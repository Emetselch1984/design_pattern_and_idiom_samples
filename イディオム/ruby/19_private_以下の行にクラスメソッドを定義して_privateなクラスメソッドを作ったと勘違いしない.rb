class User
  private

  def secret_name
    # 外部から呼ばれたくないインスタンスメソッド
    "secret!"
  end

  def self.secret_data
    # 外部から呼ばれたくないクラスメソッド！？
    "secret!!"
  end
end

class User
  private
  def secret_name
    "secret"
  end
  def self.secret_name
    "secret"
  end
  private_class_method :secret_data
end