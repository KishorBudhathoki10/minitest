require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!

require_relative "todo_list"

class TodoListTest < Minitest::Test
  def setup
    @todo1 = Todo.new('Buy milk')
    @todo2 = Todo.new('Clean room')
    @todo3 = Todo.new('Go to gym')
    @todos = [@todo1, @todo2, @todo3]

    @list = TodoList.new("Today's Todos")
    @list.add(@todo1)
    @list.add(@todo2)
    @list.add(@todo3)
  end

  def test_to_a
    assert_equal(@todos, @list.to_a)
  end

  def test_size
    assert_equal(@todos.size, @list.size)
  end

  def test_first
    assert_equal(@todos.first, @list.first)
  end

  def test_last
    assert_equal(@todo3, @list.last)
  end

  def test_shift
    assert_equal(@todo1, @list.shift)
    assert_equal([@todo2, @todo3], @list.to_a)
  end

  def test_pop
    assert_equal(@todo3, @list.pop)
    assert_equal([@todo1, @todo2], @list.to_a)
  end

  def test_done_question
    assert_equal(false, @list.done?)
  end

  def test_raise_type_error
    assert_raises(TypeError) do
      @list << 'hello'
    end
  end

  def test_shovel
    todo = Todo.new('Code 3 hours')
    assert_includes(@list << todo, todo)
  end

  def test_aliases
    todo1 = Todo.new('Code 3 hours')
    assert_equal(@todos << todo1, @list.add(todo1).to_a)
  end

  def test_item_at
    assert_raises(IndexError) do
      @list.item_at(4)
    end
    assert(@list.item_at(2))
  end

  def test_mark_done_at
    assert_raises(IndexError) { @list.mark_done_at(5) }
    @list.mark_done_at(0)
    assert_equal(true, @list.first.done?)
  end

  def test_mark_undone_at
    assert_raises(IndexError) { @list.mark_undone_at(5) }
    @list.done!
    @list.mark_undone_at(0)

    assert_equal(false, @list.first.done?)
    assert_equal(true, @list.last.done?)
  end

  def test_done_bang
    @list.done!
    assert_equal(true, @todo1.done?)
    assert_equal(true, @todo2.done?)
    assert_equal(true, @todo3.done?)
    assert_equal(true, @list.done?)
  end

  def test_remove_at
    assert_raises(IndexError) { @list.remove_at(5) }
    @list.remove_at(0)
    assert_equal([@todo2, @todo3], @list.to_a)
  end

  def test_to_s
    output = <<-OUTPUT.chomp.gsub(/^\s+/, "")
    --- Today's Todos ---
    [ ] Buy milk
    [ ] Clean room
    [ ] Go to gym
    OUTPUT

    assert_equal(output, @list.to_s)
  end

  def test_to_s_when_one_todo_is_done
    @todo1.done!
    output = <<-OUTPUT.chomp.gsub(/^\s+/, '')
    --- Today's Todos ---
    [X] Buy milk
    [ ] Clean room
    [ ] Go to gym
    OUTPUT

    assert_equal(output, @list.to_s)
  end

  def test_to_s_when_all_todos_are_done
    @list.done!
    output = <<-OUTPUT.chomp.gsub(/^\s+/, '')
    --- Today's Todos ---
    [X] Buy milk
    [X] Clean room
    [X] Go to gym
    OUTPUT

    assert_equal(output, @list.to_s)
  end

  def test_each
    @list.each(&:done!)
    assert_equal(true, @todo1.done?)
    assert_equal(true, @todo2.done?)
    assert_equal(true, @todo3.done?)
  end

  def test_each_returns_original_list
    todos = @list.each { |_| nil }.object_id
    assert_equal(todos, @list.object_id)
  end

  def test_select
    @todo1.done!
    @todo2.done!
    done_todos = @list.select(&:done?)
    assert_instance_of(TodoList, done_todos)
    assert_equal(done_todos.to_a, [@todo1, @todo2])
  end

  def todo_not_done_question
    assert_equal(false, @todo1.not_done?)
  end

  def test_find_by_title
    todo = @list.find_by_title('Buy milk')
    assert_equal(todo, @todo1)
  end
end
