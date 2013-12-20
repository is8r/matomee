#= require_self

# Creates new Angular module called 'Blog'
Blog = angular.module('Blog', ['ngRoute'])

# Sets up routing
Blog.config(['$routeProvider', ($routeProvider) ->
  # Route for '/post'
  $routeProvider.when('/post/:postId', { templateUrl: '../assets/homePost.html', controller: 'PostCtrl' } )

  # Default
  $routeProvider.otherwise({ templateUrl: '../assets/homeIndex.html', controller: 'IndexCtrl' } )

])
