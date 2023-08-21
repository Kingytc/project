<%@include file="../share/directives.jsp"%>
<%ArrayList arryRow = (ArrayList) hshValues.get("arrRow");
ArrayList arryCol = new ArrayList();

	String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
	String strMCLRFlag=Helper.correctNull((String)hshValues.get("strMCLRFlag"));
	%>
<html>
<head>
<title>Proposalflow</title>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
function callSearch()
{
	if(document.forms[0].cmdsave.disabled == false){
	var varQryString = appURL+"action/com_delegationusersearch.jsp";
	var title = "Users";
	var prop = "scrollbars=yes,width=650,height=400,menubar=no";	
	var xpos = (screen.width - 350) / 2;
	var ypos = (screen.height - 120) / 2;
	prop = prop + ",left=50,top=50";
	window.open(varQryString,title,prop);
	}
}
function placeValues()
{
	disableFields(true);
}
function disableFields(val)
	{
		for(var i=0;i<document.forms[0].elements.length;i++)
		{
			if(document.forms[0].elements[i].type=="text")
			{
			  document.forms[0].elements[i].readOnly=val;		  
			}
		}
	}
function doCancel()
{
	if(ConfirmMsg(102))
	 {
		document.forms[0].hidBeanId.value="perDeviation";
		document.forms[0].hidBeanGetMethod.value="getProposalflow";
		document.forms[0].action=appURL+"action/perm_proposalflow.jsp";
		document.forms[0].submit();
	 }
}
function doDelete()
{
	var varconfirm=ConfirmMsg('101');
	if(varconfirm)
	{
		document.forms[0].hidAction.value="delete";
	 	document.forms[0].hidBeanId.value="perDeviation";
		document.forms[0].hidBeanMethod.value="updateProposalflow";
		document.forms[0].hidBeanGetMethod.value="getProposalflow";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/perm_proposalflow.jsp";
 		document.forms[0].submit();
	}
}
function enableButtons(bool1,bool2,bool3,bool4,bool5,bool6)
{
	document.forms[0].cmdnew.disabled=bool1;
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool5;
	document.forms[0].cmdclose.disabled=bool6;

}
function doEdit()
{
	enableButtons(true,true,false,false,true,false);
	document.forms[0].hidAction.value ="update";
}
function doSave()
{
	if(document.forms[0].txt_name.value=="")
	{
		alert("Select Name");
		return;
	}
	<%if(arryRow!=null && arryRow.size()>0){
		if(arryRow.size()==1){%>

		if(document.forms[0].hiduserID.value==document.forms[0].txtuserID.value){
			alert("User Already Exists");
			return;
		}
		
		<%}else{%>

		for(var i=0;i<document.forms[0].hiduserID.length;i++)
		{
			if(document.forms[0].hiduserID[i].value==document.forms[0].txtuserID.value){
				alert("User Already Exists");
				return;
			}
		}
		
		<%}
		}%>
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].hidBeanId.value="perDeviation"
		document.forms[0].hidBeanMethod.value="updateProposalflow";
		document.forms[0].hidBeanGetMethod.value="getProposalflow";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/perm_proposalflow.jsp";
		document.forms[0].submit();
       

}
function doClose()
{
	if( ConfirmMsg(100) )
	{
		document.forms[0].action=appURL+"action/"+"mainnav.jsp";
		document.forms[0].submit();
	}
	
}
function doNew()
{
	enableButtons(true,true,false,false,true,false)
	
	document.forms[0].txt_name.value="";
	document.forms[0].txt_desig.value="";
	document.forms[0].hidAction.value ="insert";

}
function selectValues(val1, val2,val3,val4,val5,val6)
{
	
	document.forms[0].txt_name.value=val1;
	
	document.forms[0].txt_desig.value=val2;
	document.forms[0].txtuserID.value=val3;
	document.forms[0].hidsno.value=val5;
	document.forms[0].txt_desig1.value=val6;
	if(document.forms[0].btnenable.value=="Y")
	{
		enableButtons(true,false,true,true,false,false);
	}
}
function callLink(url,bean,method)
{
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].hidBeanId.value=bean;
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+url;
	document.forms[0].submit();
}
</script>
<STYLE>
DIV.cellContainer {
	width: 100%;
	height: 150;
	overflow: auto;
}
</STYLE>
</head>

<body onload="placeValues()">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems" url=""><script language="JavaScript">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script></div>
</div>
<form name="frmpri" method="post" class="normal">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
	<tr>
		<td><jsp:include page="../share/devurllinker.jsp" flush="true">
			<jsp:param name="pageid" value="5" />
		</jsp:include></td>
	</tr>
</table>
<table>
   
     <tr>
		<td class="page_flow">Home -&gt; Permission -&gt;  Proposal -&gt; Proposal Flow </td>
	</tr>
  
  </table>
  <lapschoice:ApplDevHeaderTag />
 <table width="60%" border="0" cellspacing="1" cellpadding="3"
	class="outertable">
	<tr>
		<td class="sub_tab_active" align="center">Proposal Flow</td>
		<td class="sub_tab_inactive" align="center"><a
			href="JavaScript:callLink('perm_execpage.jsp','perDeviation','getExecutive')"
			onMouseOut="window.status='';return true;"
			onMouseOver="window.status='Cash Flow';return true;"><b>Executive
		Summary</b></a></td>
	</tr>
</table>
<table width="98%" border="0" cellspacing="0" cellpadding="5"
	class="shadow" align="center" bordercolordark="#B6C1D2"
	bordercolorlight="#FFFFFF">
	<tr>
		<td valign="top">
		<table width="75%" border="0" align="center" cellspacing="0"
			cellpadding="5">
			<tr>
				<td valign="top" colspan="3">

				<table width="75%" border="0" class="outertable border1" align="center" cellspacing="0"
					cellpadding="4">
					<tr>
						<td>
						<table width="100%" border="0" align="center" cellspacing="3"
							cellpadding="3">
							<tr align="center">
								<td width="35%" class="dataheader"><b>Name</b></td>
								<td width="35%" class="dataheader"><b>Designation</b></td>
							</tr>
							<tr>

								<td width="35%" align="center"><input type="text"
									name="txt_name" size="35" maxlength="15" readonly> <span
									onClick="callSearch()" style="cursor: hand"><img
									src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
									border="0"></span></td>
								<td width="35%" align="center"><input type="hidden"
									name="txt_desig" maxlength="40" size="40" readOnly> <input
									type="text" name="txt_desig1" maxlength="40" size="40" readOnly>
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


<lapschoice:combuttonnew
	btnnames="New_Edit_Save_Delete_Cancel_Audit Trail"
	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<DIV class="cellContainer">
<table width="58%" border="0" cellspacing="0" cellpadding="3"
	class="outertable linebor" align="center">
	<tr class="dataheader">
		<td>&nbsp;</td>

		<td align="center" style="width: 30%;"><b>Name</b></td>
		<td align="center" style="width: 16%;"><b>Designation</b></td>

	</tr>
	<%
						String strSno = "";
			if(arryRow!=null && arryRow.size()>0)
					{
							for(int i=0;i<arryRow.size();i++)
							{
								arryCol=(ArrayList)arryRow.get(i); 
%>

	<tr valign="top" class="datagrid">
		<td width="3%"><input type="radio" name="radio_impln"
			onclick="selectValues('<%=Helper.correctNull((String)arryCol.get(0))%>',
					'<%=Helper.correctNull((String)arryCol.get(1))%>','<%=Helper.correctNull((String)arryCol.get(2))%>','<%=Helper.correctNull((String)arryCol.get(3))%>'
					,'<%=Helper.correctNull((String)arryCol.get(4))%>','<%=Helper.correctNull((String)arryCol.get(5))%>')"
			style="border: none"> <input type="hidden" name="hiduserID"
			value="<%=Helper.correctNull((String)arryCol.get(2))%>">
		<td style="width: 16%;"><%=Helper.correctNull((String)arryCol.get(0))%></td>
		<td style="width: 16%;"><%=Helper.correctNull((String)arryCol.get(5))%></td>



	</tr>
	<%}}%>
	<tr class="datagrid">

		<td style="width: 3%;">&nbsp;</td>
		<td style="width: 30%;">&nbsp;</td>
		<td style="width: 16%;">&nbsp;</td>

	</tr>
</table>
</DIV>
<input type="hidden" name="hidsno" value=""> <input
	type="hidden" name="txtuserID" value=""> <lapschoice:hiddentag
	pageid='<%=PageId%>' /></form>
</body>
</html>
