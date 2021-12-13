# nilチェックの代わりにObject#try(:method_name)を使う

require 'active_support/all'

if parent.children && parent.children.singleton?
  singleton = parent.children.first
  send_mail_to(singleton)
end

# childrenがnilならtry(:singleton?)はnilを返す
# nilでなければ、children.singleton?が普通に呼ばれる
if parent.children.try(:singleton?)
  singleton = parent.children.first
  send_mail_to(singleton)
end

# 「空なら別の値を代入」の代わりにpresenceを使う
class User
  require 'active_support/all'
  attr_accessor :age,:admin,:name
  def initialize(args)
    @age = args[:age]
    @admin = false
    @name = args[:name]
  end
  def admin?
    admin == true
  end
end

user = User.new({
                     age: 15
                 })

if user.name.blank?
  name = "What's your name?"
else
  name = user.name
end
name = user.name.presence || "What's your name?"

class Company
  attr_accessor :good_news

  def initialize
    @good_news = []
  end
end
company = Company.new
company.good_news << "Alice"
company.good_news << "Bob"

def send_mail(good_news)
  good_news.each do |arg|
    puts "mail_to_#{arg}"
  end
end
def tweet(good_news)
  good_news.each do |arg|
    puts "tweet_to_#{arg}"
  end
end
# Newsが1件でも存在すればメール送信＆ツイート発信
good_news = company.good_news
if good_news.count > 0
  send_mail(good_news)
  tweet(good_news)
end

if good_news = company.good_news.presence
  send_mail(good_news)
  tweet(good_news)
end