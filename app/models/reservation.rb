class Reservation < ApplicationRecord
    belongs_to :user
    belongs_to :room

    validates :check_in, presence: true
    validates :check_out, presence: true
    validates :total_people, presence: true, numericality: {only_integer: true, greater_than: 0}
    validate :start_end_check
    validate :today_check

    #自作バリデーション（チェックアウト日がチェックイン日以降でないとダメ）
    def start_end_check 
        if check_in == nil
            errors.add(:check_in,"チェックインの日付を入力してください") 
        elsif check_out == nil
            errors.add(:check_out,"チェックアウトの日付を入力してください")
        else
            errors.add(:check_out,"はチェックイン以降の日付を選択してください")
        end
    end

    def today_check
        if check_in != nil && check_out != nil && check_in < Date.today
            errors.add(:check_in, "は本日以降の日付を選択してください")
        end
    end

    def total_days
        total_days = (check_out - check_in).to_i
    end

    def total_price
        total_price = (total_days * total_people * room.price)
    end

end
