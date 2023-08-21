<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="com.sai.laps.helper.*,java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<lapschoice:handleerror />
<%	
	ArrayList arrRow	=	new ArrayList();
	ArrayList arrCol	=	new ArrayList();
	arrRow	=	(ArrayList)hshValues.get("arrRow");
	int iarrLength	=0;
	if(arrRow!=null && arrRow.size()>0)
	{
		iarrLength= arrRow.size();
	}	
	String AppStatus = Helper.correctNull((String)hshValues.get("AppStatus"));
String strPerappEmployment=Helper.correctNull(Helper.correctInt((String)hshValues.get("strPerappEmployment")));
String strbrnchead=Helper.correctNull(Helper.correctInt((String)hshValues.get("strbrnchead")));

session.setAttribute("hidRefId",Helper.correctNull((String)request.getParameter("hidRefId")));    

String strRefid= Helper.correctNull((String) session.getAttribute("strapprefid"));
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/imageload.js"></script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script type="text/javascript">
var appURL="<%=ApplicationParams.getAppUrl()%>"; 
var AppStatus = "<%=AppStatus%>";
var varPerappEmployment="<%=strPerappEmployment%>";
var varbrnchead ="<%=strbrnchead%>";

function callFunction(pagename)
{
	document.forms[0].action = appURL+"action/"+pagename;
	document.forms[0].submit();
}

function callClose()
{
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/mainnav.jsp";
	document.forms[0].submit();
}

function callsearch(i)
{
	var hidPercustid=document.forms[0].hidPercustid.value;
	var txtSearch=document.forms[0].txtcbsid[i].value;
	//alert("hidPercustid====="+hidPercustid);
	//alert("txtSearch======"+txtSearch); 
	if(txtSearch==hidPercustid)
	{
		if(hidPercustid!="" && txtSearch!="")
		{
		alert("Customer CBS Id Alredy Exists,Kinldy use Another Customer CBS Id");
		return;
	}
		}
	
	
	if(document.forms[0].txtcbsid[i].value =="")
	{
		alert("Please Enter the CBS-ID to Search");
		document.all.ifrm.src=appURL+"action/ifrmnpsearchcbs.jsp"
		return;
	}
	else
	{
		
		for(var k=0;k<document.forms[0].btnsearch.length;k++)
		{
			if(k == i)
			{
				document.forms[0].btnsearch[k].disabled=false;
			}		
			else
			{
				document.forms[0].btnsearch[k].disabled=true;
			document.forms[0].cmdcust.disabled=false;
			
			}	
		}
		
		document.all.ifrm.src=appURL+"action/ifrmnpsearchcbs.jsp?hidBeanGetMethod=getCBSidforNSDL&hidBeanId=nsdl&txtsearch="
		+document.forms[0].txtcbsid[i].value+"&gridrowno="+i+"&apptype="+document.forms[0].apptype[i].value;
	}	
}
function callMap(j,name,cus_applicanttype,refid,cus_sno,varemploy)
{
	var flag = document.forms[0].hidmapflag.value;
	flag="1";
	document.forms[0].refid.value = refid;
	document.forms[0].cus_sno.value = cus_sno;
	document.forms[0].cus_applicanttype.value = cus_applicanttype;
	var varPerappEmployment=document.forms[0].hidPerappEmployment.value;
	
	if(flag =="1")
	{
		if(ConfirmMsg(179))
		{
			document.forms[0].hidBeanGetMethod.value="updateMapCBSidforNationalPortal";
			document.forms[0].hidBeanId.value="PSB59";
			
			//document.forms[0].hidBeanMethod.value="updateMapCBSidforNationalPortal";
			//document.forms[0].hidBeanGetMethod.value="PSB59getcbsidrecord";
			//document.forms[0].hidSourceUrl.value="/action/psb59CBSIDfetch.jsp";
			document.forms[0].action=appURL+"action/psb59CBSIDfetch.jsp";	
			//document.forms[0].action=appURL+"controllerservlet"
			document.forms[0].submit(); 


			//parent.frames.window.opener.doLoadPage();
			//parent.frames.window.opener.callcbsid(refid); 

		}
	}	
}



function callOnLoad(){

	

//	parent.frames.window.opener.doLoadPage();
	//parent.frames.window.opener.callcbsid(refid); 
}
</script>
</head>
<body onload="callOnLoad();callsearch()">
<form name="appform" method="post" action=""> 

<table width="90%" cellspacing="1" cellpadding="3" align="center" class="outertable" >
	<tr  class="dataheader">
					<td align="center" width="15%">&nbsp; S.No</td>
					<td align="center" width="15%">&nbsp; Name</td>
					<td align="center" width="15%">&nbsp; Type</td> 
					<td align="center" width="15%">&nbsp; CBS ID</td>
					<% if(strbrnchead.equalsIgnoreCase("Y")) {%> 
					<td align="center" width="15%">&nbsp; CBS ID D-Link</td> 
					<%}else{ %>
					<td align="center" width="15%">&nbsp; Search</td> 
					<td align="center" width="15%">&nbsp; Map</td> 
					<%} %>
					
	</tr>
	<%if(iarrLength>0)
	{
		
			for(int i=0;i<iarrLength;i++)
			{
				arrCol	=	(ArrayList) arrRow.get(i);
	//out.print("arrColarrColarrColarrCol"+arrCol);
		%>
	<tr  class="datagrid">
			<td align="center" width="15%">	<%=i+1 %>	</td>
			<td align="center" width="15%"> <%=Helper.correctNull((String)arrCol.get(0)) %></td>
			<td align="center" width="15%"> <%=Helper.correctNull((String)arrCol.get(1)) %></td>	
			<input type="hidden" name="apptype" value="<%=Helper.correctNull((String)arrCol.get(1)) %>">
			
			
			<%if( Helper.correctNull((String)arrCol.get(5)).equals("")){ %>
			<td align="center" width="15%"> <input type= "text" name="txtcbsid"  value="<%=Helper.correctNull((String)arrCol.get(4)) %>"/></td>
			<%}else { %>
			<td align="center" width="15%"> <input type= "hidden" name="txtcbsid"/> <%=Helper.correctNull((String)arrCol.get(4)) %></td>
			<%} %>
		
			<!-- <td align="center" width="15%"> <input type= "hidden" name="txtcbsid"/> </td> -->
<% if(strbrnchead.equalsIgnoreCase("Y")) {%> 
			<td align="center" width="15%"> <input type= "button"    name = "btndlink" value="DLink"  onClick="callDLink('<%=i%>', 
			'<%=Helper.correctNull((String)arrCol.get(0))%>' ,'<%=Helper.correctNull((String)arrCol.get(1))%>' 
			)"
			style="background-color:#CC3300;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:60"/></td>	
	<%}else{ %>
					<td align="center" width="15%"> <input type= "button" name = "btnsearch" value="Search"   onClick="callsearch('<%=i%>')"
					style="background-color:#CC3300;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:60"/></td>	
				
					<!--  <td align="center" width="15%"> <input type= "button" name = "btnsearch"  value="Search"  onClick="callsearch('<%=i%>')"
					style="background-color:#CC3300;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:60"/></td>	-->
					
					
					
					
					
					<td align="center" width="15%"> <input type= "button" name = "btnmap" disabled= "disabled" value="Map"  onClick="callMap('<%=i%>', 
					'<%=Helper.correctNull((String)arrCol.get(0))%>' ,'<%=Helper.correctNull((String)arrCol.get(1))%>' ,
					'<%=Helper.correctNull((String)arrCol.get(2))%>' ,'<%=Helper.correctNull((String)arrCol.get(3))%>')"
					style="background-color:#CC3300;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:60"/></td>	
				
					<!-- <td align="center" width="15%"> <input type= "button" disabled= "disabled"   name = "btnmap" value="Map"  onClick="callMap('<%=i%>', 
					'<%=Helper.correctNull((String)arrCol.get(0))%>' ,'<%=Helper.correctNull((String)arrCol.get(1))%>' 
					)"
					style="background-color:#CC3300;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:60"/></td> -->	
					
			<%} }%>
								 
	</tr>
			 
		<%	}
	
	else
	{
		%>
		<tr  class="dataGridColor">
			<td colspan="3" align="center">&nbsp; -- No Data Found --  </td>
		</tr>
	<%} %>
</table> 
<br>
<br>
<br>
<table border="0" cellspacing="0" cellpadding="0"  align="center">
      <tr valign="middle"> 
       <td>  
        
            <input type="button" name="cmdclose" value="Close" 
            style="background-color:#CC3300;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" onClick="callClose()"> 
        </td>
        
         <td>  
        
            <input type="button" name="cmdcust" value="Customer Profile" 
            style="background-color:#CC3300;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:100 ;" 
            onClick="callFunction('psb59mastersearchper.jsp')"> 
        </td>
        
          
      </tr>
</table>
<table width="90%" cellspacing="0" cellpadding="3" align="center" class="outertable">
	<tr>
		  <td align="center">
				<iframe height="200" width="600" id="ifrm" frameborder="0" style="border:0"></iframe>
		  </td>          		
	</tr>
	<tr>&nbsp;</tr>
</table>
    <input type="hidden" name="hidBeanId" value="">
    <input type="hidden" name="hidBeanGetMethod" value="">
    <input type="hidden" name="hidUserId" value="">
    <input TYPE="hidden" name="hidmapflag">
<input TYPE="hidden" name="hidbranchhead" value="<%= strbrnchead%>">
<input TYPE="hidden" name="hidmapbtn">
<input TYPE="hidden" name="hidAppid">
<input TYPE="hidden" name="hidcbsID">
<input TYPE="hidden" name="refid">
<input TYPE="hidden" name="cus_sno">
<input TYPE="hidden" name="cus_applicanttype">


<input TYPE="hidden" name="hidCompleteCBSFlag">
<input TYPE="hidden" name="hidBeanMethod">
<input TYPE="hidden" name="hidSourceUrl">
<input TYPE="hidden" name="hidPerappEmployment" value="<%=Helper.correctNull(Helper.correctInt((String)hshValues.get("strPerappEmployment")))%>">
<input TYPE="hidden" name="hidPercustid" value="<%=Helper.correctNull(Helper.correctInt((String)hshValues.get("strSearchText")))%>">
</form>
</body>
</html>

