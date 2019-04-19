# CredoFilenameConsistency

[![Travis](https://travis-ci.com/mirego/credo_filename_consistency.svg?branch=master)](https://travis-ci.com/mirego/credo_filename_consistency)
[![Hex.pm](https://img.shields.io/hexpm/v/credo_filename_consistency.svg)](https://hex.pm/packages/credo_filename_consistency)

`CredoFilenameConsistency` is a check to ensure filename consistency across an Elixir project.

## Installation

Add the `:credo_filename_consistency` package to your `mix.exs` dependencies:

```elixir
def deps do
  [
    {:credo_filename_consistency, "~> 0.1.0", only: [:dev, :test], runtime: false}
  ]
end
```

## Usage

You just need to add the check in your `.credo.exs` configuration file:

```elixir
{CredoFilenameConsistency.Check.Consistency.FilenameConsistency}
```

And now suppose you have a `lib/foo.ex` that defines a `Bar` module:

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

### Options

#### Exclusions

You can exclude files or paths with the `excluded_paths` option:

```elixir
{CredoFilenameConsistency.Check.Consistency.FilenameConsistency, excluded_paths: ["test/support", "priv", "rel", "mix.exs"]}
```

#### Acronyms

The check converts module names to paths using `PascalCase` convention, which means that the file `lib/myapp_graphql` is expected to define the module:

```elixir
defmodule MyappGraphql do
end
```

If you want to define your own acronyms, you can do so using the `acronyms` option:

```elixir
{CredoFilenameConsistency.Check.Consistency.FilenameConsistency, acronyms: [{"MyAppGraphQL", "myapp_graphql"}]}
```

Using this, the `lib/myapp_graphql` will expect to define the module:

```elixir
defmodule MyAppGraphQL do
end
```

## License

`CredoFilenameConsistency` is © 2019 [Mirego](https://www.mirego.com) and may be freely distributed under the [New BSD license](http://opensource.org/licenses/BSD-3-Clause). See the [`LICENSE.md`](https://github.com/mirego/credo_filename_consistency/blob/master/LICENSE.md) file.

## About Mirego

[Mirego](https://www.mirego.com) is a team of passionate people who believe that work is a place where you can innovate and have fun. We’re a team of [talented people](https://life.mirego.com) who imagine and build beautiful Web and mobile applications. We come together to share ideas and [change the world](http://www.mirego.org).

We also [love open-source software](https://open.mirego.com) and we try to give back to the community as much as we can.
