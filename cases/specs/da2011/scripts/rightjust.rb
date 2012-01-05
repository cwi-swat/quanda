

toc = File.readlines(ARGV[0], :enconding => 'windows-1252') 

ml = -1
toc.each do |line|
  if line.length > ml then
    ml = line.length
  end
end
    

toc.each do |line|
  diff = ml - line.length
  fill = ' ' * diff
  puts "#{fill}#{line}"
end
