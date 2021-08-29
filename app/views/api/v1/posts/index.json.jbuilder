# API view does not render HTML but JSON
# It's a ruby file using the jbuilder gem

json.array! @posts do |post|
  json.extract! post, :id, :title, :content
  json.comments post.comments do |comment|
    json.extract! comment, :id, :content
  end
end
