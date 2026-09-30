# frozen_string_literal: true

require_relative '../svn/client'

module CLI
  class Doctor
    def initialize(svn: SVN::Client.new)
      @svn = svn
    end

    def call
      if @svn.installed?
        puts "✓ SVN #{@svn.version}"
      else
        puts '✗ SVN not found.'
      end
    end
  end
end
