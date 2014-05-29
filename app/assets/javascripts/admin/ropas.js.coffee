jQuery ->  
   $('#tags_').bind("keydown", (event) ->
     event.preventDefault() if event.keyCode is $.ui.keyCode.TAB and $(this).data("ui-autocomplete").menu.active
     return
   ).autocomplete  
     source: $('#tags_').data('autocomplete-source')
     focus: ->
     	false
     select: (event, ui) ->
       terms = @value.split(/,\s*/)
       terms.pop()
       terms.push ui.item.value
       terms.push ""
       @value = terms.join(", ")
       false