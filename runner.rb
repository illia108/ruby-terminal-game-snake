require './lib/field.rb'
require './lib/snake.rb'
require './lib/rabbit.rb'
require './lib/functions.rb'
require 'io/console'

# puts Func.get_direction

field = Field.new(15) # size
field.create_field()

rabbit = Rabbit.new(field)
rabbit.create_rabbit

snake = Snake.new(field, rabbit)
snake.create_snake()

# reprint field showing snake motion
snake_thr = Thread.new do
  loop do
    snake.move(Func.get_direction)
    field.print_field
    sleep(0.3) # snake's speed
  end
end

# catch user input (arrow keys and ESC)
Func.user_control
