class GramsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
  end

  def new
    @gram = Gram.new
  end

  def create
    @gram = current_user.grams.create(gram_params)
    gram_is_valid
  end

  def show
    @gram = Gram.find_by_id(params[:id])
    return render_not_found if @gram.blank?
  end

  def edit
    @gram = Gram.find_by_id(params[:id])
    return render_not_found if @gram.blank?
    return render text: 'Forbidden', status: :forbidden if current_user != @gram.user
  end

  def update
    @gram = Gram.find_by_id(params[:id])
    return render_not_found if @gram.blank?
    return render text: 'Forbidden', status: :forbidden if current_user != @gram.user
    @gram.update_attributes(gram_params)
    gram_is_valid
  end

  def destroy
    @gram = Gram.find_by_id(params[:id])
    return render_not_found if @gram.blank?
    return render text: 'Forbidden', status: :forbidden if current_user != @gram.user
    @gram.destroy
    redirect_to root_path
  end

  private

  def gram_params
    params.require(:gram).permit(:picture, :message)
  end
  
  def render_not_found
    render text: 'Not Found', status: :not_found
  end

  def gram_is_valid
    if @gram.valid?
      redirect_to gram_path(@gram)
    else
      render :new, status: :unprocessable_entity
    end
  end

end