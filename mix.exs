defmodule CredoNaming.MixProject do
  use Mix.Project

  @version "1.0.0"

  def project do
    [
      version: @version,
      app: :credo_naming,
      name: "CredoNaming",
      description: "A suite of checks to enforce naming best practices in an Elixir project.",
      source_url: "https://github.com/mirego/credo_naming",
      homepage_url: "https://github.com/mirego/credo_naming",
      docs: [extras: ["README.md"], main: "readme", source_ref: "v#{@version}", source_url: "https://github.com/mirego/credo_naming"],
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
      {:credo, "~> 1.4"},
      {:ex_doc, ">= 0.0.0", only: :dev}
    ]
  end

  defp package do
    %{
      maintainers: ["Rémi Prévost"],
      licenses: ["BSD-3"],
      links: %{
        "GitHub" => "https://github.com/mirego/credo_naming"
      }
    }
  end
end
