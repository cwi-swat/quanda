require 'pp'

class Datum
  attr_accessor :name, :id, :description, :conditions, :explanation, :format
end

# TODO cross check with simple grep invocations to check 
# whether we find all datums

def parse_spec(file)
  file = File.open(file, 'r', :encoding => "UTF-8")
  lines = file.readlines
  line = lines.shift
  groups = {}
  count = 0
  cur = nil
  curgroup = nil
  while line do
    if line =~ /^Gegevensgroep(.*)$/ 
      curgroup = $1.strip
      groups[curgroup] = []
      # don't parse explanation and condition yet
      line = lines.shift
      next
    end
    if line =~ /^Gegevensnaam(.*)$/
      cur = Datum.new
      groups[curgroup] << cur
      count += 1
      cur.name = $1.strip
      line = lines.shift
      while line !~ /^[Ii]dentificatie/
        cur.name << line
        line = lines.shift
      end
      next
    end
    if cur && line =~ /^[Ii]dentificatie(.*)$/
      cur.id = $1.strip
      line = lines.shift
      next
    end
    if cur && line =~ /^Omschrijving(.*)$/
      cur.description = $1.strip
      line = lines.shift
      while line !~ /^Condities/
        cur.description << line
        line = lines.shift
      end
      next 
    end
    if cur && line =~ /^Condities(.*)$/ 
      cur.conditions = $1.strip
      line = lines.shift
      while line !~ /^Toelichting/
        cur.conditions << line
        line = lines.shift
      end
      next
    end
    if cur && line =~ /^Toelichting(.*)$/ 
      cur.explanation = $1.strip
      line = lines.shift
      while line !~ /^Formaat/
        cur.explanation << line
        line = lines.shift
      end
      next
    end
    if cur && line =~/^Formaat (.*)$/
      cur.format = $1
      line = lines.shift
      next
    end
    cur = nil
    line = lines.shift
  end
  return groups
end


def escape(l)
  l.gsub(/"/, '\\"').gsub(/Pagina [0-9]+ van [0-9]+/, '')
end

def print_long(s)
  if s.nil? then
    puts '""'
    return
  end
  print "\""
  print s.split(/\n/).map { |l| escape(l).strip.chomp }.join("\n\t\t\t")
  puts "\""
end

$syms = 0

def norm(id)
  if id =~ /n\.v\.t/ then
    "not_applicable_#{$syms += 1}"
  else
    id
  end
end

def to_dsl(groups)
  groups.each do |name, datums|
    puts "group \"#{name}\" {"
    datums.each do |d|
      puts "\tdatum #{norm(d.id)}: #{d.format} {"
      puts "\t\tname \"#{d.name}\""
      print "\t\tdescription "
      print_long(d.description)
      cs = d.conditions.split(/(\[[0-9.]+\])/)
      cs = cs[1..-1] # get strange first thing out of the way
      i = 0
      while i < cs.length - 1 do
        id = cs[i].sub(/\./, '/')
        c = cs[i+1]
        i += 2
        print "\t\tcond #{id} "
        print_long(c)
        print "\n"
      end
      print "\t\texplanation "
      print_long(d.explanation)    
      print "\t}\n\n"
    end
    print "}\n\n"
  end
end

# does not deal with groups
def to_html(datums)
  #, :id, :description, :conditions, :explanation, :format
  require 'markaby'
  mab = Markaby::Builder.new
  mab.html do
    head { title "Loonheffing stuff" }
    body do 
      datums.each do |d|
        h1 d.name
        table do
          tr { td "Identifier"; td d.id }
          tr { td "Description"; td d.description }
          cs = d.conditions.split(/\[[0-9]+\]/)
          cs = cs[1..-1] # get strange first thing out of the way
          tr do 
            td "Conditions"; td do
              ul do 
                cs.each do |c|
                  li c
                end
              end
            end
          end
          tr { td "Explanation"; td d.explanation }
          tr { td "Format"; td d.format }
        end
      end
    end
  end
  puts mab.to_s
end

if __FILE__ == $0 then
  send(ARGV[0], parse_spec(ARGV[1]))
end
