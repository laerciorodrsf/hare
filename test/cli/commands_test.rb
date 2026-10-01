# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../../lib/cli/commands'

module CLI
  class CommandsTest < Minitest::Test
    def test_doctor
      output = capture_io do
        CLI::Commands.new.invoke(:doctor)
      end

      assert_includes output.first, 'SVN'
    end
  end
end
