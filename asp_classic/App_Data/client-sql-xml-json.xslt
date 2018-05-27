<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="text" indent="no"/>
  
  <xsl:template match="Products"><xsl:value-of select="@ProductName"/></xsl:template>
  
  <xsl:template match="Order_x0020_Details">{ <xsl:if test="./Products">
    "productName": "<xsl:apply-templates select="Products"/>", </xsl:if>
    "unitPrice": <xsl:value-of select="number(@UnitPrice)"/>, 
    "quantity": <xsl:value-of select="number(@Quantity)"/> 
    }<xsl:if test="count(following-sibling::*) &gt; 0">, </xsl:if></xsl:template>

  <xsl:template match="Orders">{ 
  "orderID": "<xsl:value-of select="@OrderID"/>", 
  "orderDate": "<xsl:value-of select="@OrderDate"/>", 
  "orderDetails": [<xsl:apply-templates/>]}<xsl:if test="count(following-sibling::*) &gt; 0">, </xsl:if></xsl:template>

  <xsl:template match="Customers">{
  "contactName": "<xsl:value-of select="@ContactName"/>", 
  "orders": [<xsl:apply-templates/>]}<xsl:if test="count(following-sibling::*) &gt; 0">, </xsl:if></xsl:template>

  <xsl:template match="root">[
    <xsl:apply-templates/>
    ]</xsl:template>

</xsl:stylesheet>
