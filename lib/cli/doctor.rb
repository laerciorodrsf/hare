# frozen_string_literal: true

require 'pastel'
require_relative '../svn/client'
require_relative 'ui/header'

module CLI
  class Doctor
    def initialize(svn: SVN::Client.new, pastel: Pastel.new)
      @svn = svn
      @pastel = pastel
    end

    def call
      UI::Header.print('Doctor')

      if @svn.installed?
        puts @pastel.green("✓ SVN #{@svn.version}")
      else
        puts @pastel.red('✗ SVN not found')
      end
    end
  end
end
