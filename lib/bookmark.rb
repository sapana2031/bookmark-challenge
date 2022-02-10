require 'pg'

class Bookmark

  attr_reader :id, :title, :url

  def initialize(id:, title:, url:)
    @id = id
    @title = title
    @url = url
  end

  def self.all
    connection = PG.connect(dbname: 'bookmark-manager')
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark-manager')
    end

   result = connection.exec("SELECT * FROM bookmarks")
   result.map do  |bookmark|
   Bookmark.new(id: bookmark['id'], title: bookmark['title'], url: bookmark['url'])
  end
end

  
  def self.create(url:, title:)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark-manager')
    end

    result = connection.exec_params(
      # The first argument is our SQL query template
      # The second argument is the 'params' referred to in exec_params
      # $1 refers to the first item in the params array
      # $2 refers to the second item in the params array
      "INSERT INTO bookmarks (url, title) VALUES($1, $2) RETURNING id, title, url;", [url, title]
    )
  Bookmark.new(id: result[0]['id'], title: result[0]['title'], url: result[0]['url'])

  
    # connection.exec("INSERT INTO bookmarks (title, url) VALUES('#{title}', '#{url}') RETURNING id, url, title")---- see changes above when we add result.
  end
end
# [
    #   "http://www.makersacademy.com",
    #   "http://www.destroyallsoftware.com",
    #   "http://www.google.com"
    # ]-- replace this so we can do evn setup