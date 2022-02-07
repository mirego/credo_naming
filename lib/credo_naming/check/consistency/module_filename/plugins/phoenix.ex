defmodule CredoNaming.Check.Consistency.ModuleFilename.Plugins.Phoenix do
  @moduledoc """
  For Phoenix-specific filename consistency, the validator specifies
  two naming exceptions for the "controller" and "view" folders.

  This is needed because the folder structure is defined by something like
  "/lib/app/controllers/my_controller" while the expected controller module
  is "App.MyController". In other words, the module definition doesn't
  expect the "controller" prefix from folder structure.
  """

  @behaviour CredoNaming.Check.Consistency.ModuleFilename.Plugins

  @impl true
  def transform_paths(paths) do
    paths
    |> maybe_insert_web_resource("controller")
    |> maybe_insert_web_resource("view")
  end

  defp maybe_insert_web_resource(module_part_list, resource_type) do
    path = Enum.at(module_part_list, 0)
    file_name = Enum.at(module_part_list, -1)

    if String.ends_with?(path, "_web") and (String.ends_with?(file_name, "_#{resource_type}") or String.ends_with?(file_name, "_#{resource_type}_test")) do
      List.insert_at(module_part_list, 1, resource_type <> "s")
    else
      module_part_list
    end
  end
end
