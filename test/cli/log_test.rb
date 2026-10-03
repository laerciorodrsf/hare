# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../../lib/cli/log'

module CLI
  class LogTest < Minitest::Test
    def setup
      @fake_svn = Minitest::Mock.new
    end

    def test_log
      @fake_svn.expect(:log, {
                         success: true,
                         output: "------------------------------------------------------------------------\nr2 | laercio | 2026-10-01 | update README"
                       })

      output = capture_io do
        CLI::Log.new(svn: @fake_svn).call
      end

      clean_output = output.first.gsub(/\e\[[0-9;]*m/, '')

      expected = <<~OUTPUT
        🐇 Hare Log
        ------------------------------------------------------------------------
        r2 | laercio | 2026-10-01 | update README
      OUTPUT

      assert_equal expected, clean_output

      @fake_svn.verify
    end
  end
end
