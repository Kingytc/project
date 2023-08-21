<%@include file="../share/CKEditor.jsp"%>

<%@include file="../share/directives.jsp"%>
<%
	ArrayList arrRow = new ArrayList();
	ArrayList arrCol = new ArrayList();
	arrRow = (ArrayList) hshValues.get("arrRow");
	%>
<%
	String strSessionModule = "";
	strSessionModule = Helper.correctNull((String) session
			.getAttribute("sessionModuleType"));
	if(strCategoryType.equalsIgnoreCase(""))
	{
	 strCategoryType = Helper.correctNull((String) request.getParameter("cattype"));
	}
%>
<html>
<head>
<title>Gist Proposal</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var appstatus="<%=Helper.correctNull((String) request
							.getParameter("appstatus"))%>";
var varsel_finposition="<%=Helper.correctNull((String) hshValues
									.get("fieldstrSrno"))%>";
									
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
	if(ConfirmMsg(101))
	{
	document.forms[0].hidAction.value="delete";
	document.forms[0].hidBeanId.value="compro";
    document.forms[0].hidBeanMethod.value="update_Management";
	document.forms[0].hidBeanGetMethod.value="get_Management";
    document.forms[0].action=appURL+"controllerservlet";
    document.forms[0].hidSourceUrl.value="/action/com_management.jsp";	 
	document.forms[0].submit();
	}
}
function doSave()
{
		   if(document.forms[0].sel_finposition.value=="0")
		   {
			   alert("Please Choose Type of Comments");
			   document.forms[0].sel_finposition.focus();
			   if(varsel_finposition=="")
				 {
			     document.forms[0].sel_finposition.value="0";		 
				 }
				 else
				 {
				 document.forms[0].sel_finposition.value=varsel_finposition;
				 }
			   EditorEnableDisable("id_div","block","id_editor","none");
			   return;
		   }
		   document.forms[0].cmdsave.disabled = true;
		   document.forms[0].hidAction.value ="update";
	       document.forms[0].hidBeanId.value="compro";
	       document.forms[0].hidBeanMethod.value="update_Management";
		   document.forms[0].hidBeanGetMethod.value="get_Management";
	       document.forms[0].action=appURL+"controllerservlet";
	       document.forms[0].hidSourceUrl.value="/action/com_management.jsp";	    
	       document.forms[0].submit();
		

}
function doCancel()
{
if(ConfirmMsg(102))
	{
	document.forms[0].hidBeanId.value="compro";
	document.forms[0].hidBeanGetMethod.value="get_Management";
	document.forms[0].action=appURL+"action/com_management.jsp";	
	document.forms[0].submit();
	}
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
	 	  	document.forms[0].cmddelete.disabled=false;
		  	document.forms[0].cmdsave.disabled=true;
		  	document.forms[0].cmdcancel.disabled=true;
		  	document.forms[0].cmdclose.disabled=false;
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
	 disableFields(true);
	 if(varsel_finposition=="")
	 {
     document.forms[0].sel_finposition.value="0";		 
	 }
	 else
	 {
	 document.forms[0].sel_finposition.value=varsel_finposition;
	 }
	 EditorEnableDisable("id_div","block","id_editor","none");
	 getClearanceCredit();
}
function doEdit()
{

	disableFields(false);
	document.forms[0].hidAction.value ="update";
	disableCommandButtons("edit");
	EditorEnableDisable("id_div","none","id_editor","block");
	editor_generate('txt_comments');
	document.forms[0].txt_creditdate.readOnly=true;
	document.forms[0].txt_emaildate.readOnly=true;
}
function disableFields(val)
{
	  for(var i=0;i<document.forms[0].length;i++)
	  {
		  
		  if(document.forms[0].elements[i].type=='textarea'  )
		  {
			document.forms[0].elements[i].readOnly=val;
		  }
		  
	  }
	  
	}
function callLink1(page,bean,method)
{
	if(document.forms[0].cmdsave.disabled==true)
	{
	 document.forms[0].hidAction.value="";
	 document.forms[0].hidBeanGetMethod.value=method;
	 document.forms[0].hidBeanId.value=bean;
	 document.forms[0].action=appURL+"action/"+page;
	 document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
		return;
	}
	
}
function callLink(page,bean,method,pagetype)
{

	if(document.forms[0].cmdsave.disabled==true)
	{
	 	document.forms[0].hidAction.value="";
	 	document.forms[0].hidBeanGetMethod.value=method;
	 	document.forms[0].hidBeanId.value=bean;
	 	document.forms[0].hidpage.value=pagetype;
	 	document.forms[0].action=appURL+"action/"+page;
	 	document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
		return;
	}
	
}
function getComments()
{
	var varfinposition=document.forms[0].sel_finposition.value;

	document.forms[0].hidBeanId.value="compro";
	//document.forms[0].hidBeanMethod.value="update_Management";
	document.forms[0].hidBeanGetMethod.value="get_Management";
	document.forms[0].action=appURL+"action/com_management.jsp";	
	document.forms[0].method="post";
	document.forms[0].submit();
}
function callCalender(val)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		if(document.forms[0].txt_creditdate.value=="")
		{
			alert("Enter Credit approval GRID date in Basic Information tab");
			return;
		}
		 showCal(appUrl,val);
	}
}

function getClearanceCredit(){
	var position=document.forms[0].sel_finposition.value;
	if(position=="22"){
			document.all.idcreditdatetxt.style.visibility="visible";
			document.all.idcreditdatetxt.style.position="relative";
			document.all.idtxtObservation.style.visibility="visible";
			document.all.idtxtObservation.style.position="relative";
			document.all.tabid_valuerlist.style.visibility="visible";
			document.all.tabid_valuerlist.style.position="relative";
			
			
	}
	else{
		document.all.idcreditdatetxt.style.visibility="hidden";
		document.all.idcreditdatetxt.style.position="absolute";
		document.all.idtxtObservation.style.visibility="hidden";
		document.all.idtxtObservation.style.position="absolute";
		document.all.tabid_valuerlist.style.visibility="hidden";
		document.all.tabid_valuerlist.style.position="absolute";
		
		
		
	}
			
			
}

function Addvaluer(){

	if(document.forms[0].cmdedit.disabled==true)
	{	
	var tab  = document.getElementById("tabid_valuerlist");
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
			var new_CellElement=new_RowCell.childNodes[0];
			if(i==0)
	        {
	        	new_RowCell.align="center";
	        }
			for(var j=0;j<new_RowCell.childNodes.length;j++)
			{
				if(new_RowCell.childNodes[j].type=="textarea")
				{
					new_RowCell.childNodes[j].value="";
					new_RowCell.childNodes[j].disabled=false;
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
					 if(tabid=="tabid_valuerlist" && rowsLength=="1")
					{
						document.forms[0].txt_Observation.value="";  
						document.forms[0].txt_Compliance.value="";  
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



function deleteRow(tableid)
{
	if(document.forms[0].cmdedit.disabled==true)
	{
		var table=document.getElementById(tableid);
		var rowCount=table.rows.length; 
		
		if(rowCount==1){
	       alert("Atleast one data is needed");
	       return;
		}
		else{
			 table.deleteRow(rowCount-1);
		}
	}
}



</script>

</head>
<body onload="onLoading()">
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
<form method=post class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td valign="top"><jsp:include page="../com/proposallinks.jsp"
			flush="true">
			<jsp:param name="pageid" value="22" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="1" cellpadding="3">
	<%
		if (strSessionModule.equalsIgnoreCase("corp")) {
	%>
	<tr>

		<td class="page_flow">Home -&gt; Corporate & SME -&gt;
		Proposal -&gt; Exposure to Industry / Other Info -&gt; Management/Other Details</td>
	</tr>
	<%
		} else {
	%>
	<tr>

		<td class="page_flow">Home -&gt; Agriculture -&gt; Application
		-&gt; Other Info -&gt; Management/Other Details</td>
	</tr>
	<%
		}
	%>
</table>
<span style="display: none;"><lapschoice:borrowertype /></span><lapschoice:application />
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<table width="50%" border="0" cellspacing="1" cellpadding="3">
			<tr align="center">
<td width="13%" height="14" class="sub_tab_inactive" nowrap="nowrap"> <a href="javascript:callLink1('com_Exposuretoindustry.jsp','comproposal','getExposureIndustry')">Exposure to Industry</a></td>
				<td width="13%" class="sub_tab_inactive" nowrap="nowrap"><a
					href="javascript:callLink('com_industryanalysis.jsp','compro','get_Others','Industry')">Industry
				analysis</a></td>
				<td width="12%" height="14" class="sub_tab_inactive" nowrap="nowrap">
				<a
					href="javascript:callLink1('com_swotanalysis.jsp','compro','get_swotanalysis')">Swot
				Analysis</a></td>
				<td width="13%" class="sub_tab_inactive" nowrap="nowrap"><a
					href="javascript:callLink1('com_interfirmcomp.jsp','comassestsliab','getInterfirmComp')">Inter
				Firm Comparsion</a></td>
				<td width="12%" height="14" class="sub_tab_active" nowrap="nowrap">Other
				Details</a></td>
			</tr>
		</table>
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="5"
	align="center" class="outertable">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="outertable">
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="5"
					class="outertable" align="center">
					<tr>
						<td valign="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="0"
							class="outertable">
							<tr>
								<td valign="top">
								<table width="100%" border="0" cellspacing="0" cellpadding="3"
									class="outertable border1" align="center">
									<tr>
										<td>
										<table width="90%" border="0" cellspacing="0" cellpadding="4"
											class="outertable" align="center">
											<tr>
												<td>Comments <b><span class="mantatory">*</span></b></td>
												<td align="left"><select name="sel_finposition"
													onChange="getComments();getClearanceCredit()">
													<option value="0" selected>--Select--</option>
													<option value="8">CMC Clearance</option>
													<option value="9">Account clearance</option>
													<option value="10">Others</option>
													<option value="17" title="Impact of Government Policy on the Industry and Applicant/Borrower Company">Impact of Government Policy on the Industry and Applicant/Borrower Company</option>
													<option value="18">Other Service Charges and Processing Charges</option>
													<option value="19" title="Un - hedged Foreign Currency Exposure Position">Un - hedged Foreign Currency Exposure Position</option>
													<option value="20" title="Comments on whether Account marked under Exit Policy">Comments on whether Account marked under Exit Policy</option>
													<option value="21" title="Comments on availability of Personal Guarantee of Promoters/Directors">Comments on availability of Personal Guarantee of Promoters/Directors</option>
													<option value="22" >Clearance by Credit Approval Grid</option>
													<option value="11">ALCO clearance</option>
													<option value="12">Period of renewal</option>
													<option value="13">Comment on Pricing of the facilities</option>
													<option value="23">Comment on Request for Gold Card Status</option>
													<option value="16">Other information</option>
													<option value="24">Comment on Rating</option>
												</select></td>
											</tr>
										</table>
											</td></tr>
											<tr>
											<td>
											<table id="idcreditdate" width="90%" border="0" cellspacing="0" cellpadding="4"
											class="outertable" align="center">
											<tr id="idcreditdatetxt" >
									 <td width="20%">Credit Approval grid meeting dated</td>
										<td width="21%" >
										<input type="text" name="txt_creditdate" readonly="readonly"
													size="16"
													onBlur="checkDate(this);"
													value="<%=Helper.correctNull((String) hshValues.get("com_griddate"))%>">
												</td>
											<td id="idemaildate" width="20%">observations received vide email dated</td>
											<td width="41%" ><input type="text" name="txt_emaildate" readonly="readonly"
													size="16"
													onBlur="checkDate(this);checkmindate(this,document.forms[0].txt_creditdate.value);checkmaxdate(this,currentDate)"
													value="<%=Helper.correctNull((String) hshValues.get("COM_DACCODATE"))%>">
												<a alt="Select date from calender" 
													href="#" onClick="callCalender('txt_emaildate')"
													onMouseOver="window.status='Date Picker';return true;"
													onMouseOut="window.status='';return true;"><img
													src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
													border="0" alt="Select date from calender"></a></td>
													
													
											</tr>
										</table>
			</td></tr>
			<tr>
			<td>
				<table width="90%" id ="idtxtObservation"  border="0"   cellpadding="4"  class="outertable" align="center">
				  <tr class="dataheader"  >
						<td width="5%" align="center"><span style=""><a onClick="Addvaluer();"><img
							src="<%=ApplicationParams.getAppUrl()%>img/add.png"
							border="0" tabindex="38"></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					 		<a onClick="deleteRow1('tabid_valuerlist','0');"><img
							src="<%=ApplicationParams.getAppUrl()%>img/cancel.png"
							border="0"></a> </span> </td>
						<td width="50%" align="center"> OBSERVATIONS</td>
						<td  width="45%" align="center"> COMPLIANCE</td>
				</tr>
				</table>
				</td></tr>
				<tr>
			<td>
				<table width="90%" border="0"   class="outertable"  align="center" cellpadding="3" id="tabid_valuerlist">
			 <%if(arrRow!=null && arrRow.size()>0){ 
					for(int i=0;i<arrRow.size();i++){
					arrCol=(ArrayList)arrRow.get(i);%>
				<tr id="0">	
					<td width="5%" class="datagrid"><input type="checkbox" name="chk1" style="border: none;"></td>	
					<td width="50%" class="datagrid"><textarea name="txt_Observation"
													cols="100" rows="6" onKeyPress="textlimit(this,499)" onKeyUp="textlimit(this,499)"><%=Helper.correctNull((String)arrCol.get(1)) %></textarea></td>
					<td width="45%" class="datagrid"><textarea name="txt_Compliance"
													cols="100" rows="6" onKeyPress="textlimit(this,499)" onKeyUp="textlimit(this,499)"> <%=Helper.correctNull((String)arrCol.get(2)) %></textarea>
					</td>
				
				</tr>
				<%}}else{ %>
				<tr id="0">	
					<td width="5%" class="datagrid"><input type="checkbox" name="chk1" style="border: none;"></td>	
					<td width="50%" class="datagrid"><textarea name="txt_Observation"	cols="80" rows="5" onKeyPress="textlimit(this,499)" onKeyUp="textlimit(this,499)"> </textarea></td>
					<td width="45%" class="datagrid"><textarea name="txt_Compliance" cols="80" rows="5" onKeyPress="textlimit(this,499)" onKeyUp="textlimit(this,499)">
         		     </textarea>
					</td>
				
				</tr>
				<%} %>
				</table>
				<table width="90%" border="0"   class="outertable"  align="center" cellpadding="3" id="tabid_valuerlist1">
			 
					<tr>
												<td colspan="2">
												<div id="id_div">
												<div class="EditorClassNew"><%=Helper.correctNull((String) hshValues.get("comments"))%></div>
												</div>
												<div id="id_editor"><textarea name="txt_comments" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"
													cols="150" rows="12">
         		     <%=Helper.correctNull((String) hshValues.get("comments"))%>
              </textarea></div>
												</td>
											</tr>
				
				
				</table>
				</td> 
				</tr>
				</table>
                 </td>	</tr>
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
<lapschoice:combuttonnew
	btnenable='<%=Helper.correctNull((String) request
							.getParameter("btnenable"))%>'
	btnnames='Edit_Save_Cancel_Delete_Audit Trail' /> <input type="hidden"
	name="hidPage" value="gist"> <input type="hidden"
	name="hidBeanId" value=""> <input type="hidden"
	name="hidBeanMethod" value=""> <input type="hidden"
	name="hidBeanGetMethod" value=""> <input type="hidden"
	name="hidAction" value=""> <input type="hidden"
	name="hidSourceUrl" value=""> <input type="hidden"
	name="hidpage" value="Industry">
		<input type="hidden" name="cattype" value="<%=strCategoryType%>">
	</form>
</body>
</html>