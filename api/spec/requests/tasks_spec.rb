# spec/integration/tasks_spec.rb
require 'swagger_helper'

RSpec.describe 'Tasks API', type: :request do
  path '/api/tasks' do
    get 'Retrieves all tasks' do
      tags 'Tasks'
      produces 'application/json'

      response '200', 'tasks found' do
        schema type: :array, items: {
          type: :object,
          properties: {
            id: { type: :integer },
            name: { type: :string },
            due_date: { type: :string, format: :'date-time' },
            is_completed: { type: :boolean },
            created_at: { type: :string, format: :'date-time' },
            updated_at: { type: :string, format: :'date-time' }
          },
          required: [ 'id', 'name', 'is_completed', 'created_at', 'updated_at' ]
        }

        before do
          create_list(:task, 2)
        end

        run_test!
      end
    end

    post 'Creates a task' do
      tags 'Tasks'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :task, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          due_date: { type: :string, format: :'date-time' }
        },
        required: ['name']
      }

      response '201', 'task created' do
        let(:task) { { name: 'New Task', due_date: '2024-05-20T12:00:00Z' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:task) { { name: '', due_date: 'invalid-date' } }
        run_test!
      end
    end
  end

  path '/api/tasks/{id}' do
    parameter name: :id, in: :path, type: :string

    put 'Updates a task' do
      tags 'Tasks'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :task, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          due_date: { type: :string, format: :'date-time' }
        },
        required: ['name']
      }

      response '200', 'task updated' do
        let(:id) { create(:task).id }
        let(:name) { 'Updated Task' }
        run_test!
      end

      response '404', 'task not found' do
        let(:id) { 'invalid' }
        let(:name) { 'Updated Task' }
        run_test!
      end

      response '422', 'invalid request' do
        let(:id) { create(:task).id }
        let(:name) { '' }
        run_test!
      end
    end

    delete 'Deletes a task' do
      tags 'Tasks'
      produces 'application/json'

      response '204', 'task deleted' do
        let(:id) { create(:task).id }
        run_test!
      end

      response '404', 'task not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end

  path '/api/tasks/complete/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    post('completes a task') do
      tags 'Tasks'
      let(:id) { '123' }
      response(200, 'successful') do

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/api/tasks/undo_complete/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    post('undo the completion of a task') do
      tags 'Tasks'
      let(:id) { '123' }
      response(200, 'successful') do

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end
