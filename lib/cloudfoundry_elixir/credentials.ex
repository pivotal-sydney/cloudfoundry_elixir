defmodule CloudfoundryElixir.Credentials do
  @vcap_services Poison.decode!(System.get_env("VCAP_SERVICES") || "{}")

  @doc """
    Find the credentials for the all services that have the given tag. Returns
    nil if no service is found with the given tag.
  """
  @spec find_all_by_service_tag(tag :: String.t) :: map | nil
  def find_all_by_service_tag(tag) when is_binary(tag) do
    find_all_by_service_tag(@vcap_services, tag)
  end

  @doc """
    Find the credentials for the first service that has the given tag. Returns
    nil if no service is found with the given tag.
  """
  @spec find_by_service_tag(tag :: String.t) :: map | nil
  def find_by_service_tag(tag) when is_binary(tag) do
    find_by_service_tag(@vcap_services, tag)
  end

  @spec find_all_by_service_tag(services_data :: map, tag :: String.t) :: map | nil
  def find_all_by_service_tag(services_data, tag) when is_map(services_data) and is_binary(tag) do
    services_data |> Enum.flat_map(fn ({_name, data}) -> find_by_tag_in_service(data, tag) end)
  end

  @spec find_by_service_tag(services_data :: map, tag :: String.t) :: map | nil
  def find_by_service_tag(services_data, tag) when is_map(services_data) and is_binary(tag) do
    find_all_by_service_tag(services_data, tag) |> Enum.take(1) |> List.first
  end

  defp find_by_tag_in_service(service, tag) do
    Stream.filter_map(service, fn(s) -> tag in s["tags"] end, fn(s) -> s["credentials"] end)
  end
end
