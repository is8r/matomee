@PostCtrl = ($scope, $http, $routeParams) ->

  # befour load
  $scope.data = {title: 'Now Loading', contents: 'Loading posts...'}

  # prop
  $scope.postId = $routeParams.postId
  $scope.postJson = '/posts/'+$routeParams.postId+'.json'

  # load
  $scope.loadPosts = (postId) ->
    $http.get($scope.postJson).success( (data) ->
      $scope.data = data
    ).error( ->
    )
  $scope.loadPosts()

