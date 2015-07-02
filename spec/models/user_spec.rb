describe User do 

let!(:user) do
  User.create(email: 'test@test.com', password: '12345',
              password_confirmation: '12345')
end

  it 'authenticates when given a valid email address and password' do
    authenticated_user = User.authenticate(user.email, user.password)
    expect(authenticated_user).to eq user
  end

  it 'does not authenticate when given an incorrect password' do
    not_authenticated_user = User.authenticate(user.email, password: 'notoranges')
    expect(not_authenticated_user).to be_nil
  end

end