defmodule CredoFilenameConsistency.MixProject do
  use Mix.Project

  @version "0.1.1"

  def project do
    [
      version: @version,
      app: :credo_filename_consistency,
      name: "CredoFilenameConsistency",
      description: "A check to ensure filename consistency across an Elixir project.",
      source_url: "https://github.com/mirego/credo_filename_consistency",
      homepage_url: "https://github.com/mirego/credo_filename_consistency",
      docs: [extras: ["README.md"], main: "readme", source_ref: "v#{@version}", source_url: "https://github.com/mirego/credo_filename_consistency"],
      package: package(),
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
      {:credo, "~> 1.0"},
      {:ex_doc, ">= 0.0.0", only: :dev}
    ]
  end

  defp package do
    %{
      maintainers: ["Rémi Prévost"],
      licenses: ["BSD-3"],
      links: %{
        "GitHub" => "https://github.com/mirego/credo_filename_consistency"
      }
    }
  end
end
