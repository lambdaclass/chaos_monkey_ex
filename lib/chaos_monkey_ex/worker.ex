defmodule ChaosMonkeyEx.Worker do
  use GenServer

  require Logger

  # ----------------------------------------------------------------------------
  # Public API
  # ----------------------------------------------------------------------------

  def start_link(_) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  # ----------------------------------------------------------------------------
  # GenServer Callbacks
  # ----------------------------------------------------------------------------

  def init(state) do
    Logger.info("Be careful, ChaosMonkeyEx is enabled on this node.")

    {:ok, state}
  end

  # ----------------------------------------------------------------------------
  # Private Functions
  # ----------------------------------------------------------------------------
end
