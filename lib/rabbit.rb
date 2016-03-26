class Rabbit
  attr_reader :location
  def initialize(field)
    @cells = field.cells
    @size = field.size
  end
  
  def create_rabbit
    @prng = Random.new
    @row_rabbit = @prng.rand(1..@size - 2)
    @prng = Random.new
    @cell_rabbit = @prng.rand(1..@size - 2)
    
    # check if rabbit apear on the snake. if so try another random location
    if @cells[@row_rabbit][@cell_rabbit] == Field::BLACKSQ
      create_rabbit
    else
      @location = {'row' => @row_rabbit, 'cell' => @cell_rabbit}
    end
      @cells[@row_rabbit][@cell_rabbit] = "\e[31m#{Field::BLACKSQ}\e[0m\e[32m"
  end
end
