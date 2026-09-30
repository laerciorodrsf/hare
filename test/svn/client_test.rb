# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../../lib/svn/client'

module SVN
  class ClientTest < Minitest::Test
    def setup
      @svn = SVN::Client.new
    end

    def test_installed
      assert @svn.installed?
    end

    def test_version
      assert_match(/\A\d+\.\d+\.\d+\z/, @svn.version)
    end
  end
end
