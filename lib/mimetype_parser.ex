defmodule MimetypeParser do
  defmodule Exception do
    defexception [:message]
  end
  def parse(string), do: :mimetype_parser.parse(string)
  def parse(string, opts), do: :mimetype_parser.parse(string, opts)

  def parse!(string), do: parse!(string, 1)
  def parse!(string, opts) do
    case parse(string, opts) do
      {:ok, types} ->
        types
      {:error, {_, :mimetype_parser_lexer, error}, _} ->
        raise Exception, message: to_string(:mimetype_parser_lexer.format_error(error))
      {:error, {_, :mimetype_parser_parser, parser_error}} ->
        raise Exception, message: to_string(parser_error)
    end
  end
end
