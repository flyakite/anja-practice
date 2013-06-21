mod = {}
mod.todoFocus = ->
  (scope, elm, attrs) ->
    scope.watch attrs.todoFocus, (newVal) ->
      if newVal
        $timeout ->
          elm[0].focus!
        ,0 ,false

angular.module 'todoFocus', [], .directive mod