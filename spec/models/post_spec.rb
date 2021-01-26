require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "creation" do
    before do
      user = User.create(email: 'test@test.com', password: 'asdfasdf', password_confirmation: 'asdfasdf', first_name: 'abdul', last_name: 'azeez')
      @post = Post.create(date: Date.today, rationale: 'Anything here', user_id: user.id)
    end

    it "can be created" do
      expect(@post).to be_valid
    end

    it "cannot be created without date, rationale" do
      @post.date = nil
      @post.rationale = nil
      expect(@post).to_not be_valid
    end
  end
end
