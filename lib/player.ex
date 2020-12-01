defmodule ExMon.Player do
  require_keys = [:life, :name, :moves]
  @enforce_keys require_keys
  defstruct require_keys

  @max_life 100

  def build(name, move_rnd, move_avg, move_heal) do
    %ExMon.Player{
      name: name,
      moves: %{
        move_avg: move_avg,
        move_rnd: move_rnd,
        move_heal: move_heal,
      },
      life: @max_life
    }
  end
end
