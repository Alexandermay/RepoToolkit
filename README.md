# RepoToolkit
A toolkit for proto-SIP processing at Tisch Library using a Ruby front-end to launch a set of xslts, and repackage the content consistently for ingest into MIRA.

**Dependencies**
* Java
* Saxon
* Ruby 2.0.0
* Roo

Currently set for a very localized MacOS environment.

1. Make sure you have Ruby (at least 2.0.0)

        `$ ruby -v` 
 
2. If you don’t have Java, install it with [Homebrew](https://brew.sh/):

        `$ brew cask install java`

3. Download the latest version of [Saxon-HE](https://sourceforge.net/projects/saxon/files/) from [Saxonica](http://www.saxonica.com/download/opensource.xml) and put it in your Applications folder. Make sure the jar file we need to run the transforms is in the following path.

        `//Applications/SaxonHE9-7-0-15J/saxon9he.jar`

4. Install [roo](https://github.com/roo-rb/roo) as a gem:

        `$ gem install roo`
        
5. Change your directory to your Desktop.

        `$ cd Desktop`
        
6. Clone the ToolKit

        `$ git clone https://github.com/Alexandermay/RepoToolkit.git`
 
7. Change directory from Desktop to RepoToolKit\scripts

        `$ cd RepoToolKit\scripts`
        		  
8. Run the launcher.rb

        `$ ruby launcher.rb`

9. You should now see a welcome screen with a list of options.

        ```
        
          Welcome to the Repository Toolkit!
          What would you like to process?
           1. Proquest Electronic Disertations and Theses.
           2. Springer Open Access Articles.
           3. Art and Art History (Trove)
           4. Faculty Scholarship. 
           5. Student Scholarship.
           6. InHouse Digitization files.
           7. Cataloger Subject Analysis.
           8. Exit.
            
        ```        

10.   Test the install by typing "4" at the prompt.  This will launch the Springer script.

        `Launching the Faculty Scholarship script.`
        `What is the directory you are working with?`
        `>`

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
            `>/Users/amay02/Desktop/RepoToolkit/sample_set`


        


