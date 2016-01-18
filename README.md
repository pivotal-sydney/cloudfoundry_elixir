# CloudfoundryElixir

If you need to deploy to cloudfoundry and your app doesn't include a webserver you can use this to setup a simple cowboy server to respond to health check pings.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add cloudfoundry_elixir to your list of dependencies in `mix.exs`:

        def deps do
          [{:cloudfoundry_elixir, git: "https://github.com/xtreme-andleung/cloudfoundry_elixir"}]
        end

  2. Ensure cloudfoundry_elixir is started before your application:

        def application do
          [applications: [:cloudfoundry_elixir]]
        end

