<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ page import="java.util.*,java.text.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<% request.setAttribute("_cache_refresh", "true"); %>
<laps:handleerror/>
<%
ArrayList arrCol			= new ArrayList();
ArrayList arrPreGenTCRow	= new ArrayList();
ArrayList arrPostGenTCRow	= new ArrayList();
ArrayList arrFacPreTCRow	= new ArrayList();
ArrayList arrFacPostTCRow	= new ArrayList();
ArrayList arrFacMjrTCRow	= new ArrayList();
ArrayList arrInsBranchRow	= new ArrayList();
ArrayList arrOtherPreTCRow		= new ArrayList();

String strPagetype = Helper.correctNull((String)request.getParameter("pagetype"));
HashMap hshTermsandcond = new HashMap();
if(hshValues!=null)
{
	hshTermsandcond = (HashMap)hshValues.get("hshTermsandcond");
	if((strPagetype.equalsIgnoreCase("sancbranch")) || (strPagetype.equalsIgnoreCase("sancborrower"))|| (strPagetype.equalsIgnoreCase("RPN")))
	{
		arrPreGenTCRow		= (ArrayList)hshTermsandcond.get("arrPreGenTCRow");
		arrPostGenTCRow		= (ArrayList)hshTermsandcond.get("arrPostGenTCRow");
		arrFacPreTCRow		= (ArrayList)hshTermsandcond.get("arrFacPreTCRow");
		arrFacPostTCRow		= (ArrayList)hshTermsandcond.get("arrFacPostTCRow");
		arrFacMjrTCRow		= (ArrayList)hshTermsandcond.get("arrFacMjrTCRow");
		arrOtherPreTCRow	= (ArrayList)hshTermsandcond.get("arrOtherPreTCRow");
		arrInsBranchRow		= (ArrayList)hshTermsandcond.get("arrInsBranchRow");
	}
	else
	{
		arrPreGenTCRow	= (ArrayList)hshValues.get("arrPreGenTCRow");
		arrPostGenTCRow	= (ArrayList)hshValues.get("arrPostGenTCRow");
		arrFacPreTCRow	= (ArrayList)hshValues.get("arrFacPreTCRow");
		arrFacPostTCRow	= (ArrayList)hshValues.get("arrFacPostTCRow");
		arrFacMjrTCRow	= (ArrayList)hshValues.get("arrFacMjrTCRow");
		arrOtherPreTCRow = (ArrayList)hshValues.get("arrOtherPreTCRow");
		arrInsBranchRow	= (ArrayList)hshValues.get("arrInsBranchRow");
	}
}
String strFlag = Helper.correctNull((String)hshValues.get("strFlag"));
String strNil	= "Nil";
%>
<html>
<head>
<title>Annexure - VII</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
body, table td
{
FONT-SIZE: 16px !important; COLOR: #000000 !important; FONT-FAMILY: "Book Antiqua" !important;
}
#top{background-color: #ffffff;}
#top table{ border-collapse: collapse;}
#top td {border: 0.5pt solid #000000; FONT-SIZE: 16px; COLOR: #000000; LINE-HEIGHT: 16px; FONT-FAMILY: "Book Antiqua"}

.title
{
FONT-SIZE: 16px !important; COLOR: #000000 !important; FONT-FAMILY: "Book Antiqua" !important;font-weight: bold !important;
}
</style>
</head>
<body>
<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
<% if((strPagetype.equalsIgnoreCase("sancbranch")) || (strPagetype.equalsIgnoreCase("sancborrower"))|| (strPagetype.equalsIgnoreCase("RPN"))){ %>
<tr><td align="center"><br>&nbsp;</td></tr>
<%} else if (strFlag.equalsIgnoreCase("Y")) { %>
	<tr><td align="center" class="title"><br>ANNEXURE	- III</td></tr>
<%}else{ %>
<tr><td align="center" class="title"><br>ANNEXURE	- VII</td></tr>
<%} %>
<tr><td>
<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr><td class="title"><br>TERMS AND CONDITIONS:</td></tr>
</table>
</td></tr>
<%
ArrayList arrFacilityTermApp0 = new ArrayList();
ArrayList arrFacilityTerm0 = new ArrayList();
ArrayList arrFacilityIdVal0 = new ArrayList();
ArrayList arrParentID0 = new ArrayList();
	int j=0;
	int sub=0;
	int main=0;
	String prevSno="";
	String currParentId="";
	String termsno = "";
	boolean booflag=true;
	boolean subflag=true;
	if(arrFacilityTerm0!=null && arrFacilityTerm0.size()>0)
	{ %>
	<tr><td>
<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
		<tr><td class="title"><b>Specific:</b></td></tr>
	<%	j=arrFacilityTerm0.size();
		for(int i=0;i<arrFacilityTerm0.size();i++)
		{
			termsno = Helper.correctNull((String) arrFacilityIdVal0.get(i));
			currParentId=Helper.correctNull((String) arrParentID0.get(i));
			if(currParentId.equalsIgnoreCase("0") && subflag==true )
			{
				booflag=true;
				sub=0;
			}
			if(booflag)
			{
				main = main+1;
				prevSno=Helper.correctNull((String) arrFacilityIdVal0.get(i));
				booflag=false;
			}
		%>
		<%if(currParentId.equalsIgnoreCase("0"))
		{
			subflag=true;
		%>
		<tr> 
		  	<td valign="top" nowrap="nowrap">
		      	<table cellpadding="3" cellspacing="0" width="95%" >
			      	<tr>
			      		<td width="2%" valign="top"><%=main%>.</td>
			      		<td style="text-align: justify;"><%=arrFacilityTerm0.get(i)%></td>
			      	</tr>
		      	</table>
	      	</td>
		</tr>
		<%}
		if(prevSno.equalsIgnoreCase(currParentId) && (!currParentId.equalsIgnoreCase("0")))
		{
		%>
		<tr> 
	      	<td valign="top" nowrap="nowrap">
		      	<table cellpadding="3" cellspacing="0" width="98%" align="right">
			      	<tr>
			      		<td width="2%" valign="top">&nbsp;<%=main%>.<%=++sub%></td>
			      		<td style="text-align: justify;"><%=arrFacilityTerm0.get(i)%></td>
			      	</tr>
		      	</table>
	      	</td>
	    </tr>
		
		<%}
		}%>
</table>
</td>
</tr>
	<%} %>
	<%
	if(arrFacilityTermApp0!=null)
	{%>
<tr><td>
<table width="96%" align="center" cellpadding="3" cellspacing="0" border="0">
		<%for(int i=0;i<arrFacilityTermApp0.size();i++)
			
		{  main = main+1;
		%>
		<tr > 
		  <td align="center"> 
		    <div align="left" style="text-align: justify;"><%=main%>.&nbsp;<%=arrFacilityTermApp0.get(i)%></div>
		  </td>
		</tr>
		<%
		}%>
</table>
</td>
</tr>
	<%} %>
	

<!-- General PRE -->
<% if((strPagetype.equalsIgnoreCase("sancbranch")) || (strPagetype.equalsIgnoreCase("sancborrower"))){ %>
<tr><td class="title">GENERAL CONDITIONS</td></tr>
<%} else if (strFlag.equalsIgnoreCase("Y")) { %>
	<tr><td align="center" class="title"><br>TERMS AND CONDITIONS</td></tr>
<%}else{ %>
<tr><td align="center" class="title"><br>GENERAL CONDITIONS</td></tr>
<%} %>
<tr><td align="left" class="title"><br>PRE DISBURSEMENT TERMS</td></tr>
<tr>
<td>
<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
<%
sub=0;
main=0;
prevSno="";
currParentId="";
termsno = "";
booflag=true;
subflag=true;
if(arrPreGenTCRow!=null&&arrPreGenTCRow.size()>0)
{
	for(int i=0;i<arrPreGenTCRow.size();i++)
	{
		arrCol	= (ArrayList)arrPreGenTCRow.get(i);
		 termsno = Helper.correctNull((String) arrCol.get(0));
		currParentId=Helper.correctNull((String) arrCol.get(3));
		if(currParentId.equalsIgnoreCase("0") && subflag==true )
		{
			booflag=true;
			sub=0;
		}
		if(booflag)
		{
			main = main+1;
			prevSno=Helper.correctNull((String) arrCol.get(0));
			booflag=false;
		}
		
		if(currParentId.equalsIgnoreCase("0"))
		{
		 subflag=true;%>
		<tr>
			<td width="3%" valign="top"><%=main%>.</td>
			<td style="text-align: justify;" colspan="2" width="97%" valign="top"><%=Helper.correctNull((String)arrCol.get(1))%></td>
		</tr>
		<%}if(prevSno.equalsIgnoreCase(currParentId) && (!currParentId.equalsIgnoreCase("0"))){%>
		<tr>
		<tD>&nbsp;</tD>
		<tD valign="top"><%=main%>.<%=++sub%></tD>
		<tD style="text-align: justify;" width="97%" valign="top"><%=Helper.correctNull((String)arrCol.get(1))%></tD>
		</tr>
		<%}
		}
		}else{%>
			<tr><td style="border: none;"><%=strNil%></td></tr>
		<%} %>
</table>
</td>
</tr>
<!-- General POST -->
<tr><td align="left" class="title"><br>POST DISBURSEMENT TERMS</td></tr>
<tr>
<td>
<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
<%
booflag=true;
subflag=true;
main=0;
if(arrPostGenTCRow!=null&&arrPostGenTCRow.size()>0)
{
	for(int i=0;i<arrPostGenTCRow.size();i++)
	{
		arrCol	= (ArrayList)arrPostGenTCRow.get(i);
		termsno = Helper.correctNull((String) arrCol.get(0));
		currParentId=Helper.correctNull((String) arrCol.get(3));
		if(currParentId.equalsIgnoreCase("0") && subflag==true )
		{
			booflag=true;
			sub=0;
		}
		if(booflag)
		{
			main=main+1;
			prevSno=Helper.correctNull((String) arrCol.get(0));
			booflag=false;
		}
		
		if(currParentId.equalsIgnoreCase("0"))
		{
		 subflag=true;
		%>
		<tr>
			<td width="3%" valign="top"><%=main%>.</td>
			<td style="text-align: justify;" width="97%" valign="top" colspan="2"><%=Helper.correctNull((String)arrCol.get(1))%></td>
		</tr>
		<%}if(prevSno.equalsIgnoreCase(currParentId) && (!currParentId.equalsIgnoreCase("0"))){ %>
		<tr>
		<tD>&nbsp;</tD>
		<tD valign="top"><%=main%>.<%=++sub%></tD>
		<tD style="text-align: justify;" width="97%" valign="top"><%=Helper.correctNull((String)arrCol.get(1))%></tD>
		</tr>
		<%} %>
		<%
	}
}else{
%>
<tr><td style="border: none;"><%=strNil%></td></tr>
<%} %>
</table>
</td>
</tr>

<!-- Other Conditions -->
<tr><td align="left" class="title"><br>OTHER CONDITIONS</td></tr>
<tr>
<td>
<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
<%
booflag=true;
subflag=true;
main=0;
if(arrOtherPreTCRow!=null&&arrOtherPreTCRow.size()>0)
{
	for(int i=0;i<arrOtherPreTCRow.size();i++)
	{
		arrCol	= (ArrayList)arrOtherPreTCRow.get(i);
		termsno = Helper.correctNull((String) arrCol.get(0));
		currParentId=Helper.correctNull((String) arrCol.get(3));
		if(currParentId.equalsIgnoreCase("0") && subflag==true )
		{
			booflag=true;
			sub=0;
		}
		if(booflag)
		{
			main=main+1;
			prevSno=Helper.correctNull((String) arrCol.get(0));
			booflag=false;
		}
		
		if(currParentId.equalsIgnoreCase("0"))
		{
		 subflag=true;
		%>
		<tr>
			<td width="3%" valign="top"><%=main%>.</td>
			<td style="text-align: justify;" colspan='2' width="97%" valign="top"><%=Helper.correctNull((String)arrCol.get(1))%></td>
		</tr>
		<%}if(prevSno.equalsIgnoreCase(currParentId) && (!currParentId.equalsIgnoreCase("0"))){%>
		<tr>
		<tD>&nbsp;</tD>
		<tD valign="top"><%=main%>.<%=++sub%></tD>
		<tD style="text-align: justify;" width="97%" valign="top"><%=Helper.correctNull((String)arrCol.get(1))%></tD>
		</tr>
<%	}}
}else{
%>
<tr><td style="border: none;"><%=strNil%></td></tr>
<%} %>
</table>
</td>
</tr>



<!-- FACILITY TC-->
<%
String Facid="",strFacid="",strFacSno="";
if(arrFacMjrTCRow!=null && arrFacMjrTCRow.size()>0){
	%>
	<%
	for(int i=0;i<arrFacMjrTCRow.size();i++)
	{
		arrCol	= (ArrayList)arrFacMjrTCRow.get(i);
		Facid = Helper.correctNull((String)arrCol.get(2));
		strFacSno = Helper.correctNull((String)arrCol.get(0));
%>
<tr><td align="left" class="title"><br><%=Helper.correctNull((String)arrCol.get(1))%></td></tr>
<tr>
<td>
<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
<%
booflag=true;
subflag=true;
main=0;
if(arrFacPreTCRow!=null&&arrFacPreTCRow.size()>0)
{
	for(j=0;j<arrFacPreTCRow.size();j++)
	{
		arrCol	= (ArrayList)arrFacPreTCRow.get(j);
		strFacid= Helper.correctNull((String)arrCol.get(2));
		if(strFacid.equalsIgnoreCase(Facid) && Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase(strFacSno))
		{
		termsno = Helper.correctNull((String) arrCol.get(0));
		currParentId=Helper.correctNull((String) arrCol.get(3));
		if(currParentId.equalsIgnoreCase("0") && subflag==true )
		{
			booflag=true;
			sub=0;
		}
		if(booflag)
		{
			main=main+1;
			prevSno=Helper.correctNull((String) arrCol.get(0));
			booflag=false;
		}
		
		if(currParentId.equalsIgnoreCase("0"))
		{
		 subflag=true;
		%>
		<tr>
			<td width="3%" valign="top"><%=main%>.</td>
			<td style="text-align: justify;" colspan='2' width="97%" valign="top"><%=Helper.correctNull((String)arrCol.get(1))%></td>
		</tr>
		<%}if(prevSno.equalsIgnoreCase(currParentId) && (!currParentId.equalsIgnoreCase("0"))){ %>
		<tr>
		<tD>&nbsp;</tD>
		<tD valign="top"><%=main%>.<%=++sub%></tD>
		<tD style="text-align: justify;" width="97%" valign="top"><%=Helper.correctNull((String)arrCol.get(1))%></tD>
		</tr>
		<%}%>
		<%
	}}
}else{
%>
<tr><td style="border: none;"><%=strNil%></td></tr>
<%} %>
</table>
</td>
</tr>

<%} }%>

<%
if(!strPagetype.equalsIgnoreCase("sancborrower")){ %>
<tr><td align="left" class="title"><br>INSTRUCTIONS TO THE BRANCH</td></tr>
<tr>
<td>
<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
<%
booflag=true;
subflag=true;
main=0;
if(arrInsBranchRow!=null&&arrInsBranchRow.size()>0)
{
	for(int i=0;i<arrInsBranchRow.size();i++)
	{
		arrCol	= (ArrayList)arrInsBranchRow.get(i);
		termsno = Helper.correctNull((String) arrCol.get(0));
		currParentId=Helper.correctNull((String) arrCol.get(3));
		if(currParentId.equalsIgnoreCase("0") && subflag==true )
		{
			booflag=true;
			sub=0;
		}
		if(booflag)
		{
			main=main+1;
			prevSno=Helper.correctNull((String) arrCol.get(0));
			booflag=false;
		}
		
		if(currParentId.equalsIgnoreCase("0"))
		{
		 subflag=true;
		%>
		<tr>
			<td width="3%" valign="top"><%=main%>.</td>
			<td style="text-align: justify;" colspan='2' width="97%" valign="top"><%=Helper.correctNull((String)arrCol.get(1))%></td>
		</tr>
		<%}if(prevSno.equalsIgnoreCase(currParentId) && (!currParentId.equalsIgnoreCase("0"))){%>
		<tr>
			<td>&nbsp;</td>
			<td valign="top"><%=main%>.<%=++sub%></td>
			<td style="text-align: justify;" width="97%" valign="top"><%=Helper.correctNull((String)arrCol.get(1))%></td>
		</tr>
<%	}
   }
 }else{
%>
<tr><td style="border: none;"><%=strNil%></td></tr>
<%} %>
</table>
</td>
</tr>
<%} %>

<tr><td><br><br><br><br></td></tr>
</table>
</body>
</html>