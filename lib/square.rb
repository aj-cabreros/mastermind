require 'gosu'

class Square
  attr_writer :row
  attr_accessor :color_cycle, :text, :color

  def initialize(window, column, row, color, text)
    @@colors ||= { red:     Gosu::Color.argb(0xaaff0000),
                   green:   Gosu::Color.argb(0xaa00ff00),
                   blue:    Gosu::Color.argb(0xaa0000ff),
                   yellow:  Gosu::Color.argb(0xaaffff00),
                   fuchsia: Gosu::Color.argb(0xaaff00ff),
                   cyan:    Gosu::Color.argb(0xaa00ffff),
                   white:   Gosu::Color.argb(0xaaffffff),
                   grey:    Gosu::Color.argb(0xaa808080),
                   pink:    Gosu::Color.argb(0xaaffc0cb),
                   black:   Gosu::Color.argb(0xaa000000) }
    @@font ||= Gosu::Font.new(36)
    @@title_font ||= Gosu::Font.new(72)
    @@rules_font ||= Gosu::Font.new(28)
    @@screen_font ||= Gosu::Font.new(100)
    @@window ||= window
    @row = row
    @column = column
    @color = color
    @text = text
    @color_cycle = 0
  end

  def draw_title
    return unless @number != 0

    x1 = 10 + @column * 100
    y1 = 10 + @row * 50
    x2 = x1 + 480
    y2 = y1
    x3 = x2
    y3 = y2 + 145
    x4 = x1
    y4 = y3

    c = @@colors[@color]
    @@window.draw_quad(x1, y1, c, x2, y2, c, x3, y3, c, x4, y4, c, 2)
    x_center = x1 + 40
    x_text = x_center - @@font.text_width(1) / 2
    y_text = y1 + 40
    @@title_font.draw("#{@text}", x_text, y_text, 1)
  end

  def draw_screen
    return unless @number != 0

    x1 = 10 + @column * 100
    y1 = 10 + @row * 50
    x2 = x1 + 800
    y2 = y1
    x3 = x2
    y3 = y2 + 200
    x4 = x1
    y4 = y3

    c = @@colors[@color]
    @@window.draw_quad(x1, y1, c, x2, y2, c, x3, y3, c, x4, y4, c, 2)
    x_center = x1 + 80
    x_text = x_center - @@font.text_width(1) / 2
    y_text = y1 + 55
    @@screen_font.draw("#{@text}", x_text, y_text, 1)
  end

  def draw_rules
    return unless @number != 0

    x1 = 10 + @column * 100
    y1 = 10 + @row * 50
    x2 = x1 + 480
    y2 = y1
    x3 = x2
    y3 = y2 + 300
    x4 = x1
    y4 = y3

    c = @@colors[@color]
    @@window.draw_quad(x1, y1, c, x2, y2, c, x3, y3, c, x4, y4, c, 2)
    x_center = x1 + 10
    x_text = x_center - @@font.text_width(1) / 2
    y_text = y1 + 8
    @@rules_font.draw(@text, x_text, y_text, 1)
  end

  def draw_center
    return unless @number != 0

    x1 = 10 + @column * 100
    y1 = 10 + @row * 50
    x2 = x1 + 480
    y2 = y1
    x3 = x2
    y3 = y2 + 45
    x4 = x1
    y4 = y3

    c = @@colors[@color]
    @@window.draw_quad(x1, y1, c, x2, y2, c, x3, y3, c, x4, y4, c, 2)
    x_center = x1 + 75
    x_text = x_center - @@font.text_width(1) / 2
    y_text = y1 + 5
    @@font.draw(@text, x_text, y_text, 1)
  end

  def draw_square
    x1 = 10 + @column * 100
    y1 = 10 + @row * 50
    x2 = x1 + 90
    y2 = y1
    x3 = x2
    y3 = y2 + 45
    x4 = x1
    y4 = y3

    c = @@colors[@color]
    @@window.draw_quad(x1, y1, c, x2, y2, c, x3, y3, c, x4, y4, c, 2)
    x_center = x1 + 40
    x_text = x_center - @@font.text_width(1) / 2
    y_text = y1 + 5
    @@font.draw(@text, x_text, y_text, 1)
  end

  def draw_feedback
    x1 = 10 + 4 * 100
    y1 = 10 + @row * 50
    x2 = x1 + 90
    y2 = y1
    x3 = x2
    y3 = y2 + 45
    x4 = x1
    y4 = y3

    c = @@colors[@color]

    case @text
    when 0 # top-left
      @@window.draw_quad(x1, y1, c, x2 - 45, y2, c, x3 - 45, y3 - 22, c, x4, y4 - 22, c, 2)

    when 1 # top-right
      @@window.draw_quad(x1 + 45, y1, c, x2, y2, c, x3, y3 - 22, c, x4 + 45, y4 - 22, c, 2)

    when 2 # bottom-left
      @@window.draw_quad(x1, y1 + 22, c, x2 - 45, y2 + 22, c, x3 - 45, y3, c, x4, y4, c, 2)

    when 3 # bottom-right
      @@window.draw_quad(x1 + 45, y1 + 22, c, x2, y2 + 22, c, x3, y3, c, x4 + 45, y4, c, 2)
    end
  end
end
