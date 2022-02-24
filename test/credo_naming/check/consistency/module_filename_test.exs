defmodule CredoNaming.Check.Consistency.ModuleFilenameTest do
  use Credo.TestHelper

  @described_check CredoNaming.Check.Consistency.ModuleFilename

  #
  # cases NOT raising issues
  #

  test "it should NOT report violation for nested module" do
    """
    defmodule IEx.Bar do
    end
    """
    |> to_source_file("lib/iex/bar.ex")
    |> refute_issues(@described_check, acronyms: ["IEx"])
  end

  test "it should NOT report violation for nested module with acronyms" do
    """
    defmodule MYAppGraphQL.Products.Resolver do
    end
    """
    |> to_source_file("lib/myapp_graphql/products/resolver.ex")
    |> refute_issues(@described_check, acronyms: [{"MYAppGraphQL", "myapp_graphql"}])
  end

  test "it should NOT report violation for nested module and duplicated name" do
    """
    defmodule Foo.Bar do
    end
    """
    |> to_source_file("lib/foo/bar/bar.ex")
    |> refute_issues(@described_check)
  end

  test "it should NOT report violation for root module" do
    """
    defmodule BarTest do
    end
    """
    |> to_source_file("test/bar_test.exs")
    |> refute_issues(@described_check)
  end

  test "it should NOT report violation for test root module" do
    """
    defmodule BarTest do
    end
    """
    |> to_source_file("test/bar/bar_test.exs")
    |> refute_issues(@described_check)
  end

  test "it should NOT report violation for PascalCase nested module" do
    """
    defmodule FooWeb.BarWeb do
    end
    """
    |> to_source_file("lib/foo_web/bar_web.ex")
    |> refute_issues(@described_check)
  end

  test "it should NOT report violation for PascalCase nested module with dot" do
    """
    defmodule FooWeb.Bar.Create do
    end
    """
    |> to_source_file("lib/foo_web/bar.create.ex")
    |> refute_issues(@described_check)
  end

  test "it should NOT report violation for file with multiple modules" do
    """
    defmodule Foo.QueryException do
    end
    defmodule Foo.ReportException do
    end
    """
    |> to_source_file("lib/foo/exceptions.ex")
    |> refute_issues(@described_check)
  end

  test "it should NOT report violation for file with multiple modules defined in weird way" do
    """
    defmodule Foo.QueryException do
    end
    (
    defmodule Foo.ReportException do
    end
    ;
    defmodule Foo.OutputException do
    end
    )
    """
    |> to_source_file("lib/foo/exceptions.ex")
    |> refute_issues(@described_check)
  end

  test "it should NOT report violation for file with single module and implementations for it" do
    """
    defmodule Foo.Bar do
    end
    defimpl Jason.Encoder, for: Foo.Bar do
    end
    defimpl Poison.Encoder, for: Foo.Bar do
    end
    """
    |> to_source_file("lib/foo/bar.ex")
    |> refute_issues(@described_check)
  end

  test "it should NOT report violation for file with single protocol and implementations of it" do
    """
    defprotocol Foo.Bar do
    end
    defimpl Foo.Bar, for: List do
    end
    defimpl Foo.Bar, for: Map do
    end
    """
    |> to_source_file("lib/foo/bar.ex")
    |> refute_issues(@described_check)
  end

  test "it should NOT report violation for nested module in umbrella app" do
    """
    defmodule Foo.Bar do
    end
    """
    |> to_source_file("apps/abc/lib/foo/bar.ex")
    |> refute_issues(@described_check)
  end

  test "it should NOT report violation for nested module in umbrella app 2" do
    """
    defmodule Abc.Foo.Bar do
    end
    """
    |> to_source_file("apps/abc/lib/foo/bar.ex")
    |> refute_issues(@described_check)
  end

  test "it should NOT report violation for a file called stdin" do
    """
    defmodule Foo.Bar do
    end
    """
    |> to_source_file("stdin")
    |> refute_issues(@described_check)
  end

  test "it should NOT report violation for a custom filename callback" do
    """
    defmodule Foo.Bar do
    end
    """
    |> to_source_file("lib/foo/dont_care.ex")
    |> refute_issues(@described_check,
      valid_filename_callback: fn filename, _module_name, _opts ->
        if filename == "lib/foo/dont_care.ex" do
          {true, []}
        else
          {false, []}
        end
      end
    )
  end

  #
  # cases raising issues
  #

  test "it should report a violation for wrong module name" do
    """
    defmodule FooWeb.Baz do
    end
    """
    |> to_source_file("lib/foo_web/bar.ex")
    |> assert_issue(@described_check)
  end

  test "it should report a violation for missing root module" do
    """
    defmodule Bar do
    end
    """
    |> to_source_file("lib/foo/bar.ex")
    |> assert_issue(@described_check)
  end

  test "it should report a violation for extra directory" do
    """
    defmodule Foo.Bar do
    end
    """
    |> to_source_file("lib/foo/schemas/bar.ex")
    |> assert_issue(@described_check)
  end

  test "it should report a violation for missing PascalCase root module" do
    """
    defmodule Foo.Web.Bar do
    end
    """
    |> to_source_file("lib/foo_web/bar.ex")
    |> assert_issue(@described_check)
  end

  test "it should report a violation for wrong module name (with implementations for it)" do
    """
    defmodule Foo.Baz do
    end
    defimpl Jason.Encoder, for: Foo.Baz do
    end
    defimpl Poison.Encoder, for: Foo.Baz do
    end
    """
    |> to_source_file("lib/foo/bar.ex")
    |> assert_issue(@described_check)
  end

  test "it should report a violation for wrong protocol name (with implementations of it)" do
    """
    defprotocol Foo.Baz do
    end
    defimpl Foo.Baz, for: List do
    end
    defimpl Foo.Baz, for: Map do
    end
    """
    |> to_source_file("lib/foo/bar.ex")
    |> assert_issue(@described_check)
  end

  test "it should report a violation with custom filename callback" do
    """
    defmodule Foo.Bar do
    end
    """
    |> to_source_file("lib/foo/bar.ex")
    |> assert_issue(@described_check,
      valid_filename_callback: fn _filename, module_name, _opts ->
        if module_name == "Foo.Bar" do
          {false, ["lib/foo/bar_yes.ex"]}
        else
          {true, []}
        end
      end
    )
  end

  test "it should report a violation with custom filename callback using {mod, fun}" do
    defmodule Validator do
      def validate(_filename, module_name, _opts) do
        if module_name == "Foo.Bar" do
          {false, ["lib/foo/bar_yes.ex"]}
        else
          {true, []}
        end
      end
    end

    """
    defmodule Foo.Bar do
    end
    """
    |> to_source_file("lib/foo/bar.ex")
    |> assert_issue(@described_check,
      valid_filename_callback: {Validator, :validate}
    )
  end
end
