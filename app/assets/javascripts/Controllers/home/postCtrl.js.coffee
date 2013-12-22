@PostCtrl = ($scope, $routeParams, $location, $q, postData) ->

  $scope.data =
    postData: postData.data
    currentPost:
      title: 'Loading...'
      description: ''

  $scope.data.postId = $routeParams.postId
  $scope.data.postJson = '/posts/'+$routeParams.postId+'.json'

  $scope.prepPostData = ->
    post = _.findWhere(postData.data.posts, { id: parseInt($scope.data.postId) })
    $scope.data.currentPost.title = post.title
    $scope.data.currentPost.description = post.description

  # Create promise to be resolved after posts load
  @deferred = $q.defer()
  @deferred.promise.then($scope.prepPostData)
  postData.loadPosts(@deferred)

@PostCtrl.$inject = ['$scope', '$routeParams', '$location', '$q', 'postData']


  # $scope.data.postId = $routeParams.postId

  # postData.loadPosts()

  # $scope.prepPostData = ->
  #   post = _.findWhere(postData.data.posts, { id: parseInt($scope.data.postId) })
  #   $scope.data.currentPost.title = post.title
  #   $scope.data.currentPost.contents = post.contents

  # $scope.navNewPost = ->
  #   $location.url('/post/new')

  # $scope.navHome = ->
  #   $location.url('/')

  # $scope.prepPostData()
