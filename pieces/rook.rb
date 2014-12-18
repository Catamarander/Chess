class Rook < SlidingPiece

  def move_dirs
    cardinal
  end

  def inspect
    if self.color == "white"
      "\u2656".encode('utf-8') + " " #white
    else
      "\u265C".encode('utf-8') + " "#black
    end
  end
end
