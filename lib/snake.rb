class Snake
  def initialize(field, rabbit)
    @field = field
    @rabbit = rabbit

    @cells = field.cells
    @size = field.size
  end
  
  def create_snake
    @snake = []
    @row = @size - 2
    @cell = 1
    (0..3).each do |i| # initialy snake will be 4 squares long
      @cells[@row][@cell + i] = Field::BLACKSQ
      @snake[i] = {'row' => @row, 'cell' => @cell + i}
    end
  end
  
  def move(direction)
    @direction = direction
    
    # find out where is a head and a tail of a snake
    @row_tail = @snake[0]['row']
    @cell_tail = @snake[0]['cell']
    @row_head = @snake[@snake.length - 1]['row']
    @cell_head = @snake[@snake.length - 1]['cell']
    
    turning(@direction)
  end
  
  def turning(direction)
    @direction = direction
    
    # prevent moving backward
    if @direction == 'left' && @current_direction == 'right'
      @direction = 'right'
    elsif @direction == 'right' && @current_direction == 'left'
      @direction = 'left'
    elsif @direction == 'up' && @current_direction == 'down'
      @direction = 'down'
    elsif @direction == 'down' && @current_direction == 'up'
      @direction = 'up'
    end
    
    case @direction
    when 'up'
      # move head
      if @cells[@row_head - 1][@cell_head] == Field::BLACKSQ
        Func.game_over
      else
        @cells[@row_head - 1][@cell_head] = Field::BLACKSQ
        @snake.push('row' => @row_head - 1, 'cell' => @cell_head)
        @current_direction = 'up'
      end
    when 'down'
      if @cells[@row_head + 1][@cell_head] == Field::BLACKSQ
        Func.game_over
      else
        @cells[@row_head + 1][@cell_head] = Field::BLACKSQ
        @snake.push('row' => @row_head + 1, 'cell' => @cell_head)
        @current_direction = 'down'
      end
    when 'right'
      if @cells[@row_head][@cell_head + 1] == Field::BLACKSQ
        Func.game_over
      else
        @cells[@row_head][@cell_head + 1] = Field::BLACKSQ
        @snake.push('row' => @row_head, 'cell' => @cell_head + 1)
        @current_direction = 'right'
      end
    when 'left'
      
      if @cells[@row_head][@cell_head - 1] == Field::BLACKSQ
        Func.game_over
      else
        @cells[@row_head][@cell_head - 1] = Field::BLACKSQ
        @snake.push('row' => @row_head, 'cell' => @cell_head - 1)
        @current_direction = 'left'
      end
    end
    
    # remove tail or eat rabbit
    if @row_head == @rabbit.location['row'] && @cell_head == @rabbit.location['cell']
      @field.score += 1
      
      @rabbit.create_rabbit
    else
      @cells[@row_tail][@cell_tail] = Field::WHITESQ
      @snake.shift
    end
  end
  
end
