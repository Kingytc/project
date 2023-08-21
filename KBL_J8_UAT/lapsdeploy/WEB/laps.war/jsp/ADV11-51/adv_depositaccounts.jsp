<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>Bank deposits</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
function doNew()
{
	disableFields(false);
	disableButtons(true,true,false,false,true,false,true);
	document.forms[0].hideditflag.value="Y";	
	document.forms[0].txt_name.focus();
	document.forms[0].hidAction.value="new";
	clearfields();
}
function doEdit()
{
	disableFields(false);
	disableButtons(true,true,false,false,false,false,true);
	document.forms[0].hideditflag.value="Y";
	document.forms[0].hidAction.value="update";
}

function doSave()
{
	if(document.forms[0].txt_name.value=="")
	{
		ShowAlert('121',"Name");
		document.forms[0].txt_name.focus();
	}
	else
	{
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidBeanId.value="ADV1151";	
	document.forms[0].hidBeanMethod.value="updateDepositAccounts";
	document.forms[0].hidBeanGetMethod.value="getDepositAccounts";	
	document.forms[0].hidSourceUrl.value="/action/adv_depositaccounts.jsp";	
	document.forms[0].action=appUrl+"controllerservlet";	
	document.forms[0].submit();	
	}
}

function doCancel()
{
	ConfirmMsg(102);
	document.forms[0].hidAction.value="";
	disableButtons(true,true,true,true,true,false,false);
	document.forms[0].hidBeanId.value="ADV1151";
	document.forms[0].hidBeanGetMethod.value="getDepositAccounts";
	document.forms[0].hidBeanMethod.value="getDepositAccounts";
	document.forms[0].hidSourceUrl.value="/action/adv_depositaccounts.jsp";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();	
}

function doDelete()
{
	if(varRecordFlag=="Y")
	{
		if(ConfirmMsg(101))
		{
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidBeanId.value="ADV1151";
		document.forms[0].hidBeanGetMethod.value="getDepositAccounts";
		document.forms[0].hidBeanMethod.value="updateDepositAccounts";
		document.forms[0].hidSourceUrl.value="/action/adv_depositaccounts.jsp";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].submit();	
		}
	}
	else
	{
		
		ShowAlert(158);
	}
}


function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appUrl+"action/agrborrowersearch.jsp";
		document.forms[0].submit();
	}
}


function PrintReport()
{	
		var appno="<%=(String)request.getParameter("appno")%>";
		var purl ="<%=ApplicationParams.getAppUrl()%>action/adv_printreport.jsp?hidBeanGetMethod=getADVPrint&hidBeanId=ADV1151&appno="+appno;
		var prop = 'scrollbars=yes,menubar=yes,width=750,height=520';	
		var xpos = (screen.width - 750) / 2;
		var ypos = (screen.height - 520) / 2;
		prop = prop + ",left="+xpos+",top="+ypos;
		window.open(purl,'title',prop);

		var appno="<%=(String)request.getParameter("appno")%>";
		var purl ="<%=ApplicationParams.getAppUrl()%>action/adv_printreport.jsp?hidBeanGetMethod=getADVPrint&hidBeanId=ADV1151&appno="+appno;
		var prop = 'scrollbars=yes,menubar=yes,width=750,height=520';	
		var xpos = (screen.width - 750) / 2;
		var ypos = (screen.height - 520) / 2;
		prop = prop + ",left="+xpos+",top="+ypos;
		window.open(purl,'title',prop);
}
function clearfields()
{
	document.forms[0].txt_name.value= "";
	document.forms[0].txt_sbaccountno.value= "";
	document.forms[0].txt_avgbalance.value= "";
    document.forms[0].txt_presentbalance.value="";
}

function selectValues(val1,val2,val3,val4,val5)
{
	
	document.forms[0].hidsno.value= val1;
	document.forms[0].txt_name.value= val2;
	document.forms[0].txt_sbaccountno.value= val3;
	document.forms[0].txt_avgbalance.value= val4;
    document.forms[0].txt_presentbalance.value=val5;
    if(document.forms[0].readFlag.value.toUpperCase()=="W" && document.forms[0].appstatus.value=="Open/Pending")
	{
    disableButtons(true,false,true,true,false,false,true);
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
				 
	}
}
function disableButtons(bool1,bool2,bool3,bool4,bool5,bool6,bool7)
{
	document.forms[0].cmdnew.disabled=bool1;
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool5;
	document.forms[0].cmdclose.disabled=bool7;	
}
function onLoad()
{
	disableFields(true);
}
function callLink(page,bean,method)
{		
		if (document.forms[0].cmdapply.disabled)
		{
		document.forms[0].hidSourceUrl.value=page;
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
</script>
</head>
<body onload="onLoad()">
<form name="form1" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top"><jsp:include page="../share/applurllinkscom.jsp"
			flush="true">
			<jsp:param name="pageid" value="19" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
	<tr>
		<td class="page_flow">Home-&gt; Tertiary-&gt; Proposal-&gt;ADV1151 -&gt;Deposit Accounts</td>
	</tr>
</table>
<lapschoice:borrowertype /> <lapschoice:application /><br>
<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable" align="center">
	<tr class="dataheader">
		<td align="center"><b>DEPOSIT ACCOUNTS</b>
	</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable linebor" align="center">
	<tr class="dataheader"> 
		<td colspan="4"><b>Deposit accounts (Including Family Members)</b></td>
    </tr>
    <tr class="dataheader"> 
      <td  width="3%" width="197">Name<span class="mantatory"><b>*</b></span></td>
      <td  width="3%" width="197">S.B a/c no</td>
      <td  width="3%" width="353">Avg Bal. maintained for the previous 12 months</td>
      <td  width="3%" width="244">Present Balance</td>
    </tr>
    <tr class="datagrid">
      <td width="197"> 
        <input type="text" name="txt_name" value='' onKeyPress="notAllowSplChar()" tabindex="1" maxlength="45">       
      </td>
      <td width="197"> 
        <input type="text" name="txt_sbaccountno" value='' tabindex="2" maxlength="20">
      </td>
      <td width="353"> 
        <lapschoice:CurrencyTag name="txt_avgbalance" value='' tabindex="3"  maxlength="15"/>
      </td>
      <td width="244"> 
        <lapschoice:CurrencyTag name="txt_presentbalance" value='' tabindex="4"  maxlength="15"/>
      </td>
    </tr>
</table>
  <br>
<lapschoice:combuttonnew btnnames='New_Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
  <br>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
			<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable linebor">
				<tr class="dataheader">
					<td width="5%">&nbsp;</td>
					<td width="19%" ><b>Name </b></td>
					<td width="19%" ><b>S.B a/c no</b></td>
					<td width="19%" ><b>Avg Bal. maintained for the previous 12 months</b></td> 
					<td width="19%" ><b>Present balance </b></td>						
				</tr>
				<%
					ArrayList vecRow=new ArrayList();
					ArrayList vecCol=new ArrayList();
					vecRow =(ArrayList)hshValues.get("vecRow");
					if(vecRow!=null && vecRow.size()>0)
						{                          	
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
										'<%=Helper.correctNull((String)vecCol.get(4))%>')">										
							</td>
							<td width="19%"><%=Helper.correctNull((String)vecCol.get(1))%></td>
							<td width="19%"><%=Helper.correctNull((String)vecCol.get(2))%></td>
							<td width="19%"align="right"><%=Helper.correctNull((String)vecCol.get(3))%></td>
							<td width="19%"align="right"><%=Helper.correctNull((String)vecCol.get(4))%></td>							
						</tr>
					<%}}else{%>
						<tr class="datagrid">
							<td width="5%">&nbsp;</td>
							<td width="19%">&nbsp;</td>
							<td width="19%">&nbsp;</td>
							<td width="19%">&nbsp;</td>
							<td width="19%">&nbsp;</td>							
						</tr>
						<tr class="datagrid">
							<td width="5%">&nbsp;</td>
							<td width="19%">&nbsp;</td>
							<td width="19%">&nbsp;</td>
							<td width="19%">&nbsp;</td>
							<td width="19%">&nbsp;</td>							
						</tr>					
					<%}%>
				</table>
			<br>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
	<tr>       
      <td width="20%" align="left"><b>&nbsp; 
        <a href="javascript:callLink('adv_turnover.jsp','ADV1151','getTurnover')"> 
        &lt;&lt; Previous </a>&nbsp;</b> </td>
      <td width="60%" align="center"><b> 
        <jsp:include page="../ADV11-51/adv_links.jsp" flush="true"> </jsp:include>
        </b></td>
      <td width="20%">&nbsp; 
        <div align="right"><b>Pg.9/19&nbsp;<a href="javascript:callLink('adv_termdepoits.jsp','ADV1151','getTermdepoits')"> 
          Next &gt;&gt; </a></b></div>
      </td>
    </tr>
</table>  
<input type="hidden" name="hidAppType" value="">
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidsno" >
</form>
</body>
</html>
