defmodule ChaosMonkeyEx.Worker do
  use GenServer

  require Logger

  alias Statistics.Distributions.Normal

  # ----------------------------------------------------------------------------
  # Public API
  # ----------------------------------------------------------------------------

  def start_link(_) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  # ----------------------------------------------------------------------------
  # GenServer Callbacks
  # ----------------------------------------------------------------------------

  @impl true
  def init(state) do
    Logger.info("Be careful, ChaosMonkeyEx is enabled on this node.")
    schedule_kill()

    {:ok, state}
  end

  @impl true
  def handle_info(:kill, state) do
    schedule_kill()

    Logger.info("Killing something")

    {:noreply, state}
  end

  # ----------------------------------------------------------------------------
  # Private Functions
  # ----------------------------------------------------------------------------

  defp schedule_kill do
    timeout = round(Normal.rand(5000, 0.3))
    Process.send_after(self(), :kill, timeout)
  end
end
