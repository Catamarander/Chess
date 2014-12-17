class Piece
  attr_reader :color, :chess_board
  attr_accessor :pos

  DIAGONAL_MOVES = [[1, 1], [-1, 1], [1, -1], [-1, -1]]
  CARDINAL_MOVES = [[-1, 0], [1, 0], [0, -1], [0, 1]]

  def diagonal
    DIAGONAL_MOVES
  end

  def cardinal
    CARDINAL_MOVES
  end

  def initialize(chess_board, pos, color)
    @chess_board = chess_board #board is an instance of the Board class
    @pos = pos # Initialized position to hard coded value like the beginning of chess
    @color = color

    chess_board.add_piece(pos, self)
  end

  def moves(type_of_piece)
    raise "SHAWNA WAS WRONG"
    dirs = type_of_piece.move_dirs
  end
end
