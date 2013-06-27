# -*- coding: utf-8 -*-

require "rubygems"
require "mysql"
require "kconv"

datatmp = Mysql::new("localhost","root","","saisokudb")



data = datatmp.query("select user_id,work_url from mylist")

data.each do |aaa|




    
    tmp = aaa.join(",mylist,(work)").tosjis
    
    puts "(user)" + tmp
    


end