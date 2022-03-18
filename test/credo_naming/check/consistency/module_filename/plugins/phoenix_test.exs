defmodule CredoNaming.Check.Consistency.ModuleFilename.Plugins.PhoenixTest do
  use ExUnit.Case

  alias CredoNaming.Check.Consistency.ModuleFilename.Plugins.Phoenix

  describe "transform_paths/1" do
    test "should return path 'as-is' if no keyword or view tag" do
      path = ["credo_naming", "consistency", "module_filename"]

      assert path == Phoenix.transform_paths(path)
    end

    test "should not replace if is in web context but not a controller or view file" do
      assert ~w/credo_naming_web module_filename_live/ == Phoenix.transform_paths(~w/credo_naming_web module_filename_live/)
    end

    test "should not replace if is a controller file but not web context" do
      assert ~w/credo_naming module_filename_controller/ == Phoenix.transform_paths(~w/credo_naming module_filename_controller/)
    end

    test "should not replace if is a view file but not web context" do
      assert ~w/credo_naming module_filename_view/ == Phoenix.transform_paths(~w/credo_naming module_filename_view/)
    end

    test "should replace paths when file is a controller" do
      assert ~w/credo_naming_web controllers module_filename_controller/ == Phoenix.transform_paths(~w/credo_naming_web module_filename_controller/)
    end

    test "should replace paths when file is a view" do
      assert ~w/credo_naming_web views module_filename_view/ == Phoenix.transform_paths(~w/credo_naming_web module_filename_view/)
    end
  end
end
