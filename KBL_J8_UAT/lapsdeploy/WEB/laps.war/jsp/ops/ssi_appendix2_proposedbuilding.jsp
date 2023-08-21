<%@include file="../share/directives.jsp"%>
<%

ArrayList vecRow = new ArrayList();
ArrayList vecCol = new ArrayList();
String strgenid="";
int vecrowsize =0;
if(hshValues.size()>0 && hshValues != null)
{
	vecRow = (ArrayList)hshValues.get("vecRow");
	vecrowsize = vecRow.size();
	if(vecrowsize>0)

	for(int i=0;i<vecrowsize;i++)
	{	vecCol =(ArrayList)vecRow.get(i);
		strgenid=strgenid+Helper.correctNull((String)vecCol.get(0))+",";
	}

	if(!strgenid.equals(""))
	{
	strgenid=strgenid.substring(0,(strgenid.length())-1);	
	}
}
else
{
	strgenid ="0";
}
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
<title>Raw Materials / Input</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="javascript"src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var curdate = "<%=Helper.getCurrentDateTime()%>";
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var genid = "<%=strgenid%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
function Help()
{
	  var varString = appUrl+"jsp/sethlp/hlp_ssiappendix2pro.jsp"
	   var title = "Documents";
		var prop = "scrollbars=no,width=600,height=450";	
		prop = prop + ",left=50,top=150";
		window.open(varString,title,prop);
}
function dayscalc(fromdt,todt)
{
	var fmonth = eval(fromdt.substring(3, 5)); 
	var fday = eval(fromdt.substring(0, 2));
	var fyear = eval(fromdt.substring(6, 10));
	var tmonth = eval(todt.substring(3, 5));
	var tday = eval(todt.substring(0, 2));
	var tyear = eval(todt.substring(6, 10));
	var totdays = (((eval(tday) + (eval(tmonth) * 30)) + (eval(tyear) * 365)) - ((eval(fday) + (eval(fmonth) * 30)) + (eval(fyear) * 365)));
	return totdays;
}
function chkdate(dat)
{
	if(dat.value.length ==  10)
	{
		var diff=0;
		diff = dayscalc(curdate,dat.value);
		if(diff < 0)
		{
			alert("Expected date of completion  should not be less than Current Date ");
			dat.value="";
	}
	}
}
function callDisable(one)
{
	for( i=1;i<=10;i++)		
	{	
		document.forms[0].elements["txt_propbuilding1"+i].readOnly=one;
		document.forms[0].elements["txt_propbuilding2"+i].readOnly=one;
		document.forms[0].elements["txt_propbuilding3"+i].readOnly=one;
		document.forms[0].elements["txt_propbuilding4"+i].readOnly=one;		
		document.forms[0].elements["txt_propbuilding5"+i].readOnly=one;
		document.forms[0].elements["txt_propbuilding6"+i].readOnly=one;
		document.forms[0].elements["txt_propbuilding7"+i].readOnly=one;
		document.forms[0].elements["txt_propbuilding8"+i].readOnly=one;	
		document.forms[0].elements["txt_propbuilding9"+i].readOnly=one;		
	}				
}
function disableControls(bcmdEdit,bcmdApply,bcmdCancel,bcmddel,bcmdClose)
{

	document.forms[0].cmdedit.disabled=bcmdEdit;
	document.forms[0].cmdsave.disabled=bcmdApply;
	document.forms[0].cmdcancel.disabled=bcmdCancel;
	document.forms[0].cmddelete.disabled=bcmddel;
	document.forms[0].cmdclose.disabled=bcmdClose;
}
function onloading()
{	
	document.forms[0].hidGenID.value=genid;
	callDisable(true);
	document.forms[0].hidTabName.value="AppendixIIProposedBuilding";
	document.forms[0].hidMethod.value="getAnnexure2ProposedBuilding";
}
function doEdit()
{
	callDisable(false);
	document.forms[0].hideditflag.value="Y";
	disableControls(true,false,false,false,true);
}
function doSave()
{	
	document.forms[0].hidBeanGetMethod.value="updateAnnexure2BuildingProposedData";
	document.forms[0].hidBeanId.value="comssiaboveten";
	document.forms[0].action=appUrl+"action/ssi_appendix2_proposedbuilding.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
}
function doDelete()
{
	document.forms[0].hidAction.value="Delete";
	if(!ConfirmMsg("101"))
    {
		return false;
	}
	document.forms[0].hidBeanId.value="comssiaboveten";
	document.forms[0].hidBeanMethod.value="updateAnnexure2BuildingProposedData";
	document.forms[0].hidSourceUrl.value="/action/ssi_appendix2_proposedbuilding.jsp";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
}
function doCancel()
{	
	if(ConfirmMsg('102'))
	{
		document.forms[0].hidMethod.value="getAnnexure2ProposedBuilding";
		document.forms[0].hidBeanId.value="comssiaboveten";
		document.forms[0].action=appUrl+"action/ssi_appendix2_proposedbuilding.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
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
//added by s.sathya moorthy

function callOtherDetails()
{
		document.forms[0].hidBeanGetMethod.value="getotherdetailsData1";
		document.forms[0].hidBeanId.value="comssiaboveten";
		document.forms[0].action=appUrl+"action/ssi_appendix2_otherdetails.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
}
function callCalender(fname)
{
 	if(document.forms[0].cmdsave.disabled==false)
 	{
		showCal("<%=ApplicationParams.getAppUrl()%>",fname);
	}
}
function callValuationEntry()
{
	document.forms[0].hidBeanGetMethod.value="getValuerEntryData";
	document.forms[0].hidBeanId.value="perpropertydetails";
	document.forms[0].action=appUrl+"action/ops_valuationentry.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
}
function callVehicleDetails()
{
	document.forms[0].hidBeanGetMethod.value="getAllVehicleDetails";
	document.forms[0].hidBeanId.value="comssiaboveten";
	document.forms[0].action=appUrl+"action/ops_vehicledetails.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
}
</script>
</head>
<body onload="onloading()">
<form method="post" name="fltintrate" class="normal">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <td> 
        <jsp:include page="../share/applurllinkscom.jsp" flush="true"> 
        <jsp:param name="pageid" value="12" />
        <jsp:param name="cattype" value="<%=strCategoryType%>" />
        <jsp:param name="ssitype" value="<%=strSSIType%>" />
        </jsp:include>
      </td>
    </tr>
     <tr> 
      <td class="page_flow">Home -&gt; <%=strcat %> -&gt; Application -&gt; Proposed / Offered Asset -&gt; Building Proposed</td>
    </tr>
  </table>
<span style="display:none"><lapschoice:borrowertype /></span> <lapschoice:application/> 
<lapschoice:ssiassestdetails tabid="3"/><br>
 <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
    <tr> 
      <td valign="top"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
          <tr> 
            <td valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                <tr> 
                  <td colspan="2"> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                      <tr> 
                        <td valign="top"> 
                          <table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable linebor">
                            <tr class="dataheader"> 
                              <td align="center" width="3%">S.No</td>
                              <td align="center" width="7%">Description of each Bldg</td>
                              <td align="center" width="7%">Type of construction </td>
                              <td align="center" colspan="3">Build up area in mtrs</td>
                              <td width="7%" align="center">Total Floor Area in sq.mt</td>
                              <td width="7%" align="center">Rate of construction per sq.mt</td>
                              <td width="7%" align="center">Estimated cost of each Bldg.</td>
                              <td width="7%" align="center">Expected date of completion</td>
                            </tr>
                            <tr class="dataheader"> 
                              <td width="3%">&nbsp;</td>
                              <td width="7%">&nbsp;</td>
                              <td width="7%"></td>
                              <td align="center" width="7%"><b>Length</b></td>
                              <td width="7%" align="center"><b>Breadth</b></td>
                              <td width="7%" align="center"><b>Avg. Height </b></td>
                              <td width="7%" align="center">&nbsp;</td>
                              <td width="7%" align="center">&nbsp;</td>
                              <td width="7%" align="center">&nbsp;</td>
                              <td width="7%" align="center">&nbsp;</td>
                            </tr>
                            <%if(hshValues.size()>0 && hshValues != null && vecrowsize >0)
					{
						vecCol =(ArrayList)vecRow.get(0);
				  		for(int i=0;i<vecrowsize;i++)
						  {
							vecCol =(ArrayList)vecRow.get(i);%>
                            <tr class="datagrid"> 
                              <td align="center" width="3%"><%=i+1%></td>
                              <td align="center" width="7%"> 
                                <input type="text" name="txt_propbuilding1<%=i+1%>" size="10" VALUE="<%=vecCol.get(1)%>" maxlength="50">
                              </td>
                              <td width="7%" align="center"> 
                                <input type="text" name="txt_propbuilding2<%=i+1%>" size="10" VALUE="<%=vecCol.get(2)%>" maxlength="50" >
                              </td>
                              <td width="7%" align="center"> 
                                <input type="text" name="txt_propbuilding3<%=i+1%>" size="10" VALUE="<%=vecCol.get(3)%>" onKeyPress ="allowDecimals(this)" onBlur="roundtxt(this)" maxlength="10">
                              </td>
                              <td width="7%" align="center"> 
                                <input type="text" name="txt_propbuilding4<%=i+1%>" size="10" value="<%=vecCol.get(4)%>" onKeyPress ="allowDecimals(this)" onBlur="roundtxt(this)" maxlength="10">
                              </td>
                              <td width="7%" align="center"> 
                                <input type="text" name="txt_propbuilding5<%=i+1%>" size="10" VALUE="<%=vecCol.get(5)%>" onKeyPress ="allowDecimals(this)" onBlur="roundtxt(this)" maxlength="10">
                              </td>
                              <td width="7%" align="center"> 
                                <input type="text" name="txt_propbuilding6<%=i+1%>" size="10" VALUE="<%=vecCol.get(6)%>" onKeyPress ="allowDecimals(this)" onBlur="roundtxt(this)" maxlength="10">
                              </td>
                              <td width="7%" align="center"> 
                                <input type="text" name="txt_propbuilding7<%=i+1%>" size="10" VALUE="<%=vecCol.get(7)%>" onKeyPress ="allowDecimals(this)" onBlur="roundtxt(this)" maxlength="10">
                              </td>
                              <td width="7%" align="center"> 
                                <input type="text" name="txt_propbuilding8<%=i+1%>" size="10" VALUE="<%=vecCol.get(8)%>" onKeyPress ="allowDecimals(this)" onBlur="roundtxt(this)" maxlength="10">
                              </td>
                              <td align="center" width="7%"> 
                                <input type="text" name="txt_propbuilding9<%=i+1%>" size="11" value="<%=vecCol.get(9)%>" maxlength="12" onBlur="checkDate(this);chkdate(this);" >
                                <a alt="Select date from calender"  href="javascript:callCalender('txt_propbuilding9<%=i+1%>')"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"></a>
                              </td>
                            </tr>
                            <%}for(int i=vecrowsize;i<10;i++){%>
                            <tr class="datagrid"> 
                              <td align="center" width="3%"><%=i+1%> 
                                </td>
                              <td align="center" width="7%"> 
                                <input type="text" name="txt_propbuilding1<%=i+1%>" size="10" maxlength="50">
                              </td>
                              <td width="7%" align="center"> 
                                <input type="text" name="txt_propbuilding2<%=i+1%>" size="10" maxlength="50">
                              </td>
                              <td width="7%" align="center"> 
                                <input type="text" name="txt_propbuilding3<%=i+1%>" size="10"  onKeyPress ="allowDecimals(this)" onBlur="roundtxt(this)" maxlength="10">
                              </td>
                              <td width="7%" align="center"> 
                                <input type="text" name="txt_propbuilding4<%=i+1%>" size="10" onKeyPress ="allowDecimals(this)" onBlur="roundtxt(this)" maxlength="10">
                              </td>
                              <td width="7%" align="center"> 
                                <input type="text" name="txt_propbuilding5<%=i+1%>" size="10" onKeyPress ="allowDecimals(this)" onBlur="roundtxt(this)" maxlength="10">
                              </td>
                              <td width="7%" align="center"> 
                                <input type="text" name="txt_propbuilding6<%=i+1%>" size="10" onKeyPress ="allowDecimals(this)" onBlur="roundtxt(this)" maxlength="10">
                              </td>
                              <td width="7%" align="center"> 
                                <input type="text" name="txt_propbuilding7<%=i+1%>" size="10" onKeyPress ="allowDecimals(this)" onBlur="roundtxt(this)" maxlength="10">
                              </td>
                              <td width="7%" align="center"> 
                                <input type="text" name="txt_propbuilding8<%=i+1%>" size="10" onKeyPress ="allowDecimals(this)" onBlur="roundtxt(this)" maxlength="10">
                              </td>
                              <td align="center" width="7%"> 
                                <input type="text" name="txt_propbuilding9<%=i+1%>" size="11" onBlur="checkDate(this);chkdate(this);" maxlength="12">
                                 <a alt="Select date from calender"  href="javascript:callCalender('txt_propbuilding9<%=i+1%>')"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"></a>
                              </td>
                            </tr>
                            <%}}else{
					  for(int i=0;i<10;i++)
					 {%>
                            <tr class="datagrid"> 
                              <td align="center" width="3%"><%=i+1%> 
                                </td>
                              <td align="center" width="7%"> 
                                <input type="text" name="txt_propbuilding1<%=i+1%>" size="10" maxlength="50">
                              </td>
                              <td width="7%" align="center"> 
                                <input type="text" name="txt_propbuilding2<%=i+1%>" size="10" maxlength="50">
                              </td>
                              <td width="7%" align="center"> 
                                <input type="text" name="txt_propbuilding3<%=i+1%>" size="10"  onKeyPress ="allowDecimals(this)" onBlur="roundtxt(this)" maxlength="10">
                              </td>
                              <td width="7%" align="center"> 
                                <input type="text" name="txt_propbuilding4<%=i+1%>" size="10" onKeyPress ="allowDecimals(this)" onBlur="roundtxt(this)" maxlength="10">
                              </td>
                              <td width="7%" align="center"> 
                                <input type="text" name="txt_propbuilding5<%=i+1%>" size="10" onKeyPress ="allowDecimals(this)" onBlur="roundtxt(this)" maxlength="10">
                              </td>
                              <td width="7%" align="center"> 
                                <input type="text" name="txt_propbuilding6<%=i+1%>" size="10" onKeyPress ="allowDecimals(this)" onBlur="roundtxt(this)" maxlength="10">
                              </td>
                              <td width="7%" align="center"> 
                                <input type="text" name="txt_propbuilding7<%=i+1%>" size="10" onKeyPress ="allowDecimals(this)" onBlur="roundtxt(this)" maxlength="10">
                              </td>
                              <td width="7%" align="center"> 
                                <input type="text" name="txt_propbuilding8<%=i+1%>" size="10" onKeyPress ="allowDecimals(this)" onBlur="roundtxt(this)" maxlength="10">
                              </td>
                              <td align="center" width="7%"> 
                                <input type="text" name="txt_propbuilding9<%=i+1%>" size="11" onBlur="checkDate(this);chkdate(this);" value="" maxlength="12">
                                 <a alt="Select date from calender"  href="javascript:callCalender('txt_propbuilding9<%=i+1%>')"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"></a>
                              </td>
                            </tr>
                            <%}}%>
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
      </td>
    </tr>
  </table>
  <br>
   <lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
   <br> 
   <lapschoice:hiddentag pageid='<%=PageId%>'/>
  <input type="hidden" name="hidTotalDesc" value="10">
  <input type="hidden" name="hidFieldPrefix" value="txt_propbuilding">
  <INPUT TYPE="hidden" NAME="hidGenID" VALUE="">
  <input type="hidden" name="otherGenTable" value="">
</form>
</body>
</html>
