# frozen_string_literal: true

require 'pastel'
require_relative '../svn/client'
require_relative 'ui/sync'

module CLI
  class Sync
    def initialize(svn: SVN::Client.new, pastel: Pastel.new)
      @svn = svn
      @pastel = pastel
    end

    def call
      result = @svn.update

      UI::Sync.new.print(result)
    end
  end
end
