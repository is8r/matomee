#= require_tree ./common/
#= require_tree ./app/
#= require_tree ./plugin/
#= require_tree ./Controllers/
#= require_tree ./Services/

# Creates new Angular module called 'Posts'
Posts = angular.module('Posts', ['ngRoute'])

# CSRF
Posts.config(["$httpProvider", (provider) ->
  provider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
])

# routing
Posts.config(['$routeProvider', ($routeProvider) ->

  # $locationProvider.html5Mode(true).hashPrefix('!');

  $routeProvider
    # .when('/post/new', { templateUrl: '../assets/home/create.html', controller: 'CreateCtrl' } )
    # .when('/post/:postId', { templateUrl: '../assets/home/post.html', controller: 'PostCtrl' } )
    .when('/page/:pageId', { templateUrl: '../assets/home/index.html', controller: 'IndexCtrl' } )

  $routeProvider
  	.otherwise({ templateUrl: '../assets/home/index.html', controller: 'IndexCtrl' } )
])

# --------------------------------------------------
# --------------------------------------------------
# model
Posts.factory('postData', ['$http', ($http) ->

  postData =
    data:
      posts: []
    isLoadedPages: []
    pageId: 0

  postData.loadNextPosts = (deferred) ->
    postData.pageId++
    if postData.isLoadedPages.indexOf(postData.pageId) == -1
      url = '/posts.json?page=' + postData.pageId
      $http.get(url).success( (data) ->
        if postData.data.posts.length == 0
          postData.data.posts = data[1]
        else
          # postData.data.posts = postData.data.posts.concat(data[1])
          for p in data[1]
            postData.data.posts.push p if postData.data.posts.indexOf(p) == -1
        # # trace data[0].now, postData.data.posts.length

        postData.data.info = data[0]
        postData.isLoadedPages.push data[0].now
        console.log('Successfully loaded posts.')
        if deferred
          deferred.resolve()
      ).error( ->
        console.error('Failed to load posts.')
        if deferred
          deferred.reject('Failed to load posts.')
      )
    else
      if deferred
        deferred.resolve()

  # postData.createPost = (newPost) ->
  #   # Client-side data validation
  #   if newPost.title == '' or newPost.description == '' or newPost.url == ''
  #     alert('Neither the Title nor the Body are allowed to be left blank.')
  #     return false
  #   # Create data object to POST
  #   data =
  #     new_post:
  #       title: newPost.title
  #       description: newPost.description
  #       url: newPost.url
  #   # Do POST request to /posts.json
  #   $http.post('/posts.json', data).success( (data) ->
  #     console.log('Successfully created post.')
  #     # Add new post to array of posts
  #     postData.data.posts.push(data)
  #   ).error( ->
  #     console.error('Failed to create new post.')
  #   )
  #   return true

  return postData
])
