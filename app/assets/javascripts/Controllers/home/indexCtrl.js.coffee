@IndexCtrl = ($scope, $location, $http, $q, postData) ->
  
  # $scope.data = postData

  $scope.data = postData.data
  $scope.isLoaderHidden = false

  # Create promise to be resolved after posts load
  $scope.prepPostData = ->
    $scope.isLoaderHidden = true
  @deferred = $q.defer()
  @deferred.promise.then($scope.prepPostData)
  postData.loadPosts(@deferred)

  # --------------------------------------------------
  # func
  $scope.viewPost = (postId) ->
    $location.url('/post/'+postId)
  
  $scope.createPost = () ->
    $location.url('/post/new')

@IndexCtrl.$inject = ['$scope', '$location', '$http', '$q', 'postData']


