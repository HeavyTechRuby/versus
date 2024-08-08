module Testing
  Guest = Class.new

  class Context
    attr_accessor :current_user, :current_versus
  end
end

module Versus
  module WorldHelpers
    def context = @context ||= Testing::Context.new
  end
end

World(Versus::WorldHelpers)
