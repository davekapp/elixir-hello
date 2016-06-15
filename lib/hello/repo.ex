defmodule Hello.Repo do
  use Ecto.Repo, otp_app: :hello

  # @moduledoc """
  #   In memory repository for maximum testery.
  # """

  # def all(Hello.User) do
  #   [%Hello.User{id: "1", name: "Bob Dole", username: "bobdole", password: "playstation"},
  #    %Hello.User{id: "2", name: "Larry Bird", username: "lbird", password: "mjordanman"},
  #    %Hello.User{id: "3", name: "LinkedIn", username: "linkedin", password: "pronetwork"}]
  # end

  # def all(_module), do: []

  # def get(module, id) do
  #   Enum.find all(module), fn map -> map.id == id end
  # end

  # def get_by(module, params) do
  #   Enum.find all(module), fn map ->
  #     Enum.all?(params, fn {key, val} -> Map.get(map, key) == val end)
  #   end
  # end
end


