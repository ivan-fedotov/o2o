json.extract! ticket_type, :id, :title, :created_at, :updated_at
json.url ticket_type_url(ticket_type, format: :json)
