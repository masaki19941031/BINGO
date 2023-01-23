module Bingo
  # カードを表すクラス
  class Card
    # オブジェクト初期化
    def initialize
      init
    end

    # 初期化処理の実体
    def init
      # カード番号の初期化
      @numbers = []
      CARD_SIZE.times do |row|
        # 列ごとに割り当て可能な番号を算出
        # B列(0列)目は1～15 => 0 * 15 + 1 ～ (0 + 1) * 15
        # 他の列も同じ計算式で算出可能
        low_n = row * ROW_NUMBER_RANGE + 1
        high_n = (row + 1) * ROW_NUMBER_RANGE
        # 割当可能な番号配列をランダムで並び替えてCARD_SIZE分取り出してカードに追加
        row_numbers = (low_n..high_n).to_a.shuffle # => [1, 15, 13, ....]
        @numbers[row] = row_numbers.take(CARD_SIZE)
      end
      # 出た番号の記録用ハッシュ
      # ビンゴ確認処理を高速にするためハッシュのキーに番号を記録
      @hits = {}

      # 真ん中はFREE
      # FREEに書き換え
      @numbers[CARD_SIZE/2][CARD_SIZE/2] = FREE
      # 真ん中はすでに出たものとして記録
      @hits[FREE] = true
    end

    # 出た番号を記録する
    # @param [int] n 番号
    def punch(n)
      # 記録用ハッシュに追加
      @hits[n] = true
    end

    # 指定した穴数のラインの数を取得する
    # @param [int] hit_count カウント対象の穴数
    # @return [int]
    def count_line_hole(hit_count)
      # カウント用ローカル変数を初期化
      # 縦方向(列方向): 5列分
      check_v = Array.new(CARD_SIZE, 0)
      # 横方向(行方向): 5行分
      check_h = Array.new(CARD_SIZE, 0)
      # 右下斜め方向
      check_d1 = 0
      # 左下斜め方向
      check_d2 = 0

      # カードの各マスを順番に走査
      CARD_SIZE.times do |row|
        CARD_SIZE.times do |line|
          # マスの数字: @numbers[row][line]
          # 穴が空いていなければ無視
          next unless @hits[@numbers[row][line]]
          # row列目の縦方向のカウントを加算
          check_v[row] += 1
          # line行目の横方向のカウントを加算
          check_h[line] += 1
          # row == line の場合右下斜め方向なのでカウントを加算
          check_d1 += 1 if row == line
          # row + line == CARD_SIZE - 1 の場合右上斜め方向なのでカウントを加算
          check_d2 += 1 if row + line == CARD_SIZE - 1
        end
      end

      # 指定の穴数のラインを数える
      c = 0
      c += check_v.count(hit_count)
      c += check_h.count(hit_count)
      c += 1 if check_d1 == hit_count
      c += 1 if check_d2 == hit_count
      c
    end

    # ビンゴ数を取得する
    # @return [int]
    def get_bingo
      # CARD_SIZE分穴の空いたラインを数える
      count_line_hole(CARD_SIZE)
    end

    # リーチ数を取得する
    # @return [int]
    def get_reach
      # CARD_SIZE-1分穴の空いたラインを数える
      count_line_hole(CARD_SIZE-1)
    end

    # すべて穴があいたか？
    # @return [bool]
    def is_complete?
      # ビンゴ数が列数+行数+斜め2つ分あればコンプリートしている
      get_bingo == CARD_SIZE + CARD_SIZE + 2
    end

    # カードの状況を文字列で返す
    # @return [string]
    def sprint_card
      # 二次元配列を転置(行と列を入れ替え)して読みやすいビンゴカードの形で整形
      @numbers.transpose.map{|row_numbers|
        # 各列の番号配列を文字列に置換して改行で挟んで結合する
        row_numbers.map{|number|
          # マスの番号を文字列化
          # 真ん中はFREE
          next 'FREE' if number == FREE
          # 穴があいていればカッコで囲む
          format = @hits[number] ? '(%02d)' : ' %02d '
          sprintf(format, number)
        }.join
      }.join("\n")
    end
  end
end