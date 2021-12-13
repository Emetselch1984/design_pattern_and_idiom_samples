module Sorcery
  module Model
    class Config
      attr_accessor :password_attribute_name
      attr_accessor :email_attribute_name
      # change default email attribute.
      def initialize
        @defaults = {
            :@email_attribute_name                 => :email,
            :@password_attribute_name              => :password,
        }
        reset!
      end
      # Resets all configuration options to their default values.
      def reset!
        @defaults.each do |k, v|
          instance_variable_set(k, v)
        end
      end
    end
  end
end
config = Sorcery::Model::Config.new
config.email_attribute_name