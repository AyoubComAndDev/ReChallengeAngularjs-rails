@app.directive 'gridColumns' , ->
  restrict: 'E'
  require: ['^gridScreen', 'gridColumns']
  controller: ->
    columns = []
    addColumn: (col) ->
      columns.push(col)
    getColumns: ->
      return columns
  link: (scope, element, attributes, controllers) ->
    gridScreenCtrl = controllers[0]
    gridColumnsCtrl = controllers[1]
    gridScreenCtrl.setColumns(gridColumnsCtrl.getColumns())
    console.log 'linked gridColumns'
