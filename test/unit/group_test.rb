require 'test_helper'

class GroupTest < ActiveSupport::TestCase

  def test_all
    board_size = 13

    stones = make_test_stones

    draw_test_board(board_size, stones)

    groups = Group.all(board_size, stones)

    one_stone_groups = groups.select { |g| g.stones.count == 1 }
    five_stone_groups = groups.select { |g| g.stones.count == 5 }
    ten_stone_groups = groups.select { |g| g.stones.count == 10 }
    assert_equal 10, groups.count
    assert_equal 8, one_stone_groups.count
    assert_equal 1, five_stone_groups.count
    assert_equal 1, ten_stone_groups.count
    # one 5 white stone group, one 10 black stone group
    assert_equal 5, five_stone_groups.first.stones.select {|s| s.is_white }.count
    assert_equal 10, ten_stone_groups.first.stones.select {|s| !s.is_white }.count
  end

  def test_all_with_dead_groups
    board_size = 13

    stones = make_test_dead_stones
    draw_test_board(board_size, stones)

    assert_equal 80, stones.count
    assert_equal 16, stones.select { |s| s.is_white }.count
    assert_equal 64, stones.select { |s| !s.is_white }.count

    groups = Group.all(board_size, stones)
    stones = groups.collect { |g| g.stones }.flatten(1)

    draw_test_board(board_size, stones)

    assert_equal 24, stones.count
    assert_equal 0, stones.select { |s| s.is_white }.count
    assert_equal 24, stones.select { |s| !s.is_white }.count

  end

end
