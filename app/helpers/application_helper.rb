module ApplicationHelper

  def show_group_stone_and_liberty_counts(group)
    case group.stones.size
    when 1 
      color = 'green'
    when 2 
      color = 'black'
    when 3 
      color = 'blue'
    when 4 
      color = 'red'
    when 5 
      color = 'orange'
    else 
      color = 'purple'
    end
    return "
      <div class='group' style='background: #{color};'>
        #{group.stones.size}, #{group.liberties.size}
      </div>
    ".html_safe
  end


end
