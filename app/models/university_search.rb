class UniversitySearch < ActiveRecord::Base
  ['mediawiki', 'hpricot', 'cgi', 'open-uri'].each {|f| require f}
  
  def pull_summary
#    wiki = MediaWiki.new('http://es.wikiquote.org/w/api.php')
#    page = wiki.find(id)
  end
  
end
