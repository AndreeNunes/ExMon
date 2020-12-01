defmodule ExMon do
  alias ExMon.Player, as: Player
  alias ExMon.Game, as: Game
  alias ExMon.Game.{Actions, Status}

  @computer_name "robotink"
  @computer_moves [:move_avg, :move_rnd,]

  def create_player(name, move_avg, move_rnd, move_heal) do
    Player.build(name, move_avg, move_rnd, move_heal)
  end

  def start_game(player) do
    @computer_name
    |> create_player(:punch, :kick, :heal)
    |> Game.start(player)

    Enum.random(1..2)
    |> random_start_player()


    Status.print_round_message(Game.info())
  end

  defp random_start_player(number) when number == 1 do
    IO.puts("------------------ Computador iniciou jogando :p ------------------")

    Game.info()
    |> Game.update()

    computer_move(Game.info())
  end

  defp random_start_player(number) when number == 2, do: IO.puts "\n ------------------ O PRIMEIRO MOVIMENTO EH SEU U.U ^^ ------------------ \n"

  def make_move(move) do
    Game.info()
    |> Map.get(:status)
    |> handle_status(move)
  end

  defp handle_status(:game_over, _move), do: Status.print_round_message(Game.info())

  defp handle_status(_other, move) do
    move
    |> Actions.fetch_move
    |> do_move(:player)

    computer_move(Game.info())
  end

  defp do_move({:error, move}, :player), do: Status.print_wrong_move_message(move)

  defp do_move({:ok, move}, :player) do

    case move do
      :move_heal -> Actions.heal()
      move -> Actions.attack(move)
    end

    Status.print_round_message(Game.info())
  end

  defp do_move({:ok, move}, :computer) do
    case move do
      :move_heal -> Actions.heal()
      move -> Actions.attack(move)
    end

    Status.print_round_message(Game.info())
  end

  defp computer_move(%{turn: :computer, status: :continue}) do
    move = {:ok, Enum.random(@computer_moves)}
    do_move(move, :computer)
  end

  defp computer_move(_), do: :ok
end
