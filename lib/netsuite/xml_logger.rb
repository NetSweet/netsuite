module NetSuite
  require 'logger'
  class XmlLogger < ::Logger
    def format_message(severity, timestamp, progname, msg)
      if msg.match('<?xml') && !(msg.match('SOAPAction'))
        xp(msg)
      else
        "#{msg}\n"
      end
    end

    def xp(xml_text)
      xsl = <<XSL
        <xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
        <xsl:output method="xml" encoding="UTF-8" indent="yes"/>
        <xsl:strip-space elements="*"/>
        <xsl:template match="/">
          <xsl:copy-of select="."/>
        </xsl:template>
        </xsl:stylesheet>
XSL

      doc  = Nokogiri::XML(xml_text)
      xslt = Nokogiri::XSLT(xsl)
      out  = xslt.transform(doc)

      puts out.to_xml
    end

  end
end
