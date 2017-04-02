module Transforms
  def transform_excel
    `java -cp //Applications/SaxonHE9-7-0-15J/saxon9he.jar net.sf.saxon.Transform -t -s:./firstTransform.xml -xsl:../../RepoToolkit/transforms/extract_excel.xslt -o:./workWithThis.xml`
    self
  end
  def transform_it
    `java -cp //Applications/SaxonHE9-7-0-15J/saxon9he.jar net.sf.saxon.Transform -t -s:collection.xml -xsl:../../RepoToolkit/transforms/excel_to_dc.xslt -o:./ingestThis.xml`
    `java -cp //Applications/SaxonHE9-7-0-15J/saxon9he.jar net.sf.saxon.Transform -t -s:ingestThis.xml -xsl:../../RepoToolkit/transforms/subject.xslt -o:./subjects.txt`
    self
  end
  def transform_it_springer
    `java -cp //Applications/SaxonHE9-7-0-15J/saxon9he.jar net.sf.saxon.Transform -t -s:./collection.xml -xsl:../../../RepoToolkit/transforms/Springer.xslt -o:../xml/ingestThis.xml`
    `java -cp //Applications/SaxonHE9-7-0-15J/saxon9he.jar net.sf.saxon.Transform -t -s:./ingestThis.xml -xsl:../../../RepoToolkit/transforms/subject.xslt -o:./subjects.txt`
    self
  end
  def transform_it_proquest
    `java -cp //Applications/SaxonHE9-7-0-15J/saxon9he.jar net.sf.saxon.Transform -t -s:collection.xml -xsl:../../RepoToolkit/transforms/Proquest.xslt -o:./ingestThis.xml`
    `java -cp //Applications/SaxonHE9-7-0-15J/saxon9he.jar net.sf.saxon.Transform -t -s:ingestThis.xml -xsl:../../RepoToolkit/transforms/subject.xslt -o:./subjects.txt`
    self
  end
  def subject_only
    `java -cp //Applications/SaxonHE9-7-0-15J/saxon9he.jar net.sf.saxon.Transform -t -s:xml/ingestThis.xml -xsl:../../RepoToolkit/transforms/subject.xslt -o:xml/subject_update.txt`
     self
  end
end