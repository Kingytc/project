<%@include file="../share/directives.jsp"%>
<%ArrayList arryRow = (ArrayList) hshValues.get("arrRow");
			ArrayList arryCol = new ArrayList();
	String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
	String strMCLRFlag=Helper.correctNull((String)hshValues.get("strMCLRFlag"));
   String	strdate=Helper.correctNull((String)hshValues.get("strdate"));
   String	strsancdate=Helper.correctNull((String)hshValues.get("app_processdate"));
   String	strflagcheck=Helper.correctNull((String)hshValues.get("strflagcheck"));

   String	strsanccheck=Helper.correctNull((String)hshValues.get("strsanccheck"));

	%>
<html>
<head>
<title>Proposal</title>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js">
</script>
<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script>
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var appstatus="<%=Helper.correctNull((String) request.getParameter("appstatus"))%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var strdate="<%=strdate%>";
var strsancdate="<%=strsancdate%>";
var strflagcheck="<%=strflagcheck%>";
var strsanccheck="<%=strsanccheck%>";
var varECSancDate="<%=Helper.correctNull((String)hshValues.get("strSancdate"))%>";
var varSancAuth="<%=Helper.correctNull((String)hshValues.get("strSancAuth"))%>";

function callSearch()
{
	if(document.forms[0].cmdsave.disabled == false)
	{
		if(document.forms[0].sel_details.value=="")
		{
			alert("Select User Details");
			document.forms[0].sel_details.focus();
			return;
		}
		if(document.forms[0].sel_details.value=="A")
			var varQryString = appURL+"action/com_delegationusersearch.jsp?pagefrom=propflow&hidBeanId=setusers&hidBeanGetMethod=getUserSearchData&appno="+document.forms[0].appno.value+"&hidDetails="+document.forms[0].sel_details.value;
		else
			var varQryString = appURL+"action/com_delegationusersearch.jsp?appno="+document.forms[0].appno.value+"&hidDetails="+document.forms[0].sel_details.value;
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

	if(document.forms[0].hidapplicationType.value == "Restructure")
	{
		document.all.FVCtab.style.display="table-cell";
	}
	else
	{
		document.all.FVCtab.style.display="none";
	}

	<%
	
	if(arryRow!=null && arryRow.size()>0)
	{

	
	
		for(int i=0;i<arryRow.size();i++)
		{
				arryCol=(ArrayList)arryRow.get(i);
				if(Helper.correctNull((String)arryCol.get(7)).equalsIgnoreCase("A")){%>
					document.forms[0].hidappraiseddate.value="<%=Helper.correctNull((String)arryCol.get(8))%>";
				<%}
		}
	}
	%>
	
}

function disableFields(val)
	{
		for(var i=0;i<document.forms[0].elements.length;i++)
		{
			if(document.forms[0].elements[i].type=="text")
			{
			  document.forms[0].elements[i].readOnly=val;		  
			}
			if(document.forms[0].elements[i].type=="select-one")
			{
			  document.forms[0].elements[i].disabled=val;		  
			}
		}
	}
function doCancel()
{
	if(ConfirmMsg(102))
	 {
		document.forms[0].hidBeanId.value="executive"
		document.forms[0].hidBeanGetMethod.value="getDelegationData";
		document.forms[0].action=appURL+"action/com_delegation.jsp";
		document.forms[0].submit();
	 }
	
}
function doDelete()
{
	
	if(ConfirmMsg(101))
	 {
		document.forms[0].hidAction.value="delete"
	 	document.forms[0].hidBeanId.value="executive"
		document.forms[0].hidBeanMethod.value="updateDelegationData";
		document.forms[0].hidBeanGetMethod.value="getDelegationData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/com_delegation.jsp";
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
	enableButtons(true,true,false,false,true);
	
		document.forms[0].hidAction.value ="update";
		document.forms[0].sel_details.disabled=false;
		document.forms[0].txt_date.readOnly=true;
		document.all.idtxt_date.style.display="none";
	
}
function doSave()
{
	if(document.forms[0].txt_name.value=="")
	{
		alert("Select Name");
		return;
	}
	if(document.forms[0].sel_details.value==""){
		alert(" select User type");
		return;
	}
	var strflagcheck="N";
	var strsanccheck="N";
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
		else
		{
			if(document.forms[0].hidAction.value=="insert")
			{
				if(document.forms[0].hidDetails[i].value=="A" && document.forms[0].sel_details.value=="A"){
					strflagcheck="Y";
				}
				if(document.forms[0].hidDetails[i].value=="S" && document.forms[0].sel_details.value=="S"){
					strsanccheck="Y";
				}
			}
		}
	}
	
	<%}
	}%>

	if(strflagcheck=="Y"){
		alert(" Multiple Appraised by User cannot be entered in single proposal");
		return;
	}
	if(strsanccheck=="Y"){
		alert("Multiple Sanctioned by User cannot be entered in single proposal");
		return;
	}

	if(document.forms[0].txt_date.value=="" && document.forms[0].sel_details.value=="V")
	{
		alert("Select Date");
		return;
	}
	else if(document.forms[0].txt_date.value=="" && document.forms[0].sel_details.value=="S" && (varSancAuth=="14" || varSancAuth=="15" ||varSancAuth=="16"))
	{
		<%if(!strSessionModuleType.equals("RET") && !strSessionModuleType.equals("LAD")){%>
			alert("Select Sanction Date in Basic Information Tab");
		<%}else{%>
			alert("Select Sanction Date in Appraisal -> Loan Details Tab");
		<%}%>
		return;
	}
	
	
		//document.forms[0].hidAction.value="update"
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].hidBeanId.value="executive"
		document.forms[0].hidBeanMethod.value="updateDelegationData";
		document.forms[0].hidBeanGetMethod.value="getDelegationData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/com_delegation.jsp";
		document.forms[0].submit();


}
function doClose()
{
	if( ConfirmMsg(100) )
	{
		document.forms[0].action=appURL+"action/"+"retailpge.jsp";
		document.forms[0].submit();
	}
	
}

var strvalue="corp_otherinf.htm";
function doHelp()     
{
  var hlpvar = appURL+"phlp/corp_otherinf.htm";
  var title = "OtherInformation";
  var prop = "scrollbars=yes,width=600,height=450";	
  prop = prop + ",left=50,top=150";
  window.open(hlpvar,title,prop);
}

function callProposalShort()
{
	var com_appno = document.forms[0].appno.value;
	var com_appid = document.forms[0].hidapplicantid.value;
	var pgType = "Shortnte";
	var purl 	= "<%=ApplicationParams.getAppUrl()%>action/com_postsanc_shortnote.jsp?hidBeanGetMethod=getPostSancShortnote&hidBeanId=lapsReport&appno="+com_appno+"&appid="+com_appid+"&pgType="+pgType+"&pageVal=PROPOSALLC";
	var title 	= "ProposalShort";
	var prop 	= "scrollbars=yes,width=1200,height=550,menubar=yes";
	var xpos 	= 5;
	var ypos 	= 5;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,title,prop);
}

function doNew()
{
	enableButtons(true,true,false,false,true,false)
	
	document.forms[0].txt_name.value="";
	document.forms[0].txt_desig.value="";
	document.forms[0].hidAction.value ="insert";
	document.forms[0].sel_details.disabled=false;
	document.forms[0].sel_details.value="";
	document.forms[0].txt_date.readOnly=true;

}
function selectValues(val1, val2, val3,val4,val5,val6,val7)
{
	document.forms[0].hidsno.value=val1;
	document.forms[0].txt_name.value=val2;
	document.forms[0].txt_desig.value=val3;
	document.forms[0].txt_desig1.value=val4;
	document.forms[0].txtuserID.value=val5;
	document.forms[0].sel_details.value=val6;
	document.forms[0].txt_date.value=val7;
	if(document.forms[0].btnenable.value=="Y")
	enableButtons(true,true,true,false,false,false);
}
function showpage1(url,method)
{
	//if(url=="exec_page1.jsp")
	//{
		document.forms[0].hidBeanId.value="executive" ;
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+url;
		document.forms[0].submit();
	//}
}
function showKFS(url,method)
{
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+url;
	document.forms[0].submit();
}
function callAnnexureMCLR()
{
	purl	= "<%=ApplicationParams.getAppUrl()%>action/com_MCLRAnnexure.jsp?pagefrom=annx&hidBeanGetMethod=getMCLRAnnexure&hidBeanId=commdocument&appno="+document.forms[0].appno.value+"&appid="+document.forms[0].hidapplicantid.value;
	title	= "MCLRAnnexure";
	var prop 	= "scrollbars=yes,width=1200,height=550,menubar=yes";
	var xpos 	= 5;
	var ypos 	= 5;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,title,prop);
}

function callAnnexure()
{
	purl	= "<%=ApplicationParams.getAppUrl()%>action/com_AnnexureIV.jsp?hidBeanGetMethod=getAnnexureIV&hidBeanId=commdocument&appno="+document.forms[0].appno.value+"&pagefrom=strDelegation";
	title	= "AnnexureIV";
	var prop 	= "scrollbars=yes,width=1200,height=550,menubar=yes";
	var xpos 	= 5;
	var ypos 	= 5;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,title,prop);
}
function callAnnexure2()
{
	purl	= "<%=ApplicationParams.getAppUrl()%>action/com_Corp_Annexure.jsp?hidBeanGetMethod=get_Corp_Annexure&hidBeanId=commdocument&appno="+document.forms[0].appno.value+"&pagefrom=strDelegation";
	title	= "AnnexureIV";
	var prop 	= "scrollbars=yes,width=1200,height=550,menubar=yes";
	var xpos 	= 5;
	var ypos 	= 5;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,title,prop);
}

function checkval(){
	var varappraisedby=document.forms[0].sel_details.value;
	if(varappraisedby=="S"){
		
		document.forms[0].txt_date.value=varECSancDate;
		document.forms[0].txt_date.readonly=true;
		comparedate(document.forms[0].hidappraiseddate.value,document.forms[0].txt_date.value);
	}
	else
	{
		document.forms[0].txt_date.value="";
		document.forms[0].txt_name.value="";

		document.forms[0].txt_desig.value="";
		document.forms[0].txt_desig1.value="";
		document.forms[0].txtuserID.value="";
	}
	
	
}
function callCalender(fname)
{
	if(document.forms[0].cmdedit.disabled==true)
	{
		showCal(appURL,fname);
	}
}

function comparedate(date1,date2)
{	
	var pgdt=changeDateformat(date1);
	var maxdt=changeDateformat(date2);
	if(pgdt.value!="")
	{
		{
		
			if(Date.parse(pgdt) > Date.parse(maxdt))
			{
				alert("date should not be lesser than appraised  date.");
				document.forms[0].txt_date.value="";
				document.forms[0].txt_date.focus();								
			}	
		}
				
	}
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
	<STYLE>
	
	DIV.cellContainer {	

  width: 100%; height: 150;
  overflow: auto;
}
</STYLE>
</head>

<body onload="placeValues()">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
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
<%if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){
	if(!strSessionModuleType.equals("RET")){%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../com/postsanctionlinks.jsp" flush="true">
			<jsp:param name="pageid" value="10" />
			<jsp:param name="subpageid" value="112" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		<input type="hidden" id="FVCtab">
		</td>
	</tr>
</table>
<%}else{ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../set/postsanctionlinksper.jsp" flush="true">
			<jsp:param name="pageid" value="7" />
			<jsp:param name="subpageid" value="115" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<jsp:include page="../share/postsanctionapprlinktab.jsp" flush="true">
			<jsp:param name="tabid" value="101" />
		</jsp:include>
		<input type="hidden" id="FVCtab">
<%}}else{ %>
<%if(strSessionModuleType.equals("CORP") || strSessionModuleType.equals("AGR")){%>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top" colSpan=5><jsp:include
			page="../com/proposallinks.jsp" flush="true">
			<jsp:param name="pageid" value="10" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />

		</jsp:include></td>
	</tr>
	<tr>
	    <%if(strSessionModuleType.equals("AGR")){%>
		<td class="page_flow">Home&nbsp;-&gt;&nbsp;Agriculture -&gt;&nbsp;Proposal&nbsp;-&gt;&nbsp;Proposal Flow</td>
	<%}else{%>
		<td class="page_flow">Home&nbsp;-&gt;&nbsp;Corporate&nbsp; &amp; SME -&gt;&nbsp;Proposal&nbsp;-&gt;&nbsp;Proposal Flow</td> 
		<%} %>
		
	</tr>
</table>
<%}else if(strSessionModuleType.equalsIgnoreCase("DIGI")){ %>
<jsp:include page="../share/applurllinkerdigi.jsp" flush="true">
<jsp:param name="pageid" value="10" /></jsp:include>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Digi Retail -&gt; Appraisal -&gt;Proposal Flow</td>
	</tr>
</table>
<%} else {%>
<jsp:include page="../share/Applurllinkper.jsp" flush="true">
<jsp:param name="pageid" value="10" /></jsp:include>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Retail(including schematic) -&gt; Appraisal -&gt;Proposal Flow</td>
	</tr>
</table>
<%} %>
<span style="display:none"><lapschoice:borrowertype /></span><lapschoice:application />
<%if(strSessionModuleType.equals("CORP")|| strSessionModuleType.equals("AGR")){%>
<table width="60%" border="0" cellspacing="1" cellpadding="3"
	class="outertable">
	<tr>
		<td class="sub_tab_active" align="center">Proposal Flow</td>
		<td class="sub_tab_inactive" align="center"><a
			href="JavaScript:showpage1('com_mdsanctiontoec.jsp','getMDSanctiontoEC')"
			onMouseOut="window.status='';return true;"
			onMouseOver="window.status='MD Sanction to EC';return true;"><b>MD
		Sanction to EC</b></a></td>
		<td class="sub_tab_inactive" align="center"><a
			href="JavaScript:showpage1('exec_page1.jsp','getData')"
			onMouseOut="window.status='';return true;"
			onMouseOver="window.status='Cash Flow';return true;"><b>Executive
		Summary</b></a></td>
		
		<%if(Helper.correctNull((String) request.getParameter("appstatus")).equalsIgnoreCase("Processed/Approved")){ %>
		<td class="sub_tab_inactive" align="center"><a
			href="JavaScript:showKFS('com_keyfactstatement.jsp','getKeyFactStatementData')"
			onMouseOut="window.status='Key Fact Statement';return true;"
			onMouseOver="window.status='Key Fact Statement';return true;"><b>Key
		Fact Statement</b></a></td>
		<%} %>
		
		<td id="FVCtab" class="sub_tab_inactive" align="center">
		<a href="JavaScript:showpage1('com_fairvalue_proposal.jsp','')"
			onMouseOut="window.status='';return true;"
			onMouseOver="window.status='FVC';return true;"><b>Fair value Calculation</b></a>
		</td>

	</tr>
</table>
<%}else{%>
<jsp:include page="../share/apprlinktab.jsp" flush="true">
			<jsp:param name="tabid" value="101" />
			</jsp:include>
			<input type="hidden" id="FVCtab">
<%} 
}%>
<table width="98%" border="0" cellspacing="0" cellpadding="5" class="shadow" align="center" bordercolordark="#B6C1D2" bordercolorlight="#FFFFFF">
	<tr>
		<td valign="top">
		<table width="90%" border="0" align="center" cellspacing="0" cellpadding="5">
          <tr> 
            <td valign="top" colspan="3"> 
         
              <table width="100%" border="0" class="outertable border1" align="center" cellspacing="0" cellpadding="4">
              <tr>
              <td>
              <table width="100%" border="0" align="center" cellspacing="3" cellpadding="3" >
                <tr align="center" > 
                  <td  nowrap="nowrap" class="dataheader">Details</td>
                  <td  class="dataheader"><b>Name</b></td>
                  <td  class="dataheader"><b>Designation</b></td>
                  <td  class="dataheader"> Date</td>
                </tr>
                <tr> 
                <td width="25%" align="center"><select name="sel_details"  style="width:150px" onchange="checkval();">
											<option value="" selected="selected">----Select----</option>
											<option value="A"> Appraised By</option>
											<option value="V">Vetted By </option>
											<option value="S">Sanctioned By</option>
										</select></td>	
                   <td width="25%" align="center"><input type="text" name="txt_name" size="35"
									maxlength="15"  readonly> <span
									onClick="callSearch()" style="cursor: hand"><img
									src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
									border="0"></span></td>
                  <td width="25%" align="center"> 
                    <input type="hidden" name="txt_desig" maxlength="40" size="40" readOnly>
                    <input type="text" name="txt_desig1" maxlength="40" size="40" readOnly></td>
										<td  width="25%" align="center"><input type="text" name="txt_date"
													size="16"
													onBlur="checkDate(this);checkmaxdate(this,currentDate);comparedate(document.forms[0].hidappraiseddate.value,document.forms[0].txt_date.value)"
													value="">
												<a alt="Select date from calender" 	onClick="callCalender('txt_date')" id="idtxt_date"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender"></a> 
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
							
							
							<lapschoice:combuttonnew btnnames="New_Edit_Save_Delete_Cancel_Audit Trail"
	btnenable='<%=Helper.correctNull((String) request
							.getParameter("btnenable"))%>' />	
<%if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){
	if(!strSessionModuleType.equals("RET")){%>
	<table width="30%" border="0" align="center">
	<tr>
	<td align="center"><input type="button" name="btn_shortnotes" value="Short notes for Post Sanction" onclick="callProposalShort();" class="buttonStyle"></td>
	<td align="center"><input type="button" name="btn_Annexure" value="Annexure" onclick="callAnnexure();" class="buttonStyle" style="width: 120px"></td>
	<%if(strMCLRFlag.equalsIgnoreCase("Y")){ %>
	<td align="center"><input type="button" name="btn_MCLRSM" value="Interest Annexure" onclick="callAnnexureMCLR();" class="buttonStyle" style="width: 120px"></td>
	<%} %>
	</tr>
	</table>
<%}} %>
<br>
	<DIV class="cellContainer"> 
<table width="58%" border="0" cellspacing="0" cellpadding="3" class="outertable linebor" align="center">
	<tr class="dataheader">
		<td>&nbsp;</td>
		
		<td align="center" style="width:30%;"><b>Name</b></td>
		<td align="center" style="width:16%;"><b>Designation</b></td>
		<td align="center" style="width:16%;"><b>Details</b></td>
	    <td align="center" style="width:16%;"><b>Date</b></td>
		
	
	</tr>
	   <%
						//ArrayList arryRow=new ArrayList();
						String strSno = "",Strdetails="";
			if(hshValues!=null)
			{
				arryRow=(ArrayList)hshValues.get("arrRow");
				
			}
			
			if(arryRow!=null && arryRow.size()>0)
					{
			
				
				
			for(int i=0;i<arryRow.size();i++)
							{
								arryCol=(ArrayList)arryRow.get(i); 
								
%>
	
	<tr valign="top"  class="datagrid">
		<td width="3%"><input type="radio" name="radio_impln"
			onclick="selectValues('<%=Helper.correctNull((String)arryCol.get(3))%>',
					'<%=Helper.correctNull((String)arryCol.get(6))%>',
					'<%=Helper.correctNull((String)arryCol.get(2))%>',
					'<%=Helper.correctNull((String)arryCol.get(4))%>',
					'<%=Helper.correctNull((String)arryCol.get(5))%>',
					'<%=Helper.correctNull((String)arryCol.get(7))%>',
					'<%=Helper.correctNull((String)arryCol.get(8))%>')"
			style="border: none"> 
			 
		<td style="width:30%; m" ><input type="hidden" name="hiduserID" value="<%=Helper.correctNull((String)arryCol.get(5))%>">
		<input type="hidden" name="hidDetails" value="<%=Helper.correctNull((String)arryCol.get(7))%>"><%=Helper.correctNull((String)arryCol.get(6))%></td>
		<td style="width:16%;"><%=Helper.correctNull((String)arryCol.get(4))%></td>
			<td style="width:16%;" ><%if(Helper.correctNull((String)arryCol.get(7)).equalsIgnoreCase("S")){ %>Sanctioned By<%}else if(Helper.correctNull((String)arryCol.get(7)).equalsIgnoreCase("A")){ %>Appraised By<%}
					else if(Helper.correctNull((String)arryCol.get(7)).equalsIgnoreCase("V")){ %>Vetted By<%}else{%>&nbsp;<%} %></td>
			<td style="width:16%;"><%=Helper.correctNull((String)arryCol.get(8))%></td>
	
	</tr>
	<%}}%>
	
</table>
</DIV>
<input type="hidden" name="hidsno" value="">
<input type="hidden" name="txtuserID" value="">
<input type="hidden" name="hidappraiseddate" value="">
<input type="hidden" name="txtdate1" value="<%=strdate%>">
<lapschoice:hiddentag pageid='<%=PageId%>' />
</form>
</body>
</html>
							