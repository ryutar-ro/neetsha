# -*- coding: utf-8 -*-

require "open-uri"
require "rubygems"
require "nokogiri"
require "mysql"

client = Mysql::new("localhost","root","","saisokudb")
i = 1
while(1) do
    url = "http://fastneet.org/search?m=1+2+3+6+8+101+102&p=#{i}&detail=5&count=50"
    doc = Nokogiri::HTML(open(url))
if doc.css("div.session").css("p").text =~ /条件に該当する作品は見つかりませんでした。/u
    break
    end


doc.xpath('//tr["@class =item"]').each do |manga|
    
    genretmp = manga.css("span.item-genre").text
    genre = Mysql.escape_string(genretmp)
    
    titletmp = manga.css("a.item-title").text
    next if titletmp.empty?
    title = Mysql.escape_string(titletmp)
    
    authortmp = manga.css("a.item-author").text
    author = Mysql.escape_string(authortmp)
    
    tags = manga.css("span.item-tags").css("a")
    tags.shift
    
    com = manga.css("a.item-comment").text.to_i
    
    myl = manga.css("a.item-mylist").text
    
    
    titlelinktmp = ""
    manga.css("a.item-title").each do |titlelink|
        titlelinktmp = titlelink['href']
    end
    tags.css("a").each do |taglink|
        taglinktmp = taglink.attribute("href")
        aaa = "insert into work_tags(work_url,tag_url) values(\"#{title}\",\"#{taglinktmp}\")"
        client.query(aaa) 
    end

    myltmp = myl.sub("+","").to_i
    
    bbb = "insert into work(genre,title,work_url,author,comment,mylist) values(\"#{genre}\",\"#{title}\",\"#{titlelinktmp}\",\"#{author}\",\"#{com}\",\"#{myltmp}\")"
    client.query(bbb)
    
end
    print "☆"
    print i
    
    
i += 1
sleep 2
end