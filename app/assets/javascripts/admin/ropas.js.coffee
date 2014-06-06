jQuery ->  
   # El autocompletado se inciará si se pulsa la tecla flecha abajo y si se pulsa tabulador al estar en una opción
   # no se moverá a otro campo del formulario
   $('#tags_').bind("keydown", (event) ->
     event.preventDefault() if event.keyCode is $.ui.keyCode.TAB and $(this).data("ui-autocomplete").menu.active
     return
   ).autocomplete
     # Carácteres mínimos para comenzar el autocompletado
     minLength: 2  
     # Los datos del autcompletado provienen de:
     source: (request, response) ->
      $.ajax
        url: $('#tags_').data('autocomplete-source')
        dataType: "json"
        data:
          name: request.term
        success: (data) ->
          response(data)
     # Evita que el valor insertado permanezca en focus
     focus: ->
     	false
     # Cuando se selecciona un término se añade al campo del formulario junto a una , y un espacio
     select: (event, ui) ->
       terms = @value.split(/,\s*/)
       terms.pop()
       terms.push ui.item.value
       terms.push ""
       @value = terms.join(", ")
       false