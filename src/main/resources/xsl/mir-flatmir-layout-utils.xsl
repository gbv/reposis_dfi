<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:i18n="xalan://org.mycore.services.i18n.MCRTranslation"
    xmlns:mcrver="xalan://org.mycore.common.MCRCoreVersion"
    xmlns:mcrxsl="xalan://org.mycore.common.xml.MCRXMLFunctions"
    exclude-result-prefixes="i18n mcrver mcrxsl">

  <xsl:import href="resource:xsl/layout/mir-common-layout.xsl" />

  <xsl:template name="mir.navigation">

    <div class="container">
      <div class="header_box  col-12">

        <div class="project_logo_box">
          <a title="zur Homepage" href="https://www.dfi.de/">
            <img alt="Logo DFI" class="dfi-logo" src="{$WebApplicationBaseURL}images/logos/logo-dfi-mit-schriftzug-blau.svg" />
            <img alt="Logo DFI klein" class="dfi-logo-small" src="{$WebApplicationBaseURL}images/logos/logo-dfi-blau.svg" />
          </a>
        </div>

        <div class="project_nav_box">

          <nav class="mir-prop-nav">
            <ul class="nav navbar-nav navbar-expand">
              <xsl:call-template name="mir.loginMenu" />
              <xsl:call-template name="mir.languageMenu" />
            </ul>
          </nav>

          <div class="search-button search-toggler js-search-toggler">
            <span class="search-button__label">Schnellsuche</span>
            <i class="fas fa-search search-button__icon"></i>
          </div>

          <div class="searchfield_box">
            <button class="btn js-search-close text-primary">
              <i class="far fa-times-circle search-button__close"></i>
            </button>
            <form
              id="bs-searchHeader"
              action="{$WebApplicationBaseURL}servlets/solr/find"
              class="bs-search form-inline"
              role="search">
              <div class="js-searchbar">
                <input
                  id="searchbar"
                  name="condQuery"
                  placeholder="{i18n:translate('mir.navsearch.placeholder')}"
                  class="form-control search-query"
                  type="text" />
                <xsl:choose>
                  <xsl:when test="mcrxsl:isCurrentUserInRole('admin') or mcrxsl:isCurrentUserInRole('editor')">
                    <input name="owner" type="hidden" value="createdby:*" />
                  </xsl:when>
                  <xsl:when test="not(mcrxsl:isCurrentUserGuestUser())">
                    <input name="owner" type="hidden" value="createdby:{$CurrentUser}" />
                  </xsl:when>
                </xsl:choose>
                <button type="submit" class="btn pnt-primary text-primary">
                  <i class="fas fa-search search-button__icon"></i>
                </button>
              </div>
            </form>
          </div>

          <div class="mir-main-nav pp-main-nav">
            <nav class="navbar navbar-expand-lg navbar-light">
              <button
                class="navbar-toggler"
                type="button"
                data-toggle="collapse"
                data-target=".mir-main-nav__entries--mobile"
                aria-controls="mir-main-nav__entries--mobile"
                aria-expanded="false"
                aria-label="Toggle navigation">
                <span class="navbar-toggler-icon text-primary"></span>
              </button>
              <div class="collapse navbar-collapse mir-main-nav__entries">
                <ul class="navbar-nav">
                  <xsl:call-template name="project.generate_single_menu_entry">
                    <xsl:with-param name="menuID" select="'home'"/>
                  </xsl:call-template>
                  <xsl:call-template name="project.generate_single_menu_entry">
                    <xsl:with-param name="menuID" select="'about'"/>
                  </xsl:call-template>
                  <xsl:apply-templates select="$loaded_navigation_xml/menu[@id='search']" />
                  <xsl:apply-templates select="$loaded_navigation_xml/menu[@id='browse']" />
                  <xsl:apply-templates select="$loaded_navigation_xml/menu[@id='publish']" />
                  <xsl:call-template name="mir.basketMenu" />
                </ul>
              </div>
            </nav>
          </div>

        </div>

      </div>
    </div>
  </xsl:template>

  <xsl:template name="mir.jumbotwo">
    <!-- show only on startpage -->
    <xsl:if test="//div/@class='jumbotwo'">
    </xsl:if>
  </xsl:template>

  <xsl:template name="mir.footer">
    <div class="container">
      <div class="row">

        <div class="col-4">
          <ul class="internal_links">
            <xsl:apply-templates select="$loaded_navigation_xml/menu[@id='links']/*" mode="footerMenu" />
          </ul>
        </div>

        <div class="col">
        </div>

        <div class="col-3">
          <ul class="internal_links footer-menu">
            <xsl:apply-templates select="$loaded_navigation_xml/menu[@id='below']/*" mode="footerMenu" />
          </ul>
        </div>

      </div>

      <div class="row">
        <div class="col-12">
          <div class="footer-copyright">
            <p class="text-center">© Deutsch-Französisches Institut 2023</p>
          </div>
        </div>
      </div>


    </div>
  </xsl:template>

  <xsl:template name="mir.powered_by">
    <xsl:variable name="mcr_version" select="concat('MyCoRe ',mcrver:getCompleteVersion())" />
    <div id="powered_by">
      <a href="http://www.mycore.de">
        <img src="{$WebApplicationBaseURL}mir-layout/images/mycore_logo_small_invert.png" title="{$mcr_version}" alt="powered by MyCoRe" />
      </a>
    </div>
  </xsl:template>

  <xsl:template name="project.generate_single_menu_entry">
    <xsl:param name="menuID" />

    <xsl:variable name="activeClass">
      <xsl:choose>
        <xsl:when test="$loaded_navigation_xml/menu[@id=$menuID]/item[@href = $browserAddress ]">
          <xsl:text>active</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>not-active</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <li class="nav-item {$activeClass}">

      <a id="{$menuID}" href="{$WebApplicationBaseURL}{$loaded_navigation_xml/menu[@id=$menuID]/item/@href}" class="nav-link" >
        <xsl:choose>
          <xsl:when test="$loaded_navigation_xml/menu[@id=$menuID]/item/label[lang($CurrentLang)] != ''">
            <xsl:value-of select="$loaded_navigation_xml/menu[@id=$menuID]/item/label[lang($CurrentLang)]" />
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$loaded_navigation_xml/menu[@id=$menuID]/item/label[lang($DefaultLang)]" />
          </xsl:otherwise>
        </xsl:choose>
      </a>
    </li>
  </xsl:template>

</xsl:stylesheet>
