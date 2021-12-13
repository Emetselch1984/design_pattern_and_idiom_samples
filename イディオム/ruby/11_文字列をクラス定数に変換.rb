# Railsの文法
class_constant = "文字列".classify.constantize
class_constant.クラスメソッド

def user_class
  @user_class ||= Config.user_class.to_s.constantize
rescue NameError
  raise ArgumentError, 'You have incorrectly defined user_class or have forgotten to define it in intitializer file (config.user_class = \'User\').'
end