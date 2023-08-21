<%@include file="../share/directives.jsp"%>
<% 
String strappliedfor=Helper.correctNull((String)request.getParameter("appliedfor"));
if(strCategoryType.equals("CORPORATE"))
{
	strCategoryType ="CORP";
}

String strAppno=Helper.correctNull((String)request.getParameter("appno"));

String strBorrowerType =Helper.correctNull((String)request.getParameter("hidBorrowerType"));
String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
ArrayList arrRow=new ArrayList();
ArrayList arrCol=null;
arrRow=(ArrayList)hshValues.get("arrRow");
%>
<html>
<head>
<title>Proposal</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script language="Javascript1.2"><!-- // load htmlarea
_editor_url = "<%=ApplicationParams.getAppUrl()%>";                     // URL to htmlarea files
var win_ie_ver = parseFloat(navigator.appVersion.split("MSIE")[1]);
if (navigator.userAgent.indexOf('Mac')        >= 0) { win_ie_ver = 0; }
if (navigator.userAgent.indexOf('Windows CE') >= 0) { win_ie_ver = 0; }
if (navigator.userAgent.indexOf('Opera')      >= 0) { win_ie_ver = 0; }
if (win_ie_ver >= 5.5) {
  document.write('<scr' + 'ipt src="' +_editor_url+ 'editor.js"');
  document.write(' language="Javascript1.2"></scr' + 'ipt>');  
} else { document.write('<scr'+'ipt>function editor_generate() { return false; }</scr'+'ipt>'); }
// --></script>

<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";

function callCalender(fname)
 {
	 showCal("<%=ApplicationParams.getAppUrl()%>",fname);
 }

function enableButtons(bool1,bool2,bool3,bool4,bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmdclose.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool5;
	
}
 
function disableFields(val)
{
	
	
	for(var i=0;i<document.forms[0].length;i++)
	{
		  if(document.forms[0].elements[i].type=='select-one')
		  {
			document.forms[0].elements[i].disabled=val;
		  }	
		  if(document.forms[0].elements[i].type=='textarea')
		  {
			document.forms[0].elements[i].readOnly=val;
		  }	 
		  if(document.forms[0].elements[i].type=="checkbox")
		  {
			  document.forms[0].elements[i].disabled=val;
		  } 
	}
}

function doCancel()
{
	if (ConfirmMsg(102))
	{
	document.forms[0].hidBeanId.value="comproposal";
	document.forms[0].hidBeanGetMethod.value="getRBIGuidelines_restr";
	document.forms[0].action=appURL+"action/com_rbi_regulatory_restr.jsp";
	document.forms[0].submit();
	}
}
function doEdit()
{
	enableButtons(true,false,false,true,false);
	disableFields(false);
	if(document.forms[0].chkbox.length >1)
	{
		for(var i=0;i<document.forms[0].chkbox.length;i++)
		{
			if(document.forms[0].chkbox[i].checked)
			{
				document.forms[0].txt_guideliness[i].readOnly = true;
			}
			else
			{
				document.forms[0].txt_guideliness[i].readOnly = true;
			}
		}
	}
	else
	{
		if(document.forms[0].chkbox.checked)
		{
			document.forms[0].txt_guideliness.readOnly = false;
		}else{
			document.forms[0].txt_guideliness.readOnly = true;
		}
	}
}

function doSave()
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		  if(document.forms[0].elements[i].type=='select-one')
		  {
			if(document.forms[0].elements[i].value=='S')
			{
				alert("Select a value for Compliance");
				document.forms[0].elements[i].focus();
				return false;
			}
		  }	  
	}
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidAction.value="edit";	
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidBeanId.value="comproposal";
	document.forms[0].hidBeanMethod.value="updateRBIGuidelines_restr";
	document.forms[0].hidBeanGetMethod.value="getRBIGuidelines_restr";
	document.forms[0].hidSourceUrl.value="/action/com_rbi_regulatory_restr.jsp";
	document.forms[0].submit();
}

function doDelete()
	{
	if (ConfirmMsg(101))
		{
			document.forms[0].hidAction.value="delete";	
			document.forms[0].action=appURL+"controllerservlet";	
			document.forms[0].hidBeanId.value="comproposal";
			document.forms[0].hidBeanMethod.value="updateRBIGuidelines_restr";
			document.forms[0].hidBeanGetMethod.value="getRBIGuidelines_restr";
			document.forms[0].hidSourceUrl.value="/action/com_rbi_regulatory_restr.jsp";	
			document.forms[0].method="post";
			document.forms[0].submit();
		}
   }		


function dohlp()     
{
  var hlpvar = appURL+"phlp/corp_propobriefbg.htm";
  var title = "BorrowerDemographics";
  var prop = "scrollbars=yes,width=600,height=450";	
  prop = prop + ",left=50,top=150";
  window.open(hlpvar,title,prop);
}
function callOnload()
{
	selectValues();
	disableFields(true);
}  

function callApplicant()
{
	if(document.forms[0].cmdedit.disabled == true && document.forms[0].cmdsave.disabled != true)
	{
		ShowAlert(103);
	}
	else
	{
		document.forms[0].hidBeanId.value="commdocument";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/appdocumentsappl.jsp?hidBeanGetMethod=getData";
		document.forms[0].hidAppDoc.value="A";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
}
function callInternal()
{
	if(document.forms[0].cmdedit.disabled == true && document.forms[0].cmdsave.disabled != true)
	{
		ShowAlert(103);
	}
	else
	{
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/appdocumentsinter.jsp?hidBeanGetMethod=getData";
		document.forms[0].hidAppDoc.value="I";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
}
function setValues()
{
	if(document.forms[0].chkbox.length >1)
	{
		for(var i=0;i<document.forms[0].chkbox.length;i++)
		{
			if(document.forms[0].chkbox[i].checked)
			{
				document.forms[0].hidchkbox[i].value="1";
				document.forms[0].txt_guideliness[i].readOnly = false;
			}
			else
			{
				document.forms[0].hidchkbox[i].value="0";
				document.forms[0].txt_guideliness[i].readOnly = true;
			}
		}
	}
	else
	{
		if(document.forms[0].chkbox.checked)
		{
			document.forms[0].hidchkbox.value="1";
			document.forms[0].txt_guideliness.readOnly = false;
		}else{
			document.forms[0].hidchkbox.value="0";
			document.forms[0].txt_guideliness.readOnly = true;
		}
	}
}
function selectValues()
{
	if(document.forms[0].hidchkbox.length >1)
	{
		for(var i=0;i<document.forms[0].hidchkbox.length;i++)
		{
			if(document.forms[0].hidchkbox[i].value=="1")
			{
				document.forms[0].chkbox[i].checked=true;
			}
			else
			{
				document.forms[0].chkbox[i].checked=false;
			}
		}
	}
	else
	{
		if(document.forms[0].hidchkbox.value=="1")
		{
			document.forms[0].chkbox.checked=true;
		}else{
			document.forms[0].chkbox.checked=false;
		}
	}
}
function callGeneralCompliances()
{
	document.forms[0].strPageType.value="G";
	document.forms[0].hidBeanId.value="comproposal";
	document.forms[0].hidBeanGetMethod.value="getRBIGuidelines_restr";
	document.forms[0].action=appURL+"action/com_rbi_guidelines_restr.jsp";
	document.forms[0].submit();
}
</script>
</head>
<body onload="callOnload()">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems" url="">
<script language="JavaScript">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script>
</div></div>
<form name="frmpri" method = post class="normal">
<%if(strCategoryType.equalsIgnoreCase("RET")){ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
 <tr> 
      <td> 
        <jsp:include page="../share/Applurllinkper.jsp" flush="true"> 
        <jsp:param name="pageid" value="5" />
        </jsp:include>
      </td>
    </tr>
   </table>
<%}else{ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0"  class="outertable">
    <tr> 
      <td> 
       <jsp:include page="../com/proposallinks.jsp"
			flush="true">
			<jsp:param name="pageid" value="20" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include>
      </td>
    </tr>
  </table>
 <%} %>
 
 <%if(strSessionModuleType.equalsIgnoreCase("AGR")){ %>
 <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
 <tr> 
  <td class="page_flow">
  Home -&gt; Agriculture -&gt; Application -&gt; Take Over Norms -&gt; Take Over Norms
  </td>
 </tr>
 </table>
 <%}else if(strCategoryType.equalsIgnoreCase("RET")){ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
 <tr>
	<td class="page_flow">Home-&gt; Retail -&gt; Application -&gt; Document -&gt; RBI Guidelines</td>
 </tr>
</table>
<%}else{ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0"  class="outertable">
<tr>
  <td class="page_flow">Home-&gt; Corporate & SME -&gt;Application -&gt; Take Over Norms -&gt; Take Over Norms</td>
</tr>
</table>
<%}%> 
<span style="display:none"><lapschoice:borrowertype /></span> <lapschoice:application/>
<% if(strCategoryType.equalsIgnoreCase("RET")){ %>
 <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <td> 
        <table width="30%" border="0" cellspacing="1" cellpadding="3" class="outertable">
          <tr> 
            <td width="15%"  align="center" class="sub_tab_inactive"><b><a href="javascript:callApplicant()" >By Applicant</a></b>
            </td>
            <td align="center" width="15%" class="sub_tab_inactive"><b><a href="javascript:callInternal()">By Bank</a></b>
            </td>
            <td align="center" width="15%" class="sub_tab_active"><b>RBI Guidelines</b>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <% }else{%>
  <lapstab:Rbisubpage tabid="3" applevel='<%=Helper.correctNull((String)request.getParameter("applevel"))%>' applied='<%=strappliedfor%>' appno='<%=strAppno %>'/>
  <%} %>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <td> 
        <table width="30%" border="0" cellspacing="1" cellpadding="3" class="outertable">
          <tr> 
             <td width="15%"  align="center" class="sub_tab_inactive"><b><a href="javascript:callGeneralCompliances()" >General Principles</a></b>
            </td>
            <td align="center" width="15%" class="sub_tab_active"><b>Special Regulatory Norms</b>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
<table width="100%" border="0" cellspacing="0" cellpadding="0"  class="outertable">
  <tr> 
    <td> 
            <table width="100%" border="0" cellspacing="1" cellpadding="4"  class="outertable">
              <tr class="dataheader"> 
                <td align="center" width="5%"><b>&nbsp;</b></td>
                <td align="center" width="25%">Special Regulatory Treatment for Asset classification</td>
                <td align="center" width="35%"><b>Compliances</b></td>
              </tr>
              <%
				 arrRow=(ArrayList)hshValues.get("arrRow");
				 if(arrRow!=null && arrRow.size()>0)
				 {
				 	for(int i=0;i<arrRow.size();i++)	
				{
				 		arrCol=(ArrayList)arrRow.get(i);
					if(arrCol!=null && arrCol.size()>0)
					{
				 %>
				<tr> 
				  	<td  align="center"><input type="checkbox" name="chkbox"  onclick="setValues()" style="border-style:none">&nbsp; 
				<input type="hidden" name="hidslno" value="<%=Helper.correctNull((String)arrCol.get(0))%>">
				<input type="hidden" name="hidguidelines" value="<%=Helper.correctNull((String)arrCol.get(1))%>">
				<input type="hidden" name="hidchkbox" value="<%=Helper.correctNull((String)arrCol.get(3))%>"></td>
				<td> <%=Helper.correctNull((String)arrCol.get(1))%>
				</td>
				<td align="center"> 
				  <textarea name="txt_guideliness" id="txt_guideliness" cols="70" style="text-align:left" tabindex="12" rows="5" onKeyPress="textlimit(this,999)"  onKeyUp="textlimit(this,999)" ><%=Helper.correctNull((String)arrCol.get(4))%></textarea>
				  <input type="hidden" name="txt_compliances">
				  </td>
				</tr>
				<%}
				}
				}%>
            </table>
    </td>
  </tr>
</table>
  <br>
 <lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>

 <lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type=hidden name="ano" value="<%=strAppno%>">
<input type="hidden" name="cattype" value="<%=strCategoryType%>"> 
<input type="hidden" name="ssitype" value="<%=strSSIType%>"> 
 <input type="hidden" name="hidCommentPage" value="RBIGUIDELINES_RESTR">
 <input  type="hidden" name="hidAppDoc">
 <input type="hidden" name="strPageType" value="S">

</form>
</body>

</html>
