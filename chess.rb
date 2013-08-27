class Chess

  def initialize ()
    self.piece_count = [] #ordered array of total pieces for each side currently on board.  Could be used for calculating captured pieces
    self.game_board = Board.new
    self.current_player = nil
    @player1 = nil
    @player2 = nil
  end

  def set_players
    puts "How many human players? (0,1,2)"
    answer = gets.chomp
    answer =~ /[0-2]/ ? answer : set_players
    if answer == 2
      @player1 = HumanPlayer.new
      @player2 = HumanPlayer.new
      setup_players
    elsif answer == 1
      @player1 = HumanPlayer.new
      @player2 = ComputerPlayer.new
      setup_players
    else
      @player1 = ComputerPlayer.new('white')
      @player2 = ComputerPlayer.new('black')
    end

  end

  def setup_players
    @player1.color = @player1.color_choice
    @player2.color = @player1.color == "black" ? "white" : "black"
  end

  def play

    game_board.populate_board

    until win?
      turn
    end

    play_again?
  end

  def move
    current_player.request_inputs
    valid?(request_inputs)
    make_move
    win?
  end

  def turn
    move
    change_current_player
  end

  private
  def change_current_player
    @current_player = @current_player == @player1 ? @player2 : @player1
  end
