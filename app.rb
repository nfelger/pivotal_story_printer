require 'sinatra'
Dir['./lib/*'].each do |fn|
  require fn
end

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
  stories = PivotalProject.new(params['projectId'], params['apiToken']).stories
  
  attachment "stories-#{params['projectId']}-#{Time.now.strftime('%Y%m%d')}.pdf"
  CardGenerator.new(stories).generate
end
