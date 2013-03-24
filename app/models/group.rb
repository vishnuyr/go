class Group

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

  # -- Class methods --------------------------------------------------------

  def self.all(board_size, stones)
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
    # remove groups with no liberties
    groups.delete_if {|g| g.liberties.count == 0 }
    return groups
  end

  def self.find_group(board_size, stones, previous_stone, point, group = nil)
    if stone = stones.select { |s| s.x_position == point[0] && s.y_position == point[1] }.first
      if stone.is_white == previous_stone.is_white
        group ||= Group.new
        group.add_stone(stone)

        next_points = []

        next_points << [point[0] + 1, point[1]] unless point[0] == board_size
        next_points << [point[0] - 1, point[1]] unless point[0] == 1
        next_points << [point[0], point[1] + 1] unless point[1] == board_size
        next_points << [point[0], point[1] - 1] unless point[0] == 1

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
      # no stone on that cell
      group.add_liberty(point)
      group = nil
    end
    return group
  end

end
