<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />  
<lapschoice:handleerror />
<%

String strActionflag=Helper.correctNull((String)request.getParameter("NPflag"));
if(strActionflag.equalsIgnoreCase(""))
{
	strActionflag=Helper.correctNull((String)hshValues.get("NPflag"));
}
String strcol=Helper.correctNull((String)request.getParameter("col"));
if(strcol.equalsIgnoreCase(""))
{
	strcol=Helper.correctNull((String)hshValues.get("col"));
}

String strdif=Helper.correctNull((String)request.getParameter("dif"));
if(strdif.equalsIgnoreCase(""))
{
	strdif=Helper.correctNull((String)hshValues.get("dif"));
}

%>

<html>
<head>
<title>National Portal  - SearchList</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/imageload.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
	
<script>	
var appURL="<%=ApplicationParams.getAppUrl()%>";
var varcol="<%=strcol%>";
var vardif="<%=strdif%>";

function doClose()
{
	window.close();
}	

function callSearch()
{
	if(document.forms[0].txt_ackname.value == "")
	{
		ShowAlert(121,'Search Criteria');
		document.forms[0].txt_ackname.focus();
		return;
	}

	var txtval=document.forms[0].txt_ackname.value;
	var txtlen=txtval.length;

	if(txtlen<=2) 
	{
		 alert("Enter atleast 3 characters");
	     document.forms[0].txt_ackname.focus();
	     return;
	}

	document.forms[0].hidBeanId.value="NationalPortal";
	document.forms[0].hidBeanGetMethod.value="getNPSearchList";
	document.forms[0].action=appURL+"action/NP_Searchlist.jsp";
	document.forms[0].submit();
}

function setValues(val1,val2,val3)
{
	if(vardif == 'app')
	{
		window.opener.document.forms[0].txt_vi.value=val1;
		window.opener.document.forms[0].txt_vi.readOnly=true;
		window.opener.document.forms[0].txt_cbs.value=val3;
		window.opener.document.forms[0].txt_cbs.readOnly=true;
		window.opener.document.forms[0].sel_New.value="N";
		window.opener.document.forms[0].sel_New.disabled=true;
	}else if(vardif == 'coapp1')
	{
		window.opener.document.forms[0].txt_coapp_vi1.value=val1;
		window.opener.document.forms[0].txt_coapp_vi1.readOnly=true;
		window.opener.document.forms[0].txt_coapp_cbs1.value=val3;
		window.opener.document.forms[0].txt_coapp_cbs1.readOnly=true;
		window.opener.document.forms[0].sel_New1.value="N";
		window.opener.document.forms[0].sel_New1.disabled=true;
	} else{
		window.opener.document.forms[0].txt_coapp_vi2.value=val1;
		window.opener.document.forms[0].txt_coapp_vi2.readOnly=true;
		window.opener.document.forms[0].txt_coapp_cbs2.value=val3;
		window.opener.document.forms[0].txt_coapp_cbs2.readOnly=true;
		window.opener.document.forms[0].sel_New2.value="N";
		window.opener.document.forms[0].sel_New2.disabled=true;
		
	}
	window.close();
}


</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/NationalPortal.css" type="text/css">
<link href="../../css/NationalPortal.css" rel="stylesheet" type="text/css">
</head>
<body>	
<form name="national_portal" method="post" class="normal">
	
 <table  width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1" align="center">
    <tr> 
        <td >
          <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
            <tr class="dataheader"> 
              <td colspan="2" align="center"><b>NP SearchList Check</b></td>
             </tr>
          </table>
          <br/>
          
          <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
	          <tr>
	          	<td width="25%" align="center">Search &nbsp;&nbsp;&nbsp;<input type="text" name="txt_ackname" size="25" maxlength="400" value="" onkeypress="allowAlphaNumeric();"></td>
	          	<td width="25%"><input type="button" name="cmdsearch" value="Search" class="buttonStyle" onClick="callSearch()"></td>
	          </tr>
          </table>
          
          <table width="100%" border="1" cellspacing="0" cellpadding="2" class="outertable border1">
             <tr class="dataheader">
            	  <td width="20%" align="center">LAPS ID</td>
             	  <td width="40%" align="center">Name</td>
	              <td width="40%" align="center">CBS ID</td>
	         </tr>
	
	         <tr>
	         	 
	         	 <td width="20%" align="center"><a href="#" onclick="javascript:setValues('<%=Helper.correctNull((String) hshValues.get("PERAPP_ID"))%>','<%=Helper.correctNull((String) hshValues.get("NAME"))%>','<%=Helper.correctNull((String) hshValues.get("PERAPP_CBSID"))%>');">
	         	 					<%=Helper.correctNull((String)hshValues.get("PERAPP_ID"))%></td>
	         	<td width="40%" align="center">&nbsp;<%=Helper.correctNull((String)hshValues.get("NAME"))%></td>
	             <td width="40%" align="center">&nbsp;<%=Helper.correctNull((String)hshValues.get("PERAPP_CBSID"))%></td>
             </tr>
           </table> 
          <br/>
          
       </td>
   </tr>
</table>	
<br/>
<br/>
<br/>
		
<table border="0" cellspacing="0" cellpadding="0" align="center">
	<tr>
		<td>
		<table border="0" cellspacing="0" cellpadding="1">
			<tr valign="middle">
				<td><input type="button" name="cmdclose" value="Close" class="buttonClose" onClick="doClose()"></td>
			</tr>
		</table>
		</td>
	</tr>
</table>		
	<input type="hidden" name="hidBeanGetMethod" value="">
	<input type="hidden" name="hidBeanId" value=""> 
	<input type="hidden" name="hidBeanMethod" value=""> 
	<input type="hidden" name="hidSourceUrl" value="">
	<input type="hidden" name="hidAction" value="">
<input type="hidden" name="NPflag" value="<%=strActionflag%>">
<input type="hidden" name="col" value="<%=strcol%>">
<input type="hidden" name="dif" value="<%=strdif%>">
</form>
</body>
</html>