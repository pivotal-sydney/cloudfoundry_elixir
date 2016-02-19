defmodule CloudfoundryElixir.CredentialsTest do
  use ExUnit.Case
  alias CloudfoundryElixir.Credentials, as: C

  @vcap_services_json """
  {
    "elephantsql": [
      {
        "name": "elephantsql-c6c60",
        "label": "elephantsql",
        "tags": [
          "postgres",
          "postgresql",
          "relational"
        ],
        "plan": "turtle",
        "credentials": {
          "uri": "postgres://seilbmbd:ABcdEF@babar.elephantsql.com:5432/seilbmbd"
        }
      }
    ],
    "sendgrid": [
      {
        "name": "mysendgrid",
        "label": "sendgrid",
        "tags": [
          "smtp"
        ],
        "plan": "free",
        "credentials": {
          "hostname": "smtp.sendgrid.net",
          "username": "QvsXMbJ3rK",
          "password": "HCHMOYluTv"
        }
      }
    ]
  }
  """

  @vcap_services Poison.decode!(@vcap_services_json)

  test "#find_by_service_tag" do
    assert C.find_by_service_tag(@vcap_services, "postgres") == %{"uri" => "postgres://seilbmbd:ABcdEF@babar.elephantsql.com:5432/seilbmbd"}
    assert C.find_by_service_tag(@vcap_services, "relational") == %{"uri" => "postgres://seilbmbd:ABcdEF@babar.elephantsql.com:5432/seilbmbd"}
    assert C.find_by_service_tag(@vcap_services, "smtp") == %{"hostname" => "smtp.sendgrid.net", "username" => "QvsXMbJ3rK", "password" => "HCHMOYluTv"}

    assert C.find_by_service_tag(@vcap_services, "notatag") == nil
    assert C.find_by_service_tag(%{}, "postgres") == nil
  end

  test "#find_all_by_service_tag" do
    assert C.find_all_by_service_tag(@vcap_services, "postgres") == [%{"uri" => "postgres://seilbmbd:ABcdEF@babar.elephantsql.com:5432/seilbmbd"}]
    assert C.find_all_by_service_tag(@vcap_services, "relational") == [%{"uri" => "postgres://seilbmbd:ABcdEF@babar.elephantsql.com:5432/seilbmbd"}]
    assert C.find_all_by_service_tag(@vcap_services, "smtp") == [%{"hostname" => "smtp.sendgrid.net", "username" => "QvsXMbJ3rK", "password" => "HCHMOYluTv"}]

    assert C.find_all_by_service_tag(@vcap_services, "notatag") == []
  end
end
