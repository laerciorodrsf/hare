# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../../lib/cli/status'

module CLI
  class StatusTest < Minitest::Test
    def setup
      @fake_svn = Minitest::Mock.new
    end

    def test_status
      @fake_svn.expect(:status, {
                         success: true,
                         output: 'M       README.md'
                       })

      output = capture_io do
        CLI::Status.new(svn: @fake_svn).call
      end

      clean_output = output.first.gsub(/\e\[[0-9;]*m/, '')

      assert_equal "M       README.md\n", clean_output

      @fake_svn.verify
    end
  end
end
