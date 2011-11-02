require 'prawn'

class CardGenerator
  def initialize(stories)
    @stories = stories
  end

  def generate
    pdf = Prawn::Document.new
    @stories.each do |story|
      pdf.text story[:title]
      pdf.start_new_page
    end
    pdf.render
  end
end
