class Room < ApplicationRecord
    def self.ransackable_attributes(auth_object = nil)
        ["name", "address", "introduction"]
    end

    def self.ransackable_associations(auth_object = nil)
        ["user"]
    end


    mount_uploader :room_image, RoomImageUploader
    belongs_to :user

    validates :name, presence: true
    validates :introduction, presence: true
    validates :price, presence: true
    validates :address, presence: true

end
