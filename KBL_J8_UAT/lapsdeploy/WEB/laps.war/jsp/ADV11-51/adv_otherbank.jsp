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
	disableButtons(true,true,false,false,true,true,true);	
	document.forms[0].hideditflag.value="Y";
	document.forms[0].hidAction.value="insert";
	clearfields();
}
function doEdit()
{
	document.forms[0].txt_bankfinacial.focus();
	disableFields(false);
	document.forms[0].hideditflag.value="Y";
	disableButtons(true,true,false,false,false,true,true);
	document.forms[0].hidAction.value="update";
}
function doSave()
{
	if(document.forms[0].txt_bankfinacial.value=="")
	{
		ShowAlert('121',"Name/Financial Institution");
		document.forms[0].txt_bankfinacial.focus();
	}
	else
	{	
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].hidBeanId.value="ADV1151";	
		document.forms[0].hidBeanMethod.value="updateotherbank";
		document.forms[0].hidBeanGetMethod.value="getotherbank";	
		document.forms[0].hidSourceUrl.value="/action/adv_otherbank.jsp";	
		document.forms[0].action=appUrl+"controllerservlet";	
		document.forms[0].submit();	
	}
}
function doCancel()
{
	ConfirmMsg(102);
	document.forms[0].hidAction.value="";
	disableButtons(true,true,true,true,true,true,false);
	document.forms[0].hidBeanId.value="ADV1151";
	document.forms[0].hidBeanGetMethod.value="getotherbank";
	document.forms[0].hidSourceUrl.value="/action/adv_otherbank.jsp";
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
			document.forms[0].hidBeanGetMethod.value="getotherbank";
			document.forms[0].hidBeanMethod.value="updateotherbank";
			document.forms[0].hidSourceUrl.value="/action/adv_otherbank.jsp";
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
		document.forms[0].action=appUrl+"action/agrpage.jsp";
		document.forms[0].submit();
	}
}
function clearfields()
{
	document.forms[0].txt_bankfinacial.value= "";
	document.forms[0].txt_nature.value= "";
	document.forms[0].txt_amt.value= "";
    document.forms[0].sel_paidupto.value="";
    document.forms[0].txt_noofinstal.value="";
    document.forms[0].txt_overdue.value="";
}
function selectValues(val1,val2,val3,val4,val5,val6,val7)
{
	
	document.forms[0].hidsno.value= val1;
	document.forms[0].txt_bankfinacial.value= val2;
	document.forms[0].txt_nature.value= val3;
	document.forms[0].txt_amt.value= val4;
    document.forms[0].sel_paidupto.value=val5;
    document.forms[0].txt_noofinstal.value=val6;
    document.forms[0].txt_overdue.value=val7;
    if(document.forms[0].btnenable.value.toUpperCase()=="Y")
	{
    	disableButtons(true,false,true,false,true,true,true);
    }
    showfields();
}
function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='radio')
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
		showfields();
}
function callLink(page,bean,method)
{		
		document.forms[0].hidSourceUrl.value=page;
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
		document.forms[0].action=appUrl+"action/"+page;
		document.forms[0].submit();
}
function showfields()
{
	if(document.forms[0].sel_paidupto.value=='2')
	{
	document.all.installment.style.visibility="visible";
	document.all.overdues.style.visibility="visible";
	document.all.installment_amt.style.visibility="visible";
	document.all.overdues_amt.style.visibility="visible";
	}
	else
	{
	document.all.installment.style.visibility="hidden";
	document.all.overdues.style.visibility="hidden";
	document.all.installment_amt.style.visibility="hidden";
	document.all.overdues_amt.style.visibility="hidden";
	document.forms[0].txt_noofinstal.value="";
	document.forms[0].txt_overdue.value="";
	}
}
</script>
</head>
<body onload="onLoad()">
<form name="form1" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td><jsp:include page="../share/applurllinkscom.jsp"
			flush="true">
			<jsp:param name="pageid" value="19" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
	<tr>
		<td class="page_flow">Home -&gt; Tertiary -&gt; Proposal -&gt; ADV1151 -&gt; Other Bank</td>
	</tr>
</table>
<span style="display:none"><lapschoice:borrowertype /></span> <lapschoice:application />
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable" align="center">
	<tr class="dataheader">		
      <td align="center"><b>OTHER BANK</b></td>
	</tr>
</table>
  <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable linebor" align="center">
                      <tr class="dataheader">                         
      <td colspan="6"><b>Facilities enjoyed with other banks /Financial Institutions.</b></td>
                      </tr>
                      <tr class="dataheader"> 
                        <td>Bank/Financial Institution<font color="red">*</td>
                        <td>Nature of limit</td>
                        <td>Amount</td>
                        <td>Whether installments paid up to date</td>
                        
                        <td><div id="installment">No. of installmets</div></td>
                        <td><div id="overdues">Total amount overdue</div></td>
                      </tr>
                      <tr class="datagrid"> 
                        <td> 
                          <input type="text" name="txt_bankfinacial" tabindex="1" value="" maxlength="50">
                        </td>
                        <td> 
                          <input type="text" name="txt_nature" tabindex="2" value="" maxlength="50">
                        </td>
                        <td> <lapschoice:CurrencyTag  name="txt_amt"  tabindex="3" maxlength="12" /> 
                        </td>
                        <td align="center"> 
                          <select name="sel_paidupto" tabindex="4" onchange="showfields()">
                            <option value="" selected="selected">--Select--</option>
                            <option value="1">Yes</option>
                            <option value="2">No</option>
                          </select>
                        </td>
                        <td>
                        <div id="installment_amt">
                          <input type="text" name="txt_noofinstal" tabindex="5" size="16" maxlength="12" onKeyPress="allowNumber(document.forms[0].txt_noofinstal)"value="">
                          </div> 
                        </td>
                        <td>
                        <div id="overdues_amt">
                        <lapschoice:CurrencyTag name="txt_overdue" tabindex="6"  maxlength="12" /> 
                        </div>
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
            <td width="14%" align="center"><b>Bank/Financial Institution </b></td>					
            <td width="18%" align="center"><b>Nature of limit</b></td>					
            <td width="9%"align="center" ><b>Amount</b></td>
            <td width="28%"align="center"><b>Whether installments paid up to date</b></td>						 
            <td width="12%" align="center"><b>No. of installmets</b></td>
            <td width="14%"align="center"><b>Total amount overdue</b></td>						
				</tr>
				<%
					ArrayList vecRow=new ArrayList();
					ArrayList vecCol=new ArrayList();
					vecRow =(ArrayList)hshValues.get("vecRow");
					if(vecRow!=null && vecRow.size()>0)
						{                          	
                            	for(int i=0;i<vecRow.size();i++)
                            	{
                            		vecCol =(ArrayList)vecRow.get(i);
                            		
                String install=Helper.correctNull((String)vecCol.get(4));            		
                if(install.equalsIgnoreCase("1"))
                {
                	install="Yes";
                }
                else if (install.equalsIgnoreCase("2"))
                {
                	install="No";
                }
                else if(install.equalsIgnoreCase(""))
                {
                	install="";
                }
                    %>
					 	<tr class="datagrid">
							
              <td width="5%"> 
                <input type="radio" name="radiobutton"
								value="radiobutton" style="border-style:none"
								onClick="selectValues('<%=Helper.correctNull((String)vecCol.get(0))%>',
										'<%=Helper.correctNull((String)vecCol.get(1))%>',
										'<%=Helper.correctNull((String)vecCol.get(2))%>',
										'<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol.get(3))))%>',
										'<%=Helper.correctNull((String)vecCol.get(4))%>',
										'<%=Helper.correctNull((String)vecCol.get(5))%>',
										'<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol.get(6))))%>')">
										
							</td>
			
              <td width="14%"><%=Helper.correctNull((String)vecCol.get(1))%></td>							
              <td width="18%"><%=Helper.correctNull((String)vecCol.get(2))%></td>							
              <td width="9%"align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol.get(3))))%></td>							
              <td width="28%"><%=install%></td>			  
			  <td width="12%"><%=Helper.correctNull((String)vecCol.get(5))%></td>							
              <td width="14%" align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol.get(6))))%></td>							
						</tr>
					<%}
                  	} 
                            else 
                            {	%>
						<tr class="datagrid">							
              <td width="5%">&nbsp;</td>							
              <td width="14%">&nbsp;</td>							
              <td width="18%">&nbsp;</td>							
              <td width="9%">&nbsp;</td>							
              <td width="28%">&nbsp;</td>
			  <td width="12%">&nbsp;</td>							
              <td width="14%">&nbsp;</td>							
						</tr>					
					<%}%>
				</table>		
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
	<tr> 
      <td width="20%"><b>&nbsp; 
        <a href="javascript:callLink('adv_guarantorsdetails.jsp','ADV1151','getGuranteedetails')"> 
        &lt;&lt; Previous </a>&nbsp;</b> </td>
      <td width="60%" align="center"><b> 
        <jsp:include page="../ADV11-51/adv_links.jsp" flush="true" /> 
        </b></td>
      <td width="20%">&nbsp; 

        <div align="right"><b>Pg.7/19&nbsp;<a href="javascript:callLink('adv_turnover.jsp','ADV1151','getTurnover')"> 
          Next &gt;&gt; </a></b></div>
      </td>
    </tr>
</table>  
<input type="hidden" name="hidAppType" value="">
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidsno" value="<%=Helper.correctNull((String)hshValues.get("sno"))%>">
</form>
</body>
</html>
