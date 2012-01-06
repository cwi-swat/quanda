

require 'rexml/document'
require 'yaml'

class TOC
  include REXML

  attr_reader :entries

  def initialize
    @entries = []
  end

  def max_width
    entries.map(&:width).max
  end

  def <<(entry)
    entries << entry
  end

  def to_xml
    toc = YAML.load(to_yaml)
    root = Element.new('toc')
    entries2xml(toc, root)
    doc = Document.new
    doc << root
  end

  private

  def entries2xml(es, elt)
    es.each do |hash|
      elt << entry2xml(hash)
    end
  end

  def entry2xml(hash)
    elt = Element.new('entry')
    elt.attributes['title'] = hash['title']
    elt.attributes['page'] = hash['page']
    if hash["entries"] then
      entries2xml(hash["entries"], elt)
    end
    return elt
  end

  def to_yaml(out = '')
    # NB: the truncation makes it not very precise
    # but it works because indents are different enough.
    mw = max_width.truncate
    entries.each do |e|
      ew = e.width.truncate
      ind = ' ' * (mw - ew)
      title = e.title =~ /:/ ? "\"#{e.title}\"" : e.title
      out << "#{ind}- title: #{title}\n"
      out << "#{ind}  page: #{e.page}\n"
      out << "#{ind}  entries: \n"
    end
    return out
  end

end

class TOCEntry
  attr_reader :width, :title, :page

  def initialize(width, title, page)
    @width = width
    @title = title
    @page = page
  end
  
  def to_s
    "#{width}: #{title} : #{page}"
  end
end

class TOCParser
  include REXML

  # Config
  ENCODING = 'UTF-8'
  LIT_SKIP = ['29/9/2011', 'Gegevensspecificatie DA-2011 - (DA-2011)']
  REG_SKIP = [/^\d+$/, # page number
              /^Toelichting behorende/, 
              /^Index/, 
              /^Inhoudsopgave/,
              /^Gehanteerde/, 
              /^Inkomsten- vennoot/]

  SKIP = REG_SKIP + LIT_SKIP.map { |x| 
    Regexp.new('^' + Regexp.escape(x) + '$') 
  }

  attr_reader :doc

  def initialize(filename)
    toc = File.read(ARGV[0], :encoding => ENCODING) 
    @doc = Document.new(toc)
  end

  def toc
    t = TOC.new
    doc.elements.each('pages/page/textbox/textline') do |x|
      chars = []
      x.elements.each('text') do |txt|
        if txt.attributes['bbox'] then
          chars << txt.text
        end
      end

      line = chars.join
      elts = line.split(/\.+/)
      raise if elts.length > 2
      title, page = elts
      next if SKIP.any? { |re| re =~ title }
      
      bbox = x.attributes['bbox']
      lux, luy, rlx, rly = bbox.split(',').map(&:to_f)
      width = rlx - lux
      
      t << TOCEntry.new(width, title, page)
    end
    return t
  end
end


if __FILE__ == $0 then
  tp = TOCParser.new(ARGV[0])
  toc = tp.toc
  
  doc = toc.to_xml
  pp = REXML::Formatters::Pretty.new
  pp.write(doc, $stdout)
end


