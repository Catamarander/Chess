require_relative 'pieces/pieces.rb'

class Board
  attr_accessor :chess_board

  def initialize(setup = true)
    set_up_game(setup)
  end

  def self.on_board?(pos)
    pos.all? { |coord| (0..7).cover? coord }
  end

  def move_piece!(from_pos, to_pos) # used to actually move piece
    piece = self[from_pos]

    if piece.valid_moves.include?(to_pos)
      self[to_pos] = piece
      self[from_pos] = nil
      piece.pos = to_pos
      piece.moved = true if piece.is_a?(Pawn)
    else
      raise "Not a valid move"
    end
  end

  def move(from_pos, to_pos) # only used by valid_moves
    piece = self[from_pos]
    self[to_pos] = piece
    self[from_pos] = nil
    piece.pos = to_pos
  end

  def all_moves(piece)
    piece.moves
  end

  def piece_at_position?(position)
    !self[position].nil?
  end

  def dup_board
    possible_board = Board.new(false)
    flattened = chess_board.flatten.compact
    flattened.each do |piece|
      possible_board[piece.pos] = piece.class.new(possible_board, piece.pos, piece.color)
    end

    possible_board
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
    puts "0 1 2 3 4 5 6 7"
    chess_board.map do |row|
      row.map do |square|
        if square
          square.inspect
        else
          '_'
        end
      end.join(" ")
    end.join("\n")
  end

  def in_check?(color)
    opponents = get_all_not_color(color)
    king = king_position(color)
    opponents.any? do |opp|
      moves = all_moves(opp)
      moves.include? king
    end
  end

  def check_mate?(color)
    teammates = get_all_color(color)
    teammates.all? { |teammate| teammate.valid_moves.empty? }
  end

  def king_position(color)
    get_all_color(color).select{ |el| el.is_a? King }[0].pos
  end

  def get_all_color(color)
    flat_board = chess_board.flatten.compact
    flat_board.select {|el| el.color == color }
  end

  def get_all_not_color(color)
    flat_board = chess_board.flatten.compact
    flat_board.select { |el| el.color != color }
  end

  def set_up_game(setup = true)
    @chess_board = Array.new(8) { Array.new(8) { nil } }
    if setup
      ["white", "black"].each do |color|
        place_pawns(color)
        place_pieces(color)
      end
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
