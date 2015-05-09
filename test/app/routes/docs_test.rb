require './test/app_helper'
require './test/vcr_helper'

class AppRoutesDocsTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Xapi::App
  end

  def test_error_on_missing_language
    get '/docs/unknown'

    assert_equal 404, last_response.status
    assert_equal '{"error":"Track unknown not found."}', last_response.body
  end

  def test_error_on_nonexistent_documentation
    get '/docs/assembly'

    assert_equal 404, last_response.status
    assert_equal '{"error":"Documentation for Assembly not found."}', last_response.body
  end

  def test_get_docs_for_language
    get '/docs/csharp'
    options = { format: :json, name: 'get_docs_for_language' }
    Approvals.verify(last_response.body, options)
  end
end
