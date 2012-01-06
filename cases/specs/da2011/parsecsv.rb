
require 'rexml/document'

# CONFIG

RIGHT_PAGE_REGEXP = /^Gegevensspecificatie DA-2011 - \(DA-2011\) (\d+)$/
LEFT_PAGE_REGEXP = /^(\d+)/
NAME_REGEXP = /Naam : ([A-Z]+ \d*)?/
EXP_NAME_REGEXP = /Naam :( [a-zA-Z0-9]+)+/
ENCODING = 'windows-1252'

module TaxSpec

  class Spec
    include REXML
    attr_reader :datums

    def initialize(name, datums, text)
      @name = name
      @datums = datums
      init_pages(text)
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
        elt = datum.to_xml
        page = @pages[datum.id]
        raise "No page for #{datum.id}" if page.nil?
        elt.attributes['page'] = page
        root << elt
      end
      doc << XMLDecl.new('1.1', ENCODING)
      doc << root
      return doc
    end

    def init_pages(text)
      @pages = {}
      page = nil
      text.each_line do |line|
        if line =~ LEFT_PAGE_REGEXP || line =~ RIGHT_PAGE_REGEXP then
          page = $1
        end
        if line =~ /^Identificatienummer (\d+)$/
          raise "No page for #{id}" if page.nil?
          @pages[$1] = page
        end
      end
    end

  end
  
  class Datum
    include REXML
    attr_reader :name, :id, :definition, :explanation, :format
    attr_reader :conditions, :domain, :relates_to, :source
    attr_reader :expressions, :compute_as

    def initialize(name, id, definition, explanation, format, 
                   conditions, domain, relates_to, source,
                   expressions, compute_as)
      @name = name
      @id = id
      @definition = definition
      @explanation = explanation
      @format = format
      @conditions = conditions
      @domain = domain
      @relates_to = relates_to
      @source = source
      @expressions = expressions
      @compute_as = compute_as
    end
    
    def to_xml
      elt = Element.new('datum')
      elt.attributes['name'] = name
      elt.attributes['id'] = id
      elt.attributes['format'] = format
      elt.attributes['domain'] = domain
      elt.attributes['relates_to'] = relates_to
      labels = [:definition, :explanation,:source, :compute_as]
      labels.each do |label|
        kid = Element.new(label.to_s)
        kid.text = send(label)
        elt << kid
      end

      # Conditions
      kid = Element.new('conditions')
      conditions.split("%%").each do |cond|
        celt = Element.new('condition')
        if cond =~ NAME_REGEXP then
          celt.attributes['name'] = $1
          cond.sub!(NAME_REGEXP, '')
        end

        celt.text = cond
        kid << celt
      end
      elt << kid
      
      # Expressions
      kid = Element.new('expressions')
      re = /Naam :(?: [a-zA-Z0-9]+)+/
      names = expressions.scan(re)
      exps = expressions.split(re)
      exps.shift 
      if names.length != exps.length then
        $stderr << "NAMES = #{names}\n"
        $stderr << "EXPS = #{exps}\n"
        $stderr << "\n\t#{expressions.inspect}\n"
        raise "Names and exps are not compatible"
      end
      if names.length == 0 then
        # EXP_NAME_REGEXP = /Naam :( [a-zA-Z0-9]+)+/
        names = [''] # todo: depends on exp_name_regexp
        exps = [expressions]
      else
        names.map! do |name|
          if name =~ /Naam :((?: [a-zA-Z0-9]+)+)/ then
            $1.strip
          else
            raise "Could not match name #{name}"
          end
        end
      end
      names.each_with_index do |name, i|
        next if exps[i].empty?
        exp = Element.new('expression')
        exp.attributes['name'] = name if !name.empty?
        exp.text = exps[i].sub(/\.$/, '')
        kid << exp
      end
      elt << kid
      return elt
    end

    def to_s
      values = [name, id, definition, explanation, format, 
                conditions, domain, relates_to, source,
                expressions, compute_as]
      labels = [:name, :id, :definition, :explanation, :format,
                :conditions, :domain, :relates_to, :source,
                :expressions, :compute_as]
      items = labels.zip(values).map do |label, value|
        "#{label}: #{value}"
      end
      "{#{items.join(",\n")}}"
    end
  end
  
  class CSV
    def self.read(file, text)
      src = File.read(file, :encoding => ENCODING).encode('UTF-8')
      datums = []
      first = true
      # start at 1 to skip column headers
      src.each_line do |line|
        if first then
          first = false
          next
        end
        elts = []
        loop do
          col, line = parse_value(line)
          elts << col 
          break unless line
        end
        datums << Datum.new(*elts)
      end
      Spec.new(File.basename(file), datums, text)
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
  text = File.read(ARGV[0], :encoding => ENCODING)
  spec = TaxSpec::CSV.read(ARGV[1], text)
  pp = REXML::Formatters::Pretty.new
  File.open(ARGV[2], "w:#{ENCODING}") do |f|
    pp.write(spec.to_xml, f)
  end
end  
