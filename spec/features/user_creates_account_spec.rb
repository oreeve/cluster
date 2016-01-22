require 'rails_helper'

# As a user
# I want to create an account
# So that I can post or read assignments

# Acceptance Criteria
# [√] I must provide a valid email address
# [√] I must provide a password
# [√] I must confirm password
# [√] I must specify whether I am a teacher or a student
# [√] I receive an error message if I do not provide any of the above
# [√] I successfully authenticated if I provide valid information

feature 'User signs up for an account' do
  scenario 'User provides valid information' do
    visit new_user_registration_path

    choose('I am a teacher')
    fill_in 'First name', with: 'Foo'
    fill_in 'Last name', with: 'Bar'
    fill_in 'Email', with: 'foo@bar.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign Up'

    expect(page).to have_content("Welcome! You have signed up successfully")
    expect(page).to have_content("Sign Out")
  end

  scenario 'User does not provide information' do
    visit new_user_registration_path

    click_button 'Sign Up'

    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Password can't be blank")
    expect(page).to_not have_content("Welcome! You have signed up successfully")
  end

  scenario 'password does not match password confirmation' do
    visit new_user_registration_path

    choose('I am a teacher')
    fill_in 'First name', with: 'Foo'
    fill_in 'Last name', with: 'Bar'
    fill_in 'Email', with: 'foo@bar.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'secret'
    click_button 'Sign Up'

    expect(page).to have_content("Password confirmation doesn't match")
  end
end
