require 'swagger_helper'

RSpec.describe 'api/users', type: :request do
  path '/users' do
    post 'Creates a user' do
      tags 'User'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string }
        },
        required: [ 'name' ]
      }

      response '201', 'user created' do
        let(:user) { { name: 'taru' } }
        run_test!
      end
    end

    get 'List all users' do
      tags 'Users'
      consumes 'application/json'

      response '201', 'user created' do
        run_test!
      end
    end
  end

  path '/users/{id}' do
    get 'Retrieves a user' do
      tags 'User'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response '200', 'user found' do
        schema type: :object,
          properties: {
            id: { type: :integer }
          },
          required: [ 'id' ]

        let(:id) { Blog.create(name: 'test-user').id }
        run_test!
      end

      response '404', 'user not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end
