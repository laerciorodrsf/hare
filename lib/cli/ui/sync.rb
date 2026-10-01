# frozen_string_literal: true

require 'pastel'
require_relative 'header'

module UI
  class Sync
    def initialize(pastel: Pastel.new)
      @pastel = pastel
    end

    def print(result)
      UI::Header.print('Sync')
      puts

      unless result[:success]
        print_error(result[:output])
        return
      end

      output = result[:output]

      if up_to_date?(output)
        print_up_to_date(output)
      elsif conflicts?(output)
        print_conflict(output)
      else
        print_updated(output)
      end
    end

    private

    def up_to_date?(output)
      output.match?(/At revision \d+\./)
    end

    def conflicts?(output)
      output.include?('Summary of conflicts:')
    end

    def print_error(output)
      puts @pastel.red('✗ Unable to update working copy')
      puts
      puts output
    end

    def print_up_to_date(output)
      revision = output[/At revision (\d+)\./, 1]

      puts @pastel.green('✓ Working copy is up to date')
      puts
      puts "  revision #{revision}"
    end

    def print_updated(output)
      puts @pastel.green('✓ Working copy updated')
      puts

      print_changes(output)

      print_revision(output)
    end

    def print_conflict(output)
      puts @pastel.yellow('⚠ Working copy updated with conflicts')
      puts

      print_changes(output)

      puts
      puts @pastel.yellow('  Summary of conflicts:')

      print_conflicts(output)

      print_revision(output)
    end

    def print_changes(output)
      output.each_line do |line|
        next if technical_line?(line)
        next if line.strip.empty?
        next if line.include?('conflicts')

        puts "  #{line.chomp}"
      end
    end

    def print_conflicts(output)
      conflicts = output.split('Summary of conflicts:', 2).last
      return unless conflicts

      conflicts.each_line do |line|
        next if line.strip.empty?
        next if line.match?(/Updated to revision \d+\./)

        puts "    #{line.strip}"
      end
    end

    def print_revision(output)
      revision = output[/Updated to revision (\d+)\./, 1]
      return unless revision

      puts
      puts "Updated to revision #{revision}."
    end

    def technical_line?(line)
      line.start_with?(
        'Updating',
        'Updated to revision',
        'Summary of conflicts'
      )
    end
  end
end
