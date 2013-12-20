#= require_self

# Creates new Angular module called 'Blog'
Blog = angular.module('Blog', ['ngRoute'])

# Sets up routing
Blog.config(['$routeProvider', ($routeProvider) ->
  # Route for '/post'
  $routeProvider.when('/post/:postId', { templateUrl: '../assets/home/post.html', controller: 'PostCtrl' } )

  # Default
  $routeProvider.otherwise({ templateUrl: '../assets/home/index.html', controller: 'IndexCtrl' } )

])
