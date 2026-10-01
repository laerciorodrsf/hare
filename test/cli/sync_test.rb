# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/mock'
require_relative '../../lib/cli/sync'

module UI
  class SyncTest < Minitest::Test
    def setup
      @sync = UI::Sync.new
    end

    def clean_output(output)
      output.gsub(/\e\[[0-9;]*m/, '')
    end

    def test_up_to_date
      result = {
        success: true,
        output: "Updating '.':\nAt revision 9.\n"
      }

      output = capture_io do
        @sync.print(result)
      end

      expected = <<~OUTPUT
        🐇 Hare Sync

        ✓ Working copy is up to date

          revision 9
      OUTPUT

      assert_equal expected, clean_output(output.first)
    end

    def test_updated
      result = {
        success: true,
        output: <<~SVN
          Updating '.':
          U    README.md
          A    novo.rb
          Updated to revision 10.
        SVN
      }

      output = capture_io do
        @sync.print(result)
      end

      expected = <<~OUTPUT
        🐇 Hare Sync

        ✓ Working copy updated

          U    README.md
          A    novo.rb

        Updated to revision 10.
      OUTPUT

      assert_equal expected, clean_output(output.first)
    end

    def test_updated_with_conflicts
      result = {
        success: true,
        output: <<~SVN
          Updating '.':
          C    README.md
          Summary of conflicts:
            Text conflicts: 1
          Updated to revision 9.
        SVN
      }

      output = capture_io do
        @sync.print(result)
      end

      expected = <<~OUTPUT
        🐇 Hare Sync

        ⚠ Working copy updated with conflicts

          C    README.md

          Summary of conflicts:
            Text conflicts: 1

        Updated to revision 9.
      OUTPUT

      assert_equal expected, clean_output(output.first)
    end

    def test_error
      result = {
        success: false,
        output: "svn: E155007: '/tmp/test' is not a working copy"
      }

      output = capture_io do
        @sync.print(result)
      end

      expected = <<~OUTPUT
        🐇 Hare Sync

        ✗ Unable to update working copy

        svn: E155007: '/tmp/test' is not a working copy
      OUTPUT

      assert_equal expected, clean_output(output.first)
    end
  end
end
