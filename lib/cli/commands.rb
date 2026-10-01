# frozen_string_literal: true

require 'thor'
require_relative 'doctor'
require_relative 'sync'
require_relative 'status'

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
  end
end
