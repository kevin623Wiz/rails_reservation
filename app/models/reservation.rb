class Reservation < ApplicationRecord
    belongs_to :user
    belongs_to :room

    validates :check_in, presence: true
    validates :check_out, presence: true
    validates :total_people, presence: true, numericality: {only_integer: true, greater_than: 0}
    validate :start_end_check

    #自作バリデーション（チェックアウト日がチェックイン日以降でないとダメ）
    def start_end_check
        if check_in == nil
            errors.add(:check_in,"開始日を入力してください")
        elsif check_out == nil
            errors.add(:check_out,"終了日を入力してください")
        elsif check_out < check_in
            errors.add(:check_out,"終了日は開始日以降の日付にしてください")
        end
    end

    #宿泊日数の計算、合計金額の計算
    def total_days
        (self.check_out - self.check_in).to_i
    end

    def total_price
        if self.room_id.present?
            room = Room.find(self.room_id)
            (self.total_days * self.total_people * room.price)
        end
    end

end
