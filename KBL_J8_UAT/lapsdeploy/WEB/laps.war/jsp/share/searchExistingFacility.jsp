<%@include file="../share/directives.jsp"%>

<%			
int rowcount = Integer.parseInt(Helper.correctInt((String)request.getParameter("rowcount")));
int rowIndex = Integer.parseInt(Helper.correctInt((String)request.getParameter("rowIndex")));
String temp = Helper.correctNull((String) request.getParameter("temp1"));

String btnenable=Helper.correctNull((String) request.getParameter("btnenable"));
if(btnenable.equals(""))
	btnenable=Helper.correctNull((String) hshValues.get("btnenable"));

String strexisting_facility=Helper.correctNull((String) hshValues.get("tempdata"));
String strsecextval=Helper.correctNull((String) hshValues.get("existsecurity"));

String hid_existingBowid = Helper.correctNull((String) request.getParameter("hid_existingBowid"));

 %>
<html>
<head>
<title>Existing Facility Search</title>
<SCRIPT LANGUAGE="JavaScript">
var appURL="<%=ApplicationParams.getAppUrl()%>";
var rowcount="<%=rowcount%>";
var rowIndex="<%=rowIndex%>";
var vartemp="<%=temp%>";
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var hid_existingBowid="<%=hid_existingBowid%>";
var strold_id="<%=Helper.correctNull((String) hshValues.get("strold_id"))%>";
var exstfac_attachFlag="<%=Helper.correctNull((String) hshValues.get("exstfac_attachFlag"))%>";

function callSearch()
{
	var txtval=document.forms[0].sec_name.value;
	var txtlen=txtval.length;	
	if(txtval=="")
	{
		 alert("Enter Value to Search");
	     document.forms[0].sec_name.focus();
	     return;
	}
	else if(txtlen<=2)
	 {
		alert("Enter atleast 3 charcters");
		document.forms[0].sec_name.focus();
		return;
	 }

	document.forms[0].hidBeanGetMethod.value="getExistingFacDet";
	document.forms[0].hidBeanId.value="mastapplicant";
	document.forms[0].action=appURL+"action/searchExistingFacility.jsp?rowIndex=1&rowcount=1&temp1=1234&hid_existingBowid="+hid_existingBowid;
	document.forms[0].submit();
}

function doClose()
{
 	window.close();
} 
function onRadioClick()
{
	document.forms[0].sec_name.readOnly=false;			
	document.forms[0].sec_name.value="";
	document.forms[0].sec_name.focus();
}

function setValues(val1,val2,val3,val4)
{
	if(rowcount==1)
	{
		window.opener.document.forms[0].txt_secur_id.value = val1;
		window.opener.document.forms[0].txt_secur_appname.value = val2;
		window.opener.document.forms[0].txt_secur_desp.value = val3;
		window.opener.document.forms[0].txt_secur_val.value = val4;
	}else
	{
		var temp1=vartemp.split("@");
		 var valuerlen=temp1.length;
			 for(var i=0;i<valuerlen;i++)
		     {  
				if(temp1 [i]==val1)
				{
					alert("Selected Applicant is already attached for this Application");
					return;
				}
		     }
		window.opener.document.forms[0].txt_secur_id[<%=(rowIndex-1)%>].value = val1;
		window.opener.document.forms[0].txt_secur_appname[<%=(rowIndex-1)%>].value = val2;
		window.opener.document.forms[0].txt_secur_desp[<%=(rowIndex-1)%>].value = val3;
		window.opener.document.forms[0].txt_secur_val[<%=(rowIndex-1)%>].value = val4;
	}
	window.close();
}

function doAttach()
{
	var strexisting_facility=document.forms[0].strexisting_facility.value;
	var strsecextval=document.forms[0].strsecextval.value;

	if(exstfac_attachFlag=="N")
	{
		alert("Already Borrower's Exisiting facilities are attached.");
		return;
	}
	window.opener.document.forms[0].hid_addexsistingfac.value = strexisting_facility;
	window.opener.document.forms[0].hid_addexsistingsec.value = strsecextval;
	window.opener.document.forms[0].hid_existingBowid.value = strold_id;

	window.opener.document.forms[0].txt_applt_title.disabled=false;
	window.opener.document.forms[0].txt_constitution.disabled=false;
	window.opener.document.forms[0].txt_constitution.disabled=false;
	window.opener.disablefields(false);
	
	window.opener.document.forms[0].hidAction.value="insert";
	window.opener.document.forms[0].hidBeanId.value="perDeviation";
	window.opener.document.forms[0].hidBeanMethod.value="updatepermissionGistData";
	window.opener.document.forms[0].hidBeanGetMethod.value="getPermissionGistData";
	window.opener.document.forms[0].hidSourceUrl.value="/action/permission_gist.jsp";
	window.opener.document.forms[0].action=appUrl+"controllerservlet";
	window.opener.document.forms[0].target="mainFrame";
	window.opener.document.forms[0].submit();	
	
	window.close();
}

function onLoad()
{
	if(document.forms[0].btnenable.value=="N" || document.forms[0].btnenable.value=="")
	{
		document.forms[0].cmdattach.disabled=true;
	}
	else
	{
		document.forms[0].cmdattach.disabled=false;
	}
}
</SCRIPT>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onLoad()">
<form name="appform" method="post" class="normal">
<table width="98%" border="0" cellpadding="5" cellspacing="0" class="outertable" align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="5" align="center" class="outertable">
			<tr class="datagrid">
				<td width="16%" nowrap="nowrap"> 
					<input type="radio" name="category" value="LAPSID" style="border-style:none" onClick="onRadioClick()">LAPS ID</td>
				<td width="16%" nowrap="nowrap"> 
					<input type="radio" name="category" value="CBSID" style="border-style:none" onClick="onRadioClick()">CBS Applicant ID</td>
	            <td width="16%">
					<input type="text" name="sec_name" ></td>
				<td>&nbsp;&nbsp;&nbsp;
					<input type="button" name="Submit" value="Search" class="buttonStyle" onClick="callSearch();"></td>
			</tr>
		</table>
		<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable linebor">
			<tr class="dataheader">
				<td width="5%" ><b>S.No</b></td>
				<td width="20%"><b>Proposal Number</b></td>
				<td width="20%"><b>Facility S.no</b></td>
				<td width="35%"><b>Borrower Name</b></td>
				<td width="20%"><b>Sanctioned Date</b></td>
			</tr>
		</table>
	  	<table width="100%" border="0" cellspacing="1" cellpadding="2" class="outertable linebor">
	  	<%	
						ArrayList arrRow=new ArrayList();
	  					int e=0;
						if(hshValues!=null)
						{
							arrRow = (ArrayList)hshValues.get("arryRow1");
						}		
						ArrayList arrCol=new ArrayList();
						if (arrRow != null && arrRow.size() > 0)							
						{
						for (int i = 0; i < arrRow.size(); i++) 
						{
							arrCol = (ArrayList) arrRow.get(i);
							e=e+1;
						%>
						
					 <tr class="datagrid">
							<td width="5%"><%=e%></td>
							<td width="20%"><%= Helper.correctNull((String)arrCol.get(0))%></td>
							<td width="20%"><%= Helper.correctNull((String)arrCol.get(1))%></td>
							<td width="35%"><%= Helper.correctNull((String)arrCol.get(2))%></td>
							<td width="20%"><%= Helper.correctNull((String)arrCol.get(3))%></td>
					</tr>
					<% 	 }
                       } else { %>
                      <tr class="datagrid">
							<td colspan="5" align="center"> No Data Found</td>
						</tr>
                    <%} %>
                                   
			</table>
		</td>
	</tr>
	<tr>
		<td>
			<table width="10%" border="0" cellspacing="0" cellpadding="3" align="center">
				<tr valign="top">
					<td width="20%"><lapschoice:combuttonnew  btnnames='Attach' btnenable='<%=btnenable%>' /></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<lapschoice:hiddentag /> 
<input type="hidden" name="btnenable" value="<%=btnenable%>">
<input type="hidden" name="strexisting_facility" value="<%=strexisting_facility%>">
<input type="hidden" name="strsecextval" value="<%=strsecextval%>">


<br>
</form>
</body>
</html>
