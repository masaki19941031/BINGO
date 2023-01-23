module Bingo
  # ボールを表すクラス
  class Ball
    # 外部に公開するインスタンス変数
    attr_reader :index

    # オブジェクト初期化
    def initialize
      init
    end

    # 初期化処理の実体
    def init
      # 出る番号の範囲は1 ～ 5 * 15
      min_number = 1
      max_number = CARD_SIZE * ROW_NUMBER_RANGE
      # 出る番号一覧をシャッフルしておく
      @numbers = (min_number..max_number).to_a.shuffle
      # 現在出ている番号を指す変数を先頭に初期化
      @index = 0
    end

    # 現在の番号を取得する
    # @return [int]
    def number
      @numbers[@index]
    end

    # 次の番号にすすめる
    def succ
      @index += 1
    end

    # 次の番号があるか？
    # @return [bool]
    def has_next?
      # 現在の位置が番号配列のサイズより小さければ次がある
      @index < @numbers.size
    end
  end
end