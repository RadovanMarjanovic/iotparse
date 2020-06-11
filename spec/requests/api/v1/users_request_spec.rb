require 'rails_helper'

RSpec.describe User, type: :request do
  let(:user_params) { {email: 'john.joe@iotparse.com', first_name: 'John', last_name: 'Joe', password: 'asdDEF123#', password_confirmation: 'asdDEF123#'} }


  describe "#create" do
    it 'should create a new user' do
      expect { post "/api/v1/users", params: {user: user_params} }.to change { User.count }.by(1)
    end
  end

  context 'when user is created' do
    before do
      @user_to_update= User.create(user_params)
    end

    describe "#update" do

      it 'schould update the user' do
        token = JsonWebToken.encode(user_id: @user_to_update.id)
        put "/api/v1/users/#{@user_to_update.id}", params: { user: { first_name:"Updated Name" }}, headers: {  HTTP_AUTHORIZATION: "Bearer #{token}", accept: "application/json" }
        updated_user = User.find(@user_to_update.id)
        expect(updated_user.first_name).to eq("Updated Name")
      end

      it 'should return unauthorized error if wrong user' do
        user2 = User.create( {email: 'rob.robertson@iotparse.com', first_name: 'Rob', last_name: 'Robertson', password: 'asdDEF123#', password_confirmation: 'asdDEF123#'} )
        token_user1 = JsonWebToken.encode(user_id: @user_to_update.id)
        expect {put "/api/v1/users/#{user2.id}", params: { user: { first_name:"Marc" } }, headers: {  HTTP_AUTHORIZATION: "Bearer #{token_user1}", accept: "application/json" } }.to raise_error("Unauthorized user")
      end
    end

    describe 'full_name' do
      it 'should return a full name' do
        expect(@user_to_update.full_name).to eq("John Joe")
      end
    end
  end
end
