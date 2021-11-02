defmodule ChaosMonkeyEx.Worker do
  use GenServer

  require Logger

  defstruct allow_list: [], wait_average_msecs: 5000, wait_std_msecs: 0.3

  alias ChaosMonkeyEx.ProcessInfo

  alias Statistics.Distributions.Normal

  # ----------------------------------------------------------------------------
  # Public API
  # ----------------------------------------------------------------------------

  def start_link(options) do
    GenServer.start_link(__MODULE__, options, name: __MODULE__)
  end

  # ----------------------------------------------------------------------------
  # GenServer Callbacks
  # ----------------------------------------------------------------------------

  @impl true
  def init(options) do
    Logger.info("Be careful, ChaosMonkeyEx is enabled on this node.")
    options = struct(%__MODULE__{}, options)

    schedule_next_kill(options)

    {:ok, options}
  end

  @impl true
  def handle_info(:kill, options) do
    schedule_next_kill(options)
    kill(options)
    {:noreply, options}
  end

  # ----------------------------------------------------------------------------
  # Private Functions
  # ----------------------------------------------------------------------------

  defp schedule_next_kill(options) do
    timeout = round(Normal.rand(options.wait_average_msecs, options.wait_std_msecs))
    Process.send_after(self(), :kill, timeout)
  end

  defp kill(options) do
    case ProcessInfo.list(options) |> Enum.shuffle() do
      [] ->
        Logger.debug("No allowlisted processes to kill.")

      [target | _rest] ->
        kill(target, options)
    end
  end

  defp kill(target, _options) do
    Logger.warn("Killing #{inspect(target)}")
    Process.exit(target.pid, :kill)
  end
end
