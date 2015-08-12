class FriendshipsController < ApplicationController
  
  def create
    @friendship = Friendship.new(friendship_params)
    @friendship.user_id = current_user.id

    if @friendship.save
      redirect_to(user_path(current_user), notice: => 'Friendship request sent!!')
    else
      render('physicians/index'), notice: => "Friendship request failed, try again" 
    end
  end

  def update
    @friendship = Friendship.find(params[:id])
    if @friendship.physician == current_physician && @friendship.update_attributes(accepted: true)
      redirect_to(physician_path(current_physician), notice: => 'Friendship request accepted!!')
    else
      redirect_to(physicians_path(current_physician.id)), notice: => "Friendship request failed, try again" 
    end
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    @friendship.destroy
  end

  private
  def friendship_params 
    params.require(:friendship).permit(:physician_id)
  end

end
