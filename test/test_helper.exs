Application.put_env(:swoosh_mua_test, TestMailer, adapter: Swoosh.Mua)

defmodule TestMailer do
  use Swoosh.Mailer, otp_app: :swoosh_mua_test
end

ExUnit.start()
