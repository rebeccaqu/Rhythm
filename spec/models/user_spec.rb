require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'on_period?' do
    it 'should return most recent daily rhythm' do

      u = User.create({
        first_name: "Rebecca",
        last_name: "Qu",
        email: "Rebecca@bitmaker.com",
        password: "password", 
        password_confirmation: "password"       
        })

      rhythm = instance_double("DailyRhythm", :period => true)
      rhythm2 = instance_double("DailyRhythm", :period => true)

      expect(u).to receive(:daily_rhythms) { [rhythm, rhythm2] }


      #create a user
      #create daily rhythms for that user
      #call on_period on that user and compare result to expected result 
      #@user = User.create(...)
      expect(u.on_period?).to eq(true)
    end

    it 'should return false if user has no daily rhythms' do

    end
  end
end
