#= require_self

# Creates new Angular module called 'Posts'
Posts = angular.module('Posts', ['ngRoute'])

# routing
Posts.config(['$routeProvider', ($routeProvider) ->
  $routeProvider
    .when('/post/new', { templateUrl: '../assets/home/create.html', controller: 'CreatePostCtrl' } )
  	.when('/post/:postId', { templateUrl: '../assets/home/post.html', controller: 'PostCtrl' } )

  $routeProvider
  	.otherwise({ templateUrl: '../assets/home/index.html', controller: 'IndexCtrl' } )
])

# model
Posts.factory('postData', ['$http', ($http) ->

  postData =
    data:
      posts: [{title: 'Loading...', contents: ''}]
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

  return postData
])
