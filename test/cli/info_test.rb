# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/mock'
require_relative '../../lib/cli/info'

module CLI
  class InfoTest < Minitest::Test
    def setup
      @fake_svn = Minitest::Mock.new
    end

    def test_info
      @fake_svn.expect(:info, {
                         success: true,
                         output: <<~SVN
                           Path: .
                           URL: file:///home/user/svn-lab/repo/trunk
                           Revision: 1
                           Last Changed Author: user
                           Last Changed Date: 2026-10-03 12:59:26 -0300
                         SVN
                       })

      output = capture_io do
        CLI::Info.new(svn: @fake_svn).call
      end

      clean_output = output.first.gsub(/\e\[[0-9;]*m/, '')

      expected = <<~OUTPUT
        🐇 Hare Info

        Path:        .
        Repository:  file:///home/user/svn-lab/repo/trunk
        Revision:    1
        Author:      user
        Updated:     2026-10-03 12:59:26 -0300
      OUTPUT

      assert_equal expected, clean_output

      @fake_svn.verify
    end

    def test_info_when_svn_fails
      @fake_svn.expect(:info, {
                         success: false,
                         output: 'svn: E155007: not a working copy'
                       })

      output = capture_io do
        CLI::Info.new(svn: @fake_svn).call
      end

      clean_output = output.first.gsub(/\e\[[0-9;]*m/, '')

      expected = <<~OUTPUT
        🐇 Hare Info

        ✗ Unable to get repository info

        svn: E155007: not a working copy
      OUTPUT

      assert_equal expected, clean_output

      @fake_svn.verify
    end
  end
end
