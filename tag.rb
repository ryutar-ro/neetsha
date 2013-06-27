# -- coding: utf-8

require "open-uri"
require "rubygems"
require "nokogiri"
require "mysql"

client = Mysql::new("localhost","root","","saisokudb")

doc = Nokogiri::HTML(open("http://fastneet.org/tag"))
doc.css('li.tag').each do |tag|
    
    tagtmp = tag.css("a").text
    taglinktmp = tag.css("a").attribute("href").text
    
    aaa = "insert into tags(tag_name,tag_url) values(\"#{tagtmp}\",\"#{taglinktmp}\")"
    client.query(aaa)
end

client.close