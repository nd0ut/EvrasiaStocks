search_filter = (search_string) ->
  search_string = search_string.toLowerCase()

  restaurants = $('#restaurants .restaurant, #stock-restaurants .restaurant')

  restaurants.each (i, r) ->
    street = $(r).find('span.street')[0]
    found = street.innerText.toLowerCase().indexOf(search_string)

    if found == -1
      $(r).hide()
    else
      $(r).show()


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

