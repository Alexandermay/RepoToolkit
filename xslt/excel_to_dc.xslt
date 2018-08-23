<?xml version="1.0" encoding="UTF-8"?>
<!--    
CREATED BY: Alex May, Tisch Library
CREATED ON: 2017-03-31
UPDATED ON: 2017-03-31
This stylesheet converts Excel metadata to qualified Dublin Core based on the mappings found in the MIRA data dictionary.-->
<!--Name space declarations and XSLT version -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="2.0"
    xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:dc11="http://purl.org/dc/elements/1.1/"
    xmlns:dcadesc="http://nils.lib.tufts.edu/dcadesc/"   
    xmlns:dcterms="http://purl.org/dc/terms/"
    xmlns:admin="http://nils.lib.tufts.edu/dcaadmin/"
    xmlns:ac="http://purl.org/dc/dcmitype/"
    xmlns:rel="info:fedora/fedora-system:def/relations-external#">
    <!--This calls the named templates found in the following xslt(s) for parsing specific fields into approprite data for ingest  -->
    <xsl:import href="SplitField_helper.xslt"/>
    <xsl:import href="Filename_helper.xslt"/>
    <!--This changes the output to xml -->
    <xsl:output method="xml" indent="yes" use-character-maps="killSmartPunctuation" encoding="UTF-8"/>
    <xsl:character-map name="killSmartPunctuation">
        <xsl:output-character character="“" string="&quot;"/>
        <xsl:output-character character="”" string="&quot;"/>
        <xsl:output-character character="’" string="'"/>
        <xsl:output-character character="‘" string="'"/>
        <xsl:output-character character="&#x2013;" string="-"/>
    </xsl:character-map>
    <!-- this starts the crosswalk-->
    <xsl:template match="/">
        <input xmlns:dc="http://purl.org/dc/elements/1.1/"
            xmlns:dcadesc="http://nils.lib.tufts.edu/dcadesc/"
            xmlns:dcatech="http://nils.lib.tufts.edu/dcatech/"
            xmlns:dcterms="http://purl.org/dc/terms/"
            xmlns:admin="http://nils.lib.tufts.edu/dcaadmin/"
            xmlns:ac="http://purl.org/dc/dcmitype/"
            xmlns:rel="info:fedora/fedora-system:def/relations-external#">
            <xsl:for-each select="collection('../TempRepo/collection.xml')/root/row">
                <digitalObject>
                    <xsl:call-template name="file"/>
                    <xsl:call-template name="has_model"/>
                    <xsl:call-template name="title"/>
                    <xsl:call-template name="alternative"/>
                    <xsl:call-template name="creator"/>
                    <xsl:call-template name="contributor"/>
                    <xsl:call-template name="description"/>
                    <xsl:call-template name="original_file_name"/>
                    <xsl:call-template name="source_bibliographicCitation"/>
                    <xsl:call-template name="bibliographicCitation"/>
                    <xsl:call-template name="is_part_of"/>
                    <dc:publisher>Tufts University. Tisch Library.</dc:publisher>
                    <xsl:call-template name="date"/>
                    <dc:date.created><xsl:value-of  select="current-dateTime()"/></dc:date.created>
                    <xsl:call-template name="type"/>
                    <xsl:call-template name="format"/>
                    <xsl:call-template name="subject"/>
                    <xsl:call-template name="persname"/>
                    <xsl:call-template name="corpname"/>
                    <xsl:call-template name="geogname"/>
                    <xsl:call-template name="genre"/>
                    <xsl:call-template name="temporal"/>
                    <xsl:call-template name="spatial"/>
                    <xsl:call-template name="license"/>
                    <xsl:call-template name="test"/>
                    <admin:steward>tisch</admin:steward>
                    <ac:name>amay02</ac:name>
                    <xsl:call-template name="admin_comment"/>
                    <xsl:call-template name="admin_displays"/>
                    <xsl:call-template name="embargo"/>
                </digitalObject>
            </xsl:for-each>
        </input>
    </xsl:template>
    <xsl:template match="Accession" name="file">
        <file>
            <xsl:call-template name="filename">
                <xsl:with-param name="file"/>
            </xsl:call-template>
        </file> 
    </xsl:template>
    <xsl:template match="Format" name ="has_model">
        <xsl:choose>
            <xsl:when test="Format = 'application/mp3'">
                <rel:hasModel>info:fedora/cm:Audio</rel:hasModel>
            </xsl:when>
            <xsl:when test="Format = 'application/mp4'">
                <rel:hasModel>info:fedora/afmodel:TuftsVideo</rel:hasModel>
            </xsl:when>
            <xsl:when test="Format = 'image/tiff'">
                <rel:hasModel>info:fedora/cm:Image.4DS</rel:hasModel>
            </xsl:when>
            <xsl:when test="Format = 'Image/tiff'">
                <rel:hasModel>info:fedora/cm:Image.4DS</rel:hasModel>
            </xsl:when>
            <xsl:otherwise>
                <rel:hasModel>info:fedora/cm:Text.PDF</rel:hasModel>
            </xsl:otherwise>
        </xsl:choose> 
    </xsl:template>
    <xsl:template match="Title" name="title">
        <dc:title>
            <xsl:value-of select="normalize-space(replace(replace(Title,'\.$',''),'; ',';'))"
            />.</dc:title>
    </xsl:template>
    <xsl:template match="Alternative_Title" name="alternative">
        <xsl:call-template name="altTitleSplit">
            <xsl:with-param name="altTitleText">
                <dcterms:alternative>
                    <xsl:value-of select="normalize-space(replace(replace(Alternative_Title,'\.$',''),'; ',';'))"/>
                </dcterms:alternative>
            </xsl:with-param>
        </xsl:call-template>
    </xsl:template>
    <xsl:template match ="Creator" name="creator">
        <xsl:call-template name="CreatorSplit">
            <xsl:with-param name="creatorText">
                <xsl:value-of select="normalize-space(Creator)"/>
            </xsl:with-param>
        </xsl:call-template> 
    </xsl:template>
    <xsl:template match ="Contributors" name="contributor">
        <xsl:call-template name="ContributorSplit">
            <xsl:with-param name="contributorText">
                <xsl:value-of select="normalize-space(Contributors)"/>
            </xsl:with-param>
        </xsl:call-template>       
    </xsl:template>
    <xsl:template match ="Description" name="description">
        <xsl:call-template name="DescriptionSplit">
            <xsl:with-param name="descriptionText">
                <xsl:value-of
                    select="normalize-space(Description)"/>
            </xsl:with-param>
        </xsl:call-template>     
    </xsl:template>
    <xsl:template match ="Accession" name ="original_file_name">
        <dc:description>Original file name: <xsl:value-of
            select="normalize-space(Accession)"/>
        </dc:description>       
    </xsl:template>
    <xsl:template match ="Source" name="source_bibliographicCitation">
        <xsl:choose>
            <xsl:when test="Process[contains(text(),'Trove')]">
                 <dc:source><xsl:value-of select="normalize-space(Source)"/></dc:source>
            </xsl:when>
            <xsl:when test="Process[contains(text(),'SMFA')]">
                <dc:source><xsl:value-of select="normalize-space(Source)"/></dc:source>
            </xsl:when>
            <xsl:otherwise>
                <dc:bibliographicCitation>
                    <xsl:value-of select="normalize-space(Source)"/>
                </dc:bibliographicCitation>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="bibliographicCitation" name="bibliographicCitation">
        <xsl:choose>
            <xsl:when test="bibliographicCitation[text()]">
                <dc:bibliographicCitation>
                    <xsl:value-of select="normalize-space(bibliographicCitation)"/>
                </dc:bibliographicCitation>  
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="Process" name="is_part_of">
        <xsl:choose>
            <xsl:when test="Process[contains(text(),'Faculty')]">
                <dcterms:isPartOf>Tufts University faculty scholarship.</dcterms:isPartOf>
            </xsl:when>
            <xsl:when test="Process[contains(text(),'Nutrition')]">
                <dcterms:isPartOf>Tufts University faculty scholarship.</dcterms:isPartOf>
            </xsl:when>
            <xsl:when test="Process[contains(text(),'Student')]">
                <dcterms:isPartOf>Tufts University student scholarship.</dcterms:isPartOf>
            </xsl:when>
            <xsl:when test="Process[contains(text(),'SMFA')]">
                <dcterms:isPartOf>Digitized books.</dcterms:isPartOf>
                <dcterms:isPartOf>SMFA Artist books.</dcterms:isPartOf>
            </xsl:when>
            <xsl:otherwise/>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="abstract" name="abstract"/>
    <xsl:template match ="Date_Created" name="date">
        <xsl:call-template name="dateSplit">
            <xsl:with-param name="dateText">
                <xsl:value-of select="normalize-space(Date_Created)"/>
            </xsl:with-param>
        </xsl:call-template>       
    </xsl:template>
    <xsl:template match="Type" name ="type">
        <dc:type>
            <xsl:value-of select="normalize-space(Type)"/>
        </dc:type>    
    </xsl:template>
    <xsl:template match ="Format" name ="format">
        <dc:format>
            <xsl:value-of select="normalize-space(lower-case(Format))"/>
        </dc:format>        
    </xsl:template>
    <xsl:template match="Subject" name="subject">
        <xsl:call-template name="SubjectSplit">
            <xsl:with-param name="subjectText">
                <xsl:value-of select="normalize-space(Subject)"/>
            </xsl:with-param>
        </xsl:call-template>  
    </xsl:template>
    <xsl:template match="personalNames" name="persname">
       <xsl:call-template name="persNames">
        <xsl:with-param name="persText">
            <xsl:value-of select="normalize-space(personalNames)"/>
        </xsl:with-param>
       </xsl:call-template>    
    </xsl:template>
    <xsl:template match ="corporateNames" name="corpname">
        <xsl:call-template name="corpNames">
            <xsl:with-param name="corpText">
                <xsl:value-of select="normalize-space(corporateNames)"/>
            </xsl:with-param>
        </xsl:call-template>    
    </xsl:template>
    <xsl:template match ="geographicTerms" name="geogname">
        <xsl:call-template name="geogNames">
            <xsl:with-param name="geogText">
                <xsl:value-of select="normalize-space(geographicTerms)"/>
            </xsl:with-param>
        </xsl:call-template>
    </xsl:template>
    <xsl:template match ="Genre" name="genre">
        <xsl:call-template name="GenreSplit">
            <xsl:with-param name="genreText">
                <xsl:value-of select="normalize-space(Genre)"/>
            </xsl:with-param>
        </xsl:call-template>
    </xsl:template>
    <xsl:template match="Century" name="temporal">
        <xsl:call-template name="TemporalSplit">
            <xsl:with-param name="temporalText">
                <xsl:value-of select="normalize-space(replace(Century,'\..$',''))"/>
            </xsl:with-param>
        </xsl:call-template>       
    </xsl:template>
    <xsl:template match="Spatial" name="spatial">
        <xsl:call-template name="SpatialSplit">
            <xsl:with-param name="SpatialSplitText">
                <xsl:value-of select="normalize-space(Spatial)"/>
            </xsl:with-param>
        </xsl:call-template>       
    </xsl:template>
    <xsl:template match="Process" name="admin_displays">
        <xsl:choose>
            <xsl:when test="Process[contains(text(),'Trove')]">
                <admin:displays>trove</admin:displays>
                <admin:visibility>authenticated</admin:visibility>
            </xsl:when>
            <xsl:otherwise>
                <admin:displays>dl</admin:displays>  
            </xsl:otherwise>
        </xsl:choose>           
    </xsl:template>
    <xsl:template match="Process" name="admin_comment">
        <xsl:choose>
            <xsl:when test="Process[contains(text(),'Trove')]">
                <ac:comment>ArtBatchIngest: <xsl:value-of  select="current-dateTime()"/>; Tisch manages metadata and binary.</ac:comment>
            </xsl:when>
            <xsl:when test="Process[contains(text(),'Faculty')]">
                <ac:comment>FacultyScholarshipIngest: <xsl:value-of  select="current-dateTime()"/>; Tisch manages metadata and binary.</ac:comment>
            </xsl:when>
            <xsl:when test="Process[contains(text(),'Student')]">
                <ac:comment>StudentScholarshipIngest: <xsl:value-of  select="current-dateTime()"/>; Tisch manages metadata and binary.</ac:comment>
            </xsl:when>
            <xsl:when test="Process[contains(text(),'Nutrition')]">
                <ac:comment>NutritionBatchTransform: <xsl:value-of  select="current-dateTime()"/>; Tisch manages metadata and binary.</ac:comment>
            </xsl:when>
            <xsl:when test="Process[contains(text(),'SMFA')]">
                <ac:comment>SMFA_ArtistBooksBatchIngest: <xsl:value-of  select="current-dateTime()"/>; Tisch manages metadata and binary.</ac:comment>
            </xsl:when>
            <xsl:otherwise>
                <ac:comment>NEW_CREATE_PROCESS_NEEDED</ac:comment> 
            </xsl:otherwise>
        </xsl:choose>    
    </xsl:template>
    <xsl:template match="Rights" name="license">
        <dcterms:license>
            <xsl:value-of select="normalize-space(Rights)"/>
        </dcterms:license>   
    </xsl:template>
    <xsl:template match="Embargo" name="embargo">
        <admin:embargo>
            <xsl:value-of select="normalize-space(Embargo)"/>
        </admin:embargo>       
    </xsl:template>
    <xsl:template match="License" name="test">
        <xsl:choose>
            <xsl:when test=".//License[contains(.,text())]">
                <dc:rights>
            <xsl:value-of select="normalize-space(License)"/>
        </dc:rights> 
            </xsl:when>
            <xsl:otherwise>
                <dc:rights>https://sites.tufts.edu/dca/about-us/research-help/reproductions-and-use/</dc:rights>
            </xsl:otherwise>
        </xsl:choose>    
    </xsl:template>
</xsl:stylesheet>
