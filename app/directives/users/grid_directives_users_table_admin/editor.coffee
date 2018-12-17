@app.directive 'withInlineEditor' , ->
  restrict: 'A'
  require: '^gridScreen'
  link: (scope, element, attributes, gridScreenCtrl) ->
    $('#editMsg').hide()
    gridScreenCtrl.setEditor({
      title: 'Editer',
      field: ''
      })
    console.log 'linked withInlineEditor'

@app.directive 'editorInitializer' , ($compile,$templateCache,adminService,$timeout)->
  restrict: 'E'
  templateUrl: 'template/users/editor_initializer_users_table.html'
  controller: ($scope)->
    $scope.changeState = ->
      $scope.editorState = false
    clickButton = true
    $scope.edit = (row) ->
      $scope.editorState = true
      $scope.$broadcast('edit',row) if clickButton is true
      clickButton = false
    $scope.editUser = () ->
      adminService.editUser($scope.row.id,$scope.row).then (res) ->
        $scope.rows = res.data
        $scope.pagesUsers = (num for num in [1..res.total])
        $scope.$broadcast('ready-to-render', $scope.rows, $scope.cols , $scope.pagesUsers)
        $scope.editorState = false
        $scope.showMsgValidEditUser = true
        $("#editMsg").show("slow")
        $timeout ->
          $('#editMsg').hide(1000)
        ,3000
  link: (scope, element, attributes) ->
    scope.$on('edit', (e,row) ->
      editor = $compile($templateCache.get("template/users/editor.html"))(scope)
      $(editor).insertAfter(element.parents("tr"))
      )
    console.log 'linked editorInitializer'
