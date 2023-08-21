<%@include file="../share/directives.jsp"%>
<%
	String strCategory = Helper.correctNull((String) request
			.getParameter("hidCategoryType"));

	ArrayList arrRow = new ArrayList();
	ArrayList arrCol = new ArrayList();

	if (hshValues != null) {
		arrRow = (ArrayList) hshValues.get("arrRow");
	}
	java.text.NumberFormat jtn = java.text.NumberFormat.getInstance();
	jtn.setMaximumFractionDigits(2);
	jtn.setMinimumFractionDigits(2);
	jtn.setGroupingUsed(false);

	String strBATypeWC = Helper.correctNull((String) hshValues
			.get("com_wc_bnkarg"));
	String strConsTypeWC = Helper.correctNull((String) hshValues
			.get("com_wc_type"));
	String strBATypeTL = Helper.correctNull((String) hshValues
			.get("com_tl_bnkarg"));
	String strConsTypeTL = Helper.correctNull((String) hshValues
			.get("com_tl_type"));
	String strSessionModuleType = Helper.correctNull(
			(String) session.getAttribute("sessionModuleType")).trim();
	String strcountchk=Helper.correctNull((String) hshValues
			.get("strcountchk"));
	
%>

<html>
<head>
<title>Proposal</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script type="text/javascript">
	var appstatus		= "<%=Helper.correctNull((String) request
							.getParameter("appstatus"))%>";
	var strappno 		= "<%=Helper.correctNull((String) request
									.getParameter("appno"))%>"
	var varRecordFlag	= "<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
	//var proposalnoteCheck="<%=Helper.correctDouble((String) hshValues
							.get("com_proposalnote"))%>";
	
	
	//var annexureCheck="<%=Helper.correctDouble((String) hshValues
							.get("com_annexure"))%>";
							var varmultiplechk=<%=strcountchk%>;
							
	function disableCommandButtons(valnew,valedit,valapply,valcancel,valdel,valclose)
	{
		document.forms[0].cmdnew.disabled =valnew;
		document.forms[0].cmdedit.disabled=valedit;
		document.forms[0].cmddelete.disabled=valdel;
		document.forms[0].cmdsave.disabled=valapply;
		document.forms[0].cmdcancel.disabled=valcancel;
		document.forms[0].cmdclose.disabled=valclose;
	}

	function fnLimitSel(val)
	{
		if(val!="0"&&val!="M")
		{
			document.all.id_MainLimit1.style.visibility	= "visible";
			document.all.id_MainLimit1.style.position	= "relative";
			document.all.id_MainLimit2.style.visibility	= "visible";
			document.all.id_MainLimit2.style.position	= "relative";
		}
		else
		{
			document.all.id_MainLimit1.style.visibility	= "hidden";
			document.all.id_MainLimit1.style.position	= "absolute";
			document.all.id_MainLimit2.style.visibility	= "hidden";
			document.all.id_MainLimit2.style.position	= "absolute";
		}
	}

	function doNew()
	{
		disableFields(false);
		disableCommandButtons(true,true,false,false,true,true);
		document.forms[0].hidAction.value ="insert";

		var varConsType	= '<%=Helper.correctNull((String) hshValues
									.get("com_cons_sno"))%>';

		if(varConsType=="")
		{
			varConsType	= '<%=Helper.correctNull((String) hshValues
									.get("sel_ConsType"))%>';
		}
		
		var varConsType1	= '<%=Helper.correctNull((String) hshValues
									.get("com_tl_type"))%>';

		if(varConsType1 == "M")
		{
			document.forms[0].sel_ConsType_tl.value	= varConsType;
			document.forms[0].sel_ConsType_tl.disabled	= true;
		}
		document.forms[0].txt_LeadBankName.readOnly=true;
        document.forms[0].txt_perbranch.readOnly=true;
        <%if(Helper.correctNull((String)hshValues.get("com_tl_bnkarg")).equalsIgnoreCase("C")){ %>
        document.forms[0].txt_LeadBankNameCons.readOnly=true;

        		<%}%>
	}

	function doCancel()
	{
		if(ConfirmMsg(102))
		{
			document.forms[0].hidBeanId.value="bankappfi";
			document.forms[0].hidBeanGetMethod.value="getBAConsDataTL";
			document.forms[0].action=appURL+"action/com_BAConsortium_TL.jsp";
			document.forms[0].method="post";
			document.forms[0].submit();
		}
	}

	function disableFields(val)
	{
		for(var i=0;i<document.forms[0].length;i++)
		{
			if(document.forms[0].elements[i].type=='text')
			{
				document.forms[0].elements[i].readOnly=val;
			}	  
			if(document.forms[0].elements[i].type=='textarea')
			{
				document.forms[0].elements[i].readOnly=val;
			}	 
			if(document.forms[0].elements[i].type=="radio")
			{
				document.forms[0].elements[i].disabled=(!val);		  
			} 
			if(document.forms[0].elements[i].type=="select-one")
			{
				document.forms[0].elements[i].disabled=val;		  
			} 
			if(document.forms[0].elements[i].type=="checkbox")
			{
				document.forms[0].elements[i].disabled=val;		  
			} 
		}
	}

	function doDelete()
	{
		if(ConfirmMsg(101))
		{
		   	document.forms[0].hidAction.value ="delete";		
			document.forms[0].hidBeanMethod.value="updateBAConsDataTL";
			document.forms[0].hidBeanId.value="bankappfi";
			document.forms[0].hidBeanGetMethod.value="getBAConsDataTL";
			document.forms[0].action=appURL+"action/ControllerServlet";	
			document.forms[0].hidSourceUrl.value="/action/com_BAConsortium_TL.jsp";			
			document.forms[0].method="post";			
			document.forms[0].submit();	
		}	
	}

	function doClose()
	{
		if(ConfirmMsg(100))
		{
			document.forms[0].action=appURL+"action/corppge.jsp";
			document.forms[0].submit();
		}
	}

	function doEdit()
	{
		disableFields(false);
		document.forms[0].hidAction.value ="update";
		disableCommandButtons(true,true,false,false,false,true);

		var varConsType	= '<%=Helper.correctNull((String) hshValues
									.get("com_cons_sno"))%>';

		if(varConsType=="")
		{
			varConsType	= '<%=Helper.correctNull((String) hshValues
									.get("sel_ConsType"))%>';
		}
		
		var varConsType1	= '<%=Helper.correctNull((String) hshValues
									.get("com_tl_type"))%>';

		if(varConsType1 == "M")
		{
			document.forms[0].sel_ConsType_tl.value	= varConsType;
			document.forms[0].sel_ConsType_tl.disabled	= true;
		}
		document.forms[0].txt_LeadBankName.readOnly=true;
        document.forms[0].txt_perbranch.readOnly=true;
<%if(Helper.correctNull((String)hshValues.get("com_tl_bnkarg")).equalsIgnoreCase("C")){ %>
document.forms[0].txt_LeadBankNameCons.readOnly=true;

		<%}%>
	}

	function doSave()
	{
		var varConsType1= '<%=Helper.correctNull((String)hshValues.get("com_wc_type"))%>';
		if(document.forms[0].txt_ECSifsccode.value=="")
		{    	 
		 	ShowAlert('121','IFSC CODE');	
		 	document.forms[0].txt_ECSifsccode.focus();
		 	return false;
		}
		if(document.forms[0].txt_LeadBankName.value=="")
		{    	 
		 	ShowAlert('111','Name of the Bank');	
		 	document.forms[0].txt_LeadBankName.focus();
		 	return false;
		}

		if(document.forms[0].sel_Natureloan.value=="")
		{    	 
		 	ShowAlert('111','Nature of facility');
		 	document.forms[0].sel_Natureloan.focus();	
		 	return false;
		}

		if(document.forms[0].sel_factype.value=="")
		{    	 
		 	ShowAlert('111','Main limit/ sub limit');	
		 	document.forms[0].sel_factype.focus();
		 	return false;
		}

		if(document.forms[0].txt_perbranch.value=="")
		{    	 
		 	ShowAlert('111','Branch Name');	
		 	document.forms[0].txt_perbranch.focus();
		 	return false;
		}

		if(document.forms[0].txt_email.value=="")
		{    	 
		 	ShowAlert('121','Email Id');
		 	document.forms[0].txt_email.focus();	
		 	return false;
		}
 <%if(Helper.correctNull((String)hshValues.get("com_tl_bnkarg")).equalsIgnoreCase("C")){ %>
		
		if(document.forms[0].txt_LeadBankNameCons.value=="")
		{    	 
		 	ShowAlert('111','Name of the consortium leader');	
		 	document.forms[0].txt_LeadBankNameCons.focus();
		 	return false;
		}
		if(document.forms[0].txt_AsonDate.value=="")
		{    	 
		 	ShowAlert('121','As On Date');	
		 	document.forms[0].txt_AsonDate.focus();
		 	return false;
		}
		
		<%}%>
		
		var varConsType1	= '<%=Helper.correctNull((String) hshValues
									.get("com_tl_type"))%>';

		if((document.forms[0].hidGetFLAG_tl.value!="Yes" && varConsType1 == "M")||varConsType1 == "M")
		{
			document.forms[0].sel_ConsType_tl.disabled	= false;
		}
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].hidBeanId.value="bankappfi";
		document.forms[0].hidSourceUrl.value="/action/com_BAConsortium_TL.jsp";
		document.forms[0].hidBeanMethod.value="updateBAConsDataTL";
		document.forms[0].hidBeanGetMethod.value="getBAConsDataTL";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
		
	}

	function disableCommandButtons(valnew,valedit,valapply,valcancel,valdel,valclose)
	{
		document.forms[0].cmdnew.disabled =valnew;
		document.forms[0].cmdedit.disabled=valedit;
		document.forms[0].cmddelete.disabled=valdel;
		document.forms[0].cmdsave.disabled=valapply;
		document.forms[0].cmdcancel.disabled=valcancel;
		document.forms[0].cmdclose.disabled=valclose;
	}

	function callBankmaster(id,pos)
	{
		if(document.forms[0].cmdsave.disabled==false)
		{
			var varQryString = appURL+"action/ops_sanctionhelp.jsp?hidBeanGetMethod=getSearch&hidBeanId=additionalParameter&pagename=Banking&id="+id+"&Position="+pos;
			var title = "Bank_Master";
			var prop = "scrollbars=no,width=650,height=400";
			var xpos = "50";
			var ypos = "50";
			prop = prop+","+xpos+","+ypos+",left=200,top=200";
			window.open(varQryString,title,prop);
		}
	}

	function callBankmaster1(id,pos)
	{
		if(document.forms[0].cmdsave.disabled==false)
		{
			var varQryString = appURL+"action/ops_sanctionhelp.jsp?hidBeanGetMethod=getSearch&hidBeanId=additionalParameter&pagename=Lead&id="+id+"&Position="+pos;
			var title = "Bank_Master";
			var prop = "scrollbars=no,width=650,height=400";
			var xpos = "50";
			var ypos = "50";
			prop = prop+","+xpos+","+ypos+",left=200,top=200";
			window.open(varQryString,title,prop);
		}
	}
	function callBankmaster2(id,pos)
	{
		if(document.forms[0].cmdsave.disabled==false)
		{
			var varQryString = appURL+"action/ops_sanctionhelp.jsp?hidBeanGetMethod=getSearch&hidBeanId=additionalParameter&pagename=newbank&id="+id+"&Position="+pos;
			var title = "Bank_Master";
			var prop = "scrollbars=no,width=650,height=400";
			var xpos = "50";
			var ypos = "50";
			prop = prop+","+xpos+","+ypos+",left=200,top=200";
			window.open(varQryString,title,prop);
		}
	}
	function setBankmaster(v1,v2,v3)
	{
		
		if(v3=="Lead")
		{
			document.forms[0].hid_LeadBankcodeCons.value	= v1;
			document.forms[0].txt_LeadBankNameCons.value	= v2;
		}else if(v3=="newbank"){
			document.forms[0].hid_LeadBankcode_new.value	= v1;
			document.forms[0].txt_perbranch.value	= v2;
		}
		else
		{
			document.forms[0].hid_LeadBankcode.value	= v1;
			document.forms[0].txt_LeadBankName.value	= v2;

			
			
		}				
	}

	function onloading()
	{
		disableFields(true);
		var varGetFlag	= '<%=Helper.correctNull((String) hshValues.get("hidGetFLAG"))%>';
		var varConsType	= '<%=Helper.correctNull((String) hshValues
									.get("com_cons_sno"))%>';

		var varBAVal		= '<%=Helper.correctNull((String) hshValues
							.get("com_tl_bnkarg"))%>';
		var varConsType1	= '<%=Helper.correctNull((String) hshValues
									.get("com_tl_type"))%>';

		if(varConsType=="")
		{
			varConsType	= '<%=Helper.correctNull((String) hshValues
									.get("sel_ConsType"))%>';
		}
		document.forms[0].hidGetFLAG_tl.value	= varGetFlag;

		if(document.forms[0].hidGetFLAG_tl.value!="Yes" && varConsType1 == "M")
		{
			document.forms[0].cmdnew.disabled 		= true;
			document.forms[0].sel_ConsType_tl.disabled = false;
		}
		else if(varConsType1 == "M")
		{
			document.forms[0].sel_ConsType_tl.value	= varConsType;
			document.forms[0].sel_ConsType_tl.disabled = false;
		}
		/*if(proposalnoteCheck=="Y")
		{	
			document.forms[0].proposalNote.checked=true;
		}
		else
		{	document.forms[0].proposalNote.checked=false;
		}
		if(annexureCheck=="Y"){
			document.forms[0].Annexure3.checked=true;
		}
		else
		{		document.forms[0].Annexure3.checked=false;
		}
		*/
	}
	 
	  function selectValues(val1,val2,val3,val4,val5,val6,val7,val8,val9,val10,val11,val12,val13,val14,val15,val16)
	  {
		document.forms[0].hid_LeadBankcode.value	= val1;
		document.forms[0].txt_LeadBankName.value	= val1;
		document.forms[0].sel_Natureloan.value		= val3;
		document.forms[0].sel_factype.value			= val4;
		document.forms[0].sel_limiof.value			= val5;
		document.forms[0].txt_Limit.value			= roundVal(val6);
		document.forms[0].txt_OS.value				= roundVal(val7);
		document.forms[0].txt_intrate.value			= roundVal(val8);
		document.forms[0].txta_remarks.value		= val9;
		document.forms[0].hidsno.value				= val10;

		document.forms[0].txt_OS_AS_ON.value		= val11;
		document.forms[0].txt_Unrel_Por.value		= val12;
		document.forms[0].hid_LeadBankcode_new.value		= val13;
		document.forms[0].txt_email.value		= val14;
		document.forms[0].txt_perbranch.value		= val13;
		document.forms[0].txt_ECSifsccode.value		= val16;
	
		if(val5=="S")
		{
			document.all.id_MainLimit1.style.visibility	= "visible";
			document.all.id_MainLimit1.style.position	= "relative";
			document.all.id_MainLimit2.style.visibility	= "visible";
			document.all.id_MainLimit2.style.position	= "relative";
		}
		else
		{
			document.all.id_MainLimit1.style.visibility	= "hidden";
			document.all.id_MainLimit1.style.position	= "absolute";
			document.all.id_MainLimit2.style.visibility	= "hidden";
			document.all.id_MainLimit2.style.position	= "absolute";
		}
		if(document.forms[0].btnenable.value.toUpperCase()=="Y")
		{
			disableCommandButtons(true,false,true,false,false,false);
		}
	
		
	  }

	  function getConsValue()
	  {
		//if(document.forms[0].hidGetFLAG_tl.value!="Yes")
		{
			document.forms[0].hidGetFLAG_tl.value="Yes";
			document.forms[0].hidBeanId.value="bankappfi";
			document.forms[0].hidBeanGetMethod.value="getBAConsDataTL";
			document.forms[0].action=appURL+"action/com_BAConsortium_TL.jsp";
			document.forms[0].method="post";
			document.forms[0].submit();
		}
	  }
	  function callCalender(val)
	  {
	  	if(document.forms[0].cmdsave.disabled==false)
	  	{
	  		 showCal(appUrl,val);
	  	}
	  }
	  function showOrganizationSearch(path, forgscode, forgname,forgcode)
	  {
	  	
	  		var varQryString = path+"action/searchOrg.jsp?forgscode="+forgscode+"&forgname="+forgname+"&forgcode="+forgcode;
	  		var title = "Organization";
	  		var prop = "scrollbars=yes,width=500,height=400,menubar=yes";	
	  		var xpos = (screen.width - 350) / 2;
	  		var ypos = (screen.height - 120) / 2;
	  		prop = prop + ",left=50,top=50";
	  		window.open(varQryString,title,prop);
	  	
	  }
	  function callperType(varValue) {
			var varConsortiumType = document.forms[0].sel_ConsType_tl.value;
			var varbankcode=document.forms[0].hid_LeadBankcode.value;
			if(varValue=="S"){
			document.all.sublimitTL.src = appURL
					+ "action/iframe_tlsublimit.jsp?hidBeanGetMethod=getLimitOfTLData&hidBeanId=bankapp&consortiumtype="+ varConsortiumType+"&bankcode="+varbankcode+"&appno="+strappno;
		}
	  }
	  function callIfsccode()
	  {
	  	if(document.forms[0].cmdsave.disabled==false)
	  	{
	  		
	  			var varECSifsccode=document.forms[0].txt_ECSifsccode.value;
	  			 if(varECSifsccode.length!=11){
	  	
	  				alert("Please Enter Valid IFSC Code");
	  				document.forms[0].txt_ECSifsccode.value="";
	  				return;
	  			}
	  			if(varECSifsccode.length==11)
	  				{
	  					document.all.ifrmifsc.src=appURL+"action/Bankingifsccode.jsp?hidBeanId=DigitalAppInterface&hidBeanGetMethod=IFSCcodeLapsCheck&ifsccode="+varECSifsccode;
	  				}
	  		
	  	}
	  }
</script>
</head>
<body onload="onloading();">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()" onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems" url="">
<script language="JavaScript">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script>
</div></div>
<form name="frmpri" method="post" class="normal">
<%
	if (Helper.correctNull((String) session.getAttribute("strAppType"))
			.equalsIgnoreCase("P")) {
		if (!strSessionModuleType.equalsIgnoreCase("RET")) {
%>
  <table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../com/postsanctionlinks.jsp" flush="true">
			<jsp:param name="pageid" value="3" />
			<jsp:param name="subpageid" value="104" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<table border="0" cellspacing="2" cellpadding="3" class="outertable" width="60%">
			          	<tr align="center">
			          	<td  width="15%" nowrap="nowrap" align="center" class="sub_tab_inactive"><b><a
						href="#" onclick="javascript:gotoTab(appURL,'bankappfi','getData','combankingfi.jsp')">Existing Facilities</a></b></td>	
						<td  width="15%" nowrap align="center" class="sub_tab_inactive"><b>
          				<a href="#" onclick="javascript:gotoTab(appURL,'bankapp','getBankingdetailsData','com_bankingdetails.jsp')">Asset Classification / Comments on Arrears</a></b></td>
			             <td  width="15%" nowrap="nowrap" align="center" class="sub_tab_inactive"><b>
		  				<a href="#" onclick="javascript:gotoTab(appURL,'bankapp','getBankingArrangement','comBankingArrgnmentNew.jsp')">Banking Arrangement</a></b></td>
		 
          
		  <%
		           		  	if ((!strBATypeTL.equalsIgnoreCase("") || !strConsTypeTL
		           		  					.equalsIgnoreCase(""))
		           		  					&& !strBATypeTL.equalsIgnoreCase("S")) {
		           		  %>
		  <%
		  	if (strBATypeTL.equalsIgnoreCase("C")) {
		  %>
			<td  width="15%" nowrap="nowrap" align="center" class="sub_tab_active"><b>Consortium Details for TL</b></td>
			<%
				}
						}
			%>
			
			<%
							if ((!strBATypeTL.equalsIgnoreCase("") || !strConsTypeTL
											.equalsIgnoreCase(""))
											&& !strBATypeTL.equalsIgnoreCase("S")) {
						%>
			<%
				if (strBATypeTL.equalsIgnoreCase("M")) {
			%>
			<td  width="15%" nowrap="nowrap" align="center" class="sub_tab_active"><b>Multiple Banking Details for TL</b></td>
			<%
				}
						}
			%>
			
			<%
							if ((!strBATypeWC.equalsIgnoreCase("") || !strConsTypeWC
											.equalsIgnoreCase(""))
											&& !strBATypeWC.equalsIgnoreCase("S")) {
						%>
				<%
					if (strBATypeWC.equalsIgnoreCase("C")) {
				%>
			<td  width="15%" nowrap="nowrap" align="center" class="sub_tab_inactive"><b><a
					href="#" onclick="javascript:gotoTab(appURL,'bankappfi','getBAConsData','com_BAConsortium.jsp')">Consortium Details for WC</a></b></td>
			<%
				}
						}
			%>
			
			<%
							if ((!strBATypeWC.equalsIgnoreCase("") || !strConsTypeWC
											.equalsIgnoreCase(""))
											&& !strBATypeWC.equalsIgnoreCase("S")) {
						%>
			<%
				if (strBATypeWC.equalsIgnoreCase("M")) {
			%>
			<td  width="15%" nowrap="nowrap" align="center" class="sub_tab_inactive"><b><a
					href="#" onclick="javascript:gotoTab(appURL,'bankappfi','getBAConsData','com_BAConsortium.jsp')">Multiple Banking Details for WC</a></b></td>
			<%
				}
						}
			%>
			
			<%
							if ((!strBATypeWC.equalsIgnoreCase("") || !strConsTypeWC
											.equalsIgnoreCase(""))
											&& (strBATypeWC.equalsIgnoreCase("C") || strBATypeWC
													.equalsIgnoreCase("M"))) {
						%>
			<td  width="15%" nowrap="nowrap" align="center" class="sub_tab_inactive"><b><a
					href="#" onclick="javascript:gotoTab(appURL,'bankapp','getMultipleBanking','com_multipleBanking.jsp')">
						Existing and Proposed Exposure
			</a></b></td>
			<%
				}
			%>
			            </tr>
			        	</table>
<%
	}
	} else {
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top" colSpan="5">
					<jsp:include page="../share/applurllinkscom.jsp" flush="true">
		        	<jsp:param name="pageid" value="3" />
		        	<jsp:param name="cattype" value="<%=strCategoryType%>" />
		        	<jsp:param name="ssitype" value="<%=strSSIType%>" /></jsp:include>
		       </td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
<tr>
	<td class="page_flow">Home -&gt;Agriculture -&gt;Application -&gt; Banking Arrangement -&gt; Consortium</td>
</tr>
</table>
<span style="display:none;"><lapschoice:borrowertype /></span><lapschoice:application />

	<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
		<tr align="center">
		<td valign="bottom">
		 <%
		 	if (strCategory.equalsIgnoreCase("RET")) {
		 %> 
		  <table border="0" cellspacing="2" cellpadding="3" align="left" class="outertable">
			<tr>
			<td class="sub_tab_active" id="prin" nowrap="nowrap"><b>Existing  Banking Details </b></td>
			<td class="sub_tab_inactive" id="prin"><b><b>
			<a href="#" onclick="javascript:callLink('comgroupcompanies.jsp','executive','getData7')">Guarantor / Group concern</a></b></b></td>
			</tr>
		  </table>
		 <%
		 	} else {
		 %>
		  	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			    <tr>
			      	<td>
			      		<table border="0" cellspacing="2" cellpadding="3" class="outertable" width="60%">
			          	<tr align="center">
			          	<td  width="15%" nowrap="nowrap" align="center" class="sub_tab_inactive"><b><a
						href="#" onclick="javascript:gotoTab(appURL,'bankappfi','getData','combankingfi.jsp')">Existing Facilities</a></b></td>	
			            <td  width="15%" nowrap="nowrap" align="center" class="sub_tab_inactive"><b>
			            <a href="#" onclick="javascript:gotoTab(appURL,'bankapp','getBankingdetailsData','com_bankingdetails.jsp')">Asset Classification / Comments on Arrears </a></b></td>
			            <td  width="15%" nowrap align="center" class="sub_tab_inactive"><b>
         				 <a href="#" onclick="javascript:gotoTab(appURL,'compro','getFinancialComments','com_bankcomments.jsp')">Other Comments</a></b></td>
			             <td  width="15%" nowrap="nowrap" align="center" class="sub_tab_inactive"><b>
		  				<a href="#" onclick="javascript:gotoTab(appURL,'bankapp','getBankingArrangement','comBankingArrgnmentNew.jsp')">Banking Arrangement</a></b></td>
		 
		  <%
		 		  	if ((!strBATypeTL.equalsIgnoreCase("") || !strConsTypeTL
		 		  					.equalsIgnoreCase(""))
		 		  					&& !strBATypeTL.equalsIgnoreCase("S")) {
		 		  %>
		  <%
		  	if (strBATypeTL.equalsIgnoreCase("C")) {
		  %>
			<td  width="15%" nowrap="nowrap" align="center" class="sub_tab_active"><b>Consortium Details for TL</b></td>
			<%
				}
						}
			%>
			
			<%
							if ((!strBATypeTL.equalsIgnoreCase("") || !strConsTypeTL
											.equalsIgnoreCase(""))
											&& !strBATypeTL.equalsIgnoreCase("S")) {
						%>
			<%
				if (strBATypeTL.equalsIgnoreCase("M")) {
			%>
			<td  width="15%" nowrap="nowrap" align="center" class="sub_tab_active"><b>Multiple Banking Details for TL</b></td>
			<%
				}
						}
			%>
			
			<%
							if ((!strBATypeWC.equalsIgnoreCase("") || !strConsTypeWC
											.equalsIgnoreCase(""))
											&& !strBATypeWC.equalsIgnoreCase("S")) {
						%>
				<%
					if (strBATypeWC.equalsIgnoreCase("C")) {
				%>
			<td  width="15%" nowrap="nowrap" align="center" class="sub_tab_inactive"><b><a
					href="#" onclick="javascript:gotoTab(appURL,'bankappfi','getBAConsData','com_BAConsortium.jsp')">Consortium Details for WC</a></b></td>
			<%
				}
						}
			%>
			
			<%
							if ((!strBATypeWC.equalsIgnoreCase("") || !strConsTypeWC
											.equalsIgnoreCase(""))
											&& !strBATypeWC.equalsIgnoreCase("S")) {
						%>
			<%
				if (strBATypeWC.equalsIgnoreCase("M")) {
			%>
			<td  width="15%" nowrap="nowrap" align="center" class="sub_tab_inactive"><b><a
					href="#" onclick="javascript:gotoTab(appURL,'bankappfi','getBAConsData','com_BAConsortium.jsp')">Multiple Banking Details for WC</a></b></td>
			<%
				}
						}
			%>
			
			<%
							if ((!strBATypeWC.equalsIgnoreCase("") || !strConsTypeWC
											.equalsIgnoreCase(""))
											&& (strBATypeWC.equalsIgnoreCase("C") || strBATypeWC
													.equalsIgnoreCase("M"))) {
						%>
			<td  width="15%" nowrap="nowrap" align="center" class="sub_tab_inactive"><b><a
					href="#" onclick="javascript:gotoTab(appURL,'bankapp','getMultipleBanking','com_multipleBanking.jsp')">
						Existing and Proposed Exposure
			</a></b></td>
			<%
				}
			%>
			            </tr>
			        	</table>
			        </td>
			    </tr>
		  </table>
  		<%
  			}
  		%>
  </td>
  </tr>
  </table>
  <%
  	}
  %>
  <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable border1">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
				<%
					if (Helper.correctNull((String) hshValues.get("com_tl_bnkarg"))
							.equalsIgnoreCase("C")) {
				%>
				<tr>
				<td>
				<table width="75%" border="0" cellspacing="1" cellpadding="3" class="outertable">
					<tr class="dataheader">
					<%
						if (Helper.correctNull((String) hshValues.get("com_tl_type"))
									.equalsIgnoreCase("M")) {
					%>
					<td align="center" width="25%">Consortium Type</td>
					<%
						}
					%>
					<td align="center" width="25%">Name of the consortium leader</td>
					<%
						if (Helper.correctNull((String) hshValues.get("com_tl_type"))
									.equalsIgnoreCase("M")) {
					%>
					<td align="center" width="25%">Consortium Description</td>
					<%
						}
					%>
					<td align="center" width="25%">As on Date <span class="mantatory">*</span></td>
					</tr>
					<tr class="datagrid">
					<%
						if (Helper.correctNull((String) hshValues.get("com_tl_type"))
									.equalsIgnoreCase("M")) {
					%>
					<td align="center">
					<select name="sel_ConsType_tl" onchange="getConsValue();">
					<option value="" selected="selected">&lt;----Select----&gt;</option>
					<lapschoice:BAConsortiumTag contype="TL"/>
					</select>
					</td>
					<%
						}
					%>
					<td align="center">
					<input type="text" name="txt_LeadBankNameCons" onKeyPress="" maxlength="40" size="30" tabindex="1" readonly="readonly" 
					value="<%=Helper.correctNull((String) hshValues
								.get("com_cons_bank_name"))%>">
					<input type="hidden" name="hid_LeadBankcodeCons" value="<%=Helper.correctNull((String) hshValues
								.get("com_cons_bank_code"))%>">
					<span onClick="callBankmaster1('147','0')" style="cursor: hand">
					<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0"></span>
					</td>
					<%
						if (Helper.correctNull((String) hshValues.get("com_tl_type"))
									.equalsIgnoreCase("M")) {
					%>
					<td align="center"><input type="text" name="txt_consDesc" value="<%=Helper.correctNull((String) hshValues
									.get("com_cons_desc"))%>" 
					size="35" maxlength="50"></td>
					<%
						}
					%>
					<td align="center">
					<input type="text" name="txt_AsonDate"  maxlength="40" size="30" readonly="readonly" onblur="checkDate(this);checkmaxdate(this,currentDate);"
									value="<%=Helper.correctNull((String) hshValues
								.get("com_cons_asondate"))%>">&nbsp;&nbsp;
					<a alt="Select date from calender" href="#" onClick="callCalender('txt_AsonDate')"
													onMouseOver="window.status='Date Picker';return true;"
													onMouseOut="window.status='';return true;"><img
													src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
													border="0" alt="Select date from calender"></a>
					</td>
					</tr>
				</table>
								
				</td>
				</tr>
				<%
					}
				%>
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
							<tr>
								<td>
								<table width="100%" border="0" cellspacing="1" cellpadding="5" class="outertable">
									<tr align="center" class="dataheader">
										<td align="center" width="10%">Name of the Bank<span class="mantatory">*</span></td>
										<td align="center" width="10%">Nature of facility<span class="mantatory">*</span></td>
										<td align="center" width="10%">Main limit/ sub limit <span class="mantatory">*</span></td>
										<td align="center" width="10%" id="id_MainLimit1" style="visibility: hidden;position: absolute;">Limit of</td>
										<td align="center" width="10%">Limit</td>
										<td align="center" width="10%">Outstanding</td>
										<td align="center" width="10%">Outstanding as on</td>
										<td align="center" width="10%">Unreleased Portion</td>
										<td align="center" width="10%">Interest rate</td>
										<td align="center" width="15%">Remarks</td>
									</tr>
									<tr align="center" class="datagrid">
										<td align="center" nowrap="nowrap">
										<input type="text" name="txt_LeadBankName" onKeyPress="" maxlength="40" size="30" tabindex="1" readonly="readonly" value="">
										<input type="hidden" name="hid_LeadBankcode" value="">
										<!-- <span onClick="callBankmaster('147','0')" style="cursor: hand">
										<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0"></span> -->
										</td>
										<td align="center">
										<select name="sel_Natureloan" tabindex="1">
						                 <option value="" selected="selected">&lt;----Select----&gt;</option>                      
						               	 <lapschoice:StaticDataNewTag apptype="144"/> 
						               	</select>
										</td>
										<td align="center">
										<select name="sel_factype" onchange="fnLimitSel(this.value);callperType(this.value)" tabindex="2">
										<option value="">&lt;----Select----&gt;</option>
										<option value="M">Main Limit</option>
										<option value="S">Sub Limit</option>
										</select>
										</td>
										<td align="center" id="id_MainLimit2" style="visibility: hidden;position: absolute;">
										<select name="sel_limiof">
						                 <option value="" selected="selected">&lt;----Select----&gt;</option>                      
						               	</select>
										</td>
										<td align="center">
										<lapschoice:CurrencyTag name="txt_Limit" maxlength="15" size="12" tabindex="6" onKeyPress="allowDecimals(this)" 
										style="text-align:right" onBlur="roundtxt(this)" other="readOnly" tabindex="3"/>
										</td>
										<td align="center">
										<lapschoice:CurrencyTag name="txt_OS" maxlength="15" size="12" onKeyPress="allowDecimals(this)" 
										style="text-align:right" onBlur="roundtxt(this)" tabindex="4"/>
										</td>
										<td align="center">
										<input type="text" name="txt_OS_AS_ON"  maxlength="40" size="14" readonly="readonly" onBlur="checkDate(this);">&nbsp;&nbsp;
												<a alt="Select date from calender" href="#" onClick="callCalender('txt_OS_AS_ON')"
													onMouseOver="window.status='Date Picker';return true;"
													onMouseOut="window.status='';return true;"><img
													src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
													border="0" alt="Select date from calender"></a>
													</td>
										<td align="center">
										<lapschoice:CurrencyTag name="txt_Unrel_Por" tabindex="4"/>
										</td>
										<td align="center">
										<input type="text" name="txt_intrate" maxlength="5" size="15" style=" text-align:right"  
										onkeypress="allowDecimals(this)" onblur="roundtxt(this)" tabindex="5">
										</td>
										<td align="center">
										<textarea name="txta_remarks" onkeypress="NoallowEnterandDoubleQuote();textlimit(this,300);notAllowSingleQuote();" rows="3" cols="50"
										onkeyup="textlimit(this,300)" tabindex="6"></textarea>
										</td>
									</tr>
								
								</table>
								</td>
								</tr>
							<tr>
								<td>
								<table width="75%" border="0" cellspacing="1" cellpadding="3"
									class="outertable">
									<tr class="dataheader">
										<td align="center" width="25%">Branch Name <span class="mantatory"><b>*</b></span></td>
										<td align="center" width="30%">Email Id  <span class="mantatory"><b>*</b></span></td>
								 	<td align="center" width="20%">IFSC CODE<b><span class="mantatory">*&nbsp;</span></b></td>
									
									</tr>
									<tr class="datagrid">
										<td align="center" nowrap="nowrap">
										<input type="text" name="txt_perbranch" onKeyPress="" maxlength="40" size="30" tabindex="1" readonly="readonly" value="">
										<input type="hidden" name="hid_LeadBankcode_new" value="">
										</td>
										<td align="center"><input type="text" name="txt_email" tabindex="30" size="40"
											onBlur="isEmailAddr(document.forms[0].txt_email.value,document.forms[0].txt_email)"></td>
									<td align="center"><input type="text" 
													name="txt_ECSifsccode"  onChange="callIfsccode()"
													value=""
													 maxlength="11"></td>
									</tr>
								</table>

								</td>
							</tr>
							<!-- Commented by Kishan
									<tr>
									<td>
									<table class="outertable"  border="0" cellspacing="0" cellpadding="2" width="100%">
  									<tr>
  									<td width="30%">
  										<input type="checkbox" name="proposalNote" border="0" style="border: none;"><span>Whether to be displayed in Proposal Note</span>
  									<td>
  									<input type="checkbox" name="Annexure3" border="0" style="border: none;"><span>Whether to be displayed in Annexure III</span>
  									</td>
  									</tr>
  									</table>
									</td>
								</tr>  -->
								</table>
								</td>
								</tr>
								</table>
								</td>
								</tr>
								</table>
								</td>
								</tr>
								<br>
								</table>
								<lapschoice:combuttonnew btnnames="New_Edit_Save_Delete_Cancel_Audit Trail" btnenable='<%=Helper.correctNull((String) request
							.getParameter("btnenable"))%>' />
								
								<lapschoice:hiddentag pageid='<%=PageId%>'/>
								<br><br>
								
								<%
																	String strFacType = "";
																	if (arrRow != null && arrRow.size() > 0) {
																%>
								<table width="100%" border="0" cellspacing="1" cellpadding="2" class="outertable" align="center">
								<tr align="center" class="dataheader">
										<td width="3%"></td>
										<td align="center" width="15%">Name of the Bank</td>
										<td align="center" width="15%">Nature of facility</td>
										<td align="center" width="10%">Main limit/ sub limit</td>
										<td align="center" width="9%">Limit</td>
										<td align="center" width="8%">Outstanding</td>
										<td align="center" width="8%">Interest rate</td>
										<td align="center" width="10%">Branch Name</td>
										<td align="center" width="20%">Email ID</td>
										<td align="center" width="15%">IFSC CODE</td>
								</tr>
								<%
									for (int i = 0; i < arrRow.size(); i++) {
											arrCol = (ArrayList) arrRow.get(i);
											if (Helper.correctNull((String) arrCol.get(3))
													.equalsIgnoreCase("M")) {
												strFacType = "Main Limit";
											} else if (Helper.correctNull((String) arrCol.get(3))
													.equalsIgnoreCase("S")) {
												strFacType = "Sub Limit";
											}
								%>
									
									<tr class="datagrid">
										<td align="center">
											<input type="radio" name="sno" style="border-style:none"
												onClick="selectValues(
														'<%=Helper.correctNull((String) arrCol.get(1))%>',
														'<%=Helper.correctNull((String) arrCol.get(9))%>',
														'<%=Helper.correctNull((String) arrCol.get(2))%>',
														'<%=Helper.correctNull((String) arrCol.get(3))%>',
														'<%=Helper.correctNull((String) arrCol.get(4))%>',
														'<%=Helper.correctNull((String) arrCol.get(5))%>',
														'<%=Helper.correctNull((String) arrCol.get(6))%>',
														'<%=Helper.correctNull((String) arrCol.get(7))%>',
														'<%=Helper.correctNull((String) arrCol.get(8))%>',
														'<%=Helper.correctNull((String) arrCol.get(0))%>',
														'<%=Helper.correctNull((String) arrCol.get(11))%>',
														'<%=Helper.correctNull((String) arrCol.get(12))%>',
														'<%=Helper.correctNull((String) arrCol.get(13))%>',
														'<%=Helper.correctNull((String) arrCol.get(14))%>',
														'<%=Helper.correctNull((String) arrCol.get(15))%>',
														'<%=Helper.correctNull((String) arrCol.get(16))%>')">
										</td>
										<td><%=Helper.correctNull((String) arrCol.get(1))%></td>
										<td><%=Helper.correctNull((String) arrCol.get(10))%></td>
										<td><%=strFacType%></td>
										<td align="right"><%=jtn.format(Double.parseDouble(Helper
									.correctDouble((String) arrCol.get(5))))%></td>
										<td align="right"><%=jtn.format(Double.parseDouble(Helper
									.correctDouble((String) arrCol.get(6))))%></td>
										<td align="right"><%=jtn.format(Double.parseDouble(Helper
									.correctDouble((String) arrCol.get(7))))%></td>
									<td><%=Helper.correctNull((String) arrCol.get(13))%></td>
										<td><%=Helper.correctNull((String) arrCol.get(14))%></td>
										<td><%=Helper.correctNull((String) arrCol.get(16))%></td>
										</tr>
									<%
										}
										}
									%>
								
								</table>
								
								<input type="hidden" name="hidsno" value="">
								<input type="hidden" name="hidGetFLAG_tl" value="">
								   <iframe height="0" width="0" id="sublimitTL"
	frameborder=0 style="border: 0"></iframe>
		<iframe height="0" width="0" id="ifrmifsc" frameborder="0"	style="border: 0"></iframe>
</form>
</body>

</html>
