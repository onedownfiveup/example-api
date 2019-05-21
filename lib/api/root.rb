# frozen_string_literal: true

require 'pathname'

module Example
  module API
    ROOT = Pathname.new(__dir__).ascend.detect do |dir|
      dir.basename.to_s == 'lib'
    end.parent.expand_path.freeze
  end
end
