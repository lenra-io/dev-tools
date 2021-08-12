defmodule DevTool.ApplicationRunnerAdapterTest do
  @moduledoc """
    Test the Errors for the app runner adapter
  """
  use ExUnit.Case

  alias ApplicationRunner.Action
  alias DevTool.ApplicationRunnerAdapter

  setup do
    bypass = Bypass.open(port: 6789)
    {:ok, bypass: bypass}
  end

  @fake_app_response %{"data" => %{}, "ui" => %{}}
  @fake_app_request %{data: %{}, event: %{}, props: %{}}

  test "run_action", %{bypass: bypass} do
    Bypass.expect_once(bypass, "POST", "/", fn conn ->
      Plug.Conn.resp(conn, 200, Jason.encode!(@fake_app_response))
    end)

    assert {:ok, @fake_app_response} ==
             ApplicationRunnerAdapter.run_action(%Action{
               user_id: 1,
               app_name: "test",
               build_number: 1,
               action_key: "InitData",
               old_data: @fake_app_request.data,
               event: @fake_app_request.event,
               props: @fake_app_request.props
             })
  end

  test "run_action app not started", %{bypass: bypass} do
    Bypass.down(bypass)

    assert_raise RuntimeError,
                 "Application could not be reached. Make sure that the application is started.",
                 fn ->
                   ApplicationRunnerAdapter.run_action(%Action{
                     user_id: 1,
                     app_name: "test",
                     build_number: 1,
                     action_key: "InitData",
                     old_data: @fake_app_request.data,
                     event: @fake_app_request.event,
                     props: @fake_app_request.props
                   })
                 end

    Bypass.up(bypass)
  end

  test "run_action app error", %{bypass: bypass} do
    Bypass.expect_once(bypass, "POST", "/", fn conn ->
      Plug.Conn.resp(conn, 500, "")
    end)

    assert_raise RuntimeError, "Application error (500) ", fn ->
      ApplicationRunnerAdapter.run_action(%Action{
        user_id: 1,
        app_name: "test",
        build_number: 1,
        action_key: "InitData",
        old_data: @fake_app_request.data,
        event: @fake_app_request.event,
        props: @fake_app_request.props
      })
    end
  end

  test "get_data and save_data", %{bypass: _} do
    assert {:ok, %Action{user_id: 1, app_name: "test"}} =
             ApplicationRunnerAdapter.get_data(%Action{user_id: 1, app_name: "test"})

    ApplicationRunnerAdapter.save_data({1, "test"}, "test")

    assert {:ok, %Action{user_id: 1, app_name: "test", old_data: "test"}} =
             ApplicationRunnerAdapter.get_data(%Action{user_id: 1, app_name: "test"})
  end
end
