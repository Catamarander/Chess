require_relative 'board.rb'
require_relative 'error_classes.rb'
require 'colorize'
require 'io/console'


class Game

  attr_reader :grid, :cursor
  attr_accessor :current_player

  def initialize
    @cursor = [0,0]
    @grid = Board.new
    @current_player = "white"
  end

  def game_over?
    grid.check_mate?('white') || grid.check_mate?('black')
  end

  def play
    puts "Welcome to Chess!"

    until game_over?
      update_players
      piece_moving
      take_turn
    end

    take_turn
    puts "Game over: #{@current_player} wins!"
  end

  def update_players
    puts
    system("clear")
    puts "It's #{current_player.capitalize}'s turn to move"
    puts
    puts grid.render
  end

  def piece_moving
    from_pos, piece = select_piece
    place_piece(from_pos, piece)
  end

  def select_piece
    begin
      get_cursor_position('f')
      from_pos = grid.cursor.dup
      piece = grid[from_pos]
      piece.pos = from_pos
      puts
      puts "Valid moves are: #{Board.render_position(piece.valid_moves).join(" ")}"
      raise NotAPieceError.new("That's not a piece!") if piece.nil?
      raise NotYourPieceError.new("That's not your piece!") if piece.color != current_player
    rescue NotYourPieceError => e
      puts e.message
      retry
    rescue NotAPieceError => f
      puts f.message
      retry
    end
    [from_pos, piece]
  end

  def place_piece(from_pos, piece)
    begin
      puts "Move your cursor of the desired position and press t"
      get_cursor_position('t')
      to_pos = grid.cursor
      raise NotAValidMove.new("That's not a valid move") unless piece.valid_moves.include?(to_pos)
      grid.move_piece!(from_pos, to_pos)
    rescue NotAValidMove => e
      puts e.message
      puts "You tried to move this piece to #{to_pos}"
      puts "Valid moves are #{piece.valid_moves}"
      retry
    end
  end

  def get_cursor_position(key_press)
    input = nil
    until input == key_press
      input = STDIN.getch
      grid.cursor_position(input)
      system("clear")
      puts
      puts
      puts grid.render
    end
  end

  def take_turn
    turns = Hash["white", "black", "black", "white"]
    @current_player = turns[current_player]
  end


end
system("clear")
g = Game.new
g.play

#system("clear")
