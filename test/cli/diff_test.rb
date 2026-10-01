# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/mock'
require_relative '../../lib/cli/diff'

module CLI
  class DiffTest < Minitest::Test
    def setup
      @fake_svn = Minitest::Mock.new
    end

    def test_diff
      @fake_svn.expect(:diff, {
                         success: true,
                         output: <<~DIFF
                           Index: README.md
                           ===================================================================
                           --- README.md	(revision 2)
                           +++ README.md	(working copy)
                           @@ -1,2 +1,3 @@
                            # Projeto teste
                           -segunda versão
                           +segunda versão
                           +teste
                         DIFF
                       })

      output = capture_io do
        CLI::Diff.new(svn: @fake_svn).call
      end

      clean_output = output.first.gsub(/\e\[[0-9;]*m/, '')

      expected = <<~OUTPUT
        🐇 Hare Diff

        README.md

        repository: revision 2
        local:      working copy

        ────────────────────────────────────────────
        @@ -1,2 +1,3 @@
         # Projeto teste
        - segunda versão
        + segunda versão
        + teste

        ────────────────────────────────────────────
        1 file changed · 2 additions · 1 deletion
      OUTPUT

      assert_equal expected, clean_output

      @fake_svn.verify
    end
  end
end
