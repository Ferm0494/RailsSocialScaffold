require 'rails_helper'
RSpec.describe "Friendship Features", type: :feature do
    let(:user1) { User.new(email: 'testing1@testing.com', name: 'testing1', password: 'foobar') }    
    let(:user2) { User.new(email: 'testing2@testing.com', name: 'testing2', password: 'foobar1') }

    scenario 'User can send friendship to an unknown user' do
        user2.save
        user1.save
        visit new_user_session_path
        fill_in 'Email', with: user1.email
        fill_in 'Password', with: user1.password
        click_on 'Log in'
        visit users_path
        expect(page).to have_content("Add as friend")

    end

    scenario 'User can get friendships requests when a user have sent one' do
        user1.save
        user2.save
        friendship1 = Friendship.new(user_id: user1.id, other_user_id: user2.id,status: "Pending")
        friendship2 = Friendship.new(user_id: user2.id, other_user_id: user1.id, status: "Pending")
        friendship1.save
        friendship2.save
        visit new_user_session_path
        fill_in 'Email', with: user1.email
        fill_in 'Password', with: user1.password
        click_on 'Log in'
        visit friendships_path
        expect(page).to have_content("Wants to be your friend")        

    end

end