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
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
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
	if(val=="disabled")
	{	 
		document.forms[0].cmdnew.disabled =true;
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;
	}  
}
function selectValues(val1,val2,val3,val4,val5,val6,val7,val8,val9,val10)
{
	document.forms[0].hid_strsno.value=val1;
	document.forms[0].sel_type_applicant.value=val2;
	document.forms[0].txt_name_applicant.value=val3;
	document.forms[0].txt_present_activity.value=val4;
	document.forms[0].txt_renew_means.value=val5;
	document.forms[0].txt_renew_date.value=val6;
	document.forms[0].txt_present_means.value=val7;
	document.forms[0].txt_present_date.value=val8;
	document.forms[0].txt_address.value=val9;
	document.forms[0].txt_phone.value=val10;
	if(document.forms[0].readFlag.value.toUpperCase()=="W")
	{
   disableCommandButtons("disabled");
	}
}
function doNew()
{
	disableFields(false);
	document.forms[0].hidAction.value ="insert";
	disableCommandButtons("edit");
	document.forms[0].sel_type_applicant.focus();	
}
function doEdit()
{ 	
	disableFields(false);
	document.forms[0].hidAction.value ="update";
	disableCommandButtons("edit");	
	document.forms[0].sel_type_applicant.focus();	
}
function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidSourceUrl.value="/action/filingofsuit_means.jsp";
		document.forms[0].hidAction.value ="";
		document.forms[0].hidBeanId.value="npacommon";
		document.forms[0].hidBeanGetMethod.value="getBorrowerDetails";
		document.forms[0].hidBeanMethod.value="updateBorrwerDetails";
		document.forms[0].action=appURL +"controllerservlet";
		document.forms[0].submit(); 		
	}
}

function doSave()
{
	var selapptype=document.forms[0].sel_type_applicant.value;
	if(selapptype=='0')
	{
		alert("select Applicant Type");
		document.forms[0].sel_type_applicant.focus();
		return ;
	}
		document.forms[0].hidAppType.value = document.forms[0].sel_type_applicant[document.forms[0].sel_type_applicant.selectedIndex].text;
		document.forms[0].hidSourceUrl.value="/action/filingofsuit_means.jsp";
		document.forms[0].hidBeanId.value="npacommon";
		document.forms[0].hidBeanMethod.value="updateBorrwerDetails";
		document.forms[0].hidBeanGetMethod.value="getBorrowerDetails";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
}
function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].hidSourceUrl.value="/action/filingofsuit_means.jsp";
		document.forms[0].hidBeanId.value="npacommon";
		document.forms[0].hidBeanMethod.value="updateBorrwerDetails";
		document.forms[0].hidBeanGetMethod.value="getBorrowerDetails";
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
	document.forms[0].txt_renew_date.readOnly=true;
	document.forms[0].txt_present_date.readOnly=true;
}
function onLoading()
{
	disableCommandButtons("disabled");
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
function callLink(page,bean,method)
{
	document.forms[0].hidSourceUrl.value=page;
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].hidBeanId.value=bean;
	document.forms[0].hidmoduletype.value="SUIT";
	document.forms[0].action=appURL+"action/"+page;
	document.forms[0].submit();
}
</script>

</head>
<body onload="onLoading()">
<form name="safaeri2" method="post" class="normal">
<lapstab:suiturltag pageid="6"/>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable linebor">	
				<tr> 
           <td valign="top" class="page_flow">Home -&gt; NPA-&gt; Filing Of Suit   -&gt;Borrower Means
 </td>
          </tr>
			</table>
<lapschoice:npaapplication />
		<INPUT type="hidden" name="npa_appno" value="<%=(String)request.getParameter("npa_appno")%>" />
<lapstab:npapresentpostion module='<%=Helper.correctNull((String)request.getParameter("hidmoduletype"))%>' pageid="3" /><br>
<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable border1">
    <tr> 
      <td>
  <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
    <tr> 
      <td colspan="5" align="center"><b>DETAILS OF BORROWER MEANS</b></td>
    </tr>
    <tr> 
      <td width="20%">Type Of Applicant <span class="mantatory">*&nbsp;</span></td>
      <td colspan="2"> 
       <select name="sel_type_applicant" tabindex="1">
				<option value="0">---Select-----</option>
				<%String apptype="44"; %>
				<lapschoice:StaticDataNewTag apptype='<%=apptype%>'/> 
			  </select>
      </td>
      <td width="10%">Name Of Applicant</td>
      <td width="28%"> 
        <input type="text" name="txt_name_applicant" size="30" maxlength="25" tabindex="2">
      </td>
    </tr>
    <tr> 
      <td width="20%">Address</td>
      <td colspan="2"> 
        <textarea rows="4" name="txt_address" cols="50" tabindex="3" onKeyPress="textlimit(this,399)" onKeyUp="textlimit(this,399)"></textarea>
      </td>
      <td width="10%">Phone No</td>
      <td width="28%"> 
        <input type="text" name="txt_phone" size="30" tabindex="4" onKeyPress="allowInteger()" maxlength="14">
      </td>
    </tr>
    <tr> 
      <td width="20%">Present activity of applicant</td>
      <td colspan="2"> 
        <textarea rows="2" name="txt_present_activity" tabindex="5" cols="50" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"></textarea>
      </td>
      <td width="10%">&nbsp;</td>
      <td width="28%">&nbsp; </td>
    </tr>
    <tr> 
      <td colspan="5"> <b>AT THE TIME OF RENEWAL </b></td>
    </tr>
    <tr> 
      <td width="20%">Means</td>
      <td width="4%"><b><%=ApplicationParams.getCurrency()%></b></td>
      <td width="38%"> 
        <lapschoice:CurrencyTag name="txt_renew_means" size="20" maxlength="15" tabindex="6"/>
      </td>
      <td width="10%">Date</td>
      <td width="28%"> 
        <table width="40%">
	  	<tr>
			<td>
        	<input type="text" name="txt_renew_date" size="12"
				maxlength="10" tabindex="7" onBlur="checkDate(this);checkmaxdate(this,'<%=Helper.getCurrentDateTime()%>');">
			</td>
			<td>
        	<a href="#" onClick="callCalender('txt_renew_date')"
				title="Click to view calender" border=0><img src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
				width="0" border="0" tabindex="7"></a> 
			</td>
		</tr>
	</table>
	</td>
    </tr>
    <tr> 
      <td width="20%" ><b>PRESENT POSITION</b></td>
      <td colspan="2" >&nbsp; </td>
      <td width="10%" >&nbsp;</td>
      <td width="28%" >&nbsp; </td>
    </tr>
    <tr> 
      <td width="20%" > Means <span class="mantatory">*&nbsp;</span></td>
      <td width="4%" ><b><%=ApplicationParams.getCurrency()%></b> </td>
      <td width="38%" > 
        <lapschoice:CurrencyTag name="txt_present_means" size="20" 
				maxlength="15" tabindex="8" />
      </td>
      <td width="10%" > Date <span class="mantatory">*&nbsp;</span></td>
      <td width="28%" >
	   <table width="40%">
	  	<tr>
			<td> 
        <input type="text" name="txt_present_date" size="12"
				maxlength="10" tabindex="8" onBlur="checkDate(this);checkmaxdate(this,'<%=Helper.getCurrentDateTime()%>');" >
		</td>
		<td>
        <a href="#" onClick="callCalender('txt_present_date')"
				title="Click to view calender" border=0><img src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
				width="0" border="0" tabindex="8"></a> 
		</td>
	</tr>
	</table>
	</td>
    </tr>
    <tr> 
      <td width="20%">&nbsp;</td>
      <td colspan="2">&nbsp; </td>
      <td width="10%">&nbsp;</td>
      <td width="28%">&nbsp;</td>
    </tr>
  </table>
  </td>
  </tr>
  </table>
  <br>
<lapschoice:combuttonnew btnnames="New_Edit_Save_Cancel_Delete_Audit Trial" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<br>
                      <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
                        <tr> 
                          <td valign="top">                              
                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable linebor">
                  <tr class="dataheader"> 
                    <td width="3%" >&nbsp;</td>
                    <td width="17%"  align="center">&nbsp;</td>
                    <td width="20%"  align="center">&nbsp;</td>
                    <td colspan="2" align="center"><b>AT THE TIME OF RENEWAL</b></td>
                    <td  align="center" colspan="2"><b>PRESENT POSITION</b></td>
                  </tr>
                  <tr class="dataheader"> 
                    <td width="3%">&nbsp;</td>
                    <td width="17%" align="center"><b>Type Of Applicant</b></td>
                    <td width="20%" align="center"><b>Name Of Applicant</b></td>
                    <td width="15%" align="center"><b> Means   </b></td>
                    <td width="16%" align="center"><B>Date</B></td>
                    <td width="13%" align="center"> <b>Means</b></td>
                    <td width="16%" align="center"><B>Date</B></td>
                  </tr>
                  <%vecRow=(ArrayList)hshValues.get("vecRow");
					if(vecRow!=null && vecRow.size()>0)
					{
						for(int i=0;i<vecRow.size();i++)
						{
						vecCol = (ArrayList)vecRow.get(i);%>
                  <tr class="datagrid"> 
                     <td width="3%" align=center> 
                      <input type="radio" 
													style="border:none" name="radiobutton" value="radiobutton"
													onClick="selectValues('<%=Helper.correctNull((String)vecCol.get(0))%>',
													'<%=Helper.correctNull((String)vecCol.get(1))%>','<%=Helper.correctNull((String)vecCol.get(2))%>',
													'<%=Helper.replaceForJavaScriptString((String)vecCol.get(3))%>','<%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecCol.get(4))))%>',
                            	'<%=Helper.correctNull((String)vecCol.get(5))%>','<%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecCol.get(6))))%>',
                            	'<%=Helper.correctNull((String)vecCol.get(7))%>','<%=Helper.replaceForJavaScriptString((String)vecCol.get(9))%>','<%=Helper.correctNull((String)vecCol.get(10))%>')">
                      </td>
                      
                    <td width="17%">&nbsp;<%=Helper.correctNull((String)vecCol.get(11))%></td>
                    <td width="20%">&nbsp;<%=Helper.correctNull((String)vecCol.get(2))%></td>
                    <td width="15%" align="right">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecCol.get(4))))%></td>
                    <td width="16%">&nbsp;<%=Helper.correctNull((String)vecCol.get(5))%></td>
                    <td width="13%" align="right">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecCol.get(6))))%></td>
                    <td width="16%" >&nbsp;<%=Helper.correctNull((String)vecCol.get(7))%></td>
                  </tr>
                  <%}}else{%>
                  <tr class="datagrid"> 
                    <td align=center colspan="9">No Data Found</td>
                  </tr>
                  <%}%>
                </table>
                          </td>
                        </tr>
                      </table>
<input type="hidden" name="hid_strsno" value="<%=Helper.correctNull((String)hshValues.get("PRE_SNO"))%>"/>
<input type="hidden" name="hidAppType">
<lapschoice:hiddentag pageid='<%=PageId%>'/>
</form>
</body>
</html>