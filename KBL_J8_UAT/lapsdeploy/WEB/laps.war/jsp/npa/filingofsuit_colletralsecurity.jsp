<%@include file="../share/directives.jsp"%>
<%@ page import="java.util.ArrayList" %>
<%
ArrayList vecRow=(ArrayList)hshValues.get("vecRow");
ArrayList vecCol=new ArrayList();	
java.text.NumberFormat nf=java.text.NumberFormat.getInstance();
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);
nf.setGroupingUsed(false);
%>

<html>
<head>
<title>ubi</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css"/>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js">
</script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
function disableCommandButtons(val)
{
	if(val=="load")
	{  
		disableFields(true);
		document.forms[0].cmdnew.disabled =false;
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;		 
	}	
	if(val=="edit")
	{	 
		 document.forms[0].cmdnew.disabled =true;
		 document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmddelete.disabled=true;
		 document.forms[0].cmdsave.disabled=false;
		 document.forms[0].cmdcancel.disabled=false;		 
		 document.forms[0].cmdclose.disabled=true;	 
		 disableFields(false);
	}
	if(val=="radioselect")
	{	 
		document.forms[0].cmdnew.disabled =true;
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmddelete.disabled=false;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;
	}	  
}
function selectValues(val1,val2,val3,val4,val5,val6,val7)
{
	document.forms[0].hid_strsno.value=val1;	
	document.forms[0].txt_location.value=val2;
	document.forms[0].txt_descript.value=val3;
	document.forms[0].txt_owner.value=val4;
	document.forms[0].txt_date.value=val5;
	document.forms[0].security_type.value=val6;
	document.forms[0].security_type.value=val6;
	document.forms[0].txt_present_security.value=val7;
	if(document.forms[0].btnenable.value.toUpperCase()=="Y")
	{
    disableCommandButtons("radioselect");
	}
}
function doNew()
{
	disableFields(false);
	document.forms[0].hidAction.value ="insert";
	disableCommandButtons("edit");
	document.forms[0].txt_location.focus();	
}
function doEdit()
{ 	
	disableFields(false);
	document.forms[0].hidAction.value ="update";
	disableCommandButtons("edit");	
	document.forms[0].txt_location.focus();	
}
function doCancel()
{  
	if(ConfirmMsg(102))
	{
	    document.forms[0].hidAction.value ="";	
		document.forms[0].hidSourceUrl.value="/action/filingofsuit_colletralsecurity.jsp";
		document.forms[0].hidBeanId.value="npa";
		document.forms[0].hidBeanGetMethod.value="getFilingColletralSecurity";
		document.forms[0].hidBeanMethod.value="updateFilingColletralSecurity";
		document.forms[0].action=appURL +"controllerservlet";
		document.forms[0].submit(); 	
		
	}
}

function doSave()
{
	if( document.forms[0].security_type.value == "0")
	{
		alert('Select Security type');
		document.forms[0].security_type.focus();
		return;
	}
	if(document.forms[0].txt_location.value == "")
	{
		ShowAlert('121','Location');
		document.forms[0].txt_location.focus();
		return;
	}
	if(document.forms[0].txt_present_security.value=="")
	{
		alert("Enter the present position of the Security");
		document.forms[0].txt_present_security.focus();
		return;
	}
		document.forms[0].hidSourceUrl.value="/action/filingofsuit_colletralsecurity.jsp";
		document.forms[0].hidBeanId.value="npa";
		document.forms[0].hidBeanMethod.value="updateFilingColletralSecurity";
		document.forms[0].hidBeanGetMethod.value="getFilingColletralSecurity";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
}
function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].hidSourceUrl.value="/action/filingofsuit_colletralsecurity.jsp";
		document.forms[0].hidBeanId.value="npa";
		document.forms[0].hidBeanMethod.value="updateFilingColletralSecurity";
		document.forms[0].hidBeanGetMethod.value="getFilingColletralSecurity";
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
	document.forms[0].txt_date.readOnly=true;	
}
function onLoading()
{
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
function calSUBTotal()
{
	var running=document.forms[0].txt_running_outstand.value;
	var prodential=document.forms[0].txt_prodential_writeoff.value;
	var ecgcamount=document.forms[0].txt_ecgc_claim.value;	
	if(running=="")
	{
		running="0.00";
	}
	if(prodential=="")
	{
		prodential="0.00";
	}
	if(ecgcamount=="")
	{
		ecgcamount="0.00";
	}
	var tempsubtotal=0.00;
	tempsubtotal=eval(running)+eval(prodential)+eval(ecgcamount);
	document.forms[0].txt_subtotal.value=tempsubtotal;	
	var subtotal=document.forms[0].txt_subtotal.value;
	var unrecover=document.forms[0].txt_unrecover.value;
	if(subtotal=="")
	{
		subtotal="0.00";
	}
	if(unrecover=="")
	{
		unrecover="0.00";
	}
	var tempnetdues=eval(subtotal)-eval(unrecover);
	document.forms[0].txt_net_dues.value=tempnetdues;
	var netdues=document.forms[0].txt_net_dues.value;
	
	var dummyledger=document.forms[0].txt_dummy_ledger.value;
	var legalexp=document.forms[0].txt_legal_expenses.value;
	if(dummyledger=="")
	{
		dummyledger="0.00";
	}
	if(legalexp=="")
	{
		legalexp="0.00";
	}
	var total=eval(netdues)+eval(dummyledger)+eval(legalexp);
    document.forms[0].txt_total_dues.value=total;	
}
function callLink(page,bean,method)
		{
		if (document.forms[0].cmdsave.disabled)
	{
		document.forms[0].hidSourceUrl.value=page;
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
		document.forms[0].hidmoduletype.value="SUIT";
		document.forms[0].action=appURL+"action/"+page;
		document.forms[0].submit();
			 }
	else
	{
		ShowAlert(103);
	}
		}
</script>
</head>
<body  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  onload="onLoading()">
<form name="safaeri2" method="post" class="normal">
<lapstab:suiturltag pageid="6"/>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">	
				 <tr> 
           <td valign="top" class="page_flow">Home -&gt; NPA-&gt; Filing Of Suit   -&gt;Security</td>
          </tr>
			</table>
<lapschoice:npaapplication />
		<INPUT type="hidden" name="npa_appno" value="<%=(String)request.getParameter("npa_appno")%>" />
<lapstab:npapresentpostion module='<%=Helper.correctNull((String)request.getParameter("hidmoduletype"))%>' pageid="2" /><br>
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
    <tr> 
      <td>
  <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
    <tr> 
      <td colspan="4" align="center"><b>DETAILS OF SECURITY</b></td>
    </tr>
    <tr> 
      <td width="16%">Type of Security<span class="mantatory">*</span></td>
      <td width="37%"> 
        <select name="security_type">
          <option value="0" selected>Select</option>
          <option value="1">Primary</option>
          <option value="2">Collateral</option>
        </select>
      </td>
      <td width="9%">&nbsp;</td>
      <td width="38%">&nbsp;</td>
    </tr>
    <tr> 
      <td width="16%">Location</td>
      <td width="37%"> 
        <input type="text" name="txt_location" size="35"
							maxlength="50" >
      </td>
      <td width="9%"> Description</td>
      <td width="38%"> 
        <input type="text" name="txt_descript" size="35"
							maxlength="75">
      </td>
    </tr>
    <tr> 
      <td width="16%">Owner of the Property </td>
      <td width="37%"> 
        <input type="text" name="txt_owner"
							 size="35" maxlength="50">
      </td>
      <td width="9%">Date of EM </td>
      <td width="38%"> 
        <input type="text" name="txt_date" size="15" onBlur="checkDate(this)"
							maxlength="25">
        <a href="#" onClick="callCalender('txt_date')"
							TITLE="Click to view calender" BORDER=0><IMG
							src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
							BORDER="0" TABINDEX="23"></a> </td>
    </tr>
    <tr>
      <td width="16%">Present postion of security <span class="mantatory">*&nbsp;</span></td>
      <td width="37%"> 
        <textarea rows="4" name="txt_present_security" cols="70"
					onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues.get("present_security"))%></textarea>
      </td>
      <td width="9%">&nbsp;</td>
      <td width="38%">&nbsp;</td>
    </tr>
  </table>
  </td>
  </tr>
  </table><br>
<lapschoice:combuttonnew btnnames="New_Edit_Save_Cancel_Delete_Audit Trial"
	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' /><br>
                      <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
                        <tr> 
                          <td valign="top">                              
                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable linebor">
                  <tr class="dataheader"> 
                    <td width="4%" >&nbsp;</td>
					<td width="4%"  align="center"><b>Security Type</b></td>
                    <td width="16%"  align="center"><b>Location</b></td>
                    <td width="16%"  align="center"><b>Description</b></td>
                    <td width="16%"  align="center"><b>Owner of the Property  </b></td>
                    <td width="16%"  align="center"><b>Date of EM</b></td>        
                  </tr>
                  <%vecRow=(ArrayList)hshValues.get("vecRow");
					if(vecRow.size()>0 && vecRow!=null)
					{
						for(int i=0;i<vecRow.size();i++)
						{
						vecCol = (ArrayList)vecRow.get(i);%>
                  <tr class="datagrid"> 
                    <td width="4%" align=center>
                      <input type="radio" 
													style="border:none" name="radiobutton" value="radiobutton"
													onClick="selectValues('<%=Helper.correctNull((String)vecCol.get(0))%>',
													'<%=Helper.correctNull((String)vecCol.get(1))%>','<%=Helper.correctNull((String)vecCol.get(2))%>',
													'<%=Helper.correctNull((String)vecCol.get(3))%>','<%=Helper.correctNull((String)vecCol.get(4))%>'
													,'<%=Helper.correctNull((String)vecCol.get(5))%>','<%=Helper.replaceForJavaScriptString((String)vecCol.get(6))%>')">
                   </td>
                      <%String scur_type="";
                      if("1".equals(Helper.correctNull((String)vecCol.get(5))))
                    	  scur_type="Primary";
                    	  else if("2".equals(Helper.correctNull((String)vecCol.get(5))))
                    		  scur_type="Collateral";%>                      
					   <td width="16%">&nbsp;<%=scur_type%></td>
                    <td width="16%">&nbsp;<%=Helper.correctNull((String)vecCol.get(1))%></td>
                    <td width="16%">&nbsp;<%=Helper.correctNull((String)vecCol.get(2))%></td>
                    <td width="16%">&nbsp;<%=Helper.correctNull((String)vecCol.get(3))%></td>
                    <td width="16%">&nbsp;<%=Helper.correctNull((String)vecCol.get(4))%></td>                    
                  </tr>
                  <%}}else{%>
                  <tr class="datagrid"> 
                    <td align=center colspan="10">No Data Found</td>
                  </tr>
                  <%}%>
                </table>
                          </td>
                        </tr>
                      </table>
 <lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hid_strsno" value="<%=Helper.correctNull((String)hshValues.get("fil_sno"))%>"/>
</form>
</body>
</html>