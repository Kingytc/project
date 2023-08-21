<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ page import="java.rmi.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>

<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld" %>
<laps:handleerror />
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="strUserId" class="java.lang.String" scope="session" />
<%
	String strAccLvl = Helper.correctNull((String)hshValues.get("anal_acclevel"));
	hshValues.remove("anal_acclevel");
	String strIP = "";
	String strPath ="";
	String strFile ="";
	String strAppno="";
	String strUser="";
	String strDirname="";
	String strContent="";
	boolean bstate = false;
%>
<html>
<head>
<title>LAPS-Letters Navigation</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/set/navigate.js"></script>
<%
try
{
strAppno=request.getParameter("appno");
//strUser=request.getParameter("username");
//strUser=(String)hshValues.get("strUserId");
strUser=strUserId;
strDirname=request.getParameter("dirname");
//System.out.println("strAppno===="+strAppno);
//System.out.println("strUser===="+strUser);
//System.out.println("strDirname===="+strDirname);
strIP =(String) ApplicationParams.getIP();
//strPath = ApplicationParams.getFtpPath();
strFile = "Offline"+Math.random()+".rbi";
strContent=strIP+"&"+strPath;
strContent=strContent+"\\"+"&"+strUser+"&"+strDirname+"&"+strAppno;

File fileGraph=new File(strPath,strFile);
if(fileGraph.exists())
{
//System.out.println("exists");
}
else
{
//System.out.println("does not exists");
bstate = fileGraph.createNewFile();
//System.out.println("bstate="+bstate);
BufferedWriter bw = new BufferedWriter(new FileWriter(fileGraph));
int j = strContent.length();
bw.write(strContent,0,j);
bw.close();
}
//System.out.println("bstate  "+bstate);
}
catch(Exception ce)
{
	throw new Exception("Error in getData login  "+ce.toString());
}

%>
<script>
var path ="<%=ApplicationParams.getAppUrl()%>";

function onloading()
{
  var server="ftp://"+"<%=strIP%>"+"/";
 document.location.href=server+"<%=strFile%>";

}

</script>
<style>
select {  font-family: "MS Sans Serif"; font-size: 9px; color: #003399 ;border-style: groove}
textarea {  font-family: "MS Sans Serif"; font-size: 9px; color: #003399; border-style: groove}
input {  font-family: "MS Sans Serif"; font-size: 9px; color: #000000}

.HILITE
{ color:#CC0000;}
.NONHILITE
{ color:#000000;}

a:hover {  color: #CC3300}
</style>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
</head>

<body bgcolor="#EEEAE3" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="onloading()">
<form name="updateinfo">



<input type="hidden" name="hiddesc">
<input type="hidden" name="hidId" value="<%=request.getParameter("hidId") %>">
<input type="hidden" name="hidAction" >
<input type="hidden" name="hidBeanId">
<input type="hidden" name="hidBeanMethod">
<input type="hidden" name="hidSourceUrl">
</form>
</body>
</html>
