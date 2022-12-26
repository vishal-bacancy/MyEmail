class GroupsController < ApplicationController
    before_action :set_group, only: %i[show edit update destroy delete_member]
    before_action :authenticate_user!
    def index 
        @groups = Group.where(user_email: current_user.email)
        respond_to do |format|
            format.html
            format.js
        end
    end

    def show 
    end

    def new
        @users = User.all
        @group = Group.new
    end

    def create
        
        @group = Group.new(group_params)
        @group.user_email = current_user.email
        if @group.save!
            params[:group][:users].each do |a|
                next if a ==""
                @group.users << User.find(a) 
            end
            redirect_to groups_path
        else
            render :new
        end
    end

    def edit
        @users = @group.users
    end

    def update
        if @group.update(group_params)
            redirect_to group_url(@group), notice: "Group was successfully updated."
        else
            render :edit, status: :unprocessable_entity
        end
    end 

    def delete_member
        @group = Group.find(params[:id])
        @group.users.delete(params[:delete_id])
        redirect_to groups_path
    end

    def destroy
        @group.destroy
            redirect_to group_url, notice: "Group was successfully destroyed."

    end
    
    private
    def set_group    
        @group = Group.find(params[:id])
    end

    def group_params
        params.require(:group).permit(:name,:user_email, :user =>[])
    end
end
