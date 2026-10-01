# frozen_string_literal: true

require 'thor'
require_relative 'doctor'
require_relative 'sync'
require_relative 'status'
require_relative 'log'

module CLI
  class Commands < Thor
    desc 'doctor', 'Check Hare dependencies'

    def doctor
      Doctor.new.call
    end

    desc 'sync', 'Update the SVN working copy'

    def sync
      Sync.new.call
    end

    desc 'status', 'Show the SVN working copy status'

    def status
      Status.new.call
    end

    desc 'log', 'Show the SVN commit history'

    def log
      Log.new.call
    end
  end
end
