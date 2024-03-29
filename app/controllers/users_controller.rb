class UsersController < ApplicationController
    before_action :set_user, only: %i[show edit update destroy]
    before_action :authenticate_user!
    
    def index
        @users = User.all
    end

    def show 
    end

    def home
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        respond_to do |format|
            if @user.save
                format.html{ redirect_to user_url(@user), notice: "User was successfully created."}
            else
                format.html {render :new, status: :unprocessable_entity}
        
            end
        end
    end

    def edit
    
    end

    def update
        respond_to do |format|
            if @user.update(user_params)
                format.html { redirect_to user_url(@user), notice: "User was successfully updated."}
            else
                format.html { render :edit, status: :unprocessable_entity}
            end
        end
    end 

    def destroy
        @user.destroy
        respond_to do |format|
            format.html { redirect_to users_url, notice: "User was successfully destroyed."}
        end
    end
    
    private

    def set_user    
        @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:name, :profession, :address, :contact)
    end
end
