ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase

  include Sorcery::TestHelpers::Rails

  fixtures :all

  def draw_test_board(board_size, stones)
    (1..board_size).each do |col|
      cell = ''
      drawn_row = ''
      (1..board_size).each do |row|
        if stone = stones.select { |s| s.x_position == row && s.y_position == col }.first
          stone.is_white ? color = 'w' : color = 'b'
        else
          color = ' '
        end
        row == board_size ? cell = "| #{color} |" : cell = "| #{color} "
        drawn_row += cell
      end
      puts drawn_row
    end
    puts ""
  end

  def make_test_random_stones
    (1..100).each do |num|
      stone = Stone.new({
        :x_position => rand(1..board_size),
        :y_position => rand(1..board_size),
        :is_white => [true, false].sample
      })
      stones << stone
    end
  end


  def make_test_stones
    stones = []
    (1..5).each do |num|
      stone = Stone.new({
        :x_position => num,
        :y_position => 5,
        :is_white => true
      })
      stones << stone
      stone = Stone.new({
        :x_position => 8,
        :y_position => num + 2,
        :is_white => false
      })
      stones << stone
      stone = Stone.new({
        :x_position => 9,
        :y_position => num + 5,
        :is_white => false
      })
      stones << stone

      stone = Stone.new({
        :x_position => 1,
        :y_position => num + 3,
        :is_white => num%2 == 0
      })
      stones << stone
      stone = Stone.new({
        :x_position => num,
        :y_position => num,
        :is_white => false
      })
      stones << stone
    end
    stones
  end

  def make_test_dead_stones
    stones = []

    dead_is_white = true
    (0..3).each do |x|
      (0..3).each do |y|
        stones << Stone.new({
          :x_position => x*2,
          :y_position => y*2,
          :is_white => dead_is_white
        })
        stones << Stone.new({
          :x_position => x*2 + 1,
          :y_position => y*2,
          :is_white => !dead_is_white
        })
        stones << Stone.new({
          :x_position => x*2 - 1,
          :y_position => y*2,
          :is_white => !dead_is_white
        })

        stones << Stone.new({
          :x_position => x*2,
          :y_position => y*2 + 1,
          :is_white => !dead_is_white
        })

        stones << Stone.new({
          :x_position => x*2,
          :y_position => y*2 - 1,
          :is_white => !dead_is_white
        })
      end
    end
    stones
  end


end
