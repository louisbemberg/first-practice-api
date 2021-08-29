# API view does not render HTML but JSON
# It's a ruby file using the jbuilder gem

json.array! @posts do |post|
  json.extract! post, :id, :title, :content
end
