json.extract! email, :id, :title, :description, :sender, :receiver, :is_archived, :is_deleted, :created_at, :updated_at
json.url email_url(email, format: :json)
