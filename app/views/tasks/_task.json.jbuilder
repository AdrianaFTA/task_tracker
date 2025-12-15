json.extract! task, :id, :title, :desription, :due_date, :status, :created_at, :updated_at
json.url task_url(task, format: :json)
