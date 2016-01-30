require 'rails_helper'

describe Submission do
  it { should have_valid(:body).when('This is a body!') }
  it { should_not have_valid(:body).when(nil, '') }

  it { should have_valid(:comments).when('These are the comments!') }
end
