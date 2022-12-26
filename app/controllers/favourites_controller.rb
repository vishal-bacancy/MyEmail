class FavouritesController < ApplicationController
    def index
        @email_ids= AllEmailFavourite.where(user_id: current_user.id).pluck(:email_id)
        @emails = Email.where(id: @email_ids)
    end
end
