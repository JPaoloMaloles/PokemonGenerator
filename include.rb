array = ["Hello", "world"]
array2 = ["1", "2"]
hash = {}
array.each do |key|
  array.each do |value|
    hash[key] = value
  end
end
puts hash
