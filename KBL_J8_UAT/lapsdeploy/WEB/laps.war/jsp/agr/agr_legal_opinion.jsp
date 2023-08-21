<%@include file = "../share/directives.jsp"%>
<%ArrayList arryRow = (ArrayList) hshValues.get("arrRow");
  ArrayList arrCol = new ArrayList();
			
%>
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/agr/agr_legal_opinion.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var editlockflag="<%=hshValues.get("editlock")%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var editflag = 1;
var appURL  ="<%=ApplicationParams.getAppUrl()%>"; 
var branchpanel="<%=Helper.correctNull((String)hshValues.get("branch_panel"))%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
var application_receivedate="<%=Helper.correctNull((String)hshValues.get("application_receivedate"))%>";
function doClose()
	{	
	var con=ConfirmMsg('100');
	if(con)
	{	
		document.forms[0].target="_parent";
		document.forms[0].action=appURL+"action/retailpge.jsp";				
		document.forms[0].submit();
		
	}
}
function selLawyerNme()
{
	if(document.forms[0].sel_branchpanel.value=="Y")
	{	
		//document.all.b1.style.visibility="visible";
		document.forms[0].TxtLawDet.readOnly=true;
		document.forms[0].TxtDesign.readOnly=true;		
	}
	else if(document.forms[0].sel_branchpanel.value=="N")
	{
		//document.all.b1.style.visibility="hidden";
		document.forms[0].TxtLawDet.readOnly=false;
		document.forms[0].TxtDesign.readOnly=false;
	}
}


function comparedate(date1,date2)
{	
	var pgdt=changeDateformat(date1);
	var maxdt=changeDateformat(date2);
		if(pgdt.value!="")
		{
			if(Date.parse(pgdt) > Date.parse(maxdt))
			{
				alert("Date of Entry cannot be lesser than Application Received Date");
				document.forms[0].TxtEntryDt.value="";
				document.forms[0].TxtEntryDt.focus();								
			}			
		}
}

function comparedate1(date1,date2)
{	
	var pgdt=changeDateformat(date1);
	var maxdt=changeDateformat(date2);
		if(pgdt.value!="")
		{
			if(Date.parse(pgdt) > Date.parse(maxdt))
			{
				alert("Date Sent cannot be lesser than Date of Entry");
				document.forms[0].TxtsentDt.value="";
				document.forms[0].TxtsentDt.focus();								
			}			
		}
}


function comparedate2(date1,date2)
{	
	var pgdt=changeDateformat(date1);
	var maxdt=changeDateformat(date2);
		if(pgdt.value!="")
		{
			if(Date.parse(pgdt) > Date.parse(maxdt))
			{
				alert("Date Received cannot be lesser than Date Sent");
				document.forms[0].TxtRecdDt.value="";
				document.forms[0].TxtRecdDt.focus();								
			}			
		}
}
function comparedate3(date1,date2)
{	
	var pgdt=changeDateformat(date1);
	var maxdt=changeDateformat(date2);
		if(pgdt.value!="")
		{
			if(Date.parse(pgdt) > Date.parse(maxdt))
			{
				alert("Search Report Date cannot be lesser than Date Sent");
				document.forms[0].TxtSearchDt.value="";
				document.forms[0].TxtSearchDt.focus();								
			}			
		}
}


</script>
</head>
<body onload="callLoading()">
<form name="fininc" method="post" class="normal">
  <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
     <tr> 
     <td valign="top"> 
      <table width="80%" border="0" cellspacing="0" cellpadding="3" class="outertable border1" align="center">
        <tr> 
         <td valign="top"> 
          <table width="93%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
                <tr> 
                  <td colspan="5"><b>Legal Opinion</b></td>
                </tr>
                <tr> 
                  <td width="8%" nowrap>Date of Entry</td>
                  <td width="40%"> 
                    <table border="0" cellspacing="0" cellpadding="3" class="outertable">
                      <tr> 
                        <td> 
                          <input type="text" name="TxtEntryDt" size="11"
													maxlength="10" tabindex="1"
													onBlur="checkDate(this);checkmaxdate(this,currentDate);comparedate(application_receivedate,document.forms[0].TxtEntryDt.value)"
													value="<%=Helper.correctNull((String)hshValues.get("entry_date"))%>">
                        <td colspan="2"><a href="#"
													onClick="callCalender('TxtEntryDt')"
													title="Click to view calender" border=0><img
													src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
													width="0" border="0" tabindex="2"></a></td>
                      </tr>
                    </table>
                  </td>
                  <td width="11%">Date Sent<b class="mantatory">*</b></td>
                  <td width="35%"> 
                    <table border="0" cellspacing="0" cellpadding="3" class="outertable">
                      <tr> 
                        <td> 
                          <input type="text" name="TxtsentDt" size="11"
													maxlength="10" tabindex="3"
													onBlur="checkDate(this);checkmaxdate(this,currentDate);comparedate1(document.forms[0].TxtEntryDt.value,document.forms[0].TxtsentDt.value)"
													value="<%=Helper.correctNull((String)hshValues.get("Send_date"))%>">
                        <td colspan="2"><a href="#"
													onClick="callCalender('TxtsentDt')"
													title="Click to view calender" border=0><img
													src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
													width="0" border="0" tabindex="4"></a></td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr> 
                  <td width="8%" nowrap>Date received</td>
                  <td width="40%"> 
                    <table border="0" cellspacing="0" cellpadding="3">
                      <tr> 
                        <td> 
                          <input type="text" name="TxtRecdDt" size="11"
													maxlength="10" tabindex="5"
													onBlur="checkDate(this);checkmaxdate(this,currentDate);comparedate2(document.forms[0].TxtsentDt.value,document.forms[0].TxtRecdDt.value)"
													value="<%=Helper.correctNull((String)hshValues.get("Recd_date"))%>">
                          <%out.println(Helper.correctNull((String)hshValues.get("Recd_date"))); %>
                        <td colspan="2"><a href="#"
													onClick="callCalender('TxtRecdDt')"
													title="Click to view calender" border=0><img
													src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
													width="0" border="0" tabindex="6"></a></td>
                      </tr>
                    </table>
                  </td>
                  <!--prakash-->
                  <td width="11%"nowrap>Search Report Date</td>
                  <td width="35%"> 
                    <input type="text" name="TxtSearchDt" size="11" maxlength="10"
                                onBlur="checkDate(this);checkmaxdate(this,currentDate);comparedate3(document.forms[0].TxtsentDt.value,document.forms[0].TxtSearchDt.value)"
                                value="<%=Helper.correctNull((String)hshValues.get("search_date"))%>" tabindex="7">
                    <a href="#"
													onClick="callCalender('TxtSearchDt')"
													title="Click to view calender" border=0><img
													src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
													width="0" border="0" tabindex="8"></a> 
                  </td>
                  <!--prakash-->
                </tr>
                <tr> 
                  <td nowrap="nowrap" width="8%"> 
                    <div align="left">Ref.No. 
                      </div>
                  </td>
                  <td width="30%"> 
                    <input type="text" name="TxtRefNo"
											size="38" maxlength="20" tabindex="9"
											value="<%=Helper.correctNull((String)hshValues.get("ref_no"))%>"
											onKeyPress="notAllowedDouble()">
                  
                  <td width="11%">Dated</td>
                  <td valign="top" width="35%"> 
                    <table border="0" cellspacing="0" cellpadding="3" class="outertable">
                      <tr> 
                        <td> 
                          <input type="text"
													name="TxtRefDt" size="11" maxlength="10" tabindex="10"
													onBlur="checkDate(this);checkmaxdate(this,currentDate)"
													value="<%=Helper.correctNull((String)hshValues.get("ref_date"))%>">
                        <td colspan="2"><a href="#"
													onClick="callCalender('TxtRefDt')"
													title="Click to view calender" border=0><img
													src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
													width="0" border="0" tabindex="11"></a></td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr> 
                  <td nowrap="nowrap">Whether on the branch panel?</td>
                  <td nowrap width="40%"> 
                    <select name="sel_branchpanel" tabindex="12" onChange="selLawyerNme()">
                      <option value="Y" selected>Yes</option>
                      <option value="N">No</option>
                    </select>
                    </td>
                  <td width="11%">&nbsp;</td>
                  <td valign="top" width="35%">&nbsp;</td>
                </tr>
                <tr> 
                  <td width="8%" nowrap>Lawyer Name <b class="mantatory">*</b></td>
                  <td width="40%" valign="top"> 
                    <input type="hidden" name="hid_sno" size="38" maxlength="50">
                    <input type="text" name="TxtLawDet" size="38" maxlength="50" tabindex="13" readonly="readonly">
                    <span onClick="javascript:callsupnam()"
						style="cursor:hand"><b><img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0" tabindex="14"></b></span></td>
                  <td valign="top" colspan="2"> 
                  <input type="hidden" name="TxtDesign" size="25" maxlength="10" tabindex="12" readonly="readonly"> 
                    </td>
                </tr>
                <tr> 
                  <td nowrap="nowrap">Whether legal opinion Indicated clear/marketable title </td>
                  <td nowrap="nowrap" width="40%"> 
                    <select name="LegOpFl" tabindex="15">
                      <option value="Y" selected>Yes</option>
                      <option value="N">No</option>
                    </select>
                    </td>
                  <td colspan="2" nowrap >Whether Valid mortgage can be created in favour of our bank 
                    <select name="MortFl" tabindex="16">
                      <option value="Y" selected="selected">Yes</option>
                      <option value="N">No</option>
                    </select>
                    </td>
                </tr>
                <tr> 
                  <td nowrap width="8%">Conditions</td>
                  <td valign="top" width="40%"> 
                    <textarea name="TxtCond" tabindex="17"
											cols="42" rows="4" onKeyPress="notAllowSingleAndDoubleQuote()"><%=Helper.correctNull((String)hshValues.get("conditions"))%></textarea>
                  </td>
                  <td width="11%">Remarks</td>
                  <td valign="top" width="35%"> 
                    <textarea name="TxtRemark" tabindex="18" cols="42"
											rows="4" onKeyPress="notAllowSingleAndDoubleQuote();textlimit(this,299)" onKeyUp="textlimit(this,299)" onKeyUp="textlimit(this,299)"><%=Helper.correctNull((String)hshValues.get("remarks"))%></textarea>
                  </td>
                </tr>
                <tr> 
                 
                  <td nowrap width="8%" > 
                    Past 30 Year's <br>
                    Search Report  </td>
                  <td nowrap="nowrap" width="40%"> 
                    <textarea name="TxtPast" tabindex="19"
											cols="42" rows="4" onKeyPress="notAllowSingleAndDoubleQuote();textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("past_details"))%>"></textarea>
                  </td>
                  <td nowrap width="11%">&nbsp;</td>
                  <td nowrap width="35%">&nbsp;</td>
                 
                </tr>
              </table>
             </table>
     <br>               
	<lapschoice:combuttonnew btnnames="New_Edit_Save_Cancel_Delete_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
    <br>
                <tr> 
                  <td> 
                    <table width="98.3%" border="0" cellspacing="1" cellpadding="5" class="outertable">
                      <tr class="dataheader"> 
                        <td width="5%"><b></b></td>
                        <td width="12%" align="center" nowrap><b>Opinion By </b></td>
                        <td width="10%" align="center" nowrap><b>Date Sent</b></td>
                        <td width="15%" align="center" nowrap><b>Date Received</b></td>
                        <td width="13%" align="center" nowrap><b>Date of Entry</b></td>
                        <td width="9%" align="center"><b>Opinion Ref. No </b></td>
                        <td width="17%" align="center"><b>Opinion Date</b></td>
                      </tr>
                      <%if (arryRow.size() > 0) {
				for (int i = 0; i < arryRow.size(); i++) {
					arrCol = (ArrayList) arryRow.get(i);
					
					%>
                      <tr class="datagrid"> 
                        <td width="5%"> 
                          <input type="radio" name="lopra" value="<%=arrCol.get(0)%>" style="border-style:NONE"
									onClick="selApplicant('<%=arrCol.get(0)%>', '<%=arrCol.get(1)%>','<%=arrCol.get(2)%>','<%=arrCol.get(3)%>','<%=arrCol.get(4)%>','<%=arrCol.get(5)%>','<%=arrCol.get(6)%>','<%=Helper.replaceForJavaScriptString(Helper.correctNull((String)arrCol.get(7)))%>','<%=Helper.replaceForJavaScriptString(Helper.correctNull((String)arrCol.get(8)))%>','<%=Helper.replaceForJavaScriptString(Helper.correctNull((String)arrCol.get(9)))%>', '<%=arrCol.get(10)%>', '<%=arrCol.get(11)%>','<%=arrCol.get(12)%>','<%=arrCol.get(13)%>','<%=Helper.replaceForJavaScriptString(Helper.correctNull((String)arrCol.get(14)))%>','<%=arrCol.get(15)%>','<%=arrCol.get(16)%>')">
                        </td>
                       <td width="12%"> 
                          <input type="hidden" name="loplaw" value="<%=arrCol.get(15)%>"><%=arrCol.get(15)%></td>
                        <td width="10%">&nbsp; 
                          <input type="hidden" name="lopsentdt" value="<%=arrCol.get(10)%>"><%=arrCol.get(10)%></td>
                        <td width="15%">&nbsp; 
                           <input type="hidden" name="loprecddt" value="<%=arrCol.get(11)%>"><%=arrCol.get(11)%></td>
                        <td width="13%">&nbsp; 
                          <input type="hidden" name="lopentrydt" value="<%=arrCol.get(2)%>"><%=arrCol.get(2)%></td>
                        <td width="9%">&nbsp; 
                          <input type="hidden" name="loprefno" value="<%=arrCol.get(3)%>"><%=arrCol.get(3)%></td>
                        <td width="17%">&nbsp; 
                          <input type="hidden" name="loprefdt" value="<%=arrCol.get(4)%>"><%=arrCol.get(4)%></td>
                      </tr>
                      <%}
			} else {
			}
			%>
                    </table>
                  </td>
                </tr>
                <tr> 
                  <td></td>
                </tr>
              </table>
  <br>

  <input type="hidden" name="id" value="">
  <input type="hidden" name="selapptype" value='a<%=request.getParameter("hidapplicantid")%>'>
  <input type="hidden" name="hidFlagAgr" value="Agr">	
  <input type="hidden" name="hidsno"/>
  <lapschoice:agrihiddentag pageid="<%=PageId%>"/>
</form>
</body>
</html>
