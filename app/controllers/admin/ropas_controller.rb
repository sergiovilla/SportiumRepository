#encoding: utf-8
class Admin::RopasController < Admin::AuthenticatedController

  def new
    @tipo = params[:tipo]
    @page_title = @tipo.nil? ? 'Añadiendo nueva ropa' : "Añadiendo #{@tipo}"
    
    unless @tipo.nil?
    	@ropa = Ropa.new
    	@marcas = get_all_marcas()
    	@colores = get_all_colors()
    	unless @tipo.eql? 'Zapatillas'
        	@tallas = get_all_tallas()
      	end
      	render 'new_ropa'
    end
  end
  
  def create
    @ropa = Ropa.new(params[:ropa])
    if @ropa.save
      flash[:notice] = "#{@ropa.tipo} #{@ropa.nombre} creada correctamente."
      redirect_to :action => 'index'
    else
      flash[:error] = @ropa.errors.full_messages
     	redirect_to :action => 'new_ropa'
    end
  end

  def edit
  	@ropa = get_ropa(params[:id])
  	@marcas = get_all_marcas()
  	@colores = get_all_colors()
  	@tallas = get_all_tallas()
    @tipo = @ropa.tipo
  	if @ropa.tipo.eql? 'Zapatillas'
  		@tipoZapatillas = true
  	else 
      @tipoZapatillas = false
  	end
    @page_title = "Editando #{@ropa.nombre} "
  end

  def update
 	@ropa = get_ropa(params[:id])
    if @ropa.update_attributes(params[:ropa])
      flash[:success] = "#{@ropa.nombre} actualizada correctamente"
      redirect_to :action => 'show', :id => @ropa
    else
      flash[:error] = @ropa.errors.full_messages
      redirect_to :action => 'edit'
    end
  end

 def destroy
    @ropa = get_ropa(params[:id])
    @ropa.destroy
    flash[:success] = "#{@ropa.nombre}  eliminada correctamente"
    redirect_to :action => 'index'
  end

  def show
    @ropa = get_ropa(params[:id])
    
    if @ropa.tipo  == 'Zapatillas'
  		@tipoZapatillas = true
  	else 
      @tipoZapatillas = false
  	end

  	if @ropa.deporte == '' or @ropa.deporte.nil?  then
  		@deportenulo = true
  	else
      @deportenulo = false
  	end
  	
    if @ropa.nom_equipo == '' or @ropa.nom_equipo.nil? then
  		@equiponulo = true
  	else
      @equiponulo = false
  	end
  	
    if @ropa.talla.nil? then
  		@tallanula = true
  	else
      @tallanula = false
  	end
  	
    if @ropa.color.nil? then
  		@colornulo = true
  	else
      @colornulo = false
  	end
  	
    if @ropa.imagen.exists? then
  		@imagennula = false
  	else
      @imagennula = true
  	end
  	
    @page_title = "#{@ropa.nombre}"
  end

  def index
    @ropas = get_all_ropas()
    @page_title = 'Listado de Ropas'
  end

  private
  def get_ropa(id)
    Ropa.find(id);
  end
  
  def get_all_ropas
  	Ropa.all
  end
  
  def get_all_marcas()
  	Marca.all
  end
  
  def get_all_colors()
  	Color.all
  end
  
  def get_all_tallas()
  	Talla.all
  end
  
  
end
