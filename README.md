# Swoosh.Mua

[![Hex Package](https://img.shields.io/hexpm/v/swoosh_mua.svg)](https://hex.pm/packages/swoosh_mua)
[![Hex Docs](https://img.shields.io/badge/hex-docs-blue.svg)](https://hexdocs.pm/swoosh_mua)

[Swoosh](https://github.com/swoosh/swoosh) adapter for [Mua.](https://github.com/ruslandoga/mua)

## Installation

```elixir
defp deps do
  [
    {:swoosh_mua, "~> 0.1.0"}
  ]
end
```

## Usage

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
