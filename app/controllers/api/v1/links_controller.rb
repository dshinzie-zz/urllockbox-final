class Api::V1::LinksController < ApplicationController

  def create
    @link = Link.new link_params
    if @link.save
      render json: @link, status: 201
    else
      render json: @link.errors.full_messages, status: 500
    end
  end

  def update

    @link = Link.find params[:id]
    @link.assign_attributes link_params

    if(@link.invalid_link?)
      render json: "Invalid Link", status: 500
    elsif @link.save

      head :no_content
    else
      render json: @link.errors.full_messages.join(","), status: 500
    end
  end

  private

  def link_params
    params.permit(:title, :url, :read)
  end
end
