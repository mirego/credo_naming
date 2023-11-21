defmodule CredoNaming.Check.Consistency.ModuleFilename.Plugins do
  @plugins [
    CredoNaming.Check.Consistency.ModuleFilename.Plugins.Phoenix
  ]

  @callback transform_paths(paths :: list(list(atom()))) :: list(list(atom()))

  def module_for_name(:phoenix) do
    IO.warn("Using `:phoenix` as a plugin is deprecated; use `CredoNaming.Check.Consistency.ModuleFilename.Plugins.Phoenix` instead.", Macro.Env.stacktrace(__ENV__))
    CredoNaming.Check.Consistency.ModuleFilename.Plugins.Phoenix
  end

  def module_for_name(plugin) when plugin in @plugins, do: plugin
  def module_for_name(fun) when is_function(fun), do: fun
  def module_for_name(_), do: raise("Plugin not supported")
end
