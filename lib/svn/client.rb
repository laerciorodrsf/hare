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

    def update
      stdout, stderr, status = Open3.capture3('svn', 'update')

      {
        success: status.success?,
        output: status.success? ? stdout.strip : stderr.strip
      }
    rescue Errno::ENOENT
      {
        success: false,
        output: 'SVN not found'
      }
    end

    def status
      stdout, stderr, status = Open3.capture3('svn', 'status')

      {
        success: status.success?,
        output: status.success? ? stdout.strip : stderr.strip
      }
    rescue Errno::ENOENT
      {
        success: false,
        output: 'SVN not found'
      }
    end

    def log
      stdout, stderr, status = Open3.capture3('svn', 'log')

      {
        success: status.success?,
        output: status.success? ? stdout.strip : stderr.strip
      }
    rescue Errno::ENOENT
      {
        success: false,
        output: 'SVN not found'
      }
    end

    def diff
      stdout, stderr, status = Open3.capture3('svn', 'diff')

      {
        success: status.success?,
        output: status.success? ? stdout.strip : stderr.strip
      }
    rescue Errno::ENOENT
      {
        success: false,
        output: 'SVN not found'
      }
    end

    def info
      stdout, stderr, status = Open3.capture3('svn', 'info')

      {
        success: status.success?,
        output: status.success? ? stdout.strip : stderr.strip
      }
    rescue Errno::ENOENT
      {
        success: false,
        output: 'SVN not found'
      }
    end
  end
end
