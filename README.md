<p align="center">
  <img src="https://user-images.githubusercontent.com/11348/59598372-07ca4200-90ca-11e9-8645-88642ef06a64.png" width="600" />
  <br /><br />
  <code>CredoNaming</code> is a suite of checks to enforce naming best practices in an Elixir project.
  <br /><br />
  <a href="https://travis-ci.com/mirego/credo_naming"><img src="https://travis-ci.com/mirego/credo_naming.svg?branch=master" /></a>
  <a href="https://hex.pm/packages/credo_naming"><img src="https://img.shields.io/hexpm/v/credo_naming.svg" /></a>
</p>

## Installation

Add the `:credo_naming` package to your `mix.exs` dependencies:

```elixir
def deps do
  [
    {:credo_naming, "~> 0.3", only: [:dev, :test], runtime: false}
  ]
end
```

## Usage

You just need to add the checks you want in your `.credo.exs` configuration file.

### Avoid specific terms in module names

This check will raise an issue if specific terms are found in module names.

```elixir
{CredoNaming.Check.Warning.AvoidSpecificTermsInModuleNames, terms: ["Manager", "Helper", "Helpers"]}
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

## License

`CredoNaming` is © 2019 [Mirego](https://www.mirego.com) and may be freely distributed under the [New BSD license](http://opensource.org/licenses/BSD-3-Clause). See the [`LICENSE.md`](https://github.com/mirego/credo_naming/blob/master/LICENSE.md) file.

The tag logo is based on [this lovely icon by Vectors Point](https://thenounproject.com/term/tag/2606427), from The Noun Project. Used under a [Creative Commons BY 3.0](http://creativecommons.org/licenses/by/3.0/) license.

## About Mirego

[Mirego](https://www.mirego.com) is a team of passionate people who believe that work is a place where you can innovate and have fun. We’re a team of [talented people](https://life.mirego.com) who imagine and build beautiful Web and mobile applications. We come together to share ideas and [change the world](http://www.mirego.org).

We also [love open-source software](https://open.mirego.com) and we try to give back to the community as much as we can.
