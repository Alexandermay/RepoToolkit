module UnzipIt
  def unzip
  print "Unziping...please be patient as this may take a while."
  `unzip '*.zip'`
  self
  end
end