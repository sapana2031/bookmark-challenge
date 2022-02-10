require 'pg'

class Bookmark
  def self.all
    connection = PG.connect(dbname: 'bookmark-manager')
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark-manager')
    end

   result = connection.exec("SELECT * FROM bookmarks")
   result.map { |bookmark| bookmark['url'] }
  end
  
  def self.create(url:)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end
  
    connection.exec("INSERT INTO bookmarks (url) VALUES('#{url}')")
  end
end
# [
    #   "http://www.makersacademy.com",
    #   "http://www.destroyallsoftware.com",
    #   "http://www.google.com"
    # ]-- replace this so we can do evn setup