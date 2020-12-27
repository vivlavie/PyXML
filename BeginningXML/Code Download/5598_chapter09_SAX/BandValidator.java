import org.xml.sax.helpers.XMLReaderFactory;
import org.xml.sax.XMLReader;
import org.xml.sax.SAXException;
import org.xml.sax.Attributes;
import org.xml.sax.helpers.DefaultHandler;
import org.xml.sax.Locator;
import org.xml.sax.SAXParseException;

public class BandValidator extends DefaultHandler
{
	private StringBuffer saxophonist = new StringBuffer();
	private boolean isSaxophone = false;
	private StringBuffer bandName = new StringBuffer();
	private boolean isName = false;
	private String bandType = new String();
	private Locator locatorObj;
		
	public static void main(String[] args) throws Exception 
	{
		System.out.println("Here we go ...");
		BandValidator readerObj = new BandValidator();
		readerObj.read(args[0]);
	}
	
	public void read (String fileName) throws Exception 
	{
		XMLReader readerObj = XMLReaderFactory.createXMLReader("org.apache.xerces.parsers.SAXParser");
		
		try
		{
			readerObj.setFeature("http://xml.org/sax/features/validation", true);
		}
		
		catch (SAXException e)
		{
			System.err.println("Cannot activate validation");
		}

		readerObj.setContentHandler (this);
		readerObj.setErrorHandler (this);
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
		if (qName.equals("band"))
		{
			bandType = atts.getValue("type");
			
			if (bandType == null)
			{
				if (locatorObj != null)
					System.err.println ("Error in " + locatorObj.getSystemId() + " at line " + locatorObj.getLineNumber() + ", column " + locatorObj.getColumnNumber());
				
				throw new SAXException("Band type not specified");
			}
		}
		
		else if (qName.equals("name"))
		{
			isName = true;
			isSaxophone = false;
			bandName.setLength(0);
		}
		
		else if (qName.equals("saxophone"))
		{
			isName = false;
			isSaxophone = true;
			saxophonist.setLength(0);
		}
		
		else
		{
			isName = false;
			isSaxophone = false;
		}
	}
	
	public void endElement(String uri, String localName, String qName) throws SAXException
	{
		if (isSaxophone)
		{
			System.out.println("The saxophonist in " + bandName.toString() + " (" + bandType + ") is " + saxophonist.toString());
			isSaxophone = false;
		}
		
		if (isName)
			isName = false;
	}											   
	
	public void characters(char[] chars, int start, int len) throws SAXException
	{
		if (isName)
			bandName.append(chars, start, len);

		if (isSaxophone)
			saxophonist.append(chars, start, len);
	}

	public void setDocumentLocator(Locator loc)
	{
		locatorObj = loc;
	}
	
	public void warning(SAXParseException exception) throws SAXException
	{
		System.err.println("Warning in " + exception.getSystemId() + " at line " + exception.getLineNumber() + ", column " + exception.getColumnNumber());
	}
	
	public void error(SAXParseException exception) throws SAXException
	{
		System.err.println("Error in " + exception.getSystemId() + " at line " + exception.getLineNumber() + ", column " + exception.getColumnNumber());
	}
	
	public void fatalError(SAXParseException exception) throws SAXException
	{
		System.err.println("Fatal error in " + exception.getSystemId() + " at line " + exception.getLineNumber() + ", column " + exception.getColumnNumber());
		throw exception;
	}
}
