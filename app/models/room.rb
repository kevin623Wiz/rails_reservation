class Room < ApplicationRecord
    mount_uploader :room_image, RoomImageUploader
    belongs_to :user
end
