require 'sinatra'
require './lib/card_generator'

get '/' do
  <<-HTML
<!DOCTYPE html>

<html>
  <head>
    <title>Story card printer</title>
  </head>

  <body>
    <form action="/stories" method="POST">
      <ul>
        <li>Project ID: <input type="text" name="projectId"></li>
        <li>API Token: <input type="text" name="apiToken"></li>
      </ul>
      <input type="submit" value="Submit">
    </form>
  </body>
</html>
HTML
end

post '/stories' do
  puts params.inspect
  #stories = PivotalProject.new(params['projectId'], params['apiToken']).stories
  stories = []
  
  attachment "stories-#{params['projectId']}-#{Time.now.strftime('%Y%m%d')}.pdf"
  CardGenerator.new(stories).generate
end
