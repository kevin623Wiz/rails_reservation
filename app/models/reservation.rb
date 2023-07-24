class Reservation < ApplicationRecord
    belongs_to :user
    belongs_to :room

    validates :check_in, presence: true
    validates :check_out, presence: true
    validates :total_people, presence: true, numericality: {only_integer: true, greater_than: 0}
    validate :today_check

    #自作バリデーション（チェックアウト日がチェックイン日以降でないとダメ）

    def today_check
        if check_in != nil && check_out != nil && check_in < Date.today
            errors.add(:check_in, "は本日以降の日付を選択してください")
        end
    end

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
