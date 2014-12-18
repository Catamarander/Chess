require_relative 'pieces/pieces.rb'

class Board
  attr_accessor :chess_board, :cursor

  def initialize(setup = true)
    set_up_game(setup)
    @cursor = [0, 0]
  end

  def self.on_board?(pos)
    pos.all? { |coord| (0..7).cover? coord }
  end

  def move_piece!(from_pos, to_pos)
    piece = self[from_pos]
    self[to_pos] = piece
    self[from_pos] = nil
    piece.pos = to_pos
    piece.moved = true if piece.is_a?(Pawn)
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

  def cursor_position(input_letter)
    case input_letter
    when 'w'
      cursor[0] -= 1
    when 's'
      cursor[0] += 1
    when 'a'
      cursor[1] -= 1
    when 'd'
      cursor[1] += 1
    when 't'
      cursor
    when 'f'
      cursor
    when 'q'
      raise "You quit"
    end
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
    (color == "white") ? row = 1 : row = 6
    8.times { |col| Pawn.new(self, [row, col], color)}
  end

  def place_pieces(color)
    pieces = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
    (color == "white") ? row = 0 : row = 7
    pieces.each_with_index { |piece, col| piece.new(self, [row, col], color) }
  end

  #################
  ### RENDERING ###
  #################

  def render
    letter_line = "  A B C D E F G H"
    white, black = "\u2654".encode('utf-8'), "\u265A".encode('utf-8')

    board_without_letters = chess_board.map.with_index do |row, i|
      add_numbers_to_row(row, i)
    end

    ["", letter_line, board_without_letters, letter_line,
      "", "White is #{white}  Black is #{black}"].join("\n")
  end

  def add_numbers_to_row(row, i)
    individual_line = [render_row(row, i)]
    individual_line.map { |elem| "#{8 - i} #{elem} #{8 - i}"}
  end

  def render_row(row, i)
    individual_row = row.map.with_index do |square, j|
      render_square(square, i, j)
    end
    individual_row.join("")
  end

  def render_square(square, i, j)
    if square
      square.inspect.colorize(:background => decide_background_color(i, j))
    else
      '  '.colorize(:background => decide_background_color(i, j))
    end
  end

  def decide_background_color(i, j)
    return :yellow if [i, j] == cursor
    return :light_gray if (i + j).odd?
    :blue
  end

  def self.render_position(ary)
    grid_hash = Hash[0, "A", 1, "B", 2, "C", 3, "D",
      4, "E", 5, "F", 6, "G", 7, "H"]
    number_hash = Hash[0, 8, 1, 7, 2, 6, 3, 5, 4, 4, 5, 3, 6, 2, 7, 1]

    ary.map do |computer_position|
      number, letter = computer_position
      "#{grid_hash[letter]}#{number_hash[number]}"
    end
  end
end
