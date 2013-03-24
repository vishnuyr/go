require 'test_helper'

class GroupTest < ActiveSupport::TestCase

  def test_group_stones
    board_size = 9
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
        :y_position => num,
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

    groups = Group.group_stones(board_size, stones)
    puts ""
    puts "total groups: #{groups.count}" if groups.present?
    groups.each do |group|
      puts "------------ GROUP ---------------"
      puts "stone count #{group.stones.count}" if group.present?
      group.stones.each do |stone|
        puts "--- STONE ---"
        puts "is white?: #{stone.is_white}"
        puts "x: #{stone.x_position}"
        puts "y: #{stone.y_position}"
      end
    end
    one_stone_groups = groups.select { |g| g.stones.count == 1 }
    five_stone_groups = groups.select { |g| g.stones.count == 5 }
    assert_equal 10, groups.count
    assert_equal 8, one_stone_groups.count
    assert_equal 2, five_stone_groups.count
    # one 5 black stone group, one 5 black stone group
    assert_equal 5, five_stone_groups.last.stones.select {|s| s.is_white }.count
    assert_equal 5, five_stone_groups.first.stones.select {|s| !s.is_white }.count
  end

end
