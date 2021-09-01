# Louis's Basic Chat API Documentation

🌻 A simple API Built in Ruby on Rails to write posts & comment on them... Twitter style! 🐥

## Introduction 
This simple API allows you to publish and retrieve posts,
similarly to social media services such as Twitter, Medium, etc.
Each post has a title and content, and people can comment on your posts.
The API allows you to create, edit, and delete a post. It also allows you to
add and delete comments.

## Permissions
  The API gives restricited permissions for certain actions:
  * **Read posts & comments** - anyone
  * **Publishing a post or comment** - logged-in users
  * **Editing/deleting a post or comment** - original owners of the post

## URL
  The base URL of the API is [`https://TBDTBDTBD.herokuapp.com`](https://TBDTBDTBD.herokuapp.com)\
  You may interact with the API with the method of your choice,
  although using a user-friendly interface such as [postman](https://www.postman.com) is recommended.
  The specific URLs for each available CRUD action are detailed below.

  * **See all posts (and associated comments)** - (GET) /api/v1/posts
  * **See one specific post (and associated comments)** - (GET) /api/v1/posts/:id
  * **Publishing a post** - (POST) /api/v1/posts
  * **Editing a post** - (PATCH) /api/v1/posts
  * **Deleting a post** - (DELETE) /api/v1/posts/:id
  * **Publishing a comment on a post** - (POST) /api/v1/posts/:post_id/comments
  * **Deleting a comment** - (DELETE) /api/v1/comments/:id

# Using the API
An example for each available CRUD action is listed below.

## See all posts
`(GET) /api/v1/posts`

There is no need to be logged in/authenticated to retrieve posts from the API.
You may simply perform a GET request to get the desired data.
(note: the `-s` and `| jq` improve readability but are not mandatory)

```console
curl -s http://localhost:3000/api/v1/posts | jq
```

The API will respond with a JSON array filled with all the posts:
```JSON
[
  {
    "id": 7,
    "title": "My first API!",
    "content": "Created my first API using RoR. Not so bad!",
    "comments": [
      {
        "id": 7,
        "content": "congrats on your first post!"
      },
      {
        "id": 8,
        "content": "Cool API!"
      },
      {
        "id": 9,
        "content": "Let's hire this dude!"
      },
      {
        "id": 10,
        "content": "A bit basic to my taste."
      }
    ]
  },
  {
    "id": 10,
    "title": "Try editing me!",
    "content": "Practice your API skills and change this post's title to something else :)",
    "comments": [

    ]
  }
]
```

## See one specific post
`(GET) /api/v1/posts/:id`
Similarly to the previous example, no authentication is needed for GET requests.
You may perform a GET request by specifying in the URL the id of the desired post. If you were interested in the post with id = 7, you'd run the following:

```console
curl -s http://localhost:3000/api/v1/posts/7 | jq
```

The API will respond with a JSON of the post:

```JSON
{
  "id": 7,
  "title": "My first API!",
  "content": "Created my first API using RoR. Not so bad!",
  "comments": [
    {
      "id": 7,
      "content": "congrats on your first post!"
    },
    {
      "id": 8,
      "content": "Cool API!"
    },
    {
      "id": 9,
      "content": "Let's hire this dude!"
    },
    {
      "id": 10,
      "content": "A bit basic to my taste."
    }
  ]
}
```

## Publishing a post 
`(POST) /api/v1/posts`

🚨 WARNING: For the following requests, you will need to be logged in to make a request to the API.
You can create an account by signing up [here](www.TBDTBDTBD.com) \
Alternatively, you may use the following anonymous user credentials:
```
email: anonymous@user.com
authentication_token: Rs4PjnF4knoy75ZjCi9z
```

The API will expect in the headers `User-Email` and `User-Token` keys, and JSON data in the body.
As a reminder, any post must contain a `title` and `content`.

Using the anonymous credentials mentioned above, a typical request could look like this:

```console
curl -i -X POST                                                             \
    -H 'Content-Type: application/json'                                     \
    -H 'X-User-Email: anonymous@user.com'                                   \
    -H 'X-User-Token: Rs4PjnF4knoy75ZjCi9z'                                 \
    -d '{ "title": "Hello World!", "content": "Good morning everybody!" }' \
    http://localhost:3000/api/v1/posts
```

The API will respond with a JSON object of the post you just created:

```JSON
{
    "id": 12,
    "title": "Hello World!",
    "content": "Good morning everybody!",
    "comments": []
}
```

## Editing a post
`(PATCH) /api/v1/posts/:id`

Very similar procedure as creating a post, simply with a different verb.
As a reminder, The API will expect in the headers `User-Email` and `User-Token` keys, and JSON data in the body.
In the body, you are free to specify either `title`, `content`, or both, depending on what you want to change.

Editing the post with id 12 that you have created above would look like this:

```console
curl -i -X PATCH                                        \
       -H 'Content-Type: application/json'              \
       -H 'X-User-Email: anonymous@user.com'            \
       -H 'X-User-Token: Rs4PjnF4knoy75ZjCi9z'          \
       -d '{ "restaurant": { "title": "This is a brand new title!" } }'    \
       http://localhost:3000/api/v1/posts/12
```

The API will respond with a JSON of your newly updated post:

```JSON
{
    "id": 12,
    "title": "This is a brand new title!",
    "content": "Good morning everybody!",
    "comments": []
}
```

## Deleting a post
`(DELETE) /api/v1/posts/:id`

The API will only let you delete one of your own posts.
Again, it will verify your identity using your email and token provided in the headers.

To delete the post you've created above, pass to the API your auhtentication headers and the id of the post to delete.

Let's delete 'anonymous@user.com''s post with id 12:

```console
curl -i -X DELETE                                    \
       -H 'X-User-Email: anonymous@user.com'         \
       -H 'X-User-Token: Rs4PjnF4knoy75ZjCi9z'       \
       http://localhost:3000/api/v1/posts/12
```

Sometimes, API's don't respond at all after performing a DELETE action.
In this case, the API will respond with a list of all posts, to give you the freedom to check that your post has indeed been deleted:

```JSON
[
  {
    "id": 7,
    "title": "My first API!",
    "content": "Created my first API using RoR. Not so bad!",
    "comments": [
      {
        "id": 7,
        "content": "congrats on your first post!"
      },
      {
        "id": 8,
        "content": "Cool API!"
      },
      {
        "id": 9,
        "content": "Let's hire this dude!"
      },
      {
        "id": 10,
        "content": "A bit basic to my taste."
      }
    ]
  },
  {
    "id": 10,
    "title": "Try editing me!",
    "content": "Practice your API skills and change this post's title to something else :)",
    "comments": [

    ]
  }
]
```

## Adding a comment
`(POST) /api/v1/posts/:post_id/comments`

You may add a comment to any given post. To do so, you'll need to be authenticated.

You can create an account by signing up [here](www.TBDTBDTBD.herokuapp.com) \
Alternatively, you may use the following anonymous user credentials:
```
email: anonymous@user.com
authentication_token: Rs4PjnF4knoy75ZjCi9z
```

The API will expect in the headers `User-Email` and `User-Token` keys, and JSON data in the body.
A comment is only made up of `content`. You will need to specify in the URL the id `post_id` of the post you want to comment under. 

Using the anonymous credentials mentioned above, a typical request could look like this.
Let's add a comment to the post with id = 12

```console
curl -i -X POST                                                             \
    -H 'Content-Type: application/json'                                     \
    -H 'X-User-Email: anonymous@user.com'                                   \
    -H 'X-User-Token: Rs4PjnF4knoy75ZjCi9z'                                 \
    -d '{ "content": "Awesome post!" }' \
    http://localhost:3000/api/v1/posts/12/comments
```

The API will respond with a JSON of the  post, whose `comments` array will be filled with your  new comment:

```JSON
{
    "id": 12,
    "title": "This is a brand new title!",
    "content": "Good morning everybody!",
    "comments": [
        {
            "id": 11,
            "content": "Awesome post!"
        }
    ]
}
```

## Deleting a Comment
`(POST) /api/v1/comments/:id`

Be wary of the slightly different URL when deleting a comment. The id of the post is not required, as the id of the comment to be  deleted will suffice.

To delete the recently added comment with id = 11, you could run the following:

```console
curl -i -X DELETE                                    \
       -H 'X-User-Email: anonymous@user.com'         \
       -H 'X-User-Token: Rs4PjnF4knoy75ZjCi9z'       \
       http://localhost:3000/api/v1/comments/11
```

The API will respond with a JSON object containing the post who no longer has the comment you just deleted:
```JSON
{
    "id": 12,
    "title": "This is a brand new title!",
    "content": "Good morning everybody!",
    "comments": [
    ]
}
```

## Next steps

In next releases of the API, the following features will be added:
* Creating an account using the API directly
* Hosting of the API online so that it can be accessed globally instead of locally
* Front-end design of the posts on the homepage of the API