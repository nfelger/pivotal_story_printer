require 'rest_client'
require 'nokogiri'

class PivotalProject
  def initialize(project_id, api_token)
    @project_id = project_id
    @api_token  = api_token
  end

  def stories
    response = RestClient.get(url, {'X-TrackerToken' => @api_token})
    doc = Nokogiri::XML(response.body)
    doc.css('story').map { |node|
      story = {}
      [ 'id',
        'name',
        'story_type',
        'url',
        'estimate',
        'description',
        'current_state',
        'labels',
        'created_at',
        'updated_at'
      ].each do |attr_name|
        next unless attr_node = node.at_css(attr_name)
        
        story[attr_name.intern] = attr_node.text
      end
      story
    }
  end

  private

  def url
    "http://www.pivotaltracker.com/services/v3/projects/#{@project_id}/stories"
  end
end
