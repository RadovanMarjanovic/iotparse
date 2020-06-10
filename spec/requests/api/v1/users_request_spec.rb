require 'rails_helper'

RSpec.describe User, type: :request do
  let(:user) { {email: 'john.joe@iotparse.com', first_name: 'John', last_name: 'Joe', password: 'asdDEF123#', password_confirmation: 'asdDEF123#'} }

  describe "#create" do
    it 'schould create a new user' do
      expect { post "/api/v1/users", params: {user: user} }.to change { User.count }.by(1)
      puts User.count
    end
  end

  describe "#update" do
    it 'schould update the user' do
      new_user = User.create(user)
      put "/api/v1/users/#{new_user.id}", params: { first_name: "Updated Name" }
      updated_user = User.find(new_user.id)
      expect(updated_user.first_name).to eq("Updated Name")
      # expect { put "/api/v1/users/#{new_user.id}", params: { first_name: "Updated Name" } }.to change { new_user.first_name }.from('John').to('Updated Name')
    end
  end

  describe 'full_name' do
    it 'should return a full name' do
      new_user = User.create(user)
      expect(new_user.full_name).to eq("John Joe")
    end
  end
end
