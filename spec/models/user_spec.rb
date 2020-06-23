require "rails_helper"

RSpec.describe User, type: :model do
    context "Validation for user" do
        let(:user){User.new(email: "testing@testing.com", name:"testing",password: "foobar")}

        it "Should be valid if username has email/name/password field completed password 6+" do
            expect(user).to  be_valid

        end
        it "Should be invalid if password is less than 6 chars" do
            user.password = "fooba"
            expect(user).not_to be_valid
        
        end

        it "Should be invalid if email is blank" do
            user.email = " "
            expect(user).not_to be_valid
        
        end

        it "Should be invalid if name is blank" do
            user.name = " "
            expect(user).not_to be_valid
        
        end

        it "Should be invalid if name is 20+ is blank" do
            user.name = "f" * 21
            expect(user).not_to be_valid
        
        end


    end

    context "Assocs for User" do
        it {should have_many(:posts)}
        it {should have_many(:comments)}
        it {should have_many(:likes)}
        it {should have_many(:friendships).with_foreign_key('user_id other_user_id')}
    end
end