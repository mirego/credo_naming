defmodule CredoNaming.Check.Warning.AvoidSpecificTermsInModuleNames do
  use Credo.Check,
    base_priority: :low,
    tags: [:naming],
    explanations: [
      check: """
      In an effort to encourage more accurate module naming practices, it is
      sometimes useful to maintain a list of terms to avoid in module names.

      For example, if the list of terms to avoid is ["Manager", "Fetcher"]:

          # preferred

          defmodule Accounts do
          end

          defmodule App.Networking do
          end

          # NOT preferred

          defmodule AccountManager do
          end

          defmodule App.DataFetcher do
          end
      """,
      params: [
        terms: "A list of terms to avoid"
      ]
    ],
    param_defaults: [terms: []]

  alias Credo.Code
  alias Credo.Code.Name

  @doc false
  def run(source_file, params \\ []) do
    terms = Params.get(params, :terms, __MODULE__)

    issue_meta = IssueMeta.for(source_file, params)

    Code.prewalk(source_file, &traverse(&1, &2, terms, issue_meta))
  end

  def traverse({:defmodule, _, [{:__aliases__, opts, mod} | _]} = ast, issues, terms, issue_meta) do
    issues =
      mod
      |> Enum.flat_map(&Name.split_pascal_case(Atom.to_string(&1)))
      |> Enum.reduce(issues, fn term, acc ->
        if term_to_avoid?(term, terms) do
          acc ++ [issue_for(issue_meta, Keyword.get(opts, :line), term)]
        else
          acc
        end
      end)

    {ast, issues}
  end

  def traverse(ast, issues, _, _), do: {ast, issues}

  defp term_to_avoid?(term, terms) do
    Enum.any?(terms, fn
      term_to_avoid when is_binary(term_to_avoid) -> String.downcase(term_to_avoid) == String.downcase(term)
      %Regex{} = term_to_avoid -> Regex.match?(term_to_avoid, term)
      term -> raise(~s(The "terms" config expected each term to be a String or Regex, got: #{inspect(term)}))
    end)
  end

  defp issue_for(issue_meta, line_no, trigger) do
    format_issue(
      issue_meta,
      message: "`#{trigger}` is included in the list of terms to avoid in module names. Consider replacing it with a more accurate one.",
      trigger: trigger,
      line_no: line_no
    )
  end
end
