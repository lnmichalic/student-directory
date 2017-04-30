file = File.open __FILE__
file.each_line { |line| puts line }
file.close
