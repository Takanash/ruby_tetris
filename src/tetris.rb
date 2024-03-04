require 'io/console'

class Tetris
  attr_accessor :field, :display_buffer, :mino_x, :mino_y
  # テトリスのフィールド
  FIELD_WIDTH = 12.freeze
  FIELD_HEIGHT = 22.freeze

  # ミノ
  # TODO: 別ファイルに移動するかあとで検討
  TETRIMINOS = {
    'I' => 0,
    'O' => 1,
    'S' => 2,
    'Z' => 3,
    'J' => 4,
    'L' => 5,
    'T' => 6,
  }.freeze
  MINO_ANGLE = {
    'ANGLE_0'   => 0,
    'ANGLE_90'  => 1,
    'ANGLE_180' => 2,
    'ANGLE_270' => 3,
  }.freeze
  MINO_ANGLE_MAX = 4.freeze
  MINO_WIDTH = 4.freeze
  MINO_HEIGHT = 4.freeze
  MINO_SHAPES = {
    TETRIMINOS['I'] => {
      MINO_ANGLE['ANGLE_0'] => [
        [0, 1, 0, 0],
        [0, 1, 0, 0],
        [0, 1, 0, 0],
        [0, 1, 0, 0],
      ]
    }
  }

  def initialize
    # TODO: メソッドに定義
    @field = initialize_field

    mino_x = 5
    mino_y = 0
    mino_type = 0
    mino_angle = 0

    # TODO: メソッドに定義
    while true
      # 標準出力をクリア
      puts "\e[H\e[2J"

      # ミノの移動
      # 非同期モードにすることで、キー入力を待たずに処理を進める
      # TODO: メソッドに定義
      STDIN.raw!
      if IO.select([STDIN], nil, nil, 0)
        input = STDIN.getc
        case input
        when 's'
          mino_y += 1
        when 'a'
          mino_x -= 1
        when 'd'
          mino_x += 1
        when 0x20
          mino_angle = (mino_angle + 1) % 4
        end
      end
      # 非同期モードを解除
      STDIN.cooked!

      display_buffer = Marshal.load(Marshal.dump(@field))
      mino_y += 1
      MINO_HEIGHT.times do |i|
        MINO_WIDTH.times do |j|
          display_buffer[mino_y + i][mino_x + j] = 1 if MINO_SHAPES[mino_type][mino_angle][i][j] == 1
        end
      end

      display(display_buffer)
      sleep(1)
    end

  end

  def display(field = @field)
    field.each do |row|
      row.each do |cell|
        cell == 1 ? print('■') : print(' ')
      end
      puts
    end
  end

  def start
  end

  def initialize_field
    field = Array.new(FIELD_HEIGHT) { Array.new(FIELD_WIDTH, 0) }
    field.each_with_index do |row, i|
      row[0] = 1
      row[-1] = 1
      row.fill(1) if i == FIELD_HEIGHT - 1
    end
    field
  end
end

# if __FILE__ == $0
  Tetris.new.start
# end


