#encoding: utf-8

module TagHelper


  def display_tags(ropa)
    ropa.tag_list.collect{|tag| link_to tag, show_tag_path(tag) }.join(", ").html_safe if ropa.tag_list
  end

  def related_tags(ropa)
  	# Obtiene etiquetas de la ropa
  	ropa_tags = ropa.tag_list
  	related_ropa_tags = []

  	# Crea un array con todos los tags de toda la ropa relacionada
  	ropa.find_related_tags.each do |related|
  	  related_ropa_tags += related.tag_list
  	end

  	# Elimina duplicados y los tags de la ropa principal
  	related_ropa_tags.uniq!
  	ropa_tags.each do |tag|
  	  related_ropa_tags.delete(tag)
  	end

    # Devuelve un una cadena con los tags y sus links correspondientes
  	related_ropa_tags.collect{|tag| link_to tag, show_tag_path(tag) }.join(", ").html_safe  	
  end

end