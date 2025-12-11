require 'rails_helper'

RSpec.describe UserAccount, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  it 'is valid with all attributes' do
    account = UserAccount.new(
      name: "Kristine Pham",
      email: "klp2157@barnard.edu",
      password: "Password1!"
    )
    expect(account).to be_valid
  end

  it 'is invalid with non-Columbia email' do
    account = UserAccount.new(
      name: "Kristine Pham",
      email: "klp2157@gmail.com",
      password: "Password1!"
    )
    expect(account).not_to be_valid
    expect(account.errors[:email]).to include("must be a valid Columbia or Barnard email address")
  end

  it 'is invalid with Columbia email ending with additional chars' do
    account = UserAccount.new(
      name: "Kristine Pham",
      email: "klp2157@columbia.edu!",
      password: "Password1!"
    )
    expect(account).not_to be_valid
    expect(account.errors[:email]).to include("must be a valid Columbia or Barnard email address")
  end

  it 'is invalid with empty name field' do
    account = UserAccount.new(
      email: "klp2157@columbia.edu",
      password: "Password1!"
    )
    expect(account).not_to be_valid
    expect(account.errors[:name]).to include("can't be blank")
  end

  it 'is invalid with all empty fields' do
    account = UserAccount.new()
    expect(account).not_to be_valid
    expect(account.errors[:name]).to include("can't be blank")
  end

  it 'is invalid if email already exists in database' do
    UserAccount.create!(
      name: "Kristine Pham",
      email: "jd1234@columbia.edu",
      password: "Password1!"
    )
    
    account = UserAccount.new(
      name: "Kristine Pham",
      email: "jd1234@columbia.edu",
      password: "Password1!"
    )
    expect(account).to_not be_valid
    expect(account.errors[:email]).to include("email already exists")
  end

  it 'is invalid with a weak password' do
    account = UserAccount.new(
      name: "Kristine Pham",
      email: "kp1234@columbia.edu",
      password: "weakpassword"  
    )
  
    expect(account).not_to be_valid
    expect(account.errors[:password]).to include("must be a strong password that is at least 8 characters and includes a lowercase letter, an uppercase letter, a number, and a special character")
  end
  
end
