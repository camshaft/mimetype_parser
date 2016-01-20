defmodule MimetypeParser.Mixfile do
  use Mix.Project

  def project do
    [app: :mimetype_parser,
     version: "0.1.1",
     elixir: "~> 1.0",
     description: "parse mimetypes",
     package: package,
     deps: deps]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    []
  end

  defp package do
    [files: ["src/mimetype_parser.erl", "src/*.xrl", "src/*.yrl", "lib/*", "mix.exs", "README*"],
     contributors: ["Cameron Bytheway"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/camshaft/mimetype_parser"}]
  end
end
