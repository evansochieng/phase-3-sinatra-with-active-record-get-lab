class ApplicationController < Sinatra::Base
  #set the response type to json
  set :default_content_type, 'application/json'

  # add routes
  #get request that returns all bakeries in the database
  get '/bakeries' do
    #access all bakeries from the database
    bakeries = Bakery.all

    #return them back as JSON array
    bakeries.to_json
  end

  #GET /bakeries/:id
  # Return a single bakery with its baked goods
  get '/bakeries/:id' do
    #get the id from the params and make get request
    bakery = Bakery.find(params[:id])

    #return the bakery asJSON with its baked goods as nested array
    bakery.to_json(include: :baked_goods)
  end

  #GET /baked_goods/by_price
  #return baked_goods ordered by price in descending order
  get '/baked_goods/by_price' do
    #get all baked_goods from db, order by price in DESC order
    ordered_baked_goods = BakedGood.all.order(price: :DESC)

    #return as JSON
    ordered_baked_goods.to_json
  end

  #GET /baked_goods/most_expensive
  #return single most expensive baked good
  get '/baked_goods/most_expensive' do
    #get all baked goods, order by price in DESC order, extract the top good 
    most_expensive_good = BakedGood.all.order(price: :DESC).first

    #return as JSON
    most_expensive_good.to_json
  end
end
