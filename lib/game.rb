require_relative 'square'
require 'gosu'

class Game
  def initialize(window)
    @window = window
    @solution_squares = []
    @guess_squares = []
    @current_guess = []
    @feedback_squares = []
    @current_feedback = []

    @color_cycle = 0
    solution_colors = []
    @code_colors = %i[red green blue yellow fuchsia cyan]
    @remaining_turns = 12
    @screen = 0

    4.times do
      solution_colors.push @code_colors.sample
    end

    (0..3).each do |column|
      @solution_squares.push Square.new(@window, column, 0, solution_colors[column], '')
      @current_guess.push Square.new(@window, column, 13.5, :white, '')
      @current_feedback.push Square.new(@window, 4, @remaining_turns, :black, column)
    end

    @game_title = Square.new(@window, 5, 0, :red, 'MASTERMIND')
    @turn_counter = Square.new(@window, 4, 0, :white, @remaining_turns)
    @enter_button = Square.new(@window, 5, 13.5, :pink, 'Click here to enter guess')
    @rules_title = Square.new(@window, 5, 3, :pink, 'Guess the secret code!')
    @rules = Square.new(@window, 5, 4, :pink, "
      1. Guess the correct colors and
         sequence of a 4 length code

      2. Colors can be repeated

      3. You have 12 tries to get
         the code right
      ")
    @win_screen = Square.new(@window, 1, 4, :green, 'CODE BROKEN')
    @lose_screen = Square.new(@window, 1, 4, :red, 'YOU LOSE...')
  end

  def draw
    @current_guess.each do |square|
      square.draw_square
    end

    @guess_squares.each do |square|
      square.draw_square
    end

    @feedback_squares.each do |square|
      square.draw_feedback
    end

    @game_title.draw_title
    @turn_counter.draw_square
    @enter_button.draw_center
    @rules_title.draw_center
    @rules.draw_rules
    if @screen == 1
      @solution_squares.each do |square|
        square.draw_square
      end
      @win_screen.draw_screen
    elsif @screen == -1
      @solution_squares.each do |square|
        square.draw_square
      end
      @lose_screen.draw_screen
    end
  end

  def handle_mouse_down(x, y)
    column = (x.to_i - 10) / 100
    row = (y.to_i - 10) / 50
    p row
    get_button(column, row)
  end

  def get_button(column, row)
    if column < 4 && row >= 13 && game_done?.zero?
      change_color(column)
    elsif column >= 5 && row >= 13 && game_done?.zero?
      submit_guess
    end
  end

  def change_color(column)
    square = @current_guess[column]
    square.color = @code_colors[square.color_cycle]
    square.color_cycle = (square.color_cycle += 1)
    return if square.color_cycle <= 5

    square.color_cycle = (0)
  end

  def submit_guess
    @current_guess.each do |square|
      temp = square.dup
      temp.row = @remaining_turns
      @guess_squares.unshift temp
    end
    give_feedback
    @remaining_turns -= 1
    @turn_counter.text = (@remaining_turns)
    game_done?
  end

  def game_done?
    solution = @solution_squares.map(&:color)
    guess = @guess_squares[0..3].reverse_each.map(&:color)

    if @remaining_turns.zero?
      @screen = -1
      -1
    elsif solution == guess
      @screen = 1
      1
    else
      0
    end
  end

  def give_feedback
    solution = @solution_squares.map(&:color)
    track_repeats = @solution_squares.map(&:color)
    guess = @guess_squares[0..3].reverse_each.map(&:color)

    (0..3).each do |index|
      if solution[index] == guess[index]
        @current_feedback[index].color = :red
        track_repeats[index] = :black
      elsif track_repeats.any? { |color| color == guess[index] }
        @current_feedback[index].color = :pink
      else
        @current_feedback[index].color = :black
      end
      @current_feedback[index].text = index
    end

    @current_feedback.each do |square|
      temp = square.dup
      temp.row = @remaining_turns
      @feedback_squares.unshift temp
    end
  end
end
# Start of gam
