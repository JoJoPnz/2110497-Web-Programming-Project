class Item < ApplicationRecord
    has_one_attached :picture do |attachable|
        attachable.variant :thumb100, resize_to_limit: [100, 100]
        attachable.variant :thumb75, resize_to_limit: [75, 75]
    end
end
