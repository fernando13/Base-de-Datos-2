import net.sf.saxon.Configuration;
import net.sf.saxon.Controller;
import net.sf.saxon.TransformerFactoryImpl;
import net.sf.saxon.dom.NodeOverNodeInfo;
import net.sf.saxon.event.Builder;
import net.sf.saxon.om.Axis;
import net.sf.saxon.om.DocumentInfo;
import net.sf.saxon.om.NodeInfo;
import net.sf.saxon.om.TreeModel;
import net.sf.saxon.pattern.NodeKindTest;
import net.sf.saxon.sxpath.XPathExpression;
import net.sf.saxon.xpath.XPathEvaluator;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.xml.sax.*;
import org.xml.sax.helpers.AttributesImpl;
import org.xml.sax.helpers.XMLFilterImpl;

import javax.xml.parsers.*;
import javax.xml.transform.*;
import javax.xml.transform.dom.DOMResult;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.sax.SAXResult;
import javax.xml.transform.sax.SAXSource;
import javax.xml.transform.sax.SAXTransformerFactory;
import javax.xml.transform.sax.TransformerHandler;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;
import java.io.*;
import java.net.URL;
import java.util.Properties;


/**
 * Some examples to show how the JAXP API for Transformations
 * could be used.
 *
 * @author <a href="mailto:scott_boag@lotus.com">Scott Boag</a>
 */
public class XSLTAplicationExample {

    /**
     * Method main
     * @param argv command line arguments.
     * There is a single argument, the name of the test to be run. The default is "all",
     * which runs all tests.
     */
    public static void main(String argv[]) {

        // MHK note. The SAX interface says that SystemIds must be absolute
        // URLs. This example assumes that relative URLs are OK, and that
        // they are interpreted relative to the current directory. I have
        // modified the Aelfred SAXDriver to make this work, as a number of
        // users had complained that Xalan allowed this and Saxon didn't.


        String entradaXML = "xml/banco.xml";
        String xsl = "xml/transformaBanco.xslt";
        String salidaXML = "c:/temp/salida.txt"; // si es "" la salida es por pantalla

        System.setProperty("javax.xml.transform.TransformerFactory", "net.sf.saxon.TransformerFactoryImpl");

            try {
                exampleTransformerReuse(entradaXML, xsl, salidaXML);
            } catch (Exception ex) {
                handleException(ex);
            }
    }

    /**
     * Show the simplest possible transformation from system id
     * to output stream.
     * @param sourceID file name of the source file
     * @param xslID file name of the stylesheet file
     */
    public static void exampleTransformerReuse(String sourceID, String xslID, String salidaID)
            throws TransformerException {

        // Create a transform factory instance.
        TransformerFactory tfactory = TransformerFactory.newInstance();

        // Create a transformer for the stylesheet.
        Transformer transformer =
            tfactory.newTransformer(new StreamSource(new File(xslID)));

        transformer.setParameter("a-param", "hello to you!");

        // Transform the source XML to System.out.
        transformer.transform(new StreamSource(new File(sourceID)),
                              new StreamResult(System.out));
        System.out.println("\n=========\n");
        transformer.setOutputProperty(OutputKeys.INDENT, "yes");

        // Transform the source XML to System.out.
        if (salidaID.compareTo("")!=0)
            transformer.transform(new StreamSource(new File(sourceID)),new StreamResult(new File(salidaID)));
        else
            transformer.transform(new StreamSource(new File(sourceID)),new StreamResult(System.out));

        //        new StreamResult(System.out));
    }

    /**
     * Show a transformation using a user-written URI Resolver.
     * @param sourceID file name of the source file
     * @param xslID file name of the stylesheet file
     */


    private static void handleException(Exception ex) {

        System.out.println("EXCEPTION: " + ex);
        ex.printStackTrace();

        if (ex instanceof TransformerConfigurationException) {
            System.out.println();
            System.out.println("Test failed");

            Throwable ex1 =
                ((TransformerConfigurationException) ex).getException();

            if (ex1!=null) {    // added by MHK
                ex1.printStackTrace();

                if (ex1 instanceof SAXException) {
                    Exception ex2 = ((SAXException) ex1).getException();

                    System.out.println("Internal sub-exception: ");
                    ex2.printStackTrace();
                }
            }
        }
    }


}
