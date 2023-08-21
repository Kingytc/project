<%@include file="../share/directives.jsp"%>
 <%String bill[]={"DA (FDBP)","DP (FDBP)","DA (IDBP)","DP (IDBP)","Cheque (Clean BP)","Hundis (Clean BP)"}; 
 
	%>
<html>
<head>
<title>Billpurchase</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var varRecordFlag = "<%=Helper.correctNull((String)hshValues.get("recordflag"))%>";
function doEdit()
{
	disableFields(false);
	enableButtons(true,false,false,false,true);
	document.forms[0].hideditflag.value="Y";
	document.forms[0].hidAction.value="insert";	
}
function doSave()
{
	for(var i=0;i<4;i++)
	{
		var txt_limit=document.forms[0].txt_limit[i].value;
		var txt_business=document.forms[0].txt_business[i].value;
		var txt_presentos=document.forms[0].txt_presentos[i].value;
		var txt_overdue=document.forms[0].txt_overdue[i].value;		
	}
	document.forms[0].hidRecordflag.value = varRecordFlag;
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidBeanId.value="ADV1151";	
	document.forms[0].hidBeanMethod.value="updatePurchaseDetails";
	document.forms[0].hidBeanGetMethod.value="getPurchaseDetails";	
	document.forms[0].hidSourceUrl.value="/action/adv_billpurchase.jsp";	
	document.forms[0].action=appURL+"controllerservlet";	
	document.forms[0].submit();	
}
function doCancel()
{
		if(ConfirmMsg(102))
		{
			enableButtons(false,true,true,true,false);
			document.forms[0].hidBeanId.value="ADV1151";
			document.forms[0].hidBeanGetMethod.value="getPurchaseDetails";
			document.forms[0].hidBeanMethod.value="getPurchaseDetails";
			document.forms[0].hidSourceUrl.value="/action/adv_billpurchase.jsp";
			document.forms[0].action=appURL+"controllerservlet";
			document.forms[0].submit();	
		}	
}
function doDelete()
{
	if(varRecordFlag=="Y")
	{
		if(ConfirmMsg(101))
		{
			document.forms[0].hidAction.value="delete";
			document.forms[0].hidBeanId.value="ADV1151";
			document.forms[0].hidBeanGetMethod.value="getPurchaseDetails";
			document.forms[0].hidBeanMethod.value="updatePurchaseDetails";
			document.forms[0].hidSourceUrl.value="/action/adv_billpurchase.jsp";
			document.forms[0].action=appURL+"controllerservlet";
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
		document.forms[0].action=appURL+"action/agrpage.jsp";
		document.forms[0].submit();
	}
}
function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
		{	
			if(document.forms[0].elements[i].type=='text')
			{
				document.forms[0].elements[i].readOnly=val;					
			}			
		}
		document.forms[0].txt_officeuse.disabled=val;
}
function enableButtons(bool1,bool2,bool3,bool4,bool6)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool6;	
}
function onLoad()
{
	disableFields(true);
}
function callLink(page,bean,method)
{		
		document.forms[0].hidSourceUrl.value=page;
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
		document.forms[0].action=appURL+"action/"+page;
		document.forms[0].submit();
}
</script>
</head>
<body onload="onLoad()">
<form name="form1" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top"><jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="19" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
	<tr>
		<td class="page_flow">Home-&gt; Tertiary-&gt; Proposal-&gt;ADV1151 -&gt;Bill Purchase</td>
	</tr>
</table>
<lapschoice:borrowertype /> <lapschoice:application />
<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable border1" align="center" >
    <tr class="dataheader"> 
    <td align="center"><b>BILL PURCHASE</b>
    </td>
    </tr>
    </table>
  <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable linebor" align="center">
    <tr class="dataheader"> 
      <td rowspan="2"><b>Bill Purchase </b></td>
      <td width="35%" colspan="4" >&nbsp;</td>
    </tr>
    <tr class="dataheader"> 
      <td  width="3%"><b>Limit</b></td>
      <td  width="2%"><b>Business</b></td>
      <td width="2%" ><b>Present O/S</b></td>
      <td  width="1%"><b>OverDue</b></td>
    </tr>
       <%       ArrayList vecRow= new ArrayList();
       			 ArrayList vecCol=null;
                 vecRow=(ArrayList)hshValues.get("vecRow");
					if(vecRow!=null && vecRow.size()>0)
					{
						for(int i=0;i<6;i++)
						{
						vecCol = (ArrayList)vecRow.get(i);%>
					<tr class="datagrid"> 
      <td align="left" width="14%"><%=bill[i] %>
      <input type="hidden" name="hid_billtype" value="<%=Helper.correctNull((String)vecCol.get(5))%>" />
      </td>
      <td width="8%"> <lapschoice:CurrencyTag  name="txt_limit"   maxlength="15" tabindex="1" value='<%=Helper.correctNull((String)vecCol.get(1))%>'/> 
      </td>
      <td width="8%"> <lapschoice:CurrencyTag  name="txt_business"   maxlength="15" tabindex="2" value='<%=Helper.correctNull((String)vecCol.get(2))%>'/> 
      </td>
      <td width="7%"> <lapschoice:CurrencyTag  name="txt_presentos"   maxlength="15" tabindex="3" value='<%=Helper.correctNull((String)vecCol.get(3))%>'/> 
      </td>
      <td width="7%"> <lapschoice:CurrencyTag  name="txt_overdue"   maxlength="15" tabindex="4" value='<%=Helper.correctNull((String)vecCol.get(4))%>'/> 
      </td>
    </tr>
						<%}}else{for(int i=0;i<6;i++){%>
     
						<tr class="datagrid"> 
					      <td align="left" width="14%"><%=bill[i] %>
					       <input type="hidden" name="hid_billtype" value="<%=bill[i]%>" />
					       </td>
					      <td width="8%"> <lapschoice:CurrencyTag  name="txt_limit"   onKeyPress="allowInteger()" style="text-align:right" maxlength="15" tabindex="1" value=''/> 
					      </td>
					      <td width="8%"> <lapschoice:CurrencyTag  name="txt_business"  onKeyPress="allowInteger()" style="text-align:right" maxlength="15" tabindex="2" value=''/> 
					      </td>
					      <td width="7%"> <lapschoice:CurrencyTag  name="txt_presentos"   onKeyPress="allowInteger()" style="text-align:right" maxlength="15" tabindex="3" value=''/> 
					      </td>
					      <td width="7%"> <lapschoice:CurrencyTag  name="txt_overdue"  onKeyPress="allowInteger()" style="text-align:right" maxlength="15" tabindex="4" value=''/> 
					      </td>
					    </tr>
    				<%}}%>
    <tr class="datagrid"> 
      <td width="14%">For sanctioning office 
        use</td>
      <td width="8%" colspan="4">
        <textarea name="txt_officeuse"  cols="90" rows="10" tabindex="5" onKeyPress="textlimit(this,2999)" onKeyUp="textlimit(this,2999)" ><%=Helper.correctNull((String)hshValues.get("bill_officeuse")) %></textarea>
      </td>
    </tr>
  </table>
  <br>
    <lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
    <br> 
 <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
	<tr> 
      <td width="20%" align="left"><b>&nbsp;
        <a href="javascript:callLink('adv_workingcapital.jsp','ADV1151','getworkingcapital')" > 
           &lt;&lt; Previous </a>&nbsp;</b>
      </td>
      <td width="60%" align="center"><b> 
        <jsp:include page="../ADV11-51/adv_links.jsp" flush="true"> </jsp:include>
        </b></td>
      <td width="20%">&nbsp;<div align="right"><b>Pg.13/19 &nbsp;
      <a href="javascript:callLink('adv_liabilities.jsp','ADV1151','getADVLiabilities')" > 
        Next &gt;&gt; </a></b></div></td>
    </tr>
</table>   
<lapschoice:hiddentag pageid='<%=PageId%>'/>
</form>
</body>
</html>
