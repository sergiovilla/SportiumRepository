#encoding: utf-8
class Foro::ComentariosController < ApplicationController

  def destroy
    @comentario = Comentario.find(params[:id_comment])
    @comentario.destroy

    respond_to do |format|
      format.html {
      	flash[:notice] = "Comentario eliminado con éxito"
        redirect_to foro_post_path(params[:id])
      }
      format.js
    end
  end
end
