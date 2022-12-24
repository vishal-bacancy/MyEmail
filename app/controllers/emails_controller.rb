class EmailsController < ApplicationController
  before_action :set_email, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  # GET /emails or /emails.json
  def index
    @email_ids= AllEmailReceiver.where(user_id: current_user.id).pluck(:email_id)
    @emails = Email.where(id: @email_ids)
    if params[:search]
      #@emails= @emails.where(['title LIKE ?', "%#{params[:search]}%"])
      @emails= @emails.where('title LIKE :search OR description LIKE :search OR sender LIKE :search', search: "%#{params[:search]}%")
    end
  end

  # GET /emails/1 or /emails/1.json
  def show
  end

  # GET /emails/new
  def new
    @groups = Group.where(user_email: current_user.email)
    @email = Email.new
    @receiver = User.all
  end

  # GET /emails/1/edit
  def edit
    @groups = Group.where(user_email: current_user.email)
    @receiver = User.all
  end

  # POST /emails or /emails.json
  def create
    @email = Email.new(email_params)
    @email.sender = current_user.email
    @email.receiver = params[:email][:receiver].join(",")
    @email.groups = params[:email][:groups].join(",")
    respond_to do |format|
      if @email.save
        @email.receiver.split(",").each do |a|
          next if a== ""
          @email.all_email_receivers.create!(user_id: a.to_i) 
        end
        @email.groups.split(",").each do |a|
          next if a== ""
          Group.find(a.to_i).users.each do |x|
            @email.all_email_receivers.create!(user_id: x.id) 
          end
        end
        format.html { redirect_to email_url(@email), notice: "Email was successfully created." }
        format.json { render :show, status: :created, location: @email }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @email.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /emails/1 or /emails/1.json
  def update
    respond_to do |format|
      if @email.update(email_params)
        format.html { redirect_to email_url(@email), notice: "Email was successfully updated." }
        format.json { render :show, status: :ok, location: @email }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @email.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /emails/1 or /emails/1.json
  def destroy
    @email.destroy

    respond_to do |format|
      format.html { redirect_to emails_url, notice: "Email was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  
  def sent 
    @emails = Email.where(:sender => current_user.email)
  end

  def add_to_favourites
    Email.find(params[:email_id]).all_email_favourites.create!(email_id: params[:email_id],user_id: current_user.id)
    redirect_to emails_path
  end

  def remove_to_favourites
    Email.find(params[:email_id]).all_email_favourites.where(email_id: params[:email_id],user_id: current_user.id).destroy_all
    redirect_to emails_path
  end

  def delete_from_show
    Email.find(params[:email_id]).all_email_receivers.where(email_id: params[:email_id],user_id: current_user.id).destroy_all
    redirect_to emails_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_email
      @email = Email.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def email_params
      params.require(:email).permit(:title, :description, :sender,:is_archived, :is_deleted,:all_receivers,:receiver=>[],:groups=>[])
    end
end
