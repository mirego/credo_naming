<p align="center">
  <img src="https://user-images.githubusercontent.com/11348/59598372-07ca4200-90ca-11e9-8645-88642ef06a64.png" width="600" />
  <br /><br />
  <code>CredoNaming</code> is a suite of checks to enforce naming best practices in an Elixir project.
  <br /><br />
  <a href="https://github.com/mirego/credo_naming/actions?query=workflow%3ACI+branch%3Amaster+event%3Apush"><img src="https://github.com/mirego/credo_naming/workflows/CI/badge.svg?branch=master&event=push" /></a>
  <a href="https://hex.pm/packages/credo_naming"><img src="https://img.shields.io/hexpm/v/credo_naming.svg" /></a>
</p>

## Installation

Add the `:credo_naming` package to your `mix.exs` dependencies:

```elixir
def deps do
  [
    {:credo_naming, "~> 2.0", only: [:dev, :test], runtime: false}
  ]
end
```

## Usage

You just need to add the checks you want in your `.credo.exs` configuration file.

### Avoid specific terms in module names

This check will raise an issue if specific terms are found in module names.

```elixir
{CredoNaming.Check.Warning.AvoidSpecificTermsInModuleNames, terms: ["Manager", ~r/Helpers?/]}
```

Suppose you have a `MyApp.ErrorHelpers` module:

```
$ mix credo

┃  Warnings - please take a look
┃
┃ [W] ↘ `Helpers` is included in the list of terms to avoid in module names.
┃       Consider replacing it with a more accurate one.
┃       lib/my_app/error_helpers.ex:1:39 #(MyApp.ErrorHelpers)
```

With this check configuration for example, a module named `MyApp.UserManager` or `MyApp.FormHelpers` would not be allowed.

### Ensure module/filename consistency

This check will raise an issue if the name of a module defined in a file does not match its filename.

```elixir
{CredoNaming.Check.Consistency.ModuleFilename}
```

Suppose you have a `lib/foo.ex` file that defines a `Bar` module:

```
$ mix credo

┃ Consistency
┃
┃ [C] ↘ The module defined in `lib/foo.ex` is not named consistently with the
┃       filename. The file should be named either:
┃
┃       ["lib/bar/bar.ex", "lib/bar.ex"]
┃
┃       lib/foo.ex:1:11 #(Bar)
```

#### Exclusions

You can exclude files or paths with the `excluded_paths` option:

```elixir
{CredoNaming.Check.Consistency.ModuleFilename, excluded_paths: ["test/support", "priv", "rel", "mix.exs"]}
```

You can also exclude files or paths with regex:

```elixir
{CredoNaming.Check.Consistency.ModuleFilename, excluded_paths: [~r/test\/support/, ~r/priv/, ~r/.exs/]}
```

#### Acronyms

The check converts module names to paths using `PascalCase` convention, which means that the file `lib/myapp_graphql.ex` is expected to define the module:

```elixir
defmodule MyappGraphql do
end
```

If you want to define your own acronyms, you can do so using the `acronyms` option:

```elixir
{CredoNaming.Check.Consistency.ModuleFilename, acronyms: [{"MyAppGraphQL", "myapp_graphql"}]}
```

Using this, the `lib/myapp_graphql.ex` file will expect to define the module:

```elixir
defmodule MyAppGraphQL do
end
```

#### Naming conventions

By default, the check allows for a specific list of valid filenames when a single module is declared within a file. You can overwrite this behaviour by providing the `valid_filename_callback` option and implement yourself if a filename should be considered valid.

The callback receives three arguments:

- `filename`, the stringified name of the module contained in the file (eg. `"lib/my_app/foo/bar.ex"`)
- `module_name`, the stringified name of the module contained in the file (eg. `"MyApp.Foo.Bar"`)
- `opts`, the options list passed to the check (eg. `[acronyms: [{"GraphQL", "graphql"}]]`)

And must return a tuple containing a boolean value (if the filename is considered valid) and a list of expected filenames.

In this (very simple) example, a file `lib/my_app/wrong.ex` that defines a `MyApp.Foo.Bar` module would return a `{false, ["lib/my_app/foo/bar.ex"]}` tuple.

```elixir
def valid_filename?(filename, module_name, _opts) do
  root_path = CredoNaming.Check.Consistency.ModuleFilename.root_path(filename)
  path = "#{Macro.underscore(module_name)}#{Path.extname(filename)}"

  filenames = [
    Path.join([root_path, path])
  ]

  {filename in filenames, filenames}
end

{CredoNaming.Check.Consistency.ModuleFilename, valid_filename_callback: &valid_filename/3}
```

You could also use the callback to ignore specific files and fallback on the default callback for others.

```elixir
def valid_filename?("lib/my_app/my_specific_file.ex", _module_name, _opts), do: {true, []}
def valid_filename?("lib/my_app/my_other_specific_file.ex", _module_name, _opts), do: {true, []}
def valid_filename?(filename, module_name, opts), do: CredoNaming.Check.Consistency.ModuleFilename.valid_filename?(filename, module_name, opts)

{CredoNaming.Check.Consistency.ModuleFilename, valid_filename_callback: &valid_filename/3}
```

Instead of implementing your own `valid_filename_callback` function, you can use the `plugins` option to enforce a specific supported naming convention. For now, only `:phoenix` is supported.

## Contributors

- Rémi Prévost ([@remiprev](https://github.com/remiprev))
- Tomáš Janoušek ([@liskin](https://github.com/liskin))
- Felipe Duzzi ([@duzzifelipe](https://github.com/duzzifelipe))

## License

`CredoNaming` is © 2019 [Mirego](https://www.mirego.com) and may be freely distributed under the [New BSD license](http://opensource.org/licenses/BSD-3-Clause). See the [`LICENSE.md`](https://github.com/mirego/credo_naming/blob/master/LICENSE.md) file.

The tag logo is based on [this lovely icon by Vectors Point](https://thenounproject.com/term/tag/2606427), from The Noun Project. Used under a [Creative Commons BY 3.0](http://creativecommons.org/licenses/by/3.0/) license.

## About Mirego

[Mirego](https://www.mirego.com) is a team of passionate people who believe that work is a place where you can innovate and have fun. We’re a team of [talented people](https://life.mirego.com) who imagine and build beautiful Web and mobile applications. We come together to share ideas and [change the world](http://www.mirego.org).

We also [love open-source software](https://open.mirego.com) and we try to give back to the community as much as we can.
