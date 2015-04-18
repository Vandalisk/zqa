#require 'spec_helper'
require 'rails_helper'

feature 'Create question', %q{
  In order to get answer from community
  As an authenticated user
  I want to be able to ask the question
} do

  given(:user) { create(:user) }

  scenario 'Authenticated user creates the question' do
    #sign_in(user)
    User.create!(email: 'user@test.com', password: '12345678')
    visit new_user_session_path
    fill_in 'Email', with: 'user@test.com'
    fill_in 'Password', with: '12345678'
    click_on 'Log in'

    visit questions_path
    click_on 'Ask question'
    fill_in 'Title', with: 'Test question'
    fill_in 'Text', with: 'text text text'
    click_on 'Create'
=begin
    visit '/questions'
    click_on 'Ask question'
    fill_in 'Title', with: 'Test question'
    fill_in 'Text', with: 'text text text'
    click_on 'Create'
=end
    expect(page).to have_content 'Your question successfully created.'
  end

  scenario 'Non-authenticated user try to create question' do
    #visit '/questions'
    visit questions_path
    click_on 'Ask question'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end