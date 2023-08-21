<%@include file="../share/directives.jsp"%>
<%@ page import="java.text.DecimalFormat"%>
<%
	  String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
	  ArrayList arrSecRow = new ArrayList();
	  ArrayList arrSecCol = new ArrayList();
  	  ArrayList arrAttachRow=new ArrayList();
  	  ArrayList arrAttachCol = new ArrayList();
	  if(hshValues!=null)
	  {
		  arrSecRow = (ArrayList) hshValues.get("arrSecRow");
		  arrAttachRow = (ArrayList)hshValues.get("arrAttachRow");
	  }
	  int intLength =0;
	  if(arrSecRow!=null)
	  {
		  intLength=arrSecRow.size();
	  }
	  String strApplicant = Helper.correctNull((String)hshValues.get("strcmpId"));
	  String strAppId = Helper.correctNull((String)hshValues.get("strappId"));
	  String sectype = Helper.correctNull((String) request.getParameter("hidsectype"));
	  String strBorrowerType =Helper.correctNull((String)request.getParameter("hidBorrowerType"));
	  String strFreezeflag = Helper.correctNull((String)hshValues.get("strFreezeflag"));
	  DecimalFormat dc=new DecimalFormat();
		dc.setGroupingUsed(false);
		dc.setMaximumFractionDigits(2);
		dc.setMinimumFractionDigits(2);
		String propsecFlag= Helper.correctNull((String)hshValues.get("propsecFlag"));
		
		
		String prd_type = Helper.correctNull((String) session.getAttribute("strProductType"));
		String strPrdPurpose=Helper.correctNull((String) session.getAttribute("strPrdPurpose"));
		String strProAvailableFor =Helper.correctNull((String) hshValues.get("prd_applicablefor"));
		int linkid = Integer.parseInt(Helper.correctInt(request.getParameter("linkid")));
		
		session.setAttribute("HouseEdit_Flag", Helper.correctNull((String)hshValues.get("HouseEdit_Flag"))); 
		session.setAttribute("valuationFlag", Helper.correctNull((String)hshValues.get("valuationFlag"))); 
		session.setAttribute("VehicleEdit_Flag", Helper.correctNull((String)hshValues.get("VehicleEdit_Flag"))); 
		
	%>
<html>
<head>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varCategoryType = "<%=strCategoryType%>";
var varApplicant = "<%=strApplicant%>";
var varlength = "<%=intLength%>";
var varFreeze="<%=strFreezeflag%>";
var varappstatus="<%=Helper.correctNull(request.getParameter("appstatus"))%>";
var propsecFlag="<%=propsecFlag%>";
function Onloading()
{
	disabledFields(true);
	document.forms[0].sel_applicants.value=varApplicant;
	if(varFreeze=="Y")
	{
		document.forms[0].cmdrelease.disabled=true;
		enableButtons(true,true,true,true,false);
	}
	if(varlength>0)
	{
		if(varlength==1)
		{
			document.forms[0].cmdattach.disabled=true
		}
		else
		{
			for(var i=0;i<document.forms[0].cmdattach.length;i++)
			{
				document.forms[0].cmdattach[i].disabled=true
			}
		}
	}
	document.forms[0].sel_applicants.value=varApplicant;
	document.forms[0].sel_applicants.disabled=false;
	//if(propsecFlag=="Y")
		//document.forms[0].coll_mdtd.disabled=false;
	//else
		//document.forms[0].coll_mdtd.disabled=true;
	
}
function enableButtons(bool1, bool2, bool3, bool4,bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
}
function doEdit()
{
	document.forms[0].hideditflag.value="Y";
	document.forms[0].hidAction.value="update";
	disabledFields(false);
	enableButtons(true,false,false,false,true);	
	document.forms[0].sel_applicants.disabled = true;
	if(varlength==1)
	{
		document.all.cmdview.disabled=false;
		document.all.cmdattach.disabled=false;
	}
	else 
	{
		for(var i=0;i<varlength;i++)
		{
			document.all.cmdview[i].disabled=false;
			document.all.cmdattach[i].disabled=false;
		}
	}
	//doAttchbtn();

	if(varFreeze=="Y")
	{
		document.forms[0].cmdrelease.disabled=true;
		if(varlength==1)
		{
			document.all.cmdattach.disabled=true;
		}
		else 
		{
			for(var i=0;i<varlength;i++)
			{
				document.all.cmdattach[i].disabled=true;
			}
		}
	}
	if(document.forms[0].hidPSparams.value!="")
	{
		document.forms[0].cmddelete.disabled=true;
	}
	var varPSterms = document.forms[0].hidPSparams.value.split("@");
	for(var i=0;i<varPSterms.length;i++)
	{
		if(varPSterms[i] == "SEC")
		{
			document.forms[0].cmddelete.disabled=false;
		}
	}
}

function doAttchbtn()
{
	var varCleanflag="";
	if(varlength==1)
	{
		document.all.cmdview.disabled=false;
		document.all.cmdattach.disabled=false;
	}
	else 
	{
		for(var i=0;i<varlength;i++)
		{
			var varhidtype = document.all.hidType[i].value;
			var varhidsecCategory = document.all.hidsecCategory[i].value;
			if((varhidtype=="P"||varhidtype.indexOf("P~")!= -1) && (varhidsecCategory=="1"||varhidsecCategory.indexOf("1~")!= -1))
			{
				varCleanflag = "Y";
				break;
			}
			else if((varhidtype=="P"||varhidtype.indexOf("P~")!= -1) && (varhidsecCategory!="1"||varhidsecCategory.indexOf("1~")== -1))
			{
				varCleanflag = "N";
			}
		}
		
		for(var i=0;i<varlength;i++)
		{
			var varhidtype = document.all.hidType[i].value;
			var varhidsecCategory = document.all.hidsecCategory[i].value;
			if(varCleanflag == "Y")
			{
				if((varhidtype=="P"||varhidtype.indexOf("P~")!= -1) && (varhidsecCategory=="1"||varhidsecCategory.indexOf("1~")!= -1))
				{
					document.all.cmdview[i].disabled=false;
					document.all.cmdattach[i].disabled=false;
				}
				else
				{
					document.all.cmdview[i].disabled=true;
					document.all.cmdattach[i].disabled=true;
				}
			}
			else if(varCleanflag == "N")
			{
				if(varhidsecCategory=="1"||varhidsecCategory.indexOf("1~")!= -1)
				{
					document.all.cmdview[i].disabled=true;
					document.all.cmdattach[i].disabled=true;
				}
				else
				{
					document.all.cmdview[i].disabled=false;
					document.all.cmdattach[i].disabled=false;
				}
			}
			else
			{
				document.all.cmdview[i].disabled=false;
				document.all.cmdattach[i].disabled=false;
			}
		}
	}
}

function doSave()
{
	if(document.forms[0].sel_applicants.value=="0")
	{
		ShowAlert('121', "Applicant"); 	
		document.forms[0].sel_applicants.focus();
		return;	
	}
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hid_categoryType.value = varCategoryType;
	document.forms[0].hidBeanId.value="bankappfi"
	document.forms[0].hidBeanMethod.value="updateSecurityRetailDetails";
	document.forms[0].hidBeanGetMethod.value="getSecurityRetailDetails";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/securitymaster_retail.jsp";
	document.forms[0].submit();
}
function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="bankappfi"
		document.forms[0].hidBeanGetMethod.value="getSecurityRetailDetails";
		document.forms[0].action=appURL+"action/securitymaster_retail.jsp";
		document.forms[0].submit();
	 }
}
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].method="post";
		document.forms[0].action=appURL+"action/corppge.jsp";
		document.forms[0].submit();
	}
}
function reloadSecurityDetails()
{
	document.forms[0].hidBeanId.value="bankappfi";
	document.forms[0].hidBeanGetMethod.value="getSecurityRetailDetails";
	document.forms[0].action=appURL+"action/securitymaster_retail.jsp";
	document.forms[0].submit();
}
function showsecurities(val)
{
	if (document.forms[0].hideditflag.value=="Y")
	{
		var varSecID="";
		var varSecType="";
		if(varlength==1)
		{
			varSecType = document.forms[0].hidSecClass.value;
			varSecID = document.forms[0].hidSecID.value;
		}
		else
		{
			varSecType = document.forms[0].hidSecClass[val].value;
			varSecID = document.forms[0].hidSecID[val].value;
		}
		document.forms[0].hidBeanId.value="bankappfi";
		document.forms[0].hidBeanGetMethod.value="getRetailSecuritiesbySecId";
		document.forms[0].action=appURL+"action/security_detailsdisp_retail.jsp?hidsectype="+varSecType+"&hidsecid="+varSecID+"&pagefrom=appl";
		document.forms[0].submit();
	}
	else
	{
		return false;
	}
}
function callAttach(val) 
{
	var hidVal=val;
	var hidFacID="0";
	var hidSecID="0";
	var secValue="0";
	var resiValue="0";
	var secclassification="0";
	var appno=document.forms[0].hidappno.value;
	if(varlength==1)
	{
		 hidFacID=document.forms[0].hidFacID.value;
		 hidSecID=document.forms[0].hidSecID.value;
		 secValue=document.forms[0].hid_securityVal.value;
		 resiValue=document.forms[0].hid_residualVal.value;
		 appno=document.forms[0].hidappno.value;
		 secclassification=document.forms[0].hidsecClassification.value;
		 var applicantid=document.forms[0].hidBowID.value;
	}
	else
	{
		 hidVal=val;
		 hidFacID=document.forms[0].hidFacID[val].value;
		 hidSecID=document.forms[0].hidSecID[val].value;
		 secValue=document.forms[0].hid_securityVal[val].value;
		 resiValue=document.forms[0].hid_residualVal[val].value;
		 appno=document.forms[0].hidappno.value;
		 secclassification=document.forms[0].hidsecClassification[val].value;
		 var applicantid=document.forms[0].hidBowID[val].value;
	}
	var varQryString = appURL + "action/attachSecurities_retail.jsp?hidBeanId=bankappfi&hidBeanGetMethod=getattachRetailSecurity&secValue="+secValue+"&resiValue="+resiValue+"&hidposition="+hidVal+"&appno="+appno+"&hidFacIDlist="+hidFacID+"&hidSecID="+hidSecID+"&hidsize="+document.forms[0].hidsize.value+"&applicantid="+applicantid+"&secclassifi="+secclassification;
	var title = "Securities";
	var prop = "scrollbars=yes,width=650,height=400,menubar=yes";
	var xpos = (screen.width - 250) / 2;
	var ypos = (screen.height - 120) / 2;
	prop = prop + ",left=50,top=50";
	window.open(varQryString, title, prop);
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
function callalert()
{
	alert("Click Freeze in Attached Securities page to view Security Coverage");
	return;
}
function callprimarysec()
{
	var btnenable=document.forms[0].btnenable.value;
	var hidAppNo=document.forms[0].hidappno.value;
	var prop = "scrollbars=yes,width=750,height=550,top=25,left=180";
	var url=appURL+"action/comments.jsp?hidBeanId=perfinancial&hidBeanGetMethod=getComments&hidAppNo="+hidAppNo+"&hidCommentPage=Retailprimarysec&btnenable="+btnenable+"&appstatus="+varappstatus;
	window.open(url,"Comments",prop);
}
function callcollSec()
{
	var btnenable=document.forms[0].btnenable.value;
	var hidAppNo=document.forms[0].hidappno.value;
	var prop = "scrollbars=yes,width=750,height=550,top=25,left=180";
	var url=appURL+"action/comments.jsp?hidBeanId=perfinancial&hidBeanGetMethod=getComments&hidAppNo="+hidAppNo+"&hidCommentPage=RetailCollateralsec&btnenable="+btnenable+"&appstatus="+varappstatus;
	window.open(url,"Comments",prop);	
}

function callMDTD()
{
	document.forms[0].action=appURL+"action/app_sec_MDTDdetails.jsp";
	document.forms[0].submit();	
}
function callLinkComments(page,bean,method,title)
{
	if (document.forms[0].cmdsave.disabled)
	{
		document.forms[0].hidAction.value="";
	 	document.forms[0].hidBeanGetMethod.value=method;
	 	document.forms[0].hidBeanId.value=bean;
	 	document.forms[0].hpage.value=title;	 
	 	document.forms[0].action=appURL+"action/"+page;
	 	document.forms[0].submit();
	}
	else 
	{
		ShowAlert(103);
	}
}
function callRelease()
{
	var appno=document.forms[0].hidappno.value;
	var varQryString = appURL + "action/app_releaseofsecurities.jsp?hidBeanId=securitymaster&hidBeanGetMethod=getReleaseofSecurity&appno="+appno;
	var title = "Securities";
	var prop = "scrollbars=yes,width=850,height=500,menubar=yes";
	var xpos = (screen.width - 350) / 2;
	var ypos = (screen.height - 120) / 2;
	prop = prop + ",left=50,top=50";
	window.open(varQryString, title, prop);
}
function doDelete()
{	
	if(ConfirmMsg(189))
	{
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidBeanId.value="bankappfi"
		document.forms[0].hidBeanMethod.value="updateSecurityRetailDetails";
		document.forms[0].hidBeanGetMethod.value="getSecurityRetailDetails";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/securitymaster_retail.jsp";
		document.forms[0].submit();
	}
}
</script>
</head>
<body  onLoad="Onloading();">
<form method="post" class="normal">
<%if(!Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){ %>

<% if(strSessionModuleType.equalsIgnoreCase("DIGI")) { %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../share/applurllinkerdigi.jsp" flush="true"> 
        <jsp:param name="pageid" value="22" />
        </jsp:include>
		</td>
	</tr>
</table>
<% } else { %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../share/Applurllinkper.jsp" flush="true"> 
        <jsp:param name="pageid" value="22" />
        </jsp:include>
		</td>
	</tr>
</table>
<% } %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
	 <%if(strSessionModuleType.equals("AGR")){%>
		<td class="page_flow">Home -&gt; Agriculture -&gt;Application -&gt; Security Master -&gt; Security </td>
	<%}else if(strSessionModuleType.equalsIgnoreCase("DIGI")) {%>
		<td class="page_flow">Home -&gt; Digi Retail -&gt; Application  -&gt; Security Master -&gt; Security</td>
	<%} else {%>			
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
            <td align="center" width="15%" class="sub_tab_active"><b>Borrower Securities</b>
            </td>
            <td align="center" width="15%" class="sub_tab_inactive"><b><b><a
					href="#" onclick="javascript:callLink('attachedsecurities_retail.jsp','bankappfi','getAttachedRetailSecurityDetails')">Attached Securities</a></b></b></td>
        
           <%if(strSessionModuleType.equals("RET") || strSessionModuleType.equals("DIGI") ){ %>
           
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
				<td class="sub_tab_inactive" WIDTH="15%" nowrap="nowrap"><a
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
			<td align="center" width="15%" class="sub_tab_inactive"><b><b><a href="#" onclick="javascript:callLink('securitynewtab.jsp','bankappfi','getlegalopinionverification')">Legal opinion verification</a></b></b></td>	
          
          </tr>
        </table>
      </td>
    </tr>
  </table>
<%} else{ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../set/postsanctionlinksper.jsp" flush="true">
			<jsp:param name="pageid" value="4" />
			<jsp:param name="subpageid" value="105" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr>
      <td>
        <table width="80%" border="0" cellspacing="1" cellpadding="3" class="outertable">
          <tr> 
            <td align="center" width="15%" class="sub_tab_active"><b>Security</b>
            </td>
            <td align="center" width="15%" class="sub_tab_inactive"><b><b><a
					href="#" onclick="javascript:callLink('attachedsecurities_retail.jsp','bankappfi','getAttachedRetailSecurityDetails')">Attached Securities</a></b></b></td>
			<%
			if (prd_type.equalsIgnoreCase("pH")&& !(strPrdPurpose.equalsIgnoreCase("F")||strPrdPurpose.equalsIgnoreCase("T")||strPrdPurpose.equalsIgnoreCase("HC"))) {
%>
<td class="sub_tab_inactive" WIDTH="15%" nowrap="nowrap" align="center"><a
	href="JavaScript:gototab('perpropertydetails','getHousingLoanData','per_house_proposed_asset.jsp')"><b>Proposed/Offered
Asset</b></a></td>
<%
	}
			%>
          <%
			if(strFreezeflag.equalsIgnoreCase("Y")){%>
		 	<td align="center" width="15%" class="sub_tab_inactive_new"><b>
		 	 	<a href="JavaScript:callLink('com_attchsecuritydisplay_reatail.jsp','securitymaster','getCollateralSecurityDisplayretail')">
			 	Security Coverage</a></b></td>				
			<% }else{%>
			<td align="center" width="15%" class="sub_tab_inactive_new" align="center"><b><a href="JavaScript:callalert()">Security Coverage</a></b></td>
			
				<%} %>
				
          
          </tr>
        </table>
      </td>
    </tr>
  </table>
<%} %>
  
<table width="100%" cellspacing="0" cellpadding="3" align="center" class="outertable" border="0">
     <tr>
         <td width="35%">&nbsp;</td>
         <td width="10%" align="center">Select Applicant</td>
         <td>
	         <select name="sel_applicants" class="selectwidth" tabindex="1" onchange="reloadSecurityDetails()">
				<option selected value="">&lt;--Select--&gt;</option>
				<%
                	String strAppType="A','C','G','P','O";
                %>
				<lapschoice:coappguarantorsec apptype="<%=strAppType%>" />
		     </select>
		  </td></tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable border1">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="1" cellpadding="5" class="outertable">
			<tr class="dataheader">		
			<td align="center" width="10%">Security ID</td>	                        
					<td align="center" width="25%">Security Type</td>
					<td align="center" width="25%">Classification</td>
					<td align="center" width="25%">Owner Name</td>
					<td align="center" width="15%">Security Value</td>
					<td align="center" width="10%" colspan="2">Action</td>										
			</tr>	
			<%if(arrSecRow !=null && arrSecRow.size()>0 ){ 
			for(int i=0;i<intLength;i++){
				arrSecCol = (ArrayList)arrSecRow.get(i);
				arrAttachCol = (ArrayList)arrAttachRow.get(i);
				%>			
			<tr class="datagrid">	
				<td><input type="hidden" name="hidSecID" value="<%=Helper.correctNull((String)arrSecCol.get(0))%>"><%=Helper.correctNull((String)arrSecCol.get(0))%></td>		                        
				<td align="left" width="20%"><input type="hidden" name="hidID" value="<%=i%>">
											<input type="hidden" name="hidSecExisting" value="<%=arrSecCol.get(12)%>">
											<b><%=Helper.correctNull((String)arrSecCol.get(6))%></b></td>
				<td align="left" width="13%"><input type="hidden" name="hidSecClass" value="<%=Helper.correctNull((String)arrSecCol.get(1))%>"><b><%=Helper.correctNull((String)arrSecCol.get(7))%></b></td>
				<td align="left" width="12%"><b><%=Helper.correctNull((String)arrSecCol.get(3))%></b></td>
				<td width="15%" align="right"><b><%=dc.format(Double.parseDouble(Helper.replaceComma(Helper.correctNull((String)arrSecCol.get(4)))))%><input type="hidden" name="hid_securityVal" value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrSecCol.get(4))))%>"></b></td>
					<input type="hidden" name="hid_residualVal" value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrSecCol.get(5))))%>">
					<input type="hidden" name="sel_exisprop" value="<%=Helper.correctNull((String)arrSecCol.get(10))%>">		
					<input type="hidden" name="hidCollFlag" value="<%=Helper.correctNull((String)arrSecCol.get(9))%>">
				<td width="7%" align="center"><input type="button" name="cmdview" value="View" class="buttonOthers" onClick="showsecurities(<%=i%>)"></td>
				<td width="8%" align="center"><input id="attachbtn" type="button" name="cmdattach" value="Attach" class="buttonOthers" onClick="callAttach('<%=i%>')"></td>	
							<input type="hidden" name="hidFacID" value="<%=Helper.correctNull((String)arrAttachCol.get(0))%>">
							<input type="hidden" name="hidFacSno" value="<%=Helper.correctNull((String)arrAttachCol.get(1))%>">
							<input type="hidden" name="hidFacType" value="<%=Helper.correctNull((String)arrAttachCol.get(2))%>">
							<input type="hidden" name="hidSecMargin" value="<%=Helper.correctNull((String)arrAttachCol.get(3))%>">
							<input type="hidden" name="hidFacNature" value="<%=Helper.correctNull((String)arrAttachCol.get(4))%>">		
							<input type="hidden" name="hidFacLimit" value="<%=Helper.correctNull((String)arrAttachCol.get(5))%>">
							<input type="hidden" name="hidFacOutstand" value="<%=Helper.correctNull((String)arrAttachCol.get(6))%>">
							<input type="hidden" name="hidType" value="<%=Helper.correctNull((String)arrAttachCol.get(7))%>">
							<input type="hidden" name="hidSelect" value="<%=Helper.correctNull((String)arrSecCol.get(13))%>">
							<input type="hidden" name="sel_sectype"  value="<%=Helper.correctNull((String)arrAttachCol.get(8))%>">		
							<input type="hidden" name="hidBowID" value="<%=Helper.correctNull((String)arrAttachCol.get(11))%>">
							<input type="hidden" name="hid_parentappno" value="">
							<input type="hidden" name="hid_parentsno" value="">		
							<input type="hidden" name="hidsecuritytype" value="<%=Helper.correctNull((String)arrAttachCol.get(12))%>">						
							<input type="hidden" name="hidsecCategory" value="<%=Helper.correctNull((String)arrAttachCol.get(13))%>">						
							<input type="hidden" name="hidsecClassification" value="<%=Helper.correctNull((String)arrSecCol.get(2))%>">						
							<input type="hidden" name="hidsharecount" value="<%=Helper.correctNull((String)arrSecCol.get(14))%>">						
			</tr>	
			<%}}else{ %>
			<tr align="center" class="datagrid" align="center">
				<td colspan="8"><b>No Securities Found</b></td>
			</tr>
			<%} %>	
		</table>
		</td>
	</tr>
</table>
<br>
<input type="hidden" name="hid_categoryType" value="">
<lapschoice:combuttonnew btnnames="Edit_Save_Delete_Cancel" btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />
<br>
<table width="25%" align="center" border="0" cellpadding="2" cellspacing="0">
<tr>
	<td style="display:none; "><input type="button" name="cmdrelease" class="buttonstyle" value="Release of Securities" onClick="callRelease()"></td>
	<td><input type="button" name="coll_exifac" class="buttonstyle" value="Comments on Primary Security" onClick="callprimarysec()"></td>
	<td><input type="button" name="coll_exifac" class="buttonstyle" value="Comments on Collateral Security" onClick="callcollSec()"></td>
<!--	<td><input type="button" name="coll_mdtd" class="buttonstyle" value="MDTD" onClick="callMDTD()"></td>-->

</tr>
</table>
<br>
<lapschoice:hiddentag pageid='<%=PageId%>' />
	<input type="hidden" name="hidappno" value="<%=Helper.correctNull((String)request.getParameter("appno")) %>">
	<input type="hidden" name="hidsize" value="<%=intLength%>">
	<input type="hidden" name="hid_applicant" value="<%=strApplicant%>">
	<input type="hidden" name="cattype" value="<%=strCategoryType%>"> 
  	<input type="hidden" name="ssitype" value="<%=strSSIType%>"> 
  	<input type="hidden" name="id" value="<%=strBorrowerType%>">
  	<input type="hidden" name="hidAppId" value="<%=Helper.correctNull((String)hshValues.get("hidAppId"))%>">
    <input type="hidden" name="comapp_compname" value="<%=request.getParameter("comapp_compname")%>">
  	<input type="hidden" name="comapp_compid" value="<%=request.getParameter("comapp_compid")%>">
  	<input type="hidden" name="hpage">
  	<input type="hidden" name="hidPSparams" value="<%=Helper.correctNull((String)hshValues.get("strPostSancParam")) %>">
  	<input type="hidden" name="hidValuationFlag" value="<%=Helper.correctNull((String)hshValues.get("valuationFlag"))%>">
	<input type="hidden" name="hidHouseEdit_Flag" value="<%=Helper.correctNull((String)hshValues.get("HouseEdit_Flag"))%>">
	<input type="hidden" name="hidVehicleEdit_Flag" value="<%=Helper.correctNull((String)hshValues.get("VehicleEdit_Flag"))%>">
</form>
</body>
</html>
