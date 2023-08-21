<%@include file="../share/CKEditor.jsp"%>
<%@include file="../share/directives.jsp"%>
<%ArrayList arrRow=new ArrayList(); 
ArrayList arrCol=new ArrayList();
arrRow = (ArrayList) hshValues.get("arrRow");%>
<html>
<head>
<title>Management Information</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/editor.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js">
</script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>	
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>ckeditor/ckeditor.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var appstatus="<%=Helper.correctNull((String) request.getParameter("appstatus"))%>";
var selcomments="<%=Helper.correctNull((String) hshValues.get("selcoment"))%>";
var appno="<%=request.getParameter("appno")%>";
var COM_CHANGECONST="<%=Helper.correctNull((String) hshValues.get("COM_CHANGECONST"))%>";

function doClose()
{
	if( ConfirmMsg(100) )
	{
		document.forms[0].method="post";
        document.forms[0].hidBeanId.value="";
	    document.forms[0].action=appURL+"action/"+"corppge.jsp";	
		document.forms[0].submit();
	}
}
function doDelete()
{
	document.forms[0].hidAction.value ="delete";
	document.forms[0].hidBeanId.value="compro";
    document.forms[0].hidBeanMethod.value="updateFinancialComments";
	document.forms[0].hidBeanGetMethod.value="getFinancialComments";
	document.forms[0].hidSourceUrl.value="action/com_managementinfo.jsp";	
	document.forms[0].action=appURL+"action/controllerservlet";	
	document.forms[0].submit();
}
function doSave()
{ 	
	if(document.forms[0].sel_commentstype.value =="s")
	{
		alert("Please Select comment on");
		document.forms[0].txt_comments.value="";
		EditorEnableDisable("id_div","block","id_editor","none");
		return;
	}
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidAction.value ="insert";
	document.forms[0].hidBeanId.value="compro";
	document.forms[0].hidBeanMethod.value="updateFinancialComments";
	document.forms[0].hidBeanGetMethod.value="getFinancialComments";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/com_managementinfo.jsp";
	document.forms[0].submit();
}
function disableCommandButtons(val)
{
	if(val=="load")
	{
		if(appstatus=="Processed/Rejected" || appstatus=="Processed/Approved" || appstatus=="Closed/Approved" || appstatus=="Closed/Rejected")	 
	  	{
		if(document.forms[0].btnenable.value =='N')
	  	{
			document.forms[0].cmdnew.disabled=true;
		  	document.forms[0].cmdedit.disabled=true;
		  	document.forms[0].cmddelete.disabled=true;
		  	document.forms[0].cmdsave.disabled=true;
		  	document.forms[0].cmdcancel.disabled=true;
		  	document.forms[0].cmdclose.disabled=false;
	 	}
	  	}
	 	else
	 	{
	 		document.forms[0].cmdedit.disabled=false;
	 	  	document.forms[0].cmddelete.disabled=true;
		  	document.forms[0].cmdsave.disabled=true;
		  	document.forms[0].cmdcancel.disabled=true;
		  	document.forms[0].cmdclose.disabled=false;
		  	//document.forms[0].cmdcomments.disabled=false;
	 	}
	}
	if(val=="edit")
	{
		if(document.forms[0].btnenable.value =='N')
	  	{
			document.forms[0].cmdnew.disabled=true;
		  	document.forms[0].cmdedit.disabled=true;
		  	document.forms[0].cmddelete.disabled=true;
		  	document.forms[0].cmdsave.disabled=true;
		  	document.forms[0].cmdcancel.disabled=true;
		  	document.forms[0].cmdclose.disabled=false;
	 	}
	 	else
	 	{
			document.forms[0].cmdedit.disabled=true;
			document.forms[0].cmddelete.disabled=false;
			document.forms[0].cmdsave.disabled=false;
			document.forms[0].cmdcancel.disabled=false;
			//document.forms[0].cmdcomments.disabled=false;
			if(document.forms[0].appno.value != "new")
			{
				document.forms[0].cmdclose.disabled=true;
			}
			else
			{
				document.forms[0].cmdclose.disabled=false;
				document.forms[0].cmddelete.disabled=true;
				document.forms[0].cmdcancel.disabled=true;
			}
		}
		disableFields(false);
	}
}
function onLoading()
{
	if(selcomments=="")
	{
		document.forms[0].sel_commentstype.value="s";
	}
	else
	{
		document.forms[0].sel_commentstype.value=selcomments;
		
	}				
	 //disableCommandButtons("load");
	 disableFields(true);
	 EditorEnableDisable("id_div","block","id_editor","none");
	 getDetails();
	 changeConsitut();
}
function doEdit()
{
	disableFields(false);
	document.forms[0].hidAction.value ="update";
	disableCommandButtons("edit");
	EditorEnableDisable("id_div","none","id_editor","block");
	editor_generate('txt_comments');
	//changeConsitut();
}
function disableFields(val)
{
	  for(var i=0;i<document.forms[0].length;i++)
	  {
		  
		  if(document.forms[0].elements[i].type=='textarea'  )
		  {
			document.forms[0].elements[i].readOnly=val;
		  }
		  if(document.forms[0].elements[i].type=='text'  )
		  {
			document.forms[0].elements[i].readOnly=val;
		  }
		  
	  }
	  document.forms[0].sel_constitchanges.disabled=val;  
	}
function doCancel()
{   
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="compro";
		document.forms[0].hidBeanMethod.value="updateFinancialComments";
		document.forms[0].hidBeanGetMethod.value="getFinancialComments";
		document.forms[0].action=appURL+"action/com_managementinfo.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
}

function getCollData()
{
	document.forms[0].hidBeanId.value="compro";
	document.forms[0].hidBeanGetMethod.value="getFinancialComments";
	document.forms[0].action=appURL+"action/com_managementinfo.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
	onLoading();
}
function doComments()
{
	var strAppno =appno;
	var pagetype = document.forms[0].hidCommentPage.value;
	var prop = "scrollbars=yes,width=750,height=550,top=25,left=180";
	var url=appURL+"action/com_comments.jsp?hidBeanId=comproposal&hidBeanGetMethod=getDataComments&pagetype="+pagetype+"&strAppno="+strAppno;
	window.open(url,"Comments",prop);
}
function getDetails(){
	var position=document.forms[0].sel_commentstype.value;
	if(position=="5"||position=="6")
	{
			document.all.tabid_valuerlist.style.display="table";
			document.all.idKeyPerson2.style.display="none";
			document.all.tabid_constitChange.style.display="none";
	}
	else if(position=="15")
	{
		document.all.tabid_valuerlist.style.display="none";
		document.all.idKeyPerson2.style.display="table";
		document.all.tabid_constitChange.style.display="none";
	}
	else if(position=="17")
	{
		document.all.tabid_valuerlist.style.display="none";
		document.all.idKeyPerson2.style.display="none";
		document.all.tabid_constitChange.style.display="table";

		document.forms[0].sel_constitchanges.value=COM_CHANGECONST;
	}
	else 
	{
		document.all.tabid_valuerlist.style.display="none";
		document.all.idKeyPerson2.style.display="none";
		document.all.tabid_constitChange.style.display="none";
	}
			
			
}
function Addvaluer(tabid){

	if(document.forms[0].cmdedit.disabled==true)
	{	
	var tab  = document.getElementById(tabid);
	var rowsLength = tab.rows.length;
	if(rowsLength<=201)
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
			var new_CellElement=new_RowCell.childNodes[0];
			new_RowCell.align="center";
			for(var j=0;j<new_RowCell.childNodes.length;j++)
			{
				if(new_RowCell.childNodes[j].type=="text")
				{
					new_RowCell.childNodes[j].value="";
					new_RowCell.childNodes[j].readOnly=false;
				}
				else if(new_RowCell.childNodes[j].type=="textarea")
				{
					new_RowCell.childNodes[j].value="";
					new_RowCell.childNodes[j].readOnly=false;
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
					 if(tabid=="tabid_valuerlist" && rowsLength=="2")
					{
						document.forms[0].txt_domestic.value="";  
						document.forms[0].txt_domesticplace.value="";
						document.forms[0].txt_overseas.value="";  
						document.forms[0].txt_overseasplace.value="";    
					    chkbox.checked=false; 
					    return;
					}
				 	else if(tabid=="idKeyPerson2" && rowsLength=="2")
					{
						document.forms[0].txt_name.value="";  
						document.forms[0].txt_age.value="";
						document.forms[0].txt_qualification.value="";  
						document.forms[0].txt_experience.value="";    
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

function changeConsitut(){
	if(document.forms[0].sel_constitchanges.value=="N")
    {
	document.forms[0].txt_comments.value="";
	document.all.id_comments.style.visibility="hidden";
    document.all.id_comments.style.position="absolute";
	document.all.id_comments1.style.visibility="hidden";
    document.all.id_comments1.style.position="absolute";
	//document.forms[0].txt_comments.disabled=true;
	}
	else{
	document.all.id_comments.style.visibility="visible";
	document.all.id_comments.style.position="relative";
	document.all.id_comments1.style.visibility="visible";
    document.all.id_comments1.style.position="relative";
	//document.forms[0].txt_comments.disabled=false;
	}
}
</script>

</head>
<body onload="onLoading()">
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
	<form method = post class="normal">
	<%if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../com/postsanctionlinks.jsp" flush="true">
			<jsp:param name="pageid" value="1" />
			<jsp:param name="subpageid" value="118" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<%}else{ %>
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr> 
			<td valign="top"> 
              <jsp:include page="../share/applurllinkscom.jsp" flush="true"> 
              <jsp:param name="pageid" value="1" />
			   <jsp:param name="cattype" value="<%=strCategoryType%>" />
			  <jsp:param name="ssitype" value="<%=strSSIType%>" />
			
              </jsp:include>
            </td>
          </tr>          
        </table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
<tr>
<%
String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
if(strSessionModuleType.equalsIgnoreCase("AGR")){
%>
		<td class="page_flow">Home -&gt; Agriculture -&gt;
		 Application -&gt; Applicant -&gt; Facilities</td>
<%}else{ %>
<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt;Application -&gt; Applicant -&gt; Management Information</td>
<%}%>
</tr>
</table>
		 
<span style="display:none;"><lapschoice:borrowertype /></span><lapschoice:application />
<lapstab:ComfacilityTab tabid="5"/>
<%} %>
<br>
 <table width="98%" align="center" border="0" cellspacing="0" cellpadding="0" class="outertable border1">
<tr>
<td>
<br>
    <table width="90%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
  <tr> 
    <td width="20%" nowrap="nowrap"><b>Comments On <span class="mantatory">*</span></b>&nbsp;
    <select name="sel_commentstype" tabindex="1" onchange="getCollData();getDetails()">
		<option value="s" selected>----select----</option>
		<option value="1">Management</option>
		<option value="2">Activity</option>
		<option value="3">Product/Services</option>
		<option value="4">Manufacturing Process</option>
		<option value="5">Details of Suppliers</option>
		<option value="6">Details of Buyers</option>
		<option value="7">Others</option>
		<option value="8">Memorandum and Articles of Association</option>
		<option value="9">Partnership / Reconstitution deed</option>
		<option value="10">Trust deed / bye Laws</option>]
		<option value="11">Search Report from ROC</option>
		<option value="12">Production & Infrastructural Facilities</option> 
		<option value="13">Raw Material</option>
		<option value="14">Selling & Marketing Arrangements</option>
		<option value="15">Details of Key Managerial Persons other than directors/promoters</option>
		<option value="16">Sourcing of Proposal & Market Enquiry</option>
		<option value="17">Any Change in constitution of the applicant?</option>
		</select>
    </td>
  </tr>  
  <tr><td>&nbsp;</td> </tr>  
  <tr>
			<td>
  			<table width="90%" border="0"   class="outertable"  align="center" cellpadding="4"  id="tabid_valuerlist">
  			<tr class="dataheader"  >
						<td width="5%" align="center"><span style=""><a onClick="Addvaluer('tabid_valuerlist');"><img
							src="<%=ApplicationParams.getAppUrl()%>img/add.png"
							border="0" tabindex="38"></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					 		<a onClick="deleteRow1('tabid_valuerlist','0');"><img
							src="<%=ApplicationParams.getAppUrl()%>img/cancel.png"
							border="0"></a> </span> </td>
						<td width="20%" align="center"> Domestic</td>
						<td  width="20%" align="center"> Place</td>
						<td width="20%" align="center"> Overseas</td>
						<td  width="20%" align="center"> Place</td>
				</tr>
			 <%if(arrRow!=null && arrRow.size()>0){ 
					for(int i=0;i<arrRow.size();i++){
					arrCol=(ArrayList)arrRow.get(i);%>
				<tr id="0">	
					<td width="5%" class="datagrid" align="center"><input type="checkbox" name="chk1" style="border: none;"></td>	
					<td width="20%" class="datagrid" align="center"><input type="text" name="txt_domestic" value="<%=Helper.correctNull((String)arrCol.get(1)) %>" size="50" onkeydown="allowAlphaNumeric();"></td>
					<td width="20%" class="datagrid" align="center"><input type="text" name="txt_domesticplace" value="<%=Helper.correctNull((String)arrCol.get(2)) %>" size="50" onkeydown="allowAlphaNumeric();">
					</td>
					<td width="20%" class="datagrid" align="center"><input type="text" name="txt_overseas" value="<%=Helper.correctNull((String)arrCol.get(5)) %>" size="50" onkeydown="allowAlphaNumeric();"></td>
					<td width="20%" class="datagrid" align="center"><input type="text" name="txt_overseasplace" value="<%=Helper.correctNull((String)arrCol.get(6)) %>" size="50" onkeydown="allowAlphaNumeric();">
					</td>
				
				</tr>
				<%}}else{ %>
				<tr id="0">	
					<td width="5%" class="datagrid"  align="center"><input type="checkbox" name="chk1" style="border: none;"></td>	
					<td width="20%" class="datagrid" align="center"><input type="text" name="txt_domestic" size="50" onkeydown="allowAlphaNumeric();"></td>
					<td width="20%" class="datagrid" align="center"><input type="text" name="txt_domesticplace" size="50" onkeydown="allowAlphaNumeric();"></td>
					<td width="20%" class="datagrid" align="center"><input type="text" name="txt_overseas" size="50" onkeydown="allowAlphaNumeric();"></td>
					<td width="20%" class="datagrid" align="center"><input type="text" name="txt_overseasplace" size="50" onkeydown="allowAlphaNumeric();">
					</td>
				
				</tr>
				<%} %>
				</table>
				
  			<table width="90%" border="0"   class="outertable"  align="center" cellpadding="4"  id="idKeyPerson2">
  			 <tr class="dataheader"  >
						<td width="5%" align="center"><span style=""><a onClick="Addvaluer('idKeyPerson2');"><img
							src="<%=ApplicationParams.getAppUrl()%>img/add.png"
							border="0" tabindex="38"></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					 		<a onClick="deleteRow1('idKeyPerson2','0');"><img
							src="<%=ApplicationParams.getAppUrl()%>img/cancel.png"
							border="0"></a> </span> </td>
						<td width="20%" align="center"> Name</td>
						<td  width="20%" align="center"> Age</td>
						<td width="20%" align="center"> Qualification</td>
						<td  width="20%" align="center"> Experience</td>
				</tr>
			 <%if(arrRow!=null && arrRow.size()>0){ 
					for(int i=0;i<arrRow.size();i++){
					arrCol=(ArrayList)arrRow.get(i);%>
				<tr id="0">	
					<td width="5%" class="datagrid" align="center"><input type="checkbox" name="chk2" style="border: none;"></td>	
					<td width="20%" class="datagrid" align="center"><input type="text" name="txt_name" value="<%=Helper.correctNull((String)arrCol.get(1)) %>" size="50" onkeydown="allowAlphaNumeric();"></td>
					<td width="20%" class="datagrid" align="center"><input type="text" name="txt_age" value="<%=Helper.correctNull((String)arrCol.get(2)) %>" onkeydown="allowNumber(this);" size="4"  maxlength="3">
					</td>
					<td width="20%" class="datagrid" align="center"><textarea name="txt_qualification" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"  cols="50" rows="3"><%=Helper.correctNull((String)arrCol.get(5)) %></textarea></td>
					<td width="20%" class="datagrid" align="center"><textarea name="txt_experience" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"  cols="50" rows="3"><%=Helper.correctNull((String)arrCol.get(6)) %></textarea></td>
				
				</tr>
				<%}}else{ %>
				<tr id="0">	
					<td width="5%" class="datagrid"  align="center"><input type="checkbox" name="chk2" style="border: none;"></td>	
					<td width="20%" class="datagrid" align="center"><input type="text" name="txt_name" onkeydown="allowAlphaNumeric();"  size="50"></td>
					<td width="20%" class="datagrid" align="center"><input type="text" name="txt_age" onkeypress="allowNumber(this);"  size="4" maxlength="3"></td>
					<td width="20%" class="datagrid" align="center"><textarea name="txt_qualification" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"  cols="50" rows="3"></textarea></td>
					<td width="20%" class="datagrid" align="center"><textarea name="txt_experience" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"  cols="50" rows="3"></textarea></td>
				
				</tr>
				<%} %>
				</table>
				
				
				<table width="90%" border="0"   class="outertable"  align="center" cellpadding="4"  id="tabid_constitChange">
  					<tr>
  						<td>Any Change in constitution of the applicant &nbsp;&nbsp;
  						<select name="sel_constitchanges" onchange="changeConsitut();"> 
							<option value=""> --select--</option>  						
							<option value="Y">Yes</option>  						
							<option value="N">No</option>  						
  						</select>
  						</td>
  					</tr>
  				</table>
  			
				
				</td></tr>
				<tr><td>&nbsp;</td> </tr> 
  <tr class="dataheader" id="id_comments1"> 
    <td width="20%"> Comments</td>
    </tr>
   <tr class="datagrid" id="id_comments"> 
    <td width="60%"> 
      <div id="id_div"><div class="EditorClassNew"> <%=Helper.correctNull((String)hshValues.get("comments")) %></div></div>
					 <div id="id_editor">
				
      <textarea name="txt_comments" cols="100"  rows="8" tabindex="2" wrap="VIRTUAL" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("comments"))%></textarea></div>
 </td>
 </tr>
 </table>
  <br>

 </td>
 </tr>
 </table>
 <br> 
<lapschoice:combuttonnew btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' btnnames='Edit_Save_Cancel_Delete_Audit Trail'/>
<input type="hidden" name="hidPage" value="MangementInfo">
<input type="hidden" name="hidBeanId" value="">
 <input type="hidden" name="hidBeanMethod" value=""> 
 <input type="hidden" name="hidBeanGetMethod" value=""> 
<input type="hidden" name="hidAction" value="">
<input type="hidden" name="hidSourceUrl" value=""> 
<!--<input type="hidden" name="hidCommentPage" value="finposition">-->
<br>
</form>
</body>
</html>