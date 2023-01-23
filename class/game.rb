module Bingo
  # ビンゴゲームの流れを表すクラス
  class Game
    # オブジェクト初期化
    def initialize
      # カードとボールを作成
      @card = Card.new
      @ball = Ball.new
    end

    # 引いたボールの穴をあける
    def pick_ball
      @card.punch(@ball.number)
    end

    # ゲームをプレイ
    def play
      # カードをボールを初期化
      @card.init
      @ball.init

      # ゲーム終了条件を満たすまで繰り返す
      loop do
        # ボールの番号の穴をあける
        pick_ball
        # ゲーム状況を表示
        print_game

        # 次のボールがなければ終了
        break unless @ball.has_next?
        # またはカードにすべて穴が空いていたら終了
        break if @card.is_complete?

        # 次のボールに移動
        @ball.succ
      end
    end

    # ゲーム状況を表示
    def print_game
      # 現在のボールが何個目かとその番号を表示
      puts "ball[#{@ball.index+1}]:#{@ball.number}"
      # カードの状態を表示
      puts @card.sprint_card
      # 空行
      puts
      # リーチ数を表示
      puts "REACH: #{@card.get_reach}"
      # ビンゴ数を表示
      puts "BINGO: #{@card.get_bingo}"
      # 区切り線を表示
      puts "-" * 4 * CARD_SIZE
    end
  end
end