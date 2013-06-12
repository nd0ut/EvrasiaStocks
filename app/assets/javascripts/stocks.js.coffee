$(document).ready ->
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

