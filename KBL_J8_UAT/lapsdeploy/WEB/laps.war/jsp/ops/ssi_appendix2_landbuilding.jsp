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

	for(int i=0;i<12;i++)
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
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="javascript"src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var genid = "<%=strgenid%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
function doHelp1()
{
	  var varString = appUrl+"jsp/sethlp/hlp_ssiappendix2.jsp"
	   var title = "Documents";
		var prop = "scrollbars=no,width=600,height=450";	
		prop = prop + ",left=50,top=150";
		window.open(varString,title,prop);
}
function callDisable(one)
{
	for( i=1;i<=12;i++)		
	{	
		document.forms[0].elements["txt_landbuilding"+i].readOnly=one;	
	}		
}
function otherdetails()
{
var url=appUrl+"action/ssi_otherdetails.jsp?hidBeanGetMethod=getotherdetailsData&hidBeanId=comssiaboveten&hidappno="+"<%=request.getParameter("appno")%>"+"&appno="+"<%=request.getParameter("appno")%>";
	var title = "SSIOTHERDETAILS";
	var prop = "menubar=no,scrollbars=yes,width=800,height=600";	
	var xpos = (screen.width - 800) / 2;
	var ypos = (screen.height - 600) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(url,title,prop);
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
	document.forms[0].hidparam.value="LandLocation^LandArea^LandFreeHoldLeaseHold^PurchasePriceOfLand^RentForLeaseLand^LandTermsOfLease^LandYearlyGroundRent^BuildingLocation^BuildingOwnedOrLease^PurchasePriceOfBuilding^RentForLeaseOrRentedBuilding^BuildingTermsOfLease";
	document.forms[0].hidTabName.value="AppendixIILandAndBuilding";
	document.forms[0].hidMethod.value="getGeneralDetails";
}
function doEdit()
{
	callDisable(false);
	document.forms[0].hideditflag.value="Y";
	disableControls(true,false,false,false,true);
}
function doSave()
{	
	if(<%=vecrowsize%> >0)
	{
		document.forms[0].hidAction.value="update";
	}
	else
	{
		document.forms[0].hidAction.value="insert";
	}
	document.forms[0].hidBeanGetMethod.value="updateGeneralData";
	document.forms[0].hidBeanId.value="comssiaboveten";
	document.forms[0].action=appUrl+"action/ssi_appendix2_landbuilding.jsp";
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
	document.forms[0].hidBeanMethod.value="removeUtillitiesData";
	document.forms[0].hidSourceUrl.value="/action/ssi_appendix2_landbuilding.jsp";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
}
function doCancel()
{	
	if(ConfirmMsg('102'))
	{
		document.forms[0].hidMethod.value="getGeneralDetails";
		document.forms[0].hidBeanId.value="comssiaboveten";
		document.forms[0].action=appUrl+"action/ssi_appendix2_landbuilding.jsp";
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
function callFunction(pagename,methodname,param,tabname)
{
	if(methodname=="getGeneralDetails")
	{
		document.forms[0].hidparam.value =param;
	}
	document.forms[0].method="post";	
	document.forms[0].hidTabName.value=tabname;	
	document.forms[0].hidMethod.value=methodname;	
	document.forms[0].action = appURL+"action/"+pagename;
	document.forms[0].submit();
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
function callVehicleDetails()
{
	document.forms[0].hidBeanGetMethod.value="getAllVehicleDetails";
	document.forms[0].hidBeanId.value="comssiaboveten";
	document.forms[0].action=appUrl+"action/ops_vehicledetails.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
}
function callValuationEntry()
{
	document.forms[0].hidBeanGetMethod.value="getValuerEntryData";
	document.forms[0].hidBeanId.value="perpropertydetails";
	document.forms[0].action=appUrl+"action/ops_valuationentry.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
}
</script>
</head>
<body onload="onloading()">
<form name="fininc" method="post" class="normal">
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
            <td class="page_flow">Home -&gt; <%=strcat %>-&gt; Application-&gt; Proposed / Offered Asset -&gt; Land &amp; Building </td>
          </tr>
	</table> 
  <span style="display:none"><lapschoice:borrowertype /></span> 
  <lapschoice:application/> 
  <lapschoice:ssiassestdetails tabid="1"/>
  <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
    <tr> 
      <td valign="top"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr> 
            <td valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
                <tr> 
                  <td valign="top"> 
                    <table width="100%" border="1" cellspacing="0" cellpadding="3" class="outertable">
                        <td valign="top"> 
                          <table width="100%" border="0" cellspacing="2" cellpadding="3" class="outertable">
                            <%if(hshValues.size()>0 && hshValues != null && vecrowsize >0){
							vecCol =(ArrayList)vecRow.get(0);%>
                            <tr class="dataheader"> 
                              <td colspan="2"><b>A) Land</b> </td>
                              <td width="15%">&nbsp;</td>
                              <td width="35%">&nbsp;</td>
                            </tr>
                            <tr> 
                              <td width="8%">1) Location</td>
                              <td width="42%"> 
                                <INPUT TYPE="hidden" NAME="hidtxt1" VALUE="<%=vecCol.get(0)%>">
                                <textarea name="txt_landbuilding1" cols="45" wrap="VIRTUAL" rows="3"> <%=Helper.correctNull((String)vecCol.get(1))%> </textarea>
                              </td>
							<% vecCol =(ArrayList)vecRow.get(1);%>
                              <td width="15%">2) Area</td>
                              <td width="35%"> 
                                <INPUT TYPE="hidden" NAME="hidtxt2" VALUE="<%=vecCol.get(0)%>">
                                <textarea name="txt_landbuilding2" cols="45" wrap="VIRTUAL" rows="3"> <%=Helper.correctNull((String)vecCol.get(1))%> </textarea>
                              </td>
                            </tr>
                            <tr> 
								<% vecCol =(ArrayList)vecRow.get(2);%>
                              <td width="8%">3) Whether Freehold or lease hold</td>
                              <td width="42%"> 
                                <INPUT TYPE="hidden" NAME="hidtxt3" VALUE="<%=vecCol.get(0)%>">
                                <textarea name="txt_landbuilding3" cols="45" wrap="VIRTUAL" rows="3"> <%=Helper.correctNull((String)vecCol.get(1))%> </textarea>
                              </td>
								<% vecCol =(ArrayList)vecRow.get(3);%>
                              <td width="15%">4) Purchase price of land if owned</td>
                              <td width="35%"> 
                                <INPUT TYPE="hidden" NAME="hidtxt4" VALUE="<%=vecCol.get(0)%>">
                                <textarea name="txt_landbuilding4" cols="45" wrap="VIRTUAL" rows="3"> <%=Helper.correctNull((String)vecCol.get(1))%> </textarea>
                              </td>
                            </tr>
                            <tr> 
							  <% vecCol =(ArrayList)vecRow.get(4);%>
                              <td width="8%">5) Rent in case of Leased Land</td>
                              <td width="42%"> 
                                <INPUT TYPE="hidden" NAME="hidtxt5" VALUE="<%=vecCol.get(0)%>">
                                <textarea name="txt_landbuilding5" cols="45" wrap="VIRTUAL" rows="3"> <%=Helper.correctNull((String)vecCol.get(1))%> </textarea>
                              </td>
								<% vecCol =(ArrayList)vecRow.get(5);%>
                              <td width="15%">6) Terms of Lease</td>
                              <td width="35%"> 
                                <INPUT TYPE="hidden" NAME="hidtxt6" VALUE="<%=vecCol.get(0)%>">
                                <textarea name="txt_landbuilding6" cols="45" wrap="VIRTUAL" rows="3"> <%=Helper.correctNull((String)vecCol.get(1))%> </textarea>
                              </td>
                            </tr>
                            <tr> 
							<% vecCol =(ArrayList)vecRow.get(6);%>
                              <td width="8%">7) Ground rent payable per year</td>
                              <td width="42%"> 
                                <INPUT TYPE="hidden" NAME="hidtxt7" VALUE="<%=vecCol.get(0)%>">
                                <textarea name="txt_landbuilding7" cols="45" wrap="VIRTUAL" rows="3"> <%=Helper.correctNull((String)vecCol.get(1))%> </textarea>
                              </td>
                              <td width="15%">&nbsp;</td>
                              <td width="35%">&nbsp;</td>
                            </tr>
							<%}else{%>
							<tr> 
                              <td colspan="2"><b>A) Land</b> </td>
                              <td width="15%">&nbsp;</td>
                              <td width="35%">&nbsp;</td>
                            </tr>
                            <tr> 
                              <td width="8%">1) Location</td>
                              <td width="42%"> 
                                <textarea name="txt_landbuilding1" cols="45" wrap="VIRTUAL" rows="3"></textarea>
                              </td>
                              <td width="15%">2) Area </td>
                              <td width="35%" align="right"> 
                                <textarea name="txt_landbuilding2" cols="45" wrap="VIRTUAL" rows="3"></textarea>
                              </td>
                            </tr>
                            <tr> 
                              <td width="8%">3) Whether Freehold or lease hold</td>
                              <td width="42%"> 
                                <textarea name="txt_landbuilding3" cols="45" wrap="VIRTUAL" rows="3"></textarea>
                              </td>
                              <td width="15%">4) Purchase price of land if owned</td>
                              <td width="35%" align="right"> 
                                <textarea name="txt_landbuilding4" cols="45" wrap="VIRTUAL" rows="3"></textarea>
                              </td>
                            </tr>
                            <tr> 
                              <td width="8%">5) Rent in case of Leased Land</td>
                              <td width="42%"> 
                                <textarea name="txt_landbuilding5" cols="45" wrap="VIRTUAL" rows="3"></textarea>
                              </td>
                              <td width="15%">6) Terms of Lease</td>
                              <td width="35%" align="right"> 
                                <textarea name="txt_landbuilding6" cols="45" wrap="VIRTUAL" rows="3"></textarea>
                              </td>
                            </tr>
                            <tr> 
                              <td width="8%">7) Ground rent payable per year</td>
                              <td width="42%"> 
                                <textarea name="txt_landbuilding7" cols="45" wrap="VIRTUAL" rows="3"></textarea>
                              </td>
                              <td width="15%">&nbsp;</td>
                              <td width="35%" align="right">&nbsp;</td>
                            </tr>
							<%}%>
							</table>							
                        </td>
                        <td> 
						</td>
					<tr> 
                        <td valign="top"> 
                          <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
                            <%if(hshValues.size()>0 && hshValues != null && vecrowsize >0){
                            	vecCol =(ArrayList)vecRow.get(7);%>
                            <tr class="dataheader"> 
                              <td colspan="2"><b>B) Building</b></td>
                              <td width="15%">&nbsp;</td>
                              <td width="35%">&nbsp;</td>
                            </tr>
                            <tr> 
                              <td width="8%">1) Location</td>
                              <td width="42%"> 
                                <INPUT TYPE="hidden" NAME="hidtxt8" VALUE="<%=Helper.correctNull((String)vecCol.get(0))%>">
                                <textarea name="txt_landbuilding8" cols="45" wrap="VIRTUAL" rows="3"> <%=Helper.correctNull((String)vecCol.get(1))%> </textarea>
                              </td>
						<% vecCol =(ArrayList)vecRow.get(8);%>
                              <td width="15%">2) Whether owned or leased</td>
                              <td width="35%"> 
                                <INPUT TYPE="hidden" NAME="hidtxt9" VALUE="<%=vecCol.get(0)%>">
                                <textarea name="txt_landbuilding9" cols="45" wrap="VIRTUAL" rows="3">  <%=Helper.correctNull((String)vecCol.get(1))%> </textarea>
                              </td> 
                            </tr>
                            <tr>
						<% vecCol =(ArrayList)vecRow.get(9);%>
                              <td width="8%">3) Purchase price of Building if owned</td>
                              <td width="42%"> 
                                <INPUT TYPE="hidden" NAME="hidtxt10" VALUE="<%=Helper.correctNull((String)vecCol.get(0))%>">
                                <textarea name="txt_landbuilding10" cols="45" wrap="VIRTUAL" rows="3"> <%=Helper.correctNull((String)vecCol.get(1))%> </textarea>
                              </td>
						<% vecCol =(ArrayList)vecRow.get(10);%>
                              <td width="15%">4) Rent in case of Leased/rented premises</td>
                              <td width="35%"> 
                                <INPUT TYPE="hidden" NAME="hidtxt11" VALUE="<%=vecCol.get(0)%>">
                                <textarea name="txt_landbuilding11" cols="45" wrap="VIRTUAL" rows="3"> <%=Helper.correctNull((String)vecCol.get(1))%> </textarea>
                              </td>
                            </tr>
                            <tr> 
						<% vecCol =(ArrayList)vecRow.get(11);%>
                              <td width="8%">5) Terms of Lease</td>
                              <td width="42%"> 
                                <INPUT TYPE="hidden" NAME="hidtxt12" VALUE="<%=vecCol.get(0)%>">
                                <textarea name="txt_landbuilding12" cols="45" wrap="VIRTUAL" rows="3"> <%=Helper.correctNull((String)vecCol.get(1))%> </textarea>
                              </td>
                              <td width="15%">&nbsp;</td>
                              <td width="35%">&nbsp;</td>
                            </tr>
							<%}else{%>
								 <tr> 
                              <td colspan="2"><b>B) Building</b> </td>
                              <td width="15%">&nbsp;</td>
                              <td width="35%">&nbsp;</td>
                            </tr>
                            <tr> 
                              <td width="8%">1) Location</td>
                              <td width="44%"> 
                                <textarea name="txt_landbuilding8" cols="45" wrap="VIRTUAL" rows="3"></textarea>
                              </td>
                              <td width="15%">2) Whether owned or leased</td>
                              <td width="35%"> 
                                <textarea name="txt_landbuilding9" cols="45" wrap="VIRTUAL" rows="3"></textarea>
                              </td>
                            </tr>
                            <tr>
                              <td width="8%">3) Purchase price of Building if owned</td>
                              <td width="44%"> 
                                <textarea name="txt_landbuilding10" cols="45" wrap="VIRTUAL" rows="3"></textarea>
                              </td>
                              <td width="15%">4) Rent in case of Leased/rented premises</td>
                              <td width="35%"> 
                                <textarea name="txt_landbuilding11" cols="45" wrap="VIRTUAL" rows="3"></textarea>
                              </td>
                            </tr>
                            <tr> 
                              <td width="8%">5) Terms of Lease</td>
                              <td width="44%"> 
                                <textarea name="txt_landbuilding12" cols="45" wrap="VIRTUAL" rows="3"></textarea>
                              </td>
                              <td width="15%">&nbsp;</td>
                              <td width="35%">&nbsp;</td>
                            </tr>
							<%}%>
                          </table>
                        </td>
                      </tr>
                    </table>
					
                  </td>
                </tr>
              </table>
            </td>			
          </tr></table>
        </td>
    </tr>
  </table>
<br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
<lapschoice:hiddentag pageid='<%=PageId%>'/> 
<input type="hidden" name="hidDesc1" value="LandLocation">
<input type="hidden" name="hidDesc2" value="LandArea">
<input type="hidden" name="hidDesc3" value="LandFreeHoldLeaseHold">
<input type="hidden" name="hidDesc4" value="PurchasePriceOfLand">
<input type="hidden" name="hidDesc5" value="RentForLeaseLand">
<input type="hidden" name="hidDesc6" value="LandTermsOfLease">
<input type="hidden" name="hidDesc7" value="LandYearlyGroundRent">

<input type="hidden" name="hidDesc8"  value="BuildingLocation">
<input type="hidden" name="hidDesc9"  value="BuildingOwnedOrLease">
<input type="hidden" name="hidDesc10" value="PurchasePriceOfBuilding">
<input type="hidden" name="hidDesc11" value="RentForLeaseOrRentedBuilding">
<input type="hidden" name="hidDesc12" value="BuildingTermsOfLease">

<input type="hidden" name="hidTotalDesc" value="12">
<input type="hidden" name="hidFieldPrefix" value="txt_landbuilding">
<INPUT TYPE="hidden" NAME="hidGenID" VALUE="">
<input type="hidden" name="otherGenTable" value="">
</form>
</body>
</html>
