module Sorcery
  module Controller
    module Config
      class << self
        attr_accessor :user_class
        def init!
          @defaults = {
              :@user_class => "Staff"
          }
        end
        def reset!
          @defaults.each do |k,v|
            instance_variable_set(k,v)
          end
        end
      end
      init!
      reset!
    end
  end
end
class User
  include Sorcery::Controller::Config
  def config
    @config = Sorcery::Controller::Config
  end
  def user_class
    config.user_class
  end
end