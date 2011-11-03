require 'curb-fu'
require 'nokogiri'

class PivotalProject
  def initialize(project_id, api_token)
    @project_id = project_id
    @api_token  = api_token
  end

  def stories
    response = CurbFu.get(:url => url, :headers => {'X-TrackerToken' => @api_token})
    doc = Nokogiri::XML(response.body)
    doc.css('story name').map do |node|
      {:title => node.text}
    end
  end

  private

  def url
    "http://www.pivotaltracker.com/services/v3/projects/#{@project_id}/stories"
  end
end
