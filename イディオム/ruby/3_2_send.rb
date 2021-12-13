module A
  class Config
    attr_accessor :before_authenticate

    def initialize
      @defauluts = {
          :@before_authenticate => []
      }
      reset!
    end
    def reset!
      @defauluts.each do |k,v|
        instance_variable_set(k,v)
      end
    end
    def hello
      puts "hello World"
    end
  end
end
class User
  include A

  def initialize
    set_config
  end
  def set_config
    @sorcery_config = Config.new
  end
  def sorcery_config
    @sorcery_config
  end
  def callback
    sorcery_config.before_authenticate.each do |callback|
      success, reason = send(callback)
      success
    end
  end
  def insert(method)
    sorcery_config.before_authenticate << method
  end
end
user = User.new
user.insert(:hello)
user.callback

@sorcery_config.before_authenticate.each do |callback|
  success, reason = user.send(callback)

  unless success
    return authentication_response(user: user, failure: reason, &block)
  end
end