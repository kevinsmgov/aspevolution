<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" indent="yes"/>
  
  <xsl:template match="Products">
    <xsl:value-of select="@ProductName"/>
  </xsl:template>
  
  <xsl:template match="Order_x0020_Details">
    <li>
      <xsl:apply-templates/>
      (
      <xsl:value-of select="number(@UnitPrice)"/>
      ×
      <xsl:value-of select="number(@Quantity)"/>
      )
      =
      <xsl:value-of select="format-number(number(@UnitPrice)*number(@Quantity),'#,###.00')"/>
    </li>
  </xsl:template>

  <xsl:template match="Orders">
    <li>
      <xsl:value-of select="@OrderID"/>
      -
      <xsl:value-of select="@OrderDate"/>
      <ul>
        <xsl:apply-templates/>
      </ul>
    </li>
  </xsl:template>

  <xsl:template match="Customers">
    <li>
      <xsl:value-of select="@ContactName"/>
      <ul>
        <xsl:apply-templates/>
      </ul>
    </li>
  </xsl:template>

  <xsl:template match="root">
    <ul>
      <xsl:apply-templates/>
    </ul>
  </xsl:template>

</xsl:stylesheet>
