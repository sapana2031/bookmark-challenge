require 'pg'
class Bookmark 

  def self.all
    # [
    #   "http://www.makersacademy.com",
    #   "http://www.destroyallsoftware.com",
    #   "http://www.google.com"
    # ]
    connection = PG.connect(dbname: 'bookmark-manager')
    result = connection.exec('SELECT * FROM bookmarks')
    result.map { |bookmark| bookmark['url'] }
  end
end