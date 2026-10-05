class AuthorsController < ApplicationController
   before_action :authenticate_author!

 def index
  @filterrific = initialize_filterrific(
    Author,
    params[:filterrific],
    persistence_id: false
  ) or return

  @authors = @filterrific.find
end
end