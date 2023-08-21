<%@ page import="com.sai.laps.helper.*,java.util.*"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<%ArrayList vec = new ArrayList();
	ArrayList vecrec = new ArrayList();
	int vecsize = 0;
	int vecrecsize = 0;

	if (hshValues != null) {
		vec = (ArrayList) hshValues.get("vecData");
		vecrec = (ArrayList) hshValues.get("vecRec");
		//  out.println("hshvalues==="+hshValues);
	}
	if (vec != null) {
		vecsize = vec.size();
	}
%>
<html>
<head>
<title>Help</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
textarea {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
input {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
select {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
a:hover {  color: #FF3300}
-->
</style>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<script language="Javascript1.2"><!-- // load htmlarea
_editor_url = "<%=ApplicationParams.getAppUrl()%>";     // URL to htmlarea files                   
var win_ie_ver = parseFloat(navigator.appVersion.split("MSIE")[1]);
if (navigator.userAgent.indexOf('Mac')        >= 0) { win_ie_ver = 0; }
if (navigator.userAgent.indexOf('Windows CE') >= 0) { win_ie_ver = 0; }
if (navigator.userAgent.indexOf('Opera')      >= 0) { win_ie_ver = 0; }
if (win_ie_ver >= 5.5) {
 document.write('<scr' + 'ipt src="' +_editor_url+ 'js/share/editor.js"');
 document.write(' language="Javascript1.2"></scr' + 'ipt>');  
} else { document.write('<scr'+'ipt>function editor_generate() { return false; }</scr'+'ipt>'); }
// --></script>

<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/editor.js">
</script>
<script language="JavaScript" type="text/javascript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var path      ="<%=ApplicationParams.getAppUrl()%>";

function doDelete()
{
	if(ConfirmMsg(101))
	{
        document.forms[0].hidAction.value="Delete";
        document.forms[0].hidBeanId.value="lapshelp";
		document.forms[0].hidBeanMethod.value="updateData";
		document.forms[0].hidBeanGetMethod.value="getData";
		document.forms[0].hidSourceUrl.value="/action/Helpdesc.jsp";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
	}
}

function doSave()
{
    if(document.forms[0].txt_helpKey_no.value == "")
    {
       	alert("Enter Help Key No");
   		return;
    }
    else if(document.forms[0].txta_helpdesc.value == "")
    {
        alert("Enter Help Description");
       	return;        
    }   
	else 
    {
		document.forms[0].cmdapply.disabled = true;
    	document.forms[0].hidBeanId.value="lapshelp";
		document.forms[0].hidBeanMethod.value="updateData";
		document.forms[0].hidBeanGetMethod.value="getData";
		document.forms[0].hidSourceUrl.value="/action/Helpdesc.jsp";
        document.forms[0].action=appURL+"controllerservlet";
      	document.forms[0].submit();
      	 
      	
	}       
}

function callonLoad()
{
	disableFields(true);
	enableButtons(false,false,true,true,false,false);
	if (document.forms[0].hidAction.value == "Edit")
	{
		enableButtons(false,false,true,true,false,false);
	}	
}

function disableFields(val)
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
		  	document.forms[0].elements[i].readOnly=val;	
		  	if ((val == true) && (document.forms[0].hidAction.value == "New") && ((document.forms[0].elements[i].name == "txt_phone_no")||(document.forms[0].elements[i].name == "txt_mobile_no")))
		  	{
		  		document.forms[0].elements[i].readOnly = false;
		  	}
		  	else if ((val == true) && (document.forms[0].hidAction.value == "Edit") && ((document.forms[0].elements[i].name == "txt_phone_no")||(document.forms[0].elements[i].name == "txt_mobile_no")))
		  	{
		  		document.forms[0].elements[i].readOnly = false;
		  	}
		}
		else if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=val;		  
		}
		else if (document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].disabled=val;	
		}
	}
}
		
function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appURL+"action/setupnav.jsp";
		document.forms[0].submit();
	}
}

function doEdit() 
{
    	document.forms[0].hidAction.value="Edit";
  		enableButtons(true,true,false,false,true,true);
  		
}

function enableButtons(bool1,bool2,bool3,bool4,bool5,bool6)
{
    document.forms[0].cmdNew.disabled=bool1;
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdapply.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddel.disabled=bool5;
	document.forms[0].cmdclose.disabled=bool6;
}

function disableradio(val)
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if (document.forms[0].elements[i].type=="radio")
		{
			document.forms[0].elements[i].disabled=val;	
		}
		if(document.forms[0].elements[i].type=="text")
		{
		  	document.forms[0].elements[i].value="";		  
		}
	}
}

function doNew() 
{
    document.forms[0].hidAction.value="New";
   	enableButtons(true,true,false,false,true,true);
   	
   	disableFields(false);
}

function doCancel()
{
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
		document.forms[0].hidAction.value = "";	
		document.forms[0].hid_helpKey_no.value = "";	
		document.forms[0].hidBeanGetMethod.value="getData";
		document.forms[0].hidBeanId.value="lapshelp";
		document.forms[0].action=appURL+"action/Helpdesc.jsp";	
		document.forms[0].submit();
	}
}

function callHelp_sc()
{
	var action  =document.forms[0].hidAction.value;	
   	if(action == "Edit")
   	{
	  	var prop = "scrollbars=no,width=500,height=300,top=100,left=250";
		var url=appURL+"action/HelpList.jsp?hidBeanId=lapshelp&hidBeanGetMethod=getdataHelpList&pagefrom=helpdesc&strfrom=helpdesc";
		window.open(url,"",prop);
	}
}
</script>
<link rel="stylesheet" href="blackfont.css" type="text/css">
</head>
<body bgcolor="#EEEAE3" text="#000000" leftmargin="0" topmargin="0"
	marginwidth="0" marginheight="0" onload="callonLoad()">
<form name="colForm" method="post">
<table width="98%" border="0" cellspacing="0" cellpadding="5"
	align="center" class="outertable border1">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="5"
			class="outertable border1">
			<tr>
				<td valign="top">
			</tr>
			<tr>
				<td valign="top">

				<table border="0" cellspacing="0" cellpadding="0" width="100%">
					<tr>
						<td>
						<table border="0" cellspacing="0" cellpadding="3" width="100%">
							<tr>
								<td width="20%" nowrap>Help Key</td>
								<td width="80%"><input type="text" name="txt_helpKey_no"
									size="30"
									value="<%=Helper.correctNull((String)hshValues.get("helpkeyno"))%>"
									onKeyPress="notAllowSplChar()"> <input type="hidden"
									name="hid_helpKey_no" size="30"
									value="<%=Helper.correctNull((String)hshValues.get("helpkeyno"))%>">
								<span onClick="javascript:callHelp_sc()" style="cursor:hand"><font
									face="MS Sans Serif" size="1"><b>?</b></font></span>
								</td>
							</tr>
							<!--
                      <tr> 
                       <td width="20%" nowrap>Screen Name:</td>
                        <td width="80%">
                          <input type="text" name="txt_screen_name" size="30" value="<%//screen_name%>" onKeyPress="notAllowSplChar()" Readonly>
                          <span onClick="javascript:calluser()" style="cursor:hand"><font face="MS Sans Serif" size="1"><b><img src="<%=ApplicationParams.getAppUrl()%>img/search.gif"
								border=0 ></b></font></span> 
                          <input type="hidden" name="hid_screen_id" size="30" value="<%=Helper.correctNull((String)hshValues.get("screen_id"))%>">
                        </td>
                      </tr>
					  -->
							<tr>
								<td width="12%" align="left" valign="top">Help Description</td>
								<td><textarea name="txta_helpdesc" cols="150" rows="20"><%=Helper.correctNull((String) hshValues.get("helpdesc"))%></textarea>
								</td>
							</tr>
						</table>
						<br>
						<table width="12%" border="0" cellspacing="0" cellpadding="0"
							bordercolorlight="#8F8369" bordercolordark="#FFFFFB"
							class="outertablecolor" align="center">
							<tr>
								<td>
								<table width="43%" border="0" cellspacing="0" cellpadding="2">
									<tr valign="top">
										<td><input type="button" name="cmdNew" value="New"
											style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" class="buttonStyle" onClick="doNew()"></td>
										<td><input type="button" name="cmdedit" value="Edit"
											style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" class="buttonStyle" onClick="doEdit()"></td>
										<td><input type="button" name="cmdapply" value="Save"
											style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" class="buttonStyle" onClick="doSave()"></td>
										<td><input type="button" name="cmdcancel" value="Cancel"
											style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" class="buttonStyle" onClick="doCancel()"></td>
										<td><input type="button" name="cmddel" value="Delete"
											style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" class="buttonStyle" onClick="doDelete()"></td>
										<td><input type="button" name="cmdHelp" value="Help"
											style="background-color:#009966;cursor:help;;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"
											onClick="doHelp()"></td>
										<td align="center"><input type="button" name="cmdclose"
											value="Close" onClick="doClose()"
											style="background-color:#CC3300;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50">
										</td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						<br>
						</td>
					</tr>
					<tr>
						<td></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<input type="hidden" name="hid_orgcode" value=""> <input type="hidden"
	name="hidBeanMethod" value=""> <input type="hidden" name="hidBeanId"
	value="lapshelp"> <input type="hidden" name="hidSourceUrl"> <input
	type="hidden" name="hidAction"
	value="<%=Helper.correctNull((String)hshValues.get("Hid_action"))%>"> <input
	type="hidden" name="hidslno" value=""> <input type="hidden"
	name="hidBeanGetMethod" value="getData"> <script
	language="JavaScript1.2">
var config = new Object(); // create new config object

config.width = "90%";
config.height = "200px";
config.bodyStyle = 'background-color: white; font-family: "Verdana"; font-size: x-small;';
config.debug = 0;
	
	editor_generate('txta_helpdesc',config);
	
</script></form>
</body>
</html>
