require 'rails_helper'

describe User do
  it { should have_valid(:role).when('Teacher', 'Student') }
  it { should_not have_valid(:role).when(nil, '', 'Word') }

  it { should have_valid(:first_name).when('Foo') }
  it { should_not have_valid(:first_name).when(nil, '') }

  it { should have_valid(:last_name).when('Bar') }
  it { should_not have_valid(:last_name).when(nil, '') }

  it { should have_valid(:email).when('user@example.com') }
  it { should_not have_valid(:email).when(nil, '', 'user', 'user@com', 'user.com')}

  it "has a matching password confirmation for the password" do
    user = User.new
    user.password = 'password'
    user.password_confirmation = 'wrongpassword'

    expect(user).to_not be_valid
    expect(user.errors[:password_confirmation]).to_not be_blank
  end

  describe "#teacher?" do
    it "is not a teacher if the role is not teacher" do
      user = FactoryGirl.create(:user, role: "Student")
      expect(user.teacher?).to eq(false)
    end

    it "is a teacher if the role is teacher" do
      user = FactoryGirl.create(:user, role: "Teacher")
      expect(user.teacher?).to eq(true)
    end
  end
end
