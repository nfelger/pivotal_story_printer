require 'prawn'

class CardGenerator
  def initialize(stories)
    @stories = stories
  end

  def generate
    pdf = Prawn::Document.new
    pdf.text "I WORKS"
    pdf.render
  end
end
