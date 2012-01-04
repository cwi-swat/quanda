
require 'pp'


=begin
Assumptions
 - strings use " as quotes
 - string can be nested (e.g. "'s should be balanced)
 - embedded strings cannot have a comma right after the closing quote
=end
def parse_string(line)
  quotes = 0
  val = ''
  last_was_quote = false
  pos = 0
  line.each_char do |c|
    if c == '"' then
      quotes += 1
      last_was_quote = true
    elsif  c == ',' then
      if last_was_quote && quotes % 2 == 0 then
        break
      end
    else
      last_was_quote = false
    end
    pos += 1
    val << c
  end  
  return val, line[pos + 1..-1]
end
    
def parse_value(line)
  line = line.lstrip
  if line =~ /^"/
    return parse_string(line)
  else
    # the next comma is the delimiter
    if line =~ /^(.*?),(.*)$/ then
      return $1, $2
    end
    return line, nil
  end
end


def check_column_width_consistency(lines)
  width = nil
  lines.each do |line|
    if width.nil? then
      width = line.length 
    else
      raise "Wrong width (exp. #{width}): #{line}" if width != line.length
    end
  end
end
    
  
  

csv = File.read(ARGV[0], :encoding => 'windows-1252')

lines = []
csv.each_line do |line|
  elts = []
  loop do
    col, line = parse_value(line)
    elts << col 
    break unless line
  end
  lines << elts
end
check_column_width_consistency(lines)  

p lines
  
