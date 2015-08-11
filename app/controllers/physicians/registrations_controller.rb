class Physicians::RegistrationsController < Devise::RegistrationsController

  # skip_before_filter :authenticate_user!, only: [:index, :new, :create]

  # def new
  #   @physician = Physician.new
  # end

  # def create
  #   @physician = Physician.new(user_params)

  #   if @physician.save
  #     auto_login(@physician)
  #     redirect_to(physician_path(current_user), notice: 'User was successfully created')
  #   else
  #     render :new, notice: "Try again"
  #   end
  # end

  # def show
  #   @physician = Physician.find(params[:id])
  # end

  # private

  # def user_params
  #   params.require(:physician).permit(:first_name, :last_name, :email, :password, :password_confirmation) 
  # end

end
