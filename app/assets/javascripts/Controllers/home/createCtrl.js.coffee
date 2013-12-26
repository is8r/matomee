# @CreateCtrl = ($scope, $location, postData) ->

#   $scope.data = postData.data
#   postData.loadPosts()

#   $scope.formData =
#     title: ''
#     description: ''
#     url: ''

#   $scope.navNewPost = ->
#     $location.url('/post/new')

#   $scope.navHome = ->
#     $location.url('/')
   
#   $scope.createPost = ->
#     # console.log($scope.formData)
#     postData.createPost($scope.formData)

#   $scope.clearPost = ->
#     $scope.formData.title = ''
#     $scope.formData.description = ''
#     $scope.formData.url = ''

# @CreateCtrl.$inject = ['$scope', '$location', 'postData']