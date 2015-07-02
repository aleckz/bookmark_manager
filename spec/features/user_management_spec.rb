feature 'User sign up' do

  def sign_up_as(user)
      visit '/users/new'
      expect(page.status_code).to eq(200)
      # fill_in :username, with: user.username
      # fill_in :name, with: user.name
      fill_in :email,   with: user.email
      fill_in :password, with: user.password
      fill_in :password_confirmation, with: user.password_confirmation
      click_button 'Sign up'
  end

  scenario 'I can sign up as a new user' do
    user = build :user # can't use 'create' here because then the user is already saved in the database and you therefore can't sign up as a new user.
    expect{ sign_up_as(user) }.to change(User, :count).by(1)
    expect(page).to have_content "Welcome, #{user.email}"
    expect(User.first.email).to eq "#{user.email}"
  end

  scenario 'requires a matching confirmation password' do
    user = build(:user, password_confirmation: 'notoranges') # build doesnt save into database automatically
    expect { sign_up_as(user) }.not_to change(User, :count)
    expect(current_path).to eq ('/users')
    expect(status_code).to eq 200
    expect(page).to have_content 'Password does not match the confirmation'
  end

  scenario 'I HAVE to enter an e-mail address' do
    user = build(:user, email: '')
    expect{ sign_up_as(user)}.not_to change(User, :count)
    expect(current_path).to eq ('/users')
    expect(page).to have_content 'Email must not be blank'
  end

  scenario 'I cannot sign up with an existing email' do
    user = create :user
    sign_up_as(user)
    expect { (sign_up_as(user)) }.to change(User, :count).by 0
    expect(page).to have_content 'Email is already taken'
  end

  feature 'User sign in' do
    let(:user) do
      User.create(email: 'user@example.com',
                  password: 'secret1234',
                  password_confirmation: 'secret1234')
      end


    scenario 'with correct credentials - is welcomed' do
      sign_in(email: user.email, password: user.password)
      click_button 'Sign in'
      expect(page).to have_content "Welcome, #{user.email}"
    end

    def sign_in email:, password:
      visit '/sessions/new'
      fill_in :email, with: user.email
      fill_in :password, with: user.password
    end

  end

end