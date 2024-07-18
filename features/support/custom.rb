module Testing
  class Guest
  end

  class Context
    attr_reader :current_user, :current_versus

    def set_user(new_user)
      @current_user = new_user
    end

    def set_versus(versus)
      @current_versus = versus
    end
  end
end

module Versus
  module WorldHelpers
    def context = @context ||= Testing::Context.new
  end
end

World(Versus::WorldHelpers)