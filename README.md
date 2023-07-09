Swoosh adapter for [Mua.](https://github.com/ruslandoga/mua)

```elixir
Application.put_env(:example, Mailer, adapter: Swoosh.Mua)

defmodule Mailer do
  use Swoosh.Mailer, otp_app: :example
end

email =
  Swoosh.Email.new(
    from: {"Ruslan", "hey@copycat.fun"},
    to: {"Ruslan", "dogaruslan@gmail.com"},
    subject: "how are you?",
    text_body: "I'm fine",
    html_body: "I'm <i>fine</i>"
  )

Mailer.deliver(email)
```
