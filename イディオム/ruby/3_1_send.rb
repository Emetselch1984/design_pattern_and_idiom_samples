p -365.send(:abs) #=> 365
p "ruby".send(:sub,/./,"R") #=> "Ruby"

"ruby".sub(/./,"R")
-365.abs

def update_attributes(attrs)
  attrs.each do |name, value|
    @model.send(:"#{name}=", value)
  end
  primary_key = @model.class.primary_key
  updated_count = @model.class.where(:"#{primary_key}" => @model.send(:"#{primary_key}")).update_all(attrs)
  updated_count == 1
end
hello = send(:puts,"hello")
hello
hoge = puts "hello"
hoge
# 空白を返す

@sorcery_config.before_authenticate.each do |callback|
  success, reason = user.send(callback)

  unless success
    return authentication_response(user: user, failure: reason, &block)
  end
end