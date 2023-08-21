<%@include file="../share/CKEditor.jsp"%>
<%@include file="../share/directives.jsp"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>

<jsp:useBean id="objValues" class="java.lang.Object" scope="request" /> 
<% String appnoval = "";
appnoval = Helper.correctNull((String)request.getParameter("appno"));
ArrayList arrRow=new ArrayList();
ArrayList arrCol=new ArrayList();

arrRow=(ArrayList)hshValues.get("arrRow");
%>
<html>
<head>
<title>Proposal</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script language="Javascript1.2"><!-- // load htmlarea
_editor_url = "<%=ApplicationParams.getAppUrl()%>";                     // URL to htmlarea files
var win_ie_ver = parseFloat(navigator.appVersion.split("MSIE")[1]);
if (navigator.userAgent.indexOf('Mac')        >= 0) { win_ie_ver = 0; }
if (navigator.userAgent.indexOf('Windows CE') >= 0) { win_ie_ver = 0; }
if (navigator.userAgent.indexOf('Opera')      >= 0) { win_ie_ver = 0; }
if (win_ie_ver >= 5.5) {
  document.write('<scr' + 'ipt src="' +_editor_url+ 'editor.js"');
  document.write(' language="Javascript1.2"></scr' + 'ipt>');  
} else { document.write('<scr'+'ipt>function editor_generate() { return false; }</scr'+'ipt>'); }
// --></script>

<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/editor.js"></script>
<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT	src="<%=ApplicationParams.getAppUrl()%>jas/share/CommonFunction.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>ckeditor/ckeditor.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appstatus="<%=Helper.correctNull((String) request
							.getParameter("appstatus"))%>";
var Facilityid="<%=Helper.correctNull((String) hshValues.get("hshFacility"))%>";
var appno="<%=request.getParameter("appno")%>";
var varOption="<%=Helper.correctNull((String) hshValues.get("hshOptionVal"))%>";
function enableButtons(bool1,bool2,bool3,bool4,bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmdclose.disabled=bool4;	
	document.forms[0].cmdcomments.disabled=bool5;	
}
function call_page(url,method,type)
{
	
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].hidBeanId.value="bankapp";
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+url+"?type="+type;
	document.forms[0].submit();
	
}
function disableFields(one)
{	
	for(var i=0;i<document.forms[0].length;i++)
	{
		
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=one;		  
		}
				
	}	
	
}
function placevalues()
{

if(Facilityid=="")
{
	document.forms[0].sel_facility.value ="s";
	enableButtons(true,true,true,true,false);
}
else
{	
	 	document.forms[0].sel_facility.value =Facilityid;
		disableFields(true);
		document.forms[0].sel_options.value=varOption;

		if(appstatus=="Open/Pending")
		{
		if(document.forms[0].btnenable.value.toUpperCase()=="Y")
		{
			enableButtons(false,true,true,true,false);
		}
		else
		{
			enableButtons(true,true,true,true,false);
		}
		}
	else
	{
		enableButtons(true,true,true,true,false);
	}
		if(document.forms[0].sel_facility.value!='s')
		{
			document.forms[0].sel_options.disabled=false;
		}

		if(document.forms[0].sel_options.value=="3")
		{
			document.all.id_table1.style.display="table";
			document.all.id_table.style.display="table";
		}
		else
		{
			document.all.id_table1.style.display="none";
			document.all.id_table.style.display="none";
		}
		
	 	
}		
EditorEnableDisable("id_div","block","id_editor","none");
}

function doCancel()
{
	if (ConfirmMsg(102))
	{
	document.forms[0].hidBeanGetMethod.value="getSourceOfMargin";
	document.forms[0].hidBeanId.value="bankapp";
	document.forms[0].action=appURL+"action/com_commenstonproj.jsp";
	document.forms[0].submit();
	}
}

function doClose()
{
	 var cattype=document.forms[0].cattype.value;
	if((cattype=="SSI")||(cattype=="CORP")||(cattype=="SME")||(cattype=="STL"))
    {
	    if(ConfirmMsg(100))
		{
			document.forms[0].action=appUrl+"action/corppge.jsp";
		 	document.forms[0].submit();
	 	}
	}
}

function doEdit()
{
	EditorEnableDisable("id_div","none","id_editor","block");
	editor_generate('txt_termloan');
	for(var i=0;i<document.forms[0].elements.length;i++)
		{
			if(document.forms[0].elements[i].type=="textarea")
			{
			  document.forms[0].elements[i].readOnly=false;
			  
			}
			
		}
	disableFields(false);
	enableButtons(true,false,false,true,false);
	document.forms[0].cmddelete.disabled=false;	
	document.forms[0].sel_options.disabled=true;
	document.forms[0].sel_facility.disabled=true;
	
}

function doSave()
{
	document.forms[0].sel_options.disabled=false;
	document.forms[0].sel_facility.disabled=false;
	
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidAction.value ="insert";
	document.forms[0].hidBeanId.value="bankapp";
	document.forms[0].hidBeanMethod.value="updateSourceOfMargin";
	document.forms[0].hidBeanGetMethod.value="getSourceOfMargin";
	document.forms[0].hidSourceUrl.value="/action/com_commenstonproj.jsp"
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}
function clearFields()
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].value="";		  
		}
	}		
}

function getvalues()
{
	if(document.forms[0].sel_facility.value!="s")
	{
		document.forms[0].hidBeanId.value="bankapp";
		document.forms[0].hidBeanGetMethod.value="updateSourceOfMargin";
		document.forms[0].hidBeanGetMethod.value="getSourceOfMargin";						
		document.forms[0].hidSourceUrl.value="/action/com_commenstonproj.jsp";
		document.forms[0].submit();
		disableFields(true);
		enableButtons(false,true,true,true,false);	
	}		
	else
	{
		clearFields();
		enableButtons(true,true,true,true,false);
		disableFields(true);
		document.forms[0].submit();
	}
}		
function doDelete()
{
	document.forms[0].sel_options.disabled=false;
	document.forms[0].sel_facility.disabled=false;
	
	document.forms[0].hidAction.value ="delete";
	document.forms[0].action=appURL+"action/ControllerServlet";	
	document.forms[0].hidBeanId.value="bankapp";
	document.forms[0].hidBeanMethod.value="updateSourceOfMargin";
	document.forms[0].hidBeanGetMethod.value="getSourceOfMargin";						
	document.forms[0].hidSourceUrl.value="action/com_commenstonproj.jsp";	
    document.forms[0].method="post";			
	document.forms[0].submit();	
}
function gototab(beanid,methodname,pagename,type)
{
		if(type=="COP")
		{
		document.forms[0].hidBeanId.value=beanid;
		document.forms[0].hidBeanGetMethod.value=methodname;
		document.forms[0].action=appURL+"action/"+pagename+"?hidPageSource="+type;
		document.forms[0].submit();
		}
		if(type=="SOM")
		{
		document.forms[0].hidBeanId.value=beanid;
		document.forms[0].hidBeanGetMethod.value=methodname;
		document.forms[0].action=appURL+"action/"+pagename+"?hidPageSource="+type;
		document.forms[0].submit();
		}
		else
		{
		document.forms[0].hidBeanId.value=beanid;
		document.forms[0].hidBeanGetMethod.value=methodname;
		document.forms[0].action=appURL+"action/"+pagename;
		document.forms[0].flowtype.value=type;
		document.forms[0].submit();
		}	
}   
function callcopmof()
{	
		document.forms[0].method="post";
		document.forms[0].action=appUrl+"action/com_termloanassesment.jsp";
		document.forms[0].submit();
	
}
function callReleasePattern(beanid,methodname,pagename,ptype)
{
	document.forms[0].hidBeanId.value=beanid;
	document.forms[0].hidBeanGetMethod.value=methodname;
	document.forms[0].action=appURL+"action/"+pagename;
	document.forms[0].pageType.value=ptype;
	document.forms[0].submit();
}
function doComments()
{
	var btnenable=document.forms[0].btnenable.value;
	var strAppno =appno;
	var facility=document.forms[0].sel_facility.value;
	var pagetype = document.forms[0].hidCommentPage.value;
	var prop = "scrollbars=yes,width=750,height=550,top=25,left=180";
	var url=appURL+"action/com_comments.jsp?hidBeanId=comproposal&hidBeanGetMethod=getDataComments&pagetype="+pagetype+"&strAppno="+strAppno+"&facilitysno="+facility+"&appstatus="+appstatus;
	window.open(url,"Comments",prop);
}
function getDataValues()
{
	if(document.forms[0].sel_facility.value!="s" && document.forms[0].sel_options.value!="")
	{
		document.forms[0].hidBeanId.value="bankapp";
		document.forms[0].hidBeanGetMethod.value="updateSourceOfMargin";
		document.forms[0].hidBeanGetMethod.value="getSourceOfMargin";						
		document.forms[0].hidSourceUrl.value="/action/com_commenstonproj.jsp";
		document.forms[0].submit();
		disableFields(true);
		enableButtons(false,true,true,true,false);	
	}		
	else
	{
		clearFields();
		enableButtons(true,true,true,true,false);
		disableFields(true);
		document.forms[0].submit();
	}
}
function addRows(){

	if(document.forms[0].cmdedit.disabled==true)
	{	
	var tab  = document.getElementById("id_table");
	var rowsLength = tab.rows.length;
	if(rowsLength<=200)
	{
		var new_Row    = tab.insertRow(rowsLength);
		
		var rwlength=rowsLength;
		new_Row.id=""+rowsLength;
		var previous_RowCells=tab.rows[rowsLength-1].cells; 
		for(i=0;i<previous_RowCells.length;i++)
		{
			var new_RowCell=new_Row.insertCell(i);
			new_RowCell.innerHTML=previous_RowCells[i].innerHTML;
			new_RowCell.className="datagrid";
			new_RowCell.align="center";
			var new_CellElement=new_RowCell.childNodes[0];
			
			for(var j=0;j<new_RowCell.childNodes.length;j++)
			{
				if(new_RowCell.childNodes[j].type=="text")
				{
					new_RowCell.childNodes[j].value="";
				}
			}
			 
		}
	}
	else
	{
		alert("Cannot add more rows");
	}
	
}
}

function deleteRow1(tabid,tdcount)
{
	if(document.forms[0].cmdedit.disabled==true)
	{
		var tab = document.getElementById(tabid);
		var rowsLength = tab.rows.length;
		var varCheckedFlag=false;
		if(rowsLength>=1)
		{
			for(var i=0;i<rowsLength;i++)
			{
				var current_row = tab.rows[i];
				var chkbox = current_row.cells[tdcount].childNodes[0];
				if(chkbox != null && chkbox.checked == true)
				{
					 if(tabid=="id_table" && rowsLength=="1")
					{
						document.forms[0].txt_particulars.value="";  
						document.forms[0].txt_name.value="";  
						document.forms[0].txt_quantity.value="";  
						document.forms[0].txt_costperunit.value="";
						document.forms[0].txt_amttotal.value="";  
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
				alert("Please select the check box for deletion");
			}
		}
	}
}
function calAmount(obj)
{
	var tab  = document.getElementById("id_table");
	var rowsLength = tab.rows.length;
	if(rowsLength>1)
	{
		for(var i=0;i<document.forms[0].txt_quantity.length;i++)
		{
			if(obj==document.forms[0].txt_quantity[i]||obj==document.forms[0].txt_costperunit[i])
			{
				if(document.forms[0].txt_quantity[i].value=="")
				{
					document.forms[0].txt_quantity[i].value="0";
				}
				if(document.forms[0].txt_costperunit[i].value=="")
				{
					document.forms[0].txt_costperunit[i].value="0";
				}
				document.forms[0].txt_amttotal[i].value=eval(document.forms[0].txt_quantity[i].value)*eval(document.forms[0].txt_costperunit[i].value);
				document.forms[0].txt_amttotal[i].value=roundVal(document.forms[0].txt_amttotal[i].value);
			}
		}
	}
	else
	{
		if(document.forms[0].txt_quantity.value=="")
		{
			document.forms[0].txt_quantity.value="0";
		}
		if(document.forms[0].txt_costperunit.value=="")
		{
			document.forms[0].txt_costperunit.value="0";
		}
		document.forms[0].txt_amttotal.value=eval(document.forms[0].txt_quantity.value)*eval(document.forms[0].txt_costperunit.value);
		document.forms[0].txt_amttotal.value=roundVal(document.forms[0].txt_amttotal.value);
	}
}
</script>
</head>
<body onload="placevalues()">
<%
	String strType = Helper.correctNull((String) hshValues.get("type"));
%>
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
<%
	if (strCategoryType.equalsIgnoreCase("STL")) {
%> <jsp:include
	page="../share/applurllinkscom.jsp" flush="true">
	<jsp:param name="pageid" value="11" />
	<jsp:param name="cattype" value="<%=strCategoryType%>" />
	<jsp:param name="ssitype" value="<%=strSSIType%>" />
</jsp:include>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Short
		Term Loan -&gt; Comments -&gt; Term loan assessment</td>
	</tr>
</table>
<span style="display: none;"><lapschoice:borrowertype /></span> <lapschoice:application />
<table width="30%" border="0" cellspacing="1" cellpadding="3"
	class="outertable">
	<tr>
		<td class="sub_tab_inactive" align="center"><a
			href="JavaScript:gototab('comformula','getDateFincommentsData','comdynamiccashflow.jsp','CA')"
			onMouseOut="window.status='';return true;"
			onMouseOver="window.status='Cash Flow';return true;"> <b>Cash
		Flow</b></a></td>
		<td class="sub_tab_active" align="center">Term loan assessment</td>
	</tr>
</table>
<%
	} else {
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td valign="top"><jsp:include page="../com/proposallinks.jsp"
			flush="true">
			<jsp:param name="pageid" value="41" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
</table>
<span class="page_flow">Home -&gt; Corporate &amp; SME -&gt;
Proposal -&gt; Financial Analysis -&gt; Assessment -&gt; Term Loan
Assessment -&gt; Source of Margin</span><br>
<span style="display: none;"><lapschoice:borrowertype /></span> <lapschoice:application />
 <jsp:include
	page="../com/com_commentstab.jsp" flush="true">
	<jsp:param name="tabid" value="3" />
</jsp:include> <%
 	}
 %> <%
 	if (!strCategoryType.equalsIgnoreCase("STL")) {
 %>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	align="center" class="outertable">
	<tr>
		<td valign="bottom">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="outertable">
			
			<tr>
				<td>
				<table width="90%" border="0" cellspacing="1" cellpadding="3"
					class="outertable">
					<tr align="center">
					<td class="sub_tab_inactive" align="center"><a
							href="javascript:callReleasePattern('bankapp','getSourceOfMargin','com_existingtermloan.jsp','ExistingTerm')"><b>Existing Term Loan (Review)</b></a></td>
					    <td class="sub_tab_inactive" align="center"><a
							href="javascript:callReleasePattern('bankapp','getBreifDetailOfProject','com_BreifDetailOfProject.jsp','')"><b>Brief Details of the project</b></a></td>
						<td class="sub_tab_inactive" align="center"><a
							href="javascript:callcopmof()"><b>Term loan assessment</b></a></td>
						<td class="sub_tab_inactive" align="center"><a
					href="javascript:callReleasePattern('bankapp','getSourceOfMargin','com_contlimitcomment.jsp','SOM')"><b>Source of Margin</b></a></td>
						<td class="sub_tab_active" align="center"><b>Comments on the project</b></td>
						<td class="sub_tab_inactive" align="center"><a
							href="javascript:callReleasePattern('bankapp','getReleasePattern','com_releasepattern.jsp','')"><b>Release Pattern/ Margin</b></a></td>						
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<%
	}
%>
<br>
<table width="80%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
			<tr class="dataGrid">
			    <td width="30%" align="center">Facility</td>
				<td width="70%" align="left">
					<SELECT NAME="sel_facility" onchange="getvalues();" TABINDEX="1" STYLE="width: 500">
						<OPTION VALUE="s" selected>--Select--</OPTION>
						<laps:TermLoanFund appno="<%=appnoval%>" />
					</SELECT>
				</td>				
			</tr>		
			
			
			<tr>
			    <td width="30%" align="center">Comments for</td>
				<td width="70%" align="left">
					<SELECT NAME="sel_options" onchange="getDataValues();" TABINDEX="1" STYLE="width: 500">
						<OPTION VALUE="" selected>--Select--</OPTION>
						<option value="1">Land</option>
						<option value="2">Building</option>
						<option value="3">Machineries/ Other fixed Assets</option>
						<option value="4">Any other Project Components</option>
						<option value="5" title="Availability of Infrastructure to House the above components in case of existing borrowers and Creation of Infrastructure in case of new projects">Availability of Infrastructure to House the above components</option>
						<option value="6">Approvals & Clearances</option>
						<option value="7">Technical Aspect/TEV Study</option>
						<option value="8">Details of Government Support & Subsidy available (If any)</option>
						<option value="9">Expected life (Asset/Production life) of the Asset Financed out of the Term Loan</option>
						<option value="10">Period and Repayment Schedule</option>
						<option value="11">Project Implementation Plan & Present Status and implication of DCCO with reference to IRAC</option>
						<option value="12">Others</option>
					</SELECT>
				</td>				
			</tr>	
			
			<tr>
							<td colspan="6">
							<table width="100%"  border="0"   cellpadding="4"  class="outertable" align="center"  style="border: 1px solid #bbb;"  id="id_table1">
							  <tr class="dataheader">
									<td width="5%" align="center" rowspan="2"><span style=""><a onClick="addRows();"><img
										src="<%=ApplicationParams.getAppUrl()%>img/add.png"
										border="0" tabindex="38"></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								 		<a onClick="deleteRow1('id_table','0');"><img
										src="<%=ApplicationParams.getAppUrl()%>img/cancel.png"
										border="0"></a> </span> </td>
									<td width="20%" align="center"> Machinery Particulars</td>
									<td  width="25%" align="center">Name of Supplier</td>
									<td  width="10%" align="center"> Quantity</td>
									<td  width="15%" align="center"> Cost per Unit</td>
									<td  width="15%" align="center"> Total Amount</td>
							</tr>
							</table>
							<table width="100%" border="0"   class="outertable"  align="center" cellpadding="3" style="border: 1px solid #bbb;" id="id_table">
							 <%if(arrRow!=null && arrRow.size()>0){ 
									for(int i=0;i<arrRow.size();i++){
									arrCol=(ArrayList)arrRow.get(i);%>
								<tr id="0"  align="center">	
									<td width="5%" class="datagrid"><input type="checkbox" name="chk1" style="border: none;"></td>	
									<td width="20%" class="datagrid"><input type="text" name="txt_particulars" size="30" maxlength="50" onkeypress="allowAlphabetsForName()" value="<%=Helper.correctNull((String)arrCol.get(0)) %>"></td>
									<td width="25%" class="datagrid"><input type="text" name="txt_name" size="30" maxlength="50" onkeypress="allowAlphabetsForName()"  value="<%=Helper.correctNull((String)arrCol.get(1)) %>"></td>
									<td width="10%" class="datagrid"><input type="text" name="txt_quantity" size="15" onkeypress="allowNumber(this)"  value="<%=Helper.correctNull((String)arrCol.get(2)) %>" maxlength="12" style="text-align: right;" onblur="calAmount(this);"></td>
									<td width="15%" class="datagrid"><input type="text" name="txt_costperunit" size="15" onkeypress="allowNumber(this)"  value="<%=Helper.correctNull((String)arrCol.get(3)) %>" maxlength="12" style="text-align: right;" onblur="roundtxt(this);calAmount(this);"></td>
									<td width="15%" class="datagrid"><input type="text" name="txt_amttotal" size="15"   value="<%=Helper.correctNull((String)arrCol.get(4)) %>" maxlength="12" style="text-align: right;" onblur="roundtxt(this)"></td>
								</tr>
								<%}}else{ %>
								<tr id="0"  align="center">	
									<td width="5%" class="datagrid"><input type="checkbox" name="chk1" style="border: none;"></td>	
									<td width="20%" class="datagrid"><input type="text" name="txt_particulars" size="30" maxlength="50"  onkeypress="allowAlphabetsForName()" ></td>
									<td width="25%" class="datagrid"><input type="text" name="txt_name" size="30" maxlength="50" onkeypress="allowAlphabetsForName()" ></td>
									<td width="10%" class="datagrid"><input type="text" name="txt_quantity" size="15" onkeypress="allowNumber(this)" maxlength="12" style="text-align: right;" onblur="calAmount(this);"></td>
									<td width="15%" class="datagrid"><input type="text" name="txt_costperunit" size="15" onkeypress="allowNumber(this)" maxlength="12" style="text-align: right;" onblur="roundtxt(this);calAmount(this);"></td>
									<td width="15%" class="datagrid"><input type="text" name="txt_amttotal" size="15" style="text-align: right;" onblur="roundtxt(this)"></td>
								
								</tr>
								<%} %>
								</table>
							</td>
							</tr>	
			
			
			
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="5"
	align="center" class="outertable">
		
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="5"
					class="outertable">
					<tr>
						<td valign="top">
						<table width="90%" border="0" cellspacing="0" cellpadding="3"
							class="outertable" align="center">
							<tr>
								<td valign="top" width="60%">
								 <div id="id_div"><div class="EditorClassNew"> <%=Helper.correctNull((String)hshValues.get("com_termloan_comments")) %></div></div>
					 			<div id="id_editor">
								<textarea name="txt_termloan"
									cols="110" wrap="VIRTUAL" rows="25" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)">
									<%=Helper.correctNull((String) hshValues
							.get("com_termloan_comments"))%></textarea>
							</div>
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
<table width="100%" border="0" cellspacing="0" cellpadding="2"
	class="outertable">
	<tr>
		<td colspan="3"><lapschoice:combuttonnew
			btnnames='Edit_Save_Cancel_Delete_Comments'
			btnenable='<%=Helper.correctNull((String) request
							.getParameter("btnenable"))%>' />
		</td>
	</tr>
</table>
<lapschoice:hiddentag pageid='<%=PageId%>' /> <input type="hidden"
	name="flowtype" /> <input type="hidden" name="yearfrom" value="1">
<input type="hidden" name="cattype" value="<%=strCategoryType%>">
<input type="hidden" name="pageType" value="CommentsProj">
<input type="hidden" name="hidSno" value="1">
<input type="hidden" name="pagefrom">
<INPUT TYPE="hidden" name="strAssessment" value = "<%=request.getParameter("strAssessment")%>">
<input type="hidden" name="hidCommentPage" value="CommentsProj">
</form>
</body>
</html>
