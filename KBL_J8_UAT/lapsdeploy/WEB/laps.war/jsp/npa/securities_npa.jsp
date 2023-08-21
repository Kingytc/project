<%@include file="../share/directives.jsp"%>
<%ArrayList vecRow=(ArrayList)hshValues.get("vecRow");
ArrayList vecCol=new ArrayList();%>
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
var currentDate = "<%=Helper.getCurrentDateTime()%>";
function disableCommandButtons(cmdnew,cmdedit,cmddelete,cmdsave,cmdcancel)
{
	document.forms[0].cmdnew.disabled =cmdnew;
	document.forms[0].cmdedit.disabled=cmdedit;
	document.forms[0].cmddelete.disabled=cmddelete;
	document.forms[0].cmdsave.disabled=cmdsave;
	document.forms[0].cmdcancel.disabled=cmdcancel;	
}
function selectValues(val1,val2,val4,val5,val6,val7,val8,val9,i,size)
{
	disableCommandButtons(true,false,true,true,true,false);	
	document.forms[0].hid_strsno.value=val1;
	document.forms[0].sel_security.value=val2;
	document.forms[0].txt_renew_valuedate.value=val4;
	document.forms[0].txt_renew_valueamount.value=val5;
	document.forms[0].txt_present_valuedate.value=val6;
	document.forms[0].txt_present_valueamount.value=val7;
	document.forms[0].txt_present_inspecdate.value=val8;
	document.forms[0].txt_present_inspecby.value=val9;
	if(size==1)
	{
		document.forms[0].txt_nature.value=document.forms[0].hidlocation.value;
	}
	else
	{
		document.forms[0].txt_nature.value=document.forms[0].hidlocation[i].value;
	}
	 if(document.forms[0].readFlag.value.toUpperCase()=="W")
	{
		 disableCommandButtons(true,false,true,true,true,false);	  
	}	
}
function callLink(page,bean,method)
{
	if (document.forms[0].cmdsave.disabled)
	{
		document.forms[0].hidSourceUrl.value=page;
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
		document.forms[0].hidmoduletype.value="SARFI";
		document.forms[0].action=appURL+"action/"+page;
		document.forms[0].submit();
	}
	else
	{
		ShowAlert(103);
	}
}
function doNew()
{
	disableFields(false);
	document.forms[0].hidAction.value ="insert";
	disableCommandButtons(true,true,true,false,false,true);
	document.forms[0].sel_security.focus();	
}
function doEdit()
{ 	
	disableFields(false);
	document.forms[0].hidAction.value ="update";
	disableCommandButtons(true,true,true,false,false,true);
	document.forms[0].sel_security.focus();		
}
function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidAction.value ="";
		document.forms[0].hidSourceUrl.value="/action/securities_npa.jsp";
		document.forms[0].hidBeanId.value="npacommon";
		document.forms[0].hidBeanGetMethod.value="getSecurities";
		document.forms[0].hidBeanMethod.value="updateSecurities";
		document.forms[0].action=appURL +"controllerservlet";
		document.forms[0].submit(); 		
	}	
}

function doSave()
{	
	if(document.forms[0].sel_security.value=="S")
	{
		ShowAlert('111', 'Type of Security');
		return;
	}
	if(document.forms[0].sel_security.value=="0")
	{
		alert("Select the Type of Security");
		document.forms[0].sel_security.focus();
		return;
	}
	if(document.forms[0].txt_present_valuedate.value=="")
	{
		alert("Enter the Valuation Date");
		document.forms[0].txt_present_valuedate.focus();
		return;
	}
	if(document.forms[0].txt_present_valueamount.value=="")
	{
		alert("Enter the Valuation Amount");
		document.forms[0].txt_present_valueamount.focus();
		return;
	}
	if(document.forms[0].txt_present_inspecdate.value=="")
	{
		alert("Enter the Inspection Date");
		document.forms[0].txt_present_inspecdate.focus();
		return;
	}
	if(document.forms[0].txt_present_inspecby.value=="")
	{
		alert("Enter Inspected By");
		document.forms[0].txt_present_inspecby.focus();
		return;
	}
	document.forms[0].hidSourceUrl.value="/action/securities_npa.jsp";
	document.forms[0].hidBeanId.value="npacommon";
	document.forms[0].hidBeanMethod.value="updateSecurities";
	document.forms[0].hidBeanGetMethod.value="getSecurities";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}
function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].hidSourceUrl.value="/action/securities_npa.jsp";
		document.forms[0].hidBeanId.value="npacommon";
		document.forms[0].hidBeanMethod.value="updateSecurities";
		document.forms[0].hidBeanGetMethod.value="getSecurities";
		document.forms[0].action=appURL+"controllerservlet";
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
	}
	document.forms[0].txt_present_valuedate.readOnly=true;
	document.forms[0].txt_present_inspecdate.readOnly=true;
}
function onLoading()
{
	disableCommandButtons(false,true,true,true,true,false);	  
	disableFields(true);
}
function doClose()
	{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appURL+"action/npa_mainlinknav.jsp";
		document.forms[0].submit();
		
	}
}	
function callCalender(name)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal(appURL,name);
		
	}
}
</script>
</head>
<body onload="onLoading()">
<form name="safaeri2" method="post" class="normal">
						<lapstab:sarfiurltag pageid="2"/>					
           <span class="page_flow">Home -&gt; NPA-&gt; Sarfaesi Proposal -&gt;Present Position -&gt;Securities 
<lapschoice:npaapplication />
		<INPUT type="hidden" name="npa_appno" value="<%=(String)request.getParameter("npa_appno")%>" />
<lapstab:npapresentpostion module='<%=Helper.correctNull((String)request.getParameter("hidmoduletype"))%>' pageid="2" />
<br>
   <table width="90%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable border1">
   <tr>
   <td>
  <table width="100%" border="0" cellspacing="1" cellpadding="3" align="center" class="outertable">
    <tr class="dataheader"> 
      <td colspan="5"><b>SECURITIES</b></td>
    </tr>
    <tr class="datagrid"> 
      <td>TYPE OF SECURITY <span class="mantatory">*&nbsp;</span></td>
      <td> 
        <select  name="sel_security" tabindex="1">
          <option value="S">--SELECT--</option>
          <option value="P">PRIMARY</option>
          <option value="C">COLLATERAL</option>
        </select>
      </td>
      <td colspan="2">NATURE & LOCATION</td>
      <td> 
        <TEXTAREA cols="45" rows="3" name="txt_nature" tabindex="2" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"></textarea>
      </td>
    </tr>
    <tr class="dataheader"> 
      <td colspan="5" ><b>AT THE TIME OF RENEWAL </b></td>
    </tr>
    <tr class="datagrid"> 
      <td>VALUATION DATE</td>
      <td> 
        <input type="text" name="txt_renew_valuedate" size="12"
				maxlength="10" tabindex="22" 
				value="<%=Helper.correctNull((String)hshValues.get("date_documents"))%>" onBlur="checkDate(this)">
        <a href="#" onClick="callCalender('txt_renew_valuedate')"
				title="Click to view calender" border=0><img src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
				width="0" border="0" tabindex="23"></a></td>
      <td>VALUATION AMOUNT</td>
      <td>Rs.</td>
      <td> 
        <lapschoice:CurrencyTag name="txt_renew_valueamount" size="20" 
				maxlength="15" tabindex="3" />
      </td>
    </tr>
    <tr class="dataheader"> 
      <td colspan="5" ><b>PRESENT POSITION</b></td>
    </tr>
    <tr class="datagrid"> 
      <td >VALUATION DATE <span class="mantatory">*&nbsp;</span></td>
      <td > 
        <input type="text" name="txt_present_valuedate" size="12"
				maxlength="10" tabindex="4" 
				 onBlur="checkDate(this)">
        <a href="#" onClick="callCalender('txt_present_valuedate')"
				title="Click to view calender" border=0><img src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
				width="0" border="0" tabindex="4"></a> </td>
      <td >VALUATION AMOUNT <span class="mantatory">*&nbsp;</span></td>
      <td >Rs.</td>
      <td > 
        <lapschoice:CurrencyTag name="txt_present_valueamount" size="20" 
				maxlength="15" tabindex="5" />
      </td>
    </tr>
    <tr class="datagrid"> 
      <td> INSPECTION DATE <span class="mantatory">*&nbsp;</span></td>
      <td > 
        <input type="text" name="txt_present_inspecdate" size="12"
				maxlength="10" tabindex="6" 
				 onBlur="checkDate(this)">
        <a href="#" onClick="callCalender('txt_present_inspecdate')"
				title="Click to view calender" border=0><img src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
				width="0" border="0" tabindex="6"></a> </td>
      <td colspan="2" > INSPECTED BY <span class="mantatory">*&nbsp;</span></td>
      <td > 
        <input type="text" name="txt_present_inspecby" size="25"
				maxlength="20" tabindex="7" onKeyPress="notAllowSplChar()">
      </td>
    </tr>
  </table>
  </td>
  </tr>
  </table>
  <br>
   <lapschoice:combuttonnew btnnames='New_Edit_Save_Cancel_Delete_Audit Trial' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
   <br> 
 <table border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">                      
  <tr align="center"> 
                  <td colspan="2">
                      <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
                        <tr> 
                          <td valign="top">                              
                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable linebor">
                  <tr class="dataheader"> 
                    <td width="3%" >&nbsp;</td>
                    <td width="13%"  align="center">&nbsp;</td>
                    <td width="14%"  align="center">&nbsp;</td>
                    <td colspan="2"  align="center"><b>AT THE TIME OF RENEWAL</b></td>
                    <td colspan="4"  align="center"><b>PRESENT POSITION</b></td>
                  </tr>
                  <tr class="dataheader"> 
                    <td width="3%" >&nbsp;</td>
                    <td width="13%"  align="center"><b>TYPE OF SECURITY</b></td>
                    <td width="14%"  align="center"><b>NATURE & LOCATION</b></td>
                    <td width="12%"  align="center"><b>VALUATION DATE</b></td>
                    <td width="13%"  align="center"><b> VALUATION AMOUNT</b></td>
                    <td width="13%"  align="center"> <b> VALUATION DATE</b></td>
                    <td width="13%"  align="center"><b>VALUATION AMOUNT</b></td>
                    <td width="8%"  align="center"><b>INSPECTION DATE</b></td>
                    <td width="11%"  align="center"><b>INSPECTED BY</b></td>
                  </tr>
                  <%                    
                  vecRow=(ArrayList)hshValues.get("vecRow");
					if(vecRow.size()>0 && vecRow!=null)
					{
						int size=vecRow.size();
						for(int i=0;i<vecRow.size();i++)
						{
						vecCol = (ArrayList)vecRow.get(i);%>
                  <tr class="datagrid"> 
                    <td width="3%" align=center>
                      <input type="radio" 
													style="border:none" name="radiobutton" value="radiobutton"
													onClick="selectValues('<%=Helper.correctNull((String)vecCol.get(0))%>',
													'<%=Helper.correctNull((String)vecCol.get(1))%>',
													'<%=Helper.correctNull((String)vecCol.get(3))%>','<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol.get(4))))%>',
                            	'<%=Helper.correctNull((String)vecCol.get(5))%>','<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol.get(6))))%>',
                            	'<%=Helper.correctNull((String)vecCol.get(7))%>','<%=Helper.correctNull((String)vecCol.get(8))%>','<%=i%>','<%=size%>')">
                            	<input type="hidden" name="hidlocation" value="<%=Helper.correctNull((String)vecCol.get(2))%>">
                   </td>
					  <%
					  String security=Helper.correctNull((String)vecCol.get(1));
					  if(security.equalsIgnoreCase("p"))
					  {
						  security="PRIMARY";
					  }
					  else if(security.equalsIgnoreCase("c"))
					  {
						  security="COLLATERAL";
					  }
					  %>
					  
                    <td width="13%">&nbsp;<%=security%></td>
                    <td width="14%">&nbsp;<%=Helper.correctNull((String)vecCol.get(2))%></td>
                    <td width="12%">&nbsp;<%=Helper.correctNull((String)vecCol.get(3))%></td>
                    <td width="13%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol.get(4))))%></td>
                    <td width="13%" >&nbsp;<%=Helper.correctNull((String)vecCol.get(5))%></td>
                    <td width="13%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol.get(6))))%></td>
                    <td width="8%" >&nbsp;<%=Helper.correctNull((String)vecCol.get(7))%></td>
                    <td width="11%" >&nbsp;<%=Helper.correctNull((String)vecCol.get(8))%></td>
                  </tr>
                  <%}}else{%>
                  <tr> 
                    <td align="center" colspan="11">No Data Found</td>
                  </tr>
                  <%}%>
                </table>
                          </td>
                        </tr>
                      </table>
                  </td>
                </tr>
                </table>
<input type="hidden" name="hid_strsno" value="<%=Helper.correctNull((String)hshValues.get("SECU_SNO"))%>"/>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
</form>
</body>
</html>