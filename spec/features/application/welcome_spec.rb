require 'rails_helper'

RSpec.describe 'welcome page' do
  context 'you go to the main page' do
    it 'displays a title and gihub information' do
      visit '/'

      expect(page).to have_content('Not just Esty, this shop is Z-ESTY!')
      expect(page).to have_content('Github Contributors')
      expect(page).to have_content('Repo Name')
      expect(page).to have_content('Pull Requests')
    end
  end
end
