json.extract! account, :id, :name, :name_long, :is_service, :password, :created_at, :updated_at
json.url account_url(account, format: :json)
