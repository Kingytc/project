<%@include file="../share/directives.jsp"%>
<%
ArrayList arrRow	= new ArrayList();
ArrayList arrCol	= new ArrayList();
if(hshValues!=null)
{
	arrRow	= (ArrayList)hshValues.get("arrRow");
}
int intSize=0;
if(arrRow!=null&&arrRow.size()>0)
{ intSize	= arrRow.size();}
String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
%>
<html>
<head>
<title>Proposal</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
var currdate = "<%=Helper.getCurrentDateTime()%>";
var appstatus="<%=Helper.correctNull((String) request.getParameter("appstatus"))%>";
var intSize	= '<%=intSize%>';
var strappno = "<%=Helper.correctNull((String) request.getParameter("appno"))%>"

function enableButtons(bool1,bool2,bool3,bool4,bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmddelete.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;	
}

function doCancel()
{
	if (ConfirmMsg(102))
	{
	document.forms[0].hidBeanGetMethod.value="getBankingDetails";
	document.forms[0].hidBeanId.value="comproposal";
	document.forms[0].action=appURL+"action/com_operdet.jsp";
	document.forms[0].submit();
	}
}

function callclose()
{
	var cattype=document.forms[0].cattype.value;
 	if((cattype=="ASSI")||(cattype=="ASBI"))
    {
    	if(ConfirmMsg(100))
	 	{
			document.forms[0].action=appURL+"action/agrborrowersearch.jsp";
		 	document.forms[0].submit();
	 	}
	}
	else
	{
    	if(ConfirmMsg(100))
	 	{
			document.forms[0].action=appURL+"action/corppge.jsp";
		 	document.forms[0].submit();
	 	}
	}
}

function doEdit()
{	
	enableButtons(true,false,false,false);
	disableFields(false);
	if(intSize=="1")
	{
		document.forms[0].txt_LeadBankName.readOnly="readonly";
	}
	else
	{
		for(var i=0;i<intSize;i++)
		{
			document.forms[0].txt_LeadBankName[i].readOnly="readonly";
		}
	}
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].hidBeanId.value="comproposal";
		document.forms[0].hidBeanMethod.value="updateBankingDetails";					
		document.forms[0].hidBeanGetMethod.value="getBankingDetails";
		document.forms[0].hidSourceUrl.value="action/com_operdet.jsp";
	    document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].method="post";	
		document.forms[0].submit();
	}
}

function doSave()
{
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidAction.value="insert";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidBeanId.value="comproposal";
	document.forms[0].hidBeanMethod.value="updateBankingDetails";
	document.forms[0].hidBeanGetMethod.value="getBankingDetails";
	document.forms[0].hidSourceUrl.value="/action/com_operdet.jsp";
	document.forms[0].submit();
}

function callLink(page,bean,method)
{
	if (document.forms[0].cmdsave.disabled)
	{
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

function dohlp()     
{
  var hlpvar = appURL+"phlp/corp_propooperdet.htm";
  var title = "BankingDetails";
  var prop = "scrollbars=yes,width=600,height=450";	
  prop = prop + ",left=50,top=150";
  window.open(hlpvar,title,prop);
}

function fnOnload()
{
	if(appstatus=="Open/Pending")
	{
		if(document.forms[0].hidNonPoolFlag.value=="Y")
		{
			enableButtons(true,true,true,true,false);
		}
		else
		{
			enableButtons(false,true,true,true,false);
		}
	}
	else
	{
		enableButtons(true,true,true,true,false);
	}
	disableFields(true);
}

function callourcredit()
{
	var varQryString = appURL+"action/com_ourbankcredit.jsp?hidBeanGetMethod=getourBankcreditDetails&hidBeanId=comproposal&appstatus="+appstatus+"&strAppno="+strappno+"&bank=our";
	var title = "Credit_Facilities";
	var prop = "scrollbars=yes,width=850,height=600";
	var xpos = "50";
	var ypos = "50";
	prop = prop+","+xpos+","+ypos+",left=50,top=50";
	window.open(varQryString,title,prop);
}

function callotherscredit()
{
	var varQryString = appURL+"action/com_otherbankcredit.jsp?hidBeanGetMethod=getourBankcreditDetails&hidBeanId=comproposal&appstatus="+appstatus+"&strAppno="+strappno+"&bank=other";
	var title = "Credit_Facilities";
	var prop = "scrollbars=yes,width=850,height=600";
	var xpos = "50";
	var ypos = "50";
	prop = prop+","+xpos+","+ypos+",left=50,top=50";
	window.open(varQryString,title,prop);
}



function callcomments1()
{

var appno="<%=(String)request.getParameter("appno")%>";
var pagetype = "BDCOM1";
var purl ="<%=ApplicationParams.getAppUrl()%>action/com_Bankingdetacomment1.jsp?hidBeanGetMethod=getcom_Bankingdetacommentdata&hidBeanId=compro&hidpagetype="+pagetype+"&appno="+appno+"&appstatus="+appstatus;		
var prop = 'scrollbars=yes,menubar=no,width=700,height=445';	
var xpos = (screen.width - 600) / 2;
var ypos = (screen.height - 600) / 2;
prop = prop + ",left="+xpos+",top="+ypos;
window.open(purl,'title',prop);	
}

function callcomments2()
{

var appno="<%=(String)request.getParameter("appno")%>";
var pagetype = "BDCOM2";
var purl ="<%=ApplicationParams.getAppUrl()%>action/com_Bankingdetacomment1.jsp?hidBeanGetMethod=getcom_Bankingdetacommentdata&hidBeanId=compro&hidpagetype="+pagetype+"&appno="+appno+"&appstatus="+appstatus;		
var prop = 'scrollbars=yes,menubar=no,width=700,height=445';	
var xpos = (screen.width - 600) / 2;
var ypos = (screen.height - 650) / 2;
prop = prop + ",left="+xpos+",top="+ypos;
window.open(purl,'title',prop);	
}

function funfactype()
{
	var varcom_Exiconsortiummul="<%=Helper.correctNull((String)hshValues.get("com_Exiconsortiummul"))%>"
	var varcom_com_proconsortiummul="<%=Helper.correctNull((String)hshValues.get("com_proconsortiummul"))%>"
	
	if(varcom_Exiconsortiummul!="")
	{
		document.forms[0].sel_Exewhetherconmul.value=varcom_Exiconsortiummul;
	}
	else
	{
		document.forms[0].sel_Exewhetherconmul.value="";
	}
	
	if(varcom_com_proconsortiummul!="")
	{
		document.forms[0].sel_Prowhetherconmul.value=varcom_com_proconsortiummul;
	}
	else
	{
		document.forms[0].sel_Prowhetherconmul.value="";
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
	}
	
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
function setBankmaster(v1,v2,v3)
{
	if(intSize=="1")
	{
		document.forms[0].hid_LeadBankcode.value=v1;
		document.forms[0].txt_LeadBankName.value=v2;
	}
	else
	{
		document.forms[0].hid_LeadBankcode[v3].value=v1;
		document.forms[0].txt_LeadBankName[v3].value=v2;
	}
}
</script>
</head>
<body onload="fnOnload();funfactype()">
<form name="frmpri" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top"><jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="3"/>
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<%
	if (strSessionModuleType.equalsIgnoreCase("AGR")){%>
	<tr>
		<td class="page_flow">Home -&gt; Agriculture -&gt;Application -&gt;Banking Arrangement -&gt; Banking Details</td>
	</tr>
<%}else if (strCategoryType.equalsIgnoreCase("CORP")) {
	%>
	<tr>
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt;
		Application -&gt; Banking Arrangement -&gt; Banking Details</td>
	</tr>
	<%
		} else if (strCategoryType.equalsIgnoreCase("SRE")) {
	%>
	<tr>
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Short
		Review/Extension -&gt; Banking Arrangement -&gt; Banking Details</td>
	</tr>
	<%
		} else if (strCategoryType.equalsIgnoreCase("STL")) {
	%>
	<tr>
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Short
		Term Loan -&gt; Banking Arrangement -&gt; Banking Details</td>
	</tr>
	<%
	}%>
</table>
<%
	//}
%> <span style="display: none;"><lapschoice:borrowertype /></span>
<lapschoice:application /> <%
 	if (!strCategoryType.equalsIgnoreCase("STL")) {
 %>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	align="center" class="outertable">
	<tr>
		<td valign="bottom">
		<table border="0" cellspacing="2" cellpadding="3" class="outertable" width="60%">
			<tr align="center">
				
				<%
					if (!strCategoryType.equalsIgnoreCase("STL")) {
				%>
				<!--<td  width="15%" nowrap="nowrap" align="center" class="sub_tab_inactive"><b><a
					href="#" onclick="javascript:callLink('combanking.jsp','bankapp','getData')">Working Capital</a></b></td>
				--> <td  width="15%" nowrap="nowrap" align="center" class="sub_tab_inactive"><b><a
					href="#" onclick="javascript:gotoTab(appURL,'bankappfi','getData','combankingfi.jsp')">Existing Facilities</a></b></td>
						
				
					<td width="15%" nowrap align="center"   class="sub_tab_active"> <b> Banking Arrangement </b> </td>
					
					<td  width="15%" nowrap="nowrap" align="center" class="sub_tab_inactive"><b><a
					href="#" onclick="javascript:gotoTab(appURL,'bankapp','getBankingdetailsData','com_bankingdetails.jsp')">Banking Details </a></b></td>
				<%
					}
				%><!--
				<%if (strCategoryType.equals("CORP") || strCategoryType.equals("SME")) {
			%>
				<td  width="15%" nowrap="nowrap" align="center" class="sub_tab_inactive" nowrap="nowrap"><b><a
					href="#" onclick="javascript:gotoTab(appURL,'combanking','getRepayData','comrepayment.jsp')">
				Repayment of Existing loans</a></b></td>
			<%}%>
			--></tr>
		</table>
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
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
							<tr>
								<td>
								
							<table width="98%" border="0" cellspacing="1" cellpadding="3" class="outertable">
							  <tr class="dataheader" align="center">
							   <td  >&nbsp;</td>
							   <td>Existing Facilities</td>
							   <td>Proposed Facilities</td>
							 	</tr>
								<tr align="center">
								<td >Whether Single Consortium or Multiple</td>
								<td><select name="sel_Exewhetherconmul">
								<option value="">---Select---</option>
								<option value="1">Single </option>
								<option value="2">Multiple</option>
								</select>
								</td>
								
								<td><select name="sel_Prowhetherconmul">
								<option value="">---Select---</option>
								<option value="1">Single </option>
								<option value="2">Multiple</option>
								</select>
								</td>
								</tr>
								</table>
								<br>
								<tr>
								<td>
								<table width="100%" border="0" cellspacing="1" cellpadding="5" class="outertable">
									<tr align="center" class="dataheader">
										<td align="center" width="15%">Facility Type</td>
										<td align="center" width="18%">Facility Name</td>
										<td align="center" width="10%">Type of Credit</td>
										<td align="center" width="18%">Bank</td>
										<td align="center" width="15%">Banking Arrangement</td>
										<td align="center" width="19%">Lead Bank</td>
									</tr>
									<%if(arrRow!=null && arrRow.size()>0) {
										for(int i=0;i<arrRow.size();i++){
											arrCol	= (ArrayList)arrRow.get(i);
									%>
									<tr class="datagrid">
									<td align="left" width="15%">
									<input type="hidden" name="hid_FacilityType" value="<%=Helper.correctNull((String)arrCol.get(0))%>">
									<input type="text" name="txt_FacilityType" value="<%=Helper.correctNull((String)arrCol.get(1))%>" readonly="readonly" size="30">
									</td>
									<td align="left" width="18%">
									<input type="text" name="txt_Facilitydesc" value="<%=Helper.correctNull((String)arrCol.get(4))%>" readonly="readonly" size="30">
									<input type="hidden" name="hid_FacilityId" value="<%=Helper.correctNull((String)arrCol.get(2))%>">
									<input type="hidden" name="hid_FacilitySno" value="<%=Helper.correctNull((String)arrCol.get(3))%>">
									</td>
									<td align="left" width="10%">
									<input type="hidden" name="hid_FacilityCreditType" value="<%=Helper.correctNull((String)arrCol.get(5))%>">
									<input type="text" name="txt_FacilityCreditType" value="<%=Helper.correctNull((String)arrCol.get(6))%>" readonly="readonly" size="15">
									</td>
									<td align="left" width="18%">
									<input type="text" name="txt_BankName" tabindex="2" value="<%=Helper.correctNull((String)arrCol.get(7))%>" readonly="readonly" size="30">
									</td>
									<td align="left" width="15%">
									<input type="hidden" name="hid_BankingArrangement" value="<%=Helper.correctNull((String)arrCol.get(8))%>">
									<input type="text" name="txt_BankingArrangement" value="<%=Helper.correctNull((String)arrCol.get(9))%>"  readonly="readonly" size="20">
									</td>
									<td align="left" width="25%">
									<input type="text" name="txt_LeadBankName" onKeyPress="" maxlength="40" size="30" tabindex="1" readonly="readonly" value="<%=Helper.correctNull((String)arrCol.get(10))%>">
									<input type="hidden" name="hid_LeadBankcode" value="<%=Helper.correctNull((String)arrCol.get(11))%>">
									<span onClick="callBankmaster('147','<%=i%>')" style="cursor: hand">
									<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0" tabindex="2"></span>
									</td>
									</tr>
									<%}} %>
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
<table width="50%" align="center" >
							
	<tr><td width="40%" >
	
<lapschoice:combuttonnew btnnames="Edit_Save_Delete_Cancel_Audit Trail"
	btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />
</td>		<td>						
	<table border="1" width="10%">
	<tr>
	<td width="5%"><input align="middle" type="button" name="cmdcomment" value="BDWCC" onClick="callcomments1()" class="buttonStyle"></td>
	<td width="5%"><input align="middle" type="button" name="cmdcomment" value="BDTLC" onClick="callcomments2()" class="buttonStyle"></td>
	</tr></table></td>
	</tr>
					
					</table>
				         
							<br>
							<table width="50%" align="center" border="0" cellpadding="2" cellspacing="0">
							
							<tr>
							<td align="center"><input type="button" name="our_bank" class="buttonstyle" 
							value="Details of Credit Facilities from Our bank" onClick="callourcredit()"></td>
							<!--  <td><input type="button" name="other_bank" class="buttonstyle" 
							value="Details of Credit Facilities from Other bank" onClick="callotherscredit()"></td>-->
							</tr>
							</table>
<lapschoice:hiddentag pageid='<%=PageId%>' />
<input type="hidden" name="hid_RowSize" value="<%=intSize%>">
</form>
</body>
</html>
