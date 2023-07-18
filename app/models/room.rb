class Room < ApplicationRecord
    mount_uploader :room_image, RoomImageUploader
    belongs_to :user

    validates :name, presence: true
    validates :introduction, presence: true
    validates :price, presence: true
    validates :address, presence: true

end
