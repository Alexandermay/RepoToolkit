<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE Publisher PUBLIC "-//Springer-Verlag//DTD A++ V2.4//EN" "http://devel.springer.de/A++/V2.4/DTD/A++V2.4.dtd">
<!--    
CREATED BY: Alex May, Tisch Library
CREATED ON: 2016-05-11
UPDATED ON: 2016-05-16
This stylesheet converts Springer metadata to qualified Dublin Core based on the mappings found in the MIRA data dictionary.-->
<!--Name space declarations and XSLT version -->




<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="2.0">
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
            <xsl:for-each select="collection('../../RepoToolKit/TempRepo/collection.xml')">
                <xsl:sort select=".//DISS_comp_date" order="ascending"/>
                <digitalObject>
                    <file>
                        <xsl:value-of select="//DISS_binary"/>
                    </file>
                    <!-- this portion crosswalks the rel:hasModel for pdfs as bolierplate -->
                    <rel:hasModel>info:fedora/cm:Text.PDF</rel:hasModel>
                    <!-- this portion crosswalks the MARC uniform title to the dc:title element, if a 240 does not exist, it croswallks the 245 -->
                    <dc:title>
                        <xsl:value-of select="normalize-space(replace(//DISS_title, '\.+$', ''))"/>
                        <xsl:text>.</xsl:text>
                    </dc:title>
                    <!-- this portion crosswalks the MARC main author entry to the dc:creator element -->
                    <dc:creator>
                        <xsl:value-of
                            select="normalize-space(/DISS_submission/DISS_authorship/DISS_author/DISS_name/DISS_surname)"/>
                        <xsl:text>, </xsl:text>
                        <xsl:value-of
                            select="normalize-space(/DISS_submission/DISS_authorship/DISS_author/DISS_name/DISS_fname)"/>
                        <xsl:text>.</xsl:text>
                    </dc:creator>
                    <dc:description>
                        <xsl:text>Abstract: </xsl:text>
                        <xsl:value-of
                            select="normalize-space(/DISS_submission/DISS_content/DISS_abstract)"/>
                    </dc:description>
                    <dc:description>
                        <xsl:text>Thesis (</xsl:text>
                        <xsl:value-of
                            select="normalize-space(/DISS_submission/DISS_description/DISS_degree)"
                        /><xsl:text>)--Tufts University, </xsl:text><xsl:value-of
                            select="./DISS_submission/DISS_description/DISS_dates/DISS_comp_date"/><xsl:text>.</xsl:text>
                    </dc:description>
                    <dc:description><xsl:text>Submitted to the Dept. of </xsl:text><xsl:value-of select="DISS_submission/DISS_description[1]/DISS_institution[1]/DISS_inst_contact[1]"/><xsl:text>.</xsl:text></dc:description>
                    <xsl:choose>
                        <xsl:when
                            test="/DISS_submission/DISS_description/DISS_advisor[not(position() = last())]/DISS_name">
                            <dc:description>
                                <xsl:text>Advisors: </xsl:text>
                                <xsl:for-each
                                    select="/DISS_submission/DISS_description/DISS_advisor[not(position() = last())]/DISS_name">
                                    <xsl:value-of select="normalize-space(DISS_fname)"/>
                                    <xsl:text> </xsl:text>
                                    <xsl:value-of select="normalize-space(DISS_surname)"/>
                                    <xsl:text>, </xsl:text>
                                </xsl:for-each>
                                <xsl:if
                                    test="/DISS_submission/DISS_description/DISS_advisor[position() > 1][last()]/DISS_name">
                                    <xsl:text>and </xsl:text>
                                    <xsl:value-of
                                        select="/DISS_submission/DISS_description/DISS_advisor[position() > 1][last()]/DISS_name/DISS_fname"/>
                                    <xsl:text> </xsl:text>
                                    <xsl:value-of
                                        select="/DISS_submission/DISS_description/DISS_advisor[position() > 1][last()]/DISS_name/DISS_surname"/>
                                    <xsl:text>.</xsl:text>
                                </xsl:if>
                            </dc:description>
                        </xsl:when>
                        <xsl:otherwise>
                            <dc:description>
                                <xsl:text>Advisor: </xsl:text>
                                <xsl:value-of
                                    select="normalize-space(/DISS_submission/DISS_description[1]/DISS_advisor[1]/DISS_name[1]/DISS_fname[1])"/>
                                <xsl:text> </xsl:text>
                                <xsl:value-of
                                    select="normalize-space(/DISS_submission/DISS_description[1]/DISS_advisor[1]/DISS_name[1]/DISS_surname[1])"
                                /><xsl:text>.</xsl:text>
                            </dc:description>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:choose>
                        <xsl:when test="/DISS_submission/DISS_description/DISS_cmte_member[not(position() = last())]/DISS_name">
                            <dc:description>
                                <xsl:text>Committee: </xsl:text>
                                <xsl:for-each
                                    select="/DISS_submission/DISS_description/DISS_cmte_member[not(position() = last())]/DISS_name">
                                    <xsl:value-of select="normalize-space(DISS_fname)"/>
                                    <xsl:text> </xsl:text>
                                    <xsl:value-of select="normalize-space(DISS_surname)"/>
                                    <xsl:text>, </xsl:text>
                                </xsl:for-each>
                                <xsl:if
                                    test="/DISS_submission/DISS_description/DISS_cmte_member[position() > 1][last()]/DISS_name">
                                    <xsl:text>and </xsl:text>
                                    <xsl:value-of
                                        select="/DISS_submission/DISS_description/DISS_cmte_member[position() > 1][last()]/DISS_name/DISS_fname"/>
                                    <xsl:text> </xsl:text>
                                    <xsl:value-of
                                        select="/DISS_submission/DISS_description/DISS_cmte_member[position() > 1][last()]/DISS_name/DISS_surname"/>
                                    <xsl:text>.</xsl:text>
                                </xsl:if>
                            </dc:description>
                        </xsl:when>
                        <xsl:when test="/DISS_submission/DISS_description[1]/DISS_cmte_member[1]/DISS_name[1]">
                            <dc:description>
                                <xsl:text>Committee: </xsl:text>
                                <xsl:value-of
                                    select="normalize-space(/DISS_submission/DISS_description[1]/DISS_cmte_member[1]/DISS_name[1]/DISS_fname[1])"/>
                                <xsl:text> </xsl:text>
                                <xsl:value-of
                                    select="normalize-space(/DISS_submission/DISS_description[1]/DISS_cmte_member[1]/DISS_name[1]/DISS_surname[1])"
                                /><xsl:text>.</xsl:text>
                            </dc:description>
                        </xsl:when>
                        <xsl:otherwise/>
                    </xsl:choose>
                    <xsl:choose>
                        <xsl:when test="/DISS_submission/DISS_description/DISS_categorization/DISS_category[not(position() = last())]/DISS_cat_desc">
                            <dc:description>
                                <xsl:text>Keywords: </xsl:text>
                                <xsl:for-each
                                    select="/DISS_submission/DISS_description/DISS_categorization/DISS_category[not(position() = last())]/DISS_cat_desc">
                                    <xsl:value-of select="normalize-space(.)"/>
                                    <xsl:text>, </xsl:text>
                                </xsl:for-each>
                                <xsl:if
                                    test="/DISS_submission/DISS_description/DISS_categorization/DISS_category[position() > 1][last()]/DISS_cat_desc">
                                    <xsl:text>and </xsl:text>
                                    <xsl:value-of
                                        select="/DISS_submission/DISS_description/DISS_categorization/DISS_category[position() > 1][last()]/DISS_cat_desc"/>
                                    <xsl:text>.</xsl:text>
                                </xsl:if>
                            </dc:description>
                        </xsl:when>
                        <xsl:otherwise>
                            <dc:description>
                                <xsl:text>Keyword: </xsl:text>
                                <xsl:value-of
                                    select="normalize-space(/DISS_submission/DISS_description[1]/DISS_categorization[1]/DISS_category[1]/DISS_cat_desc[1])"/>
                                <xsl:text>.</xsl:text>
                            </dc:description>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:choose>                       
                        <xsl:when test="./DISS_submission/DISS_description[1]/DISS_institution[1][contains(DISS_inst_code,'0930')]">
                            <dcterms:isPartOf>Tufts University. Fletcher School of Law and Diplomacy. Theses and Dissertations.</dcterms:isPartOf> 
                        </xsl:when>
                        
                        <xsl:when test="./DISS_submission/DISS_description[1]/DISS_institution[1][contains(DISS_inst_code,'0234')] and //DISS_inst_contact [contains(text(),'Engineering')]">
                            <dcterms:isPartOf>Tufts University. School of Engineering. Theses and Dissertations.</dcterms:isPartOf> 
                        </xsl:when>
                       
                        <xsl:when test="./DISS_submission/DISS_description[1]/DISS_institution[1][contains(DISS_inst_code,'0234')] and //DISS_inst_contact [not(contains(text(),'Engineering'))]">
                            <dcterms:isPartOf>Tufts University. Graduate School of Arts and Sciences. Theses and Dissertations.</dcterms:isPartOf> 
                        </xsl:when> 
                        
                        <xsl:when test="./DISS_submission/DISS_description[1]/DISS_institution[1][contains(DISS_inst_code,'0845')]">
                            <dcterms:isPartOf>Tufts University. Sackler School of Graduate Biomedical Sciences. Theses and Dissertations.</dcterms:isPartOf> 
                        </xsl:when>
                        <xsl:when test="./DISS_submission/DISS_description[1]/DISS_institution[1][contains(DISS_inst_code,'1546')]">
                            <dcterms:isPartOf>Tufts University.  Gerald J. &amp; Dorothy R. Friedman School of Nutrition Science and Policy. Theses and Dissertations.</dcterms:isPartOf> 
                        </xsl:when>
                        <xsl:when test="./DISS_submission/DISS_description[1]/DISS_institution[1][contains(DISS_inst_code,'1547')]">
                            <dcterms:isPartOf>Tufts University. School of Dental Medicine. Theses and Dissertations.</dcterms:isPartOf> 
                        </xsl:when>
                    </xsl:choose>
                    <dcterms:isPartOf>Tufts University electronic theses and dissertations.</dcterms:isPartOf>
                    <!-- this portion inserts the date created element -->
                    <dc:date.created>
                        <xsl:value-of
                            select="./DISS_submission/DISS_description/DISS_dates/DISS_comp_date"/>
                    </dc:date.created>
                    <xsl:choose>
                        <xsl:when test="//DISS_inst_contact[1] [contains(text(),'Diplomacy, History, and Politics')]">
                            <dcadesc:corpname>Fletcher School of Law and Diplomacy.</dcadesc:corpname>
                        </xsl:when>
                        <xsl:when test="//DISS_inst_contact[1] [contains(text(),'Chemistry')]">
                            <dcadesc:corpname>Tufts University. Department of Chemistry.</dcadesc:corpname>
                        </xsl:when>
                        <xsl:when test="//DISS_inst_contact[1] [contains(text(),'Art')]">
                            <dcadesc:corpname>Tufts University. Department of Art and Art History.</dcadesc:corpname>
                        </xsl:when>
                        <xsl:when test="//DISS_inst_contact[1] [contains(text(),'Biology')]">
                            <dcadesc:corpname>Tufts University. Department of Biology.</dcadesc:corpname>
                        </xsl:when>
                        <xsl:when test="//DISS_inst_contact[1] [contains(text(),'Biomedical')]">
                            <dcadesc:corpname>Tufts University. Department of Biomedical Engineering.</dcadesc:corpname>
                        </xsl:when>
                        <xsl:when test="//DISS_inst_contact[1] [contains(text(),'Biological')]">
                            <dcadesc:corpname>Tufts University. Department of Chemical and Biological Engineering.</dcadesc:corpname>
                        </xsl:when>
                        <xsl:when test="//DISS_inst_contact[1] [contains(text(),'Civil')]">
                            <dcadesc:corpname>Tufts University. Department of Civil and Environmental Engineering.</dcadesc:corpname>
                        </xsl:when>
                        <xsl:when test="//DISS_inst_contact[1] [contains(text(),'Classics')]">
                            <dcadesc:corpname>Tufts University. Department of Classics.</dcadesc:corpname>
                        </xsl:when>
                        <xsl:when test="//DISS_inst_contact[1] [contains(text(),'Computer')]">
                            <dcadesc:corpname>Tufts University. Department of Computer Science.</dcadesc:corpname>
                        </xsl:when>
                        <xsl:when test="//DISS_inst_contact[1] [contains(text(),'Drama')]">
                            <dcadesc:corpname>Tufts University. Department of Drama and Dance.</dcadesc:corpname>
                        </xsl:when>
                        <xsl:when test="//DISS_inst_contact[1] [contains(text(),'Drama')]">
                            <dcadesc:corpname>Tufts University. Department of Drama and Dance.</dcadesc:corpname>
                        </xsl:when>
                        <xsl:when test="//DISS_inst_contact[1] [contains(text(),'Economics')]">
                            <dcadesc:corpname>Tufts University. Department of Economics.</dcadesc:corpname>
                        </xsl:when>
                        <xsl:when test="//DISS_inst_contact[1] [contains(text(),'Education')]">
                            <dcadesc:corpname>Tufts University. Department of Education.</dcadesc:corpname>
                        </xsl:when>
                        <xsl:when test="//DISS_inst_contact[1] [contains(text(),'Electrical')]">
                            <dcadesc:corpname>Tufts University. Department of Electrical and Computer Engineering.</dcadesc:corpname>
                        </xsl:when>
                        <xsl:when test="//DISS_inst_contact[1] [contains(text(),'English')]">
                            <dcadesc:corpname>Tufts University. Department of English.</dcadesc:corpname>
                        </xsl:when>
                        <xsl:when test="//DISS_inst_contact[1] [contains(text(),'History')]">
                            <dcadesc:corpname>Tufts University. Department of History.</dcadesc:corpname>
                        </xsl:when>
                        <xsl:when test="//DISS_inst_contact[1] [contains(text(),'Mathematics')]">
                            <dcadesc:corpname>Tufts University. Department of Mathematics.</dcadesc:corpname>
                        </xsl:when>
                        <xsl:when test="//DISS_inst_contact[1] [contains(text(),'Mechanical')]">
                            <dcadesc:corpname>Tufts University. Department of Mechanical Engineering.</dcadesc:corpname>
                        </xsl:when>
                        <xsl:when test="//DISS_inst_contact[1] [contains(text(),'Music')]">
                            <dcadesc:corpname>Tufts University. Department of Music.</dcadesc:corpname>
                        </xsl:when>
                        <xsl:when test="//DISS_inst_contact[1] [contains(text(),'Physics')]">
                            <dcadesc:corpname>Tufts University. Department of Physics and Astronomy.</dcadesc:corpname>
                        </xsl:when>
                        <xsl:when test="//DISS_inst_contact[1] [contains(text(),'Psychology')]">
                            <dcadesc:corpname>Tufts University. Department of Psychology.</dcadesc:corpname>
                        </xsl:when>
                        <xsl:when test="//DISS_inst_contact[1] [contains(text(),'Urban')]">
                            <dcadesc:corpname>Tufts University. Department of Urban and Environmental Policy and Planning.</dcadesc:corpname>
                        </xsl:when>
                        <xsl:when test="//DISS_inst_contact[1] [contains(text(),'Child')]">
                            <dcadesc:corpname>Tufts University. Eliot-Pearson Department of Child Development.</dcadesc:corpname>
                        </xsl:when>
                        <xsl:when test="//DISS_inst_contact[1] [contains(text(),'Nutrition')]">
                            <dcadesc:corpname>Gerald J. &amp; Dorothy R. Friedman School of Nutrition Science and Policy.</dcadesc:corpname>
                        </xsl:when>
                        <xsl:when test="//DISS_inst_contact[1] [contains(text(),'Fletcher')]">
                            <dcadesc:corpname>Fletcher School of Law and Diplomacy.</dcadesc:corpname>
                        </xsl:when>
                        <xsl:when test="//DISS_inst_contact[1] [contains(text(),'Dental')]">
                            <dcadesc:corpname>Tufts University. School of Dental Medicine.</dcadesc:corpname>
                        </xsl:when>
                        <xsl:when test="//DISS_inst_contact[1] [contains(text(),'Occupational')]">
                            <dcadesc:corpname>Tufts University. Occupational Therapy Department.</dcadesc:corpname>
                        </xsl:when>                        
                        <xsl:when test="//DISS_inst_contact[1] [contains(text(),'Interdisciplinary')]">
                            <dcadesc:corpname>Tufts University.Graduate School of Arts and Sciences.</dcadesc:corpname>
                        </xsl:when>
                        <xsl:when test="//DISS_inst_contact[1] [contains(text(),'School of Nutrition')] | //DISS_inst_name[1][contains(text(),'School of Nutrition')] ">
                            <dcadesc:corpname>Gerald J. &amp; Dorothy R. Friedman School of Nutrition Science and Policy.</dcadesc:corpname>
                        </xsl:when>                       
                        <xsl:when test="//DISS_inst_name[1] [contains(text(),'Dental')]">
                            <dcadesc:corpname>Tufts University. School of Dental Medicine.</dcadesc:corpname>
                        </xsl:when>
                        <xsl:when test="//DISS_inst_name[1] [contains(text(),'Graduate Biomedical Sciences')] and //DISS_inst_contact[1] [contains(text(),'Biochemistry')]">
                            <dcadesc:corpname>Sackler School of Graduate Biomedical Sciences. Department of Biochemistry.</dcadesc:corpname>
                        </xsl:when>
                        <xsl:when test="//DISS_inst_name[1] [contains(text(),'Graduate Biomedical Sciences')] and //DISS_inst_contact[1] [contains(text(),'Cell')]">
                            <dcadesc:corpname>Sackler School of Graduate Biomedical Sciences  Department of Cell, Molecular and Developmental Biology.</dcadesc:corpname>
                        </xsl:when>
                        <xsl:when test="//DISS_inst_name[1] [contains(text(),'Graduate Biomedical Sciences')] and //DISS_inst_contact[1] [contains(text(),'Cellular')]">
                            <dcadesc:corpname>Sackler School of Graduate Biomedical Sciences. Department of Cellular and Molecular Physiology.</dcadesc:corpname>
                        </xsl:when>
                        <xsl:when test="//DISS_inst_name[1] [contains(text(),'Graduate Biomedical Sciences')] and //DISS_inst_contact[1] [contains(text(),'Translational')]">
                            <dcadesc:corpname>Sackler School of Graduate Biomedical Sciences. Department of Clinical and Translational Science.</dcadesc:corpname>
                        </xsl:when>
                        <xsl:when test="//DISS_inst_name[1] [contains(text(),'Graduate Biomedical Sciences')] and //DISS_inst_contact[1] [contains(text(),'Clinical Research')]">
                            <dcadesc:corpname>Sackler School of Graduate Biomedical Sciences. Department of Clinical Research.</dcadesc:corpname>
                        </xsl:when>
                        <xsl:when test="//DISS_inst_name[1] [contains(text(),'Graduate Biomedical Sciences')] and //DISS_inst_contact[1] [contains(text(),'Immunology')]">
                            <dcadesc:corpname>Sackler School of Graduate Biomedical Sciences. Department of Immunology.</dcadesc:corpname>
                        </xsl:when>
                        <xsl:when test="//DISS_inst_name[1] [contains(text(),'Graduate Biomedical Sciences')] and //DISS_inst_contact[1] [contains(text(),'Genetics')]">
                            <dcadesc:corpname>Sackler School of Graduate Biomedical Sciences. Department of Genetics.</dcadesc:corpname>
                        </xsl:when>
                        <xsl:when test="//DISS_inst_name[1] [contains(text(),'Graduate Biomedical Sciences')] and //DISS_inst_contact[1] [contains(text(),'Microbiology')]">
                            <dcadesc:corpname>Sackler School of Graduate Biomedical Sciences. Department of Molecular Microbiology.</dcadesc:corpname>
                        </xsl:when>
                        <xsl:when test="//DISS_inst_name[1] [contains(text(),'Graduate Biomedical Sciences')] and //DISS_inst_contact[1] [contains(text(),'Neuroscience')]">
                            <dcadesc:corpname>Sackler School of Graduate Biomedical Sciences. Department of Neuroscience.</dcadesc:corpname>
                        </xsl:when>
                        <xsl:when test="//DISS_inst_name[1] [contains(text(),'Graduate Biomedical Sciences')] and //DISS_inst_contact[1] [contains(text(),'Therapeutics')]">
                            <dcadesc:corpname>Sackler School of Graduate Biomedical Sciences. Department of Pharmacology and Experimental Therapeutics.</dcadesc:corpname>
                        </xsl:when>
                        <xsl:otherwise>
                            <dcadesc:corpname>NONEFOUND</dcadesc:corpname>
                        </xsl:otherwise>
                    </xsl:choose>
                    <!-- this portion inserts the type and format boilerplate -->
                    <dc:type>Text</dc:type>
                    <dc:format>application/pdf</dc:format>
                    <!-- this portion inserts the boilerplate steward information -->
                    <admin:steward>tisch</admin:steward>
                    <!-- this portion inserts the boilerplate batch template information -->
                    <ac:name>amay02</ac:name>
                    <ac:comment>ProquestProvisionalBatchTransform2016: <xsl:value-of
                            select="current-dateTime()"/></ac:comment>
                    <admin:createdby>externalXSLT</admin:createdby>
                    <!-- this portion inserts the boilerplate batch displays information -->
                    <xsl:choose>
                        <xsl:when test="(//DISS_comp_date &lt;= 2011)">
                            <admin:displays>nowhere</admin:displays> 
                        </xsl:when>
                        <xsl:otherwise>
                            <admin:displays>dl</admin:displays>  
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:choose>
                        <xsl:when test="/DISS_submission[@embargo_code='1']">
                            <admin:embargo>
                                <xsl:value-of
                                    select="replace(./DISS_submission/DISS_description/DISS_dates/DISS_accept_date,'(\d{2})/(\d{2})/((\d{4}))','$3-')"/><xsl:value-of
                                        select="(number(replace(./DISS_submission/DISS_description/DISS_dates/DISS_accept_date,'(\d{2})/(\d{2})/((\d{4}))','$1'))+6)"/><xsl:value-of
                                            select="replace(./DISS_submission/DISS_description/DISS_dates/DISS_accept_date,'(\d{2})/(\d{2})/((\d{4}))','-$2')"/>
                            </admin:embargo>
                        </xsl:when>
                        <xsl:when test="/DISS_submission[@embargo_code='2']">
                            <admin:embargo>
                                <xsl:value-of
                                    select="number(replace(./DISS_submission/DISS_description/DISS_dates/DISS_accept_date,'(\d{2})/(\d{2})/((\d{4}))','$3'))+1"/><xsl:value-of
                                        select="replace(./DISS_submission/DISS_description/DISS_dates/DISS_accept_date,'(\d{2})/(\d{2})/((\d{4}))','-$1-$2')"/>
                            </admin:embargo>
                        </xsl:when>
                        <xsl:when test="/DISS_submission[@embargo_code='3']">
                            <admin:embargo>
                                <xsl:value-of
                                    select="number(replace(./DISS_submission/DISS_description/DISS_dates/DISS_accept_date,'(\d{2})/(\d{2})/((\d{4}))','$3'))+2"/><xsl:value-of
                                        select="replace(./DISS_submission/DISS_description/DISS_dates/DISS_accept_date,'(\d{2})/(\d{2})/((\d{4}))','-$1-$2')"/>
                            </admin:embargo>
                        </xsl:when>
                        <xsl:when test="/DISS_submission[@embargo_code='4'] and /DISS_submission/DISS_restriction/DISS_sales_restriction[@remove='']">
                            <admin:embargo>
                                2999
                            </admin:embargo>
                        </xsl:when>
                        <xsl:when test="/DISS_submission[@embargo_code='4']">
                            <admin:embargo>
                                <xsl:value-of select="normalize-space(replace(/DISS_submission/DISS_restriction/DISS_sales_restriction/@remove,'(\d{2})/(\d{2})/((\d{4}))','$3-$1-$2'))"/>
                            </admin:embargo>
                        </xsl:when>
                        <xsl:otherwise>
                            <admin:embargo/>
                        </xsl:otherwise>
                    </xsl:choose> 
                </digitalObject>

            </xsl:for-each>
        </input>
    </xsl:template>
</xsl:stylesheet>
