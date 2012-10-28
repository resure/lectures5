# encoding: utf-8
require 'redcarpet'
class MarkdownParser
  def initialize text
    @text = text
  end

  def to_html
    parse @text
  end

  private

  def parse text
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
                                       autolink: true,
                                       space_after_headers: true,
                                       strikethrough: true,
                                       tables: true,
                                       hard_wrap: true)
    post (markdown.render (pre text))
  end

  def pre(text)
    text
  end

  def post(text)
    result = text.gsub(/\[left\]([\S\s]*?)\[\/left\]/i,'<div class="left-align">\1</div>')
    result = result.gsub(/\[right\]([\S\s]*?)\[\/right\]/i,'<div class="right-align">\1</div>')
    result = result.gsub(/\[center\]([\S\s]*?)\[\/center\]/i,'<div class="center-align">\1</div>')
    result = result.gsub("--","—")
  end
end

