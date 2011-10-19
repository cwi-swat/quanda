require 'pp'

class Datum
  attr_accessor :name, :id, :description, :conditions, :explanation, :format
end

# TODO cross check with simple grep invocations to check 
# whether we find all datums

file = File.open(ARGV[0], 'r', :encoding => "UTF-8")
lines = file.readlines
line = lines.shift
datums = []
count = 0
cur = nil
while line do
  if line =~ /^Gegevensnaam (.*)$/
    cur = Datum.new
    datums << cur
    count += 1
    cur.name = $1
    line = lines.shift
    while line !~ /^Identificatie/
      cur.name << line
      line = lines.shift
    end
    next
  end
  if cur && line =~ /^Identificatie (.*)$/
    cur.id = $1
    line = lines.shift
    next
  end
  if cur && line =~ /^Omschrijving (.*)$/
    cur.description = $1
    line = lines.shift
    while line !~ /^Condities/
      cur.description << line
      line = lines.shift
    end
    next 
  end
  if cur && line =~ /^Condities (.*)$/ 
    cur.conditions = $1
    line = lines.shift
    while line !~ /^Toelichting/
      cur.conditions << line
      line = lines.shift
    end
    next
  end
  if cur && line =~ /^Toelichting (.*)$/ 
    cur.explanation = $1
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

#puts "Total num of datums: #{count}"


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
