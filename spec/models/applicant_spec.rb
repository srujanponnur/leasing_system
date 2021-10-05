require 'rails_helper'

RSpec.describe Applicant, type: :model do
  before(:all) do
    @user = User.create(email: "rn", user_type: "applicant")
    @applicant = Applicant.new(id: "3", name: "randm", email: "random", password: "random", phone_number: "124566", user_id: @user.id)
    @applicant.save
  end
  it 'checks that a applicant can be created' do
    expect(@applicant).to be_valid
  end
  it 'checks that a applicant can be read' do
    expect(Applicant.find_by_email("random")).to eq(@applicant)
  end
  it 'checks that a applicant can be updated' do
    @applicant.update(:email => "HighInTheSky@ncsu.edu")
    expect(Applicant.find_by_email("HighInTheSky@ncsu.edu")).to eq(@applicant)
  end
  it 'checks that a applicant can be destroyed' do
    @applicant.destroy
    expect(Applicant.count).to eq(0)
  end



end
