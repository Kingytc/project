<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
   if(objValues instanceof java.util.HashMap)
  {
	  hshValues=(java.util.HashMap)objValues;
  }
 %>
<html>
<head>
<title>Organisation and Employees</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varRecordFlag="<%=Helper.correctNull((String)hshValues.get("recordflag"))%>";

function placeValues()
{
	disableFields(true);
}
function disableFields(val)
	{
		for(var i=0;i<document.forms[0].elements.length;i++)
		{
			if(document.forms[0].elements[i].type=="textarea")
			{
			  document.forms[0].elements[i].readOnly=val;		  
			}
			else if(document.forms[0].elements[i].type=="text")
			{
			  document.forms[0].elements[i].readOnly=val;		  
			}
		}
	}
function enableButtons(bool1,bool2,bool3,bool4,bool5)
{
   	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;

}
function doEdit()
{
	disableFields(false);
	enableButtons(true,false,false,false,true)

}
function doDelete()
{
if(varRecordFlag=="Y")
		{
	if(ConfirmMsg(101))
	 {
		document.forms[0].hidAction.value="delete"
		document.forms[0].hidBeanId.value="combanking"
		document.forms[0].hidBeanMethod.value="updateEmp";
		document.forms[0].hidBeanGetMethod.value="getEmpData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/comemp.jsp";
		document.forms[0].submit();
	 }
	 }
	 else{
	 ShowAlert(158);
	 }
}

function doSave()
{
		document.forms[0].cmdsave.disabled = true;
		document.forms[0].hidAction.value="update"
		document.forms[0].hidBeanId.value="combanking"
		document.forms[0].hidBeanMethod.value="updateEmp";
		document.forms[0].hidBeanGetMethod.value="getEmpData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/comemp.jsp";
		document.forms[0].submit();

		
}

function doCancel()
{
	if(ConfirmMsg(102))
	 {
		document.forms[0].hidBeanId.value="combanking"
		document.forms[0].hidBeanGetMethod.value="getEmpData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/comemp.jsp";
		document.forms[0].submit();
	 }
}


function doClose()
{
	if( ConfirmMsg(100) )
	{
		document.forms[0].action=appURL+"action/"+"comsearch.jsp";
		document.forms[0].submit();
	}
	
}

function callLink(page,bean,method)
{

	if (document.forms[0].cmdsave.disabled)
	{
	 document.forms[0].hidBeanGetMethod.value=method;
	 document.forms[0].hidBeanId.value=bean;
	 document.forms[0].action=appURL+"action/"+page;
	 document.forms[0].submit();
	}
	else
	{
		ShowAlert(103);
	}
}

 function callApplicantTab(page)
  { 
   	
	if (document.forms[0].cmdsave.disabled)
	{
	  if(page=="company")
	  { 
		  document.forms[0].hidBeanGetMethod.value="getData";
		  document.forms[0].action=appURL+"action/comcompany.jsp";
	  }
	  if(page=="proposal")
	  {
		  document.forms[0].hidBeanGetMethod.value="getProposal";
		  document.forms[0].action=appURL+"action/comproposal.jsp";
	  }
	    	  if(page=="facilities")
	  {
		  document.forms[0].hidBeanMethod.value="getFacilityData";
		  document.forms[0].hidBeanId.value="facilities";
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/facilities.jsp";
	  }
	 		  document.forms[0].submit();
	}
	else
	{
		ShowAlert(103);
	}
	
	
  }

var strvalue="corp_organdemp_mgetemp.htm";
function doHelp()     
{
  var hlpvar = appURL+"phlp/corp_organdemp_mgetemp.htm";
  var title = "MgtAndEmp";
  var prop = "scrollbars=yes,width=600,height=450";	
  prop = prop + ",left=50,top=150";
  window.open(hlpvar,title,prop);
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
</head>
<body onload="placeValues()">
<form method="post" name="fltintrate" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td valign="top" colSpan="5"><jsp:include page="../share/applurllinkscom.jsp" flush="true"> 
        <jsp:param name="pageid" value="5" />
        <jsp:param name="cattype" value="<%=strCategoryType%>" />
        <jsp:param name="ssitype" value="<%=strSSIType%>" />
        </jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable border1">
	<tr>
		<td class="page_flow">Home -&gt; 
        Corporate &amp; SME -&gt; Application -&gt; Org. &amp; Emp.-&gt; Mgmt. &amp; Employees</td>
    </tr>
  </table>
  <span style="display:none"><lapschoice:borrowertype /></span><lapschoice:application/> 
 <table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<table border="0" cellspacing="1" cellpadding="3" class="outertable" width="60%">
			<tr align="center">
				<td width="15%" class="sub_tab_inactive"><b><a href="#" onclick="javascript:callLink('comorg.jsp','combanking','getOrgData')">Organisation</b></td>
				<td width="15%" class="sub_tab_active"><b>
					Mgmt. &amp; Employees</b></td>
				<td width="15%" class="sub_tab_inactive"><b><a
					href="#" onclick="javascript:callLink('commis.jsp','combanking','getMisData')">
					Other Management Details</a></b></td>
				<td width="15%" class="sub_tab_inactive"><b> <a
					href="#" onclick="javascript:callLink('comotherinfo.jsp','combanking','getInfoData')">Other Info</a></b></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
  <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
    <tr> 
      <td valign="top"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable border1">
          <tr> 
            <td valign="top"> 
              <table width="100%" border="0" cellspacing="1" cellpadding="0" class="outertable">
                <tr> 
                  <td align="center">&nbsp;</td>
                  <td align="center" class="dataheader">Succession plan for the top management</td>
                  <td align="center" class="dataheader">Strategic initiatives taken by Managment to meet new challanges etc 
                    </td>
                </tr>
                <tr> 
                  <td align="center">&nbsp;</td>
                  <td align="center"> 
                    <textarea name="succession" cols="70" rows="10" onKeyPress="textlimit(this,199)" onKeyUp="textlimit(this,199)"><%=Helper.correctNull((String)hshValues.get("Succession plan"))%></textarea>
                    </td>
                  <td align="center"> 
                    <textarea name="strategic" cols="70" rows="10" onKeyPress="textlimit(this,199)" onKeyUp="textlimit(this,199)"><%=Helper.correctNull((String)hshValues.get("Strategic initiatives"))%></textarea>
                    </td>
                </tr>
                <tr> 
                  <td colspan="4">&nbsp;</td>
                </tr>
                <tr> 
                  <td colspan="4">Number of 
                    employees</td>
                </tr>
                <tr> 
                  <td colspan="4"> 
                    <table width="60%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                      <tr> 
                        <td width="13%">Skilled</td>
                        <td width="36%"> 
                          <input type="text" name="skilled" value="<%=Helper.correctNull((String)hshValues.get("Skilled"))%>" onKeyPress="allowInteger(this)" maxlength="12">
                        </td>
                        <td width="14%">Unskilled</td>
                        <td width="37%"> 
                          <input type="text" name="unskilled" value="<%=Helper.correctNull((String)hshValues.get("Unskilled"))%>" onKeyPress="allowInteger(this)" maxlength="12">
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr> 
                  <td align="center" valign="top">&nbsp;</td>
                  <td align="center" valign="top">&nbsp;</td>
                  <td align="center" valign="top">&nbsp;</td>
                </tr>
                <tr> 
                  <td align="center" valign="top">&nbsp;</td>
                  <td align="center" valign="top" colspan="2"> 
                    <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
                      <tr align="center" class="dataheader"> 
                        <td width="32%"><b>Employees Welfare Programmes</b></td>
                        <td width="35%"><b>Any strike in the past, if so, the period of strike and 
                          the present stand of the management</b></td>
                        <td width="33%"><b>Comments on the Labour turnover during the preceeding 2-3 years</b></td>
                      </tr>
                      <tr align="center"> 
                        <td width="32%"> 
                          <textarea name="welfare" cols="40"  rows="4" onKeyPress="textlimit(this,199)" onKeyUp="textlimit(this,199)"><%=Helper.correctNull((String)hshValues.get("Employee welfare"))%></textarea>
                          </td>
                        <td width="35%"> 
                          <textarea name="strike" cols="40" rows="4" onKeyPress="textlimit(this,199)" onKeyUp="textlimit(this,199)"><%=Helper.correctNull((String)hshValues.get("Any strike"))%></textarea>
                          </td>
                        <td width="33%"> 
                          <textarea name="turnover" cols="40" rows="4" onKeyPress="textlimit(this,199)" onKeyUp="textlimit(this,199)"><%=Helper.correctNull((String)hshValues.get("Comments"))%></textarea>
                          </td>
                      </tr>
                    </table>
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

<lapschoice:combuttonnew btnnames="Edit_Save_Delete_Cancel" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<lapschoice:hiddentag pageid='<%=PageId%>'/> 
</form>
</body>
</html>
