class Board
  attr_reader :grid
  
  def initialize
    @grid = Array.new(9, -1)
  end
  
  def move(square, player)
    if not @grid[square] == -1 
      return false      
    end
    @grid[square] = player
  end
  
  def reset 
    @grid.replace(Array.new(9, -1))
  end
  
  def game_over?
    for i in 0..2
      if @grid[3*i] != -1 && @grid[3*i] == @grid[3*i + 1] && @grid[3*i + 1] == @grid[3*i + 2]
        return @grid[3*i]
      elsif @grid[3*i] != -1 && @grid[3*i] == @grid[3*i + 3] && @grid[3*i + 3] == @grid[3*i + 6]
        return @grid[3*i]
      end
    end
    
    if @grid[0] != -1 && @grid[0] == @grid[4] && @grid[4] == @grid[8]
      return @grid[0]
    elsif @grid[2] != -1 && @grid[2] == @grid[4] && @grid[4] == @grid[6]
      return @grid[2]
    end
    
    if not @grid.include?(-1)
      return -1
    end
    
    false
  end

end