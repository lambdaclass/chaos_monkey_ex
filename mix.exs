defmodule ChaosMonkeyEx.MixProject do
  use Mix.Project

  def project do
    [
      app: :chaos_monkey_ex,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {ChaosMonkeyEx.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:statistics, "~> 0.6.2"}
    ]
  end
end
