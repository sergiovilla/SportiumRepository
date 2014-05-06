$ ->
	make_draggable_and_droppable = ->
		$(".ropa-imagen").draggable
			helper: "clone"
			snap: "#shopping_cart"
			cursor: "move"

		$("#shopping_cart").droppable drop: drop_ropa

		return

	drop_ropa = (event, ui) ->
		$.ajax
			type: "POST"
			url: "/cart/add?id=" + ui.draggable.attr("id")
			dataType: "script"
			remote: "true"
			success: ->
		return

	$ make_draggable_and_droppable()

	return