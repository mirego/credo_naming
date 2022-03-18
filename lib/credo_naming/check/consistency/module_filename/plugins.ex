defmodule CredoNaming.Check.Consistency.ModuleFilename.Plugins do
  alias CredoNaming.Check.Consistency.ModuleFilename.Plugins.Phoenix

  @callback transform_paths(paths :: list(list(atom()))) :: list(list(atom()))

  def module_for_name(:phoenix), do: Phoenix
  def module_for_name(_), do: raise("Plugin not supported")
end
