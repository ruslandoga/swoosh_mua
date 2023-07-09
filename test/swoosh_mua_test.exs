defmodule Swoosh.MuaTest do
  use ExUnit.Case

  @tag :integration
  test "it works" do
    email =
      Swoosh.Email.new(
        from: {"Ruslan", "hey@copycat.fun"},
        to: {"Ruslan", "dogaruslan@gmail.com"},
        subject: "how are you?",
        text_body: "I'm fine",
        html_body: "I'm <i>fine</i>"
      )

    assert {:ok, _receipt} = TestMailer.deliver(email)
  end
end
