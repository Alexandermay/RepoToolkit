<?xml version="1.0" encoding="UTF-8"?>
<!--    
CREATED BY: Alex May, Tisch Library
CREATED ON: 2017-03-31
UPDATED ON: 2017-03-31
This stylesheet converts Springer metadata to qualified Dublin Core based on the mappings found in the MIRA data dictionary.-->
<!--Name space declarations and XSLT version -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="2.0"
    xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:dcterms="http://purl.org/dc/terms/">
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
            <xsl:for-each select="collection('../../RepoToolKit/TempRepo/xml/collection.xml')">
                <digitalObject>
                    <xsl:call-template name="file"/>
                    <rel:hasModel>info:fedora/cm:Text.PDF</rel:hasModel>
                    <xsl:call-template name="title"/>
                    <xsl:call-template name="creator"/>
                    <xsl:call-template name="abstract"/>
                    <xsl:call-template name="keywords"/>
                    <dc:description>Springer Open.</dc:description>
                    <dcterms:isPartOf>Tufts University faculty scholarship.</dcterms:isPartOf>
                    <xsl:call-template name="rights"/>
                    <xsl:call-template name="date"/>
                    <dc:date.created><xsl:value-of  select="current-dateTime()"/></dc:date.created>
                    <dc:type>Text</dc:type>
                    <dc:format>application/pdf</dc:format>
                    <admin:steward>tisch</admin:steward>
                    <ac:name>amay02</ac:name>
                    <ac:comment>SpringerBatchTransform: <xsl:value-of
                        select="current-dateTime()"/></ac:comment>
                    <admin:createdby>Tisch metadata staff.</admin:createdby>
                    <admin:displays>dl</admin:displays>
                </digitalObject>
            </xsl:for-each>
        </input>
    </xsl:template>
    <xsl:template match="//JournalInfo" name="file">
        <file><xsl:value-of select="//JournalInfo/JournalID"/>_<xsl:value-of
                select="//RegistrationDate/Year"/>_Article_<xsl:value-of select="//ArticleID"
            />.pdf</file>
    </xsl:template>
    <xsl:template match="//ArticleTitle" name="title">
        <dc:title>
            <xsl:value-of select="replace(//ArticleTitle, '\.+$', '')"/>
            <xsl:text>.</xsl:text>
        </dc:title>
    </xsl:template>
    <xsl:template match="//Author" name="creator">
        <xsl:for-each
            select="//Author">
            <xsl:choose>
                <xsl:when test=".//GivenName[2]">
                    <dc:creator><xsl:value-of select="normalize-space(.//FamilyName)"/>, <xsl:value-of select="normalize-space(.//GivenName[1])"/><xsl:text> </xsl:text><xsl:value-of select="normalize-space(replace(.//GivenName[2],'\.+$',''))"/><xsl:text>.</xsl:text></dc:creator>
                </xsl:when>
                <xsl:otherwise>
                    <dc:creator><xsl:value-of select="normalize-space(.//FamilyName)"/>, <xsl:value-of select="normalize-space(.//GivenName[1])"/><xsl:text>.</xsl:text></dc:creator>
                </xsl:otherwise> 
            </xsl:choose>                      
        </xsl:for-each>
    </xsl:template>
    <xsl:template name="abstract">
        <xsl:choose>
            <xsl:when test="//AbstractSection[@ID]/Heading">
                <dc:description>  
                    <xsl:value-of select=".//AbstractSection[@ID][1]/Heading"/>: <xsl:value-of
                        select=".//AbstractSection[@ID][1]/Para[1]"/> 
                </dc:description>  
            </xsl:when>
            <xsl:when test="//Abstract/Heading">
                <dc:description>  
                    <xsl:value-of select=".//Abstract/Heading"/>: <xsl:value-of
                        select="normalize-space(.//Abstract[1]/Para[1])"/></dc:description>  
            </xsl:when>
            <xsl:otherwise/>    
        </xsl:choose>
    </xsl:template>
    <xsl:template name="keywords">
        <xsl:choose>
            <xsl:when test=".//KeywordGroup/Heading">
                <dc:description>
                    <xsl:value-of select=".//KeywordGroup/Heading"/>: <xsl:for-each select=".//Keyword[not(position()=last())]"><xsl:value-of select="normalize-space(.)"/><xsl:text>, </xsl:text></xsl:for-each>
                    <xsl:if test=".//Keyword[last()]">
                        <xsl:value-of select="normalize-space(.//Keyword[last()])"/><xsl:text>.</xsl:text>
                    </xsl:if>
                </dc:description> 
            </xsl:when>
            <xsl:when test=".//KeywordGroup">
                <dc:description>
                    <xsl:text>Keywords: </xsl:text><xsl:for-each select=".//Keyword[not(position()=last())]"><xsl:value-of select="normalize-space(.)"/><xsl:text>, </xsl:text></xsl:for-each>
                    <xsl:if test=".//Keyword[last()]">
                        <xsl:value-of select="normalize-space(.//Keyword[last()])"/><xsl:text>.</xsl:text>
                    </xsl:if>
                </dc:description> 
            </xsl:when>
            <xsl:when test=".//AbbreviationGroup">
                <dc:description>  
                    <xsl:text>Keywords: </xsl:text><xsl:for-each select=".//AbbreviationGroup/DefinitionList/DefinitionListEntry[not(position()=last())]"><xsl:value-of select="normalize-space(.//Para)"/><xsl:text>, </xsl:text></xsl:for-each>
                    <xsl:if test=".//AbbreviationGroup/DefinitionList/DefinitionListEntry[position()=last()]">
                        <xsl:value-of select="normalize-space(replace(.//AbbreviationGroup/DefinitionList/DefinitionListEntry[last()]/Description/Para,'\.+$',''))"/><xsl:text>.</xsl:text>
                    </xsl:if>
                </dc:description>  
            </xsl:when>
            <xsl:otherwise/>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="rights">
        <xsl:choose>
            <xsl:when test=".//ArticleCopyright/CopyrightComment/SimplePara/ExternalRef[1]/RefTarget[1]/@Address">
                <dc:rights><xsl:value-of select=".//ArticleCopyright/CopyrightComment/SimplePara/ExternalRef[1]/RefTarget[1]/@Address"/></dc:rights> </xsl:when>
            <xsl:otherwise>
                <dc:rights><xsl:value-of select=".//License/SimplePara/ExternalRef[1]/RefTarget[1]/@Address"/></dc:rights> 
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match = "//OnlineDate/Year" name ="date">
        <dc:date>
            <xsl:value-of select=".//OnlineDate/Year"/>
        </dc:date>
    </xsl:template>
</xsl:stylesheet>
