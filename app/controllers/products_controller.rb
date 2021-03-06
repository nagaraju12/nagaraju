class ProductsController < ApplicationController
  
	def index
		@products = Product.paginate(page: params[:page], per_page: 2)
	end

	def new
		@product= Product.new
	end

	def create
  @product = Product.new(product_params)
 
  @product.save
  redirect_to @product
end

 def show
    @product = Product.find(params[:id])
  end

  def edit
  	@product= Product.find(params[:id])
  end

   def update
    @product = Product.find(params[:id])
 
    if @product.update(product_params)
      redirect_to @product
    else
      render 'edit'
    end
  end
 
  def destroy
    @product = Product.find(params[:id])
    @product.destroy
 
    redirect_to products_path
  end
 
  private
    def product_params
      params.require(:product).permit(:title, :description, :price, :photo)
    end
end