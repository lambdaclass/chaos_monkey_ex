defmodule ChaosMonkeyEx.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, options) do
    children = [
      # Starts a worker by calling: ChaosMonkeyEx.Worker.start_link(arg)
      {ChaosMonkeyEx.Worker, options}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ChaosMonkeyEx.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
