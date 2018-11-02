defmodule Weebpotion.MixProject do
  use Mix.Project

  def project do
    [
      app: :weebpotion,
      version: "0.2.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :beta,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [extra_applications: [:logger]]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:poison, "~> 3.1"},
      {:httpoison, "~> 1.4"},
      {:earmark, "~> 1.2", only: :dev},
      {:ex_doc, "~> 0.19", only: :dev}
    ]
  end
end
