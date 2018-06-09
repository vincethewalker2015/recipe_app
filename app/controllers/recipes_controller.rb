class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]
  
  
  def index
    @recipes = Recipe.paginate(page: params[:page], per_page: 5) #This will paginate the page
    #@recipes = Recipe.all
  end
  
  def show
    
  end
  
  def new
    @recipe = Recipe.new
  end
  
  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.chef = Chef.first
    if @recipe.save
      flash[:success] = "Recipe was created sucessfully"
      redirect_to recipe_path(@recipe)
    else
      flash.now[:danger] = "Oops!! Something didn't go quite right here... Lets try that again!"
      render "new"
    end
  end
  
  def edit
     
  end
  
  def update
    if @recipe.update(recipe_params)
      flash[:success] = "Update was sucessfull"
      redirect_to recipe_path(@recipe)
    else
      flash.now[:danger] = "Oops!! Something didn't go quite right here... Lets try that again!"
      render 'edit'
    end
  end
  
  def destroy
    @recipe.destroy
    flash[:success] = "Recipe has been deleted"
    redirect_to recipes_path
  end
  
  private
  
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end
  
    def recipe_params
      params.require(:recipe).permit(:name, :description)
    end
  
  
end