
require 'rexml/document'

module TaxSpec

  class Spec
    include REXML
    attr_reader :datums

    def initialize(name, datums)
      @name = name
      @datums = datums
    end

    def to_s
      datums.join("\n")
    end

    def to_dot(out = $stdout)
      out << "digraph spec {\n"
      datums.each do |datum|
        out << "n#{datum.id};\n"
      end
      datums.each do |datum|
        datum.relates_to.split(', ').each do |other|
          out << "n#{datum.id} -> n#{other}\n"
        end
      end
      out << "}\n"
    end

    
    def to_xml
      doc = Document.new
      root = Element.new('tax-spec')
      root.attributes['name'] = @name
      datums.each do |datum|
        root << datum.to_xml
      end
      return root
    end
  end
  
  class Datum
    include REXML
    attr_reader :name, :id, :definition, :explanation, :format
    attr_reader :conditions, :domain, :relates_to, :source
    attr_reader :countings, :compute_as

    def initialize(name, id, definition, explanation, format, 
                   conditions, domain, relates_to, source,
                   countings, compute_as)
      @name = name
      @id = id
      @definition = definition
      @explanation = explanation
      @format = format
      @conditions = conditions
      @domain = domain
      @relates_to = relates_to
      @source = source
      @countings = countings
      @compute_as = compute_as
    end
    
    def to_xml
      elt = Element.new('datum')
      elt.attributes['name'] = name
      elt.attributes['id'] = id
      elt.attributes['format'] = format
      elt.attributes['domain'] = domain
      elt.attributes['relates_to'] = relates_to
      labels = [:definition, :explanation,:conditions, :source, :countings, :compute_as]
      labels.each do |label|
        kid = Element.new(label.to_s)
        kid.text = send(label)
        elt << kid
      end
      return elt
    end

    def to_s
      values = [name, id, definition, explanation, format, 
                conditions, domain, relates_to, source,
                countings, compute_as]
      labels = [:name, :id, :definition, :explanation, :format,
                :conditions, :domain, :relates_to, :source,
                :countings, :compute_as]
      items = labels.zip(values).map do |label, value|
        "#{label}: #{value}"
      end
      "{#{items.join(",\n")}}"
    end
  end
  
  class CSV
    def self.read(file)
      csv = File.readlines(file, :encoding => 'windows-1252')
      datums = []
      # start at 1 to skip column headers
      1.upto(csv.length - 1) do |i|
        line = csv[i]
        elts = []
        loop do
          col, line = parse_value(line)
          elts << col 
          break unless line
        end
        datums << Datum.new(*elts)
      end
      Spec.new(File.basename(file), datums)
    end
    
    
    # Assumptions
    #  - strings use " as quotes
    #  - string can be nested (e.g. "'s should be balanced)
    #  - embedded strings cannot have a comma right after the closing quote
    def self.parse_string(line)
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
          last_was_quote = false
        else
          last_was_quote = false
        end
        pos += 1
        val << c
      end  
      return val[1..-2], line[pos + 1..-1]
    end
    
    def self.parse_value(line)
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
  end
end



if __FILE__ == $0 then
  spec = TaxSpec::CSV.read(ARGV[1])
  if ARGV[0] == 'to_xml' then
    pp = REXML::Formatters::Pretty.new
    pp.write(spec.to_xml, $stdout)
  elsif ARGV[0] == 'to_dot' then
    spec.to_dot($stdout)
  end
end  
