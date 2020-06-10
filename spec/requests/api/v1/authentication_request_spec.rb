require 'rails_helper'

RSpec.describe "Api::V1::Authentications", type: :request do
  context 'Login action' do
    describe 'not authorized' do
      it 'expects response to return unauthorized http status' do
        post '/api/v1/auth/login', params: { email: 'wronguser@iotparse.com', password: 'pass123'}
        expect(response).to have_http_status(:unauthorized)
      end
    end

    describe 'authorized' do
      before do
        user = {email: 'john.joe@iotparse.com', first_name: 'John', last_name: 'Joe', password: 'asdDEF123#', password_confirmation: 'asdDEF123#'}
        post "/api/v1/users", params: {user: user}
        post '/api/v1/auth/login', params: { email: 'john.joe@iotparse.com', password: 'asdDEF123#'}
      end

      it 'expects response to return ok http status' do
        expect(response).to have_http_status(:ok)
      end
    end
end
end


# Daš mu pravi username in password, in pričakuješ da je talken 
# Če u das napačen pričakuješ da ti vrnee error 
# Če mu dan drugi username, drugi error.
