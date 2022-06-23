# defmodule DevTool.UserDataServices do
#   @moduledoc """
#     The service that manages application data.
#   """

#   alias ApplicationRunner.UserDataServices
#   alias DevTool.Repo

#   def has_user_data?(env_id, user_id) do
#     UserDataServices.current_user_data_query(env_id, user_id)
#     |> Repo.exists?()
#   end

#   def create_user_data(env_id, user_id) do
#     UserDataServices.create_with_data(env_id, user_id)
#     |> Repo.transaction()
#   end
# end
