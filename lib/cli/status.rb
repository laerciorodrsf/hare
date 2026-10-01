# frozen_string_literal: true

require 'pastel'
require_relative '../svn/client'
require_relative 'ui/header'

module CLI
  class Status
    def initialize(svn: SVN::Client.new, pastel: Pastel.new)
      @svn = svn
      @pastel = pastel
    end

    def call
      UI::Header.print('Status')

      result = @svn.status

      if result[:success]
        puts @pastel.green(result[:output])
      else
        puts @pastel.red(result[:output])
      end
    end
  end
end
