<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="2.0"
  xmlns:dc="http://purl.org/dc/elements/1.1/"
  xmlns:dcadesc="http://nils.lib.tufts.edu/dcadesc/" 
  xmlns:dcatech="http://nils.lib.tufts.edu/dcatech/"  
  xmlns:dcterms="http://purl.org/dc/terms/"
  xmlns:admin="http://nils.lib.tufts.edu/dcaadmin/"
  xmlns:ac="http://purl.org/dc/dcmitype/"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:rel="info:fedora/fedora-system:def/relations-external#"
  xmlns:local="http://nils.lib.tufts.edu/dcaadmin/">
  
  <xsl:output method="xml" indent="yes" use-character-maps="killSmartPunctuation" encoding="UTF-8"/>
  <xsl:character-map name="killSmartPunctuation">
    <xsl:output-character character="“" string="&quot;"/>
    <xsl:output-character character="”" string="&quot;"/>
    <xsl:output-character character="’" string="'"/>
    <xsl:output-character character="‘" string="'"/>
    <xsl:output-character character="&#x2013;" string="-"/>
  </xsl:character-map>
  
  <!-- identity transform: -->
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>
 
  <xsl:template match="dcadesc:genre">
    <dcadesc:genre><xsl:value-of select="concat(upper-case(substring(.,1,1)),
      substring(., 2),
      ' '[not(last())]
      )"/></dcadesc:genre>
  </xsl:template>
  
  <xsl:template match="dc:publisher">
    <dc:publisher>Digital Collections and Archives, Tufts University.</dc:publisher> 
  </xsl:template>
  
  <xsl:template match="local:steward">
    <local:steward>dca</local:steward>
  </xsl:template>
  
  <xsl:template match="local:displays">
    <local:displays>dl</local:displays>
  </xsl:template>
  
  <!-- Specific to Great Courses
  <xsl:template match="local:visibility">
    <xsl:choose>
      <xsl:when test="preceding::dc:title[contains(text(),'Slides')]">
        <local:visibility>authenticated</local:visibility>
      </xsl:when>
      <xsl:otherwise>
        <local:visibility>open</local:visibility>
      </xsl:otherwise>
    </xsl:choose>  
  </xsl:template>
  -->
  
</xsl:stylesheet>
