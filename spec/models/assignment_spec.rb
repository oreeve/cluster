require 'rails_helper'

describe Assignment do
  it { should have_valid(:title).when('This is a title!') }
  it { should_not have_valid(:title).when(nil, '') }

  it { should have_valid(:instructions).when('These are the instructions!') }
  it { should_not have_valid(:instructions).when(nil, '') }

  it { should have_valid(:file).when(File.new("#{Rails.root}/spec/support/PDFs/sample1.pdf")) }
  it { should_not have_valid(:file).when(nil, '') }
end
