require 'io/console'

class Tetris
  # テトリスのフィールド
  FIELD_WIDTH = 12.freeze
  FIELD_HEIGHT = 22.freeze

  # ミノ
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
  MINO_ANGLE_MAX = MINO_ANGLE.count.freeze
  MINO_WIDTH = 4.freeze
  MINO_HEIGHT = 4.freeze
  MINO_SHAPES = {
    TETRIMINOS['I'] => {
      MINO_ANGLE['ANGLE_0'] => [
        [0, 1, 0, 0],
        [0, 1, 0, 0],
        [0, 1, 0, 0],
        [0, 1, 0, 0],
      ],
      MINO_ANGLE['ANGLE_90'] => [
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [1, 1, 1, 1],
        [0, 0, 0, 0],
      ],
      MINO_ANGLE['ANGLE_180'] => [
        [0, 0, 1, 0],
        [0, 0, 1, 0],
        [0, 0, 1, 0],
        [0, 0, 1, 0],
      ],
      MINO_ANGLE['ANGLE_270'] => [
        [0, 0, 0, 0],
        [1, 1, 1, 1],
        [0, 0, 0, 0],
        [0, 0, 0, 0],
      ],
    },
    TETRIMINOS['O'] => {
      MINO_ANGLE['ANGLE_0'] => [
        [0, 0, 0, 0],
        [0, 1, 1, 0],
        [0, 1, 1, 0],
        [0, 0, 0, 0],
      ],
      MINO_ANGLE['ANGLE_90'] => [
        [0, 0, 0, 0],
        [0, 1, 1, 0],
        [0, 1, 1, 0],
        [0, 0, 0, 0],
      ],
      MINO_ANGLE['ANGLE_180'] => [
        [0, 0, 0, 0],
        [0, 1, 1, 0],
        [0, 1, 1, 0],
        [0, 0, 0, 0],
      ],
      MINO_ANGLE['ANGLE_270'] => [
        [0, 0, 0, 0],
        [0, 1, 1, 0],
        [0, 1, 1, 0],
        [0, 0, 0, 0],
      ],
    },
    TETRIMINOS['S'] => {
      MINO_ANGLE['ANGLE_0'] => [
        [0, 0, 0, 0],
        [0, 1, 1, 0],
        [1, 1, 0, 0],
        [0, 0, 0, 0],
      ],
      MINO_ANGLE['ANGLE_90'] => [
        [0, 1, 0, 0],
        [0, 1, 1, 0],
        [0, 0, 1, 0],
        [0, 0, 0, 0],
      ],
      MINO_ANGLE['ANGLE_180'] => [
        [0, 0, 0, 0],
        [0, 0, 1, 1],
        [0, 1, 1, 0],
        [0, 0, 0, 0],
      ],
      MINO_ANGLE['ANGLE_270'] => [
        [0, 0, 0, 0],
        [0, 1, 0, 0],
        [0, 1, 1, 0],
        [0, 0, 1, 0],
      ],
    },
    TETRIMINOS['Z'] => {
      MINO_ANGLE['ANGLE_0'] => [
        [0, 0, 0, 0],
        [1, 1, 0, 0],
        [0, 1, 1, 0],
        [0, 0, 0, 0],
      ],
      MINO_ANGLE['ANGLE_90'] => [
        [0, 0, 0, 0],
        [0, 0, 1, 0],
        [0, 1, 1, 0],
        [0, 1, 0, 0],
      ],
      MINO_ANGLE['ANGLE_180'] => [
        [0, 0, 0, 0],
        [0, 1, 1, 0],
        [0, 0, 1, 1],
        [0, 0, 0, 0],
      ],
      MINO_ANGLE['ANGLE_270'] => [
        [0, 0, 1, 0],
        [0, 1, 1, 0],
        [0, 1, 0, 0],
        [0, 0, 0, 0],
      ],
    },
    TETRIMINOS['J'] => {
      MINO_ANGLE['ANGLE_0'] => [
        [0, 0, 1, 0],
        [0, 0, 1, 0],
        [0, 1, 1, 0],
        [0, 0, 0, 0],
      ],
      MINO_ANGLE['ANGLE_90'] => [
        [0, 0, 0, 0],
        [1, 1, 1, 0],
        [0, 0, 1, 0],
        [0, 0, 0, 0],
      ],
      MINO_ANGLE['ANGLE_180'] => [
        [0, 0, 0, 0],
        [0, 1, 1, 0],
        [0, 1, 0, 0],
        [0, 1, 0, 0],
      ],
      MINO_ANGLE['ANGLE_270'] => [
        [0, 0, 0, 0],
        [0, 1, 0, 0],
        [0, 1, 1, 1],
        [0, 0, 0, 0],
      ],
    },
    TETRIMINOS['L'] => {
      MINO_ANGLE['ANGLE_0'] => [
        [0, 1, 0, 0],
        [0, 1, 0, 0],
        [0, 1, 1, 0],
        [0, 0, 0, 0],
      ],
      MINO_ANGLE['ANGLE_90'] => [
        [0, 0, 0, 0],
        [0, 0, 1, 0],
        [1, 1, 1, 0],
        [0, 0, 0, 0],
      ],
      MINO_ANGLE['ANGLE_180'] => [
        [0, 0, 0, 0],
        [0, 1, 1, 0],
        [0, 0, 1, 0],
        [0, 0, 1, 0],
      ],
      MINO_ANGLE['ANGLE_270'] => [
        [0, 0, 0, 0],
        [0, 1, 1, 1],
        [0, 1, 0, 0],
        [0, 0, 0, 0],
      ],
    },
    TETRIMINOS['T'] => {
      MINO_ANGLE['ANGLE_0'] => [
        [0, 0, 0, 0],
        [1, 1, 1, 0],
        [0, 1, 0, 0],
        [0, 0, 0, 0],
      ],
      MINO_ANGLE['ANGLE_90'] => [
        [0, 0, 0, 0],
        [0, 1, 0, 0],
        [0, 1, 1, 0],
        [0, 1, 0, 0],
      ],
      MINO_ANGLE['ANGLE_180'] => [
        [0, 0, 0, 0],
        [0, 0, 1, 0],
        [0, 1, 1, 1],
        [0, 0, 0, 0],
      ],
      MINO_ANGLE['ANGLE_270'] => [
        [0, 0, 1, 0],
        [0, 1, 1, 0],
        [0, 0, 1, 0],
        [0, 0, 0, 0],
      ],
    },
  }.freeze
  MINO_TYPE_MAX = MINO_SHAPES.count.freeze

  def initialize
    @field = initialize_field
    reset_mino
  end

  def start
    time = Time.now.to_i

    while true
      # ミノの移動
      # 非同期モードにすることで、キー入力を待たずに処理を進める
      STDIN.raw!
      if IO.select([STDIN], nil, nil, 0)
        input = STDIN.getc
        case input
        when 's'
          @mino_y += 1 unless is_hit?(@mino_x, @mino_y+1, @mino_type, @mino_angle)
        when 'a'
          @mino_x -= 1 unless is_hit?(@mino_x-1, @mino_y, @mino_type, @mino_angle)
        when 'd'
          @mino_x += 1 unless is_hit?(@mino_x+1, @mino_y, @mino_type, @mino_angle)
        when ' '
          unless is_hit?(@mino_x, @mino_y, @mino_type, (@mino_angle + 1) % MINO_ANGLE_MAX)
            @mino_angle = (@mino_angle + 1) % MINO_ANGLE_MAX
          end
        when 'q'
          exit
        end
        # 非同期モードを解除
        STDIN.cooked!
        display
      else
        # 非同期モードを解除
        STDIN.cooked!
      end

      if (time != Time.now.to_i)
        time = Time.now.to_i

        if is_hit?(@mino_x, @mino_y+1, @mino_type, @mino_angle)
          # ミノが着地したらフィールドに固定する
          MINO_HEIGHT.times do |i|
            MINO_WIDTH.times do |j|
              @field[@mino_y + i][@mino_x + j] = 1 if MINO_SHAPES[@mino_type][@mino_angle][i][j] == 1
            end
          end
          # ラインが揃っているかどうかを判定
          (FIELD_HEIGHT-1).times do |i|
            line_fill = true
            1.upto(FIELD_HEIGHT-1) do |j|
              if @field[i][j] == 0
                line_fill = false
                break
              end
            end
            # 揃っているラインがあれば消す
            if line_fill
              @field.delete_at(i)
              @field.unshift(Array.new(FIELD_WIDTH, 0))
              @field[0][0] = 1
              @field[0][-1] = 1
            end
          end
          # 新しいミノを生成
          reset_mino
        else
          @mino_y += 1
        end

        display
      end
    end
  end

  # 初期状態のフィールドを生成
  def initialize_field
    field = Array.new(FIELD_HEIGHT) { Array.new(FIELD_WIDTH, 0) }
    field.each_with_index do |row, i|
      row[0] = 1
      row[-1] = 1
      row.fill(1) if i == FIELD_HEIGHT - 1
    end
    field
  end

  # ミノを生成
  def reset_mino
    @mino_x = 5
    @mino_y = 0
    @mino_type = rand(7) % MINO_TYPE_MAX
    @mino_angle = rand(4) % MINO_ANGLE_MAX
  end

  # 壁や他のミノに当たっているかどうかを判定する
  def is_hit?(_mino_x, _mino_y, _mino_type, _mino_angle)
    MINO_HEIGHT.times do |i|
      MINO_WIDTH.times do |j|
        if MINO_SHAPES[_mino_type][_mino_angle][i][j] == 1
          return true if @field[_mino_y + i][_mino_x + j] == 1
        end
      end
    end
    false
  end

  # 標準出力に描画する
  def display
    display_buffer = Marshal.load(Marshal.dump(@field))

    # fieldから複製したdisplay_bufferにミノを追加
    MINO_HEIGHT.times do |i|
      MINO_WIDTH.times do |j|
        display_buffer[@mino_y + i][@mino_x + j] = 1 if MINO_SHAPES[@mino_type][@mino_angle][i][j] == 1
      end
    end

    # 標準出力をクリア
    puts "\e[H\e[2J"

    # display_bufferを標準出力に描画
    display_buffer.each do |row|
      row.each do |cell|
        cell == 1 ? print('⬛') : print('⬜')
      end
      print("\n")
    end
  end
end

# if __FILE__ == $0
Tetris.new.start
# end


