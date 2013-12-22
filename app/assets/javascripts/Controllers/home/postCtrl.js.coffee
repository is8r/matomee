@PostCtrl = ($scope, $routeParams, $location, $q, postData) ->

  $scope.data =
    postData: postData.data
    currentPost:
      title: 'Loading...'
      description: ''
      url: ''

  $scope.data.postId = $routeParams.postId
  $scope.data.postJson = '/posts/'+$routeParams.postId+'.json'

  $scope.prepPostData = ->
    post = _.findWhere(postData.data.posts, { id: parseInt($scope.data.postId) })
    $scope.data.currentPost.title = post.title
    $scope.data.currentPost.description = post.description
    $scope.data.currentPost.url = post.url

  # Create promise to be resolved after posts load
  @deferred = $q.defer()
  @deferred.promise.then($scope.prepPostData)
  postData.loadPosts(@deferred)

@PostCtrl.$inject = ['$scope', '$routeParams', '$location', '$q', 'postData']

