#encoding: utf-8
class Foro::ComentariosController < ApplicationController

  def destroy
    @comentario = Comentario.find(params[:id_comment])
    @comentario.destroy

    flash[:notice] = "Comentario eliminado con éxito"
    redirect_to foro_post_path(params[:id])
  end
end
