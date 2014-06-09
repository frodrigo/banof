#!/usr/bin/ruby -w

require 'csv'
require 'rexml/document'
include REXML

file = ARGV[1]
if ARGV[0][0] == '0'
  code = ARGV[0][1..2] + file.split('/')[-1][2..4]
else
  code = ARGV[0][0..2] + file.split('/')[-1][3..4]
end

xmlfile = File.new(file)
xmldoc = Document.new(xmlfile)

CSV.open(file.gsub(/.osm/, '\1.csv'), 'wb') do |csv_nom|

XPath.each(xmldoc, "/osm/node/tag[@k='name']/../tag[@k='angle']") { |angle|
    node = angle.parent
    angle = angle.attributes['v']
    name = XPath.first(node, "tag[@k='name']/@v").value
    csv_nom << [code, node.attributes['lat'], node.attributes['lon'], angle[0..-2], name]
}

end
