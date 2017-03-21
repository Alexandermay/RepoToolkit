module ToRoo
  def roo_to_xml
    filex=Dir.glob('*.xlsx').to_s.gsub(/\[\"|\"\]/,'')
    require 'roo'
    work = Roo::Spreadsheet.open(filex)
    sheet = File.open("firstTransform.xml", "w+")
    sheet.puts work.to_xml
    sheet.close 
    self
 end
 end