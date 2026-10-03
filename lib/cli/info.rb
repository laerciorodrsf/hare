# frozen_string_literal: true

require_relative '../svn/client'
require_relative 'ui/info'

module CLI
  class Info
    def initialize(svn: SVN::Client.new)
      @svn = svn
    end

    def call
      result = @svn.info

      UI::Info.new.print(result)
    end
  end
end
