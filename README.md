# CloudfoundryElixir

## Services
There are some helpers available for pulling credentials out of the VCAP_SERVICES environment variable.

```elixir
CloudfoundryElixir.Credentials.find_by_service_tag("postgres")
=> %{"uri" =>  "postgres://seilbmbd:ABcdEF@babar.elephantsql.com:5432/seilbmbd"}

CloudfoundryElixir.Credentials.find_all_by_service_tag("postgres")
=> [%{"uri" =>  "postgres://seilbmbd:ABcdEF@babar.elephantsql.com:5432/seilbmbd"}]
```

See `CloudfoundryElixir.Credentials` for more information.

## Cloud Foundry Health Check

If you need to deploy to cloudfoundry and your app doesn't include a webserver you can use this to setup a simple cowboy server to respond to health check pings.

Simply add the following worker to your supervision tree:
```elixir
worker(CloudfoundryElixir.WebServer, []),
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add cloudfoundry_elixir to your list of dependencies in `mix.exs`:

        def deps do
          [{:cloudfoundry_elixir, git: "https://github.com/pivotal-sydney/cloudfoundry_elixir"}]
        end

  2. Ensure cloudfoundry_elixir is started before your application:

        def application do
          [applications: [:cloudfoundry_elixir]]
        end


## Development

### Run The Tests

```
mix test
```
