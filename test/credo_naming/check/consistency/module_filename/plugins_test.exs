defmodule CredoNaming.Check.Consistency.ModuleFilename.PluginsTest do
  use ExUnit.Case

  alias CredoNaming.Check.Consistency.ModuleFilename.Plugins

  describe "module_for_name/1" do
    test "should return plugin for :phoenix" do
      assert Plugins.Phoenix == Plugins.module_for_name(:phoenix)
    end

    test "should return plugin for plugin in list" do
      assert Plugins.Phoenix == Plugins.module_for_name(Plugins.Phoenix)
    end

    test "should return one arity function for function" do
      fun = Plugins.module_for_name(fn paths -> paths end)
      assert 1 == :erlang.fun_info(fun)[:arity]
    end

    test "should raise when plugin doesn't exist" do
      assert_raise RuntimeError, "Plugin not supported", fn ->
        Plugins.module_for_name("an_ancient_bird")
      end
    end
  end
end
