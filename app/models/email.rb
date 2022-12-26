class Email < ApplicationRecord
    has_many :all_email_receivers ,dependent: :destroy
end
