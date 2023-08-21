<%@include file="../share/directives.jsp"%>
<%
String PageType =Helper.correctNull((String) hshValues.get("PageType"));
ArrayList vecrow = new ArrayList();
ArrayList veccol = new ArrayList();
int vecsize = 0;
String tractortype = "";
String tractorreason = "";
String machinerytype = "";
String machineryreason = "";
if (hshValues != null) {
	vecrow = (ArrayList) hshValues.get("vecData");
	vecsize = vecrow.size();
	}
java.text.NumberFormat nf=java.text.NumberFormat.getInstance();
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);
nf.setGroupingUsed(false);
String strFreeze=Helper.correctNull((String)request.getParameter("hidFreeze"));

String prd_type = Helper.correctNull((String) session.getAttribute("strProductType"));
String strPrdPurpose=Helper.correctNull((String) session.getAttribute("strPrdPurpose"));
String strProAvailableFor =Helper.correctNull((String) hshValues.get("prd_applicablefor"));
int linkid = Integer.parseInt(Helper.correctInt(request.getParameter("linkid")));
String strFreezeflag = Helper.correctNull((String)hshValues.get("strFreezeflag"));
String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();

%>
<html>
<head>
<title>Personal - Solar Light</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>	
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var seltract = "<%=Helper.correctNull((String)hshValues.get("seltractor"))%>";
var selmachin = "<%=Helper.correctNull((String)hshValues.get("selmachinery"))%>";
var SALARYTOSB = "<%=Helper.correctNull((String)hshValues.get("SALARYTOSB"))%>";
var ADEQUATE_INCOME = "<%=Helper.correctNull((String)hshValues.get("ADEQUATE_INCOME"))%>";
var varstrFreeze="<%=strFreeze%>";

function callhelp()
{
	var varQryString = appUrl+"/jsp/perhlp/hlp_educourse.jsp";
	var title = "ApplicantDemographics";
	var prop = "scrollbars=no,width=600,height=450";	
	prop = prop + ",left=200,top=150";
	window.open(varQryString,title,prop);
}

function enableButtons(bool1, bool2, bool3, bool4, bool5)
{	
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
}

function doClose()
{
	if( ConfirmMsg(100))
	{
		parent.menuFrame.doWindowClose();
	}
}

function doSave()
{

  for(i=0;i<7;i++)
  {
   if(document.forms[0].txt_particulars[i].value!="")
   {
   		if(document.forms[0].txt_hp[i].value=="")
   		{
   			ShowAlert('121','Quotation no & Date');
   		document.forms[0].txt_hp[i].focus();
   		return;
   		}
   }
   
  }
  	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidBeanId.value="agreconomic";		
	document.forms[0].hidSourceUrl.value="/action/per_solarlight.jsp";
	document.forms[0].hidBeanMethod.value="updateSolarlightData";
	document.forms[0].hidBeanGetMethod.value="getSolarlightData";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();	
}

function doEdit()
{
 	disableFields(false);
 	callfilldata();
	document.forms[0].hidAction.value ="update"; 
	enableButtons(true, false, false, false, true);
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidAction.value ="";
		document.forms[0].hidBeanId.value="agreconomic";
		document.forms[0].hidBeanGetMethod.value="getSolarlightData";
		document.forms[0].action=appUrl+"action/per_solarlight.jsp";
		document.forms[0].submit(); 	
	}
}

function doDelete()
{
	if( ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appUrl+"action/ControllerServlet";	
		document.forms[0].hidBeanMethod.value="updateSolarlightData";
		document.forms[0].hidBeanGetMethod.value="getSolarlightData";
		document.forms[0].hidBeanId.value="agreconomic";
		document.forms[0].hidSourceUrl.value="/action/per_solarlight.jsp";	
		document.forms[0].method="post";			
		document.forms[0].submit();	
	} 
}
	
function disableFields(one)
{	
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
		 if(document.forms[0].elements[i].name=='txt_loanamt')continue;
		  if( document.forms[0].elements[i].name=='txt_totloanamt')continue;
			document.forms[0].elements[i].readOnly=one;
		}	  
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=one;
		}
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=one;		  
		}		
		
	} 
		
}	

function onloading()
{
	callfilldata();
	document.all.r1.style.visibility="hidden";
	document.all.r2.style.visibility="hidden";
	document.all.r3.style.visibility="hidden";
	document.all.r4.style.visibility="hidden";	
	if(seltract!="")
	{	
		document.forms[0].sel_tractor.value=seltract;
	}
	if(selmachin!="")
	{
		document.forms[0].sel_machinery.value=selmachin;
	}
	if(SALARYTOSB!="")
	{
		document.forms[0].sel_salrytoSB.value=SALARYTOSB;
	}
	if(ADEQUATE_INCOME!="")
	{
		document.forms[0].sel_adeqincsrc.value=ADEQUATE_INCOME;
	}
	if(seltract=="2")
	{
		document.all.r1.style.visibility="visible";
		document.all.r2.style.visibility="visible";
	}
	else if(seltract=="1")
	{
		document.all.r1.style.visibility="hidden";
		document.all.r2.style.visibility="hidden";
	}
	if(selmachin=="2")
	{
		document.all.r3.style.visibility="visible";
		document.all.r4.style.visibility="visible";
	}
	else if(selmachin=="1")
	{
		document.all.r3.style.visibility="hidden";
		document.all.r4.style.visibility="hidden";
	}
	disableFields(true);
	var strUserMode="";
	strUserMode=document.forms[0].hidUsrMode.value;
	if(strUserMode=='MAKER_MODE')
	{
		disabledFields(true);
		disableEditButtons(false, true, true, false, false, false);
	}
	else if(strUserMode=='CHECKER_MODE')
	{
		disabledFields(true);
		disableEditButtons(true, true, true, true, false, false);
	}
	else if(strUserMode=='VIEW_MODE')
	{
		disabledFields(true);
		disableEditButtons(true, true, true, true, false, false);
	}
	document.forms[0].cmddelete.disabled=true; 

	if(varstrFreeze=='Y')
	{
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmdsave.disabled=true;
	}
}

function tractormeth()
{
	if(document.forms[0].sel_tractor.value=="2")
	{
		document.all.r1.style.visibility="visible";
		document.all.r2.style.visibility="visible";
	}
	else
	{
		document.all.r1.style.visibility="hidden";
		document.all.r2.style.visibility="hidden";
		document.forms[0].txt_tractorreason.value="";
	}
}

function machinerymeth()
{
	if(document.forms[0].sel_machinery.value=="2")
	{
		document.all.r3.style.visibility="visible";
		document.all.r4.style.visibility="visible";
	}
	else
	{
		document.all.r3.style.visibility="hidden";
		document.all.r4.style.visibility="hidden";
		document.forms[0].txt_machineryreason.value="";
	}
}
function totloanamtmeth()
{
	var totloanamt=0;
	document.forms[0].txt_totloanamt.value="";
	for(var i=0; i<7; i++)
	{
		var temp = document.forms[0].txt_loanamt[i].value;
		
		if(temp == "")
		{
			temp=0;
		}
		totloanamt = eval(totloanamt) + eval(temp);
	}
	document.forms[0].txt_totloanamt.value=totloanamt;
	
}

function doCal()
	{
   var unit=0.00,cost=0.00;
   for(i=0;i<7;i++)
	{
 	
   var unit=document.forms[0].txt_estimcost[i].value;
   var cost=document.forms[0].txt_margin[i].value;
   var total=0;
   if(unit==""){
      unit="1";
     
   }
   if(cost==""){
      cost="0";
   }
        
   total=eval(cost)*eval(unit);
   document.forms[0].txt_loanamt[i].value=total;
   roundtxt(document.forms[0].txt_loanamt[i]); 
   roundtxt(document.forms[0].txt_margin[i]); 
   }
}
function callfilldata()
{
	for(var i=0;i<7;i++)
	{
		if((i==0) || (i==1) ||(i==2))
		{
	
			document.forms[0].txt_particulars[0].value='Cost as per Prof. Invoice';
			document.forms[0].txt_particulars[1].value='Installation Charges';
			document.forms[0].txt_particulars[2].value='Cost of Accessories';
			document.forms[0].txt_particulars[0].readOnly=true;
			document.forms[0].txt_particulars[1].readOnly=true;
			document.forms[0].txt_particulars[2].readOnly=true;
	
		}
		
		else
		{
		}
	}
	}
function gototab(beanid,methodname,pagename)
{
		document.forms[0].hidBeanId.value=beanid;
		document.forms[0].hidBeanGetMethod.value=methodname;
		document.forms[0].action=appURL+"action/"+pagename;
		document.forms[0].submit();
	
}
function callalert()
{
	alert("Click Freeze in Attached Securities page to view Security Coverage");
	return;
}

function callLink(page,bean,method)
{ 
		if (document.forms[0].cmdsave.disabled)
		{
			document.forms[0].hidAction.value="";
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
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onloading()">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems"><script language="JavaScript1.2">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script></div>
</div>
<form name="" method="post" class="normal">

<%if(!Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../share/Applurllinkper.jsp" flush="true"> 
        <jsp:param name="pageid" value="22" />
        </jsp:include>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
	 <%if(strSessionModuleType.equals("AGR")){%>
		<td class="page_flow">Home -&gt; Agriculture -&gt;Application -&gt; Security Master -&gt; Security </td>
	<%}else{%>
		<td class="page_flow">Home -&gt; Retail(including schematic) -&gt; Application  -&gt; Security Master -&gt; Security</td>
		<%} %>			
	</tr>
</table>
<span style="display: none"><lapschoice:borrowertype /></span> <lapschoice:application />
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr>
      <td>
        <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
          <tr align="center"> 
            <td align="center" width="15%" class="sub_tab_inactive"><b><b><a href="#" onclick="javascript:callLink('securitymaster_retail.jsp','bankappfi','getSecurityRetailDetails')">Borrower Securities</a></b></b>
            </td>
            <td align="center" width="15%" class="sub_tab_inactive"><b><b><a
					href="#" onclick="javascript:callLink('attachedsecurities_retail.jsp','bankappfi','getAttachedRetailSecurityDetails')">Attached Securities</a></b></b></td>
        
           <%if(strSessionModuleType.equals("RET")){ %>
           
          	<%
				  if (prd_type.substring(0, 1).equalsIgnoreCase("p")
								&& !prd_type.equalsIgnoreCase("pE")
								&& !prd_type.equalsIgnoreCase("pG")
								&& !prd_type.equalsIgnoreCase("pM")
								&& !prd_type.equalsIgnoreCase("pL")
								&& !prd_type.equalsIgnoreCase("pI")) {
							if (linkid == 5) {
				%>
				<td class="sub_tab_active" WIDTH="15%" nowrap="nowrap"><b>Proposed/Offered
				Asset</b></td>
				<%
					} else if ((prd_type.equalsIgnoreCase("pH")&& !(strPrdPurpose.equalsIgnoreCase("F")||strPrdPurpose.equalsIgnoreCase("T")||strPrdPurpose.equalsIgnoreCase("HC")))
									|| prd_type.equalsIgnoreCase("pM")
									|| prd_type.equalsIgnoreCase("pI")
									|| prd_type.equalsIgnoreCase("pT")) {
				%>
				<td class="sub_tab_inactive" WIDTH="15%" nowrap="nowrap"><a
					href="JavaScript:gototab('perpropertydetails','getHousingLoanData','per_house_proposed_asset.jsp')"><b>Proposed/Offered
				Asset</b></a></td>
				<%
					} else if (prd_type.equalsIgnoreCase("pA")||(prd_type.equalsIgnoreCase("pU") && strProAvailableFor.equalsIgnoreCase("V"))) {
				%>
				<td class="sub_tab_inactive" WIDTH="15%" nowrap="nowrap"><a
					href="JavaScript:gototab('percollateral','getBoatAuto','perappvehicle.jsp')"><b>Proposed/Offered
				Asset</b></a></td>
				<%
					} else if (prd_type.equalsIgnoreCase("pD")) {
				%>
				<td class="sub_tab_inactive" WIDTH="15%" nowrap="nowrap"><a
					href="JavaScript:gototab('perpropertydetails','getOtherAssetData','otherassets.jsp')"><b>Proposed/Offered
				Asset</b></a></td>
				<%
					} else if (prd_type.equalsIgnoreCase("pK")) {
				%>
				<td class="sub_tab_active" WIDTH="15%" nowrap="nowrap"><a
					href="JavaScript:gototab('agreconomic','getSolarlightData','per_solarlight.jsp')"><b>Proposed/Offered
				Asset</b></a></td>
				<%
					}
						}	
         		 %>
          <% } %>
          
          <%
			if(strFreezeflag.equalsIgnoreCase("Y")){%>
		 	<td align="center" width="15%" class="sub_tab_inactive_new"><b>
		 	 	<a href="JavaScript:callLink('com_attchsecuritydisplay_reatail.jsp','securitymaster','getCollateralSecurityDisplayretail')">
			 	Security Coverage</a></b></td>				
			<% }else{%>
			<td align="center" width="15%" class="sub_tab_inactive_new" align="center"><b><a href="JavaScript:callalert()">Security Coverage</a></b></td>
			
				<%} %>
				
			<td align="center" width="15%" class="sub_tab_inactive"><b><b><a href="#" onclick="javascript:callLinkComments('per_commentsonseccovergae.jsp','facilities','getComments','secoverageretail')">Comments on Security Coverage</a></b></b></td>	
			<td align="center" width="15%" class="sub_tab_inactive"><b><b><a href="#" onclick="javascript:callMDTD()">MDTD</a></b></b></td>	
          
          </tr>
        </table>
      </td>
    </tr>
  </table>
  
  <%} %>

  <table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
    <tr> 
      <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0"
			align="left" class="outertable">
          <tr> 
            <td>
              <jsp:include page="../per/ProposedAssetTabs.jsp"
					flush="true"> 
              <jsp:param name="tabid" value="7" />
              </jsp:include>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <br>
		<table width="100%" border="0" cellpadding="5" cellspacing="0">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="2">
			<tr>
				<td>
				<table width="100%" border="1" cellspacing="0" cellpadding="3">
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="1" cellpadding="3">
							<tr class="dataHeader">
								<td colspan="6" align="center" ><font
									color="" size="1" face="MS Sans Serif"><b>Particulars of
								Investment</b></font></td>
							</tr>
							<tr class="dataHeader">
								<td width="14%" align="center" ><font
									color="" size="1" face="MS Sans Serif"> Particulars</font></td>
								<td width="12%" align="center" ><font
									face="MS Sans Serif" size="1" color="">Name of the  supplier</font></td>
								<td width="12%" align="center" ><font
									face="MS Sans Serif" size="1" color="">Quotation no &amp; Date
									<span class="mantatory">*</span>
									</font></td>
								<td width="12%" align="center" ><font
									face="MS Sans Serif" size="1" color="">No. of Units </font></td>
								<td width="12%" align="center" ><font
									face="MS Sans Serif" size="1" color="">Rate per unit</font></td>
								<td width="12%" align="center" ><font
									face="MS Sans Serif" size="1" color="">Total Cost</font></td>
							</tr>
							<%if(vecsize>0){
							for (int i = 0; i < vecsize; i++) {
								veccol = (ArrayList) vecrow.get(i);
								tractortype =Helper.correctNull((String)veccol.get(10));
								tractorreason =Helper.correctNull((String)veccol.get(11));
								machinerytype =Helper.correctNull((String)veccol.get(12));
								machineryreason =Helper.correctNull((String)veccol.get(13));
							%>
							<tr>
								<td align="center"><input type="text" name="txt_particulars"
									value="<%=Helper.correctNull((String)veccol.get(1))%>" size="53" maxlength="99" style="text-align:left"></td>
								<td align="center"><font color="#000000"> <input type="text"
									name="txt_make" value="<%=Helper.correctNull((String)veccol.get(2))%>" size="20" maxlength="49"
									onKeyPress="notAllowSplChar();notallowInteger();" style="text-align:left"> </font></td>
								<td align="center"><input type="text" name="txt_hp" value="<%=Helper.correctNull((String)veccol.get(3))%>"
									size="15" maxlength="30" onKeyPress="notAllowSingleQuote()"
									style="text-align:left"></td>
								<td align="center"><input type="text" name="txt_estimcost"
									value="<%=Helper.correctNull((String)veccol.get(4))%>" size="8" maxlength="5" onKeyPress="allowNumber(this)" onBlur="doCal();;totloanamtmeth();"
									style="text-align:right"></td>
								<td align="center"><input type="text" name="txt_margin" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)veccol.get(5))))%>"
									size="12" maxlength="8" onKeyPress="allowDecimals(this)" onBlur="doCal();roundtxt(this);totloanamtmeth()"
									style="text-align:right"></td>
								<td align="center"><input type="text" name="txt_loanamt" 
									value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)veccol.get(6))))%>" size="12" maxlength="9"
									onKeyPress="allowDecimals(this)" onBlur="doCal();totloanamtmeth();roundtxt(this)" style="text-align:right" readOnly></td>
							</tr>
							<%}}else{
							for (int i = 0; i < 7; i++) {%>
							<tr>
								<td align="center"><input type="text" name="txt_particulars"
									value="" size="53" maxlength="99" style="text-align:left"></td>
								<td align="center"><font color="#000000"> <input type="text"
									name="txt_make" value="" size="20" maxlength="49"
									onKeyPress="notAllowSplChar();notallowInteger();" style="text-align:right"> </font></td>
								<td align="center"><input type="text" name="txt_hp" value=""
									size="15" maxlength="30" onKeyPress="notAllowSingleQuote()"
									style="text-align:right"></td>
								<td align="center"><input type="text" name="txt_estimcost"
									value="" size="8" maxlength="5" onKeyPress=""onBlur="doCal();totloanamtmeth();"
									style="text-align:right"></td>
								<td align="center"><input type="text" name="txt_margin" value=""
									size="12" maxlength="8" onKeyPress="allowDecimals(this)" onBlur="doCal();;totloanamtmeth();roundtxt(this)"
									style="text-align:right"></td>
								<td align="center"><input type="text" name="txt_loanamt" onBlur="doCal();totloanamtmeth();roundtxt(this)"
									value="" size="12" maxlength="9"
									onKeyPress="allowDecimals(this)" style="text-align:right" readOnly></td>
							</tr>
							<%}} %>
							<tr>
								<td colspan="3" align="right"><font size="1"
									face="MS Sans Serif">&nbsp;</font></td>
								<td align="center">&nbsp;</td>
								<td align="center"><b>Total Cost&nbsp;</b></td>
								<td align="center"><input type="text" readOnly name="txt_totloanamt"
									value="<%if(nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("totloanamt")))).equalsIgnoreCase("0.00"))
									{
										out.println("");
										
									}
									else
									{
											out.println(nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("totloanamt")))));
									}
									%>" size="12" maxlength="9"
									onKeyPress="allowDecimals(this)" style="text-align:right"></td>
							</tr>
							<tr>
								<td colspan="3" align="left"><font size="1" face="MS Sans Serif">Whether
								the machinery proposed to be purchased as per BIS code
								of CF MT T I &nbsp;(Commercial Test Report)</font></td>
								<td align="center">&nbsp; <select name="sel_tractor" onChange="tractormeth()">
									<option value="1" selected <%if(tractortype.equalsIgnoreCase("1")){ out.println("Selected");}%>>Yes</option>
									<option value="2" <%if(tractortype.equalsIgnoreCase("2")){ out.println("Selected");}%>>No</option>
								</select></td>
								<td align="center" id="r1">&nbsp;<font size="1" face="MS Sans Serif">Give
								Reason </font></td>
								<td align="center" id="r2">&nbsp;<textarea name="txt_tractorreason" rows="2"
									cols="20" onKeyPress="textlimit(this,399)" onKeyUp="textlimit(this,399)"><%=tractorreason%> </textarea></td>
									
							</tr>
							<tr>
								<td colspan="3" align="left"><font size="1" face="MS Sans Serif">Whether
								the other farm machinery / implements meets BIS standard</font></td>
								<td align="center">&nbsp;<select name="sel_machinery" onChange="machinerymeth()">
									<option value="1" selected <%if(machinerytype.equalsIgnoreCase("1")){ out.println("Selected");}%>>Yes</option>
									<option value="2" <%if(machinerytype.equalsIgnoreCase("2")){ out.println("Selected");}%>>No</option>
									</select></td>
								<td align="center" id="r3">&nbsp;<font size="1" face="MS Sans Serif">Give
								Reason </font></td>
								<td align="center" id="r4">&nbsp;<textarea name="txt_machineryreason" rows="2"
									cols="20" onKeyPress="textlimit(this,399)" onKeyUp="textlimit(this,399)"><%=machineryreason%></textarea></td>
								
							</tr>
							<tr>
							<td colspan="3"><font size="1" face="MS Sans Serif">Where salary of the applicant is directly credited to his SB A/c with the branch under an irrevocable arrangement with the salary disbursing authority and he/she has produced an irrevocable letter of authority to debit his/ her account towards the monthly installment payable.</font></td>
							<td align="center"><select name="sel_salrytoSB">
									<option value="Y">Yes</option>
									<option value="N">No</option>
								</select></td>
							</tr>
							<tr>
							<td colspan="3"><font size="1" face="MS Sans Serif">Whether the applicant has adequate income source</font></td>
							<td align="center"><select name="sel_adeqincsrc">
									<option value="Y">Yes</option>
									<option value="N">No</option>
								</select></td>
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
	<tr>
	<td>
	
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete'	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
</td>
</tr>
</table>
<input type="hidden" name="hidAction" value=""> 
<INPUT TYPE="hidden" name="hidBeanId" value=""> 
<input type="hidden" name="hidBeanMethod" value=""> 
<INPUT TYPE="hidden" name="hidBeanGetMethod" value=""> 
<input type="hidden" name="hidSourceUrl" value="">
<input type="hidden" name="hidUsrMode" value="<%=session.getAttribute("strUserMode")%>">
<input type="hidden" name="hpage">
</form>
</body>
</html>