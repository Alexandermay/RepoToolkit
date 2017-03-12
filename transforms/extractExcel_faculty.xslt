<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <xsl:output method="xml"/>
    
    <xsl:template match="sheet">
        <root>
            <xsl:for-each-group select="cell[not(@row = '1')]" group-by="@row">
            <xsl:for-each select="current-group()">
                <xsl:value-of select="./cell"/>
            </xsl:for-each>
            <row>
                <Accession><xsl:value-of select="current-group()[@column = '1']"/></Accession>
                <Title><xsl:value-of select="current-group()[@column = '2']"/></Title>
                <Alternative_Title><xsl:value-of select="current-group()[@column = '3']"/></Alternative_Title>
                <Creator><xsl:value-of select="current-group()[@column = '4']"/></Creator>
                <Description><xsl:value-of select="current-group()[@column = '5']"/></Description>
                <Source><xsl:value-of select="current-group()[@column = '6']"/></Source>
                <Date_Created><xsl:value-of select="current-group()[@column = '7']"/></Date_Created>
                <Type><xsl:value-of select="current-group()[@column = '8']"/></Type>
                <Format><xsl:value-of select="current-group()[@column = '9']"/></Format>
                <Subject><xsl:value-of select="current-group()[@column = '10']"/></Subject>
                <personalNames><xsl:value-of select="current-group()[@column = '11']"/></personalNames>
                <corporateNames><xsl:value-of select="current-group()[@column = '12']"/></corporateNames>
                <geographicTerms><xsl:value-of select="current-group()[@column = '13']"/></geographicTerms>
                <Rights><xsl:value-of select="current-group()[@column = '14']"/></Rights>
                <Embargo><xsl:value-of select="current-group()[@column = '15']"/></Embargo>
            </row>
            
        </xsl:for-each-group>
        </root>
    </xsl:template>

</xsl:stylesheet>
