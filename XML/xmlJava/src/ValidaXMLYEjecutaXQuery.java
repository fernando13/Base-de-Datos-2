//Java
import java.io.*;
import java.util.Properties;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.sax.SAXSource;
import javax.xml.transform.stream.StreamResult;
import org.xml.sax.InputSource;

//SAXON
import net.sf.saxon.om.DocumentInfo;
import net.sf.saxon.Configuration;
import net.sf.saxon.om.NodeInfo;
import net.sf.saxon.query.DynamicQueryContext;
import net.sf.saxon.query.StaticQueryContext;
import net.sf.saxon.query.XQueryExpression;
import net.sf.saxon.trans.XPathException;



//Librerías de SAX 
import org.xml.sax.*;
import org.xml.sax.helpers.*;

import javax.xml.parsers.*;
import org.w3c.dom.Document;


public class ValidaXMLYEjecutaXQuery {

	// Constantes para validación de Schemas 
    static final String JAXP_SCHEMA_LANGUAGE = 
               "http://java.sun.com/xml/jaxp/properties/schemaLanguage";
    static final String W3C_XML_SCHEMA = 
               "http://www.w3.org/2001/XMLSchema";

	public void ejecutaXQuery(String entradaXML, String query, String salidaXML)
	{
    InputStream queryStream=null;
      
    //documentul XML ce va fi interogat este reprezentat de
    //fisierul AircraftDealer.xml  
    File XMLStream=null;
//    String xmlFileName="C://banco.xml";

    //print the result to the console
    OutputStream destStream = null;
    try {
		if (salidaXML.compareTo("")==0)
			destStream = System.out;
		else
			destStream = new FileOutputStream(salidaXML);
	} catch (FileNotFoundException e1) {
		// TODO Auto-generated catch block
		e1.printStackTrace();
	}
                       
    //compile the XQuery expression
    XQueryExpression exp=null;
    
    //create a Configuration object
    Configuration C=new Configuration();
     
    //static and dynamic context
    StaticQueryContext SQC=new StaticQueryContext(C);
    DynamicQueryContext DQC=new DynamicQueryContext(C);      
     
    //indentation
    Properties props=new Properties();
    props.setProperty(OutputKeys.METHOD,"xml");
    props.setProperty(OutputKeys.INDENT,"yes");

     try{
//        queryStream=new FileInputStream(queryFileName);
//        SQC.setBaseURI(new File(queryFileName).toURI().toString());
        
        //compilation
        exp=SQC.compileQuery(query);
        
        }catch(net.sf.saxon.trans.XPathException e)
          { 
        	e.printStackTrace();
        	System.err.println(e.getMessage());
        }
       
       //get the XML ready
       try{   
          XMLStream=new File(entradaXML);
          InputSource XMLSource=new InputSource(XMLStream.toURI().toString());
          SAXSource SAXs=new SAXSource(XMLSource);
          
          DocumentInfo DI=SQC.buildDocument(SAXs);
          DQC.setContextNode(DI);
          
          //evaluating
          exp.run(DQC,new StreamResult(destStream),props);
          destStream.close();
          }catch(net.sf.saxon.trans.XPathException e)
               {System.err.println(e.getMessage());
          }catch (java.io.IOException e)
               {System.err.println(e.getMessage());}
                       
 }
	
	public void validaDocumento(String xmlFileName)
	{
		 // Constantes para validacion de Schemas   
		 final String JAXP_SCHEMA_LANGUAGE = "http://java.sun.com/xml/jaxp/properties/schemaLanguage";  
		 final String JAXP_SCHEMA_SOURCE = "http://java.sun.com/xml/jaxp/properties/schemaSource";  
		 final String W3C_XML_SCHEMA = "http://www.w3.org/2001/XMLSchema";
//		 final String MY_SCHEMA = "C:/banco.xsd";  
//		 final String MY_XML= "C:/banco.xml";  
		                           
		 // Creando la factoria e indicando que hay validacion  
		 DocumentBuilderFactory documentBuilderFactory = DocumentBuilderFactory.newInstance();  
		documentBuilderFactory.setNamespaceAware(true);  
		 documentBuilderFactory.setValidating(true);  
		           
		 try {  
		     
		   //Configurando el Schema de validacion          
		   documentBuilderFactory.setAttribute(JAXP_SCHEMA_LANGUAGE, W3C_XML_SCHEMA);  
		   //documentBuilderFactory.setAttribute(JAXP_SCHEMA_SOURCE, new File(MY_SCHEMA));  
		            
		   // Parseando el documento  
		  DocumentBuilder documentBuilder = documentBuilderFactory.newDocumentBuilder();  
		     
		  Document parse = documentBuilder.parse(new File(xmlFileName));  
		   } catch (SAXException saxEx){  
			   saxEx.printStackTrace();  
		   } catch (Exception ex) {  
			   ex.printStackTrace();
		         
	       }  	
	}
	
    public static void main(String[] args) {

     ValidaXMLYEjecutaXQuery prueba = new ValidaXMLYEjecutaXQuery();
     String documento = "./xml/banco.xml";
     prueba.validaDocumento(documento);
     String xquery = "for      $x in /banco/cuenta" +
	   "     let       $nroCuenta := $x/nro_cuenta" +
	   "    where $x/saldo > 400 " +
	   "     return <cuenta>{$nroCuenta/text()} </cuenta>";

  		
     
     prueba.ejecutaXQuery(documento,xquery,"");
  }
}