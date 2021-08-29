# DB flush
puts "Cleaning out the DB..."

Comment.destroy_all
puts "Successfully destroyed all comments ✅"

User.destroy_all
puts "Successfully destroyed all users ✅"

Post.destroy_all
puts "Successfully destroyed all posts ✅"


# USERS
puts "Creating users..."

user1 = User.create!(email: "louisbemberg@my-first-api.com", password: "my-first-api-123456")
user2 = User.create!(email: "anonymous@user.com", password: "123456")

puts "#{User.count} user(s) successfully created."

# POSTS
puts "Creating posts"

post1 = Post.create!(user: user1, title: "My first API!", content: "Created my first API using RoR. Not so bad!")
post2 = Post.create!(user: user1, title: "Leave a comment below :)", content: "Hey everyone, why not leaving a comment under this post?")
post3 = Post.create!(user: user2, title: "Try deleting me!", content: "Practice your API skills and delete this post!")
post4 = Post.create!(user: user2, title: "Try editing me!", content: "Practice your API skills and change this post's title to something else :)")

puts "#{Post.count} post(s) successfully created."

# COMMENTS
comment1 = Comment.create!(user: user2, post: post1, content: "congrats on your first post!")
comment2 = Comment.create!(user: user2, post: post1, content: "Cool API!")
comment3 = Comment.create!(user: user2, post: post1, content: "Let's hire this dude!")
comment4 = Comment.create!(user: user2, post: post1, content: "A bit basic to my taste.")

puts "#{Comment.count} comment(s) successfully created."
