<%@include file="../share/directives.jsp"%>
<%
String strbankarrangement=Helper.correctNull((String)hshValues.get("bankarrangement"));
String flag=Helper.correctNull((String)hshValues.get("flag"));
String comments=Helper.correctNull((String)hshValues.get("comments"));

HashMap hshAppdata=new HashMap();
hshAppdata=(HashMap)hshValues.get("hshAppdata");

String strAppno="";
String strcbsid="";
String appname="";
String strAppstatus="";
String appstatus="";
String strAppname="";
String readFlag="";
String strBorrowertype="";
String strmoduletype="";
String strBTNEnable="";
String npaorgscode="";
String strAppholder="";
String strOrgname="";

strAppno = Helper.correctNull((String) hshAppdata.get("npaappno"));
strcbsid = Helper.correctNull((String) hshAppdata.get("cbsid"));
appname = Helper.correctNull((String) hshAppdata.get("customername"));
strAppname=Helper.encodeAmpersand(appname);
appstatus = Helper.correctNull((String) hshAppdata.get("status"));
strBorrowertype = Helper.correctNull((String) hshAppdata.get("demoapptype"));
strmoduletype = Helper.correctNull((String) hshAppdata.get("moduletype"));
strBTNEnable = Helper.correctNull((String) hshAppdata.get("btnenable"));
readFlag= Helper.correctNull((String) hshAppdata.get("readflag"));
npaorgscode=Helper.correctNull((String) hshAppdata.get("createorgscode"));
strAppholder=Helper.correctNull((String) hshAppdata.get("holduserid"));
strOrgname=Helper.correctNull((String) hshAppdata.get("apporgname"));

if(appstatus.equalsIgnoreCase("OP")||appstatus.equalsIgnoreCase("PP")){
	strAppstatus="Open/Pending";
}
else if(appstatus.equalsIgnoreCase("PA")){
	strAppstatus="Processed/Approved";
}
else if(appstatus.equalsIgnoreCase("PR")){
	strAppstatus="Processed/Rejected";
}
else if(appstatus.equalsIgnoreCase("CA")){
	strAppstatus="Closed/Approved";
}
else if(appstatus.equalsIgnoreCase("CR")){
	strAppstatus="Closed/Rejected";
}%>
<html>
<head>
<title>ubi</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css"/>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>	
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var sta_bankarrangement="<%=strbankarrangement%>";
var flag="<%=flag%>";
var comments="<%=comments%>";
var varconstitution="<%=Helper.correctNull((String)hshValues.get("constitution"))%>";
var varOrgLevel="<%=strOrgLevel%>";

function disableCommandButtons(valedit,valsave,valcancel,valclose)
{
	document.forms[0].cmdedit.disabled=valedit;
	document.forms[0].cmdsave.disabled=valsave;
	document.forms[0].cmdcancel.disabled=valcancel;
	document.forms[0].cmdclose.disabled=valclose;		 
}

function onLoading()
{
	if(comments!="")
	{
		alert(comments);
		document.forms[0].action=appURL+"action/npa_mainlinknav.jsp";
		document.forms[0].submit();
	}
	if(document.forms[0].appno.value=="NEW")
	{
		disableFields(false);
		document.forms[0].hidAction.value ="insert";
		document.forms[0].hideditflag.value="Y";
		disableCommandButtons(true,false,true,false);
	}
	else
	{
		if(sta_bankarrangement!="")
		{
			document.forms[0].sel_bankarrangement.value=sta_bankarrangement;
		}
		else
		{
			document.forms[0].sel_bankarrangement.value="0";
		}
		if(varconstitution!="")
		{
			document.forms[0].sel_constitution.value=varconstitution;
		}
		disableFields(true);
		//disableCommandButtons(false,true,true,false);
	}
	
}

function doEdit()
{ 	
	disableFields(false);
	document.forms[0].hidAction.value ="insert";
	document.forms[0].hideditflag.value="Y";
	disableCommandButtons(true,false,false,true);	
}

function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidSourceUrl.value="/action/SarfaeriProposal_page1.jsp";
		document.forms[0].hidBeanId.value="npacommon";
		document.forms[0].hidBeanGetMethod.value="getGeneralinfoData";
		document.forms[0].hidBeanMethod.value="getGeneralinfoData";
		document.forms[0].action=appURL +"controllerservlet";
		document.forms[0].submit(); 		
	}	
}

function doSave()
{
	if(document.forms[0].sel_bankarrangement.value=="")
	{
		alert("Select the Banking Arrangement");
		document.forms[0].sel_bankarrangement.focus();
		return;
	}
	document.forms[0].hidSourceUrl.value="/action/SarfaeriProposal_page1.jsp";
	document.forms[0].hidBeanId.value="npacommon";
	document.forms[0].hidBeanGetMethod.value="updateGeneralinfoData";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}


function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}
		if(document.forms[0].elements[i].type=='text')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}
		if(document.forms[0].elements[i].type=='select-one')
	 	{
			document.forms[0].elements[i].disabled=val;
		}		  
		 
	}
	document.forms[0].txt_advancesince.readOnly=true;
	document.forms[0].txt_npasince.readOnly=true;
	document.forms[0].txt_activity.readOnly=true;
	document.forms[0].asset_class.readOnly=true;
	document.forms[0].sel_constitution.readOnly=true;
}	   
function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].hidSourceUrl.value="/action/SarfaeriProposal_page1.jsp";
		document.forms[0].hidBeanId.value="npacommon";
		document.forms[0].hidBeanMethod.value="updateGeneralinfoData";
		document.forms[0].hidBeanGetMethod.value="getGeneralinfoData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
	}
}
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appURL+"action/npa_mainlinknav.jsp";
		document.forms[0].submit();		
	}
}
function callLink(page,bean,method)
{
	if(document.forms[0].hideditflag.value=="N")
	{
		document.forms[0].hidSourceUrl.value=page;
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
		document.forms[0].action=appURL+"action/"+page;
		document.forms[0].submit();
	}
}

function callCalender(name)
{
	if(document.forms[0].hideditflag.value=="Y")
	{
		showCal(appURL,name);
	}
}

function clearAllFeilds()
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].value="";
		}
		if(document.forms[0].elements[i].type=='text')
	 	{
				document.forms[0].elements[i].value="";
		}
		if(document.forms[0].elements[i].type=='select-one')
	 	{
			document.forms[0].elements[i].value="0";
		}			  
	}
}
</script>
</head>
<body onload="onLoading()">
<form name="safaeri1" method="post" class="normal">
						<lapstab:sarfiurltag pageid="1"/>					
<span class="page_flow">Home -&gt; NPA-&gt; Sarfaesi Proposal -&gt; General -&gt; Banking Details</span> 
 <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable linebor">
	<tr class="applicationheader">
		<td nowrap><b>Application No :</b></td>
		<td nowrap><b><%=strAppno%></b></td>

		<td nowrap><b>Applicant Name:</b></td>
		<td nowrap><b><%=appname%></b></td>
		
		<td nowrap><b>CBS CUSTOMER ID:</b></td>
		<td nowrap><b><%=strcbsid%></b></td>

		<td nowrap><b>Status:</b></td>
		<td nowrap><b><%=strAppstatus%></b></td>
	</tr>
	<tr class="applicationheader">
		<td nowrap><b>Application Holder:</b></td>
		<td nowrap><b><%=strAppholder%></b></td>
		<td nowrap><b>Application Recd. from:</b></td>
		<td nowrap><b><%=strOrgname%></b></td>		
		<td colspan="4">&nbsp;
		<input type="hidden" name="appstatus" value="<%=appstatus%>">
		<input type="hidden" name="appname" value="<%=strAppname%>">
		<input type="hidden" name="cbsid" value="<%=strcbsid%>">
		<input type="hidden" name="npaorgcode" value="<%=npaorgscode%>">
		<input type="hidden" name="appno" value="<%=strAppno%>">
		<input type="hidden" name="readFlag" value="<%=readFlag%>">
		<input type="hidden" name="hidmoduletype" value="<%=strmoduletype%>">
		<input type="hidden" name="hidborrowertype" value="<%=strBorrowertype%>">
		<input type="hidden" name="btnenable" value="<%=strBTNEnable%>">
		<input type="hidden" name="appholder" value="<%=strAppholder%>">
		<input type="hidden" name="apporgname" value="<%=strOrgname%>">
		</td>		
	</tr>
</table>
<lapstab:npabankingdetails module='<%=strmoduletype%>' pageid="5" bankarrangement='<%=strbankarrangement%>'/>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
  <tr> 
    <td>
        <table width="98%" border="0" cellspacing="0" cellpadding="4" align="center" class="outertable">
          <tr> 
            <td colspan="2"> 
              <table width="82%" border="0" cellspacing="0" cellpadding="4" align="center" class="outertable linebor">
                <tr class="datagrid"> 
                  <td  colspan="2">ACTIVITY FOR WHICH FINANCED</td>
                  <td  colspan="2">&nbsp; 
                    <input type="text" name="txt_activity" size="25"
              						maxlength="20" value="<%=Helper.correctNull((String)hshValues.get("activity"))%>">
                  </td>
                </tr>
                <tr class="datagrid"> 
                  <td colspan="2">CONSTITUTION</td>
                  <td colspan="2"> &nbsp; 
				  <input type="text" name="sel_constitution" value="<%=Helper.correctNull((String)hshValues.get("constitution"))%>" >
                  </td>
                </tr>
                <tr class="datagrid"> 
                  <td colspan="2">BANKING ARRANGEMENT <span class="mantatory">*&nbsp;</span></td>
                  <td colspan="2"> &nbsp; 
                    <select name="sel_bankarrangement" tabindex="1">
                      <option value="0" selected>----Select----</option>
                      <option value="1">Sole</option>
                      <option value="2">Consortium</option>
                      <option value="3">Multiple Banking</option>
                    </select>
                  </td>
                </tr>
                <tr class="datagrid"> 
                  <td colspan="2">ADVANCE SINCE</td>
                  <td colspan="2">&nbsp; 
                    <input type="text" name="txt_advancesince" size="12" maxlength="10" 
				value="<%=Helper.correctNull((String)hshValues.get("advancesince"))%>" >
                  </td>
                </tr>
                <tr class="datagrid"> 
                  <td colspan="2">NPA SINCE</td>
                  <td colspan="2">&nbsp; 
                    <input type="text" name="txt_npasince" size="12"
				maxlength="10"  
				value="<%=Helper.correctNull((String)hshValues.get("npasince"))%>" 
				onBlur="checkDate(this);checkmaxdate(this,'<%=Helper.getCurrentDateTime()%>')">
                 <a href="#" onClick="callCalender('txt_npasince')"
				title="Click to view calender" border=0><img src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
				width="0" border="0" tabindex="23"></a>
                  </td>
                </tr>
                <tr class="datagrid"> 
                  <td colspan="2" >ASSET CLASSIFICATION </td>
                  <td colspan="2" >&nbsp; 
                    <input type="text" name="asset_class" value="<%=Helper.correctNull((String)hshValues.get("presentclassification"))%>" >
                  </td>
                </tr>
                <tr class="datagrid"> 
                  <td colspan="2" >PROVISION</td>
                  <td colspan="2" > &nbsp; 
                    <input type="text" name="txt_provision" size="15" onKeyPress="allowInteger()" tabindex="10"
              						maxlength="12" value="<%=Helper.correctNull((String)hshValues.get("provision"))%>">
                  </td>
                </tr>
              </table>
            </td>
          </tr>
        </table>
    </td>
  </tr>
</table>
<br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Audit Trial' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidbankarrangement" value="<%=strbankarrangement%>">
<input type="hidden" name="hidDataFlag" value="<%=Helper.correctNull((String)hshValues.get("recordFlag"))%>">
</form>
</body>
</html>
