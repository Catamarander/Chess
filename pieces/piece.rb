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

  # def moves(type_of_piece)
  #   raise "SHAWNA WAS WRONG"
  #   dirs = type_of_piece.move_dirs
  # end

  def valid_moves
    # all_possible_moves = all_moves(piece)
    true_valid_moves = []
    current_position = self.pos
    moves.each do |possible_move|
      possible_board = self.chess_board.dup_board
      possible_board.move(current_position, possible_move)
      true_valid_moves << possible_move unless possible_board.in_check?(self.color)
    end

    true_valid_moves
  end
end
