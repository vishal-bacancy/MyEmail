class Email < ApplicationRecord
    has_many :all_email_receivers ,dependent: :destroy
    has_many :all_email_favourites, dependent: :destroy
    has_rich_text :description
end
