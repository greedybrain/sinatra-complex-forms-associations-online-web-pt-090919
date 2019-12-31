class OwnersController < ApplicationController
  get '/owners' do
    @owners = Owner.all
    erb :'/owners/index' 
  end
  get '/owners/new' do 
    @pets = Pet.all
    erb :'/owners/new'
  end
  post '/owners' do 
    @owner = Owner.create(params[:owner])
    if !params["pet"]["name"].empty?
      @owner.pets << Pet.create(name: params["pet"]["name"])
    end
    redirect "/owners/#{@owner.id}"
  end
  get '/owners/:id' do |id|
    @owner = Owner.find_by_id(id)
    erb :'/owners/show'
  end
  get '/owners/:id/edit' do |id|
    @owner = Owner.find_by_id(id) #=> params[:id]
    binding.pry
    erb :'/owners/edit'
  end
  
  patch '/owners/:id' do |id|
    if !params[:owner].keys.include?("pet_ids")
      params[:owner]["pet_ids"] = []
    end
    @owner = Owner.find_by_id(id)
    @owner.update(params["owner"])
    if !params["pet"]["name"].empty?
      @owner.pets << Pet.create(name: params["pet"]["name"])
    end
    redirect "owners/#{@owner.id}"
  end
end