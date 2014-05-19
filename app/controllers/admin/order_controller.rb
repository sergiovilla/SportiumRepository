class Admin::OrderController < Admin::AuthenticatedController
  def close
    order = Order.find(params[:id])
    order.close
    flash[:notice] = "La orden  ##{order.id} ha sido cerrada."
    redirect_to :action => 'index'
  end

  def show
    @order = Order.find(params[:id])
    @page_title = "Mostrando orden: ##{@order.id}"
  end

  def index
    @status = params[:id]
    if @status.blank?
      @status = 'all'
      conditions = nil
    else
      conditions = "status = '#{@status}'"
    end
    @orders = Order.paginate :page => params[:page], :conditions => conditions, :per_page => 10
    @page_title = "Mostrando ordenes con estado: #{@status}"
  end
end
