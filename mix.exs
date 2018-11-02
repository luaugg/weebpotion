defmodule WeebPotion.MixProject do
  use Mix.Project

  def project do
    [
      app: :weebpotion,
      version: "0.2.1",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :beta,
      deps: deps(),
      description: description(),
      name: "weebpotion",
      source_url: "https://github.com/SamOphis/weebpotion",
      package: package()
    ]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp deps do
    [
      {:poison, "~> 3.1"},
      {:httpoison, "~> 1.4"},
      {:earmark, "~> 1.2", only: :dev},
      {:ex_doc, "~> 0.19", only: :dev}
    ]
  end

  defp description do
    "Incomplete Elixir wrapper for the Weeb.sh API. Supports most of toph."
  end

  defp package do
    [
      licenses: ["Apache 2.0"],
      links: %{"GitHub" => "https://github.com/SamOphis/weebpotion"}
    ]
  end
end
