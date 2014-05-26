module ForoHelper

	def display_as_tree(posts)
	  contenido = ''.html_safe

	  posts.each do |post|
	  	url = link_to "#{post.subject}", ver_post_path(post)
	  	margin_left = post.depth * 20
	  	contenido << %(<div style="margin-left:#{margin_left}px">
	  					|- #{url} por <b>#{post.nombre}</b> &middot;
	  					#{post.created_at.strftime("%H:%M:%S %d/%m/%Y")}
	  				  ).html_safe
		
		if current_user and post.parent_id == 0
		  contenido += link_to 'Borrar', delete_post_path(post.id), :method => :delete,
		                :confirm => '¿Está seguro que desea eliminar este post junto con todos sus comentarios?', :class =>  'btn btn-danger btn-xs'
		end

		contenido << %(</div>).html_safe
	  end
	  contenido
	end

end
