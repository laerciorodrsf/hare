# frozen_string_literal: true

require 'open3'

module SVN
  class Client
    def installed?
      system('command -v svn > /dev/null 2>&1')
    end

    def version
      stdout, _stderr, status = Open3.capture3('svn', '--version', '--quiet')

      return stdout.strip if status.success?

      nil
    rescue Errno::ENOENT
      nil
    end
  end
end
