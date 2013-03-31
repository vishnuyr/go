class Group

  require 'group_helper'
  extend GroupHelper

  attr_reader :stones, :liberties

  def initialize(stones = [], liberties = [])
    @stones = stones
    @liberties = liberties
  end

  # -- Instance methods -----------------------------------------------------
  def add_stone(stone)
    @stones << stone
  end

  def add_liberty(point)
    @liberties << point
  end

  def is_alive(groups, board_size)
    # is there an empty space next to any stone in the group
    self.stones.each do |stone| 
      next_points = Group.surrounding_points([stone.x_position, stone.y_position], board_size)
      next_points.each do |np|
        # if there isn't a stone in the live groups at that point, then we're good
        if !groups.any? { |lg| lg.stones.any? { |s| s.x_position == np[0] && s.y_position == np[1] } }
          self.liberties << [np[0], np[1]] if self.liberties == 0
          return true
        end
      end
    end
    return false
  end

  # -- Class methods --------------------------------------------------------

  def self.all(board_size, stones, new_stone = nil)
    groups = []
    (1..board_size).each do |row|
      (1..board_size).each do |col|
        if stone = stones.select { |s| s.x_position == col && s.y_position == row }.first
          unless groups.any? { |g| g.stones.include?(stone) }
            group = Group.find_group(board_size, stones, stone, [col, row])
            groups << group
          end
        end
      end
    end
    # remove groups with no liberties,
    # except the group containing the new stone, which may or may not be alive
    dead_groups = groups.select { |g| g.liberties.count == 0 }

    new_group = groups.select { |g| g.stones.include?(new_stone) }.first
    unless new_group && new_group.is_alive(groups, board_size)
      dead_groups.delete(new_group)
    end
    groups = groups - dead_groups

    delete_stones_in_groups(dead_groups)

    if new_group
      if !new_group.is_alive(groups, board_size)
        delete_stones_in_groups([new_group])
        groups.delete(new_group)
      else
        groups << new_group
      end
    end

    return groups
  end

  def self.find_group(board_size, stones, previous_stone, point, group = nil)
    # there is a stone at that point.
    if stone = stones.select { |s| s.x_position == point[0] && s.y_position == point[1] }.first
      # the stone is same color as last stone
      if stone.is_white == previous_stone.is_white
        group ||= Group.new
        group.add_stone(stone)

        # check surrounding points for more stones in the group
        next_points = surrounding_points(point, board_size)
        next_points.each do |next_point|
          unless group.stones.any? {|s| s.x_position == next_point[0] && s.y_position == next_point[1]}
            Group.find_group(board_size, stones, stone, next_point, group)
          end
        end
      else
        # there is a stone at that point, but it's not the same color as last stone.
        group = nil
      end
    else
      # no stone on that cell. add liberty if it's not already included.
      unless group.liberties.any? { |l| l[0] == point[0] && l[1] == point[1] }
        group.add_liberty(point)
      end
      group = nil
    end
    return group
  end

end
