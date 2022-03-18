# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [2.0.0] - 2022-03-18

- BREAKING: Filenames with dots (`.`) in them no longer considers dots as separators. For example, a `FooWeb.Bar.Create` module should be defined in `lib/foo_web/bar/create.ex` or `lib/foo_web/bar/create/create.ex`. `lib/foo_web/bar.create.ex` is no longer valid for this module.
- `CredoNaming.Check.Consistency.ModuleFilename` now supports a `plugins` list to enforce a specific file naming convention [#17](https://github.com/mirego/credo_naming/pull/17)

## [1.0.0] - 2020-10-06

- Nothing new — just committing to a major version for semver benefits

## [0.6.1] - 2020-05-08

- Add missing changelog entries

## [0.6.0] - 2020-05-07

- Add Credo 1.4-specific features [#12](https://github.com/mirego/credo_naming/pull/12)

## [0.5.0] - 2020-03-12

- Add support for a “valid_filename_callback” option `ModuleFilename` check [#8](https://github.com/mirego/credo_naming/pull/8)

## [0.4.1] - 2019-10-24

- Exclude `stdin` source files for `ModuleFilename` (because we cannot check consistency between module and filename when we have no filename)

## [0.4.0] - 2019-07-31

- Add regex term support in `AvoidSpecificTermsInModuleNames` check

## [0.3.1] - 2019-06-19

- Improve documentation

## [0.3.0] - 2019-06-18

- Add `AvoidSpecificTermsInModuleNames` check

## [0.2.1] - 2019-05-03

### Added

- Add checking of [protocol](https://elixir-lang.org/getting-started/protocols.html) module filenames by [@liskin](https://github.com/liskin). [#2](https://github.com/mirego/credo_filename_consistency/pull/2)

## [0.2.0] - 2019-04-26

### Added

- Add support for [umbrella projects](https://elixir-lang.org/getting-started/mix-otp/dependencies-and-umbrella-projects.html#umbrella-projects) by [@liskin](https://github.com/liskin). [#1](https://github.com/mirego/credo_filename_consistency/pull/1)
