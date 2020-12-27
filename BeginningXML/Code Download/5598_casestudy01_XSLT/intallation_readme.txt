Installing the case study application

1. Download Tomcat version 4.x from http://jakarta.apache.org/site/binindex.html. Look for the 4.x version. Don't use version 3.x as it will only work with a parser version that is different from the parser version the XSLT engine requires. Tomcat version 4.0 is currently in beta at the time of this writing as it waits for an underlying servlet specification to become final.

2. Install Tomcat either with the setup program or by unpacking the files into a convenient directory such as C:\java\tomcat. I suggest avoiding a directory path that includes imbedded spaces such as C:\Program Files\... as white space can be interpreted as the end of a file specifying string in Java or Unix.

3. Set an environment variable that tells Tomcat where your Java runtime installation resides such as JAVA_HOME=c:\java\java1_3. Environment variables can be set in the shell or DOS box you are executing Tomcat in, or as a system variable in Windows under My Computer->Properties. This may not be necessary if Java was installed properly with its installer. In my case I just copied Java into a directory so none of the environment variables or Windows registry settings were created.

4. Configure the web server listening port if you already have a web server running. If you don't, ignore this item. When Tomcat is started it will use port 8080 if you haven't done anything to configure it. That is the standard port for all Java Web Servers and Tomcat so if you already have a server running that listens at that port you will have to stop it first. You can configure the port that the Tomcat server listens on in TOMCAT_HOME/conf/server.xml. Search for the string 8080 to find the element.

5. Drop the xsl.war file from the Wrox web site into Tomcat's web applications directory at TOMCAT_HOME/webapps. Note that the TOMCAT_HOME/webapps/xsl directory does not exist when you first install Tomcat but will be created from the xsl.war file when Tomcat is first started. That means you can't change anything in the application until after the first time it runs.

6. Start the server with startup.bat or startup.sh in TOMCAT_HOME/bin from that directory, not from your hard drive root directory or your shell home or other directory. To start the server in Windows, open a DOS or command window which will show the standard prompt C:\. Change directory to TOMCAT_HOME\bin. Then type startup.

7. Point your browser at http://localhost:8080/xsl/xslapp to start the application. Expect a delay when the application first starts. This URL assumes you have the default installation on the computer you are running the browser on.

