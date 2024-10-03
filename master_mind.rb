require_relative 'lib/game'
require_relative 'lib/square'

require 'gosu'

class Mastermind < Gosu::Window
  def initialize
    super 1000, 750
    self.caption = 'Mastermind'
    @game = Game.new(self)
  end

  def draw
    @game.draw
  end

  def needs_cursor?
    true
  end

  def button_down(id)
    return unless id == Gosu::MsLeft

    @game.handle_mouse_down(mouse_x, mouse_y)
  end
end

Mastermind.new.show if __FILE__ == $0
