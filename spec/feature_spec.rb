# feature tests for the bookmark manager
feature 'Bookmark viewing' do
  before :each do
    trunc_test_database
  end
  scenario 'show all bookmarks' do
    populate_test_database
    visit '/bookmarks'
    expect(page).to have_link('Google', href: 'http://www.google.com')
    expect(page).to have_link('Bing', href: 'http://www.bing.com')
    expect(page).to have_link('Destroyallsoftware',
        href: 'http://www.destroyallsoftware.com')
  end
end

feature 'Add Bookmark' do
  before :each do
    trunc_test_database
  end
  scenario 'input new bookmark' do
    populate_test_database
    visit '/'
    click_button 'add_bookmark'
    fill_in :title, with: 'BBC'
    fill_in :url, with: 'http://www.bbc.co.uk'
    click_button 'submit'
    expect(page).to have_link('BBC', href: 'http://www.bbc.co.uk')
  end
end

feature 'Delete Bookmark' do
  before :each do
    trunc_test_database
  end
  scenario 'removes the bookmark' do
    populate_test_database
    visit '/bookmarks'
    expect(page).to have_link('Google', href: 'http://www.google.com')
    visit '/'
    click_button 'delete_bookmark'
    fill_in :title, with: 'Google'
    click_button 'submit'
    expect(page).not_to have_link('Google', href: 'http://www.google.com')
  end
end
