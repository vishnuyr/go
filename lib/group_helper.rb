module GroupHelper

  def surrounding_points(point, board_size)
    surrounding_points = []
    surrounding_points << [point[0] + 1, point[1]] unless point[0]+1 > board_size
    surrounding_points << [point[0] - 1, point[1]] unless point[0]-1 < 1
    surrounding_points << [point[0], point[1] + 1] unless point[1]+1 > board_size
    surrounding_points << [point[0], point[1] - 1] unless point[1]-1 < 1
    return surrounding_points
  end

  def delete_stones_in_groups(groups)
    groups.each do |group|
      group.stones.each do |stone|
        stone.delete
      end
    end
  end

end 