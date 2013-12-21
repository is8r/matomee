@PostCtrl = ($scope, $routeParams, postData) ->

  $scope.data =
    postData: postData.data
    currentPost:
      title: 'Loading...'
      description: ''

  postData.loadPosts()

  $scope.data.postId = $routeParams.postId
  $scope.data.postJson = '/posts/'+$routeParams.postId+'.json'

@PostCtrl.$inject = ['$scope', '$routeParams', 'postData']


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
