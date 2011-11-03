require 'prawn'
require "prawn/measurement_extensions"

class CardGenerator
  def initialize(stories)
    @stories = stories
  end

  def generate
    pdf = Prawn::Document.new(
      :page_layout => :portrait,
      :margin      => [25, 25, 25, 25],
      :page_size   => [15.24.cm, 10.16.cm]
    )

    between_box_margin = 0.5.cm

    @stories.each do |story|
      puts story.inspect
      next if story[:story_type] == 'release'


      pdf.text_box story[:name], :size => 30, :height => 3.cm, :overflow => :shrink_to_fit
      pdf.move_down 3.cm + between_box_margin

      pdf.text_box story[:description], :at => [0, pdf.cursor], :height => 4.cm, :overflow => :shrink_to_fit
      pdf.move_down 4.cm + between_box_margin

      bottom_line = "#{story[:story_type].upcase} — #{story[:url]} — printed #{Time.now.strftime('%Y-%m-%d')}"
      pdf.text_box bottom_line, :at => [0, 6], :size => 6, :align => :center
      pdf.start_new_page
    end
    pdf.render
  end
end
