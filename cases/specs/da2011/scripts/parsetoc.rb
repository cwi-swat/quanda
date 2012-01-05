


toc = File.readlines(ARGV[0], :enconding => 'windows-1252') 


FONT = '/Library/Fonts/Microsoft/Arial.ttf'


=begin
idea:
 - set the current_width if it is nil and init hash[section] = [], section = line
 - if the current line is narrower then the current_width hash[section] << {line => []}
 
=end

=begin
def line_width(line)
  result = `convert xc: -font #{FONT} -pointsize 9 -debug annotate -annotate 0 '#{line}' null: 2>&1`
  if result =~ /width: (\d+(\.\d+)?);/
    return $1.to_f
  end
  raise "Error width computation: #{result}"
end

def extract_label(line)
  if line =~ /^(.*?)\./ then
    return $1
  end
  raise "Error label extraction: #{line}"
end

def extract_dots(line)
  if line =~ /(\.+)/ then
    return $1
  end
  raise "Error extract dots: #{line}"
end

def same_level?(w1, w2, delta = 5.0)
  (w1 - w2).abs < delta
end

# 1.upto(50) do |i|
#   puts line_width('.' * i)
# end


# exit!

stack = []
last_width = Float::MAX
last = nil
toc.each do |line|
  line = line.chomp
  width = line_width(line)
  label = extract_label(line)
  #dots = extract_dots(line)
  #dots_width = line_width(dots)
  #txt_width = width - dots_width
  #kdots_width = dots.length * 2 * 1.09375 # size of a single dot
  #lwidth = txt_width + kdots_width
  #puts "DOTSLENGTH = #{dots.length} DOTS_WIDTH = #{dots_width} KDOTS_WIDTH = #{kdots_width} WIDTH = #{width} LWIDTH = #{lwidth}"
  #puts "#{dots.length} / 3 = #{dots.length / 3}"
  #next

  #puts ' '*(width / 10).to_i + label
  puts "#{width}: #{label}"
  if same_level?(width, last_width, 10.0) then
    #puts "#{width} same level: #{label}"
    stack.last[stack.last.keys.first] << {label => []}
  elsif width < last_width then
    # nest
    #puts "#{width} nesting: #{label}"
    current = {label => []}
    stack.push(current)
  elsif width > last_width then
    #puts "#{width} unnest: #{label}"
    # unnest
    kid = stack.pop
    stack.last[stack.last.keys.first] << kid
    last = stack.last
  end
  last_width = width
end

require 'pp'

pp last
pp stack

=end

toc.each do |line|
  diff = ml - line.length
  fill = ' ' * diff
  puts "#{fill}#{line}"
end
