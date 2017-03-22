module Transforms
  def extract_scholarship
    `java -cp //Applications/SaxonHE9-7-0-15J/saxon9he.jar net.sf.saxon.Transform -t -s:./firstTransform.xml -xsl:../../../Desktop/RepoToolkit/transforms/extractExcel_faculty.xslt -o:./workWithThis.xml`
    self
  end
  def extract_trove
    `java -cp //Applications/SaxonHE9-7-0-15J/saxon9he.jar net.sf.saxon.Transform -t -s:./firstTransform.xml -xsl:../../../Desktop/RepoToolkit/transforms/extractExcel_trove.xslt -o:./workWithThis.xml`
    self
  end
  def to_faculty
    `java -cp //Applications/SaxonHE9-7-0-15J/saxon9he.jar net.sf.saxon.Transform -t -s:collection.xml -xsl:../../../Desktop/RepoToolkit/transforms/Faculty.xslt -o:./ingestThis.xml`
    `java -cp //Applications/SaxonHE9-7-0-15J/saxon9he.jar net.sf.saxon.Transform -t -s:ingestThis.xml -xsl:../../../Desktop/RepoToolkit/transforms/subject.xslt -o:./subjects.txt`
    self
  end
  def to_student
    `java -cp //Applications/SaxonHE9-7-0-15J/saxon9he.jar net.sf.saxon.Transform -t -s:collection.xml -xsl:../../../Desktop/RepoToolkit/transforms/Student.xslt -o:./ingestThis.xml`
    `java -cp //Applications/SaxonHE9-7-0-15J/saxon9he.jar net.sf.saxon.Transform -t -s:ingestThis.xml -xsl:../../../Desktop/RepoToolkit/transforms/subject.xslt -o:./subjects.txt`
    self
  end
  def to_trove
    `java -cp //Applications/SaxonHE9-7-0-15J/saxon9he.jar net.sf.saxon.Transform -t -s:./collection.xml -xsl:../../../Desktop/RepoToolkit/transforms/Trove.xslt -o:./ingestThis.xml`
    `java -cp //Applications/SaxonHE9-7-0-15J/saxon9he.jar net.sf.saxon.Transform -t -s:./ingestThis.xml -xsl:../../../Desktop/RepoToolkit/transforms/subject.xslt -o:./subjects.txt`
    self
  end
  def to_nutrition
    `java -cp //Applications/SaxonHE9-7-0-15J/saxon9he.jar net.sf.saxon.Transform -t -s:./collection.xml -xsl:../../../Desktop/RepoToolkit/transforms/Nutrition.xslt -o:./ingestThis.xml`
    `java -cp //Applications/SaxonHE9-7-0-15J/saxon9he.jar net.sf.saxon.Transform -t -s:./ingestThis.xml -xsl:../../../Desktop/RepoToolkit/transforms/subject.xslt -o:./subjects.txt`
    self
  end
  def to_springer
    `java -cp //Applications/SaxonHE9-7-0-15J/saxon9he.jar net.sf.saxon.Transform -t -s:./collection.xml -xsl:../../../../Desktop/RepoToolkit/transforms/Springer.xslt -o:../xml/ingestThis.xml`
    `java -cp //Applications/SaxonHE9-7-0-15J/saxon9he.jar net.sf.saxon.Transform -t -s:./ingestThis.xml -xsl:../../../../Desktop/RepoToolkit/transforms/subject.xslt -o:./subjects.txt`
    self
  end
  def to_proquest
    `java -cp //Applications/SaxonHE9-7-0-15J/saxon9he.jar net.sf.saxon.Transform -t -s:collection.xml -xsl:../../../Desktop/RepoToolkit/transforms/Proquest.xslt -o:./ingestThis.xml`
    `java -cp //Applications/SaxonHE9-7-0-15J/saxon9he.jar net.sf.saxon.Transform -t -s:ingestThis.xml -xsl:../../../Desktop/RepoToolkit/transforms/subject.xslt -o:./subjects.txt`
    self
  end
  def subject_only
    `java -cp //Applications/SaxonHE9-7-0-15J/saxon9he.jar net.sf.saxon.Transform -t -s:xml/ingestThis.xml -xsl:../../../Desktop/RepoToolkit/transforms/subject.xslt -o:xml/subject_update.txt`
     self
  end
end