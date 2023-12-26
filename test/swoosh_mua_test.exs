defmodule Swoosh.MuaTest do
  use ExUnit.Case, async: true

  test "multihost error" do
    email =
      Swoosh.Email.new(
        from: {"Mua", "mua@github.com"},
        to: {"to", "to@github.com"},
        cc: [{"cc1", "cc1@gmail.com"}]
      )

    assert {:error, %Swoosh.Mua.MultihostError{} = error} =
             TestMailer.deliver(email)

    assert Exception.message(error) ==
             "expected all recipients to be on the same host, got: github.com, gmail.com"
  end
end
