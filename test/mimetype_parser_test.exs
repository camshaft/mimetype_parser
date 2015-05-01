defmodule MimetypeParserTest do
  use ExUnit.Case

  cases = [
    {"json", [{"application", "json", %{}}]},
    {"hyper+json", [{"application", "hyper+json", %{}}]},
    {"html", [{"text", "html", %{}}]},
    {"html, json", [{"text", "html", %{}},
                    {"application", "json", %{}}]},
    {"application/xml", [{"application", "xml", %{}}]},
    {"text/xml", [{"text", "xml", %{}}]},
    {"rdf; param=123", [{"application", "rdf+xml", %{"param" => "123"}}]},
    {"application/hyper+json; profile=users; version=1.0", [{"application", "hyper+json", %{"profile" => "users", "version" => "1.0"}}]}
  ]

  for {input, output} <- cases do
    test "#{inspect(input)} -> #{inspect(output)}" do
      assert {:ok, unquote(Macro.escape(output))} == :mimetype_parser.parse(unquote(Macro.escape(input)))
    end
  end
end
