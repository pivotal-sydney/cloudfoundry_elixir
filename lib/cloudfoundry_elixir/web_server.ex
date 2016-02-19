defmodule CloudfoundryElixir.WebServer do
  use Plug.Router

  plug Plug.Logger
  plug :match
  plug :dispatch

  def start_link do
    {port, _} = Integer.parse(System.get_env("PORT"))
    Plug.Adapters.Cowboy.http __MODULE__, [], [port: port]
  end

  get "/" do
    send_resp(conn, 200, "ok")
  end

  match _ do
    send_resp(conn, 404, "oops")
  end
end
