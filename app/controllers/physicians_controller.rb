class PhysiciansController < ApplicationController

  def index
    @physicians = Physician.all
    
  end

  def show
    @physician = Physician.find(params[:id])
    @friendships = Friendship.where(physician_id: @physician.id)
  end

end