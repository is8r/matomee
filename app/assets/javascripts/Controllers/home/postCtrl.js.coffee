@PostCtrl = ($scope, $routeParams, postData) ->

  $scope.data =
    postData: postData.data

  postData.loadPosts()

  $scope.data.postId = $routeParams.postId
  $scope.data.postJson = '/posts/'+$routeParams.postId+'.json'

@PostCtrl.$inject = ['$scope', '$routeParams', 'postData']

