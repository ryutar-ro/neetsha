# -*- coding: utf-8 -*-

require "open-uri"
require "rubygems"
require "nokogiri"
require "mysql"

client = Mysql::new("localhost","root","","saisokudb")
i = 1

k=0

idtmp = client.query("select user_id from user")

idtmp.each do |user_id|

    k+=1
  if k>=496
    
while(1) do
    
    url = "http://fastneet.org/mylist/#{user_id[0]}?p=#{i}&detail=5"
    doc = Nokogiri::HTML(open(url))
    if doc.css("div.session").css("p").text =~ /条件に該当する作品は見つかりませんでした。/u
        i = 1
        break
    end
    
    
    doc.xpath('//tr["@class =item"]').each do |manga|
        
        
        titletmp = manga.css("a.item-title").text
        next if titletmp.empty?
        title = Mysql.escape_string(titletmp)
        
        
            aaa = "insert into mylist(user_id,work_url) values(\"#{user_id[0]}\",\"#{title}\")"
            client.query(aaa)
        
            end
    
    
    
    i += 1
    
end
puts user_id
    end
    end
    

