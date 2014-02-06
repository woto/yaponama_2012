$ ->

  right_hand = ->
    $("#right_hand").animate(
      left: "5px"
    ).animate
      left: "0"
    ,
      complete: ->
        _.delay right_hand, 1000

  right_hand()
