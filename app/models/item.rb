class Item < ApplicationRecord
    has_one_attached :picture do |attachable|
        attachable.variant :thumb100, resize_to_limit: [100, 100]
    end
end
