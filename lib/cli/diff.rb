# frozen_string_literal: true

require 'pastel'
require_relative '../svn/client'
require_relative 'ui/header'
require_relative 'ui/diff'

module CLI
  class Diff
    def initialize(svn: SVN::Client.new, pastel: Pastel.new)
      @svn = svn
      @pastel = pastel
    end

    def call
      result = @svn.diff

      if result[:success]
        UI::Diff.new.print(result[:output])
      else
        puts @pastel.red(result[:output])
      end
    end
  end
end
