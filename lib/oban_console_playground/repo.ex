defmodule ObanConsolePlayground.Repo do
  use Ecto.Repo,
    otp_app: :oban_console_playground,
    adapter: Ecto.Adapters.Postgres
end
