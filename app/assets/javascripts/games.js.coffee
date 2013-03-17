$ ->

  $(document).on 'click', 'td.board_cell', ->
    console.log "hello"
    path = "/games/" + game_id + "/stones"
    $.post path, {'stone': {'x_position': $(this).data('x'), 'y_position': $(this).data('y')}}