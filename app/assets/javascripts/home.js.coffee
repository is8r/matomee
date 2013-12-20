#= require_self

# Creates new Angular module called 'Posts'
Posts = angular.module('Posts', ['ngRoute'])

# Sets up routing
Posts.config(['$routeProvider', ($routeProvider) ->
  $routeProvider
    .when('/post/new', { templateUrl: '../assets/home/create.html', controller: 'CreatePostCtrl' } )
  	.when('/post/:postId', { templateUrl: '../assets/home/post.html', controller: 'PostCtrl' } )

  $routeProvider
  	.otherwise({ templateUrl: '../assets/home/index.html', controller: 'IndexCtrl' } )

])
