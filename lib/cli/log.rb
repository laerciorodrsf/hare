# frozen_string_literal: true

require 'pastel'
require_relative '../svn/client'

module CLI
  class Log
    def initialize(svn: SVN::Client.new, pastel: Pastel.new)
      @svn = svn
      @pastel = pastel
    end

    def call
      result = @svn.log

      if result[:success]
        puts @pastel.green(result[:output])
      else
        puts @pastel.red(result[:output])
      end
    end
  end
end
