<xsl:stylesheet
      xmlns:xsl='http://www.w3.org/1999/XSL/Transform' version='2.0'
      >

  <xsl:output encoding="iso-8859-1" />



  <xsl:template match="banco/cuenta">
         <cuentas><xsl:value-of select="nro_cuenta"/> - <xsl:value-of select="sucursal"/> - <xsl:value-of select="saldo"/></cuentas>
  </xsl:template>
  <xsl:template match="banco/cliente"/>
  <xsl:template match="banco/titular"/>

</xsl:stylesheet>
