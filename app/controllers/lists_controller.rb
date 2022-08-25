class ListsController < ApplicationController
  before_action :set_list, only: %i[show]

  def index
    @lists = List.all
  end

  def show
  end

  def new
  end

  private
  def set_list
    @list = List.find(params[:list_id])
  end
end
