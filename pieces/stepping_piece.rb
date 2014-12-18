class SteppingPiece < Piece

  def moves()
    every_move = []
    move_dirs.each do |dir|
      farther = [dir[0] + pos[0], dir[1] + pos[1]]
      if Board.on_board?(farther)
        if !chess_board.piece_at_position?(farther)
          every_move << farther
        elsif chess_board[farther].color != self.color
          every_move << farther
        end
      end
    end

    every_move
  end
end
