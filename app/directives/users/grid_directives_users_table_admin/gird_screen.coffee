@app.directive 'gridScreen' , (adminService)->
  restrict: 'E'
  controller: ($scope)->
    setEditor: (editor) ->
      $scope.cols.unshift(editor)
    setColumns: (cols) ->
      $scope.cols = cols
  link: (scope, element, attributes)->
    adminService.getAllUsers().then (res) ->
      scope.rows = res.data
      scope.pagesUsers = (num for num in [1..res.total])
      scope.$broadcast('ready-to-render', scope.rows, scope.cols , scope.pagesUsers)
    console.log 'linked gridScreen'
