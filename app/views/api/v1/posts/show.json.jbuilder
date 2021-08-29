json.extract! @post, :id, :title, :content
json.comments @post.comments do |comment|
  json.extract! comment, :id, :content
end
