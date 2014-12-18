class Bishop < SlidingPiece

  def move_dirs
    diagonal
  end

  def inspect
    if self.color == "white"
      "\u2657".encode('utf-8') + " "#white
    else
      "\u265D".encode('utf-8') + " " #black
    end
  end
end
