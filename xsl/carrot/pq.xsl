<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output indent="yes" omit-xml-declaration="no" encoding="UTF-8" />

<xsl:template match="/">
  <searchresult>
    <xsl:apply-templates select="//items/item[@href]" />
  </searchresult>
</xsl:template>

 <xsl:template match="item">
   <document>
     <title><xsl:value-of select="uin" /></title>
     <snippet><xsl:value-of select="questionText" /></snippet>
     <url><xsl:value-of select="@href" /></url>
   </document>
 </xsl:template>

</xsl:stylesheet>
