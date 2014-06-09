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

number = {}
XPath.each(xmldoc, "/osm/node/tag[@k='addr:housenumber']") { |tag|
    node = tag.parent
    number[node.attributes['id']] = [node.attributes['lat'], node.attributes['lon'], tag.attributes['v']]
}

CSV.open(file.gsub(/.osm/, '\1-number.csv'), 'wb') do |csv_number|
CSV.open(file.gsub(/.osm/, '\1-street.csv'), 'wb') do |csv_street|

XPath.each(xmldoc, "/osm/relation/tag[@k='type'][@v='associatedStreet']") { |tag|
    street = tag.parent
    id = street.attributes['id']
    name = XPath.first(street, "tag[@k='name']/@v").value
    XPath.each(street, "member/@ref") { |ref|
        csv_number << [code, id] + number[ref.value]
    }
    csv_street << [code, id, name]
}

end
end
