@IndexCtrl = ($scope, $location, $http, $q, $routeParams, postData) ->
  
  $scope.data = postData.data
  $scope.isLoaderHidden = false
  $scope.currentPage = $routeParams.pageId | 0

  # Create promise to be resolved after posts load
  $scope.prepPostData = ->
    $scope.isLoaderHidden = true
    $scope.getPager()

  @deferred = $q.defer()
  @deferred.promise.then($scope.prepPostData)
  postData.loadPosts(@deferred, $scope.currentPage)

  # --------------------------------------------------
  # pager
  $scope.maxPage = 0
  $scope.getPager = ->
    $scope.pageSize = $scope.data.posts.length
    $scope.maxPage = Math.ceil($scope.data.info.all/$scope.pageSize)
    $scope.itemSize = $scope.data.info.all
    $scope.pages = [0..$scope.maxPage]
  $scope.onPage = (n) ->
    $location.url('/page/' + n)
  $scope.nextPage = (n) ->
    $location.url('/page/' + n)

  # --------------------------------------------------
  # func
  $scope.viewPost = (postId) ->
    $location.url('/post/'+postId)
  
  $scope.createPost = () ->
    $location.url('/post/new')

@IndexCtrl.$inject = ['$scope', '$location', '$http', '$q', '$routeParams', 'postData']


