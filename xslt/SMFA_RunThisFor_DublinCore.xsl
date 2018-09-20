<?xml version="1.0" encoding="UTF-8"?> 
<!-- CREATED BY: Alex May, Tisch Library CREATED ON: 2018-09-05. This stylesheet converts Shared Shelf metadata to qualified Dublin Core based on the mappings found in the MIRA data dictionary.--> 
<!--Name space declarations and XSLT version -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="2.0"
    xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcadesc="http://nils.lib.tufts.edu/dcadesc/"
    xmlns:dcatech="http://nils.lib.tufts.edu/dcatech/" xmlns:dcterms="http://purl.org/dc/terms/"
    xmlns:admin="http://nils.lib.tufts.edu/dcaadmin/" xmlns:ac="http://purl.org/dc/dcmitype/"
    xmlns:rel="info:fedora/fedora-system:def/relations-external#">
    <xsl:import href="Filename_helper_2.xslt"/>
    <xsl:import href="SplitField_helper.xslt"/>
    <!--This changes the output to xml -->
    <xsl:output method="xml" indent="yes" use-character-maps="killSmartPunctuation" encoding="UTF-8"/>
    <!-- Kill smart punctuation and force UTF-8 compliance -->
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
            <!-- Order our output -->
            <xsl:for-each select="//row">
                <xsl:sort select=".//SSID" order="ascending"/>
                <xsl:sort select=".//Filename" order="ascending"/>
                <!-- Call the templates and fill in the xml accroding to expected Trove order -->
                <digitalObject>
                    <xsl:call-template name="file"/>
                    <rel:hasModel>info:fedora/cm:Image.4DS</rel:hasModel>
                    <xsl:call-template name="title"/>
                    <xsl:call-template name="creator"/>
                    <xsl:call-template name="description"/>
                    <xsl:call-template name="source"/>
                    <dc:publisher>Tufts University. Tisch Library.</dc:publisher>
                    <dcterms:isPartOf>SMFA collection.</dcterms:isPartOf>
                    <xsl:call-template name="earlydate"/>
                    <xsl:call-template name="latedate"/>
                    <dc:type>Image</dc:type>
                    <dc:format>image/tiff</dc:format>
                    <xsl:call-template name="genre_1"/>
                    <xsl:call-template name="culture"/>
                    <dc:rights>http://rightsstatements.org/vocab/CNE/1.0/</dc:rights>
                    <admin:steward>tisch</admin:steward>
                    <admin:displays>trove</admin:displays>
                    <admin:visibility>authenticated</admin:visibility>
                    <ac:name>amay02</ac:name>
                    <ac:comment>SMFA_batch_ingest: <xsl:value-of  select="current-dateTime()"/>; Tisch manages metadata and binary. Migrated from the ArtStor Sharedshelf SMFA collection.</ac:comment>
                </digitalObject>
            </xsl:for-each>
        </input>
    </xsl:template>
    <!-- Template to create a file name for trove to attach the binary to the record -->
    <xsl:template match=".//Filename" name="file">
        <file>SSID<xsl:value-of select="normalize-space(.//SSID)"/>_<xsl:value-of select="normalize-space(.//Filename)"/></file>
    </xsl:template>
    <!-- Template that maps title to title, and uses regex to normalize terminal puncuation -->
    <xsl:template match=".//Title_24862_" name="title">
        <dc:title>
            <xsl:value-of select="normalize-space(replace(.//Title_24862_, '\.', ''))"/>.</dc:title>
    </xsl:template>
    <!-- Template that maps creator to creator, and uses regex to normalize terminal punctuation -->
    <xsl:template match=".//Creator_24860_" name="creator">
        <xsl:for-each select=".//*[contains(name(), 'Creator')]">
            <dc:creator>
                <xsl:value-of select="normalize-space(replace(replace(.,'(\s$)',''),'(\w$)','$1.'))"/></dc:creator>
        </xsl:for-each>
        <!-- Template that creates a description based on whether or not shared shelf elements have strings, if we see issues it will be here -->
    </xsl:template>
    <xsl:template match=".//row" name="description">
        <dc:description><xsl:choose><xsl:when test=".//Description_24881_[. != '']"><xsl:value-of select="replace(.//Description_24881_,'\.$','')"/>. </xsl:when><xsl:otherwise/></xsl:choose><xsl:choose><xsl:when test=".//Image_View_Type_24864_[. != '']"><xsl:text>Type of view: </xsl:text><xsl:value-of select=".//Image_View_Type_24864_"/>. </xsl:when><xsl:otherwise/></xsl:choose><xsl:choose><xsl:when test=".//Image_View_Description_24863_[. != '']"><xsl:text>Image view: </xsl:text><xsl:value-of select=".//Image_View_Description_24863_"/>. </xsl:when><xsl:otherwise/></xsl:choose><xsl:choose><xsl:when test=".//Image_View_Type_24864_[. != '']"><xsl:text>Type of view: </xsl:text><xsl:value-of select=".//Image_View_Type_24864_"/>. </xsl:when><xsl:otherwise/></xsl:choose><xsl:text>Date created: </xsl:text><xsl:value-of select="normalize-space(replace(.//Date_24865_,'\.',''))"/>. <xsl:choose>    
            <xsl:when test="././Style_Period_24868_[. != '']"><xsl:text>Style/Period: </xsl:text><xsl:value-of select=".//Style_Period_24868_"/>. </xsl:when><xsl:otherwise/></xsl:choose><xsl:text>Materials: </xsl:text><xsl:value-of select="normalize-space(replace(.//Materials_Techniques_24869_, '\.', ''))"/>. <xsl:choose>    
                <xsl:when test=".//Measurements_24870_[* != '']"><xsl:text>Measurements: </xsl:text><xsl:value-of select=".//Measurements_24870_"/>.</xsl:when><xsl:otherwise/></xsl:choose> Keyword(s): <xsl:value-of select="normalize-space(.//Artstor_Classification_24871_)"/>. <xsl:choose>    
                    <xsl:when test="./Repository_24873_[. != '']"><xsl:text>Currently housed at: </xsl:text><xsl:value-of select="replace(.//.//Repository_24873_,'\.$','')"/>.</xsl:when><xsl:otherwise/></xsl:choose></dc:description>
    </xsl:template>     
    <!-- Template that maps earliest date to dcterms:date which will be a place holder until we deploy edm:earliest_date -->
    <xsl:template match="Earliest_Date_24866_" name="earlydate">
        <dcterms:date>
            <xsl:value-of select=".//Earliest_Date_24866_"/>
        </dcterms:date>
    </xsl:template>
    <!-- Template that maps latest date to dcterms:date which will be a place holder until we deploy edm:latest_date -->
    <xsl:template match="Latest_Date_24867_" name="latedate">
        <dcterms:date>
            <xsl:value-of select=".//Latest_Date_24867_"/>
        </dcterms:date>
    </xsl:template>
    <!-- Template that maps Getty AAT subjects to Genre, which is where Trove puts Getty terms -->
    <xsl:template match ="Subject_24882_" name="genre_1">
        <xsl:call-template name="GenreSplit">
            <xsl:with-param name="genreText">
                <xsl:value-of select="normalize-space(Subject_24882_)"/>
            </xsl:with-param>
        </xsl:call-template>
    </xsl:template>
    <!-- Template that maps Getty Culture terms to Genere, which is where Trove puts Getty terms -->
    <xsl:template match="Culture_24861_" name="culture">
                <dcadesc:genre>
                    <xsl:value-of select="normalize-space(.//Culture_24861_)"/>
                </dcadesc:genre>        
    </xsl:template>
    <!-- Template that maps image_source to dc:source -->
    <xsl:template match="Image_Source_24884_" name="source">
        <dc:source>
            <xsl:value-of select="normalize-space(Image_Source_24884_)"/>
        </dc:source> 
   </xsl:template>    
</xsl:stylesheet>
