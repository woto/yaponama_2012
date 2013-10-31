json.extract! talk, :id, :talkable_id, :talkable_type, :read, :updated_at
json.created_at l(talk.created_at, :format => :short)
json.creator talk.creator.try(:to_label)
json.user_id talk.somebody_id
json.text talk.talkable.try(:to_label)
