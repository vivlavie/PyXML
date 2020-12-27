import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import org.w3c.dom.*;
import javax.xml.parsers.*;
import org.xml.sax.*;
import org.apache.crimson.tree.*;
import javax.xml.transform.*;
import javax.xml.transform.stream.*;
import javax.xml.transform.dom.*;


public class xslapp extends HttpServlet {
  DocumentBuilderFactory dbf = null;
  DocumentBuilder db = null;
  TransformerFactory tFactory;
  String path;
  String debug = "false";
  String docFileName, stylesheetFileName;

  public void init() throws ServletException{
    dbf = DocumentBuilderFactory.newInstance ();
    try{
      db = dbf.newDocumentBuilder ();
    }
    catch (ParserConfigurationException e){
      throw new ServletException(e.getMessage());
    }
    tFactory = TransformerFactory.newInstance();
    path = getServletContext().getRealPath("") + "/";
    docFileName = path + getServletConfig().getInitParameter("document");
    stylesheetFileName = path + getServletConfig().getInitParameter("stylesheet");
    debug = getServletConfig().getInitParameter("debug");
    if (debug == null) debug = "false";
  }

  public void service(HttpServletRequest request, HttpServletResponse
  response) throws IOException, ServletException {
    response.setContentType("text/html");
    PrintWriter out = response.getWriter();
    try{
      Document docToXSL = createFromFileWithParams(request, docFileName);
      String sId = request.getSession().getId();
      transform(docToXSL, stylesheetFileName, out, sId);
    }
    catch(Exception e){
      out.print("Exception: " + e.getMessage());
    }
  }

  Document createFromFileWithParams(HttpServletRequest request, String fn)
    throws ServletException {
    Document doc = null;
    try{
      doc = db.parse(new File(fn));
    }
    catch(IOException e){
      throw new ServletException(e.getMessage());
    }
    catch(SAXException e){
      throw new ServletException(e.getMessage());
    }
    Element root = doc.getDocumentElement();
    Node first_child = root.getFirstChild();
    Element param = doc.createElement("param");

    // get an enumeration of all the parameter names found in the http query string
    Enumeration ereq = request.getParameterNames();
    String name, value;
    Text tRow;
    Element curRow;
    // iterate through the parameter names
    while (ereq.hasMoreElements()){
      name = (String) ereq.nextElement(); // from the enumeration
      value = request.getParameter(name);     // from the request

      // the text between tags is actually a node itself
      tRow = (Text) doc.createTextNode(value);

      // create a new node naming it the current name
      curRow = (Element) doc.createElement(name);
      curRow.appendChild(tRow);           // and attach the text value

      param.appendChild(curRow);  // add the node just built to the param node
    }

    // finally insert the param node into the doc root
    root.insertBefore(param, first_child);
    return doc;
  }

  void transform(Document doc, String xsl, PrintWriter out, String id)
      throws ServletException, IOException{

    try{
      Transformer transformer = tFactory.newTransformer(new StreamSource(xsl));
      transformer.setParameter ("_real-path", path);
      transformer.setParameter("_session-id", id);
      transformer.transform(new DOMSource(doc), new StreamResult(out));

      // for raw XML debugging, send the source doc to the browser
      if(debug.equalsIgnoreCase("true"))
        ((XmlDocument) doc).write(out);
    }
    catch(TransformerConfigurationException tce){
      System.out.println("Exception in " + xsl + ": " + tce.getMessage());
      throw new ServletException("Configuration Exception in " + xsl + ": " +
        tce.getMessageAndLocation());
    }
    catch(TransformerException te){
      System.out.println("Exception in " + xsl + ": " + te.getMessageAndLocation());
      throw new ServletException("Transform Exception in " + xsl + ": " +
        te.getMessageAndLocation());
    }
  }

}
