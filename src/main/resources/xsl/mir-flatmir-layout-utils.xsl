<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:i18n="xalan://org.mycore.services.i18n.MCRTranslation"
    xmlns:mcrver="xalan://org.mycore.common.MCRCoreVersion"
    xmlns:mcrxsl="xalan://org.mycore.common.xml.MCRXMLFunctions"
    exclude-result-prefixes="i18n mcrver mcrxsl">

  <xsl:import href="resource:xsl/layout/mir-common-layout.xsl" />

  <xsl:template name="mir.navigation">

  <div class="header_box container">

    <div class="project_logo_box">
      <a title="zur Homepage" href="{$WebApplicationBaseURL}">
        <img alt="Logo DFI" src="{$WebApplicationBaseURL}images/logos/logo-dfi-mit-schriftzug-blau.svg" />
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
              class="form-control search-query pp-rounded"
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
              <xsl:apply-templates select="$loaded_navigation_xml/menu[@id='about']" />
              <xsl:apply-templates select="$loaded_navigation_xml/menu[@id='search']" />
              <xsl:call-template name="project.generate_single_menu_entry">
                <xsl:with-param name="menuID" select="'citation'"/>
              </xsl:call-template>
              <xsl:apply-templates select="$loaded_navigation_xml/menu[@id='publish']" />
              <xsl:call-template name="mir.basketMenu" />
            </ul>
          </div>
        </nav>
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

          <h3>
            Deutsch-Französisches Institut
          </h3>
          <p>
            <span class="pin">
              <a
                href="https://www.google.de/maps/place/Deutsch-Franz%C3%B6sisches+Institut+Ludwigsburg/@48.8976159,9.1830197,17z/data=!3m1!5s0x4799d1bd6694908b:0x9627151deaa141a3!4m14!1m7!3m6!1s0x4799d1bd611e3c49:0x1603631e0c8eee72!2sDeutsch-Franz%C3%B6sisches+Institut+Ludwigsburg!8m2!3d48.8976159!4d9.1852137!16s%2Fm%2F04n2d39!3m5!1s0x4799d1bd611e3c49:0x1603631e0c8eee72!8m2!3d48.8976159!4d9.1852137!16s%2Fm%2F04n2d39"
                target="_blank" rel="noreferrer">Asperger Straße 34<br /> D-71634 Ludwigsburg
              </a>
            </span>
          </p>
          <p>
            Telefon: <a href="tel:+49714193030" class="tel">+49 (0) 7141 93 03 0</a><br />
            Telefax: <a href="tel:+497141930350" class="tel">+49 (0) 7141 93 03 50</a><br />
            Allgemeine Anfragen: <a href="#" class="mail" data-mailto-token="jxfiql7fkclXacf+ab"
              data-mailto-vector="-3">info@<span style="display:none;">remove-this.</span>dfi.de</a><br />
            Presseanfragen: <a href="#" class="mail"
              data-mailto-token="jxfiql7mobppbxkcoxdbXacf+ab" data-mailto-vector="-3">
            presseanfrage@<span style="display:none;">remove-this.</span>dfi.de</a>
          </p>

        </div>

        <div class="col-4">

          <h3>
            Frankreich-Bibliothek (dfi)
          </h3>
          <p>
            <span class="pin">
              <a
                href="https://www.google.de/maps/place/Arbeitsgemeinschaft+der+Spezialbibliotheken/@48.8986138,9.1917587,15z/data=!3m1!5s0x4799d1bd7b981ab9:0x7156f3e6fce3b2ae!4m10!1m2!2m1!1sFrankreich+Bibliothek+Asperger+Stra%C3%9Fe+30+D-71634+Ludwigsburg!3m6!1s0x4799d1bd7bebd3cb:0xcb688aa752d0e533!8m2!3d48.89745!4d9.1860401!15sCj1GcmFua3JlaWNoIEJpYmxpb3RoZWsgQXNwZXJnZXIgU3RyYcOfZSAzMCBELTcxNjM0IEx1ZHdpZ3NidXJn4AEA!16s%2Fg%2F11swvgt0zl"
                target="_blank" rel="noreferrer">Asperger Straße 30<br /> D-71634 Ludwigsburg
              </a>
            </span>
          </p>
          <p>Telefon: <a href="tel:+497141930334" class="tel">+49 (0) 7141 93 03 34</a><br />
            Telefax: <a href="tel:+497141930355" class="tel">+49 (0) 7141 93 03 55</a><br /><a
              href="#" class="mail" data-mailto-token="jxfiql7coxkhobfze:yfyiflqebhXacf+ab"
              data-mailto-vector="-3">frankreich-bibliothek@<span style="display:none;">
            remove-this.</span>dfi.de</a></p>

        </div>

        <div class="col-2">

        </div>

        <div class="col-2 text-right">
          <ul class="internal_links">
            <xsl:apply-templates select="$loaded_navigation_xml/menu[@id='brand']/*" />
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
