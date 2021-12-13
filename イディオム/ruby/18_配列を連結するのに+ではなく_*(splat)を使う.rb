numbers = [1, 2, 3]
numbers_with_zero_and_100 = [0] + numbers + [100] # => [0, 1, 2, 3, 100]

numbers = (1..3).to_a
numbers_with_zero_and_100 = [0,*numbers,100]
