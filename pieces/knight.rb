class Knight < SteppingPiece
  KNIGHT_MOVES =[[2,1], [2,-1],[-2,1], [-2,-1], [1,2], [1,-2], [-1,2], [-1,-2]]

  def move_dirs
    KNIGHT_MOVES
  end

  def inspect
    if self.color == "white"
      "\u2658".encode('utf-8') + " "#white
    else
      "\u265E".encode('utf-8') + " "#black
    end
  end
end
