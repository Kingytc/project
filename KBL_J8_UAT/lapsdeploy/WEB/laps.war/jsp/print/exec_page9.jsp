<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>Executive Summary</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css">
<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/editor.js"></script>
<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";

function disableCommandButtons(val)
{
	if(val=="load")
	{  
		disableFields(true);
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;		 
	}
	
	if(val=="edit")
	{	 
		 document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmddelete.disabled=false;
		 document.forms[0].cmdsave.disabled=false;
		 document.forms[0].cmdcancel.disabled=false;		 
		 document.forms[0].cmdclose.disabled=true;	 
		 disableFields(false);
	}
}

function callLink(page,bean,method)
{	
	 document.forms[0].hidSourceUrl.value=page;
	 document.forms[0].hidSourceUrl.value=page;
	 document.forms[0].hidBeanGetMethod.value=method;
	 document.forms[0].hidBeanId.value=bean;
	 document.forms[0].hidCategoryType.value="CORP"; 
 	 document.forms[0].action=appUrl+"action/"+page;
	 document.forms[0].submit();
}

function placevalues()
{
	disableFields(true);
	var varfacility="<%=Helper.correctNull((String)hshValues.get("facility"))%>";
	var varsancterms="<%=Helper.correctNull((String)hshValues.get("sancterms"))%>";
	if(varfacility!="")
	{
		document.forms[0].selfacility.value=varfacility
	}
	else
	{
		document.forms[0].selfacility.value="s";
	}
	if(varsancterms!="")
	{
		document.forms[0].selsancterms.value=varsancterms;
	}
	else
	{
		document.forms[0].selsancterms.value="s";
	}
}


function disableFields(val)

	{
	
	for(var i=0;i<document.forms[0].elements.length;i++)
		{
			if(document.forms[0].elements[i].type=="text")
			{
			  document.forms[0].elements[i].readOnly=val;		  
			}
			if(document.forms[0].elements[i].type=="textarea")
			{
			  document.forms[0].elements[i].readOnly=val;		  
			}
			/*if(document.forms[0].elements[i].type=="select-one")
			{
			  document.forms[0].elements[i].disabled=val;		  
			}*/
		}
	
		
	}
function doEdit()
{
	if(document.forms[0].selfacility.value=="s")
	{
		alert('Select Facility');
		return;
	}
	if(document.forms[0].selsancterms.value=="s")
	{
		alert('Select Terms of Sanction');
		return;
	}
	disableFields(false);
	document.forms[0].hidAction.value ="insert";
	disableCommandButtons("edit");
}

function getsanctionterms()
{
	if(document.forms[0].selfacility.value=="s")
	{
		alert('Select Facility');
		return;
	}
	if(document.forms[0].selsancterms.value=="s")
	{
		alert('Select Terms of Sanction');
		return;
	}
	document.forms[0].hidBeanId.value="executive"
	document.forms[0].hidBeanGetMethod.value="getData9";
	document.forms[0].action=appUrl+"action/exec_page9.jsp";
	document.forms[0].submit();
}

function doCancel()
{
	if(ConfirmMsg(102))
	 {
		document.forms[0].hidBeanId.value="executive"
		document.forms[0].hidBeanGetMethod.value="getData9";
		//document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].action=appUrl+"action/exec_page9.jsp";
		document.forms[0].submit();
	 }
	
}
function doClose()
{	
	if( ConfirmMsg(100) )
	{
		document.forms[0].method="post";
		document.forms[0].action=appUrl+"action/corppge.jsp";
		document.forms[0].submit();
	}	
}
function doSave()
{
		document.forms[0].cmdsave.disabled = true;
		document.forms[0].hidBeanId.value="executive";
		document.forms[0].hidBeanMethod.value="updateData9";
		document.forms[0].hidBeanGetMethod.value="getData9";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/exec_page9.jsp";
		document.forms[0].submit();
		
}

function doDelete()
{
	if(ConfirmMsg(101))
	 {
		document.forms[0].hidAction.value="delete"
		document.forms[0].hidBeanId.value="executive"
		document.forms[0].hidBeanMethod.value="updateData9";
		document.forms[0].hidBeanGetMethod.value="getData9";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/exec_page9.jsp";
		document.forms[0].submit();
	 }
}

function PrintReport()
{		
	var appno="<%=request.getParameter("appno")%>";
	var CompanyName="<%=request.getParameter("appname")%>";	
	var purl ="<%=ApplicationParams.getAppUrl()%>action/executiveprint.jsp?hidBeanGetMethod=getExecutivePrint&hidBeanId=executive&appno="+appno+"&CompanyName="+CompanyName;
	var prop = 'scrollbars=yes,menubar=yes,status=yes,width=750,height=520';	
	var xpos = (screen.width - 750) / 2;
	var ypos = (screen.height - 520) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,'title',prop);
}
function ExecutiveReport()
{
	callLAPSPDF('ExecutiveSummary.pdf');
}
</script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
</head>
<body  onload="placevalues()">
<form name="formsum" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top"><jsp:include page="../com/proposallinks.jsp"
			flush="true">
			<jsp:param name="pageid" value="10" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />

		</jsp:include></td>
	</tr>
	<tr>
		<td class="page_flow">
			Home -&gt; Corporate &amp; SME -&gt; Proposal -&gt; Executive Summary -&gt; Page 7
		</td>
	</tr>
</table>
<span style="display:none;"><lapschoice:borrowertype /></span><lapschoice:application />

<table width="100%" border="0" cellspacing="0" cellpadding="3"
	align="center" class="outertable">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td valign="top" colspan="2">
				
              <table width="100%" border="1" cellspacing="0" cellpadding="3"
					class="outertable">
                <tr class="dataheader"> 
                  <td colspan="2"><b>Summary of changes in sanction terms ,if 
                    any</b></td>
                </tr>
                <tr class="dataheader"> 
                  <td align="center" width="48%"><b>Facility</b></td>
                  <td align="center" width="52%"><b>Terms of sanction</b></td>
                </tr>
                <tr class="datagrid"> 
                  <td width="48%"> 
                    <select name="selfacility" tabindex="1"
							onchange="getsanctionterms()">
                      <option value="s" selected="selected">&lt;-- Select --&gt;</option>
                      <option value="0">&lt;-- General --&gt;</option>
                      <lapschoice:comtermscond /> 
                    </select>
                  </td>
                  <td width="52%"> 
                    <select name="selsancterms" tabindex="2"
							onchange="getsanctionterms()">
                      <option value="s" selected="selected">&lt;---Select---&gt;</option>
                      <option value="roi">Rate of Interest(fixed or floating)</option>
                      <option value="mar">Margin(%)</option>
                      <option value="lclg">Commission for L/c,LG,DPGL(%)</option>
                      <option value="remit">Commission on remittances and other 
                      services(please specify)</option>
                      <option value="pc">Processing charges</option>
                      <option value="ps">Primary security (give details)</option>
                      <option value="cs">Collateral security (give details)</option>
                      <option value="pcg">Personal /Corporate guarantees(Name/means/TNW)</option>
                      <option value="othr">Other Matters</option>
                    </select>
                  </td>
                </tr>
                <tr class="datagrid"> 
                  <td colspan="2">
                    <table width="100%" border="0" class="outertable">
                      <tr> 
                        <td align="center" width="35%">Stipulated earlier</td>
                        <td align="center" width="30%">Present</td>
                        <td align="center" width="35%">Now recommended</td>
                      </tr>
                      <tr> 
                        <td align="center">
							<textarea name="txt_earlierstipulated" cols="50" rows="3" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" tabindex="3"><%=Helper.correctNull((String) hshValues	.get("earlierstipulation"))%></textarea>
						</td>
                        <td width="30%"  align="center"><textarea name="txt_present" cols="50" rows="3" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" tabindex="4"><%=Helper.correctNull((String) hshValues.get("present"))%></textarea>
						</td>
                        <td width="35%"  align="center"><textarea name="txt_recommdnow" cols="50" rows="3" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" tabindex="4"><%=Helper.correctNull((String) hshValues.get("nowrecommended"))%></textarea>
						</td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr> 
                  <td width="48%"> </td>
                  <td width="52%"> </td>
                </tr>
              </table>
				</td>
			</tr>

		</table>
		</td>
	</tr>
</table>


	<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
	<tr>
		<td width="33%"><b><a
			href="javascript:callLink('exec_page6.jsp','executive','getData6')"
			>&lt;&lt; &nbsp; Previous</a></b></td>
		<td width="33%" align="center">&nbsp;<b> <jsp:include
			page="../com/link1.jsp" flush="true"/>
	 </b></td>
		
      <td width="33%" align="right"><b>Pg.7/8 &nbsp;<a href="javascript:callLink('exec_page11.jsp','executive','getData11')" > 
        Next &gt;&gt; </a></b></td>
	</tr>
	<tr>
	</tr>
	<tr>
		<td colspan="3">&nbsp;
			
		</td>
	</tr>
	
	<tr>
		<td colspan="3">&nbsp;
			
		</td>
	</tr>
	<tr>
		<td colspan="3">
		<div align="center"><input type="Button"
			value="Executive Summary Print" name="Print" onClick="PrintReport()"
			style='font-weight:bold;background-color:#CC3300;color:white;font-size=10;font-family:mssansserif;width:150'>
		</div>
		</td>
		
	</tr>
</table>
   <lapschoice:hiddentag pageid='<%=PageId%>'/>
	</form>
</body>
</html>
