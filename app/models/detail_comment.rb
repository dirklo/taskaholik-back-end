class DetailComment < ApplicationRecord
    belongs_to :author, class_name: "User"
    belongs_to :detail
end
