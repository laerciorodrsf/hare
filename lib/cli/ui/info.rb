# frozen_string_literal: true

require 'pastel'
require_relative 'header'

module UI
  class Info
    def initialize(pastel: Pastel.new)
      @pastel = pastel
    end

    def print(result)
      UI::Header.print('Info')
      puts

      unless result[:success]
        puts @pastel.red('✗ Unable to get repository info')
        puts
        puts result[:output]
        return
      end

      data = parse(result[:output])

      puts "Path:        #{data['Path']}"
      puts "Repository:  #{data['URL']}"
      puts "Revision:    #{data['Revision']}"
      puts "Author:      #{data['Last Changed Author']}"
      puts "Updated:     #{data['Last Changed Date']}"
    end

    private

    def parse(output)
      output.each_line.with_object({}) do |line, result|
        key, value = line.split(':', 2)
        next unless value

        result[key.strip] = value.strip
      end
    end
  end
end
