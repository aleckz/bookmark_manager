feature 'Adding tags' do

  scenario 'I can add a single tag to a new link' do
    visit '/links/new'
    fill_in 'url',   with: 'http://www.makersacademy.com/'
    fill_in 'title', with: 'Makers Academy'
    fill_in 'tags', with: 'education' #single tag for now
    click_button 'Create Link'
    link = Link.first
    expect(link.tags).to include('education')
  end  

end