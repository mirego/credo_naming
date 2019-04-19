defmodule CredoFilenameConsistency.MixProject do
  use Mix.Project

  def project do
    [
      app: :credo_filename_consistency,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: false,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:credo, "~> 1.0"}
    ]
  end
end
