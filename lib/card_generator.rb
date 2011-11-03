require 'prawn'
require "prawn/measurement_extensions"

class CardGenerator
  def initialize(stories)
    @stories = stories
  end

  def generate
    pdf = Prawn::Document.new(
      :page_layout => :portrait,
      :page_size   => [15.24.cm, 10.16.cm]
    )
    @stories.each do |story|
      pdf.text story[:title]
      pdf.start_new_page
    end
    pdf.render
  end
end
