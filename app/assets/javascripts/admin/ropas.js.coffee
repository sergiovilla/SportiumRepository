jQuery ->  
   $('#tags_').bind("keydown", (event) ->
     event.preventDefault() if event.keyCode is $.ui.keyCode.TAB and $(this).data("ui-autocomplete").menu.active
     return
   ).autocomplete
     minLength: 2  
     source: (request, response) ->
      $.ajax
        url: $('#tags_').data('autocomplete-source')
        dataType: "json"
        data:
          name: request.term
        success: (data) ->
          response(data)
     focus: ->
     	false
     select: (event, ui) ->
       terms = @value.split(/,\s*/)
       terms.pop()
       terms.push ui.item.value
       terms.push ""
       @value = terms.join(", ")
       false