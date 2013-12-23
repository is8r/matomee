@IndexCtrl = ($scope, $location, $http, $q, $routeParams, postData) ->
  
  $scope.data = postData.data
  $scope.maxPage = 0
  $scope.isLoading = true
  $scope.loadFin = false

  # --------------------------------------------------
  # Create promise to be resolved after posts load
  $scope.loadHandler = () ->
    $scope.isLoading = false
    $scope.pageSize = $scope.data.info.size
    $scope.maxPage = Math.ceil($scope.data.info.all/$scope.pageSize) if !$scope.maxPage
    $scope.currentPage = parseInt($scope.data.info.now - 1)
    $scope.loadPosts = $scope.data.posts.length
    $scope.allPosts = $scope.data.info.all
    if $scope.allPosts == $scope.loadPosts
      $scope.loadFin = true

  $scope.loadMore = () ->
    $scope.isLoading = true
    @deferred = $q.defer()
    @deferred.promise.then($scope.loadHandler)
    postData.loadNextPosts(@deferred)
  $scope.loadMore()

  # --------------------------------------------------

  $scope.clickExternalLink = (url) ->
    data =
      new_click:
        url: url
        count: 1
    $http.post('/clicks.json', data).success( (data) ->
      console.log('Successfully created click.')
    ).error( ->
      console.error('Failed to create new click.')
    )

  # --------------------------------------------------

  $scope.initShares = (url) ->
    $scope.gethatena(url)
    $scope.getTwitter(url)
    $scope.getFacebook(url)

  $scope.gethatena = (url) ->
    $.ajax
      url: 'http://api.b.st-hatena.com/entry.count?callback=?'
      dataType: 'jsonp'
      data:
        url: url
      success: (e) ->
        # trace e
        $('li', '.list').each (i, el) ->
          if $(el).data('url') == url
            $('.hatena', el).text e
      error: (e) ->
        trace e
  $scope.getTwitter = (url) ->
    $.ajax
      url: 'http://urls.api.twitter.com/1/urls/count.json'
      dataType: 'jsonp'
      data:
        url: url
      success: (e) ->
        # trace e.count
        $('li', '.list').each (i, el) ->
          if $(el).data('url') == url
            $('.twitter', el).text e.count
      error: (e) ->
        trace e
  $scope.getFacebook = (url) ->
    $.ajax
      url: 'https://graph.facebook.com/'
      dataType: 'jsonp'
      data:
        id: url
      success: (e) ->
        # trace e.shares
        $('li', '.list').each (i, el) ->
          if $(el).data('url') == url
            $('.facebook', el).text e.shares
      error: (e) ->
        trace e

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


