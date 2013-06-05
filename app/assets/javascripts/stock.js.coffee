search_filter = (search_string) ->
  search_string = search_string.toLowerCase()

  restaurants = $('#restaurants .restaurant .street')

  restaurants.each (i, r) ->
    restaurant_block = r.parentNode.parentNode.parentNode.parentNode.parentNode
    found = r.innerText.toLowerCase().indexOf(search_string)

    if found == -1
      $(restaurant_block).hide()
    else
      $(restaurant_block).show()


$(document).ready ->
  search_form = $('form#search')

  search_input = search_form.find('input')[0]
  search_button = search_form.find('button')[0]

  $(search_input).keyup ->
    search_filter(this.value)

  $(search_button).click (e) ->
    search_filter(search_input.value)
    e.preventDefault()