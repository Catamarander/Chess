class King < SteppingPiece
  def move_dirs
    diagonal + cardinal
  end

  def inspect
    if self.color == "white"
      "\u2654".encode('utf-8') + " "#white
    else
      "\u265A".encode('utf-8') + " "#black
    end
  end
end
