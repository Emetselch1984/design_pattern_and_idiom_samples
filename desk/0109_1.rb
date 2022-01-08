# 記事を表す(集約オブジェクト中の要素)
class Article
  # 記事のタイトル
  attr_reader :title
  def initialize(title)
    @title = title
  end

end

class Blog
  attr_reader :articles

  def initialize
    @articles = []
  end

  def get_article_at(index)
    articles[index]
  end

  def add_article(article)
    articles << article
  end

  def length
    articles.length
  end

  def iterator
    BlogIterator.new(self)

  end

end


class BlogIterator
  attr_reader :blog
  attr_accessor :index
  ZERO = 0.freeze

  def initialize(blog)
    @blog = blog
    @index = ZERO
  end

  def has_next?
    self.index < blog.length
  end

  def next_article
    article = self.has_next? ? blog.get_article_at(self.index) : nil
    self.index += 1
    article
  end

end


blog = Blog.new
10.times do |n|
  blog.add_article(Article.new(n))
end
blog.length
iterator = blog.iterator

while iterator.has_next?
  article = iterator.next_article
  puts article.title
end
