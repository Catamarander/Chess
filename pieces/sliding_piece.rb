class SlidingPiece < Piece
  def one_direction(direction, pos)
    farther = [direction[0] + pos[0], direction[1] + pos[1]]
    return [] unless Board.on_board?(farther)
    if chess_board.piece_at_position?(farther)
      if chess_board[farther].color != self.color
        one_direction(direction, farther) << farther
      else
        return []
      end
    else
      one_direction(direction, farther) << farther
    end
  end

  def moves(pos) # instance of piece
    every_move = []
    move_dirs.each do |dir|
      every_move += one_direction(dir, pos)
    end

    every_move
  end

  def find_moves(direction)
    current_pos = pos
    moves = []
  end
end
