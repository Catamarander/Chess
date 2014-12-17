class Pawn < Piece

  def move_dirs
    [1, 0] # or [-1, 0]
  end

  def moves(pos)
    [move_dirs[0] + pos[0], move_dirs[1] + pos[1]]
  end

  def inspect
    if self.color == "white"
      "\u2659".encode('utf-8') #white
    else
      "\u265F".encode('utf-8') #black
    end
  end
end
