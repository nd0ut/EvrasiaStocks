search_filter = (search_string) ->
  search_string = search_string.toLowerCase()

  restaurants = $('#restaurants .restaurant, #stock-restaurants .restaurant')

  restaurants.each (i, r) ->
    street = $(r).find('span.street')[0]
    metro = $(r).find('span.metro')[0]

    found_in_street = street.innerHTML.toLowerCase().indexOf(search_string) != -1

    found_in_metro = false
    if metro != undefined
      found_in_metro = metro.innerHTML.toLowerCase().indexOf(search_string) != -1

    if found_in_street || found_in_metro
      $(r).show()
    else
      $(r).hide()


$(document).ready ->
#  search form
  search_form = $('form#search')

  search_input = search_form.find('input')[0]
  search_button = search_form.find('button')[0]

  $(search_input).keyup ->
    length = this.value.length

    if length > 2 or length == 0
      search_filter(this.value)

  $(search_input).keypress (e) ->
    if e.which == 13
      search_filter(this.value)
      e.preventDefault()

  $(search_button).click (e) ->
    search_filter(search_input.value)
    e.preventDefault()

#  show description link
  toggle_description_link = $('#toggle_description')
  description = $('#description')[0]

  toggle_description_link.click (e) ->
    $(description).slideToggle(null, ->
      console.log description

      if $(description).is(":visible")
        toggle_description_link.text("Скрыть полную информацию")
      else
        toggle_description_link.text("Показать полную информацию")
    )
    e.preventDefault();

