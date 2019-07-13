# This class represents a todo item and its associated
# data: name and description. There's also a "done"
# flag to show whether this todo item is done.
class Todo
  DONE_MARKER = 'X'
  UNDONE_MARKER = ' '

  attr_accessor :title, :description, :done

  def initialize(title, description='')
    @title = title
    @description = description
    @done = false
  end

  def done!
    self.done = true
  end

  def done?
    done
  end

  def not_done?
    !done
  end

  def undone!
    self.done = false
  end

  def to_s
    "[#{done? ? DONE_MARKER : UNDONE_MARKER}] #{title}"
  end
end

class TodoList
  attr_writer :todos

  def initialize(title)
    @title = title
    @todos = []
  end

  def each
    idx = 0
    while idx < todos.length
      yield(todos[idx])
      idx += 1
    end
    self
  end

  def select
    new_object = TodoList.new(title)
    new_object.todos = todos.select do |todo|
      yield(todo)
    end
    new_object
  end

  def find_by_title(title)
    select { |todo| todo.title == title }.first
  end

  def all_done
    select(&:done?)
  end

  def all_not_done
    select(&:not_done?)
  end

  def mark_done(title)
    todos.select { |todo| todo.title == title }.first.done!
  end

  def mark_all_done
    todos.each(&:done!)
  end

  def mark_all_undone
    todos.each(&:undone!)
  end

  def add(todo)
    raise TypeError, "Can only add Todo objects!" if todo.class != Todo
    todos << todo
  end
  alias_method :<<, :add

  def size
    todos.size
  end

  def first
    todos[0]
  end

  def last
    todos[-1]
  end

  def to_a
    todos
  end

  def done?
    todos.all?(&:done?)
  end

  def item_at(idx)
    todos[idx] ? todos[idx] : (raise IndexError)
  end

  def mark_done_at(idx)
    todos[idx] ? todos[idx].done! : (raise IndexError)
  end

  def mark_undone_at(idx)
    todos[idx] ? todos[idx].undone! : (raise IndexError)
  end

  def done!
    todos.each(&:done!)
  end

  def shift
    todos.shift
  end

  def pop
    todos.pop
  end

  def remove_at(idx)
    todos[idx] ? todos.delete_at(idx) : (raise IndexError)
  end

  def to_s
    text = "--- #{title} ---\n"
    text << todos.map(&:to_s).join("\n")
    text
  end

  private

  attr_accessor :title
  attr_reader :todos
end
