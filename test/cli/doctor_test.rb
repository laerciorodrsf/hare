# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/mock'
require_relative '../../lib/cli/doctor'

module CLI
  class DoctorTest < Minitest::Test
    def setup
      @fake_svn = Minitest::Mock.new
    end

    def test_svn_installed
      @fake_svn.expect(:installed?, true)
      @fake_svn.expect(:version, '1.14.5')

      output = capture_io do
        CLI::Doctor.new(svn: @fake_svn).call
      end

      assert_equal "✓ SVN 1.14.5\n", output.first

      @fake_svn.verify
    end
  end
end
