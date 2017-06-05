<?xml version="1.0" encoding="UTF-8"?>
<!--    
CREATED BY: Alex May, Tisch Library
CREATED ON: 2017-03-31
UPDATED ON: 2017-03-31
This stylesheet converts Excel metadata to qualified Dublin Core based on the mappings found in the MIRA data dictionary.-->
<!--Name space declarations and XSLT version -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="2.0"
    xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcadesc="http://nils.lib.tufts.edu/dcadesc/"
    xmlns:dcterms="http://purl.org/dc/terms/" xmlns:admin="http://nils.lib.tufts.edu/dcaadmin/"
    xmlns:ac="http://purl.org/dc/dcmitype/"
    xmlns:rel="info:fedora/fedora-system:def/relations-external#">
    <!--This calls the named templates found in the following xslt(s) for parsing specific fields into approprite data for ingest  -->
    <xsl:import href="MARC_helper.xslt"/>
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
            <xsl:for-each select="collection/record">
                <digitalObject>
                    <xsl:call-template name="file"/>
                    <rel:hasModel>info:fedora/cm:Text.PDF</rel:hasModel>
                    <xsl:call-template name="title"/>
                    <xsl:call-template name="alternative"/>
                    <xsl:call-template name="creator"/>
                    <xsl:call-template name="contributor"/>
                    <xsl:call-template name="edition"/>
                    <xsl:call-template name="phyical_item_description"/>
                    <xsl:call-template name="notes"/>
                    <xsl:call-template name="toc"/>
                    <xsl:call-template name="boundwith"/>
                    <xsl:call-template name="repoduction_note"/>
                    <xsl:call-template name="provenance"/>
                    <xsl:call-template name="binding"/>
                    <xsl:call-template name="indexed_in"/>
                    <xsl:call-template name="language"/>
                    <xsl:call-template name="internet_archive"/>
                    <dc:publisher>Tufts University. Tisch Library.</dc:publisher>
                    <xsl:call-template name="internet_archive_source"></xsl:call-template>
                    <xsl:call-template name="phys_source"/>
                    <xsl:call-template name="date"/>
                    <dc:date.created><xsl:value-of  select="current-dateTime()"/></dc:date.created>
                    <dc:type>Text</dc:type>
                    <dc:format>application/pdf</dc:format>
                    <xsl:call-template name="persname_subject"/>
                    <xsl:call-template name="corpname_subject"/>
                    <xsl:call-template name="geo_subject"/>
                    <xsl:call-template name="topic_subject"/>
                    <xsl:call-template name="genre"/>
                    <dc:rights>https://sites.tufts.edu/dca/about-us/research-help/reproductions-and-use/</dc:rights>
                    <admin:steward>tisch</admin:steward>
                    <ac:name>amay02</ac:name>
                    <ac:comment>InHouseDigitizationBatchTransform: <xsl:value-of
                        select="current-dateTime()"/></ac:comment>
                    <admin:createdby>externalXSLT</admin:createdby>
                    <!-- this portion inserts the boilerplate batch displays information -->
                    <admin:displays>dl</admin:displays>
                    
                    <!--
                    <xsl:call-template name="description"/>
                    <xsl:call-template name="original_file_name"/>
                    <xsl:call-template name="source"/>
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
                    <dc:rights>https://sites.tufts.edu/dca/about-us/research-help/reproductions-and-use/</dc:rights>
                    <admin:steward>tisch</admin:steward>
                    <ac:name>amay02</ac:name>
                    <xsl:call-template name="admin_comment"/>
                    <xsl:call-template name="admin_displays"/>
                    <xsl:call-template name="embargo"/>
                    -->
                </digitalObject>
            </xsl:for-each>
        </input>
    </xsl:template>
    <xsl:template match="@tag" name="file">
        <xsl:choose>
            <xsl:when
                test="datafield[@tag = '856']/subfield[@code = 'u'][contains(text(), 'archive.org')]">
                <file><xsl:value-of
                        select="datafield[@tag = '856']/subfield[@code = 'u'][contains(text(), 'archive.org')][contains(text(), 'archive.org')]"
                    />.pdf</file>
            </xsl:when>
            <xsl:when
                test="datafield[@tag = '035']/subfield[@code = 'a'][contains(text(), '(OCoLC)')]">
                <file><xsl:value-of
                        select="datafield[@tag = '035']/subfield[@code = 'a'][contains(text(), '(OCoLC)')]/replace(., '\(OCoLC\)', '')"
                    />.pdf</file>
            </xsl:when>
            <xsl:otherwise>
                <file>.pdf</file>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="@tag" name="title">
        <dc:title>
            <xsl:value-of
                select="normalize-space(replace(replace(datafield[@tag = '245'], '\[electronic resource\]', ''), '(/|:|;|,)', '$1 '))"
            />
        </dc:title>
    </xsl:template>
    <xsl:template match="@tag" name="alternative">
        <xsl:for-each select="datafield[@tag = '246']/subfield[@code = 'a']|datafield[@tag = '240']/subfield[@code = 'a']">
            <dcterms:alternative>
                <xsl:value-of select="normalize-space(.)"/>
            </dcterms:alternative>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="@tag" name="creator">
        <xsl:for-each
            select="datafield[@tag = '100'] | datafield[@tag = '110'] | datafield[@tag = '111'] | datafield[@tag = '130']">
            <dc:creator>
                <xsl:call-template name="nameSelect">
                    <xsl:with-param name="delimeter">
                        <xsl:text> </xsl:text>
                    </xsl:with-param>
                </xsl:call-template>
            </dc:creator>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="@tag" name="contributor">
        <xsl:for-each
            select="datafield[@tag = '700'] | datafield[@tag = '710'] | datafield[@tag = '711'] | datafield[@tag = '720']">
            <dcterms:contributor>
                <xsl:call-template name="nameSelect">
                    <xsl:with-param name="delimeter">
                        <xsl:text> </xsl:text>
                    </xsl:with-param>
                </xsl:call-template>
            </dcterms:contributor>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="@tag" name="edition">
        <xsl:choose>
            <xsl:when test="datafield[@tag = '250'][text()]">
                <dc:description>
                    <xsl:value-of select="normalize-space(datafield[@tag = '250'])"/>
                </dc:description>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="@tag" name="phyical_item_description">
        <dc:description>
            <xsl:value-of
                select="normalize-space(replace(replace(datafield[@tag = '300']/replace(., '(\w )$', '$1.'), '(/|:|;|,)', '$1 '), '(\w)$', '$1.'))"
            />
        </dc:description>
    </xsl:template>
    <xsl:template match="@tag" name="notes">
        <xsl:for-each select="datafield[@tag = '500']">
            <dc:description>
                <xsl:value-of
                    select="normalize-space(./replace(., '(MMeT.)|(MMeT)|(MMet)', ''))"
                />
            </dc:description>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="@tag" name="boundwith">
        <xsl:choose>
            <xsl:when test="datafield[@tag = '501'][text()]">
                              <dc:description>Bound with: <xsl:value-of
                                  select="normalize-space(datafield[@tag = '501']/replace(., '(MMeT.)|(MMeT)|(MMet)', ''))"/>
                    </dc:description>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="@tag" name="toc">
        <xsl:choose>
            <xsl:when test="datafield[@tag = '505'][text()]">
                <xsl:for-each select="datafield[@tag = '505']">
                    <dcterms:tableOfContents>Table of Contents: <xsl:value-of
                        select="normalize-space(.)"/>
                    </dcterms:tableOfContents>
                </xsl:for-each>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="@tag" name="indexed_in">
        <xsl:choose>
            <xsl:when test="datafield[@tag = '510'][text()]">
                <xsl:for-each select="datafield[@tag = '510']">
                    <dc:description>Indexed in: <xsl:value-of select="normalize-space(.)"/>
                    </dc:description>
                </xsl:for-each>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="@tag" name="repoduction_note">
        <xsl:choose>
            <xsl:when test="datafield[@tag = '533'][text()]">
                <dc:description>
                    <xsl:value-of
                        select="normalize-space(replace(datafield[@tag = '533']/replace(., '(MMeT.)|(MMeT)|(MMet)', ''), '(:|;|,|\.)', '$1 '))"
                    />
                </dc:description>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="@tag" name="provenance">
        <xsl:choose>
            <xsl:when test="datafield[@tag = '561'][text()]">
                <xsl:for-each select="datafield[@tag = '561']">
                    <dcterms:provenance>Provenance: <xsl:value-of
                        select="normalize-space(./replace(., '(MMeT.)|(MMeT)|(MMet)', ''))"
                    />
                    </dcterms:provenance>
                </xsl:for-each>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="@tag" name="binding">
        <xsl:choose>
            <xsl:when test="datafield[@tag = '563'][text()]">
                <dc:description>
                    <xsl:value-of
                        select="normalize-space(replace(./replace(datafield[@tag = '563'], '(MMeT.)|(MMeT)|(MMet)', ''), '(:|;|,|\.)', '$1 '))"
                    />
                </dc:description>
            </xsl:when>
        </xsl:choose>
    </xsl:template> 
    <xsl:template match="@tag" name="language">
        <dcterms:language>
            <xsl:value-of select="normalize-space(controlfield[@tag = '008']/replace(., '.*?\s0\s|.{2}$', ''))"
            />
        </dcterms:language>
    </xsl:template> 
    <xsl:template match="@tag" name="internet_archive">
        <xsl:choose>
            <xsl:when test="datafield[@tag = '910']/subfield[@code = 'a'][contains(text(), 'Tisch')]">
                <dc:description><xsl:value-of select="normalize-space(./replace(., '.*/', ''))"/>
                </dc:description>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="@tag" name="internet_archive_source">
        <xsl:choose>
            <xsl:when
                test="datafield[@tag = '776']/subfield[@code = 'w'][contains(text(), '(DLC)')]">
                <dc:source>
                    <xsl:value-of
                        select="normalize-space(substring-before(replace(datafield[@tag = '776'], '(/|:|;|,|\.)', '$1 '), '(DLC)'))"
                    />.</dc:source>
            </xsl:when>
            <xsl:when
                test="datafield[@tag = '776']/subfield[@code = 'w'][contains(text(), '(OCoLC)')]">
                <dc:source>
                    <xsl:value-of
                        select="normalize-space(substring-before(replace(datafield[@tag = '776'], '(/|:|;|,|\.)', '$1 '), '(OCoLC)'))"
                    />.</dc:source>
            </xsl:when>
            <xsl:otherwise/>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="@tag" name="phys_source">
        <xsl:choose>
            <xsl:when test="datafield[@tag = '776']/subfield[@code = 'w']">
                <xsl:for-each
                    select="datafield[@tag = '776']/subfield[@code = 'w']">
                    <dc:source>
                        <xsl:value-of select="normalize-space(.)"/>
                    </dc:source>
                </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
                <dc:source>Original print publication: <xsl:value-of
                    select="normalize-space(datafield[@tag = '260'])"
                /></dc:source>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="@tag" name="date">
        <xsl:choose>
            <xsl:when test="controlfield[@tag = '008'][contains(text(), 'm')]">
                <dc:date>
                    <xsl:for-each select="controlfield[@tag = '008']">
                        <xsl:value-of select="normalize-space(./replace(., '^.{7}|\s|\w.?.{16}$', ''))"
                        />
                    </xsl:for-each>
                </dc:date> 
            </xsl:when>
            <xsl:otherwise>
                <dc:date>
                    <xsl:for-each select="controlfield[@tag = '008']">
                        <xsl:value-of select="normalize-space(./replace(., '^.{7}|\s.*?$', ''))"
                        />
                    </xsl:for-each>
                </dc:date> 
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="@tag" name="persname_subject">
        <xsl:choose>
            <xsl:when test="datafield[@tag = 600][text()]">
                <xsl:for-each select="datafield[@tag = 600]">
                    <dcadesc:persname>
                        <xsl:call-template name="nameSelect">
                            <xsl:with-param name="delimeter">
                                <xsl:text> </xsl:text>
                            </xsl:with-param>
                        </xsl:call-template>
                    </dcadesc:persname>
                </xsl:for-each>
            </xsl:when>
            
        </xsl:choose>
    </xsl:template>
    <xsl:template match="@tag" name="corpname_subject">
        <xsl:choose>
            <xsl:when test="datafield[@tag = 610][text()] | datafield[@tag = 611][text()]">
                <xsl:for-each select="datafield[@tag = 610] | datafield[@tag = 611]">
                    <dcadesc:corpname>
                        <xsl:call-template name="subfieldSelect">
                            <xsl:with-param name="delimeter">--</xsl:with-param>
                        </xsl:call-template>
                    </dcadesc:corpname>
                </xsl:for-each>
            </xsl:when>  
        </xsl:choose>
    </xsl:template>
    <xsl:template match="@tag" name="geo_subject">
        <xsl:choose>
            <xsl:when test="datafield[@tag = 651][text()]">
                <xsl:for-each select="datafield[@tag = 651]">
                    <dcadesc:geogname>
                        <xsl:call-template name="subfieldSelect">
                            <xsl:with-param name="delimeter">--</xsl:with-param>
                        </xsl:call-template>
                    </dcadesc:geogname>
                </xsl:for-each>
            </xsl:when>  
        </xsl:choose>
    </xsl:template>
    <xsl:template match="@tag" name="topic_subject">
        <xsl:choose>
            <xsl:when test="datafield[@tag = 650][text()]">
                <xsl:for-each select="datafield[@tag = 650]">
                    <dcadesc:subject>
                        <xsl:call-template name="subfieldSelect">
                            <xsl:with-param name="delimeter">--</xsl:with-param>
                        </xsl:call-template>
                    </dcadesc:subject>
                </xsl:for-each>
            </xsl:when>  
        </xsl:choose>
    </xsl:template>
    <xsl:template match="@tag" name="genre">
        <xsl:choose>
            <xsl:when test="datafield[@tag = 655][text()]">
                <xsl:for-each select="datafield[@tag = '655']">
                    <dcadesc:genre>
                        <xsl:call-template name="subfieldSelect">
                            <xsl:with-param name="delimeter">--</xsl:with-param>
                        </xsl:call-template>
                    </dcadesc:genre>
                </xsl:for-each>
            </xsl:when>  
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>
