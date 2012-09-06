require 'sinatra'
require 'slim'
require './markdown_parser'

get '/' do
  slim :index
end

get '/pages/:name' do
  name = params[:name]
  text = File.read "#{settings.root}/pages/#{name}.md"
  text = MarkdownParser.new(prepare(text)).to_html
  @page = unprepare text
  slim :page
end

get '/style.css' do
  scss :style
end

private

def prepare text
  text.gsub(?`, '$esc1$').gsub(?_, '$esc2$')
end

def unprepare text
  text.gsub('$esc1$', ?`).gsub('$esc2$', ?_)
end
