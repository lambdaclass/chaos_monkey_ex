defmodule ChaosMonkeyEx.ProcessInfo do
  # ----------------------------------------------------------------------------
  # Process Metadata
  # ----------------------------------------------------------------------------

  def info(pid) do
    application =
      case :application.get_application(pid) do
        {:ok, application} -> application
        :undefined -> nil
      end

    info = Process.info(pid)
    registered_name = info[:registered_name]

    %{pid: pid, application: application, registered_name: registered_name}
  end

  # ----------------------------------------------------------------------------
  # Process listing
  # ----------------------------------------------------------------------------

  def list() do
    Process.list()
    |> Enum.map(&info/1)
  end

  def list(options) do
    list()
    |> Enum.filter(fn process -> allow_listed?(process, options.allow_list) end)
  end

  @doc """
  List running OTP applications.
  """
  def list_applications() do
    list()
    |> Enum.map(fn process -> process.application end)
    |> Enum.uniq()
    |> Enum.filter(fn application -> not is_nil(application) end)
  end

  # ----------------------------------------------------------------------------
  # Allow & Block List Logic
  # ----------------------------------------------------------------------------

  defp allow_listed?(process, allow_list) do
    Enum.member?(allow_list, process.application)
  end
end
