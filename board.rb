require_relative 'pieces/pieces.rb'

class Board
  attr_accessor :chess_board

  def self.on_board?(pos)
    pos.all? { |coord| (0..7).cover? coord }
  end

  def valid_moves(piece)
    all_possible_moves = piece.moves(piece.pos)
  end

  def piece_at_position?(position)
    !self[position].nil?
  end

  def initialize
    set_up_game
  end

  def move_piece!(from_pos, to_pos)
      piece = self[from_pos]
      self[to_pos] = piece
      self[from_pos] = nil
      piece.pos = to_pos
  end

  def [](pos)
    row, col = pos
    chess_board[row][col]
  end

  def []=(pos, piece)
    row, col = pos
    chess_board[row][col] = piece
  end

  def add_piece(pos, piece)
    self[pos] = piece
  end

  def render
    chess_board.each { |row| p row }
  end

  def in_check?(color)
    opponents = get_all_not_color(color)
    king = king_position(color)
    opponents.any? do |opp|
      moves = valid_moves(opp)
      moves.include? king
    end
  end

  def king_position(color)
    get_all_color(color).select{ |el| el.is_a? King }[0].pos
  end

  def get_all_color(color)
    flat_board = chess_board.flatten
    flat_board.delete(nil)
    flat_board.select! {|el| el.color == color }
  end

  def get_all_not_color(color)
    flat_board = chess_board.flatten
    flat_board.delete(nil)
    flat_board.select! { |el| el.color != color }
  end

  def set_up_game
    @chess_board = Array.new(8) { Array.new(8) { nil } }
    ["white", "black"].each do |color|
      place_pawns(color)
      place_pieces(color)
    end
  end

  def place_pawns(color)
    if color == "white"
      row = 1
    elsif color == "black"
      row = 6
    end
    8.times { |col| Pawn.new(self, [row, col], color)}

  end

  def place_pieces(color)
    pieces = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]

    if color == "white"
      row = 0
    elsif color == "black"
      row = 7
    end
    pieces.each_with_index do |piece, col|
      piece.new(self, [row, col], color)
    end
  end


end
b = Board.new

# b.render
b.move_piece!([0, 4], [4, 4])
b.move_piece!([7, 4], [3, 4])
b.move_piece!([4, 4], [7, 4])
b.move_piece!([3, 4], [0, 4])
#
# p b.in_check?('black')
# b.render

puts
b.render
puts

p "The white king is in check: #{b.in_check?('white')}"
puts
p "The black king is in check: #{b.in_check?('black')}"
