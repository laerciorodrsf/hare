# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/mock'
require_relative '../../lib/cli/sync'

module CLI
  class SyncTest < Minitest::Test
    def setup
      @fake_svn = Minitest::Mock.new
    end

    def test_sync
      @fake_svn.expect(:update, {
                         success: true,
                         output: 'Updated to revision 2.'
                       })

      output = capture_io do
        CLI::Sync.new(svn: @fake_svn).call
      end

      clean_output = output.first.gsub(/\e\[[0-9;]*m/, '')

      assert_equal "Updated to revision 2.\n", clean_output

      @fake_svn.verify
    end
  end
end
