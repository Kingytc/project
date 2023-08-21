<%@ include file="../share/directives.jsp"%>
<%@ page import="java.util.ArrayList" %>
<%
ArrayList vecRow=(ArrayList)hshValues.get("vecRow");
ArrayList vecCol=new ArrayList();	
%>

<html>
<head>
<title>ubi</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/link.css" type="text/css"/>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css"/>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>

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
function selectValues(val1,val2,val3,val5,val6,val7,val8,i,size)
{
	document.forms[0].hid_strsno.value=val1;
	document.forms[0].sel_type_applicant.value=val2;
	document.forms[0].txt_name_applicant.value=val3;
	
	document.forms[0].txt_renew_means.value=val5;
	document.forms[0].txt_renew_date.value=val6;
	document.forms[0].txt_present_means.value=val7;
	document.forms[0].txt_present_date.value=val8;
	//document.forms[0].txt_address.value=val9;
	//document.forms[0].txt_phone.value=val10;
	if(size==1)
	{
		document.forms[0].txt_present_activity.value=document.forms[0].hidpresent_activity.value;
	}
	else
	{
		document.forms[0].txt_present_activity.value=document.forms[0].hidpresent_activity[i].value;
	}
	if(document.forms[0].readFlag.value.toUpperCase()=="W")
	{
  //  disableCommandButtons("radioselect");
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
		document.forms[0].hidAction.value ="";
		document.forms[0].hidSourceUrl.value="/action/prudential_applntmeans.jsp";
		document.forms[0].hidBeanId.value="npacommon";
		document.forms[0].hidBeanGetMethod.value="getBorrowerDetails";
		document.forms[0].hidBeanMethod.value="updateBorrwerDetails";
		document.forms[0].action=appURL +"controllerservlet";
		document.forms[0].submit(); 		
	}	
}

function doSave()
{
	if(document.forms[0].sel_type_applicant.value=="0")
	{
		ShowAlert('111','Type of Applicant');
		return;
	}
	if(document.forms[0].txt_present_means.value=="")
	{
		alert("Enter the Means - Present Position");
		document.forms[0].txt_present_means.focus();
		return;
	}
	if(document.forms[0].txt_present_date.value=="")
	{
		alert("Enter the Date - Present Position");
		document.forms[0].txt_present_date.focus();
		return;
	}
		document.forms[0].hidAppType.value = document.forms[0].sel_type_applicant[document.forms[0].sel_type_applicant.selectedIndex].text;
		document.forms[0].hidSourceUrl.value="/action/prudential_applntmeans.jsp";
		document.forms[0].hidBeanId.value="npacommon";
		document.forms[0].hidBeanMethod.value="updateBorrwerDetails";
		document.forms[0].hidBeanGetMethod.value="getBorrowerDetails";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
}


function callLink(page,bean,method)
	{
	if (document.forms[0].cmdsave.disabled)
			{
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

function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].hidSourceUrl.value="/action/prudential_applntmeans.jsp";
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
		if(document.forms[0].elements[i].type=='radio')
	 	{
			document.forms[0].elements[i].disabled=!val;
		}		  
		 
	}
	
	
}
function onLoading()
{
		//disableCommandButtons("load");
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

</script>
</head>
<body onload="onLoading()">
<form name="prudential_appltmeans" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" align="left" class="outertable">
				<tr>
					<td>
						<lapstab:pwourltag pageid="4"/>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr> 
           <td class="page_flow">Home -&gt; NPA-&gt; Prudential Write Off -&gt; Promoters/ Guarantors </td>
          </tr>
        </table>

  <table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
	<tr>
		<td><lapschoice:npaapplication />
		<INPUT type="hidden" name="npa_appno" value="<%=(String)request.getParameter("npa_appno")%>" />
		</td>
	</tr>
</table>
<lapstab:npapresentpostion
	module='<%=Helper.correctNull((String)request.getParameter("hidmoduletype"))%>'
	pageid="3" /><br>
	 <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
    <tr> 
      <td >
  <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
    <tr> 
      <td colspan="5" align="center"><b>Promoters/Guarantors</b></td>
    </tr>
    <tr> 
      <td width="19%">TYPE OF APPLICANT<span class="mantatory">*&nbsp;</span>
      </td>
	  <td width="3%">&nbsp;</td>
      <td width="38%"> 
	
	 <select name="sel_type_applicant" tabindex="1">
				<option value="0">---Select-----</option>
				<%String apptype="44"; %>
				<lapschoice:StaticDataNewTag apptype='<%=apptype%>'/> 
			  </select>
      </td>
      <td width="12%">NAME OF APPLICANT</td>
      <td width="28%"> 
        <input type="text" name="txt_name_applicant" size="30"
				maxlength="25" tabindex="2" onKeyPress="notAllowSplChar()"
				value="">
      </td>
    </tr>    
    <tr> 
      <td width="19%">PRESENT ACTIVITY OF APPLICANT</td>
	  <td width="3%">&nbsp;</td>
      <td width="38%"> 
        <textarea rows="3" name="txt_present_activity" cols="35" tabindex="3"  onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%//=Helper.correctNull((String)hshValues.get("complaint_received"))%></textarea>
      </td>
      <td width="12%">&nbsp;</td>
      <td width="28%">&nbsp; </td>
    </tr>
    <tr> 
      <td colspan="4"><b>AT THE TIME OF RENEWAL </b></td>
    </tr>
    <tr> 
      <td width="19%">MEANS</td>
	  <td width="3%"><b><%=ApplicationParams.getCurrency()%></b></td>
      <td width="38%"> <lapschoice:CurrencyTag name="txt_renew_means" size="16"
				maxlength="12" tabindex="4" 
				value=''/> </td>
      <td width="12%">DATE</td>
      <td width="28%"> 
        <table width="25%" class="outertable">
          <tr> 
            <td> 
              <input type="text" name="txt_renew_date" size="12"
				maxlength="10" tabindex="5" 
				value="" onBlur="checkDate(this);checkmaxdate(this,'<%=Helper.getCurrentDateTime()%>')">
            </td>
            <td> <a href="#" onClick="callCalender('txt_renew_date')"
				title="Click to view calender" border=0><img src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
				width="0" border="0" tabindex="5"></a> </td>
          </tr>
        </table>
      </td>
    </tr>
    <tr> 
      <td width="19%" ><b>PRESENT POSITION</b></td>
	  <td width="3%">&nbsp;</td>
      <td width="38%" >&nbsp; </td>
      <td width="12%" >&nbsp;</td>
      <td width="28%" >&nbsp; </td>
    </tr>
    <tr> 
      <td width="19%" > MEANS <span class="mantatory">*&nbsp;</span>
      </td>
	  <td width="3%"><b><%=ApplicationParams.getCurrency()%></b></td>
      <td width="38%" > <lapschoice:CurrencyTag name="txt_present_means" size="16"
				maxlength="12" tabindex="6" 
				value='' /> </td>
      <td width="12%" > DATE<span class="mantatory">*&nbsp;</span>
      </td>
      <td width="28%" > 
        <table width="25%" class="outertable">
          <tr> 
            <td> 
              <input type="text" name="txt_present_date" size="12"
				maxlength="10" tabindex="7" 
				value="" onBlur="checkDate(this);checkmaxdate(this,'<%=Helper.getCurrentDateTime()%>')" >
            </td>
            <td> <a href="#" onClick="callCalender('txt_present_date')"
				title="Click to view calender" border=0><img src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
				width="0" border="0" tabindex="7"></a> </td>
          </tr>
        </table>
    </tr>
    <tr> 
      <td width="19%">&nbsp;</td>
	  <td width="3%">&nbsp;</td>
      <td width="38%">&nbsp; </td>
      <td width="12%">&nbsp;</td>
      <td width="28%">&nbsp;</td>
    </tr>
  </table>
  </td>
  </tr>
  </table>
  <br>
   <lapschoice:combuttonnew btnnames="New_Edit_Save_Cancel_Delete_Audit Trial"
	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'	 /> 
	<br>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
  <tr align="center"> 
    <td colspan="2">
        <table width="100%" border="0" cellspacing="3" cellpadding="0" class="outertable" align="center">
          <tr> 
            <td valign="top"> 
              <div align="left"> 
                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable linebor">
                  <tr class="dataheader"> 
                    <td width="3%" >&nbsp;</td>
                    <td width="17%" align="center">&nbsp;</td>
                    <td width="20%" align="center">&nbsp;</td>
                    <td colspan="2" align="center"><b>AT THE 
                      TIME OF RENEWAL</b></td>
                    <td  align="center" colspan="2"><b>PRESENT 
                      POSITION</b></td>
                  </tr>
                  <tr class="dataheader"> 
                    <td width="3%" >&nbsp;</td>
                    <td width="17%"  align="center"><b>TYPE OF APPLICANT</b></td>
                    <td width="20%" align="center"><b>NAME OF APPLICANT</b></td>
                      <td width="15%"  align="center"><b>MEANS (RS.)</b></td>
                      <td width="16%"  align="center"><b>DATE</b></td>
                      <td width="13%"  align="center"><b>MEANS (RS.) </b></td>
                      <td width="16%"  align="center"><b>DATE</b></td>
                  </tr>
                  <%
                     
                  vecRow=(ArrayList)hshValues.get("vecRow");
					if(vecRow.size()>0 && vecRow!=null)
					{
						for(int i=0;i<vecRow.size();i++)
						{
						vecCol = (ArrayList)vecRow.get(i);
					%>
                  <tr class="datagrid"> 
                    <td width="3%" align=center> 
                      <input type="radio" 
													style="border:none" name="radiobutton" value="radiobutton"
													onClick="selectValues('<%=Helper.correctNull((String)vecCol.get(0))%>',
													'<%=Helper.correctNull((String)vecCol.get(1))%>',
													'<%=Helper.correctNull((String)vecCol.get(2))%>',
													'<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol.get(4))))%>',
                            						'<%=Helper.correctNull((String)vecCol.get(5))%>',
                            						'<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol.get(6))))%>',
                            						'<%=Helper.correctNull((String)vecCol.get(7))%>',
                            						'<%=i%>','<%=vecRow.size()%>')">
                            	<input type="hidden" name="hidpresent_activity" value="<%=Helper.correctNull((String)vecCol.get(3))%>">
                      </td>
                   
                    <td width="17%">&nbsp;<%=Helper.correctNull((String)vecCol.get(11))%></td>
                    <td width="20%">&nbsp;<%=Helper.correctNull((String)vecCol.get(2))%></td>
                    <td width="15%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol.get(4))))%></td>
                    <td width="16%" align="center">&nbsp;<%=Helper.correctNull((String)vecCol.get(5))%></td>
                    <td width="13%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol.get(6))))%></td>
                    <td width="16%" align="center">&nbsp;<%=Helper.correctNull((String)vecCol.get(7))%></td>
                  </tr>
                  <%
					 }
					 }
				  	else
                	{
               %>
                  <tr class="datagrid"> 
                    <td align="center" colspan="9">No 
                      Data Found</td>
                  </tr>
                  <%
                	}
                %>
                </table>
            </td>
          </tr>
        </table>
    </td>
  </tr>
  </table>
<lapschoice:hiddentag pageid='<%=PageId%>'/> 
  <input type="hidden" name="hid_strsno" value="<%=Helper.correctNull((String)hshValues.get("PRE_SNO"))%>"/>
  <input type="hidden" name="hidclaimsettled" value="<%=Helper.correctNull((String)request.getParameter("hidclaimsettled"))%>"/>
  <input type="hidden" name="hidAppType">
</form>
</body>
</html>