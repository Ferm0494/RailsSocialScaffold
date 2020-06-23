require 'rails_helper'
RSpec.describe 'Login', type: :feature do
  let(:user) { User.new(email: 'testing@testing.com', name: 'testing', password: 'foobar') }
  scenario 'Valid login' do
    user.save
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
    expect(page).to have_content('Signed in successfully.')
  end

  scenario 'Invalid login' do
    user.save
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'foobaz'
    click_button 'Log in'
    expect(page).not_to have_content('Signed in successfully.')
  end
end
