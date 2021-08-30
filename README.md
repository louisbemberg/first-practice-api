## Louis's Basic Chat API Documentation

🌻 A simple API Built in Ruby on Rails to write posts & comment on them.

### Introduction
 This simple API allows you to publish and retrieve posts,
 similarly to social media services such as Twitter, Medium, etc.
 Each post has a title and content, and people can comment on your posts.
 The API allows you to create, edit, and delete a post. It also allows you to
 add and delete comments.

#### Permissions
The API gives restricited permissions for certain actions:
* **Read posts & comments** - anyone
* **Publishing a post or comment** - logged-in users
* **Editing/deleting a post or comment** - original owners of the post


#### URL(s)
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


### Using the API
An example for each available CRUD action is listed below.

#### See all posts - `(GET) /api/v1/posts`

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

#### See one specific post - `(GET) /api/v1/posts/:id`
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
