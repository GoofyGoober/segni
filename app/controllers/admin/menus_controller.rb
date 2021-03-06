class Admin::MenusController < AdminController
  before_action :set_menu, only: [:edit, :update, :destroy]
  layout 'admin-page'
  def index
    @preview = @website.first_page
  end
  
  # GET /operas/1
  # GET /operas/1.json
  def show
    @preview = @website.first_page
  end

  # GET /operas/new
  def new
    @menu = Menu.new
    @preview = @website.first_page
    render '_form'
  end

  # GET /products/1/edit
  def edit
    @preview = @website.first_page
    render '_form'
  end

  # POST /products
  # POST /products.json
  def create
    @menu = Menu.new(menu_params)
    @menu.website = @website
    @menu.position = Menu.last_position+1 if @menu.position.blank?
    respond_to do |format|
      if @menu.save
        format.html { redirect_to goto_dashboard('menus'), notice: 'menu was successfully created.' }
        format.json { render :show, status: :created, location: @menu }
      else
        format.html { render '_form' }
        format.json { render json: @menu.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    @preview = @website.first_page

    respond_to do |format|
      if @menu.update(menu_params)
        format.html { redirect_to goto_dashboard('menus'), notice: 'Menu was successfully updated.' }
        format.json { render :show, status: :ok, location: @menu }
      else
        format.html { render '_form' }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @menu.destroy
    if request.xhr?
      render js: "$('#menuOrderable #sortable_index_#{@menu.id}').hide()"
    else
     redirect_to goto_dashboard('menus'), notice: 'Product was successfully destroyed.' 
    end
  end

  def sort
    @menu = Menu.find(params[:menu_id])
    @menu.insert_at(params[:position].to_i+1)
    render nothing: true
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_menu
      @menu = Menu.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def menu_params
      params.require(:menu).permit(:name, :name_it, :name_en, :url, :position, :page_id)
    end
end
