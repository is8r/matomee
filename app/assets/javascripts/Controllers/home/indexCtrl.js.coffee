@IndexCtrl = ($scope, $location, $http, $q, postData) ->
  
  # $scope.data = postData

  $scope.data = postData.data
  $scope.isLoaderHidden = false

  # Create promise to be resolved after posts load
  $scope.prepPostData = ->
    $scope.isLoaderHidden = true
    $scope.getPager()

  @deferred = $q.defer()
  @deferred.promise.then($scope.prepPostData)
  postData.loadPosts(@deferred)

  # --------------------------------------------------
  # pager
  $scope.maxPage = 0
  $scope.getPager = ->
    $scope.currentPage = $scope.data.info.now | 0
    $scope.pageSize = $scope.data.posts.length
    $scope.maxPage = Math.ceil($scope.data.info.all/$scope.pageSize)
    $scope.itemSize = $scope.data.info.all
    $scope.pages = [0..$scope.maxPage]
  $scope.setPage = (n) ->
  $scope.prevPage = ->
  $scope.nextPage = ->

  # --------------------------------------------------
  # func
  $scope.viewPost = (postId) ->
    $location.url('/post/'+postId)
  
  $scope.createPost = () ->
    $location.url('/post/new')

@IndexCtrl.$inject = ['$scope', '$location', '$http', '$q', 'postData']


