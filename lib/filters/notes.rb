
#
# This filter adds a class to every paragraph that begins
# with capital letters followed by a colon.

# For example if a paragraph begins with "WARNING:", then
# this filter will add class="warning" to that paragraph tag.

# Special cases include
#
#   WARNING:
#   EDITOR NOTE:
#   TIP:
#   TODO:
#

class NoteClasses < Nanoc3::Filter
  
  identifier :note_classes
  type :text
  
  def run(content, params={})
    doc = Nokogiri::HTML(content)
    doc.css("p").map do |p|
      if p.text.match pattern
        p["class"] = to_class(p.text)
      end
    end
    doc.to_html
  end
  
  def to_class(text)
    text.match(pattern) { $1 }.downcase.gsub(" ","-")
  end

  def pattern
    /(^[A-Z\s]+):/
  end
end