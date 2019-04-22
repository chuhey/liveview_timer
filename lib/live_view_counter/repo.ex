defmodule LiveViewCounter.Repo do
  use Ecto.Repo,
    otp_app: :live_view_counter,
    adapter: Ecto.Adapters.Postgres
end
