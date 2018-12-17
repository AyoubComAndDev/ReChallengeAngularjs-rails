@app.directive 'gridColumn' , ->
  restrict: 'E'
  require:'^gridColumns'
  link: (scope, element, attributes, gridColumnsCtrl) ->
    gridColumnsCtrl.addColumn({title: attributes.title,field: attributes.field})
    console.log 'linked gridColumn'
