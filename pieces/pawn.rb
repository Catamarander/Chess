class Pawn < Piece
  attr_accessor :moved

  def initialize(board, pos, color, moved = false)
    super board, pos, color
    @moved = moved
  end

  def moves
    if self.color == "white"
      a = 1
    else
      a = -1
    end
    move_dirs = []
    unless @moved
      move_dirs << [self.pos[0] + 2*a, self.pos[1]]
    end
    farther = [self.pos[0] + a, self.pos[1]]
    unless chess_board.piece_at_position?(farther)
      move_dirs << farther
    end

    diagonals = [[self.pos[0] + a, self.pos[1] + 1],[self.pos[0] + a, self.pos[1] - 1]]
    diagonals.each do |diag|
      move_dirs << diag if chess_board.piece_at_position?(diag) && chess_board[diag].color != self.color
    end
    move_dirs
  end

  def inspect
    if self.color == "white"
      "\u2659".encode('utf-8') + " " #white
    else
      "\u265F".encode('utf-8') + " " #black
    end
  end
end
