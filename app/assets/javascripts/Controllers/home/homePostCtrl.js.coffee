@PostCtrl = ($scope, $http, $routeParams) ->

  # befour load
  $scope.postId = $routeParams.postId
  $scope.postJson = '/posts/'+$routeParams.postId+'.json'

  # load
  loadPosts = ->
    $http.get($scope.postJson).success( (data) ->
      # console.log 'sucess'
      $scope.data = data
    ).error( ->
      # console.log 'error'
    )
  loadPosts()

