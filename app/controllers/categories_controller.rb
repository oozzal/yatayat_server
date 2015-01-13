class CategoriesController < ApplicationController
  def index
    render json: Category.all.to_json(only: [:id, :name])
  end
end

