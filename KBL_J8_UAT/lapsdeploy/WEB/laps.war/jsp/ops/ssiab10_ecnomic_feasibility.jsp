<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
 if(objValues instanceof java.util.HashMap)
   {
	  hshValues=(java.util.HashMap)objValues;
   }
HashMap htab=(HashMap)hshValues.get("hsh2");// for general hs2
// for general values
ArrayList vecRow = new ArrayList();
ArrayList vecCol = new ArrayList();
int vecrowsize =0;
if(htab.size()>0 && htab != null)
{	
	vecRow = (ArrayList)htab.get("vecRow");	
	if(vecRow !=null)
	{
		vecrowsize = vecRow.size();
		vecCol = new ArrayList();
	}
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
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="javascript" >
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";

function whileLoading()
{
	disableFields(true);
	document.forms[0].hidparam.value="Marketing^ProductItemCodeNo^NameMajorcustomers^Region/Area^ExtentofcompetitionandNoOfUnits^Howdoesunitmeet/propose^Pricaandquality^Unitsellingdirecttocutomers";
	document.forms[0].hidTabName.value="Economicfeasibility";
}

function enableButtons(bool1,bool2,bool3,bool4,bool5)
{	
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;	
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
}

function disableFields(val)
	{		
		for(var i=0;i<document.forms[0].elements.length;i++)
		{
			if((document.forms[0].elements[i].type=="text")||(document.forms[0].elements[i].type=="textarea"))
			{
				document.forms[0].elements[i].readOnly=val;		  
			}			
		}
	}
  function doCancel()
	{		
		if(ConfirmMsg(102))
		{
				document.forms[0].hidBeanGetMethod.value="getData";
				document.forms[0].hidBeanId.value="arrears";
				document.forms[0].action=appUrl+"action/ssiab10_ecnomic_feasibility.jsp";	
				document.forms[0].hidMethod.value="getGeneralData";						
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
function doEdit()
{
	disableFields(false);
	enableButtons(true,false,false,false,true);	
	document.forms[0].hideditflag.value="Y";
}
function doDelete()
{
	document.forms[0].hidAction.value="Delete";	
	if(ConfirmMsg(101))
	{
		document.forms[0].hidBeanId.value="comssiaboveten";
		document.forms[0].hidBeanMethod.value="removeUtillitiesData";	
		document.forms[0].hidSourceUrl.value="/action/ssiab10_ecnomic_feasibility.jsp";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].submit();
	}
}

function doSave()
{
	var appUrl="<%=ApplicationParams.getAppUrl()%>";
	document.forms[0].hidBeanGetMethod.value="updateSSIAB10Data";
	document.forms[0].hidBeanId.value="arrears";
	document.forms[0].action=appUrl+"action/ssiab10_ecnomic_feasibility.jsp";	
	document.forms[0].submit();
}

function AnticipatedTurnover_SSI()
{
	var appno="<%=request.getParameter("appno")%>";
	var varbtnenable = document.forms[0].btnenable.value;
	var cattype="<%=strCategoryType%>";
	var purl=appUrl+"action/ssi_anticipated_turnover.jsp?hidBeanGetMethod=getAnticipatedTurnover&hidBeanId=arrears&appno="+appno+"&cattype="+cattype+"&status="+document.forms[0].appstatus.value+"&btnenable="+varbtnenable;
	prop='scrollbars=yes,menubar=no,width=750,height=520';
	xpos=(screen.width-750)/2;
	ypos=(screen.height-520)/2;
	prop=prop+",xpos="+xpos+",ypos="+ypos;
	window.open(purl,'title',prop);
}

function AnticipatedTurnover_AGR()
{
	var appno="<%=request.getParameter("appno")%>";
	var varbtnenable = document.forms[0].btnenable.value;
	var cattype="<%=strCategoryType%>";
	var purl=appUrl+"action/agrssi_anticipatedturn.jsp?hidBeanGetMethod=getAnticipatedTurnover&hidBeanId=arrears&appno="+appno+"&cattype="+cattype+"&btnenable="+varbtnenable;
	prop='scrollbars=yes,menubar=no,width=750,height=520';
	xpos=(screen.width-750)/2;
	ypos=(screen.height-520)/2;
	prop=prop+",xpos="+xpos+",ypos="+ypos;
	window.open(purl,'title',prop);
}
</script>
</head>
<body onload="javascript:whileLoading()">
<form name="ecnomicfeasbility" method="post" class="normal">
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
    	<td class="page_flow">Home -&gt; Tertiary -&gt; Application -&gt; Eco.Feasibility -&gt; Marketing</td>
    </tr>
	</table>
<span style="display:none"><lapschoice:borrowertype /></span> <lapschoice:application/> 
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <td valign="top"> 
        <table width="40%" border="0" cellspacing="1" cellpadding="3" class="outertable">
          <tr align="center"> 
            <td class="sub_tab_active"><b>Marketing</b></td>
            <td class="sub_tab_inactive"><b><b><a href="javascript:callFunction('ssi_above10_distributionvolume.jsp','getGeneralDetails','DetailsOfSelling/DistributionAgency^NatureAndVolumeOfOrders&Enquiries','DistributionAgencyVolume')">Selling/Distribution Agency </a></b></b>
            </td>
            <td class="sub_tab_inactive"><b><b><a href="javascript:callFunction('ssi_above10_exportproducts.jsp','getExportProducts','','ExportDetails');">Export Product </a></b></b>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
    <tr> 
      <td valign="top" > 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr> 
            <td valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
                <tr> 
                  <td> 
                    <table width="100%" border="1" cellspacing="0" cellpadding="3" class="outertable">
                      <tr> 
                        <td>
						
                          <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                            <tr> 
                              <td width="35%"><b>ECONOMIC FEASIBILITY </b></td>
                            </tr>
                            <tr> 
                              <td width="35%"> 
                                <table width="100%" border="0" cellspacing="1" cellpadding="5" class="outertable">
                                  <tr> 
                                    <td width="74%">Marketing (mention separately for each product)</td>
                                  </tr>
				  <%			 
					if(hshValues.size()>0 && hshValues != null && vecrowsize >0)
					{
						vecCol =(ArrayList)vecRow.get(0);		
					%>
                                  <tr> 
                                    <td width="74%" align="right"> 
                                      <textarea name="hidDescVal1" cols="135" rows="5" wrap="VIRTUAL"><%=vecCol.get(0)%></textarea>
                                    </td>
                                  </tr>
                                </table>
                              </td>
                            </tr>
                            <tr> 
                              <td width="35%"> 
                                <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
                                  <tr> 
                                    <td width="29%">Whether 
                                      the product is reserved exclusively for 
                                      the SSI sector ? If so, please furnish Item 
                                      Code No.</td>
										<% vecCol =(ArrayList)vecRow.get(1);%>
                                    <td width="27%"> 
                                      <input type="text" name="hidDescVal2" size="25" value="<%=vecCol.get(0)%>">
                                    </td>
                                    <td width="21%">Name 
                                      of the Major customers</td>
										<% vecCol =(ArrayList)vecRow.get(2);%>
                                    <td width="23%" align="right"> 
                                      <input type="text" name="hidDescVal3" size="25" value="<%=vecCol.get(0)%>">
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td width="29%">Region 
                                      / Area where the product is / will be sold</td>
										<%vecCol =(ArrayList)vecRow.get(3);%>
                                    <td width="27%"> 
                                      <input type="text" name="hidDescVal4" size="25" value="<%=vecCol.get(0)%>">
                                    </td>
                                    <td width="21%">Extent 
                                      of competition &amp; No. of Units engaged 
                                      in similar line in the area</td>
										<% vecCol =(ArrayList)vecRow.get(4);%>
                                    <td width="23%" align="right"> 
                                      <input type="text" name="hidDescVal5" size="25" value="<%=vecCol.get(0)%>">
                                    </td>
                                  </tr>
                                </table>
                              </td>
                            </tr>
                            <tr>
                              <td width="35%">
                                <table width="100%" border="0" cellspacing="1" cellpadding="5" class="outertable">
                                  <tr> 
                                    <td width="21%">How 
                                      does the unit meet / propose to meet the 
                                      competition ?</td>
                                  </tr>
									<% vecCol =(ArrayList)vecRow.get(5);%>
                                  <tr> 
                                    <td width="21%" align="right"> 
                                      <textarea name="hidDescVal6" cols="135" rows="5" wrap="VIRTUAL"><%=vecCol.get(0)%></textarea>
                                    </td>
                                  </tr>
										   <tr> 
                                    <td width="21%">In price and quality,how does the unit's product compare with those of its competitors?</td>
                                  </tr>
										  <% vecCol =(ArrayList)vecRow.get(6);%>
                                  <tr> 
                                    <td width="21%" align="right"> 
                                      <textarea name="hidDescVal7" cols="135" rows="5" wrap="VIRTUAL"><%=vecCol.get(0)%></textarea>
                                    </td>
                                  </tr>

                                  <tr> 
                                    <td width="21%">Is 
                                      the Unit selling direct to its cutomers? 
                                      If so, please furnish details like sales 
                                      force, showrooms depots etc.</td>
                                  </tr>
										  <% vecCol =(ArrayList)vecRow.get(7);%>
                                  <tr> 
                                    <td width="21%" align="right">
                                      <textarea name="hidDescVal8" cols="135" rows="5" wrap="VIRTUAL"><%=vecCol.get(0)%></textarea>
                                    </td>
                                  </tr>
					  <%}else{%>  
								<tr>		
                                    <td width="74%" align="right"> 
                                      <textarea name="hidDescVal1" cols="135" rows="5" wrap="VIRTUAL"></textarea>
                                    </td>
                                  </tr>
                                </table>
                              </td>
                            </tr>
                            <tr> 
                              <td width="35%"> 
                                <table width="100%" border="0" cellspacing="1" cellpadding="5" class="outertable">
                                  <tr> 
                                    <td width="29%">Whether 
                                      the product is reserved exclusively for 
                                      the SSI sector ? If so, please furnish Item 
                                      Code No.</td>
							 <td width="27%"> 
                                      <input type="text" name="hidDescVal2" size="25" value="">
                                    </td>
                                    <td width="21%">Name 
                                      of the Major customers</td>
										
                                    <td width="23%" align="right"> 
                                      <input type="text" name="hidDescVal3" size="25" value="" onKeyPress="formattext()">
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td width="29%">Region 
                                      / Area where the product is / will be sold</td>
										
                                    <td width="27%"> 
                                      <input type="text" name="hidDescVal4" size="25" value="">
                                    </td>
                                    <td width="21%">Extent 
                                      of competition &amp; No. of Units engaged 
                                      in similar line in the area</td>
										
                                    <td width="23%" align="right"> 
                                      <input type="text" name="hidDescVal5" size="25" value="">
                                    </td>
                                  </tr>
                                </table>
                              </td>
                            </tr>
                            <tr>
                              <td width="35%">
                                <table width="100%" border="0" cellspacing="1" cellpadding="5" class="outertable">
                                  <tr> 
                                    <td width="21%">How 
                                      does the unit meet / propose to meet the 
                                      competition ?</td>
                                  </tr>
									
                                  <tr> 
                                    <td width="21%" align="right"> 
                                      <textarea name="hidDescVal6" cols="135" rows="5" wrap="VIRTUAL"></textarea>
                                    </td>
                                  </tr>
										   <tr> 
                                    <td width="21%">In price and quality,how does the unit's product compare with those of its competitors?</td>
                                  </tr>
										  
                                  <tr> 
                                    <td width="21%" align="right"> 
                                      <textarea name="hidDescVal7" cols="135" rows="5" wrap="VIRTUAL"></textarea>
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td width="21%">Is 
                                      the Unit selling direct to its cutomers? 
                                      If so, please furnish details like sales 
                                      force, showrooms depots etc.</td>
                                  </tr>
										 
                                  <tr> 
                                    <td width="21%" align="right"> 
                                      <textarea name="hidDescVal8" cols="135" rows="5" wrap="VIRTUAL"></textarea>
                                    </td>
                                  </tr>						
						<%}if(strCategoryType.equalsIgnoreCase("SSI")){%>		
							<tr>
								<td align="center"><input type="button" name="cmdanticipted"
								value="Anticipated Turnover"
								class="buttonStyle" style="width:150"
								onclick="AnticipatedTurnover_SSI()"></td>
							</tr>
							<%}
							else if(strCategoryType.equalsIgnoreCase("OPS"))
							{
							%>
							<tr>
								<td align="center"><input type="button" name="cmdanticipted"
								value="Anticipated Turnover"
								class="buttonStyle" style="width:150"
								onclick="AnticipatedTurnover_AGR()"></td>
							</tr>
							<%} %>
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
        </td>
    </tr>
  </table>
  <br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<br> 
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidDesc1" value="Marketing">
<input type="hidden" name="hidDesc2" value="ProductItemCodeNo">
<input type="hidden" name="hidDesc3" value="NameMajorcustomers">
<input type="hidden" name="hidDesc4" value="Region/Area ">
<input type="hidden" name="hidDesc5" value="ExtentofcompetitionandNoOfUnits ">
<input type="hidden" name="hidDesc6" value="Howdoesunitmeet/propose ">
<input type="hidden" name="hidDesc7" value="Unitsellingdirecttocutomers">
<input type="hidden" name="hidDesc8" value="Pricaandquality">
<input type="hidden" name="hidTotalDesc" value="8">
<input type="hidden" name="otherGenTable" value="">
<input type="hidden" name="genTable" value="yes">
</form>
</body>
</html>
