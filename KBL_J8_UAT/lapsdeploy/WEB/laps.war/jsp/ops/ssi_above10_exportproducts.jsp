<%@include file="../share/directives.jsp"%>
<%
ArrayList vecRow = new ArrayList();
ArrayList vecCol = new ArrayList();
String strCodeNo="";
int vecrowsize =0;
if(hshValues.size()>0 && hshValues != null)
{
	vecRow = (ArrayList)hshValues.get("vecRow");
	if (vecRow.size()>0)
	{
	vecCol =(ArrayList)vecRow.get(0);
	strCodeNo = Helper.correctNull((String)vecCol.get(0));
	}
}
else
{
	strCodeNo="";
}
String strBorrowerType =Helper.correctNull((String)request.getParameter("hidBorrowerType"));
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
<SCRIPT language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="javascript"src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var genid = "";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
var varRecordflag = "<%= Helper.correctNull((String)hshValues.get("recordflag"))%>";
function callDisable(one)
{
	for( i=1;i<=1;i++)		
	{	

		document.forms[0].elements["txt_exportproducts1"+i].readOnly=one;	
		document.forms[0].elements["txt_exportproducts2"+i].readOnly=one;	
		document.forms[0].elements["txt_exportproducts3"+i].readOnly=one;	
	}		
		document.forms[0].txt_exportercodeno.readOnly=one;			
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
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=true;
		}	 
	}
	document.forms[0].hidTabName.value="ExportDetails";
	document.forms[0].hidMethod.VALUE="getExportProducts";
}
function doEdit()
{
	disableControls(true,false,false,false,true);
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
	 	{
			document.forms[0].elements[i].readOnly=false;
	 	}
	 }
	 document.forms[0].hideditflag.value="Y";
	 }

function doSave()
{	
if(trimtxt(document.forms[0].txt_exportercodeno.value)=="")
{
alert('Enter the Code Number');
return false;
}
	document.forms[0].hidRecordflag.value = varRecordflag;
    document.forms[0].hidMethod.value="getExportProducts";
	document.forms[0].hidBeanGetMethod.value="updateExportProductsData";
	document.forms[0].hidBeanId.value="comssiaboveten";
	document.forms[0].action=appUrl+"action/ssi_above10_exportproducts.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
}

function doDelete()
{
	document.forms[0].hidAction.value="Delete";
	if(varRecordflag == "Y"){
	if(ConfirmMsg("101"))
	{
	document.forms[0].hidBeanId.value="comssiaboveten";
	document.forms[0].hidBeanGetMethod.value="updateExportProductsData";
	document.forms[0].hidMethod.value="getExportProducts";
	//document.forms[0].hidSourceUrl.value="/action/ssi_above10_exportproducts.jsp";
	document.forms[0].action=appUrl+"action/ssi_above10_exportproducts.jsp";
	document.forms[0].submit();
	}
}
}
function doCancel()
{	
	if(ConfirmMsg('102'))
	{
		document.forms[0].hidMethod.value="getExportProducts";
		document.forms[0].hidBeanId.value="comssiaboveten";
		document.forms[0].action=appUrl+"action/ssi_above10_exportproducts.jsp";
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
  <table width="100%" border="1" cellspacing="0" cellpadding="0" class="outertable">
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
            <td class="page_flow">Home -&gt;  <%=strcat %>-&gt;  Application-&gt; Eco.Feasibility -&gt;Export Product  
</td>
          </tr>
	</table> 
  <span style="display:none"><lapschoice:borrowertype /></span> <lapschoice:application/> 
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <td valign="top"> 
        <table width="55%" border="0" cellspacing="1" cellpadding="3" class="outertable">
          <tr align="center"> 
            <td class='sub_tab_inactive'> 
              <b><b><a href="javascript:callFunctionTab('ssiab10_ecnomic_feasibility.jsp','getGeneralData','Marketing^ProductItemCodeNo^NameMajorcustomers^Region/Area^ExtentofcompetitionandNoOfUnits^Howdoesunitmeet/propose^Pricaandquality^Unitsellingdirecttocutomers','Economicfeasibility','no')">Marketing 
                </a></b></b>
            </td>
            <td class='sub_tab_inactive'> 
              <b><b><a href="javascript:callFunction('ssi_above10_distributionvolume.jsp','getGeneralDetails','DetailsOfSelling/DistributionAgency^NatureAndVolumeOfOrders&Enquiries','DistributionAgencyVolume')">Selling/Distribution 
                Agency </a></b></b>
            </td>
            <td class="sub_tab_active"><b>Export Product </b>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <table width="100%" border="1" cellspacing="0" cellpadding="5" class="outertable">
    <tr> 
      <td valign="top"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr> 
            <td valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
                <tr> 
                  <td> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable linebor">
                      <tr> 
                        <td colspan="4">If 
                          the Unit is export oriented, please furnish exporter 
                          code no. if allotted, and relevant details as per the 
                          following details in the preceding three years :-</td>
                      </tr>
                      <tr> 
                        <td width="11%">Code Number<b>(<span class="mantatory">*&nbsp;</span>)</b></td>
                        <td colspan="3"  >
                            <input type="text" name="txt_exportercodeno"  onKeyPress="notAllowSplChar()" size="25" value="<%=strCodeNo%>" maxlength="18">
                        </td>
                      </tr>
                      <tr class="dataheader"> 
                        <td align="center" colspan="2">Name of the Product Exported</td>
                        <td width="35%" align="center">Name of the Country where Exported </td>
                        <td width="27%" align="center">F.O.B. Value </td>
                      </tr>
                      <%if (vecRow.size()>0){%>
                      <tr class="datagrid"> 
                        <td align="center" colspan="2"> 
                          <input type="text" name="txt_exportproducts1" onKeyPress="notAllowSplChar1(this)" size="30" VALUE="<%=Helper.correctNull((String)vecCol.get(2))%>" maxlength="30"  >
                        </td>
                        <td width="35%" align="center"> 
                          <input type="text" name="txt_exportproductcntry1" onKeyPress="notAllowSplChar()" size="30" VALUE="<%=Helper.correctNull((String)vecCol.get(3))%>" maxlength="30"  >
                        </td>
                        <td width="27%" align="center"> 
                          <input type="text"  name="txt_exportproductvalue1" size="15" onKeyPress="allowNumber(this)" style="text-align:right" VALUE="<%=Helper.correctNull((String)vecCol.get(4))%>" maxlength="10" >
                        </td>
                      </tr>
                      <tr class="datagrid"> 
					  <%vecCol =(ArrayList)vecRow.get(1);%>
                        <td align="center" colspan="2"> 
                          <input type="text" name="txt_exportproducts2" onKeyPress="notAllowSplChar1(this)" size="30" value="<%=Helper.correctNull((String)vecCol.get(2))%>" maxlength="30">
                        </td>
                        <td width="35%" align="center"> 
                          <input type="text" name="txt_exportproductcntry2" onKeyPress="notAllowSplChar()" size="30" value="<%=Helper.correctNull((String)vecCol.get(3))%>" maxlength="30">
                        </td>
                        <td width="27%" align="center"> 
                          <input type="text" name="txt_exportproductvalue2" style="text-align:right" onKeyPress="allowNumber(this)" size="15" value="<%=Helper.correctNull((String)vecCol.get(4))%>" maxlength="10">
                        </td>
                      </tr>
                      <tr class="datagrid"> 
					   <%vecCol =(ArrayList)vecRow.get(2);%>
                        <td align="center" colspan="2"> 
                          <input type="text" name="txt_exportproducts3" onKeyPress="notAllowSplChar1(this)" size="30" value="<%=Helper.correctNull((String)vecCol.get(2))%>" maxlength="30">
                        </td>
                        <td width="35%" align="center"> 
                          <input type="text" name="txt_exportproductcntry3" onKeyPress="notAllowSplChar()" size="30" value="<%=Helper.correctNull((String)vecCol.get(3))%>" maxlength="30">
                        </td>
                        <td width="27%" align="center"> 
                          <input type="text" name="txt_exportproductvalue3" style="text-align:right" onKeyPress="allowNumber(this)" size="15" value = "<%=Helper.correctNull((String)vecCol.get(4))%>" maxlength="10">
                        </td>
                      </tr>
                      <tr class="datagrid"> 
					  <%vecCol =(ArrayList)vecRow.get(3);%>
                        <td align="center" colspan="2"> 
                          <input type="text" name="txt_exportproducts4" onKeyPress="notAllowSplChar1(this)" size="30" value="<%=Helper.correctNull((String)vecCol.get(2))%>" maxlength="30">
                        </td>
                        <td width="35%" align="center"> 
                          <input type="text" name="txt_exportproductcntry4" onKeyPress="notAllowSplChar()" size="30" value ="<%=Helper.correctNull((String)vecCol.get(3))%>" maxlength="30">
                        </td>
                        <td width="27%" align="center"> 
                          <input type="text" name="txt_exportproductvalue4" style="text-align:right" onKeyPress="allowNumber(this)" size="15" value ="<%=Helper.correctNull((String)vecCol.get(4))%>" maxlength="10">
                        </td>
                      </tr>
                      <tr class="datagrid"> 
					  <%vecCol =(ArrayList)vecRow.get(4);%>
                        <td align="center" colspan="2"> 
                          <input type="text" name="txt_exportproducts5" size="30" onKeyPress="notAllowSplChar1(this)" value ="<%=Helper.correctNull((String)vecCol.get(2))%>" maxlength="30">
                        </td>
                        <td width="35%" align="center"> 
                          <input type="text" name="txt_exportproductcntry5" size="30" onKeyPress="notAllowSplChar()" value ="<%=Helper.correctNull((String)vecCol.get(3))%>" maxlength="30" >
                        </td>
                        <td width="27%" align="center"> 
                          <input type="text" name="txt_exportproductvalue5" style="text-align:right" onKeyPress="allowNumber(this)" size="15" value ="<%=Helper.correctNull((String)vecCol.get(4))%>" maxlength="10">
                        </td>
                      </tr>
                      <%}else{%>
                       <tr class="datagrid"> 
                        <td align="center" colspan="2"> 
                          <input type="text" name="txt_exportproducts1" onKeyPress="notAllowSplChar1(this)" size="30" VALUE="" maxlength="30"  >
                        </td>
                        <td width="35%" align="center"> 
                          <input type="text" name="txt_exportproductcntry1" onKeyPress="notAllowSplChar()" size="30" VALUE="" maxlength="30"  >
                        </td>
                        <td width="27%" align="center"> 
                          <input type="text" align="right" name="txt_exportproductvalue1" size="15" onKeyPress="allowNumber(this)" VALUE="" maxlength="10" >
                        </td>
                      </tr>
                      <tr class="datagrid">					 
                        <td align="center" colspan="2"> 
                          <input type="text" name="txt_exportproducts2" onKeyPress="notAllowSplChar1(this)" size="30" value="" maxlength="30">
                        </td>
                        <td width="35%" align="center"> 
                          <input type="text" name="txt_exportproductcntry2" onKeyPress="notAllowSplChar()" size="30" value="" maxlength="30">
                        </td>
                        <td width="27%" align="center"> 
                          <input type="text" name="txt_exportproductvalue2" onKeyPress="allowNumber(this)" size="15" value="" maxlength="10">
                        </td>
                      </tr>
                      <tr class="datagrid"> 					  
                        <td align="center" colspan="2"> 
                          <input type="text" name="txt_exportproducts3" onKeyPress="notAllowSplChar1(this)" size="30" value="" maxlength="30">
                        </td>
                        <td width="35%" align="center"> 
                          <input type="text" name="txt_exportproductcntry3" onKeyPress="notAllowSplChar()" size="30" value="" maxlength="30">
                        </td>
                        <td width="27%" align="center"> 
                          <input type="text" name="txt_exportproductvalue3" onKeyPress="allowNumber(this)" size="15" value = "" maxlength="10">
                        </td>
                      </tr>
                      <tr class="datagrid"> 					 
                        <td align="center" colspan="2"> 
                          <input type="text" name="txt_exportproducts4" onKeyPress="notAllowSplChar1(this)" size="30" value="" maxlength="30">
                        </td>
                        <td width="35%" align="center"> 
                          <input type="text" name="txt_exportproductcntry4" onKeyPress="notAllowSplChar()" size="30" value ="" maxlength="30">
                        </td>
                        <td width="27%" align="center"> 
                          <input type="text" name="txt_exportproductvalue4" onKeyPress="allowNumber(this)" size="15" value ="" maxlength="10">
                        </td>
                      </tr>
                      <tr class="datagrid">				  
                        <td align="center" colspan="2"> 
                          <input type="text" name="txt_exportproducts5" size="30" onKeyPress="notAllowSplChar1(this)" value ="" maxlength="30">
                        </td>
                        <td width="35%" align="center"> 
                          <input type="text" name="txt_exportproductcntry5" size="30" onKeyPress="notAllowSplChar()" value ="" maxlength="30">
                        </td>
                        <td width="27%" align="center"> 
                          <input type="text" name="txt_exportproductvalue5" onKeyPress="allowNumber(this)" size="15" value ="" maxlength="10">
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

<br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidTotalDesc" value="10">
<input type="hidden" name="hidFieldPrefix" value="txt_exportproducts">
<INPUT TYPE="hidden" NAME="hidGenID" VALUE="">
<input type="hidden" name="otherGenTable" value="">
</form>
</body>
</html>

