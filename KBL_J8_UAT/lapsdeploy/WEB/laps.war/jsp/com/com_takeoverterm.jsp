<%@include file="../share/directives.jsp"%>
<% 
if(strCategoryType.equals("CORPORATE"))
{
	strCategoryType ="CORP";
}

String bid=Helper.correctNull((String)hshValues.get("borrowerid"));
String strAppID="";
if (bid.trim().equals(""))
{
 strAppID=request.getParameter("comapp_id");
}
else
{
 strAppID=Helper.correctNull((String)hshValues.get("borrowerid"));
}

String strAppno=request.getParameter("appno");

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

<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
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
	document.forms[0].cmdcomments.disabled=false;
	
}
function call_page(url,method)
{
	
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].method="post";

	if(url=="com_takeoverterm.jsp")
	{
		document.forms[0].hidBeanId.value="comproposal";
	}
	else if(url=="com_takeoverworking.jsp")
	{
		document.forms[0].hidBeanId.value="comproposal";
	}
	
	else
	{
		document.forms[0].hidBeanId.value="comproposal";
	}
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+url+"?type=1";
	document.forms[0].submit();
	
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
	}
}

function doCancel()
{
	if (ConfirmMsg(102))
	{
	document.forms[0].hidBeanId.value="comproposal";
	document.forms[0].hidBeanGetMethod.value="gettakeoverterm";
	document.forms[0].action=appURL+"action/com_takeoverterm.jsp";
	document.forms[0].submit();
	}
}
function doEdit()
{
	enableButtons(true,false,false,true,false);
	disableFields(false);
	var i=0;
	<% 
	if(arrRow!=null && arrRow.size()>0)
	{
	%>
	var vararrsize="<%=arrRow.size()%>";	
	<%}	
	%>
	if(parseInt(vararrsize)==0)
	{
		if(document.forms[0].sel_reasons.value=="NO" || document.forms[0].sel_reasons.value=="S")
		{
			document.forms[0].txt_reasons.readOnly = true;
		}
		else
		{
			document.forms[0].txt_reasons.readOnly = false;
		}
	}
	else if(parseInt(vararrsize)> 0)
	{
		if(parseInt(vararrsize)==1)
		{
			if(document.forms[0].sel_reasons.value=="NO" || document.forms[0].sel_reasons.value=="S")
			{
				document.forms[0].txt_reasons.readOnly = true;
			}
			else
			{
				document.forms[0].txt_reasons.readOnly = false;
			}
		}
		else
		{
			for(i=0;i<parseInt(vararrsize);i++)
			{
				if(document.forms[0].sel_reasons[i].value=="NO" || document.forms[0].sel_reasons[i].value=="S")
				{
					document.forms[0].txt_reasons[i].readOnly = true;
				}
				else
				{
					document.forms[0].txt_reasons[i].readOnly = false;
				}
			}
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
		  if(document.forms[0].elements[i].type=='textarea')
		  {
			if(document.forms[0].elements[i].value=='')
			{
				alert("Enter Comments for Compliance");
				document.forms[0].elements[i].focus();
				return false;
			}
		  }	 	  
	}
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidAction.value="edit";	
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidBeanId.value="comproposal";
	document.forms[0].hidBeanMethod.value="updatetakeoverterm";
	document.forms[0].hidBeanGetMethod.value="gettakeoverterm";
	document.forms[0].hidSourceUrl.value="/action/com_takeoverterm.jsp";
	document.forms[0].submit();
}

function doDelete()
	{
	if (ConfirmMsg(101))
		{
			document.forms[0].hidAction.value="delete";	
			document.forms[0].action=appURL+"controllerservlet";	
			document.forms[0].hidBeanId.value="comproposal";
			document.forms[0].hidBeanMethod.value="updatetakeoverterm";
			document.forms[0].hidBeanGetMethod.value="gettakeoverterm";
			document.forms[0].hidSourceUrl.value="/action/com_takeoverterm.jsp";	
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
	disableFields(true);
	document.forms[0].cmdcomments.disabled=false;
}  
function doClose()
{
	var cattype=document.forms[0].cattype.value;
	var id=document.forms[0].id.value;
 	if(cattype=="OPS")
    {
    	if(ConfirmMsg(100))
	 	{ 
			document.forms[0].action=appURL+"action/agrborrowersearch.jsp";
			document.forms[0].submit();
	 	}
	}
	if((cattype=="SSI")||(cattype=="CORP")||(cattype=="SME"))
    {
        if(ConfirmMsg(100))
		{
			document.forms[0].action=appURL+"action/corppge.jsp";
			document.forms[0].submit();
	 	}
	}
}

function calSelection(selname,i,len)
{
	if(parseInt(len)==1)
	{
		if(selname.value =='YES')
		{
				document.forms[0].txt_reasons.value='';
				document.forms[0].txt_reasons.readOnly=false;
				document.forms[0].txt_reasons.focus();
		}
		else if(selname.value =='NO')
		{
			document.forms[0].txt_reasons.value='';
			document.forms[0].txt_reasons.readOnly=false;
			document.forms[0].txt_reasons.focus();
		}
		else
		{
			document.forms[0].txt_reasons.value='';
			document.forms[0].txt_reasons.readOnly=false;
		}	
	}
	else
	{
		if(selname.value =='YES')
		{
			document.forms[0].txt_reasons[i].value='';
			document.forms[0].txt_reasons[i].readOnly=false;
			document.forms[0].txt_reasons[i].focus();
		}
		else if(selname.value =='NO')
		{
			document.forms[0].txt_reasons[i].value='';
			document.forms[0].txt_reasons[i].readOnly=false;
			document.forms[0].txt_reasons[i].focus();
		}
		else
		{
			document.forms[0].txt_reasons[i].value='';
			document.forms[0].txt_reasons[i].readOnly=false;
		}	
	}
}
function doComments()
{
	var btnenable=document.forms[0].btnenable.value;
	var hidAppNo = document.forms[0].ano.value;
	var hidCommentPage = document.forms[0].hidCommentPage.value;
	var prop = "scrollbars=yes,width=750,height=550,top=25,left=180";
	var url=appURL+"action/comments.jsp?hidBeanId=perfinancial&hidBeanGetMethod=getComments&hidAppNo="+hidAppNo+"&hidCommentPage="+hidCommentPage+"&appstatus="+appstatus+"&btnenable="+btnenable;
	window.open(url,"Comments",prop);
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
<%if(strCategoryType.equalsIgnoreCase("OPS")){ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
 <tr> 
      <td> 
        <jsp:include page="../share/applurllinkscom.jsp" flush="true"> 
        <jsp:param name="pageid" value="17" />
        <jsp:param name="cattype" value="<%=strCategoryType%>" />
        <jsp:param name="ssitype" value="<%=strSSIType%>" />
        </jsp:include>
      </td>
    </tr>
   </table>
<%}else{ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0"  class="outertable">
    <tr> 
      <td> 
        <jsp:include page="../share/applurllinkscom.jsp" flush="true"> 
        <jsp:param name="pageid" value="41" />
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
 <%}else if(strCategoryType.equalsIgnoreCase("OPS")){ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
 <tr>
	<td class="page_flow">Home-&gt; Tertiary -&gt; Application -&gt; Take Over Norms -&gt; Take Over Norms</td>
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
<lapstab:TakeoverTab tabid="2" istakeover="1"/>
  <table width="100%" border="0" cellspacing="0" cellpadding="5" align="center"  class="outertable">
    <tr> 
      <td valign="top"> 
        <div align="left"> </div>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%"  class="outertable">
          <tr> 
            <td valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="5" height="100%"  class="outertable">
                <tr> 
                  <td valign="top"> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="0"  class="outertable">
                      <tr> 
                        <td> 
                          <table width="100%" border="0" cellspacing="0" cellpadding="0"   class="outertable border1">
                            <tr> 
                              <td> 
                                <table width="100%" border="0" cellspacing="1" cellpadding="4"  class="outertable">
                                  <tr class="dataheader"> 
                                    <td align="center" colspan="5"><b>NORMS</b></td>
                                    <td align="center" width="13%">&nbsp;</td>
                                    <td align="center" width="35%"><b>COMPLIANCE</b></td>
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
                                    	<td colspan="5"  align="left">&nbsp; <%=Helper.correctNull((String)arrCol.get(1))%>
                                    	<input type="hidden" name="hidslno" value="<%=Helper.correctNull((String)arrCol.get(0))%>">
										<input type="hidden" name="hidnorms" value="<%=Helper.correctNull((String)arrCol.get(1))%>"></td>
                                    <td width="13%"  align="center"> 
                                      <select name="sel_reasons" onChange="calSelection(this,'<%=i%>','<%=arrRow.size()%>')">
                                        <%String strselreason=Helper.correctNull((String)arrCol.get(2));
	                                      	if(strselreason.equalsIgnoreCase("S")){
	                                      	%>
                                        <option value="S" selected>---Select---</option>
                                        <%}else{ %>
                                        <option value="S">---Select---</option>
                                        <%} if(strselreason.equalsIgnoreCase("YES")){%>
                                        <option value="YES" selected>YES</option>
                                        <%}else { %>
                                        <option value="YES">YES</option>
                                        <%}  if(strselreason.equalsIgnoreCase("NO")){%>
                                        <option value="NO" selected>NO</option>
                                        <%}else { %>
                                        <option value="NO">NO</option>
                                        <%} %>
                                      </select>
                                    </td>
                                    <td width="35%"  align="center"> 
                                      <textarea name="txt_reasons" id="txt_reasons" cols="50" style="text-align:left" tabindex="12" rows="2" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" ><%=Helper.correctNull((String)arrCol.get(3))%></textarea>
                                    </td>
                                  </tr>
								   <%}
								  }
								  }%>
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
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <br>
 <lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Comments_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>

 <lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type=hidden name="comapp_id" value="<%=strAppID%>">
<input type=hidden name="ano" value="<%=strAppno%>">
<input type="hidden" name="cattype" value="<%=strCategoryType%>"> 
<input type="hidden" name="ssitype" value="<%=strSSIType%>"> 
 <input type="hidden" name="id" value="<%=strBorrowerType%>">
 <input type="hidden" name="hidCommentPage" value="Takeover">

</form>
</body>

</html>
