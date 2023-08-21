<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%@include file="../share/directives.jsp"%>
<%ArrayList arrVal = new ArrayList();
			ArrayList arrValdesc = new ArrayList();
			ArrayList arrValint = new ArrayList();
			ArrayList arrValdate = new ArrayList();
			ArrayList arrValrefno = new ArrayList();
			ArrayList arrValrefdt = new ArrayList();
			ArrayList arrValdet = new ArrayList();
			ArrayList arrValActive = new ArrayList();
			
			arrVal = (ArrayList) hshValues.get("arrVal");
			arrValdesc = (ArrayList) hshValues.get("arrValdesc");
			arrValint = (ArrayList) hshValues.get("arrValint");
			arrValdate = (ArrayList) hshValues.get("arrValdate");
			arrValrefno = (ArrayList) hshValues.get("arrValrefno");
			arrValrefdt = (ArrayList) hshValues.get("arrValrefdt");
			arrValdet = (ArrayList) hshValues.get("arrValdet");
			arrValActive = (ArrayList)hshValues.get("arrValActive");
			
			
			String s = "";
			String s1 = "";
			String s2 = "";
			String s3 = "";
			String s4 = "";
			String s5 = "";
			String s6 = "";
			String s7 = "";

			for (int i = 0; i < arrVal.size(); i++) {
				s = s + arrVal.get(i) + "^";
				s1 = s1 + arrValdesc.get(i) + "^";
				s2 = s2 + arrValint.get(i) + "^";
				s3 = s3 + arrValdate.get(i) + "^";
				s4 = s4 + arrValrefno.get(i) + "^";
				s5 = s5 + arrValrefdt.get(i) + "^";
				s6 = s6 + Helper.replaceForJavaScriptString((String)arrValdet.get(i)) + "^";
				s7 = s7 + arrValActive.get(i) + "^";
			}

			%>
<HTML>
<HEAD>
<TITLE>List Of Interest Type</TITLE>
<META NAME="Generator" CONTENT="EditPlus">
<style type="text/css">
DIV.cellContainer 
{	
  width: 100%; height: 300;
  overflow: auto;
}

</STYLE>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/headmenu.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";

function place(val)
{
	var id=val;	
	arr="<%=s%>";
	arr1=arr.split("^");	
	arrVal="<%=s1%>";
	arrVal1=arrVal.split("^");
	arrValint="<%=s2%>";
	arrValint1=arrValint.split("^")	;
	arrValdate="<%=s3%>";
	arrValdate1=arrValdate.split("^");	
	arrValrefno="<%=s4%>";
	arrValrefno1=arrValrefno.split("^");	
	arrValrefdt="<%=s5%>";
	arrValrefdt1=arrValrefdt.split("^");	
	
	arrValdet="<%=s6%>";
	arrValdet1=arrValdet.split("^");
	
	arrValActive="<%=s7%>";
	arrValActive1=arrValActive.split("^");
	
	
	window.opener.document.forms[0].id.value=arr1[id];
	window.opener.document.forms[0].txtinterest.value=arrVal1[id];
	window.opener.document.forms[0].txtrate.value=arrValint1[id];
	window.opener.document.forms[0].txtrate_old.value=arrValint1[id];
	window.opener.document.forms[0].txtcircrefno.value=arrValrefno1[id];
	window.opener.document.forms[0].txtcircdate.value=arrValrefdt1[id];
	window.opener.document.forms[0].circulartext.value=arrValdet1[id];	
	
	window.opener.document.forms[0].selactive.value=arrValActive1[id];
	
	//window.opener.document.forms[0].dat.value=arrValdate1[id];
	window.opener.document.forms[0].cmdsave.disabled=true;
	window.opener.document.forms[0].cmdcancel.disabled=true;
	//window.opener.document.forms[0].cmddelete.disabled=true;
	window.opener.document.forms[0].cmdclose.disabled=false;
	window.opener.document.forms[0].cmdedit.disabled=false;
	self.close();	
}

function call_page()
{
	window.close();	
}

function doClose()
{
	window.close();
}

</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</HEAD>
<body>
<form class="normal">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()" onMouseout="lowlightie5()" onClick="jumptoie5()"> 
  <div class="menuitems" url="">
   <script language="JavaScript1.2">


</script>
</div>
  </div>
<table border="0" cellspacing="0" cellpadding="3"
	 width="98%"
	align="center" class="outertable border1">
	<tr>
		<td valign="top">
		<div class="cellcontainer"> 
		<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
			<tr class="dataheader">
				<td colspan="3"><b>
					 The Interest Rate Description </b></td>
			</tr>
			
			
			 <%for (int i = 0; i < arrVal.size(); i++) {
				%> 
			<tr class="datagrid">
				<td  width="70%"><b>
					<%out.print("<a href='javascript:place(");
				out.print(i);
				out.print(")");
				out.print("' class='blackfont'>");
				out.print(arrValdesc.get(i));
				out.print("</a>");

				%> </b></td>
				<td  width="15%"><b> <%out.print("<a href='javascript:place(");
				out.print(i);
				out.print(")");
				out.print("' class='blackfont'>");
				out.print(arrValrefno.get(i));
				out.print("</a>");

				%> </b></td>
				
            <td width="15%">
              <%out.print(arrValrefdt.get(i));
				out.print("<br>");
			}
		%>
              <b>
					 </b></td>
			</tr>
		

		</table>
		</div>
		</td>
		</tr>
</table>
<br>
<lapschoice:combuttonnew btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
</form> 
</BODY>
</HTML>
