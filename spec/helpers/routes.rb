module RSpecHelpers
  module Routes
    (100..999).each do |code|
      define_method("expect_#{code}".to_sym) do
        expect(last_response.status).to eq(code)
      end
    end

    def last_json
      JSON.parse(last_response.body)['body']
    end

    def post_json(handler, json)
      post handler, json.to_json, 'CONTENT_TYPE' => 'application/json'
    end

    def delete_json(handler, json)
      delete handler, json.to_json, 'CONTENT_TYPE' => 'application/json'
    end

    def put_json(handler, json)
      put handler, json.to_json, 'CONTENT_TYPE' => 'application/json'
    end
  end
end
