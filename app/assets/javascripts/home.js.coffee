#= require_self

# Creates new Angular module called 'Posts'
Posts = angular.module('Posts', ['ngRoute'])

# CSRF
Posts.config(["$httpProvider", (provider) ->
  provider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
])

# routing
Posts.config(['$routeProvider', ($routeProvider) ->
  $routeProvider
    .when('/post/new', { templateUrl: '../assets/home/create.html', controller: 'CreateCtrl' } )
  	.when('/post/:postId', { templateUrl: '../assets/home/post.html', controller: 'PostCtrl' } )

  $routeProvider
  	.otherwise({ templateUrl: '../assets/home/index.html', controller: 'IndexCtrl' } )
])

# model
Posts.factory('postData', ['$http', ($http) ->

  postData =
    data:
      posts: [{
        title: '',
        description: '',
        url: ''
        }]
    isLoaded: false

  postData.loadPosts = ->
    if !postData.isLoaded
      $http.get('/posts.json').success( (data) ->
        postData.data.posts = data
        postData.isLoaded = true
        console.log('Successfully loaded posts.')
      ).error( ->
        console.error('Failed to load posts.')
      )

  postData.createPost = (newPost) ->
    # Client-side data validation
    if newPost.title == '' or newPost.description == '' or newPost.url == ''
      alert('Neither the Title nor the Body are allowed to be left blank.')
      return false

    # Create data object to POST
    data =
      new_post:
        title: newPost.title
        description: newPost.description
        url: newPost.url

    # Do POST request to /posts.json
    $http.post('/posts.json', data).success( (data) ->
      console.log('Successfully created post.')

      # Add new post to array of posts
      postData.data.posts.push(data)

    ).error( ->
      console.error('Failed to create new post.')
    )

    return true

  return postData
])
