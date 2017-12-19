require 'mechanize'
require 'pry'
require 'nokogiri'

mechanize = Mechanize.new
html = mechanize.get('http://weather.goo.ne.jp/weather/division-1/370000/') # urlのhtmlを取得

title = html.search("h2") # cssの場合
title = html.search("//h2") # xpathの場合
binding.pry

