require 'rails_helper'

RSpec.describe 'navigate' do
  let!(:user) { FactoryBot.create(:user) }

  before do
    login_as(user, :scope => :user)
    visit posts_path
  end

  describe 'index' do

    before do
      post1 = FactoryBot.create(:post, user: user)
      post2 = FactoryBot.create(:second_post, user: user)
    end

    it 'can be reached successfully' do
      expect(page.status_code).to eq(200)
    end

    it 'has a title of Posts' do
      expect(page).to have_content(/Posts/)
    end

    it 'has a list of posts' do
      visit posts_path
      expect(page).to have_content(/rationale|content/)
    end

    it 'has a scope so that only post creators can see their posts' do
      other_user = FactoryBot.create(:non_authorized_user)
      post_from_other_user = FactoryBot.create(:third_post, user: other_user)

      visit posts_path
      expect(page).not_to have_content(/Some third content/)
    end
  end

  describe 'new' do
    it 'has a link from the home page' do
      visit root_path
      
      click_link("new_post_from_nav")
      expect(page.status_code).to eq(200)
    end
  end

  describe 'delete' do
    it 'can be deleted' do
      post = FactoryBot.create(:post, user: user)
      visit posts_path

      click_link("delete_post_#{post.id}_from_index")
      expect(page.status_code).to eq(200)
    end
  end

  describe 'creation' do

    before do
      logout(:user)
      @user = FactoryBot.create(:user)
      login_as(@user, :scope => :user)
      visit new_post_path
    end

    it 'has a new form that can be reached' do
      expect(page.status_code).to eq(200)
    end

    it 'can be created from the new form page' do
      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: "Some rationale"
      click_on "Save"

      expect(page).to have_content("Some rationale")
    end

    it 'will have a user associated with it' do
      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: "User Association"
      click_on "Save"
      
      expect(@user.posts.last.rationale).to eq("User Association")
    end
  end

  describe 'edit' do
    before do
      @post = FactoryBot.create(:post, user: user)
    end

    it 'can be edited' do
      visit edit_post_path(@post)
      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: "Edited Content"
      click_on 'Save'

      expect(page).to have_content("Edited Content")
    end

    it 'cannot be edited by a non authorized user' do
      logout(:user)
      non_authorized_user = FactoryBot.create(:non_authorized_user)
      login_as(non_authorized_user, :scope => :user)

      visit edit_post_path(@post)

      expect(current_path).to eq(root_path)
    end
  end
end