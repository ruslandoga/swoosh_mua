defmodule Swoosh.Mua do
  @moduledoc """
  Swoosh adapter for [Mua.](https://github.com/ruslandoga/mua)
  """

  use Swoosh.Adapter

  @impl true
  def deliver(email, config) do
    sender = address(email.from)
    message = render(email)

    recipients(email)
    |> Enum.group_by(&__MODULE__.recipient_host/1)
    |> Map.to_list()
    |> case do
      [{host, recipients}] ->
        Mua.easy_send(host, sender, recipients, message, config)

      [_ | _] = multihost ->
        {:error, "expected all recipients to be on the same host, got: #{inspect(multihost)}"}
    end
  end

  @doc false
  def address({_, address}) when is_binary(address), do: address
  def address(address) when is_binary(address), do: address

  @doc false
  def recipient_host(address) do
    [_username, host] = String.split(address, "@")
    host
  end

  defp recipients(%Swoosh.Email{to: to, cc: cc, bcc: bcc}) do
    (List.wrap(to) ++ List.wrap(cc) ++ List.wrap(bcc))
    |> Enum.map(&__MODULE__.address/1)
    |> Enum.uniq()
  end

  defp render(email) do
    Mail.build_multipart()
    |> maybe(&Mail.put_from/2, email.from)
    |> maybe(&Mail.put_to/2, email.to)
    |> maybe(&Mail.put_cc/2, email.cc)
    |> maybe(&Mail.put_bcc/2, email.bcc)
    |> maybe(&Mail.put_reply_to/2, email.reply_to)
    |> maybe(&Mail.put_subject/2, email.subject)
    |> maybe(&Mail.put_text/2, email.text_body)
    |> maybe(&Mail.put_html/2, email.html_body)
    |> maybe(&__MODULE__.put_headers/2, email.headers)
    |> maybe(&__MODULE__.put_attachments/2, email.attachments)
    |> Mail.render()
  end

  defp maybe(mail, _fun, empty) when empty in [nil, [], %{}], do: mail
  defp maybe(mail, fun, value), do: fun.(mail, value)

  @doc false
  def put_attachments(mail, attachments) do
    Enum.reduce(attachments, mail, fn attachment, mail ->
      Mail.put_attachment(mail, {attachment.filename, Swoosh.Attachment.get_content(attachment)})
    end)
  end

  @doc false
  def put_headers(mail, headers) do
    Enum.reduce(headers, mail, fn {key, value}, mail ->
      Mail.Message.put_header(mail, key, value)
    end)
  end
end
