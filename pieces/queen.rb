class Queen < SlidingPiece

  def move_dirs
    diagonal + cardinal
  end

  def inspect
    if self.color == "white"
      "\u2655".encode('utf-8') + " "#white
    else
      "\u265B".encode('utf-8') + " " #black
    end
  end
end
