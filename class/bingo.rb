# ビンゴ機能を表すモジュール
module Bingo
    # カードのサイズ: CARD_SIZE * CARD_SIZE のマス数
    CARD_SIZE = 5
    # 1列につき割り当て数字の範囲
    # B列目(0列目)なら 1 ～ ROW_NUMBER_RANGE => 1 ～ 15
    # I列目(1列目)なら ROW_NUMBER_RANGE + 1 ～ ROW_NUMBER_RANGE * 2 => 16 ～ 30
    ROW_NUMBER_RANGE = 15
    # 真ん中を表す特殊な番号
    FREE = -1
end