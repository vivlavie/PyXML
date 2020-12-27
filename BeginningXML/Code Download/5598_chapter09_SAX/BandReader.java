import org.xml.sax.helpers.XMLReaderFactory;
import org.xml.sax.XMLReader;
import org.xml.sax.SAXException;
import org.xml.sax.Attributes;
import org.xml.sax.helpers.DefaultHandler;

public class BandReader extends DefaultHandler
{
	public static void main(String[] args) throws Exception 
	{
		System.out.println("Here we go ...");
		BandReader readerObj = new BandReader();
		readerObj.read(args[0]);
	}
	
	public void read (String fileName) throws Exception 
	{
		XMLReader readerObj = XMLReaderFactory.createXMLReader("org.apache.xerces.parsers.SAXParser");
		readerObj.setContentHandler (this);
		readerObj.parse (fileName);
	}
	
	public void startDocument() throws SAXException 
	{
		System.out.println("Starting ...");
	}
	
	public void endDocument() throws SAXException 
	{
		System.out.println("... Finished");
	}
	
	public void startElement(String uri, String localName, String qName, Attributes atts) throws SAXException 
	{
		System.out.println("Element is " + qName);
	}
}
