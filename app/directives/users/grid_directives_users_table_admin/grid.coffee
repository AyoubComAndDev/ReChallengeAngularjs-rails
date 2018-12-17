@app.directive 'grid' , ->
  restrict: 'E'
  replace: true
  templateUrl: "template/users/users_table_admin.html"
  controller: ($scope,$http)->
    $scope.$on('ready-to-render',(e, rows, cols, pagesUsers)->
      $scope.rows = rows
      $scope.cols = cols
      $scope.pagesUsers = pagesUsers
      )
    $scope.reloadUserPage = (p)->
      $scope.ActivePageUser = p
      $http.get('/GetAllUsers/'+p).then (res) ->
        $scope.rows = res.data.data
      ,(error)->
        console.log error,'page users not found'
