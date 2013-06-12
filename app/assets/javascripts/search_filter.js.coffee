search_filter = (search_string) ->
  search_string = search_string.toLowerCase()

  restaurants = $('.restaurant')

  restaurants.each (i, r) ->
    r = $(r)
    r.removeHighlight()

    title = r.find('.title').eq(0)
    street = r.find('.street').eq(0)
    metro = r.find('.metro').eq(0)
    hours = r.find('.hours').eq(0)

    found_in_title = (title.html().toLowerCase().indexOf(search_string) != -1)
    found_in_street = (street.html().toLowerCase().indexOf(search_string) != -1)
    found_in_metro = (metro.html().toLowerCase().indexOf(search_string) != -1) if $.isEmptyObject(metro)
    found_in_hours = (hours.html().toLowerCase().indexOf(search_string) != -1)

    found = found_in_title || found_in_street || found_in_metro || found_in_hours

    if found
      title.highlight(search_string) if found_in_title
      street.highlight(search_string) if found_in_street
      metro.highlight(search_string) if found_in_metro
      hours.highlight(search_string) if found_in_hours

      r.show()
    else
      r.hide()

$(document).ready ->
  search_form = $('form#search')

  search_input = search_form.find('input').eq(0)
  search_button = search_form.find('button').eq(0)

  unless $.browser.mobile
    $(search_input).keyup ->
      search_filter(this.value)

  $(search_input).keypress (e) ->
    if e.which == 13
      search_filter(this.value)
      e.preventDefault()

  $(search_button).click (e) ->
    search_filter(search_input.value)
    e.preventDefault()