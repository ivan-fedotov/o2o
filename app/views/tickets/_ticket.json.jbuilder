json.extract! ticket, :id, :site_id, :author_id, :title, :time_new, :time_at_site, :time_done, :status_id, :created_at, :updated_at
json.url ticket_url(ticket, format: :json)
