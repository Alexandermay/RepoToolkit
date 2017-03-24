module Transforms
  def transform_excel
    `java -cp //Applications/SaxonHE9-7-0-15J/saxon9he.jar net.sf.saxon.Transform -t -s:./firstTransform.xml -xsl:../../RepoToolkit/transforms/extract_excel.xslt -o:./workWithThis.xml`
    self
  end
  def transform_it_faculty
    `java -cp //Applications/SaxonHE9-7-0-15J/saxon9he.jar net.sf.saxon.Transform -t -s:collection.xml -xsl:../../RepoToolkit/transforms/Faculty.xslt -o:./ingestThis.xml`
    `java -cp //Applications/SaxonHE9-7-0-15J/saxon9he.jar net.sf.saxon.Transform -t -s:ingestThis.xml -xsl:../../RepoToolkit/transforms/subject.xslt -o:./subjects.txt`
    self
  end
  def transform_it_student
    `java -cp //Applications/SaxonHE9-7-0-15J/saxon9he.jar net.sf.saxon.Transform -t -s:collection.xml -xsl:../../RepoToolkit/transforms/Student.xslt -o:./ingestThis.xml`
    `java -cp //Applications/SaxonHE9-7-0-15J/saxon9he.jar net.sf.saxon.Transform -t -s:ingestThis.xml -xsl:../../RepoToolkit/transforms/transforms/subject.xslt -o:./subjects.txt`
    self
  end
  def transform_it_trove
    `java -cp //Applications/SaxonHE9-7-0-15J/saxon9he.jar net.sf.saxon.Transform -t -s:./collection.xml -xsl:../../RepoToolkit/transforms/Trove.xslt -o:./ingestThis.xml`
    `java -cp //Applications/SaxonHE9-7-0-15J/saxon9he.jar net.sf.saxon.Transform -t -s:./ingestThis.xml -xsl:../../RepoToolkit/transforms/subject.xslt -o:./subjects.txt`
    self
  end
  def transform_it_nutrition
    `java -cp //Applications/SaxonHE9-7-0-15J/saxon9he.jar net.sf.saxon.Transform -t -s:./collection.xml -xsl:../../RepoToolkit/transforms/Nutrition.xslt -o:./ingestThis.xml`
    `java -cp //Applications/SaxonHE9-7-0-15J/saxon9he.jar net.sf.saxon.Transform -t -s:./ingestThis.xml -xsl:../../RepoToolkit/transforms/subject.xslt -o:./subjects.txt`
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