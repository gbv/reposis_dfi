<?xml version="1.0"?>
<xsl:stylesheet version="3.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                xmlns:p="info:srw/schema/5/picaXML-v1.0"
                xmlns:mods="http://www.loc.gov/mods/v3"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:zs="http://www.loc.gov/zing/srw/"
                exclude-result-prefixes="xsl p xlink zs">
  <xsl:mode on-no-match="shallow-copy"/>
  
  <xsl:import href="default/pica2mods-default-titleInfo.xsl" />
  <xsl:import href="default/pica2mods-default-name.xsl" />
  <xsl:import href="default/pica2mods-default-identifier.xsl" />
  <xsl:import href="default/pica2mods-default-language.xsl" />
  <xsl:import href="default/pica2mods-default-location.xsl" />
  <xsl:import href="default/pica2mods-default-physicalDescription.xsl" />
  <xsl:import href="default/pica2mods-default-originInfo.xsl" />
  <xsl:import href="default/pica2mods-default-genre.xsl" />
  <xsl:import href="default/pica2mods-default-recordInfo.xsl" />
  <xsl:import href="default/pica2mods-default-note.xsl" />
  <xsl:import href="default/pica2mods-default-abstract.xsl" />
  <xsl:import href="default/pica2mods-default-subject.xsl" />
  <xsl:import href="default/pica2mods-default-relatedItem.xsl" />

  <xsl:import href="_common/pica2mods-pica-PREPROCESSING.xsl" />
  <xsl:import href="_common/pica2mods-functions.xsl" />

  <xsl:param name="MCR.PICA2MODS.CONVERTER_VERSION" select="'Pica2Mods 2.5'" />
  <xsl:param name="MCR.PICA2MODS.DATABASE" select="'gvk'" />

  <xsl:template match="p:record">
    <mods:mods>
      <xsl:call-template name="modsTitleInfo" />
      <xsl:call-template name="modsAbstract" />
      <xsl:call-template name="modsName" />
      <xsl:call-template name="modsIdentifier" />
      <xsl:call-template name="modsLanguage" />
      <xsl:call-template name="modsPhysicalDescription" />
      <xsl:call-template name="modsOriginInfo" />
      <xsl:call-template name="modsGenre" />
      <xsl:call-template name="modsLocation" />
      <xsl:call-template name="modsRecordInfo" />
      <xsl:call-template name="modsNote" />
      <xsl:call-template name="modsRelatedItem" />
      <xsl:call-template name="modsSubject" />
      <xsl:call-template name="modsDfiFIVSubject" />
      <xsl:call-template name="modsDfiSpecific" />
    </mods:mods>
  </xsl:template>
  
  <xsl:template name="modsDfiFIVSubject" >
    <xsl:for-each select="./p:datafield[@tag='045N'][not(@occurrence)]" >
      <mods:subject xlink:type="simple">
        <xsl:variable name="valueURI" select="concat('http://bartoc.org/en/node/20447#',./p:subfield[@code='a'])"/>
        <mods:geographic authorityURI="http://bartoc.org/en/node/20447" valueURI="{$valueURI}"/>
      </mods:subject>
    </xsl:for-each>
    <xsl:for-each select="./p:datafield[@tag='045N'][@occurrence='01']" >
      <mods:subject xlink:type="simple">
        <xsl:variable name="valueURI" select="concat('http://bartoc.org/en/node/20446#',./p:subfield[@code='a'])"/>
        <mods:topic authorityURI="http://bartoc.org/en/node/20446" valueURI="{$valueURI}"/>
      </mods:subject>
    </xsl:for-each>
    <xsl:for-each select="./p:datafield[@tag='045N'][@occurrence='02']" >
      <mods:subject xlink:type="simple">
        <xsl:variable name="valueURI" select="concat('http://repo.dfi.de/api/v1/classifications/fivdfi#',./p:subfield[@code='a'])"/>
        <mods:topic authorityURI="http://repo.dfi.de/api/v1/classifications/fivdfi" valueURI="{$valueURI}"/>
      </mods:subject>
    </xsl:for-each>
    <xsl:for-each select="./p:datafield[@tag='045D'][@occurrence='60' or @occurrence='70']" >
      <mods:subject xlink:type="simple">
        <mods:topic><xsl:value-of select="./p:subfield[@code='a']"/></mods:topic>
      </mods:subject>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="modsDfiSpecific" >
    <mods:accessCondition type="use and reproduction" xlink:href="http://www.mycore.org/classifications/mir_licenses#rights_reserved" xlink:type="simple"/>
    <mods:genre type="intern" authorityURI="http://www.mycore.org/classifications/mir_genres" valueURI="http://www.mycore.org/classifications/mir_genres#article"/>
  </xsl:template>

  <xsl:template match="zs:searchRetrieveResponse">
    <xsl:apply-templates select="//p:record" />
  </xsl:template>
 
</xsl:stylesheet>
