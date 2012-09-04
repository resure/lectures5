require 'sinatra'
require 'slim'
require './markdown_parser'

get '/' do
  slim :index
end

get '/pages/:name' do
  name = params[:name]
  text = File.read "#{settings.root}/pages/#{name}.md"
  text = MarkdownParser.new(text.gsub(?`, ?$)).to_html
  @page = text.gsub ?$, ?`
  puts @page
  slim :page
end

get '/style.css' do
  scss :style
end
