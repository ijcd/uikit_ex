defmodule UIKit.Mixfile do
  use Mix.Project

  @version "0.1.0"
  @source_url "https://github.com/ijcd/uikit_ex"
  @description "Elixir helpers for working with the UIKit css framework."

  def project do
    [
      app: :uikit,
      version: @version,
      elixir: "~> 1.5",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps(),

      # docs
      description: @description,
      name: "UIKit",
      source_url: @source_url,
      package: package(),
      dialyzer: [flags: "--fullpath"],
      docs: [
        main: "readme",
        source_ref: "v#{@version}",
        source_url: @source_url,
        extras: [
          "README.md"
        ]
      ]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:taggart, "~> 0.1.5"},
      # {:taggart, github: "ijcd/taggart"},
      # {:taggart, path: "~/work/taggart"},

      # docs
      {:ex_doc, "~> 0.16.4", only: :dev, runtime: false},
      {:earmark, "~> 1.2", only: :dev, runtime: false},
      {:mix_test_watch, "~> 0.3", only: [:dev, :test], runtime: false},
      {:credo, "~> 0.8.5", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 0.5", only: [:dev, :test], runtime: false},
      {:stream_data, "~> 0.2.0", only: [:dev, :test], runtime: false},
      {:mex, "~> 0.0.5", only: [:dev, :test], runtime: false}
    ]
  end

  defp package do
    [
      description: @description,
      files: ["lib", "config", "mix.exs", "README*"],
      maintainers: ["Ian Duggan"],
      licenses: ["Apache 2.0"],
      links: %{GitHub: @source_url}
    ]
  end
end
