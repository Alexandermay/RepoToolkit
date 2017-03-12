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
 
2. If you don’t have Java, install it with Homebrew:

        `$ brew cask install java`

3. Download [Saxon-HE](http://www.saxonica.com/download/opensource.xml) and put it in your Applications folder. Make sure the jar files is in the following path.

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

10.   Test the install by typing "2" at the prompt.  This will launch the Springer script.

        `Launching the Springer processing script.`
        `What is the directory you are working with?`
        `>`

+   At this prompt enter the absolute path to the sample_springer_open directory[^1]
+   If you drag and drop the directory, make sure to delete any trailing whitespace.[^2] 

Note:

If **1_ingestThis.xml** is produced, and the content from Springer is packaged into pdf, xml and zip directories respectively, then you are set to process content for ingest into MIRA.  Remember the following:
+ The Proquest and Springer processes require zip files in their own directory.
+ The Trove, Faculty and Student processes require .xlsx files and their respective binaries.
+ The inHouse Digitization process needs a MARC xml file and binaries.


---

[^1]: The sample content is a zip file of open access articles from Springer, and each article comes with a Creative Commons 4.0 license, so for the purposes of testing the install, we should be ok. That said, the only people installing this should be from Tisch.

[^2]: When I enter the absolute path on my Mac it looks like this, with no trailing whitespace: 
            `/Users/amay02/Desktop/RepoToolkit/sample_springer_open`


        


