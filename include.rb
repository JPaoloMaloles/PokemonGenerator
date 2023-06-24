4096.times do
  is_shiny = false
  if rand(1..4097) == 1
    is_shiny = true
  end
  if is_shiny == true
    p is_shiny
  end
end
