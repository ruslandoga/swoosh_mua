defmodule Swoosh.Mua.MixProject do
  use Mix.Project

  @version "0.1.0"
  @repo_url "https://github.com/ruslandoga/swoosh_mua"

  def project do
    [
      app: :swoosh_mua,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      # hex
      package: package(),
      description: "Swoosh adapter for Mua, a minimal SMTP client",
      # docs
      name: "Swoosh.Mua",
      docs: [
        source_url: @repo_url,
        source_ref: "v#{@version}",
        main: "readme",
        extras: ["README.md"]
        # extras: ["README.md", "CHANGELOG.md"],
        # skip_undefined_reference_warnings_on: ["CHANGELOG.md"]
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp package do
    [
      licenses: ["MIT"],
      links: %{"GitHub" => @repo_url}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:swoosh, "~> 1.11"},
      {:mail, "~> 0.3.0"},
      {:mua, "~> 0.1.0"},
      {:dialyxir, "~> 1.3", only: [:dev, :test], runtime: false},
      {:castore, "~> 0.1.0 or ~> 1.0", only: [:dev, :test]},
      {:ex_doc, "~> 0.29", only: :dev},
      # swoosh wants hackney
      {:hackney, "~> 1.9", only: [:dev, :test]}
    ]
  end
end
