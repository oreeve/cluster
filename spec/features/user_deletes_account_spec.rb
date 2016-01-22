require 'rails_helper'

# As an authenticated user
# I should be able to delete my account
# So that my informatino is no longer retained by the app
#
# Acceptance Criteria
#
# [√] A user should be able to click a button to delete an account
# [√] A user should be a prompted with a confirmation for account deletion
# [√] Once an account is deleted, a user should be logged out and re routed
# =>  to the home page.
# [√] A user should should not exist in the database once their account has
# =>  been deleted.
# [√] All assignments associated with that user are deleted

feature 'User deletes their existing account' do

  let!(:user) { FactoryGirl.create(:user) }

  scenario 'User visits Edit Account page to delete their account' do
    login_as(user, scope: :user)

    visit edit_user_registration_path
    click_button 'Cancel my account'

    expect(page).to have_content "Bye! Your account has been successfully
                                  cancelled."
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button 'Sign In'

    expect(page).to have_content "Invalid email or password."
  end
end
