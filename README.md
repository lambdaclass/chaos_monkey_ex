# ChaosMonkeyEx

Test the robustnes of your elixir applications by randomly killing processes!

## Usage

```elixir
ChaosMonkeyEx.Application.start(nil, allow_list: [:my_application_1, :my_application_2])
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `chaos_monkey_ex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:chaos_monkey_ex, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/chaos_monkey_ex](https://hexdocs.pm/chaos_monkey_ex).

