@IndexCtrl = ($scope, $location, $http) ->
  
  # befour load
  $scope.data = 
    posts: [{title: 'Now Loading', contents: 'Loading posts...'}]

  # loadPosts
  $scope.loadPosts = (postId) ->
    $http.get('./posts.json').success( (data) ->
      $scope.data.posts = data
    ).error( ->
    )
  $scope.loadPosts()

  # --------------------------------------------------
  # func
  $scope.viewPost = (postId) ->
    $location.url('/post/'+postId)
