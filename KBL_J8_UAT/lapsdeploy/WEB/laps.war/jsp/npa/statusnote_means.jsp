<%@include file="../share/directives.jsp"%>
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
<SCRIPT language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
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
function selectValues(val1,val2,val3,val5,val6,val7,val8,val10,i,size)
{
	document.forms[0].hid_strsno.value=val1;
	document.forms[0].sel_type_applicant.value=val2;
	document.forms[0].txt_name_applicant.value=val3;
	document.forms[0].txt_renew_means.value=val5;
	document.forms[0].txt_renew_date.value=val6;
	document.forms[0].txt_present_means.value=val7;
	document.forms[0].txt_present_date.value=val8;
	document.forms[0].txt_phone.value=val10;
	if(size==1)
	{
		document.forms[0].txt_present_activity.value=document.forms[0].hidactivity.value;
		document.forms[0].txt_address.value=document.forms[0].hidaddress.value;
	}
	else
	{
		document.forms[0].txt_present_activity.value=document.forms[0].hidactivity[i].value;
		document.forms[0].txt_address.value=document.forms[0].hidaddress[i].value;
	}
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
		document.forms[0].hidAction.value ="";
		document.forms[0].hidSourceUrl.value="/action/statusnote_means.jsp";
		document.forms[0].hidBeanId.value="npacommon";
		document.forms[0].hidBeanGetMethod.value="getBorrowerDetails";
		document.forms[0].hidBeanMethod.value="updateBorrwerDetails";
		document.forms[0].action=appUrl +"controllerservlet";
		document.forms[0].submit(); 		
	}	
	
}

function doSave()
{
		var selapptype=document.forms[0].sel_type_applicant.options[document.forms[0].sel_type_applicant.selectedIndex].value;
	if(selapptype=='s')
	{
		alert("Select Applicant Type");
		document.forms[0].sel_type_applicant.focus();
		return ;
	}
	if(document.forms[0].sel_type_applicant.value=="0")
	{
		alert("Select Applicant Type");
		document.forms[0].sel_type_applicant.focus();
		return;
	}
	if(document.forms[0].txt_name_applicant.value=="")
	{
		alert("Enter Applicant Name");
		document.forms[0].txt_name_applicant.focus();
		return;
	}
	if(document.forms[0].txt_present_means.value=="")
	{
		alert("Enter the Means");
		document.forms[0].txt_present_means.focus();
		return;
	}
	if(document.forms[0].txt_present_date.value=="")
	{
		alert("Enter the Date");
		document.forms[0].txt_present_date.focus();
		return;
	}
		document.forms[0].hidAppType.value = document.forms[0].sel_type_applicant[document.forms[0].sel_type_applicant.selectedIndex].text;
		document.forms[0].hidSourceUrl.value="/action/statusnote_means.jsp";
		document.forms[0].hidBeanId.value="npacommon";
		document.forms[0].hidBeanMethod.value="updateBorrwerDetails";
		document.forms[0].hidBeanGetMethod.value="getBorrowerDetails";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].submit();
}
function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].hidSourceUrl.value="/action/statusnote_means.jsp";
		document.forms[0].hidBeanId.value="npacommon";
		document.forms[0].hidBeanMethod.value="updateBorrwerDetails";
		document.forms[0].hidBeanGetMethod.value="getBorrowerDetails";
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
		 
	}
	document.forms[0].txt_renew_date.readOnly=true;
	document.forms[0].txt_present_date.readOnly=true;
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
function callLink(page,bean,method)
	{
		if (document.forms[0].cmdsave.disabled)
		{
		document.forms[0].hidSourceUrl.value=page;
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
		document.forms[0].hidmoduletype.value="STAT";
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
<body onload="onLoading()">
<form name="safaeri2" method="post" class="normal">

<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable border1">
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" align="left" class="outertable">
				<tr>
					<td>
						<lapstab:staturltag pageid="2"/>
					</td>
				</tr>
				 <tr> 
           <td valign="top" class="page_flow">Home -&gt; NPA-&gt; Status Note -&gt; Present Position -&gt; Promoters/ Guarantors    
 </td>
          </tr>
			</table>
		</td>
	</tr>
</table>
<lapschoice:npaapplication />
		<INPUT type="hidden" name="npa_appno" value="<%=request.getParameter("appno")%>" />
<lapstab:npapresentpostion
	module='<%=Helper.correctNull((String)request.getParameter("hidmoduletype"))%>'
	pageid="3" />

<table width="100%" border="1" cellspacing="0" cellpadding="3" class="outertable">
    <tr> 
    <td>
  <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
    <tr class="dataheader">    
      <td colspan="4" align="center"><b>Promoters/ Guarantors</b></td>
    </tr>
    <tr> 
      <td>TYPE OF APPLICANT<span class="mantatory">*&nbsp;</span></td>
      <td> 
        <select name="sel_type_applicant" tabindex="1">
          <option value="0">---Select-----</option>
          <%String apptype="44"; %>
          <lapschoice:StaticDataNewTag apptype='<%=apptype%>'/> 
        </select>
      </td>
      <td>NAME OF APPLICANT<span class="mantatory">*&nbsp;</span></td>
      <td> 
        <input type="text" name="txt_name_applicant" size="30"
				maxlength="25" tabindex="2" 
				value="<%//=Helper.correctNull((String)hshValues.get("date_documents"))%>">
      </td>
    </tr>
     <tr> 
      <td width="20%">ADDRESS</td>
      <td>
        <textarea rows="4" name="txt_address" cols="50" tabindex="3" onKeyPress="textlimit(this,399)" onKeyUp="textlimit(this,399)"><%//=Helper.correctNull((String)hshValues.get("complaint_received"))%></textarea>
      </td>
      <td>PHONE</td>
      <td>
        <input type="text" name="txt_phone" size="30"
				maxlength="14" tabindex="4" onKeyPress="allowInteger()"
				value="<%//=Helper.correctNull((String)hshValues.get("date_documents"))%>">
      </td>
    </tr>
    <tr> 
      <td>PRESENT ACTIVITY OF APPLICANT</td>
      <td> 
        <textarea rows="2" name="txt_present_activity" cols="50" tabindex="5" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%//=Helper.correctNull((String)hshValues.get("complaint_received"))%></textarea>
      </td>
      <td>&nbsp;</td>
      <td>&nbsp; </td>
    </tr>
    <tr> 
      <td colspan="4"><b>AT THE TIME OF RENEWAL </b></td>
    </tr>
    <tr> 
      <td>MEANS</td>
      <td> 
        <b><%=ApplicationParams.getCurrency()%></b><lapschoice:CurrencyTag name="txt_renew_means" size="20"
				maxlength="15" tabindex="6" />
      </td>
      <td>DATE</td>
      <td> 
        <input type="text" name="txt_renew_date" size="13"
				maxlength="10" tabindex="7" 
				value="<%//=Helper.correctNull((String)hshValues.get("date_documents"))%>" onBlur="checkDate(this);checkmaxdate(this,currentDate)">
        <a href="#" onClick="callCalender('txt_renew_date')"
				title="Click to view calender" border=0><img src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
				width="0" border="0" tabindex="7"></a> </td>
    </tr>
    <tr> 
      <td ><b>PRESENT POSITION</b></td>
      <td >&nbsp; </td>
      <td >&nbsp;</td>
      <td >&nbsp; </td>
    </tr>
    <tr> 
      <td > MEANS <span class="mantatory">*&nbsp;</span></td>
      <td > 
        <b><%=ApplicationParams.getCurrency()%></b><lapschoice:CurrencyTag name="txt_present_means" size="20"
				maxlength="15" tabindex="8"  />
      </td>
      <td > DATE <span class="mantatory">*&nbsp;</span></td>
      <td > 
        <input type="text" name="txt_present_date" size="13"
				maxlength="10" tabindex="9" 
				value="<%//=Helper.correctNull((String)hshValues.get("date_documents"))%>" onBlur="checkDate(this);checkmaxdate(this,currentDate)" >
        <a href="#" onClick="callCalender('txt_present_date')"
				title="Click to view calender" border=0><img src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
				width="0" border="0" tabindex="9"></a> </td>
    </tr>
    <tr> 
      <td>&nbsp;</td>
      <td>&nbsp; </td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
  </table>
  </td>
  </tr>
  </table>
 <br>
                             <lapschoice:combuttonnew btnnames='New_Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
 <br>
                   
                      <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
                        <tr class="dataheader"> 
                          <td valign="top"> 
                          
                              
                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable linebor">
                  <tr > 
                    <td width="3%" >&nbsp;</td>
                    <td width="17%"  align="center">&nbsp;</td>
                    <td width="20%"  align="center">&nbsp;</td>
                    <td colspan="2"  align="center"><b>AT THE 
                      TIME OF RENEWAL</b></td>
                    <td  align="center" colspan="2"><b>PRESENT 
                      POSITION</b></td>
                  </tr>
                  <tr> 
                    <td width="3%" >&nbsp;</td>
                    <td width="17%"  align="center"><b>TYPE OF 
                      APPLICANT</b></td>
                    <td width="20%"  align="center"><b>NAME OF 
                      APPLICANT</b></td>
                    <td width="15%"  align="center"><b>MEANS  (<%=ApplicationParams.getCurrency()%>)</b></td>
                    <td width="16%"  align="center"><b>DATE</b></td>
                    <td width="13%"  align="center"> <b>MEANS (<%=ApplicationParams.getCurrency()%>)
                      </b></td>
                    <td width="16%"  align="center"><b>DATE</b></td>
                  </tr>
                  <%
                     
                  vecRow=(ArrayList)hshValues.get("vecRow");
					if(vecRow!=null && vecRow.size()>0)
					{
						int size=vecRow.size();
						for(int i=0;i<vecRow.size();i++)
						{
						vecCol = (ArrayList)vecRow.get(i);
					%>
                  <tr class="datagrid"> 
                     <td width="3%" align=center> 
                      <input type="radio" 
													style="border:none" name="radiobutton" value="radiobutton"
													onClick="selectValues('<%=Helper.correctNull((String)vecCol.get(0))%>',
													'<%=Helper.correctNull((String)vecCol.get(1))%>','<%=Helper.correctNull((String)vecCol.get(2))%>',
													'<%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecCol.get(4))))%>',
                            	'<%=Helper.correctNull((String)vecCol.get(5))%>','<%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecCol.get(6))))%>',
                            	'<%=Helper.correctNull((String)vecCol.get(7))%>','<%=Helper.correctNull((String)vecCol.get(10))%>','<%=i%>','<%=size%>')">
                            	<input type="hidden" name="hidaddress" value="<%=Helper.correctNull((String)vecCol.get(9))%>">
                            	<input type="hidden" name="hidactivity" value="<%=Helper.correctNull((String)vecCol.get(3))%>">
                     </td>
                    
                    <td width="17%">&nbsp;<%=Helper.correctNull((String)vecCol.get(11))%></td>
                    <td width="20%">&nbsp;<%=Helper.correctNull((String)vecCol.get(2))%></td>
                    <td width="15%" align="right">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecCol.get(4))))%></td>
                    <td width="16%" align="center">&nbsp;<%=Helper.correctNull((String)vecCol.get(5))%></td>
                    <td width="13%" align="right">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecCol.get(6))))%></td>
                    <td width="16%" align="center">&nbsp;<%=Helper.correctNull((String)vecCol.get(7))%></td>
                  </tr>
                  <%
					 }
					 }
				  	else
                	{
               %>
                  <tr class="datagrid"> 
                    <td align center colspan="9">No 
                      Data Found</td>
                  </tr>
                  <%
                	}
                %>
                </table>
                           
                          </td>
                        </tr>
                      </table>
                    </div>
<input type="hidden" name="hid_strsno" value="<%=Helper.correctNull((String)hshValues.get("APPSNO_NPA"))%>"/>
<input type="hidden" name="hidAppType">
 <lapschoice:hiddentag pageid='<%=PageId%>'/>
</form>
</body>
</html>