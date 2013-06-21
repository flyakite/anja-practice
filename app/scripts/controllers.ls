mod = {}

mod.TodoCtrl = <[$scope $location angularFire filterFilter]> ++ (s, $location, angularFire, filterFilter) ->
  url = \https://anja.firebaseio.com/todomvc
  promise = angularFire(url, s, 'todos')

  s.newTodo = ''
  s.editTodo = null
  if $location.path! is ''
    $location.path '/'
  s.location = $location

  promise.then (todos)->
    console.log s.todos
    startWatch(s, filterFilter)

startWatch = (s, filter) ->
  s.$watch(\todos, ->
    console.log s.todos.length
    s.remainingCount = filter(s.todos, completed:false).length
    s.completedCount = s.todos.length - s.remainingCount
    s.allChecked = !s.remainingCount
  , true)
  s.$watch 'location.path()', (path) ->
    s.statusFilter = switch path
      case \/active
         completed: false
      case \/completed
        completed: true
      default
        null  
  

  s.addTodo = ->
    console.log \add
    if !s.newTodo.length
      return
    newTodo = 
      title: s.newTodo
      completed: false
    console.log newTodo
    s.todos.push newTodo
    console.log s.todos
      

    s.newTodo = ''

  s.editTodo = (todo) ->
    s.editedTodo = todo

  s.doneEditing = (todo) ->
    s.editedTodo = null
    if !todo.title
      s.removeTodo(todo)

  s.removeTodo = (todo) ->
    s.todos.splice(s.todos.indexOf(todo), 1)

  s.clearCompletedTodos = ->
    s.todos = s.todos.filter (val) ->
      return !val.completed

  s.markAll = (completed)->
    s.todos.forEach (todo) ->
      todo.completed = completed



angular.module 'app.controllers' ['firebase'] .controller mod
