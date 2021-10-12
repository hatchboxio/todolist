module TodosHelper
  def todo_class(todo)
    "text-decoration-line-through" if todo.completed_at?
  end
end
