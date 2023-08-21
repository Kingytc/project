<%@include file="../share/directives.jsp"%>
<%
String stryear=Helper.correctNull((String)request.getParameter("mon_year"));
if(!stryear.equalsIgnoreCase(""))
{
	stryear=Helper.correctNull((String)hshValues.get("mon_year"));
}
String strmonth=Helper.correctNull((String)request.getParameter("mon_month"));

if(!strmonth.equalsIgnoreCase(""))
{
	strmonth=Helper.correctNull((String)hshValues.get("mon_month"));
}
	ArrayList vecRow = new ArrayList();
	ArrayList vecCol = new ArrayList();
	vecRow =(ArrayList)hshValues.get("vecRow");
%>
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var appURL="<%=ApplicationParams.getAppUrl()%>";
var strAction="<%=request.getParameter("hidEditMode")%>";
var varorglevel="<%=strOrgLevel%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";

function selectValues(val1,val2,val3,val4,val5,val6,val7,val8,val9,val11,val12,i,size)
{
	document.forms[0].strsno.value=val1;
    document.forms[0].cbsid.value =val2 ;
	document.forms[0].txt_accno.value= val3;
    document.forms[0].txt_nature.value=val8;
    document.forms[0].txt_amount.value=val9;
	if(document.forms[0].btnenable.value=="Y" && varorglevel=='A')
	{
		disableCommandButtons(true,false,false,true,false,false);	
	}
}
	
function callOnload()
{
	if(document.forms[0].btnenable.value=="Y" && varorglevel=='A')
	{
		disableCommandButtons(false,true,true,true,true,false);
	}
	else
	{
		disableCommandButtons(true,true,true,true,true,false);
	}
	disableFields(true);
}

function doNew()
{
	disableFields(false);
	disableCommandButtons(true,true,true,false,false,true);	
	document.forms[0].hidAction.value ="new";   
}
function doSave()
{
	document.forms[0].hidBeanMethod.value="updatehedgeddetails";
	document.forms[0].hidBeanGetMethod.value="gethedgeddetails";
	document.forms[0].hidBeanId.value="mmrcommon";
	document.forms[0].hidSourceUrl.value="/action/mon_hedgeddetails.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}	  
		if(document.forms[0].elements[i].type=='radio')
		{
			document.forms[0].elements[i].disabled=(!val);
		}	
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].readOnly=val;
		} 
	}
}
  
function callCalender(name)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal(appURL,name);
	}
}

function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appURL+"action/mainnav.jsp";
		document.forms[0].submit();
	}
}
function doCancel()
{
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
		document.forms[0].hidBeanGetMethod.value="gethedgeddetails";
		document.forms[0].hidBeanId.value="mmrcommon";
		document.forms[0].action=appURL+"action/mon_hedgeddetails.jsp";	
		document.forms[0].submit();
	}
}
function doEdit()
{
	document.forms[0].hidAction.value ="update";
	disableFields(false);
	disableCommandButtons(true,true,true,false,false,true);
}
function doDelete()
{
	var varconfirm=ConfirmMsg('101');
	if(varconfirm)
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].hidBeanMethod.value="updatehedgeddetails";
	    document.forms[0].hidBeanGetMethod.value="gethedgeddetails";
		document.forms[0].hidBeanId.value="mmrcommon";
		document.forms[0].hidSourceUrl.value="/action/mon_hedgeddetails.jsp";
	    document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].method="post";	
		document.forms[0].submit();
	
	}
}
function callLink(page,bean,method)
{
	
	 if (document.forms[0].cmdsave.disabled)
		{
			document.forms[0].hidSourceUrl.value=page;
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
function disableCommandButtons(cmdnew,cmdedit,cmddelete,cmdsave,cmdcancel,cmdclose)
{
	 document.forms[0].cmdnew.disabled =cmdnew;
	 document.forms[0].cmdedit.disabled=cmdedit;
	 document.forms[0].cmddelete.disabled=cmddelete;
	 document.forms[0].cmdsave.disabled=cmdsave;
	 document.forms[0].cmdcancel.disabled=cmdcancel;		 
	 document.forms[0].cmdclose.disabled=cmdclose;	
}  
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="callOnload()">
<form name="hedgedetails" method="post" class="normal">
						<lapschoice:monthlymonitortag pageid="4"/>					
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
      <td class="page_flow">Home-&gt; Monitoring-&gt; Monthly Monitoring Reports-&gt; Limit Unhedged Details</td>
	</tr>
</table>
<lapschoice:MonthlyMonitor />
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable linebor">		
  <tr class="dataheader" align="center"> 
            <td colspan="6" ><b>Details of Unhedged foreign exchange exposure</b><br><br></td>
  </tr>
  <tr class="datagrid"> 
            <td width="11%">Nature</td>
            <td width="16%"> 
              <input type="text" name="txt_nature" tabindex="3" value=''  size="16" maxlength="25">
    </td>
            <td width="8%" align="center">Amount</td>
            <td width="23%"> <lapschoice:CurrencyTag  name="txt_amount" size="16" maxlength="12" tabindex="4" value=''/> 
            </td>
		</table>
		</td>
	</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames='New_Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<br> 
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">		
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable linebor">
					<tr align="center" class="dataheader">
						<td width="5%">&nbsp;</td>
						<td width="19%"><b>Nature</b></td>
						<td width="19%"><b>Amount</b></td> 
					</tr>
					<% if(vecRow!=null && vecRow.size()>0)
						{
                          	String temp="";
                            	int size= vecRow.size();
                            	for(int i=0;i<vecRow.size();i++)
                            	{
                            		vecCol =(ArrayList)vecRow.get(i);%>
					<tr class="datagrid">
						<td width="5%"><input type="radio" name="radiobutton"
							value="radiobutton" style="border-style:none"
							onClick="selectValues('<%=Helper.correctNull((String)vecCol.get(0))%>',
										'<%=Helper.correctNull((String)vecCol.get(1))%>',
										'<%=Helper.correctNull((String)vecCol.get(2))%>',
										'<%=Helper.correctNull((String)vecCol.get(3))%>',
										'<%=Helper.correctNull((String)vecCol.get(4))%>',
										'<%=Helper.correctNull((String)vecCol.get(5))%>',
										'<%=Helper.correctNull((String)vecCol.get(6))%>',
										'<%=Helper.correctNull((String)vecCol.get(7))%>',
										'<%=Helper.correctNull((String)vecCol.get(8))%>',
										'<%=Helper.correctNull((String)vecCol.get(10))%>',
										'<%=Helper.correctNull((String)vecCol.get(11))%>','<%=i%>','<%=size%>')">
										<input type="hidden" name="hidlocation" value="<%=Helper.correctNull((String)vecCol.get(9))%>">
						</td>
						<td width="19%"><%=Helper.correctNull((String)vecCol.get(7))%></td>
						<td width="19%"><%=Helper.correctNull((String)vecCol.get(8))%></td>
						</tr>
					<%}
                  	} 
                            else 
                            {	%>
					<tr class="datagrid">
						<td width="5%">&nbsp;</td>
						<td width="19%">&nbsp;</td>
						<td width="19%">&nbsp;</td>
					</tr>
					<tr class="datagrid">
						<td width="5%">&nbsp;</td>
						<td width="19%">&nbsp;</td>
						<td width="19%">&nbsp;</td>
					</tr>
					<tr class="datagrid">
						<td width="5%">&nbsp;</td>
						<td width="19%">&nbsp;</td>
						<td width="19%">&nbsp;</td>
					</tr>
					<tr class="datagrid">
						<td width="5%">&nbsp;</td>
						<td width="19%">&nbsp;</td>
						<td width="19%">&nbsp;</td>
					</tr>
					<%}%>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="cbsid" value="<%=Helper.correctNull((String)request.getParameter("cbsid"))%>">
<input type="hidden" name="mon_year" value="<%=Helper.correctNull((String)request.getParameter("mon_year"))%>">
<input type="hidden" name="mon_month" value="<%=Helper.correctNull((String)request.getParameter("mon_month"))%>">
<input type="hidden" name="cbsname" value="<%=Helper.correctNull((String)request.getParameter("cbsname"))%>">
<input type="hidden" name="strsno" value="<%=Helper.correctNull((String)hshValues.get("slno"))%>">
<input type="hidden" name="txt_accno">
</form>
</body>
</html>