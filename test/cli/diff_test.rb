# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../../lib/cli/diff'

module CLI
  class DiffTest < Minitest::Test
    def setup
      @fake_svn = Minitest::Mock.new
    end

    def test_diff
      @fake_svn.expect(:diff, {
                         success: true,
                         output: "Index: README.md\n===================================================================\n--- README.md\n+++ README.md"
                       })

      output = capture_io do
        CLI::Diff.new(svn: @fake_svn).call
      end

      clean_output = output.first.gsub(/\e\[[0-9;]*m/, '')

      assert_equal(
        "Index: README.md\n===================================================================\n--- README.md\n+++ README.md\n",
        clean_output
      )

      @fake_svn.verify
    end
  end
end
