class Group

  attr_reader :stones, :liberties

  def initialize(stones = [])
    @stones = stones
  end

  # -- Instance methods -----------------------------------------------------
  def add_stone(stone)
    @stones << stone
  end

  def add_liberty(liberty)
    @liberties << liberty
  end




  # -- Class methods --------------------------------------------------------

  def self.group_stones(board_size, stones)
    groups = []
    (1..board_size).each do |row|
      puts "ROW NUMBER #{row}"
      (1..board_size).each do |col|
        puts "COLUMN NUMBER #{col}"
        if stone = stones.select { |s| s.x_position == col && s.y_position == row }.first
          puts "---- THERE IS A STONE ON THIS CELL"
          unless groups.any? { |g| g.stones.include?(stone) }
            puts "---- THIS STONE HASN'T BEEN INCLUDED IN GROUPS YET"
            group = Group.find_group(board_size, stones, stone, [col, row])
            groups << group
          end
        end
      end
    end
    return groups
  end

  def self.find_group(board_size, stones, previous_stone, point, group = nil)
    if stone = stones.select { |s| s.x_position == point[0] && s.y_position == point[1] && s.is_white == previous_stone.is_white }.first
      puts "---- STONE IS SAME COLOR AS PREVIOUS STONE"
      group ||= Group.new
      puts "------ 1"
      group.add_stone(stone)
      puts "------ 2"

      next_points = [
        [point[0] + 1, point[1]], 
        [point[0] - 1, point[1]], 
        [point[0], point[1] + 1], 
        [point[0], point[1] - 1]
      ]
      next_points.delete([previous_stone.x_position, previous_stone.y_position])

      next_points.each do |next_point|
        if next_group = Group.find_group(board_size, stones, stone, next_point)
          puts "------ 3"
          next_group.stones.each do |stone|
            puts "------ 4"
            group.add_stone(stone) unless stone == previous_stone
          end
          puts "------ 5"
        end
      end
    else
      group = nil
    end
    return group
  end

end
