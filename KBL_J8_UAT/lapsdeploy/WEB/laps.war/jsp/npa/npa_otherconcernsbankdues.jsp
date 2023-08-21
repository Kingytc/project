<%@include file="../share/directives.jsp"%>
<%ArrayList arrRow = new ArrayList();
			ArrayList arrCol = new ArrayList();
			String strbanktype = "";
			strbanktype = Helper.correctNull((String) request
					.getParameter("banktype"));
			if (strbanktype.equals("")) {
				strbanktype = Helper.correctNull((String) request
						.getParameter("hidbanktype"));
			}
%>

<html>
<head>
<title>ubi</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css" />
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>

var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";

function disableCommandButtons(valnew,valedit,valapply,valcancel,valdel,valclose)
{
	document.forms[0].cmdnew.disabled=valnew;
	document.forms[0].cmdedit.disabled=valedit;
	document.forms[0].cmddelete.disabled=valdel;
	document.forms[0].cmdsave.disabled=valapply;
	document.forms[0].cmdcancel.disabled=valcancel;
	document.forms[0].cmdclose.disabled=valclose;		 
}

function doNew()
{
	disableFields(false);
	document.forms[0].hidAction.value ="insert";
	disableCommandButtons(true,true,false,false,true,true);
}

function doEdit()
{ 	
	disableFields(false);
	document.forms[0].hidAction.value ="update";
	disableCommandButtons(true,true,false,false,false,true);
}

function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidAction.value ="";
		document.forms[0].hidSourceUrl.value="/action/npa_otherconcernsbankdues.jsp";
		document.forms[0].hidBeanId.value="npacommon";
		document.forms[0].hidBeanGetMethod.value="getsisterconcerndata";
		document.forms[0].hidBeanMethod.value="updatesisterconcernsdata";
		document.forms[0].action=appUrl +"controllerservlet";
		document.forms[0].submit(); 		
	}	
}

function doSave()
{
	if(document.forms[0].txt_concern.value=="")
	{
		ShowAlert('121','Name of Associate Concern');
		document.forms[0].txt_concern.focus();
		return;
	}
	if(document.forms[0].txt_partners.value=="")
	{
		ShowAlert('121','Name of Partners/Directors');
		document.forms[0].txt_partners.focus();
		return;
	}
	if(document.forms[0].txt_bankers.value=="")
	{
		ShowAlert('121','Bankers');
		document.forms[0].txt_bankers.focus();
		return;
	}
	if(document.forms[0].txt_limit.value=="" || document.forms[0].txt_limit.value=="0.00")
	{
		ShowAlert('121','Limit Sanctioned');
		document.forms[0].txt_limit.focus();
		return;
	}
	if(document.forms[0].status.value=="0")
	{
		ShowAlert('111','Status of A/c');
		document.forms[0].status.focus();
		return;
	}
	document.forms[0].hidSourceUrl.value="/action/npa_otherconcernsbankdues.jsp";
	document.forms[0].hidBeanId.value="npacommon";
	document.forms[0].hidBeanMethod.value="updatesisterconcernsdata";
	document.forms[0].hidBeanGetMethod.value="getsisterconcerndata";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
}


function callLink(page,bean,method)
	{
	if (document.forms[0].cmdsave.disabled)
			{
			document.forms[0].hidBeanGetMethod.value=method;
			document.forms[0].hidBeanId.value=bean;
			document.forms[0].action=appUrl+"action/"+page;
			document.forms[0].submit();
			}
			else
			{
				ShowAlert(103);
			}
	}

function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].hidSourceUrl.value="/action/npa_otherconcernsbankdues.jsp";
		document.forms[0].hidBeanId.value="npacommon";
		document.forms[0].hidBeanMethod.value="updatesisterconcernsdata";
		document.forms[0].hidBeanGetMethod.value="getsisterconcerndata";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].submit();
	}
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
		if(document.forms[0].elements[i].type=='radio')
	 	{
			document.forms[0].elements[i].disabled=!val;
		}		  
		 
	}
	
	
}
function onLoading()
{
	disableFields(true);
}
function doClose()
	{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appUrl+"action/npa_mainlinknav.jsp";
		document.forms[0].submit();
		
	}
}	
function callCalender(name)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal(appUrl,name);
		
	}
}


function selectValues(val1,val2,val3,val4,val5,val6)
{
	document.forms[0].hidsno.value=val1;
	document.forms[0].txt_concern.value=val2;
	document.forms[0].txt_partners.value=val3;
	document.forms[0].txt_bankers.value=val4;
	document.forms[0].txt_limit.value=val5;
	document.forms[0].status.value=val6;
	if(document.forms[0].btnenable.value.toUpperCase()=="Y")
	{
    	disableCommandButtons(true,false,true,false,false,true);
    }
}
</script>
</head>
<body onload="onLoading()">
<form name="prudential_appltmeans" method="post" class="normal">
<%if(Helper.correctNull((String)request.getParameter("hidmoduletype")).equalsIgnoreCase("PAWO")){ %>
<lapstab:pwourltag pageid="1"/>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top" class='page_flow'>Home -&gt; NPA-&gt;
		Prudential Write Off -&gt; Banking Details -&gt; Sister Concerns Banking</td>
	</tr>
</table>
<%}else if(Helper.correctNull((String)request.getParameter("hidmoduletype")).equalsIgnoreCase("STAT")){ %>
<lapstab:staturltag pageid="1"/>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top" class='page_flow'>Home -&gt; NPA-&gt;
		Status Note -&gt; General -&gt; Sister Concerns Banking</td>
	</tr>
</table>

<%} else if(Helper.correctNull((String)request.getParameter("hidmoduletype")).equalsIgnoreCase("SUIT")){ %>
<lapstab:suiturltag pageid="1"/>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top" class='page_flow'>Home -&gt; NPA-&gt;
		Filing Of Suit -&gt; General -&gt; Sister Concerns Banking</td>
	</tr>
</table>

<%} %>


  <table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
	<tr>
		<td><lapschoice:npaapplication />
		<INPUT type="hidden" name="npa_appno" value="<%=(String)request.getParameter("npa_appno")%>" />
		</td>
	</tr>
</table>

<lapstab:npabankingdetails module='<%=Helper.correctNull((String)request.getParameter("hidmoduletype"))%>' pageid="4" bankarrangement='<%=Helper.correctNull((String)request.getParameter("hidbankarrangement"))%>'/>
<table width="100%" border="0" cellspacing="0" cellpadding="3"
	class="outertable border1">


<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
	
	<tr>
		<td><b>Name of Associate Concern</b> <span class="mantatory">*&nbsp;</span></td>
		<td><input type="text" name="txt_concern" size="35" maxlength="30" tabindex="10"></td>
		<td><b>Name of Partner's/Director's</b> <span class="mantatory">*&nbsp;</span></td>
		<td><input type="text" name="txt_partners" size="35" maxlength="30" tabindex="10"></td>
	</tr>
	<tr>
		<td><b>Bankers</b> <span class="mantatory">*&nbsp;</span></td>
		<td><input type="text" name="txt_bankers" size="35" maxlength="30" tabindex="10"></td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td><b>Limit Sanctioned <%=ApplicationParams.getCurrency()%></b> <span class="mantatory">*&nbsp;</span></td>
		<td><lapschoice:CurrencyTag name="txt_limit" size="25" tabindex="12" maxlength="15" /></td>
		<td><b>Status of A/c.</b> <span class="mantatory">*&nbsp;</span></td>
		<td><select name="status" tabindex="13">
			<option value="0" selected="selected">----Select----</option>
			<option value="1">Regular</option>
			<option value="2">NPA</option>
		</select></td>
	</tr>
	
</table>
<br>
 <lapschoice:combuttonnew btnnames='New_Edit_Save_Cancel_Delete_Audit Trial' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
 <br> 
  <table width="100%" border="0" cellspacing="0" cellpadding="0"  align="center" class="outertable">
  <tr align="center"> 
    <td colspan="2"> 
      <div class="cellContainer"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0"  align="center" class="outertable">
          <tr> 
            <td valign="top"> 
              <div align="left"> 
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable border1">
                    <tr class="dataheader"> 
                      <td width="3%" >&nbsp;</td>
                      <td width="17%"  align="center"><b>Name 
                        of Associate Concern</b></td>
                      <td width="20%"  align="center"><b>Name 
                        of Partner's/Director's</b></td>
                      <td width="20%"  align="center"><b>Bankers</b></td>
                      <td  align="center"><b>Limit Sanctioned</b></td>
                      <td  align="center"><b>Status of A/c.</b></td>
                    </tr>
                    <%
                     
                  arrRow=(ArrayList)hshValues.get("arrRow");
					if(arrRow.size()>0 && arrRow!=null)
					{
						for(int i=0;i<arrRow.size();i++)
						{
						arrCol = (ArrayList)arrRow.get(i);
					%>
                    <tr> 
                      <td width="3%" align="center"> 
                        <input type="radio" 
													style="border:none" name="radiobutton" value="radiobutton"
													onClick="selectValues('<%=Helper.correctNull((String)arrCol.get(0))%>',
													'<%=Helper.correctNull((String)arrCol.get(1))%>',
													'<%=Helper.replaceForJavaScriptString((String)arrCol.get(2))%>',
													'<%=Helper.correctNull((String)arrCol.get(3))%>',
													'<%=Helper.correctNull((String)arrCol.get(4))%>',
													'<%=Helper.correctNull((String)arrCol.get(6))%>')">
                      </td>
                      <td width="17%">&nbsp;<%=Helper.correctNull((String)arrCol.get(1))%></td>
                      <td width="20%"><%=Helper.correctNull((String)arrCol.get(2))%></td>
                      <td width="20%">&nbsp;<%=Helper.correctNull((String)arrCol.get(3))%></td>
                      <td width="15%" align="right">&nbsp;<%=Helper.correctNull((String)arrCol.get(4))%></td>
                      <td width="16%" align="center">&nbsp;<%=Helper.correctNull((String) arrCol.get(6))
									.equals("1") ? "Regular" : "NPA"%></td>
                    </tr>
                    <%
					 }
					 }
				  	else
                	{
               %>
                    <tr class="datagrid"> 
                      <td align="center" colspan="10">No Data Found</td>
                    </tr>
                    <%
                	}
                %>
                  </table>
              </div>
            </td>
          </tr>
        </table>
      </div>
    </td>
  </tr>
  </table>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidsno" value="<%=Helper.correctNull((String)hshValues.get("PRE_SNO"))%>" /> 
<input type="hidden" name="hidbanktype" value="<%=strbanktype%>"/>  
<input type="hidden" name="hidclaimsettled" value="<%=Helper.correctNull((String)request.getParameter("hidclaimsettled"))%>" />
<input type="hidden" name="hidbankarrangement" value="<%=Helper.correctNull((String)request.getParameter("hidbankarrangement"))%>">
</form>
</body>
</html>
