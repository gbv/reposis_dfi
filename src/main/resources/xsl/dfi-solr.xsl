<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:mods="http://www.loc.gov/mods/v3"
  xmlns:mcrxsl="xalan://org.mycore.common.xml.MCRXMLFunctions"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  exclude-result-prefixes="mods mcrxsl xlink"
>
  <xsl:import href="xslImport:solr-document:dfi-solr.xsl" />
  
  <xsl:template match="mycoreobject[contains(@ID,'_mods_')]">
    <xsl:apply-imports />
    <!-- fields from mycore-mods -->
    <xsl:apply-templates select="metadata/def.modsContainer/modsContainer/mods:mods" mode="dfi" />
  </xsl:template>

  <xsl:template match="mods:mods" mode="dfi">
    <xsl:for-each select="mods:language/mods:languageTerm[@authority='rfc5646']">
      <field name="rfc5646">
        <xsl:value-of select="." />
      </field>
    </xsl:for-each>
    <xsl:for-each select="mods:subject/mods:topic[@authorityURI='http://repositorium.dfi.de/api/v1/classifications/fivdfi']">
      <field name="fivdfi">
        <xsl:value-of select="substring-after(@valueURI,'#')" />
      </field>
    </xsl:for-each>
    <field name="mods.dateIssuedDateRange">
      <xsl:value-of select="mods:originInfo[@eventType='publication']/mods:dateIssued[@encoding='w3cdtf']"/>
    </field>
  </xsl:template>
  
    
</xsl:stylesheet>
