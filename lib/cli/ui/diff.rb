# frozen_string_literal: true

require 'pastel'
require_relative 'header'
require_relative '../../helper/ui_helper'

module UI
  class Diff
    SEPARATOR = '─' * 44

    def initialize(pastel: Pastel.new)
      @pastel = pastel
    end

    def print(output)
      @files = 0
      @additions = 0
      @deletions = 0
      @filename = nil
      @revision = nil

      puts @pastel.bold(UI::Header.print('Diff'))

      output.each_line do |line|
        print_line(line)
      end

      print_summary
    end

    private

    def print_line(line)
      case line
      when /^Index: (.+)/
        @files += 1
        @filename = Regexp.last_match(1)
      when /^={5,}$/
        # Ignores SVN separator
      when /^--- .+\(revision (\d+)\)/
        @revision = Regexp.last_match(1)
      when /^\+\+\+ .+\(working copy\)/
        # Ignores: already in print_file_header
      when /^@@/
        print_file_header
        puts @pastel.cyan(line.strip)
        puts
      when /^\+/
        @additions += 1
        puts @pastel.green("+ #{line[1..].chomp}")
      when /^-/
        @deletions += 1
        puts @pastel.red("- #{line[1..].chomp}")
      else
        puts " #{line.chomp}"
      end
    end

    def print_summary
      puts
      puts @pastel.dim(SEPARATOR)

      summary = []

      summary << "#{@files} #{Helper::UIHelper.pluralize(@files, 'file')} changed"
      summary << "#{@additions} #{Helper::UIHelper.pluralize(@additions, 'addition')}"
      summary << "#{@deletions} #{Helper::UIHelper.pluralize(@deletions, 'deletion')}"

      puts summary.join(' . ')
    end

    def print_file_header
      puts
      puts @pastel.bold(@filename)
      puts
      puts "repository: revision #{@revision}"
      puts 'local:      working copy'
      puts
      puts @pastel.dim(SEPARATOR)
    end
  end
end
