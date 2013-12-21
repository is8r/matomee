@IndexCtrl = ($scope, $location, $http, postData) ->
  
  # $scope.data = postData

  $scope.data = postData.data
  postData.loadPosts()

  # --------------------------------------------------
  # func
  $scope.viewPost = (postId) ->
    $location.url('/post/'+postId)
  
  $scope.createPost = () ->
    $location.url('/post/new')

@IndexCtrl.$inject = ['$scope', '$location', '$http', 'postData']


