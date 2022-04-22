defmodule DevTool.DatastoreControllerTest do
  @moduledoc """
    Test the `DevTool.DatastoreController` module
  """
  use DevTool.ConnCase, async: false

  alias ApplicationRunner.SessionManagers

  alias DevTool.{
    Environment,
    Repo
  }

  # setup %{conn: conn} do
  #   %{env: env, app: app, session_id: session_id, token: token} = create_app_and_get_env()
  #   {:ok, %{conn: conn, env: env, app: app, session_id: session_id, token: token}}
  # end

  # defp create_app_and_get_env do
  #   {:ok, user} = Repo.insert(User.new(%{}))

  #   {:ok, env} = Repo.insert(Environment.new(%{}))

  #   {:ok, %{inserted_application: application, application_main_env: env}} =
  #     LenraApplicationServices.create(
  #       user.id,
  #       %{name: "stubapp", color: "FFFFFF", icon: 1}
  #     )

  #   {:ok, inserted_build} = Repo.insert(Build.new(user.id, application.id, 1, %{}))

  #   deploy(inserted_build.id, env.environment_id, user.id)

  #   env_preloaded =
  #     Environment
  #     |> Repo.get(env.environment_id)
  #     |> Repo.preload(:deployed_build)

  #   faas = FaasStub.create_faas_stub()
  #   lenra_env = Application.fetch_env!(:lenra, :lenra_env)
  #   url = "/function/#{lenra_env}-#{application.service_name}-#{inserted_build.build_number}"

  #   Bypass.stub(faas, "POST", url, &handle_request(&1))

  #   session_id = Ecto.UUID.generate()

  #   {:ok, token} =
  #     SessionStateServices.create_and_assign_token(session_id, user.id, env_preloaded.id)

  #   SessionManagers.start_session(
  #     session_id,
  #     env.id,
  #     %{user: user, application: application, environment: env_preloaded, socket_pid: self()},
  #     %{application: application, environment: env_preloaded}
  #   )

  #   %{env: env_preloaded, app: application, session_id: session_id, token: token}
  # end

  # defp handle_request(conn) do
  #   Plug.Conn.resp(conn, 200, Jason.encode!(%{"manifest" => %{}}))
  # end

  # defp deploy(build_id, env_id, publisher_id) do
  #   build =
  #     build_id
  #     |> BuildServices.get()
  #     |> Repo.preload(:application)

  #   env = EnvironmentServices.get(env_id)

  #   Ecto.Multi.new()
  #   |> Ecto.Multi.update(:updated_env, Ecto.Changeset.change(env, deployed_build_id: build_id))
  #   |> Ecto.Multi.insert(
  #     :inserted_deployment,
  #     Deployment.new(build.application.id, env_id, build_id, publisher_id, %{})
  #   )
  #   |> Repo.transaction()
  # end

  # # TODO make tests when route are defined
  # describe "DevTool.DatastoreController.create_2/1" do
  #   test "should create datastore if params valid", %{
  #     conn: conn,
  #     token: token
  #   } do
  #     conn =
  #       conn
  #       |> put_req_header("accept", "application/json")
  #       |> put_req_header("authorization", "Bearer #{token}")
  #       |> post(Routes.datastore_path(conn, :create), %{
  #         "name" => "test"
  #       })

  #     assert Map.has_key?(json_response(conn, 200), "data")
  #   end

  #   test "should return error if params not valid", %{
  #     conn: conn,
  #     token: token
  #   } do
  #     conn =
  #       conn
  #       |> put_req_header("accept", "application/json")
  #       |> put_req_header("authorization", "Bearer #{token}")
  #       |> post(Routes.datastore_path(conn, :create), %{
  #         "datastore" => "test"
  #       })

  #     assert json_response(conn, 400) == %{
  #              "errors" => [%{"code" => 0, "message" => "name can't be blank"}],
  #              "success" => false
  #            }
  #   end
  # end

  # describe "DevTool.DatastoreController.delete_1/1" do
  #   test "should delete datastore if id valid", %{
  #     conn: conn,
  #     token: token
  #   } do
  #     conn
  #     |> put_req_header("accept", "application/json")
  #     |> put_req_header("authorization", "Bearer #{token}")
  #     |> post(Routes.datastore_path(conn, :create), %{
  #       "name" => "test"
  #     })

  #     conn =
  #       conn
  #       |> put_req_header("accept", "application/json")
  #       |> put_req_header("authorization", "Bearer #{token}")
  #       |> delete(Routes.datastore_path(conn, :delete, "test"))

  #     assert Map.has_key?(json_response(conn, 200), "data")
  #   end

  #   test "should return error if id invalid" do
  #   end
  # end
end
