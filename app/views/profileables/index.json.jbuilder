/ TODO Переработать или вообще удалить
json.array!(@names) do |name|
  json.extract! name, :name, :creation_reason, :notes, :notes_invisible, :removed, :user_id, :creator_id
  json.url name_url(name, format: :json)
end