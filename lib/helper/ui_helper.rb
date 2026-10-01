# frozen_string_literal: true

module Helper
  class UIHelper
    def self.pluralize(count, singular)
      count == 1 ? singular : "#{singular}s"
    end
  end
end
