$ ->
	# Funcíon para hacer draggable y droppable a los elementos
	make_draggable_and_droppable = ->
		# Se hace draggable a los elementos cuya clase es "ropa-imagen"
		$(".ropa-imagen").draggable
			helper: "clone" # La imagen que se arrastra es un clon de la original, la original permanece en su posción
			snap: "#shopping_cart" # La imagen arrastrada se pega a los bordes de shopping_cart
			cursor: "move" # El cursor permanece visible y en movimiento al arrastrar

		# Se hace droppable el elemento con identificador "shopping_cart"
		$("#shopping_cart").droppable drop: drop_ropa

		return

	drop_ropa = (event, ui) ->
		# Cada vez que se suelta un elemento se hace una llamada ajax
		$.ajax
			type: "POST"
			url: "/cart/add?id=" + ui.draggable.attr("id")
			dataType: "script"
			remote: "true"
			success: ->
		return

	# Se ejecuta la función definida.
	$ make_draggable_and_droppable()

	return