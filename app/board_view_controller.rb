class BoardViewController < UIViewController
  SQUARE_SIZE = 80
  COLORS = [UIColor.greenColor, UIColor.redColor, UIColor.whiteColor]
  
  def viewDidLoad   
    self.init_views
    self.new_game 
    self.boardChanged
  end
  
  def init_views
    view.backgroundColor = UIColor.blackColor
    
    @boardView = UIView.alloc.initWithFrame([[0, 0], [SQUARE_SIZE * 3, SQUARE_SIZE * 3]])
    @boardView.center = view.center
    
    @squareViews = []
    for i in 0..2
      for j in 0..2
        squareView = UIView.alloc.initWithFrame([[j * (SQUARE_SIZE + 2), i * (SQUARE_SIZE + 2)], [SQUARE_SIZE - 4, SQUARE_SIZE - 4]])
        @squareViews[3*i + j] = squareView
        @boardView.addSubview(squareView)
      end
    end
    
    @label = UILabel.alloc.initWithFrame([[0, 0], [0, 0]])
    @label.textColor = UIColor.whiteColor
    @label.font = UIFont.systemFontOfSize(30)
    @label.backgroundColor = nil
    
    view.addSubview(@label)
    view.addSubview(@boardView)
  end
  
  def show_info(text)
    @label.text = text
    @label.sizeToFit
    @label.center = [160, 50]
  end
  
  def new_game
    @board = Board.new
    @current_player = 1
  end  
  
  def touchesEnded(touches, withEvent:event)
    for i in 0..8
      if event.touchesForView(@squareViews[i])
        if not @board.move(i, @current_player) then 
          show_info("Illegal move!")
          break
        end
        
        @current_player += 1
        @current_player %= 2
        break
      end
    end
    
    if winner = @board.game_over?
      @board.reset
      show_info("Player #{winner} wins!")
    end
    
    self.boardChanged
  end
  
  def boardChanged
    for i in 0..8
      @squareViews[i].backgroundColor = COLORS[@board.grid[i]]
    end
  end
  
end