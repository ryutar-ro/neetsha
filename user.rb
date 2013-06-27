# -- coding: utf-8

require "open-uri"
require "rubygems"
require "nokogiri"
require "mysql"

client = Mysql::new("localhost","root","","saisokudb")

doc = Nokogiri::HTML(open("http://fastneet.org/user/view?pub=mylist"))
doc.css('td.user').each do |user|
    
    user_id = user.css("b").css("a").attribute("href").text.sub("\/mylist\/","")
    user_name = user.css("b").css("a").text.sub(/\s\([0-9]+\)$/,"")

    aaa = "insert into user(user_id,user_name) values(\"#{user_id}\",\"#{user_name}\")"
    client.query(aaa)

    
end