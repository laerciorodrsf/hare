# frozen_string_literal: true

require 'thor'
require_relative 'doctor'

module CLI
  class Commands < Thor
    desc 'doctor', 'Check Hare dependencies'

    def doctor
      Doctor.new.call
    end
  end
end
