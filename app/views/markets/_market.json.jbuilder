json.extract! market, :id, :user_id, :item_id, :price, :stock, :created_at, :updated_at
json.url market_url(market, format: :json)
