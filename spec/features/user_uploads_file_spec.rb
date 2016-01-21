require "rails_helper"

feature "assignment" do

  let!(:user) { FactoryGirl.create(:user, role: "Teacher") }

  scenario "user uploads an assignment" do
    login_as(user, scope: :user)
    visit assignments_path
    click_link "Add New Assignment"

    fill_in "Title", with: "Noodles!"
    attach_file "File", "#{Rails.root}/spec/support/PDFs/sample1.pdf"
    click_button "Add Assignment"

    expect(page).to have_content("Assignment added successfully")
    expect(page).to have_content("Noodles!")
  end
end
