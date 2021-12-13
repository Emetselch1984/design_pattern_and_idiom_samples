ADMIN_NAMES = ["Tom", "Alice"].freeze.each(&:freeze)
ADMIN_NAMES << "Taro" # => RuntimeError: can't modify frozen Array
ADMIN_NAMES[0].downcase! # => RuntimeError: can't modify frozen String
