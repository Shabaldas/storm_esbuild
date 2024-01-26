require 'rails_helper'

describe '/static_pages/home', js: true, type: :feature do
  describe 'GET /static_pages/home' do
    it 'shows the static pages' do
      visit root_path
      expect(page).to have_content('Main')
    end
  end
end
