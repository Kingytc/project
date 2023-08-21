<%@include file="../share/directives.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Untitled Document</title>

<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var  AGR_FININSTITUTION="<%=Helper.correctNull((String)hshValues.get("AGR_FININSTITUTION"))%>";
var  AGR_OURBANK="<%=Helper.correctNull((String)hshValues.get("AGR_OURBANK"))%>";

function onloading()
{
	
  if(AGR_OURBANK!="")
	{
		document.forms[0].sel_ourbank.value=AGR_OURBANK;
		
	}
	if(AGR_FININSTITUTION!="")
	{
		document.forms[0].sel_fininstitution.value=AGR_FININSTITUTION;
		
	}
disableFields(true);
}

function enableButtons(bool1, bool2, bool3, bool4, bool5, bool6,bool7)
{
	
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool5;
	
}

function disableFields(one)
{	
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=one;
		}
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=one;		  
		}
		if(document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].disabled=one;		  
		}		
	}	
	document.forms[0].txt_year.readOnly=true;
	document.forms[0].txt_date.readOnly=true;  
	document.forms[0].txt_ceremonydate.readOnly=true;
}

function clearfields()
{
 document.forms[0].txt_patient.value="";
 document.forms[0].txt_doctor.value="";
 document.forms[0].txt_child.value="";
 document.forms[0].txt_class.value="";
 document.forms[0].txt_year.value="";
 document.forms[0].txt_school.value="";
 document.forms[0].txt_bride.value="";
 document.forms[0].txt_bridegroom.value="";
 document.forms[0].txt_place.value="";
 document.forms[0].txt_date.value="";
 document.forms[0].txt_ceremony.value="";
 document.forms[0].txt_ceremonydate.value="";
 document.forms[0].txt_deceased.value="";
 document.forms[0].txt_born.value="";
 
 
           
}



function doEdit()
{
	disableFields(false);
	document.forms[0].hidAction.value="insert";
	
	enableButtons(true, true, false, false, false,true,true);	
}

function doSave()
{
	enableButtons(true, true, true, true, true,true,false);
	document.forms[0].hidBeanId.value="agrlandholdings";
	document.forms[0].hidSourceUrl.value="/action/ConsumptionLoans.jsp";
	document.forms[0].hidBeanMethod.value="updateConsumptionloan";
	document.forms[0].hidBeanGetMethod.value="getDataConsumptionloan";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}
function doCancel() 
{

	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{ 
	    clearfields();
		document.forms[0].hidBeanGetMethod.value="getDataConsumptionloan";
		document.forms[0].hidBeanId.value="agrlandholdings";
        document.forms[0].action=appURL+"action/ConsumptionLoans.jsp";
		document.forms[0].submit();
	}
		
}

function doDelete()
{
	var varconfirm=ConfirmMsg('101');
	if(varconfirm)
	{
	document.forms[0].hidAction.value ="delete";
	document.forms[0].action=appURL+"action/ControllerServlet";		
	document.forms[0].hidBeanMethod.value="updateConsumptionloan";
	document.forms[0].hidBeanId.value="agrlandholdings";
	document.forms[0].hidSourceUrl.value="action/ConsumptionLoans.jsp";	
	document.forms[0].method="post";			
	document.forms[0].submit();	
	}
}


function doClose()
{
	if( ConfirmMsg(100))
	{
		document.forms[0].target="_parent";
		document.forms[0].action=appURL+"action/retailpge.jsp";				
		document.forms[0].submit();
	}
}

 
function callCalender(fname)
 {
 	if(document.forms[0].cmdsave.disabled!=true)
	{
	 showCal("<%=ApplicationParams.getAppUrl()%>",fname);
	 }
 }

 
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
 

<body onLoad="onloading()">
 <form name="frmpri" method="post" class="normal">
 <br/>
  <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
  <tr>
  <td> 
  <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
    <tr> 
      <td colspan="3">Whether the applicant has taken loan from any other financing 
        institution<br>
      </td>
      <td>
        <select name="sel_fininstitution" >
          <option value="1" selected >Yes</option>
          <option value="2" >No</option>
        </select>
      </td>
    </tr>
    <tr> 
      <td colspan="3">Whether he is a defaulter of our bank<br>
      </td>
      <td>
        <select name="sel_ourbank" >
          <option value="1" selected >Yes</option>
          <option value="2" >No</option>
        </select>
      </td>
    </tr>
    <tr class="dataheader"> 
      <td colspan="7"><strong>In case of medical expenses </strong></td>
    </tr>
    <tr> 
      <td colspan="2" nowrap="nowrap">Name of Patient/s </td>
      <td colspan="2"> 
        <input type="text" name="txt_patient"  value="<%=Helper.correctNull((String)hshValues.get("AGR_PATIENTNAME"))%>" size="25" maxlength="50" onKeyPress="notAllowSplChar()">
      </td>
      <td width="20%">Name of Doctor / Hospital </td>
      <td colspan="2"> 
        <input type="text" name="txt_doctor"  value="<%=Helper.correctNull((String)hshValues.get("AGR_DOCNAME"))%>" size="25" maxlength="50" onKeyPress="notAllowSplChar()">
      </td>
    </tr>
    <tr class="dataheader"> 
      <td colspan="7"><strong>In case of children`s education, state </strong></td>
    </tr>
    <tr> 
      <td colspan="2" nowrap="nowrap">Name of Child / Children</td>
      <td colspan="2">
        <input type="text" name="txt_child" value="<%=Helper.correctNull((String)hshValues.get("AGR_CHILDNAME"))%>" size="25" maxlength="50" onKeyPress="notAllowSplChar()">
      </td>
      <td width="20%">Class</td>
      <td colspan="2"> 
        <input type="text" name="txt_class"  value="<%=Helper.correctNull((String)hshValues.get("AGR_CLASS"))%>" size="20" maxlength="3" onKeyPress="notAllowSplChar()">
      </td>
    </tr>
    <tr> 
      <td colspan="2" nowrap="nowrap">Year of studying </td>
      <td width="69"> 
        <input type="text" name="txt_year"  value="<%=Helper.correctNull((String)hshValues.get("AGR_YEAROFSTUDY"))%>"  size="25" onBlur="checkDate(this)" maxlength="6">
      </td>
      <td align="left" width="206"><a alt="Select date from calender" href="#"
																	onClick="callCalender('txt_year')"
																	onMouseOver="window.status='Date Picker';return true;"
																	onMouseOut="window.status='';return true;"><img
																	src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
																	border=0 alt="Select date from calender"></a> 
      </td>
      <td width="20%">Name of the school / College </td>
      <td colspan="2"> 
        <input type="text" name="txt_school"  value="<%=Helper.correctNull((String)hshValues.get("AGR_SCHOOL"))%>" size="25" maxlength="50" onKeyPress="notAllowSplChar()">
      </td>
    </tr>
    <tr class="dataheader"> 
      <td colspan="7"><strong>In case of expenses relating to marriage ceremonies, 
        indicate</strong> </td>
    </tr>
    <tr> 
      <td width="90">Name of bride</td>
      <td colspan="3"> 
        <input type="text" name="txt_bride"  value="<%=Helper.correctNull((String)hshValues.get("AGR_BRIDENAME"))%>" size="25" maxlength="50" onKeyPress="notAllowSplChar()">
      </td>
      <td width="100">Name of Bridegroom</td>
      <td colspan="2"> 
        <input type="text" name="txt_bridegroom"  value="<%=Helper.correctNull((String)hshValues.get("AGR_BRIDEGROOMNAME"))%>" size="25" maxlength="50" onKeyPress="notAllowSplChar()">
      </td>
    </tr>
    <tr> 
      <td width="90" rowspan="2">Marriage Place </td>
      <td rowspan="2" colspan="3"> 
        <input type="text" name="txt_place"  value="<%=Helper.correctNull((String)hshValues.get("AGR_MARRPLACE"))%>"  size="25" maxlength="25" onKeyPress="notAllowSplChar()">
      </td>
      <td width="100" rowspan="2">Marriage date</td>
      <td width="140" height="60"> 
        <input type="text" name="txt_date"  value="<%=Helper.correctNull((String)hshValues.get("AGR_MARRDATE"))%>"  size="25" onBlur="checkDate(this)" maxlength="6" >
      </td>
      <td align="left" width="267"><a alt="Select date from calender" href="#"
																	onClick="callCalender('txt_date')"
																	onMouseOver="window.status='Date Picker';return true;"
																	onMouseOut="window.status='';return true;"><img
																	src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
																	border=0 alt="Select date from calender"></a> 
      </td>
    </tr>
    <tr> </tr>
    <tr class="dataheader"> 
      <td colspan="7"><strong>In case of funerals and birth and any other ceremony, 
        indicate </strong></td>
    </tr>
    <tr> 
      <td width="90">Name of the ceremony</td>
      <td colspan="3"> 
        <input type="text" name="txt_ceremony"  value="<%=Helper.correctNull((String)hshValues.get("AGE_CEREMONYNAME"))%>"  size="25" maxlength="25" onKeyPress="notAllowSplChar()">
      </td>
      <td width="100">Name of the ceremonydate</td>
      <td width="140"> 
        <input type="text" name="txt_ceremonydate"  value="<%=Helper.correctNull((String)hshValues.get("AGR_CEREMONYDATE"))%>"  size="25" onBlur="checkDate(this)" maxlength="6">
      </td>
      <td align="left" width="267"><a alt="Select date from calender" href="#"
																	onClick="callCalender('txt_ceremonydate')"
																	onMouseOver="window.status='Date Picker';return true;"
																	onMouseOut="window.status='';return true;"><img
																	src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
																	border=0 alt="Select date from calender"></a> 
      </td>
    </tr>
    <tr> 
      <td width="90">Name of the deceased</td>
      <td colspan="3"> 
        <input type="text" name="txt_deceased" size="25"  value="<%=Helper.correctNull((String)hshValues.get("AGR_DECEASED"))%>" maxlength="35" onKeyPress="notAllowSplChar()">
      </td>
      <td width="100">Name of the newly born child</td>
      <td colspan="2"> 
        <input type="text" name="txt_born"  value="<%=Helper.correctNull((String)hshValues.get("AGR_NEWBORNCHILD"))%>" size="25" maxlength="35" onKeyPress="notAllowSplChar()">
      </td>
    </tr>
  </table>
  </td>
  </tr>
 </table>
<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<lapschoice:agrihiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidAuditFlag" value="<%=Helper.correctNull((String)hshValues.get("auditFlag"))%>">
</form> 
</body>
</html>


 
