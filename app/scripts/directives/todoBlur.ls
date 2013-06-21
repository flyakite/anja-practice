mod = {}

mod.todoBlur = ->
  (scope, elm, attrs) ->
    elm.bind \blur, ->
      scope.$apply(attrs.todoBlur)

angular.module 'app.todoBlur' [] .directive mod