require 'rails_helper'
RSpec.describe "Authentication features", type: :feature do
    let(:user) { User.new(email: 'testing@testing.com', name: 'testing', password: 'foobar') }
    let(:post) { Post.new(content: 'Content for post') }

    scenario "User can create posts if it logged in" do
        user.save
        visit new_user_session_path
        fill_in "Email", with:user.email
        fill_in "Password", with: user.password
        click_button "Log in"
        # expect(page).to have_content("Signed in successfully.")
        fill_in "Content" , with: "Great post!"
        click_button "Save"
        expect(page).to have_content("Post was successfully created.")

    end

    scenario "User cant create posts/viewusers/comment if its not logged in" do
        visit root_path
        expect(page).to have_content("You need to sign in or sign up before continuing.")
    end

    scenario "A user can view all users if its logged in" do
        user.save
        visit new_user_session_path
        fill_in "Email", with:user.email
        fill_in "Password", with: user.password
        click_button "Log in"
        # expect(page).to have_content("Signed in successfully.")
        visit users_path
        expect(page).not_to have_content("You need to sign in or sign up before continuing.")
        
    end

    
end