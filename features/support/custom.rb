module Testing
  Guest = Class.new

  class Context
    attr_accessor :current_user, :current_versus
  end
end

module Versus
  module DeviseTestHelpers
    include Warden::Test::Helpers

    def login_user(user)
      Warden.test_mode!
      login_as(user, scope: :user)
    end

    def logout_user
      Warden.test_mode!
      logout(:user)
    end
  end

  module WorldHelpers
    def context = @context ||= Testing::Context.new
  end
end

World(Versus::DeviseTestHelpers)
World(Versus::WorldHelpers)
