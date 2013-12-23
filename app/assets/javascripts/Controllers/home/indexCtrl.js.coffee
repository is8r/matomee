@IndexCtrl = ($scope, $location, $http, $q, $routeParams, postData) ->
  
  $scope.data = postData.data
  $scope.maxPage = 0
  $scope.isLoading = true

  # --------------------------------------------------
  # Create promise to be resolved after posts load
  $scope.loadHandler = () ->
    $scope.isLoading = true
    $scope.pageSize = $scope.data.info.size
    $scope.maxPage = Math.ceil($scope.data.info.all/$scope.pageSize) if !$scope.maxPage
    $scope.currentPage = parseInt($scope.data.info.now - 1)
    $scope.loadPosts = $scope.data.posts.length
    $scope.allPosts = $scope.data.info.all

  $scope.loadMore = () ->
    $scope.isLoading = false
    @deferred = $q.defer()
    @deferred.promise.then($scope.loadHandler)
    postData.loadNextPosts(@deferred)
  $scope.loadMore()

  # # --------------------------------------------------
  # # pager
  # $scope.maxPage = 0
  # $scope.getPager = ->
  #   $scope.pageSize = $scope.data.posts.length
  #   $scope.maxPage = Math.ceil($scope.data.info.all/$scope.pageSize)
  #   $scope.itemSize = $scope.data.info.all
  #   $scope.pages = [0..$scope.maxPage]
  # $scope.onPage = (n) ->
  #   $location.url('/page/' + n)
  # $scope.nextPage = (n) ->
  #   $location.url('/page/' + n)

  # --------------------------------------------------
  # func
  $scope.viewPost = (postId) ->
    $location.url('/post/'+postId)
  
  $scope.createPost = () ->
    $location.url('/post/new')

@IndexCtrl.$inject = ['$scope', '$location', '$http', '$q', '$routeParams', 'postData']


