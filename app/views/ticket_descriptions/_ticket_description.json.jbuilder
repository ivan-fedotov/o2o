json.extract! ticket_description, :id, :title, :created_at, :updated_at
json.url ticket_description_url(ticket_description, format: :json)
