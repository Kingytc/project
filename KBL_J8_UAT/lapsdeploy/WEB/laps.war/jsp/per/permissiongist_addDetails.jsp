<%@include file="../share/directives.jsp"%>
<%
String appno = Helper.correctNull((String) hshValues.get("appno"));

String applstatus = Helper.correctNull((String) hshValues.get("DEV_APPSTATUS"));

String appstatus = "";
if (applstatus.equalsIgnoreCase("OP")) {
	appstatus = "Open/Pending";
} else if (applstatus.equalsIgnoreCase("PA")) {
	appstatus = "Processed/Approved";
} else if (applstatus.equalsIgnoreCase("PR")) {
	appstatus = "Processed/Rejected";
} else if (applstatus.equalsIgnoreCase("CA")) {
	appstatus = "Closed/Approved";
} else if (applstatus.equalsIgnoreCase("CR")) {
	appstatus = "Closed/Rejected";
}
String strDEV_SUBTYPE = Helper.correctNull((String) hshValues.get("strDEV_SUBTYPE"));
java.text.NumberFormat nf = java.text.NumberFormat
.getNumberInstance();
nf.setGroupingUsed(false);
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);
ArrayList arrRow5 = (ArrayList) hshValues.get("arrRow");
ArrayList arrRow4 = (ArrayList) hshValues.get("arrRow1");
ArrayList arrRow_bank = (ArrayList) hshValues.get("arrRow_bank");
String strDEV_CBSID = Helper.correctNull((String) hshValues.get("DEV_CBSID"));

%>
<html>
<head>
<script language="javaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/jquery.js"></script>

<SCRIPT LANGUAGE="JavaScript">
	var curdate = "<%=Helper.getCurrentDateTime()%>";
	var appUrl="<%=ApplicationParams.getAppUrl()%>";
	var appURL="<%=ApplicationParams.getAppUrl()%>";
	var permsubtype="<%=strDEV_SUBTYPE%>";
	var varDEV_CBSID="<%=strDEV_CBSID%>";
	
	function callLink(url,bean,method)
	{
		if(document.forms[0].cmdsave.disabled == false)
		{
			ShowAlert(103);
			return;
		}
		if(document.forms[0].cmdsave.disabled)
		{
			document.forms[0].hidBeanGetMethod.value=method;
			document.forms[0].hidBeanId.value=bean;
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+url;
			document.forms[0].submit();
		}
	}

	function doClose()
	{
		var varconfirm=ConfirmMsg('100');
		if(varconfirm)
		{
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/mainnav.jsp";
			document.forms[0].submit();
		}
	}
	function doSave()
	{
		document.forms[0].cmdsave.disabled = true;

		document.forms[0].hidAction.value="update";
		document.forms[0].hidBeanId.value="perDeviation";
		document.forms[0].hidBeanMethod.value="updatePermissionGistMoreDet";
		document.forms[0].hidBeanGetMethod.value="getPermissionGistMoreDet";
		document.forms[0].hidSourceUrl.value="/action/permissiongist_addDetails.jsp";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].submit();	
	}
	function doEdit()
	{
		if(document.forms[0].txt_extfac_presroifac){
		<%if (arrRow5 != null && arrRow5.size() > 0) {
			for (int i = 0; i < arrRow5.size(); i++) {
			if(arrRow5.size()>1){%>
				document.forms[0].txt_extfac_presroifac[<%=i%>].readOnly=false;
				document.forms[0].txt_extfac_arrear[<%=i%>].readOnly=false;
			<%}else{%>
				document.forms[0].txt_extfac_presroifac.readOnly=false;
				document.forms[0].txt_extfac_arrear.readOnly=false;
		<%}}}%>
		}

		if(document.forms[0].txt_exstfac_interest){
		<%if (arrRow4 != null && arrRow4.size() > 0) {
			for (int i = 0; i < arrRow4.size(); i++) {
			if(arrRow4.size()>1){%>
				document.forms[0].txt_exstfac_interest[<%=i%>].readOnly=false;
				document.forms[0].txt_exstfac_arrears[<%=i%>].readOnly=false;
			<%}else{%>
				document.forms[0].txt_exstfac_interest.readOnly=false;
				document.forms[0].txt_exstfac_arrears.readOnly=false;
		<%}}}%>
		}

		if(document.forms[0].txt_other_bankname){
			<%if (arrRow_bank != null && arrRow_bank.size() > 0) {
				for (int i = 0; i < arrRow_bank.size(); i++) {
				if(arrRow_bank.size()>1){ %>
					if(document.forms[0].txt_other_val1[<%=i%>].value=="N")
					{
						document.forms[0].check[<%=i%>].disabled=false;
						document.forms[0].txt_other_limit[<%=i%>].readOnly=false;
						document.forms[0].txt_other_facility[<%=i%>].readOnly=false;
						document.forms[0].txt_other_duedate[<%=i%>].readOnly=false;
						document.forms[0].txt_other_arrear[<%=i%>].readOnly=false;
						
					}
				<%}else{%>
					if(document.forms[0].txt_other_val1.value=="N")
					{
						document.forms[0].check.disabled=false;
						document.forms[0].txt_other_limit.readOnly=false;
						document.forms[0].txt_other_facility.readOnly=false;
						document.forms[0].txt_other_duedate.readOnly=false;
						document.forms[0].txt_other_arrear.readOnly=false;
					}
			<%}}}%>
		}

		
		callDisableControls(true,false,false,true);
			}
	function doCancel()
	{
		var varconfirm=ConfirmMsg('102');
		if(varconfirm)
		{
		document.forms[0].hidBeanGetMethod.value="getPermissionGistMoreDet";
		document.forms[0].hidBeanId.value="perDeviation";
		document.forms[0].action=appUrl+"action/permissiongist_addDetails.jsp";
		document.forms[0].submit();
		}
	}
	function onload()
	{
		var nodelist = document.getElementsByTagName("div").length;
		for(var i=0;i<nodelist;i+=2)
		{
			var x=document.getElementsByTagName("div")[i].id;
			var tmp=x.replace("_div","");
			$('.'+tmp).hide();
		}
		
		
		var permsubtypedesc="";
		if(permsubtype=="5")
		{
			permsubtypedesc="cre";
		}
		else if(permsubtype=="6")
		{
			permsubtypedesc="gen";
		}
		else if(permsubtype=="7")
		{
			permsubtypedesc="sal";
		}
		else if(permsubtype=="8")
		{
			permsubtypedesc="trust";
		}
		else if(permsubtype=="3")
		{
			permsubtypedesc="dev";
		}
		else if(permsubtype=="4")
		{
			permsubtypedesc="dev";
		}
		
		
		var nodelist = document.getElementsByTagName("div").length;
		for(var i=0;i<nodelist;i+=2)
		{
			var x=document.getElementsByTagName("div")[i].id;
			if(x.indexOf(permsubtypedesc)>-1)
			{	
				var tmp=x.replace("_div","");
				$('.'+tmp).show();
			}
		}
		var AssessmentParam=document.forms[0].hidassessment.value;
		 var FinancialParam=document.forms[0].hidfinancial.value;	 
				if(AssessmentParam=="Y")
				{			
					document.all.idAssessment.style.display="table-cell";
				}
				else
				{
					document.all.idAssessment.style.display="none";
				}
				if(FinancialParam=="Y")
				{
					document.all.idFinancial.style.display="table-cell";
				}
				else
				{				
					document.all.idFinancial.style.display="none";				
				}	
				
				//callDisableControls(false,true,true,false);
				disablefields(true);

			if(varDEV_CBSID!="")
			{
				document.all.id_otherBank_exst.style.display="table-cell";
				document.all.id_otherBank_new.style.display="none";
			}
			else
			{
				document.all.id_otherBank_exst.style.display="none";
				document.all.id_otherBank_new.style.display="table-cell";
			}
	}	

	function disablefields(bool)
	{
		for(var i=0;i<document.forms[0].length;i++)
		{
			if(document.forms[0].elements[i].type=='text')
			{
				document.forms[0].elements[i].readOnly=bool;
			}	  
			if(document.forms[0].elements[i].type=='select-one')
			{
				document.forms[0].elements[i].disabled=bool;
			}
			if(document.forms[0].elements[i].type=="textarea")
			{
				document.forms[0].elements[i].readOnly=bool;		  
			}		
			if(document.forms[0].elements[i].type=='checkbox')
			{
				document.forms[0].elements[i].disabled=bool;
			}

		}
	}

	function callDisableControls(cmdEdit,cmdSave,cmdCancel,cmdClose)
	{
		document.forms[0].cmdedit.disabled=cmdEdit;
		document.forms[0].cmdsave.disabled=cmdSave;
		document.forms[0].cmdcancel.disabled=cmdCancel;
		document.forms[0].cmdclose.disabled=cmdClose;
	}	

	function addexstFac3()
	{
		if(document.forms[0].cmdedit.disabled==true)
		{	
		var tab  = document.getElementById("tab_other_bank");
		var rowsLength = tab.rows.length;
		if(rowsLength<=200)
		{
			var new_Row    = tab.insertRow(rowsLength);
			var rwlength=rowsLength;
			new_Row.id=1+rowsLength;
			new_Row.className="datagrid";
			new_Row.align="center";
			var previous_RowCells=tab.rows[rowsLength-1].cells; 
			for(i=0;i<previous_RowCells.length;i++)
			{
				var new_RowCell=new_Row.insertCell(i);
				new_RowCell.innerHTML=previous_RowCells[i].innerHTML;
				new_RowCell.align="center";
				var new_CellElement=new_RowCell.childNodes[0];
				if(i==0)
		        {
		        	new_RowCell.align="center";
		        }
				for(var j=0;j<new_RowCell.childNodes.length;j++)
				{
					if(new_RowCell.childNodes[j].type=="text")
					{
						new_RowCell.childNodes[j].value="";
						new_RowCell.width="18%";	
						new_RowCell.childNodes[j].disabled=false;
						new_RowCell.childNodes[j].readOnly=false;
						
					}
					if(new_RowCell.childNodes[j].type=="textarea")
					{
						new_RowCell.childNodes[j].value="";	
						new_RowCell.width="25%";		  
						new_RowCell.childNodes[j].disabled=false;
						new_RowCell.childNodes[j].readOnly=false;
						
					}
					if(new_RowCell.childNodes[j].type=="checkbox")
					{
						new_RowCell.childNodes[j].checked=false;	
						new_RowCell.width="3%";	  
						new_RowCell.childNodes[j].disabled=false;
					}
					if(new_RowCell.childNodes[j].name=="txt_other_val1")
					{
						new_RowCell.childNodes[j].value="N";
					}
					if(new_RowCell.childNodes[j].name=="hid_other_bankcode")
					{
						new_RowCell.childNodes[j].value="";
					}
					if(new_RowCell.childNodes[j].name=="txt_other_bankname")
					{
						new_RowCell.childNodes[j].readOnly=true;
					}
					
				}
				 
			}
		}
		else
		{
			alert("Cannot add more rows");
		}
		//ClearFields();
		}
	}

	function callBankmaster(rowIndex1,obj)
	{
		var table=document.getElementById("tab_other_bank");
		var rowcount1=table.rows.length; 
		var varflag="false";
		var index="";

		if(rowcount1==1)
		{
			if (document.forms[0].cmdsave.disabled == false && document.forms[0].txt_other_val1.value=="N") 
			{
				var varQryString = appURL+"action/ops_sanctionhelp.jsp?hidBeanGetMethod=getSearch&hidBeanId=additionalParameter&pagename=deviation&id=147&rowcount="+rowcount1+"&rowIndex=1";
				var title = "Bank_Master";
				var prop = "scrollbars=no,width=650,height=400";
				var xpos = "50";
				var ypos = "50";
				prop = prop+","+xpos+","+ypos+",left=200,top=200";
				window.open(varQryString,title,prop);
			}
		}
		else if(rowcount1>1)
		{
			for(var i=0;i<document.all.idbank.length;i++)
				{
					if(obj==document.all.idbank[i])
					{
						if(document.forms[0].txt_other_val1[i].value=="N")
						{
							index=i;
							varflag="true";
						}
					}
				}
			if(varflag=="true")
			{
				var varQryString = appURL+"action/ops_sanctionhelp.jsp?hidBeanGetMethod=getSearch&hidBeanId=additionalParameter&pagename=deviation&id=147&rowcount="+rowcount1+"&rowIndex="+index;
				var title = "Bank_Master";
				var prop = "scrollbars=no,width=650,height=400";
				var xpos = "50";
				var ypos = "50";
				prop = prop+","+xpos+","+ypos+",left=200,top=200";
				window.open(varQryString,title,prop);
			}
		}
	}

	function deleterow1(tabid,tdcount)
	{
		if(document.forms[0].cmdedit.disabled==true)
		{
			var tab = document.getElementById(tabid);
			var rowsLength = tab.rows.length;
			var varCheckedFlag=false;

			var tab1 = document.getElementById("tab_other_bank");
			var rowsLength1 = tab.rows.length;

			if(rowsLength>=1)
			{
				for(var i=0;i<rowsLength;i++)
				{
					var current_row = tab.rows[i];
					var chkbox = current_row.cells[tdcount].childNodes[0];
					if(chkbox != null && chkbox.checked == true)
					{
						if(tabid=="tab_other_bank" && rowsLength=="1")
						{
							 document.forms[0].txt_other_bankname.value="";  
							 document.forms[0].hid_other_bankcode.value="";  
					    	 document.forms[0].txt_other_facility.value="";
					    	 document.forms[0].txt_other_limit.value="";  
					    	 document.forms[0].txt_other_duedate.value="";
					    	 document.forms[0].txt_other_arrear.value="";
					    	 document.forms[0].txt_other_val1.value="N";
					    	 
					    	 chkbox.checked=false;
					    	 return;
								
						}
						else
						{
							tab.deleteRow(i);
							rowsLength--;
							i--;
						}

						if(!varCheckedFlag)
						{
							varCheckedFlag=true;
						}
					}
				}
				if(!varCheckedFlag)
				{
					alert("please select the check box for deletion");
				}
			}
		}
	}

	function callCalender_mul(name,rowindex,obj) 
	{
		var varflag="false";
			var tab  = document.getElementById("tab_other_bank");
			var rowsLength = tab.rows.length;
			if(rowsLength==1)
			{
				if (document.forms[0].cmdsave.disabled == false && document.forms[0].txt_other_val1.value=="N") 
				{
					showCal(appURL, name);
				}
			}
			else
			{
				if(name=="txt_other_duedate")
				{
					for(var i=0;i<document.all.idcal2.length;i++)
					{
						if(obj==document.all.idcal2[i])
						{
							name="txt_other_duedate["+(i)+"]";
							if(document.forms[0].txt_other_val1[i].value=="N")
							{
								varflag="true";
							}
						}
					}
				}
				if (document.forms[0].cmdsave.disabled == false && varflag=="true") 
				{
					showCal(appURL, name);
				}
			}
	}
	
	function callCalender_mul2(name,rowindex,obj) 
	{
		var tab  = document.getElementById("tab_extFac1");
		var rowsLength = tab.rows.length;
		if(rowsLength==1)
		{
			if (document.forms[0].cmdsave.disabled == false) 
			{
				showCal(appURL, name);
			}
		}
		else
		{
			for(var i=0;i<document.all.idcal2.length;i++)
			{
				if(obj==document.all.idcal2[i])
				{
					name="txt_extfac_duedate["+(i)+"]";
				}
			}
			if (document.forms[0].cmdsave.disabled == false) 
			{
				showCal(appURL, name);
			}
		}
	}
	function callCalender_mul3(name,rowindex,obj) 
	{
		var tab  = document.getElementById("tab_exstFacility_cre1");
		var rowsLength = tab.rows.length;
		if(rowsLength==1)
		{
			if (document.forms[0].cmdsave.disabled == false) 
			{
				showCal(appURL, name);
			}
		}
		else
		{
			for(var i=0;i<document.all.idcal3.length;i++)
			{
				if(obj==document.all.idcal3[i])
				{
					name="txt_exstfac_duedate["+(i)+"]";
				}
			}
			if (document.forms[0].cmdsave.disabled == false) 
			{
				showCal(appURL, name);
			}
		}
	}


		
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>

</head>
<body onload="onload();">
<form method="post" class="normal">

<table width="100%" border="0" cellpadding="0" cellspacing="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../share/devurllinker.jsp" flush="true">
			<jsp:param name="pageid" value="1" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0"
	class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Permission -&gt; Permission Gist More Details
		</td>
	</tr>
</table>
	<lapschoice:ApplDevHeaderTag />

<table width="100%">

	<tr>
		<td>
		<table border="0" cellspacing="2" cellpadding="3" align="left"
			class="outertable">
			<tr>
				<td class="sub_tab_inactive" id="prin" width="150px;" align="center"><b><a href="#" 
					onclick="javascript:callLink('permission_gist.jsp','perDeviation','getPermissionGistData')">Permission Gist</a></b></td>
				<td class="sub_tab_active" id="more_det" nowrap width="250px;" align="center"><b>Permission Gist- More Information</b></td>
				<td class="sub_tab_inactive" id="prin" align="center" width="200px;"><b><a href="#"
					onclick="javascript:callLink('perm_appbackground_info.jsp','perDeviation','get_PermApplBackgroundData')">Background of the Applicant</a></b></td>
				<td class="sub_tab_inactive" id="idAssessment" width="200px" align="center" ><b><a href="#"
					onclick="javascript:callLink('perdeviationassessment.jsp','perDeviation','getAssessment')">Interest concession Assessment</a></b></td>
				<td class="sub_tab_inactive" id="prin" width="150px;" align="center"><b><a href="#"
					onclick="javascript:callLink('permission_parameters.jsp','perDeviation','getPermissionData')">Permission Parameters</a></b></td>
				<td class="sub_tab_inactive" id="idFinancial" width="200px;" align="center" ><b><a href="#"
					onclick="javascript:callLink('perm_financial.jsp','perDeviation','getdataFinancial')">Gist of Balance Sheet Analysis</a></b></td>
			</tr>
		</table>
		</td>
	</tr>
</table>

<table width="98%" border="0" cellspacing="0" cellpadding="3"
	class="outertable">
	<tr>
	<td valign="top">
	<table width="100%" border="0" cellspacing="0" cellpadding="0"
		class="outertable">
		<tr>
			<td valign="top">
			<table width="98%" border="0" cellspacing="0" cellpadding="5" class="outertable">
				
				<%if(strDEV_SUBTYPE.equalsIgnoreCase("3") || strDEV_SUBTYPE.equalsIgnoreCase("4") || strDEV_SUBTYPE.equalsIgnoreCase("6") || strDEV_SUBTYPE.equalsIgnoreCase("8"))
				{%>	
				<div id="id_gen_dev_trust_div">
				<tr class="id_gen_dev_trust">
					<td valign="top">
					<table width="99%" border="0" cellspacing="1" cellpadding="3"
						class="outertable">
						<tr>
						<td class="dataheader" align="center" colspan="7">Existing Facility</td>
						</tr>
						<tr class="dataheader" align="center">
							<td width="14%">Proposal No</td>
							<td width="14%">Facility S.No</td>
							<td width="14%">Name of the Facility</td>
							<td width="14%">Module Type</td>
							<td width="14%">A/C Number</td>
							<td width="14%">Limit</td>
							<td width="16%">Purpose</td>
						</tr>
					</table>
					<table width="99%" border="0" cellspacing="1" cellpadding="3" class="outertable" >
						<%
							ArrayList arrCol5 = new ArrayList();
								if (arrRow5 != null && arrRow5.size() > 0) {
									for (int i = 0; i < arrRow5.size(); i++) {
										arrCol5 = (ArrayList) arrRow5.get(i);
						%>
						<tr class="datagrid" align="center">
							<td width="14%"><input type="text" name="txt_Proposalnumber"
								value="<%=Helper.correctNull((String) arrCol5.get(0))%>">
								<input type="hidden" name="txt_hidborrowerID" value="<%=Helper.correctNull((String) arrCol5.get(14))%>"></td>
							<td width="14%"><input type="text" name="txt_facsno"
								value="<%=Helper.correctNull((String) arrCol5.get(1))%>"></td>
							<td width="14%"><input type="text" name="txt_extfac_Name"
								value="<%=Helper.correctNull((String) arrCol5.get(2))%>"></td>
							<td width="14%"><input type="text" name="txt_ModuleType"
								value="<%=Helper.correctNull((String) arrCol5.get(3))%>"></td>
							<td width="14%"><input type="text" name="txt_extfac_accnum"
								value="<%=Helper.correctNull((String) arrCol5.get(4))%>"></td>
							<td width="14%"><input type="text" name="txt_extfac_limit"
								value="<%=Helper.correctNull((String) arrCol5.get(5))%>"
								onblur="roundtxt(this);" style="text-align: right;"></td>
							<td width="16%"><textarea name="txt_extfac_purpose" rows="3"
								cols="25"><%=Helper.correctNull((String) arrCol5.get(6))%></textarea></td>
						</tr>
						<%
							}
								} else {
						%>
						<tr class="datagrid" align="center">
							  <td colspan="7"> No Records Found </td>
						</tr>
						<%
							}
						%>
					</table>
					<br />
					<table width="99%" border="0" cellspacing="1" cellpadding="3" class="outertable">
						<tr class="dataheader" align="center">
							<td width="19%">Sanctioned Ref</td>
							<td width="13%">Sanctioned Date</td>
							<td width="13%">Sanctioned ROI</td>
							<td width="13%">Present ROI charged to the facility</td>
							<td width="13%">Bal O/s</td>
							<td width="13%">Due Date</td>
							<td width="16%">Arrears if any status</td>
						</tr>
					</table>
					<table width="99%" border="0" cellspacing="1" cellpadding="3" class="outertable" id="tab_extFac1">
						<%
							if (arrRow5 != null && arrRow5.size() > 0) {
									for (int i = 0; i < arrRow5.size(); i++) {
										arrCol5 = (ArrayList) arrRow5.get(i);
						%>
						<tr class="datagrid" align="center">
							<td width="19%"><input type="text" name="txt_extfac_sancref"
								size="35"
								value="<%=Helper.correctNull((String) arrCol5.get(7))%>"></td>
							<td width="13%"><input type="text"
								name="txt_extfac_sancdate" size="15"
								value="<%=Helper.correctNull((String) arrCol5.get(8))%>"></td>
							<td width="13%"><input type="text" name="txt_extfac_sancroi"
								onblur="roundtxt(this);"
								value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrCol5.get(9))))%>"></td>
							<td width="13%"><input type="text"
								name="txt_extfac_presroifac" onblur="roundtxt(this);checkPercentage(this);" maxlength="6" onkeypress="allowNumber(this);"
								value="<%=Helper.correctNull((String) arrCol5.get(10))%>"></td>
							<td width="13%"><input type="text" name="txt_extfac_bal"
								onblur="roundtxt(this);"
								value="<%=Helper.correctNull((String) arrCol5.get(11))%>"></td>
							<td width="13%"><input type="text" name="txt_extfac_duedate"
								size="15"
								value="<%=Helper.correctNull((String) arrCol5.get(12))%>">
								<a alt="Select date from calender"
											onClick="callCalender_mul2('txt_extfac_duedate',this.parentNode.parentNode.id,this);"
											onMouseOver="window.status='Date Picker';return true;"
											onMouseOut="window.status='';return true;" id="idcal2"> <img
											src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
											alt="Select date from calender"></a>	
								</td>
							<td width="16%"><textarea name="txt_extfac_arrear" rows="3"
								cols="25" onKeyPress="textlimit(this,399)" onKeyUp="textlimit(this,399)"><%=Helper.correctNull((String) arrCol5.get(13))%></textarea>
							</td>
						</tr>
						<%
							}
								} else {
						%>
						<tr class="datagrid" align="center">
							 <td colspan="7"> No Records Found </td>
						</tr>
						<%
							}
						%>
					</table>
					</td>
				</tr>
				</div>
				<%} %>	
					
				<%if(strDEV_SUBTYPE.equalsIgnoreCase("5")){ %>	
				<div id="id_cre_div">
				<tr class="id_cre" >
					<td valign="top">
					<table width="100%" border="0" cellspacing="1" cellpadding="3"
						class="outertable">
						<tr>
						<td class="dataheader" align="center" colspan="6">Existing Facility</td>
						</tr>
						<tr class="dataheader" align="center">
							<td width="17%">Proposal No</td>
							<td width="17%">Facility S.No</td>
							<td width="17%">Module Type</td>
							<td width="17%">Name of the Borrower</td>
							<td width="17%">Nature of loan/facility</td>
							<td width="15%">Date of Loan</td>
						</tr>
					</table>
					<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable" >
						<%
							ArrayList arrCol4 = new ArrayList();
								if (arrRow4 != null && arrRow4.size() > 0) {
									for (int i = 0; i < arrRow4.size(); i++) {
										arrCol4 = (ArrayList) arrRow4.get(i);
						%>
						<tr class="datagrid" align="center" id="1">
							<td width="17%"><input type="text"
								name="txt_exst_Proposalnumber" size="22"
								value="<%=Helper.correctNull((String) arrCol4.get(0))%>">
								<input type="hidden" name="txt_hidborrowerID" value="<%=Helper.correctNull((String) arrCol4.get(11))%>"></td>
							<td width="17%"><input type="text" name="txt_exst_facsno"
								size="22"
								value="<%=Helper.correctNull((String) arrCol4.get(1))%>"></td>
							<td width="17%"><input type="text"
								name="txt_exst_ModuleType" size="22"
								value="<%=Helper.correctNull((String) arrCol4.get(2))%>"></td>
							<td width="17%"><input type="text"
								name="txt_exstfac_borName" style="text-align: center" size="22"
								value="<%=Helper.correctNull((String) arrCol4.get(3))%>">
							</td>
							<td width="17%"><input type="text"
								name="txt_exstfac_facnature" size="22"
								value="<%=Helper.correctNull((String) arrCol4.get(4))%>"></td>
							<td width="15%"><input type="text"
								name="txt_exstfac_loandate" size="15"
								value="<%=Helper.correctNull((String) arrCol4.get(5))%>"></td>
						</tr>
						<%
							}
								} else {
						%>
						<tr class="datagrid" align="center" id="1">
							  <td colspan="6"> No Records Found </td>
						</tr>
						<%
							}
						%>
					</table>
					</td>
				</tr>

				<tr class="id_cre">
					<td>
					<table width="100%" border="0" cellspacing="1" cellpadding="3"
						class="outertable">
						<tr class="dataheader" align="center">
							<td width="20%">Limit</td>
							<td width="20%">O/s. Bal</td>
							<td width="20%">ROI/ Commission</td>
							<td width="20%">Due Date</td>
							<td width="20%">Arrears</td>
						</tr>
					</table>
					<table width="100%" border="0" cellspacing="1" cellpadding="3"
						class="outertable" id="tab_exstFacility_cre1">
						<%
							if (arrRow4 != null && arrRow4.size() > 0) {
									for (int i = 0; i < arrRow4.size(); i++) {
										arrCol4 = (ArrayList) arrRow4.get(i);
						%>
						<tr class="datagrid" align="center">
							<td width="20%"><input type="text" name="txt_exstfac_limit" size="20" 
								value="<%=Helper.correctNull((String) arrCol4.get(6))%>" style="text-align: right;"></td>
							<td width="20%"><input type="text" name="txt_exstfac_osbalance" size="20"
								value="<%=Helper.correctNull((String) arrCol4.get(7))%>" style="text-align: right;"></td>
							<td width="20%"><input type="text" name="txt_exstfac_interest" size="20" onblur="roundtxt(this);checkPercentage(this);" maxlength="6" onkeypress="allowNumber(this);"
								value="<%=Helper.correctNull((String) arrCol4.get(8))%>" style="text-align: right;"></td>
							<td width="20%"><input type="text" name="txt_exstfac_duedate" size="20"
								value="<%=Helper.correctNull((String) arrCol4.get(9))%>">
								<a alt="Select date from calender"
											onClick="callCalender_mul3('txt_exstfac_duedate',this.parentNode.parentNode.id,this);"
											onMouseOver="window.status='Date Picker';return true;"
											onMouseOut="window.status='';return true;" id="idcal3"> <img
											src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
											alt="Select date from calender"></a>
								</td>
							<td width="20%"><textarea name="txt_exstfac_arrears"
								rows="3" cols="25" onKeyPress="textlimit(this,399)" onKeyUp="textlimit(this,399)"><%=Helper.correctNull((String) arrCol4.get(10))%></textarea>
							</td>
						</tr>
						<%
							}
								} else {
						%>
						<tr class="datagrid" align="center" >
							 <td colspan="6"> No Records Found </td>
						</tr>
						<%
							}
						%>
					</table>
					</td>

				</tr>
				</div>	
				<%} %>	
				
				
				<div id="id_cre_dev_gen_div">
				<tr class="id_cre_dev_gen" >
					<td>
					<table width="99%" border="0" cellspacing="1" cellpadding="3"
						class="outertable">
						<tr class="dataheader" align="center">
						<td colspan="8">Security Details for the Existing Facilities</td>
						</tr>
						<tr class="dataheader" align="center">
							<td width="12%">Proposal Number</td>
							<td width="8%">Fac S.no</td>
							<td width="12%">Security ID</td>
							<td width="12%">Applicant Name</td>
							<td width="16%">Description</td>
							<td width="10%">Value</td>
							<td width="8%">Type</td>
							<td width="8%">Margin</td>
						</tr>
						<%
							ArrayList arrCol9 = new ArrayList();
							ArrayList arrRow9 = (ArrayList) hshValues.get("arrRow_sec");
							if (arrRow9 != null && arrRow9.size() > 0) {
								for (int i = 0; i < arrRow9.size(); i++) {
									arrCol9 = (ArrayList) arrRow9.get(i);
						%>

						<tr class="datagrid" align="center">
							<td width="12%"><input type="text" name="txt_secur_propno"
								size="20"
								value="<%=Helper.correctNull((String) arrCol9.get(0))%>"
								style="text-align: center"></td>
							<td width="12%"><input type="text" name="txt_secur_facsno"
								size="10"
								value="<%=Helper.correctNull((String) arrCol9.get(1))%>"
								style="text-align: center"></td>
							<td width="12%"><input type="text" name="txt_secur_id"
								size="20"
								value="<%=Helper.correctNull((String) arrCol9.get(2))%>"
								style="text-align: center"></td>
							<td width="12%"><input type="text" name="txt_secur_appname"
								size="20"
								value="<%=Helper.correctNull((String) arrCol9.get(3))%>"
								style="text-align: center"></td>
							<td width="16%"><textarea rows="3" cols="30"
								name="txt_secur_desp"><%=Helper.correctNull((String) arrCol9.get(4))%></textarea></td>
							<td width="12%"><input type="text" name="txt_secur_val"
								size="15" onblur="roundtxt(this);"
								value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String) arrCol9.get(5))))%>"
								style="text-align: right"></td>
							<td width="12%"><input type="text" name="txt_secur_type"
								size="20"
								value="<%=Helper.correctNull((String) arrCol9.get(6))%>"
								style="text-align: center"></td>
								<%if(Helper.correctNull((String) arrCol9.get(6)).equalsIgnoreCase("Collateral")) {%>
									<td width="12%"><input type="text" name="txt_secur_marg"
									size="10" onblur="roundtxt(this);checkPercentage(this);"
									value=""
									style="text-align: center"></td>
								<%} else{%>
									<td width="12%"><input type="text" name="txt_secur_marg"
										size="10" onblur="roundtxt(this);checkPercentage(this);"
										value="<%=Helper.correctNull((String) arrCol9.get(7))%>"
										style="text-align: center"></td>
								<%} %>
						</tr>
						<%
							}
							} else {
						%>
						<tr class="datagrid" align="center">
							 <td colspan="8"> No Records Found </td>
						</tr>
						<%
							}
						%>
					</table>
					</td>
				</tr>
				</div>
				
					<div id="id_dev_gen_div">
						<tr class="id_dev_gen" id="p2">
							<td valign="top"> 
							<table width="99%" border="0" cellspacing="1" cellpadding="3"
								class="outertable">
								<tr class="dataheader" align="center">
								<td colspan="5" id="id_otherBank_new">Details of loan accounts maintained with other Bank &nbsp;
									<a onClick="addexstFac3();"><img src="<%=ApplicationParams.getAppUrl()%>img/add.png" width="10"	height="10" border="0" tabindex="38"></a>&nbsp;&nbsp;&nbsp; 
									<a onClick="deleterow1('tab_other_bank','0');"><img	src="<%=ApplicationParams.getAppUrl()%>img/cancel.png" width="10" height="10" border="0" tabindex="38"></a>
								</td>
								<td colspan="5" id="id_otherBank_exst">Details of loan accounts maintained with other Bank</td>
								</tr>
								<tr class="dataheader" align="center">
									<td width="27%">Name of the Bank</td>
									<td width="18%">Facility</td>
									<td width="15%">Limit</td>
									<td width="15%">Due Date</td>
									<td width="25%">Arrears if any</td>
								</tr>
							</table>
							<table width="99%" border="0" cellspacing="1" cellpadding="3"
								class="outertable" id="tab_other_bank">
								<%
									ArrayList arrCol8 = new ArrayList();
									ArrayList arrRow8 = (ArrayList) hshValues.get("arrRow_bank");
									String str_otherval="";
									if (arrRow8 != null && arrRow8.size() > 0) {
										for (int i = 0; i < arrRow8.size(); i++) {
											arrCol8 = (ArrayList) arrRow8.get(i);
									str_otherval = Helper.correctNull((String) arrCol8.get(6));
								%>
								<tr class="datagrid" align="center">
		
									<td width="3%"><input type="checkbox" name="check"
										style="border: none;"> 
										<input type="hidden" name="txt_other_val1" value="<%=str_otherval %>"></td>
									<td width="24%"><input type="text" name="txt_other_bankname"
										size="45" maxlength="50" style="text-align: center" readOnly="readonly" onKeyPress="notAllowSingleAndDoubleQuote();notAllowSplChar()"
										value="<%=Helper.correctNull((String) arrCol8.get(5))%>">
										<input type="hidden" name="hid_other_bankcode" value="<%=Helper.correctNull((String) arrCol8.get(0))%>">
												<a onClick="callBankmaster(this.parentNode.parentNode.id,this)" id="idbank" style="cursor: hand">
												<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0">
												</a>
										</td>
									<td width="18%"><input type="text" name="txt_other_facility"
										size="25" style="text-align: left" maxlength="20"
										value="<%=Helper.correctNull((String) arrCol8.get(1))%>"></td>
									<td width="15%"><input type="text" name="txt_other_limit"
										size="20" onKeyPress="allowNumber(this)" maxlength="15"
										onblur="roundtxt(this);"
										value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrCol8.get(2))))%>"
										style="text-align: right"></td>
									<td width="15%"><input type="text" name="txt_other_duedate"
										size="20" style="text-align: center" onblur="checkDate(this);"
										value="<%=Helper.correctNull((String) arrCol8.get(3))%>">
										<a alt="Select date from calender"
											onClick="callCalender_mul('txt_other_duedate',this.parentNode.parentNode.id,this);"
											onMouseOver="window.status='Date Picker';return true;"
											onMouseOut="window.status='';return true;" id="idcal2"> <img
											src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
											alt="Select date from calender"></a></td>
									<td width="25%"><textarea rows="3" cols="30"
										name="txt_other_arrear" onkeyup="textlimitcorp1(this,50);" onkeydown="textlimitcorp1(this,50);"><%=Helper.correctNull((String) arrCol8.get(4))%></textarea></td>
								</tr>
								<%
									}
									} else {
								%>
								<tr class="datagrid" align="center">
										  <td colspan="6"> No Records Found </td>
								</tr>
								
								<tr class="datagrid" align="center" style="visibility: hidden; position: absolute;">
									<td width="3%"><input type="checkbox" name="check"
										style="border: none;"> 
										<input type="hidden" name="txt_other_val1" value=""></td>
									<td width="24%"><input type="text" name="txt_other_bankname"
										size="45" maxlength="50" style="text-align: center" readOnly="readonly" onKeyPress="notAllowSingleAndDoubleQuote();notAllowSplChar()"
										value="">
										<input type="hidden" name="hid_other_bankcode" value="">
												<a onClick="callBankmaster(this.parentNode.parentNode.id,this)" id="idbank" style="cursor: hand">
												<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0">
												</a>
										</td>
									<td width="18%"><input type="text" name="txt_other_facility"
										size="25" style="text-align: left" maxlength="20"
										value=""></td>
									<td width="15%"><input type="text" name="txt_other_limit"
										size="20" onKeyPress="allowNumber(this)" maxlength="15"
										onblur="roundtxt(this);"
										value=""
										style="text-align: right"></td>
									<td width="15%"><input type="text" name="txt_other_duedate"
										size="20" style="text-align: center" onblur="checkDate(this);"
										value="">
										<a alt="Select date from calender"
											onClick="callCalender_mul('txt_other_duedate',this.parentNode.parentNode.id,this);"
											onMouseOver="window.status='Date Picker';return true;"
											onMouseOut="window.status='';return true;" id="idcal2"> <img
											src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
											alt="Select date from calender"></a></td>
									<td width="25%"><textarea rows="3" cols="30" onKeyPress="textlimit(this,49)" onKeyUp="textlimit(this,49)"
										name="txt_other_arrear"></textarea></td>
								</tr>
								<%
									}
								%>
							</table>
						</td>
					</tr>
				</div>	
				
				
				<div id="id_dev_gen_div">
				<tr class="id_dev_gen" >
					<td valign="top">
					<table width="100%" border="0" cellspacing="1" cellpadding="3"
						class="outertable">
						<tr class="dataheader" align="center">
						<td colspan="6">Details of deposit accounts</td>
						</tr>
						<tr class="dataheader" align="center">
							<td width="19%">Name</td>
							<td width="16%">Account No.</td>
							<td width="16%">Deposit Amt (Rs.)</td>
							<td width="16%">Present balance (Rs.)</td>
							<td width="16%">Maturity Date</td>
							<td width="16%">Rate of Int (%)</td>
						</tr>
					</table>
					<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable" >
						<%
							ArrayList arrCol6 = new ArrayList();
							ArrayList arrRow6 = (ArrayList) hshValues.get("arrRow_depacc");
							if (arrRow6 != null && arrRow6.size() > 0) {
								for (int i = 0; i < arrRow6.size(); i++) {
									arrCol6 = (ArrayList) arrRow6.get(i);
						%>
						<tr class="datagrid" align="center" >
							<td width="19%"><input type="text" name="txt_dep_name" size="20"
								value="<%=Helper.correctNull((String) arrCol6.get(0))%>" style="text-align: center"></td>
							<td width="16%"><input type="text" name="txt_dep_accno" size="20"
								value="<%=Helper.correctNull((String) arrCol6.get(1))%>" style="text-align: right"></td>
							<td width="16%"><input type="text" name="txt_dep_depamt" size="20"
								value="<%=Helper.correctNull((String) arrCol6.get(2))%>" style="text-align: right;"></td>
							<td width="16%"><input type="text" name="txt_dep_presbal" size="20"
								value="<%=Helper.correctNull((String) arrCol6.get(3))%>" style="text-align: right;"></td>
							<td width="16%"><input type="text" name="txt_dep_maturdate" size="20" 
								value="<%=Helper.correctNull((String) arrCol6.get(4))%>" style="text-align: center"></td>
							<td width="16%"><input type="text" name="txt_dep_roi" size="20"
								value="<%=Helper.correctNull((String) arrCol6.get(5))%>" style="text-align: center"></td>
						</tr>
						<%
							}
							} else {
						%>
						<tr class="datagrid" align="center">
							  <td colspan="6"> No Records Found </td>
						</tr>
						<%
							}
						%>
					</table>
					</td>
				</tr>
				</div>
				
			</table>
			</td>
		</tr>
	</table>
	
	<table width="0%" border="0" cellspacing="0" cellpadding="2" class="outertable" align="center">
		<tr valign="top">
			<td height="2" align="center">
				<lapschoice:combuttonnew btnnames='Edit_Save_Cancel' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
			</td>
		</tr>
	</table>
	
	</td>
	</tr>
</table>
<lapschoice:hiddentag pageid='<%=PageId%>' />
</form>
</body>
</html>