require 'net/http'
require 'nokogiri'
require 'open-uri'


class Page
attr_accessor :url, :doc
  def initialize(url)
    @url = url
    @doc = Nokogiri::HTML(open(@url))
  end

  def fetch!
  uri = URI.parse(@url)
  req = Net::HTTP::Get.new(uri.to_s)
  res = Net::HTTP.start(uri.host, uri.port) {|http|
    http.request(req)
  }
  puts res.body
  end

  def links
    
    p @doc.search("a").inner_text
  end

  def title
    # source = Net::HTTP.get(@url, '/index.html')
    @doc.search("title").inner_text
  
  end
end

example = Page.new('http://www.example.com/')
p example.fetch!
example.links
p example.title