import org.xml.sax.helpers.XMLReaderFactory;
import org.xml.sax.XMLReader;
import org.xml.sax.SAXException;
import org.xml.sax.Attributes;
import org.xml.sax.helpers.DefaultHandler;

public class SaxFinder extends DefaultHandler
{
	private StringBuffer saxophonist = new StringBuffer();
	private boolean isSaxophone = false;
		
	public static void main(String[] args) throws Exception 
	{
		System.out.println("Here we go ...");
		SaxFinder readerObj = new SaxFinder();
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
		if (qName.equals("saxophone"))
		{
			isSaxophone = true;
			saxophonist.setLength(0);
		}
		
		else
			isSaxophone = false;
	}
	
	public void endElement(String uri, String localName, String qName) throws SAXException
	{
		if (isSaxophone)
		{
			System.out.println("Saxophonist is " + saxophonist.toString());
			isSaxophone = false;
		}
	}											   
	
	public void characters(char[] chars, int start, int len) throws SAXException
	{
		if (isSaxophone)
			saxophonist.append(chars, start, len);
	}
}
