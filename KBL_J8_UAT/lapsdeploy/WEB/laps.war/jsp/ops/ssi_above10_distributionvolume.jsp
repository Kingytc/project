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

	for(int i=0;i<2;i++)
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
if(!strCategoryType.equalsIgnoreCase(null))
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
<SCRIPT language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var genid = "<%=strgenid%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";

function callDisable(one)
{
	for( i=1;i<=2;i++)		
	{
		document.forms[0].elements["txt_distributionvolume"+i].readOnly=one;	
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
	document.forms[0].hidparam.value="DetailsOfSelling/DistributionAgency^NatureAndVolumeOfOrders&Enquiries";
	document.forms[0].hidTabName.value="DistributionAgencyVolume";
	document.forms[0].hidMethod.value="getGeneralDetails";
}
function doEdit()
{
	callDisable(false);
	disableControls(true,false,false,false,true);
	document.forms[0].hideditflag.value="Y";
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
	document.forms[0].action=appUrl+"action/ssi_above10_distributionvolume.jsp";
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
	document.forms[0].hidBeanMethod.value="removeUtillitiesData";
	document.forms[0].hidSourceUrl.value="/action/ssi_above10_distributionvolume.jsp";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
}
function doCancel()
{	
	if(ConfirmMsg('102'))
	{
		document.forms[0].hidMethod.value="getGeneralDetails";
		document.forms[0].hidBeanId.value="comssiaboveten";
		document.forms[0].action=appUrl+"action/ssi_above10_distributionvolume.jsp";
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
</script>
</head>
<body onload="onloading()">
<form name="fininc" method="post" class="normal">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <td> 
        <jsp:include page="../share/applurllinkscom.jsp" flush="true">
        <jsp:param name="pageid" value="3" />
		<jsp:param name="cattype" value="<%=strCategoryType%>" />
	    <jsp:param name="ssitype" value="<%=strSSIType%>" />
        </jsp:include>
      </td>
    </tr>
    <tr> 
            <td class="page_flow">Home -&gt; <%=strcat %> -&gt; Application -&gt;  Eco.Feasibility -&gt; Selling/Distribution Agency 
 </td>
          </tr>
	</table> 
  <span style="display:none"><lapschoice:borrowertype /></span> <lapschoice:application/> 
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <td valign="top"> 
        <table width="55%" border="0" cellspacing="1" cellpadding="3" class="outertable">
          <tr> 
            <td width="26%" class='sub_tab_inactive' align="center"><b><a href="javascript:callFunctionTab('ssiab10_ecnomic_feasibility.jsp','getGeneralData','Marketing^ProductItemCodeNo^NameMajorcustomers^Region/Area^ExtentofcompetitionandNoOfUnits^Howdoesunitmeet/propose^Pricaandquality^Unitsellingdirecttocutomers','Economicfeasibility','no')">Marketing 
                </a></b>
            </td>
            <td width="44%" class='sub_tab_active'  align="center"><b>Selling/Distribution Agency </b></td>
            <td width="30%" class='sub_tab_inactive' align="center"><b><a href="javascript:callFunction('ssi_above10_exportproducts.jsp','getExportProducts','','ExportDetails');">Export 
                Product </a></b>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <br>
  <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
    <tr> 
      <td valign="top"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr> 
            <td valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
                <tr> 
                  <td> 
                    <table width="100%" border="1" cellspacing="0" cellpadding="3" class="outertable">
                      <tr> 
                        <td> 
                          <table width="100%" border="0" cellspacing="1" cellpadding="5" class="outertable">
						  <%if(hshValues.size()>0 && hshValues != null && vecrowsize >0)
						{
							vecCol =(ArrayList)vecRow.get(0);%>
                            <tr> 
                              <td width="21%">If 
                                a selling / distribution agency has been appointed, 
                                its name, period of contract, commission payable, 
                                period by which the bills will be paid by it etc.</td>
                            </tr>
                            <tr> 
                              <td width="21%" align="right"> 
                                <INPUT TYPE="hidden" NAME="hidtxt1" VALUE="<%=vecCol.get(0)%>">
                            <textarea name="txt_distributionvolume1" cols="135" rows="7" wrap="VIRTUAL"> <%=vecCol.get(1)%></textarea>
                              </td>
                            </tr>
                            <tr> 
                              <td width="21%">Nature 
                                and volume of orders / enquiries on hand (certified 
                                xerox copies to be furnished)</td>
                            </tr>
						   <% vecCol =(ArrayList)vecRow.get(1);%>
                            <tr> 
                              <td width="21%" align="right"> 
                                <INPUT TYPE="hidden" NAME="hidtxt2" VALUE="<%=vecCol.get(0)%>">
                            <textarea name="txt_distributionvolume2" cols="135" rows="7" wrap="VIRTUAL"> <%=vecCol.get(1)%></textarea>
                              </td>
                            </tr>
							<%}else{%>
								       <tr> 
                              <td width="21%">If 
                                a selling / distribution agency has been appointed, 
                                its name, period of contract, commission payable, 
                                period by which the bills will be paid by it etc.</td>
                            </tr>
                            <tr> 
                              <td width="21%" align="right"> 
                                <textarea name="txt_distributionvolume1" cols="135" rows="7" wrap="VIRTUAL"></textarea>
                              </td>
                            </tr>
                            <tr> 
                              <td width="21%">Nature 
                                and volume of orders / enquiries on hand (certified 
                                xerox copies to be furnished)</td>
                            </tr>
                            <tr> 
                              <td width="21%" align="right"> 
                                <textarea name="txt_distributionvolume2" cols="135" rows="7" wrap="VIRTUAL"></textarea>
                              </td>
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
          </tr>
        </table>
        </td>
    </tr>
  </table>
<br>
   <lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidDesc1" value="DetailsOfSelling/DistributionAgency">
<input type="hidden" name="hidDesc2" value="NatureAndVolumeOfOrders&Enquiries">
<input type="hidden" name="hidTotalDesc" value="2">
<input type="hidden" name="hidFieldPrefix" value="txt_distributionvolume">
<INPUT TYPE="hidden" NAME="hidGenID" VALUE="">
<input type="hidden" name="otherGenTable" value="">
</form>
</body>
</html>
