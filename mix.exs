defmodule MimetypeParser.Mixfile do
  use Mix.Project

  def project do
    [app: :mimetype_parser,
     version: "0.1.3",
     elixir: "~> 1.0",
     description: "parse mimetypes",
     package: package(),
     deps: deps()]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    [{:ex_doc, ">= 0.0.0", only: :dev}]
  end

  defp package do
    [files: ["src/mimetype_parser.erl", "src/*.xrl", "src/*.yrl", "lib/*", "mix.exs", "README*"],
     maintainers: ["Cameron Bytheway"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/camshaft/mimetype_parser"}]
  end
end
