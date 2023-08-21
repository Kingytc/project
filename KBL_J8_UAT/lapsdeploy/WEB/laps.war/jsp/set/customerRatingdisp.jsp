<%@include file="../share/directives.jsp"%>
<%HashMap hshRecord = (HashMap) hshValues.get("hshRecord");
java.text.NumberFormat nf=java.text.NumberFormat.getInstance();
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);
nf.setGroupingUsed(false);
String pageid = Helper.correctNull((String) request.getParameter("pageid"));
String strapptype = Helper.correctNull((String) request.getParameter("corp"));
if(strapptype.equalsIgnoreCase(""))
{
	strapptype = Helper.correctNull((String)request.getParameter("hidapptype"));
}
String strEmployment=(String)session.getAttribute("strEmployment");
String strModuleName = Helper.correctNull(request.getParameter("hidModuleName"));
String strModName = "";
if (strModuleName.equalsIgnoreCase("T")) {
	strModName = "Tertiary";
} else if (strModuleName.equalsIgnoreCase("P")) {
	strModName = "Retail";
} else {
	strModName = "Corporate & SME";
}
String strProfilestatus = Helper.correctNull((String) hshValues.get("strProfilestatus"));

ArrayList arrRow = new ArrayList();
ArrayList arrCol = new ArrayList();
if(hshValues!=null)
{
	arrRow = (ArrayList)hshValues.get("arrRow");
}
String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
%>
<html>
<head>
<title>Rating/Defaulter</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
<script language="JavaScript">
var appURL="<%=ApplicationParams.getAppUrl()%>";
var curdate = "<%=Helper.getCurrentDateTime()%>";
var apptype = "<%=strapptype%>";
var selratType="<%=Helper.correctNull((String) hshValues.get("RAT_TYPE"))%>";
var appstatus ="<%=Helper.correctNull((String) hshValues.get("appstatus"))%>";

function callOnload()
{ 
	if(selratType =="1"){
		document.forms[0].sel_RatingType.value="1";
		//disablecontrols(true,true,true,true,true,false);
	}else if(selratType =="2"){
		document.forms[0].sel_RatingType.value="2";
		//disablecontrols(true,true,true,true,true,false);
	}else{
		document.forms[0].sel_RatingType.value="";
		//disablecontrols(true,true,true,true,true,false);
	}  	
	showRating();
	//document.forms[0].cmdcomments.disabled = false;
	calldisable(true);
}

function selectValues(v1,v2,v3,v4,v5,v6,v7,v8,v9,v10)
{
	document.forms[0].hidSno.value=v2;
	document.forms[0].txt_pre_agency.value=v3;
	document.forms[0].txt_ratinddate.value=v4;
	document.forms[0].txt_facrated_parti.value=v5;
	document.forms[0].txt_amt_rated.value=v6;
	document.forms[0].txt_pre_longsymbol.value=v7;
	document.forms[0].txtar_desc.value=v8;
	document.forms[0].txt_duedate.value=v9;
	document.forms[0].txt_rat_weight.value=v10;
	//disablecontrols(true,false,true,true,true,false);
}

function disablecontrols(val1,edit,save,cancel,cdelete,close)
{
	document.forms[0].cmdnew.disabled = val1;
	document.forms[0].cmdedit.disabled = edit;
	document.forms[0].cmdsave.disabled = save;
	document.forms[0].cmdcancel.disabled = cancel;
	document.forms[0].cmddelete.disabled = cdelete;
	document.forms[0].cmdclose.disabled = close;
}

function calldisable(val)
{
	for(i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type == "text" )
		{
			document.forms[0].elements[i].disabled = val;
		}
		if(document.forms[0].elements[i].type == "textarea" )
		{
			document.forms[0].elements[i].disabled = val;
		}
		if(document.forms[0].elements[i].type == "select-one" )
		{
			document.forms[0].elements[i].disabled = val;
		}
    }
	document.forms[0].sel_RatingType.disabled= false;
}

function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appURL+"action/mastersearchper.jsp";	
		document.forms[0].submit();
	}
}

function doEdit()
{
	calldisable(false);
	document.forms[0].hidAction.value="update";
	disablecontrols(true,true,false,false,false,true);
	document.forms[0].hideditflag.value="Y";
	document.forms[0].cmdcomments.disabled = true;
}

function doNew()
{
	document.forms[0].hidAction.value="insert";
	calldisable(false);
	disablecontrols(true,true,false,false,true,true);
	document.forms[0].hideditflag.value="Y";
	document.forms[0].cmdcomments.disabled = true;
}

function doSave()
{	
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidBeanId.value="mastapplicant";
	document.forms[0].hidBeanMethod.value="updateRating";
	document.forms[0].hidBeanGetMethod.value="getRating";
	document.forms[0].hidSourceUrl.value="/action/customerRating.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();	
}

function doCancel()
{
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
		document.forms[0].hidBeanId.value="mastapplicant";
		document.forms[0].hidBeanGetMethod.value="getRating";
		document.forms[0].action=appURL+"action/customerRating.jsp";	
		document.forms[0].submit();
	}
}

function doDelete()
{	
	if(ConfirmMsg(101))
	{	
		document.forms[0].hidBeanId.value="mastapplicant";
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidBeanMethod.value="updateRating";
		document.forms[0].hidBeanGetMethod.value="getRating";
		document.forms[0].hidSourceUrl.value="/action/customerRating.jsp";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
	}
	else
	{
		ShowAlert(158);
	}		
}

function showSymbol(val,val1)
{	
	if(document.forms[0].cmdsave.disabled==false)
	{
		if(val1 == "P")
		{
			if(document.forms[0].txt_pre_agency.value != "")
			{
				var agency = document.forms[0].txt_pre_agency.value;
			}
			else
			{
				alert("Please select Rating Agency");
				return;
			}
		}
		else if(val1 == "C")
		{
			if(document.forms[0].txt_cur_agency.value != "")
			{
				var agency = document.forms[0].txt_cur_agency.value;
			}
			else
			{
				alert("Please select current year Agency Name");
				return;
			}
		}
		
		var type = val;
		var varQryString = "<%=ApplicationParams.getAppUrl()%>action/searchsymbollist.jsp?hidBeanGetMethod=getAgencyandSymbolList&hidBeanId=limitmaster&agency="+agency+"&type="+type+"&yeartype="+val1+"&hidvalue=symbol";
		var title = "Symbollist";
		var prop = "scrollbars=yes,width=650,height=400,menubar=yes";	
		var xpos = (screen.width - 350) / 2;
		var ypos = (screen.height - 120) / 2;
		prop = prop + ",left=50,top=50";
		window.open(varQryString,title,prop);
	}	
}

function callCalender(name)
{
	if(document.forms[0].cmdsave.disabled==false)
	{	
		showCal(appURL,name);
	}
}

function showAgency(val)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		var varQryString = "<%=ApplicationParams.getAppUrl()%>action/searchagencylist.jsp?hidBeanGetMethod=getAgencyandSymbolList&hidBeanId=limitmaster&hidvalue=agency&yeartype="+val;
		var title = "Agencylist";
		var prop = "scrollbars=yes,width=650,height=400,menubar=yes";	
		var xpos = (screen.width - 350) / 2;
		var ypos = (screen.height - 120) / 2;
		prop = prop + ",left=50,top=50";
		window.open(varQryString,title,prop);
	}
}

function showRating()
{
	if(document.forms[0].sel_RatingType.value=="1")
	{		
		document.getElementById("ratingtab").style.display = "table";
		document.getElementById("ratingtabgrid").style.display = "table";
		calldisable(false);
		//disablecontrols(false,true,true,true,true,false);
	}
	else
	{
		document.getElementById("ratingtab").style.display = "none";		
		document.getElementById("ratingtabgrid").style.display = "none";
		//disablecontrols(true,true,true,true,true,false);		
	}	
	calldisable(true);	
}

function ClearFields()
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			  document.forms[0].elements[i].value="";		  
		}		
		else if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].value="";		  
		}
	}
}

function doComments()
{
	var hidDemoId=document.forms[0].hidDemoId.value;
	var prop = "scrollbars=no,width=750,height=550,top=25,left=180";
	var url=appURL+"action/comments.jsp?hidBeanId=perfinancial&hidBeanGetMethod=getComments&hidDemoId="+hidDemoId+"&hidCommentPage=cusratingnew";
	window.open(url,"Comments",prop);
}

function callLink(page,bean,method)
{ 
	document.forms[0].hidAction.value="";
 	document.forms[0].hidBeanGetMethod.value=method;
 	document.forms[0].hidBeanId.value=bean;
 	document.forms[0].action=appURL+"action/"+page;
 	document.forms[0].submit();
}
</script>
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="callOnload()">
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
<form name="colForm" method="post" class="normal">
<%if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){ 
if(!strSessionModuleType.equalsIgnoreCase("RET")){%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../com/postsanctionlinks.jsp" flush="true">
			<jsp:param name="pageid" value="1" />
			<jsp:param name="subpageid" value="115" />
			<jsp:param name="subsubpageid" value="24" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<% }else{%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../set/postsanctionlinksper.jsp" flush="true">
			<jsp:param name="pageid" value="2" />
			<jsp:param name="subsubpageid" value="24"/>
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<%} %>
<jsp:include page="../share/Cusurllinkdisp.jsp" flush="true">
			<jsp:param name="pageid" value=""/>
			<jsp:param name="subsubpageid" value="24"/>
			<jsp:param name="employmenttype" value="<%=strEmployment%>" />
			<jsp:param name="demoid" value="<%=strapptype%>" />
		</jsp:include>
<%}else{ %>
       <%if(strapptype.equalsIgnoreCase("C")){ %>
	<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="1" />
			<jsp:param name="cattype" value="CORP" />
			<jsp:param name="ssitype" value="" />
			<jsp:param name="applevel" value="A" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
   <%

if(strSessionModuleType.equalsIgnoreCase("AGR")){
%>
	<tr>
		<td class="page_flow">Home -&gt;Agriculture -&gt; Application -&gt; Applicant-&gt; customer profile -&gt; Rating/Defaulter</td>
	</tr>
	<%}else{ %>
	<tr>
		<td class="page_flow">Home -&gt;Corporate &amp; SME -&gt; Application -&gt; Applicant-&gt; customer profile -&gt; Rating/Defaulter</td>
	</tr>
  </table>
	<%}}else if(strapptype.equalsIgnoreCase("R")){%>
        <jsp:include page="../share/Applurllinkper.jsp" flush="true"> 
        <jsp:param name="pageid" value="<%=pageid%>" />
        </jsp:include>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center"  class="outertable">
    <tr> 
      <td class="page_flow">Home -&gt; 
       Retail(including schematic) -&gt; Application -&gt; Applicant/Guarantor -&gt; Demographics</td>
    </tr>
  </table>
  <%} %>
<lapschoice:application />
   
   <table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
		<table width="98%" border="0" cellspacing="1" cellpadding="3"
			align="left" class="outertable">
			<%if(strapptype.equalsIgnoreCase("C")){ %>
		<tr>
		<lapstab:ComfacilityTab tabid="2" />
		</tr>
		<%}if(strapptype.equalsIgnoreCase("C") || strapptype.equalsIgnoreCase("R")){%>
			<tr>
		<td><jsp:include page="../share/Cusurllinkdisp.jsp" flush="true">
			<jsp:param name="pageid" value="24"/>
			<jsp:param name="employmenttype" value="<%=strEmployment%>" />
			<jsp:param name="demoid" value="<%=strapptype%>" />
		</jsp:include></td>
			</tr>
		</table>
		</td>
	</tr>
	</table>
	<%}} %>

		<table width="30%" border="0" cellpadding="2" cellspacing="1" class="outertable">
		<tr>
		<td class="sub_tab_active" align="center"><b>Rating</b></td>
		<td class="sub_tab_inactive" align="center"><b><a href="#" 
		onclick="javascript:callLink('customerDefaulterdisp.jsp','mastapplicant','getDefaulter')"><b>Defaulter</b></a></td>
		</tr>
		</table>
<br>
	<table width="98%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable border1">
		<tr>
		<td>
		<table width="100%" border="0" cellspacing="1" cellpadding="3"	align="center" class="outertable">
		<tr valign="top" class="applicationheader">
		<td><b>External Long Rating of the Customer</b></td>
		</tr>
		<tr>
		<td>Rating Type&nbsp;&nbsp;&nbsp;
			<select name="sel_RatingType" onChange="showRating()">
			<option value="" selected>--Select--</option>
			<option value="1">Rated</option>
			<option value="2">Non Rated</option>
			</select>
		</td>
		</tr> 
		</table>
		<br>
			<table id="ratingtab" width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
			<tr>
			<td width="20%">Name of the rating agency</td>
			<td width="30%"><input type="text" name="txt_pre_agency" size="40" maxlength="50"
				value="<%=Helper.correctNull((String) hshValues.get("RAT_AGENCY"))%>">
				<b><span onClick="showAgency('P');" style="cursor: hand"><font size="1" face="MS Sans Serif">
				<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0"></font></span>
				</b>&nbsp;</td>
			<td width="20%">Date of rating / press release</td>
			<td width="30%"><input type="text" name="txt_ratinddate" size="11" value="<%=Helper.correctNull((String) hshValues
							.get("RAT_DATE"))%>" onBlur="checkDate(this);checkmaxdate(this,curdate)" maxlength="12">
			<a alt="Select date from calender" href="#"	onClick="callCalender('txt_ratinddate')"
				onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;">
				<img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" tabindex="29"></a></td>
			</tr>
			<tr>
			<td>Particulars of facility rated</td>
			<td><input type="text" name="txt_facrated_parti" size="48" maxlength="100"
				value=""></td>
			<td>Amount rated</td>
			<td><input type="text" name="txt_amt_rated" size="15" maxlength="10"
				value="" onBlur="roundtxt(this);" onKeypress="allowNumber(this);" style="text-align:right"></td>
			</tr>
			<tr>
			<td>Rating assigned</td>
			<td><input type="text" name="txt_pre_longsymbol" size="15"  maxlength="50"
				value="<%=Helper.correctNull((String) hshValues.get("RAT_SYMBOL"))%>">
				<b><span onClick="showSymbol('L','P');"	style="cursor: hand"><font size="1"	face="MS Sans Serif">
				<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0"></font></span>
				</b>&nbsp;</td>
			<td>Description</td>
			<td><textarea name="txtar_desc" cols="25"  rows="2"  onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"></textarea></td>
			</tr>
			<tr>
			<td>Due date</td>
			<td><input type="text" name="txt_duedate" size="11" value="" onBlur="checkDate(this);checkmaxdate(this,curdate)" maxlength="12">
			<a alt="Select date from calender" href="#"	onClick="callCalender('txt_duedate')"
				onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;">
				<img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender"></a></td>
			<td>Risk weight</td>
			<td><input type="text" name="txt_rat_weight" size="12" maxlength="5" onKeypress="allowNumber(this);"
				value=""></td>
			</tr> 
			</table>
		</td></tr>
	</table>
		
<br>
		<lapschoice:combuttonnew  btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
		<input type="button" name="cmdsave" disabled style="display:none"> 
<br>

<table id="ratingtabgrid" width="98%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
	<tr><td>
		<table width="100%" border="0" cellspacing="1" cellpadding="3" align="center" class="outertable">
			<tr class="dataheader">
			<td width="5%" align="center">&nbsp;</td>
			<td width="20%" align="center">Name of the rating agency</td>
			<td width="15%" align="center">Date of rating / press release</td>
<!--			<td width="15%" align="center">Particulars of facility rated</td>-->
			<td width="15%" align="center">Amount rated</td>
			<td width="15%" align="center">Rating assigned</td>
<!--			<td width="10%" align="center">Description</td>-->
			<td width="15%" align="center">Due date</td>
			<td width="15%" align="center">Risk weight</td>
			</tr>
			<%if(arrRow!=null && arrRow.size()>0){
				for(int i=0;i<arrRow.size();i++){
					arrCol = (ArrayList)arrRow.get(i);%>
			<tr class="datagrid">
			<td align="center"><input type="radio" name="rad_sel" style="border-style:none" onClick="selectValues(
				'<%=Helper.correctNull((String)arrCol.get(0))%>',
				'<%=Helper.correctNull((String)arrCol.get(1))%>',
				'<%=Helper.correctNull((String)arrCol.get(2))%>',
				'<%=Helper.correctNull((String)arrCol.get(3))%>',
				'<%=Helper.correctNull((String)arrCol.get(4))%>',
				'<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(5))))%>',
				'<%=Helper.correctNull((String)arrCol.get(6))%>',
				'<%=Helper.correctNull((String)arrCol.get(7))%>',
				'<%=Helper.correctNull((String)arrCol.get(8))%>',
				'<%=Helper.correctNull((String)arrCol.get(9))%>')">
			</td>
			<td><%=Helper.correctNull((String)arrCol.get(2))%></td>
			<td><%=Helper.correctNull((String)arrCol.get(3))%></td>
<!--			<td><%=Helper.correctNull((String)arrCol.get(4))%></td>-->
			<td align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(5))))%></td>
			<td><%=Helper.correctNull((String)arrCol.get(6))%></td>
<!--			<td><%=Helper.correctNull((String)arrCol.get(7))%></td>-->
			<td><%=Helper.correctNull((String)arrCol.get(8))%></td>
			<td align="right"><%=Helper.correctNull((String)arrCol.get(9))%></td>
			</tr>
			<%}}else{ %>
			<tr class="datagrid">
			<td colspan="9" align="center">No Data Found</td>
			</tr>
			<%} %>
		</table>
	</td></tr>
</table>
<%String strappno = request.getParameter("appno");%> 
<lapschoice:hiddentag pageid='<%=PageId%>' />
<input type="hidden" name="txtperapp_appid" value="<%=Helper.correctNull((String)hshValues.get("applicantId"))%>"> 
<input type="hidden" name="hidDemoId" value="<%=Helper.correctNull((String)request.getParameter("hidDemoId"))%>">
<input type="hidden" name="hidappstatus" value="<%=Helper.correctNull((String)hshValues.get("appstatus"))%>">   
<input type="hidden" name="hidFromPage" value="Defaulter">   
<input type="hidden" name="hidSno" value="Defaulter">   
<input type="hidden" name="hidapptype" value="<%=strapptype%>">   
<INPUT TYPE="hidden" name="hidPage" value="<%=pageid%>">
</form>
</body>
</html>
