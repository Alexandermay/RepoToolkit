# RepoToolkit
A toolkit for proto-SIP processing at Tisch Library using a Ruby front-end to launch a set of xslts, and repackage the content consistently for ingest into MIRA.

**Requirements**
* Java
* Saxon
* Ruby 2.0.0
* Roo
* Nokogiri

This should work in Windows, MacOS, and Unix environments.

For installation, perform the following at the command prompt:

1. Install [Ruby](https://www.ruby-lang.org/en/downloads/) (at least 2.0.0).  To test your version number, type:

         $ ruby -v
 
2. Install [Java](https://www.java.com/en/download/). In MacOS, you can install Java with [Homebrew](https://brew.sh/):

         $ brew cask install java

3. Download the latest version of [Saxon-HE](https://sourceforge.net/projects/saxon/files/) from [Saxonica](http://www.saxonica.com/download/opensource.xml).  Saxon can be installed in any folder.  Create an Environment Variable named SAXON_PATH containing the full pathname to the saxon jar file, e.g.:

         //Applications/SaxonHE9-7-0-15J/saxon9he.jar
         or
         C:\Users\smcdon03\Desktop\SaxonHE9-8-0-8J\saxon9he.jar

4. Install [roo](https://github.com/roo-rb/roo) as a gem:

         $ gem install roo
         
5. Install [nokogiri](http://www.nokogiri.org/tutorials/installing_nokogiri.html) (Review nokogiri documentation.)  Nokogiri might be already installed as part of roo.
       
6. Install [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)

7. Change your directory to where you want to install the Repotoolkit.  It may be installed in your Desktop folder, or any other folder you want.

         $ cd Desktop
        
8. Clone the ToolKit

         $ git clone https://github.com/Alexandermay/RepoToolkit.git
 
9. Change directory to RepoToolKit\bin

         $ cd RepoToolKit\bin
        		  
10. Run the launcher.rb

         $ ruby launcher.rb

11. You should now see a welcome screen with a list of options.

        
            Welcome to the Repository Toolkit for MIRA 1.0!

            What would you like to process?

            1. Faculty Scholarship.
            2. Student Scholarship.
            3. Nutrition School.
            4. Art and Art History (Trove).
            5. Springer Open Access Articles.
            6. Proquest Electronic Disertations and Theses.
            7. In-House digitized books.
            8. Subject Analysis.
            9. SMFA Artist Books.
            10. Exit.

            repotoolkit> 

                  

12.   Test the install by typing "1" at the prompt.  This will launch the Faculty script.

         Launching the Faculty Scholarship script.
         What is the directory you are working with?
         repotoolkit>

+   At the prompt (`>`) enter the absolute path to the `sample_set` directory[^1]
+   If you drag and drop the directory, make sure to delete any trailing whitespace.[^2] 
+   Hit `return`
+ You should then see that the files are being moved into their respective directories, and Saxon is launched to transform the .xslx into the XML Tisch needs to despoit items into the repository.
+ When it finishes, you will be given an option to review the xml.  It is best if you have oXygen, otherwise it will open in a generic text editor.

**So, did it work?**

If `ingestThis.xml` is produced, and the content is packaged into excel, pdf and xml directories respectively, then you are set to process content for ingest into MIRA.  Remember the following:
+ The Proquest and Springer processes require zip files in their own directory.
+ The Trove, Faculty and Student processes require .xlsx files and their respective binaries.
+ The inHouse Digitization process needs a MARC xml file and binaries.
+ The Cataloger Subject Analysis should be run against Trove, Faculty, or Student processes, simply drag and drop the entire directory to get an updated analysis.


---

[^1]: The sample content is a pdf and .xlsx that I put together, so for the purposes of testing the install, we should be ok. That said, the only people installing this should be from Tisch.

[^2]: When I enter the absolute path on my Mac it looks like this, with no trailing whitespace: 
            `repotoolkit> /Users/amay02/Desktop/RepoToolkit/sample_set`
