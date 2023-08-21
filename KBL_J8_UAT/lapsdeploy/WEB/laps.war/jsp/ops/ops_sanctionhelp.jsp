<%@ include file="../share/directives.jsp"%>

<%ArrayList arrValues = new ArrayList();

			if (hshValues != null) {
				arrValues = (ArrayList) hshValues.get("arrCode");
			}
			//out.print();
			String strID = Helper.correctNull((String) request
					.getParameter("id"));
			String pagename = Helper.correctNull((String) request.getParameter("pagename"));
			String Position = Helper.correctNull((String) request.getParameter("Position"));
			String strLeadBankFlag=Helper.correctNull((String) request.getParameter("LeadBank"));
			
			int rowcount = Integer.parseInt(Helper.correctInt((String)request.getParameter("rowcount")));
			int rowIndex = Integer.parseInt(Helper.correctInt((String)request.getParameter("rowIndex")));

			%>
<html>
<head>
<title>Static Data Master Search</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<STYLE>

DIV.cellContainer {	
  width: 100%; height: 200;
  overflow: auto;
}
</STYLE>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
	<script
src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js">
</script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/PageLoadTime.js"></script>
<SCRIPT LANGUAGE="JavaScript">

var appURL = "<%=ApplicationParams.getAppUrl()%>";
var position="<%=Position%>";
var pagename="<%=pagename%>";
var strLeadBankFlag="<%=strLeadBankFlag%>";
var rowcount="<%=rowcount%>";
var rowIndex="<%=rowIndex%>";

function callSearch()
{
	var id="<%=strID%>";
	if(document.forms[0].cat[0].checked)
	{
		cat=1;
	}
	else if (document.forms[0].cat[1].checked)
	{
		cat=2;
	}
	else
	{
		alert("Select a search criteria to search");
		return;
	}
			
	var txtval=document.forms[0].txt_codename.value;
	var txtlen=txtval.length;	
	if (cat==2)
	{
		 if(txtlen<=2)
		 {
			 alert("Enter atleast 3 charcters");
		     document.forms[0].txt_codename.focus();
		     return;
	 	 }
	}
	else if(txtval=="")
	{
		 alert("Enter Value to Search");
	     document.forms[0].txt_codename.focus();
	     return;
	}
	document.forms[0].method="post";
	document.forms[0].hidBeanMethod.value="getSearch";
	document.forms[0].hidBeanGetMethod.value="getSearch";
	document.forms[0].hidBeanId.value="additionalParameter";
	document.forms[0].action=appURL+"action/ops_sanctionhelp.jsp?pagename="+pagename+"&LeadBank="+strLeadBankFlag+"&rowcount="+rowcount+"&rowIndex="+rowIndex;	
	document.forms[0].submit();
}

function ClearFields()
	{
		for(var i=0;i<document.forms[0].elements.length;i++)
		{
			if(document.forms[0].elements[i].type=="text")
			{
				  document.forms[0].elements[i].value="";		  
			}		
			
		}
	}

function setValues(value1,value2,value3)
{
	
	if("<%=pagename%>"=="industrygroup")
	{
		window.opener.document.forms[0].txt_indgrpcode.value=value2;
		window.opener.document.forms[0].txt_indgrp.value=value3;
	}
	else if("<%=pagename%>"=="industrymaster")
	{
		window.opener.document.forms[0].expid.value=value1;
		window.opener.document.forms[0].txt_grpcode.value=value2;
		window.opener.document.forms[0].exp_desc.value=value3;
	}
	else if("<%=pagename%>"=="kycnorms")
	{
	if("<%=strID%>"=='53')
		{
		window.opener.document.forms[0].txt_AnnualIncome.value=value3;
		window.opener.document.forms[0].hid_AnnualIncome.value=value2;
		}
	if("<%=strID%>"=='18')
		{		
		window.opener.document.forms[0].txt_CountryResi.value=value3;
		window.opener.document.forms[0].hid_CountryResi.value=value2;
		}
	if("<%=strID%>"=='54')
		{
		window.opener.document.forms[0].txt_IdProofType.value=value3;
		window.opener.document.forms[0].hid_IdProofType.value=value2;
		}
	if("<%=strID%>"=='55')
		{
		window.opener.document.forms[0].txt_ResiProofType.value=value3;
		window.opener.document.forms[0].hid_ResiProofType.value=value2;
		}
	if("<%=strID%>"=='56')
		{
		window.opener.document.forms[0].txt_SourceIncome.value=value3;
		window.opener.document.forms[0].hid_SourceIncome.value=value2;
		}
	if("<%=strID%>"=='57')
		{
		window.opener.document.forms[0].txt_Networth.value=value3;
		window.opener.document.forms[0].hid_Networth.value=value2;
		}
    if("<%=strID%>"=='58')
		{
		window.opener.document.forms[0].txt_TurnOver.value=value3;
		window.opener.document.forms[0].hid_TurnOver.value=value2;
		}
	if("<%=strID%>"=='59')
		{
		window.opener.document.forms[0].txt_EstiTurnOver.value=value3;
		window.opener.document.forms[0].hid_EstiTurnOver.value=value2;
		}
	if("<%=strID%>"=='60')
		{
		window.opener.document.forms[0].txt_Activity.value=value3;
		window.opener.document.forms[0].hid_Activity.value=value2;
		}
	if("<%=strID%>"=='18')
		{
		window.opener.document.forms[0].txt_RemitCountry.value=value3;
		window.opener.document.forms[0].hid_RemitCountry.value=value2;
		}
	if("<%=strID%>"=='61')
		{
		window.opener.document.forms[0].txt_Risk.value=value3;
		window.opener.document.forms[0].hid_Risk.value=value2;
		}
	if("<%=strID%>"=='18')
		{
		window.opener.document.forms[0].txt_city1.value=value3;
		window.opener.document.forms[0].hid_city1.value=value2;
		}
	if("<%=strID%>"=='18')
		{
		window.opener.document.forms[0].txt_cntry1.value=value3;
		window.opener.document.forms[0].hid_cntry1.value=value2;
		}
	if("<%=strID%>"=='18')
		{
		window.opener.document.forms[0].txt_city2.value=value3;
		window.opener.document.forms[0].hid_city2.value=value2;
		}
	if("<%=strID%>"=='18')
		{
		window.opener.document.forms[0].txt_cntry2.value=value3;
		window.opener.document.forms[0].hid_cntry2.value=value2;
		}
	if("<%=strID%>"=='18')
		{
		window.opener.document.forms[0].txt_city3.value=value3;
		window.opener.document.forms[0].hid_city3.value=value2;
		}
	if("<%=strID%>"=='18')
		{
		window.opener.document.forms[0].txt_cntry3.value=value3;
		window.opener.document.forms[0].hid_cntry3.value=value2;
		}
		if("<%=strID%>"=='70')
		{
			window.opener.document.forms[0].hid_custoccup.value=value2;
			window.opener.document.forms[0].txt_custoccup.value=value3;
		}
	}
	else if("<%=pagename%>"=="Banking")
	{
		window.opener.setBankmaster(value2,value3,position);
	}
	else if("<%=pagename%>"=="Bankingdetail")
	{
		window.opener.document.forms[0].hidmembnamecode.value=value2;
		window.opener.document.forms[0].txt_membname.value=value3;
	}
	else if("<%=pagename%>"=="Lead")
	{
		window.opener.setBankmaster(value2,value3,"Lead");
	}
	else if("<%=pagename%>"=="newbank")
	{
		window.opener.setBankmaster(value2,value3,"newbank");
	}
	else if("<%=pagename%>"=="CusBanking" && "<%=strLeadBankFlag%>"!='Y')
	{
		window.opener.document.forms[0].hid_LeadBankcode.value=value2;
		window.opener.document.forms[0].txt_Bank.value=value3;
	}
	else if("<%=pagename%>"=="Takeover")
	{
		window.opener.document.forms[0].hid_LeadBankcode.value=value2;
		window.opener.document.forms[0].txt_bankname.value=value3;
	}
	else if("<%=pagename%>"=="RetTakeOver")
	{
		window.opener.document.forms[0].txt_bankid.value=value2;
		window.opener.document.forms[0].loan_fininst.value=value3;
	}
	else if("<%=pagename%>"=="bsamaster1")
	{
		if(rowcount==1)
		{
			window.opener.document.forms[0].hid_dsaservBankcode.value=value2;
			window.opener.document.forms[0].txt_dsaservBank.value=value3;
		}
		else
		{
			window.opener.document.forms[0].hid_dsaservBankcode[<%=(rowIndex-1)%>].value=value2;
			window.opener.document.forms[0].txt_dsaservBank[<%=(rowIndex-1)%>].value=value3;
		}
	}

	else if("<%=pagename%>"=="deviation")
	{
		
		if(rowcount==1)
		{
			window.opener.document.forms[0].hid_other_bankcode.value=value2;
			window.opener.document.forms[0].txt_other_bankname.value=value3;
		}
		else if(rowcount>1)
		{
			window.opener.document.forms[0].hid_other_bankcode[<%=(rowIndex)%>].value=value2;
			window.opener.document.forms[0].txt_other_bankname[<%=(rowIndex)%>].value=value3;
		}
	}

	
	else if("<%=pagename%>"=="bsamaster2")
	{
		if(rowcount==1)
		{
			window.opener.document.forms[0].hid_empnameBankcode.value=value2;
			window.opener.document.forms[0].txt_empnameBank.value=value3;
		}
		else
		{
			window.opener.document.forms[0].hid_empnameBankcode[<%=(rowIndex-1)%>].value=value2;
			window.opener.document.forms[0].txt_empnameBank[<%=(rowIndex-1)%>].value=value3;
		}
	}
	else if("<%=pagename%>"=="sec")
	{
		window.opener.document.forms[0].hid_LeadBankcode.value=value2;
		window.opener.document.forms[0].txt_name_institution.value=value3;
	}
	else if("<%=pagename%>"=="DDR01")
	{	
		if(rowcount==1)
		{
			window.opener.document.forms[0].hid_LeadBank.value=value2;
			window.opener.document.forms[0].txt_Bank.value=value3;
		}
		else
		{
			window.opener.document.forms[0].hid_LeadBank[<%=(rowIndex)%>].value=value2;
			window.opener.document.forms[0].txt_Bank[<%=(rowIndex)%>].value=value3;
		}
	}
	else if("<%=pagename%>"=="DDR02")
	{
			window.opener.document.forms[0].hid_LeadBankcode.value=value2;
			window.opener.document.forms[0].txt_bankname.value=value3;
	}
	
	
	if("<%=pagename%>"=="CusBanking" && "<%=strLeadBankFlag%>"=='Y')
	{
		window.opener.document.forms[0].hid_Bankcode.value=value2;
		window.opener.document.forms[0].txt_LeadBank.value=value3;
	}
	if("<%=pagename%>"=="CusBanking_sub" && "<%=strLeadBankFlag%>"=='Y')
	{
		window.opener.document.forms[0].hid_sub_Bankcode.value=value2;
		window.opener.document.forms[0].txt_sub_LeadBank.value=value3;
	}
	else 
	{
		if("<%=strID%>"=='25')
		{
			var varpancheck="";
			if(window.opener.document.forms[0].hidTaxSlab)
			{
				varpancheck=window.opener.document.forms[0].hidTaxSlab.value;
			}
			if(varpancheck=="NOPAN")
			{
				if(value2=="NOPAN")
				{
					var value5=value2+"-"+value3;
					window.opener.document.forms[0].sel_taxslab.value=value2;
					window.opener.document.forms[0].txt_taxslab.value=value5;
				}
				else
				{
					alert('Select Only NOPAN');
					return;
				}
			}
			else
			{
				var value5=value2+"-"+value3;
				window.opener.document.forms[0].sel_taxslab.value=value2;
				window.opener.document.forms[0].txt_taxslab.value=value5;
			}
		}
		if("<%=strID%>"=='18')
		{
			var value5=value2+"-"+value3;
			window.opener.document.forms[0].sel_sectorcode.value=value2;
			window.opener.document.forms[0].txt_sectorcode.value=value5;
		}
		if("<%=strID%>"=='19')
		{
			var value5=value2+"-"+value3;
			window.opener.document.forms[0].sel_subsector.value=value2;
			window.opener.document.forms[0].txt_subsectorcode.value=value5;
		}
		if("<%=strID%>"=='22')
		{
			var value5=value2+"-"+value3;
			window.opener.document.forms[0].select_purposeadvance.value=value2;
			window.opener.document.forms[0].txt_purposeofadvance.value=value5;
		}
		if("<%=strID%>"=='16')
		{
			var value5=value2+"-"+value3;
			window.opener.document.forms[0].sel_oprationmode.value=value2;
			window.opener.document.forms[0].txt_operationmode.value=value5;
		}
		if("<%=strID%>"=='6')
		{
			var value5=value2;
			window.opener.document.forms[0].hidfreetext7.value=value2;
			window.opener.document.forms[0].txt_freetext7.value=value5;
		}
		if("<%=strID%>"=='62'||"<%=strID%>"=='63'
		   ||"<%=strID%>"=='64'||"<%=strID%>"=='65'
		   ||"<%=strID%>"=='66')
		{
			window.opener.document.forms[0].hidlabel.value=value2;
			window.opener.document.forms[0].txt_label.value=value3;
		}
		if("<%=strID%>"=='67')
		{
			window.opener.document.forms[0].hidcusttype.value=value2;
			window.opener.document.forms[0].txt_custtype.value=value3;
		}
		if("<%=strID%>"=='68')
		{
			window.opener.document.forms[0].hidhealthcode.value=value2;
			window.opener.document.forms[0].txt_healthcode.value=value3;
		}
		if("<%=strID%>"=='69')
		{
			window.opener.document.forms[0].hidfreecode7.value=value2;
			window.opener.document.forms[0].txt_freecode7.value=value3;
		}
		if("<%=pagename%>"=="svanidhi" && "<%=strLeadBankFlag%>"=='Y')
		{
			window.opener.document.forms[0].txt_bankcode.value=value2;
			window.opener.document.forms[0].txt_bankname.value=value3;
		}
		
		
	}
	window.close();
}


function doSelect()
{
	document.forms[0].txt_codename.value="";
	document.forms[0].txt_codename.focus();
}
function doClose()
{
	window.close();
}

function callOnload()
{
	if(("<%=pagename%>"=="Banking") || ("<%=pagename%>"=="Bankingdetail") || "<%=pagename%>"=="CusBanking")
	{
		document.all.setlabel.innerHTML="Bank Code";
		document.all.setlabel1.innerHTML="Bank Name";
	}
	
}
</SCRIPT>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css">
</head>
<body onload="callOnload()">
<form name="appform" method="post" class="normal">
<table width="98%" border="1" cellpadding="5" cellspacing="0" class="outertable" align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="1" class="outertable">
			<tr>
				<td>

				<table width="100%" border="0" cellspacing="0" cellpadding="1" class="outertable">
					<tr>
						<td width="4%" nowrap><input type="radio" name="cat" value="1"
							onClick="doSelect()" style="border-style:none"></td>
						<td width="25%" nowrap><b><div id="setlabel">CBS
						Code</div></b></td>
						<td width="4%" nowrap><input type="radio" name="cat" value="2"
							onClick="doSelect()" style="border-style:none"></td>
						<td width="17%" nowrap><b><div id="setlabel1">CBS
						Parameter</div></b></td>
						<td width="16%"><input type="text" name="txt_codename" size="20"
							maxlength="25" value="" onKeyPress="notAllowSplChar()">
						</td>
						<td width="16%">
						<div align="center"><input type="button" name="cmdsearch"
							value="Search"
							class="buttonStyle"
							onClick="callSearch()"></div>
						</td>

					</tr>
					<tr>
						<td colspan="7" nowrap>&nbsp;</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
					<tr>
						<td valign="top">

						<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
							<tr class="dataheader">
								<td width="15%"> Code</td>
								<td width="45%"><b>CBS
								Parameter</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>

						<td valign="top" align="center">
						<DIV class="cellcontainer">

						<table width="100%" border="0" cellspacing="1" cellpadding="2" class="outertable">
							<%if (arrValues != null) {
				int arrSize = arrValues.size();
				ArrayList arrCol = null;
				for (int i = 0; i < arrSize; i++) {
					arrCol = new ArrayList();
					arrCol = (ArrayList) arrValues.get(i);

					%>
							<tr class="datagrid">
								<td width="15%"><a
									href="javascript:setValues('<%= Helper.correctNull((String)arrCol.get(0))%>',
                          												'<%= Helper.correctNull((String)arrCol.get(1))%>',
                          												'<%= Helper.correctNull((String)arrCol.get(2))%>')"><%=Helper.correctNull((String) arrCol.get(1))%></a></td>

								<td width="45%"><a
									href="javascript:setValues('<%= Helper.correctNull((String)arrCol.get(0))%>',
                          												'<%= Helper.correctNull((String)arrCol.get(1))%>',
                          												'<%= Helper.correctNull((String)arrCol.get(2))%>')"><%=Helper.correctNull((String) arrCol.get(2))%></a></td>

							</tr>
							<%}

			}

			%>
							<tr class="datagrid">
								<td width="15%">&nbsp;</td>
								<td width="45%">&nbsp;</td>
							</tr>
							<tr class="datagrid">
								<td width="15%">&nbsp;</td>
								<td width="45%">&nbsp;</td>
							</tr>
							<tr class="datagrid">
								<td width="15%">&nbsp;</td>
								<td width="45%">&nbsp;</td>
							</tr>
							<tr class="datagrid">
								<td width="15%">&nbsp;</td>
								<td width="45%">&nbsp;</td>
							</tr>
							<tr class="datagrid">
								<td width="15%">&nbsp;</td>
								<td width="45%">&nbsp;</td>
							</tr>
							<tr class="datagrid">
								<td width="15%">&nbsp;</td>
								<td width="45%">&nbsp;</td>
							</tr>

						</table>
						</div>
					<lapschoice:combuttonnew 
							btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>

 <lapschoice:hiddentag pageid='<%=PageId%>'/> 
<input type=hidden name="pagename" value="<%=pagename%>">
<input type=hidden name="Position" value="<%=Position%>">
<input type=hidden name="id" value="<%=strID%>"> 
</form>
</body>
</html>
