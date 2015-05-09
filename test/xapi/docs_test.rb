require './test/test_helper'
require 'xapi/docs'

class DocsTest < Minitest::Test
  def language
    "fake"
  end

  def dir
    './test/fixtures/'
  end

  def test_files
    docs = Xapi::Docs.new(language, dir)
    files = {
      "HELLO.md" => "## Creating your first module\n",
      "RESOURCES.md" => "## Reading resources\n",
      "INSTALLATION.md" => "## Installing Z\n",
      "TOOLS.md" => "## Lint tools\n",
      "WORKFLOW.md" => "## Running tests\n",
    }

    assert_equal files, docs.files
  end

  def test_files_for_unknown_language
    docs = Xapi::Docs.new("whatever", dir)

    assert_empty docs.files
  end

  def test_available
    docs = Xapi::Docs.new(language, dir)

    assert docs.available?
  end

  def test_available_for_unknown_language
    docs = Xapi::Docs.new("another", dir)

    refute docs.available?
  end

  def test_available_for_non_existent_dir
    docs = Xapi::Docs.new(language, "another")

    refute docs.available?
  end
end
