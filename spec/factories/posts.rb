FactoryBot.define do
  
  factory :post do
    date { Date.today }
    rationale { "Some rationale" }
    user
  end

  factory :second_post, class: "Post" do
    date { Date.yesterday }
    rationale { "Some second content" }
    user
  end

  factory :third_post, class: "Post" do
    date { Date.yesterday }
    rationale { "Some third content" }
    user
  end
end