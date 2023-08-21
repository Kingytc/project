<%@include file="../share/directives.jsp"%>
<%
	String strDesc=request.getParameter("hiddesc");
    String strBorrowerType =Helper.correctNull((String)request.getParameter("hidBorrowerType"));
    String strcat="";
    if(!strCategoryType.equalsIgnoreCase(""))
    {
    	if(strCategoryType.equalsIgnoreCase("OPS"))
    	{
    		strcat="Tertiary";
    	}
    	else 
    	{
    		strcat="Corporate";
    	}    		
    }%>
<html>
<head>
<title>Small Scale Industries</title>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var path = "<%=ApplicationParams.getAppUrl()%>";
var varDesc = "<%=strDesc%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
var currdate="<%=Helper.getCurrentDateTime()%>";
var selid;
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varRecordflag = "<%=Helper.correctNull((String)hshValues.get("recordflag"))%>";
</script>
<script language="javascript" >
 function callCalender(fldname)
 {
	  if(document.forms[0].cmdsave.disabled==false)
	 {	
		showCal(path,fldname);
	 }
 }
  function whileLoading()
{	
		if(document.forms[0].type="text")
		{
			for(var i=0;i< 32;i++)
			{
			document.forms[0].elements[i].readOnly=true;
			}
		}	
}
function doCancel()
{
if (ConfirmMsg(102))
	{document.forms[0].submit();
	}
}
function enableButtons(bool1,bool2,bool3,bool4,bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;	
	document.forms[0].cmdclose.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool5;
}
function doClose()
{
	if(ConfirmMsg(100))
	{ 
		document.forms[0].action=appUrl+"action/agrpage.jsp";
		document.forms[0].submit();
	}
}
function doSave()
{				
	document.forms[0].hidRecordflag.value=varRecordflag;
	document.forms[0].hidBeanGetMethod.value="updateData";
	document.forms[0].hidBeanId.value="Ssi_schdu";
	document.forms[0].action=appURL+"action/Ssi_schdu.jsp";	
	document.forms[0].submit();
}
function doEdit()
{	
	if(document.forms[0].type="text")
	{
		for(var i=0;i< 32;i++)
		{
		document.forms[0].elements[i].readOnly=false;
		}
		enableButtons(true,false,false,true,false);
	}
}
function doDelete()
{				
	if(varRecordflag== "Y")
	{
	if(ConfirmMsg('101'))
	{
		document.forms[0].hidAction.value="Delete";
		//document.forms[0].hidBeanMethod.value="";
		document.forms[0].hidBeanGetMethod.value="updateData";	
		document.forms[0].hidBeanId.value="Ssi_schdu";
		document.forms[0].action=appURL+"action/Ssi_schdu.jsp";	
		document.forms[0].submit();
	}
	}
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
</head>
<body onload="whileLoading()" >
<form name="fininc" method="post" class="normal">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <td> 
        <jsp:include page="../share/applurllinkscom.jsp" flush="true">
        <jsp:param name="pageid" value="20" />
		<jsp:param name="cattype" value="<%=strCategoryType%>" />
	    <jsp:param name="ssitype" value="<%=strSSIType%>" />
        </jsp:include>
      </td>
    </tr>
    <tr> 
            <td class="page_flow">Home -&gt;<%=strcat %>-&gt;  Application-&gt; Cost &amp; Means   -&gt;Schedule of Implementation</td>
          </tr>
	</table>
  <span style="display:none"><lapschoice:borrowertype /></span> <lapschoice:application/> 
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <td valign="top"> 
        <table width="70%" border="0" cellspacing="1" cellpadding="3" class="outertable">
          <tr align="center"> 
            <td class="sub_tab_inactive"><b><a href="javascript:callFunction('ssi_above10_costofprojectincurred.jsp','getCostofProject','LAND^BULIDING^INDIGENOUSPLANTMC^IMPORTEDPLANTMC^TOOLSSPARES^TESTEQUIPMENTS^MISCFIXEDASSETS^INSTALLATIONCHRG^PRELIMEXPEMSES^PREOPTEXPENSES^BUILDINGCONTINGENCIES^PLANTMACHCONTINGENCIES^FIXEDASSETSCONTINGENCIES^MARGINWCREQ','getCostofProject')"> 
                Cost of Project </a></b>
            </td>
            <td class="sub_tab_inactive"><b><a href="javascript:callFunction('ssi_above10_accrualsexpenditure.jsp','getGeneralDetails','InternalAccruals^FinanceOfExpenditureIncurred^PromotersPercentToTheProject','AccrualsExpenditure')">Accruals 
                </a></b>
            </td>
            <td class="sub_tab_inactive"><b><a href="javascript:callFunction('ssi_above10_meansoffinancing.jsp','getCostofProject','CAPITAL^RESERVES^TERMLOANS^UNSECUREDLOANS^DEFERREDPAYMENTS^SUBSIDYGOVT^SEEDCAPITAL^INTERNALCASHACCRUALS^OTHERSOURCES','MeansOfFinancing')">Means 
                of Financing </a> </b>
            </td>
            <td class="sub_tab_active"><b>Schedule of Implementation </b></td>
          </tr>
        </table>
      </td>
    </tr>
  </table><br>
  <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
    <tr> 
      <td valign="top"> 
        <table width="100%" border="1" cellspacing="0" cellpadding="0" class="outertable">
          <tr> 
            <td valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
                <tr> 
                  <td> 
                    <table width="100%" border="0" cellspacing="1" cellpadding="2" class="outertable">
                      <tr class="dataheader"> 
                        <td colspan="7">(Please 
                          indicate the progress made so far in the implementation 
                          of the project and furnish the schedule of implementation 
                          as follows:)</td>
                      </tr>
                      <tr class="dataheader"> 
                        <td align="center" width="4%">S.No</td>
                        <td align="center" width="37%">Particulars</td>
                        <td align="center" colspan="2">Date 
                          of Commencement</td>
                        <td width="6%" align="center"></td>
                        <td width="23%" align="center">Expected 
                          Date of Completion</td>
                        <td width="5%" align="center"></td>
                      </tr>
                      <tr class="datagrid"> 
                        <td align="center" width="4%">1.</td>
                        <td width="37%">Acquisition 
                          of Land</td>
                        <td align="center" colspan="2"> 
                          <input type="text" name="text11" size="15"
						   onBlur="checkDate(this)" value="<%=Helper.correctNull((String)hshValues.get("text11")) %>">
                        </td>
                        <td width="6%" align="center"><a alt="Select date from calender"  href="#" onClick="callCalender('text11')" onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"  border="0" alt="Select date from calender"></a></td>
                        <td width="23%" align="center"> 
                          <input type="text" name="text12" size="15"
						   onBlur="checkDate(this);checkmindate(this,currdate)" value="<%=Helper.correctNull((String)hshValues.get("text12")) %>">
                        </td>
                        <td width="5%" align="center"><a alt="Select date from calender"  href="#" onClick="callCalender('text12')" onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"  border="0" alt="Select date from calender"></a></td>
                      </tr>
                      <tr class="datagrid"> 
                        <td align="center" width="4%">2.</td>
                        <td width="37%">Development 
                          of Land</td>
                        <td align="center" colspan="2"> 
                          <input type="text" name="text21" size="15"
						   onBlur="checkDate(this)" value="<%=Helper.correctNull((String)hshValues.get("text21")) %>">
                        </td>
                        <td width="6%" align="center"><a alt="Select date from calender"  href="#" onClick="callCalender('text21')" onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"  border="0" alt="Select date from calender"></a></td>
                        <td width="23%" align="center"> 
                          <input type="text" name="text22" size="15"
						   onBlur="checkDate(this);checkmindate(this,currdate)" value="<%=Helper.correctNull((String)hshValues.get("text22")) %>">
                        </td>
                        <td width="5%" align="center"><a alt="Select date from calender"  href="#" onClick="callCalender('text22')" onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"  border="0" alt="Select date from calender"></a></td>
                      </tr>
                      <tr class="datagrid"> 
                        <td align="center" width="4%">3.</td>
                        <td width="37%">Civil 
                          works for Factory Building Machinery Foundation Administrative 
                          Building </td>
                        <td align="center" colspan="2"> 
                          <input type="text" name="text31" size="15"
						   onBlur="checkDate(this)" value="<%=Helper.correctNull((String)hshValues.get("text31")) %>">
                        </td>
                        <td width="6%" align="center"><a alt="Select date from calender"  href="#" onClick="callCalender('text31')" onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"  border="0" alt="Select date from calender"></a></td>
                        <td width="23%" align="center"> 
                          <input type="text" name="text32" size="15"
						   onBlur="checkDate(this);checkmindate(this,currdate)" value="<%=Helper.correctNull((String)hshValues.get("text32")) %>">
                        </td>
                        <td width="5%" align="center"><a alt="Select date from calender"  href="#" onClick="callCalender('text32')" onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"  border="0" alt="Select date from calender"></a></td>
                      </tr>
                      <tr class="datagrid"> 
                        <td align="center" width="4%">4.</td>
                        <td width="37%">Plant 
                          &amp; Machinery Imported Indigenous</td>
                        <td align="center" colspan="2"> 
                          <input type="text" name="text41" size="15"
						   onBlur="checkDate(this)" value="<%=Helper.correctNull((String)hshValues.get("text41")) %>">
                        </td>
                        <td width="6%" align="center"><a alt="Select date from calender"  href="#" onClick="callCalender('text41')" onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"  border="0" alt="Select date from calender"></a></td>
                        <td width="23%" align="center"> 
                          <input type="text" name="text42" size="15"
						   onBlur="checkDate(this);checkmindate(this,currdate)" value="<%=Helper.correctNull((String)hshValues.get("text42")) %>">
                        </td>
                        <td width="5%" align="center"><a alt="Select date from calender"  href="#" onClick="callCalender('text42')" onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"  border="0" alt="Select date from calender"></a></td>
                      </tr>
                      <tr class="datagrid"> 
                        <td align="center" width="4%">5.</td>
                        <td width="37%">Arrangement 
                          for power</td>
                        <td align="center" colspan="2"> 
                          <input type="text" name="text51" size="15"
						   onBlur="checkDate(this)" value="<%=Helper.correctNull((String)hshValues.get("text51")) %>">
                        </td>
                        <td width="6%" align="center"><a alt="Select date from calender"  href="#" onClick="callCalender('text51')" onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"  border="0" alt="Select date from calender"></a></td>
                        <td width="23%" align="center"> 
                          <input type="text" name="text52" size="15"
						   onBlur="checkDate(this);checkmindate(this,currdate)" value="<%=Helper.correctNull((String)hshValues.get("text52")) %>">
                        </td>
                        <td width="5%" align="center"><a alt="Select date from calender"  href="#" onClick="callCalender('text52')" onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"  border="0" alt="Select date from calender"></a></td>
                      </tr>
                      <tr class="datagrid"> 
                        <td align="center" width="4%">6.</td>
                        <td width="37%">Arrangement 
                          for water</td>
                        <td align="center" colspan="2"> 
                          <input type="text" name="text61" size="15"
						   onBlur="checkDate(this)" value="<%=Helper.correctNull((String)hshValues.get("text61")) %>">
                        </td>
                        <td width="6%" align="center"><a alt="Select date from calender"  href="#" onClick="callCalender('text61')" onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"  border="0" alt="Select date from calender"></a></td>
                        <td width="23%" align="center"> 
                          <input type="text" name="text62" size="15"
						   onBlur="checkDate(this);checkmindate(this,currdate)" value="<%=Helper.correctNull((String)hshValues.get("text62")) %>">
                        </td>
                        <td width="5%" align="center"><a alt="Select date from calender"  href="#" onClick="callCalender('text62')" onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"  border="0" alt="Select date from calender"></a></td>
                      </tr>
                      <tr class="datagrid"> 
                        <td align="center" width="4%">7.</td>
                        <td width="37%">Erection 
                          of equipment</td>
                        <td align="center" colspan="2"> 
                          <input type="text" name="text71" size="15"
						   onBlur="checkDate(this)" value="<%=Helper.correctNull((String)hshValues.get("text71")) %>">
                        </td>
                        <td width="6%" align="center"><a alt="Select date from calender"  href="#" onClick="callCalender('text71')" onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"  border="0" alt="Select date from calender"></a></td>
                        <td width="23%" align="center"> 
                          <input type="text" name="text72" size="15"
						   onBlur="checkDate(this);checkmindate(this,currdate)" value="<%=Helper.correctNull((String)hshValues.get("text72")) %>">
                        </td>
                        <td width="5%" align="center"><a alt="Select date from calender"  href="#" onClick="callCalender('text72')" onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"  border="0" alt="Select date from calender"></a></td>
                      </tr>
                      <tr class="datagrid"> 
                        <td align="center" width="4%">8.</td>
                        <td width="37%">Commissioning</td>
                        <td align="center" colspan="2"> 
                          <input type="text" name="text81" size="15"
						   onBlur="checkDate(this)" value="<%=Helper.correctNull((String)hshValues.get("text81")) %>">
                        </td>
                        <td width="6%" align="center"><a alt="Select date from calender"  href="#" onClick="callCalender('text81')" onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"  border="0" alt="Select date from calender"></a></td>
                        <td width="23%" align="center"> 
                          <input type="text" name="text82" size="15"
						   onBlur="checkDate(this);checkmindate(this,currdate)" value="<%=Helper.correctNull((String)hshValues.get("text82")) %>">
                        </td>
                        <td width="5%" align="center"><a alt="Select date from calender"  href="#" onClick="callCalender('text82')" onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"  border="0" alt="Select date from calender"></a></td>
                      </tr>
                      <tr class="datagrid"> 
                        <td align="center" width="4%">9.</td>
                        <td width="37%">Initial 
                          Procurement of Raw Material</td>
                        <td align="center" colspan="2"> 
                          <input type="text" name="text91" size="15"
						   onBlur="checkDate(this)" value="<%=Helper.correctNull((String)hshValues.get("text91")) %>">
                        </td>
                        <td width="6%" align="center"><a alt="Select date from calender"  href="#" onClick="callCalender('text91')" onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"  border="0" alt="Select date from calender"></a></td>
                        <td width="23%" align="center"> 
                          <input type="text" name="text92" size="15"
						   onBlur="checkDate(this);checkmindate(this,currdate)" value="<%=Helper.correctNull((String)hshValues.get("text92")) %>">
                        </td>
                        <td width="5%" align="center"><a alt="Select date from calender"  href="#" onClick="callCalender('text92')" onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"  border="0" alt="Select date from calender"></a></td>
                      </tr>
                      <tr class="datagrid"> 
                        <td align="center" width="4%">10.</td>
                        <td width="37%">Trial 
                          Runs</td>
                        <td align="center" colspan="2"> 
                          <input type="text" name="text101" size="15"
						   onBlur="checkDate(this)" value="<%=Helper.correctNull((String)hshValues.get("text101")) %>">
                        </td>
                        <td width="6%" align="center"><a alt="Select date from calender"  href="#" onClick="callCalender('text101')" onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"  border="0" alt="Select date from calender"></a></td>
                        <td width="23%" align="center"> 
                          <input type="text" name="text102" size="15"
						   onBlur="checkDate(this);checkmindate(this,currdate)" value="<%=Helper.correctNull((String)hshValues.get("text102")) %>">
                        </td>
                        <td width="5%" align="center"><a alt="Select date from calender"  href="#" onClick="callCalender('text102')" onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"  border="0" alt="Select date from calender"></a></td>
                      </tr>
                      <tr class="datagrid"> 
                        <td align="center" width="4%">11.</td>
                        <td width="37%">Commercial 
                          Production </td>
                        <td align="center" colspan="2"> 
                          <input type="text" name="text111" size="15"
						   onBlur="checkDate(this)" value="<%=Helper.correctNull((String)hshValues.get("text111")) %>">
                        </td>
                        <td width="6%" align="center"><a alt="Select date from calender"  href="#" onClick="callCalender('text111')" onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"  border="0" alt="Select date from calender"></a></td>
                        <td width="23%" align="center"> 
                          <input type="text" name="text112" size="15"
						   onBlur="checkDate(this);checkmindate(this,currdate)" value="<%=Helper.correctNull((String)hshValues.get("text112")) %>">
                        </td>
                        <td width="5%" align="center"><a alt="Select date from calender"  href="#" onClick="callCalender('text112')" onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"  border="0" alt="Select date from calender"></a></td>
                      </tr>
                    </table>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
        </table>
        </td>
    </tr>
  </table>
<br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidId1" value="1">
<input type="hidden" name="hidId2" value="2">
<input type="hidden" name="hidId3" value="3">
<input type="hidden" name="hidId4" value="4">
<input type="hidden" name="hidId5" value="5">
<input type="hidden" name="hidId6" value="6">
<input type="hidden" name="hidId7" value="7">
<input type="hidden" name="hidId8" value="8">
<input type="hidden" name="hidId9" value="9">
<input type="hidden" name="hidId10" value="10">
<input type="hidden" name="hidId11" value="11">
<input type="hidden" name="hiddesc">
<input type="hidden" name="hidTotalDesc" value="">
<input type="hidden" name="hidFieldPrefix" value="">
<input type="hidden" name="otherGenTable" value="">
<!--<input type="hidden" name="hidAction" value="">-->
</form>
</body>
</html>