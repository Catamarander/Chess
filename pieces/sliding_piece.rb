class SlidingPiece < Piece

  # attr_reader :chess_board

  def one_direction(direction, pos, continue = true)
    farther = [direction[0] + pos[0], direction[1] + pos[1]]
    return [] unless Board.on_board?(farther)
    return [] unless continue
    if chess_board.piece_at_position?(farther)
      if chess_board[farther].color != self.color
        one_direction(direction, farther, false) << farther
      else
        return []
      end
    else
      one_direction(direction, farther) << farther
    end
  end



  def moves # instance of piece
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
