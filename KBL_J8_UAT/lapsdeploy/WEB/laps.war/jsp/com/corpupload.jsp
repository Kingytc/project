<%
/**
@author Sureshkumar Ganapathy 22-NOV-2008
@FileName  corpupload.jsp
@purpose  uploading the data from MS-Acess table to oracle table for corporate 
**/
%>
<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>Corporate Offline Upload</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var check_String = "<%=Helper.correctNull((String)hshValues.get("checkFlagAccess"))%>";
var varAppno = "<%=Helper.correctNull((String)hshValues.get("strAppnoAccess"))%>";
function callClose()
{
	if(ConfirmMsg('100'))
	{
		document.forms[0].action=appURL+"action/mainnav.jsp";
		document.forms[0].submit();
	}
}
function callUpload()
{
	
	
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/corpupload.jsp?&hidFileType=MULTIPART&&hidUploadType=MSACCESS&txtsheetname="+document.forms[0].fileUpload.value;
	document.forms[0].submit();
}

function loading()
{
	if("<%=strIsSaral%>" == "Y")
	{
		document.all.saral.style.visibility="visible";
		document.all.saral1.style.visibility="visible";
		
	}
	else
	{	
		document.all.saral.style.visibility="hidden";
		document.all.saral1.style.visibility="hidden";
	}
	if(check_String!="")
	{
		alert("Application no "+varAppno+" Successfully Created");
	}
}

function checkUpload(obj1)
{
	if("<%=strIsSaral%>" == "Y")
	{
		if(document.forms[0].comapp_orgname.value=="")
		{
			alert('Select Application Recd. From');
			return false;
		}
	}
	//if(document.forms[0].txt_appinwardno.value=="")
	//{
	//	alert('Select Application Inward Number');
	//	return false;
	//}
	else if(obj1.fileUpload.value!="")
	{
		var a = obj1.fileUpload.value.lastIndexOf(".mdb");
		if(a==-1)
		{
			alert("Please Upload .mdb file");
			return false;					
		}
	}
	else
	{
		alert("Please Upload ms access database");
		return false;
	}
	return true;	
}

function showAckSearch()
{		
	var varQryString = "<%=ApplicationParams.getAppUrl()%>action/searchAppinwradno.jsp?Category=c&proposal=C";
	var title = "Acknowledgement";
	var prop = "scrollbars=yes,width=650,height=400,menubar=yes";	
	var xpos = (screen.width - 350) / 2;
	var ypos = (screen.height - 120) / 2;
	prop = prop + ",left=50,top=50";
	window.open(varQryString,title,prop);
}

function upload()
{
	if( checkUpload(form1))
	{
		var varcusttype="<%=request.getParameter("custtype")%>";
		var varinwardno=document.forms[0].txt_appinwardno.value;
		var comapp_scode = document.forms[0].comapp_scode.value;
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/corpupload.jsp?&hidFileType=MULTIPART&hidUploadType=MSACCESS&hidBeanId=corpupload&hidBeanGetMethod=getAppno&custtype="+varcusttype+"&inwardno="+varinwardno+"&comapp_scode="+comapp_scode;
		document.forms[0].submit();
	}
}
function showOrgSearch1(val1,val2,val3)
{
	if("<%=strIsSaral%>" == "Y")
	{
		showOrgSearch(val1,val2,val3);
	}
}
</SCRIPT>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
</head>
<body onLoad="loading()">
<form  name="form1" method="post" enctype="multipart/form-data" class="normal">
<p align="center">
	<font size=2 >
		<strong>Upload Offline Corporate File Here!</strong>
	</font>
</p>
<table width="80%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
	<tr>
		<td valign="top" >   
			<table  width="100%" cellpadding="0" cellspacing="0" border="0" class="outertable">
				<tr>
					<td>
      					<table width="40%" border="0" cellspacing="0" cellpadding="3"
						class="outertable" align="center">
							<tr>
								 <td nowrap id="saral">Application 
                                Recd. From <b class="mantatory">*</b> 
                                </td>
                              <td colspan="3" id="saral1"> 
                                <INPUT type="hidden" name="comapp_scode"
									 style="width:200">
                                <input type="text"
									name="comapp_orgname" size="25"
									value="">
                                <b><a href="#" onClick="showOrgSearch1('<%=ApplicationParams.getAppUrl()%>','comapp_scode','comapp_orgname')" style="cursor:hand"
									tabindex="15"><img
									src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
									border="0"></a></b>
								</td>
							</tr>
							<tr>
								<td>Application Inward No:<b class="mantatory">*</b></td>
                              <td colspan="3"> 
                                <input type="text"
											name="txt_appinwardno" size="20" maxlength="15" tabindex=""
											onkeypress="allowInteger(this)" readonly="readonly">
                                <b><span onClick="showAckSearch()"
											style="cursor:hand"><img
											src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
											border="0"></span></b></td>
							</tr>
							<tr>
								<td align="center" colspan="4"> File : <input type="file" name="fileUpload" ></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td align="center">
						<input type="button" value="Upload" class="buttonStyle" onClick="upload()">
						<input type="button" value="Close" class="buttonClose"  onClick="callClose()">
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
   
<input type="hidden" name="hidFileType" value="MULTIPART">			
<input type="hidden" name="hidBeanGetMethod" value="getAppno">
<input type="hidden" name="hidBeanId" value="corpupload">
<input type="hidden" name="hidUploadType" value="MSACCESS">
<input type="hidden" name="custtype" value="<%=request.getParameter("custtype")%>">
</form>
<br>
<center>
  <strong class="mantatory"><%=Helper.correctNull((String)hshValues.get("status")) %></strong> 
</center>
</body>
</html>
