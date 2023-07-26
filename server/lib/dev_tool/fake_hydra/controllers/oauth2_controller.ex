defmodule DevTool.FakeHydra.OAuth2Controller do
  use DevTool, :controller

  alias DevTool.FakeHydra.OAuth2Helper
  require Logger

  def auth(conn, params) do
    IO.inspect({conn, params})

    uri = params["redirect_uri"]
    code = OAuth2Helper.generate_code(%{scope: params["scope"]})
    encoded_params = URI.encode_query(%{"code" => code})
    redirect(conn, external: "#{uri}?#{encoded_params}")
  end

  # defp encode_token(scope, )

  def token(conn, %{"code" => code}) do
    with {:ok, token} <- OAuth2Helper.generate_token(code) do
      response = %{
        access_token: token,
        expire_in: 3600,
        scope: "foo bar",
        token_type: "bearer"
      }

      json(conn, response)
    end
  end

  def revoke(conn, params) do
    IO.inspect({conn, params})
    resp(conn, 200, "ok")
  end
end
