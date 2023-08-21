<%@include file="../share/CKEditor.jsp"%>
<%@include file="../share/directives.jsp"%>
<%
String strPropformat=Helper.correctNull((String)session.getAttribute("Propformat"));
ArrayList arrRow=new ArrayList(); 
ArrayList arrCol=new ArrayList();
arrRow = (ArrayList) hshValues.get("arrRow"); 

%>
<html>
<head>
<title>Ratification</title>
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
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>ckeditor/ckeditor.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var appstatus="<%=Helper.correctNull((String) request.getParameter("appstatus"))%>";
var selratification="<%=Helper.correctNull((String) hshValues.get("selratification"))%>";
var varSanctioningDept="<%=Helper.correctNull((String) hshValues.get("strSanctioningDept"))%>";
var varOrgLevel="<%=Helper.correctNull((String) session.getAttribute("strOrgLevel"))%>";
function doClose()
{
	if( ConfirmMsg(100) )
	{
		document.forms[0].method="post";
        document.forms[0].hidBeanId.value="executive";
	    document.forms[0].action=appURL+"action/"+"corppge.jsp";	
		document.forms[0].submit();
	}
}

function doDelete()
{
	if(ConfirmMsg(101))
	 {
	document.forms[0].hidAction.value ="delete";
	document.forms[0].hidBeanId.value="executive";
    document.forms[0].hidPage.value="ratification";
	document.forms[0].hidBeanMethod.value="updateRatificationComments";
	document.forms[0].hidBeanGetMethod.value="getRatificationComments";
	document.forms[0].hidSourceUrl.value="action/com_ratification.jsp";	
	document.forms[0].method="post";
	document.forms[0].action=appURL+"action/controllerservlet";	
	document.forms[0].submit();
	 }
}
function doSave()
{ 	
		document.forms[0].cmdsave.disabled = true;
	    document.forms[0].hidAction.value="update"
	    document.forms[0].hidBeanId.value="executive";
	    document.forms[0].hidPage.value="ratification";
		document.forms[0].hidBeanMethod.value="updateRatificationComments";
		document.forms[0].hidBeanGetMethod.value="getRatificationComments"
		document.forms[0].hidSourceUrl.value="/action/com_ratification.jsp";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
}

function doEdit()
{

	disableFields(false);
	//document.forms[0].hidAction.value ="update";
	disableCommandButtons("edit");
	EditorEnableDisable1("id_div","none","id_editor","block");
	editor_generate('txt_comments');
}
function disableCommandButtons(val)
{
	if(val=="load")
	{
		if(appstatus=="Open/Pending")	 
	  	{
		if(document.forms[0].btnenable.value =='Y')
	  	{

			document.forms[0].cmdedit.disabled=false;
	 	  	document.forms[0].cmddelete.disabled=true;
		  	document.forms[0].cmdsave.disabled=true;
		  	document.forms[0].cmdcancel.disabled=true;
		  	document.forms[0].cmdclose.disabled=false;
		  	
			
	 	}
		else
		{
			//document.forms[0].cmdnew.disabled=true;
		  	document.forms[0].cmdedit.disabled=true;
		  	document.forms[0].cmddelete.disabled=true;
		  	document.forms[0].cmdsave.disabled=true;
		  	document.forms[0].cmdcancel.disabled=true;
		  	document.forms[0].cmdclose.disabled=false;
	  	}
	  	}
	 	else
	 	{
	 		//document.forms[0].cmdnew.disabled=true;
		  	document.forms[0].cmdedit.disabled=true;
		  	document.forms[0].cmddelete.disabled=true;
		  	document.forms[0].cmdsave.disabled=true;
		  	document.forms[0].cmdcancel.disabled=true;
		  	document.forms[0].cmdclose.disabled=false;
	 	}
	}
	if(val=="edit")
	{
		if(document.forms[0].btnenable.value =='Y')
	  	{
			//document.forms[0].cmdnew.disabled=true;
			document.forms[0].cmdedit.disabled=true;
			document.forms[0].cmddelete.disabled=false;
			document.forms[0].cmdsave.disabled=false;
			document.forms[0].cmdcancel.disabled=false;
			document.forms[0].cmdclose.disabled=false;
			document.forms[0].cmddelete.disabled=false;
			
		  	
	 	}
	 	else
	 	{
	 		document.forms[0].cmdedit.disabled=true;
		  	document.forms[0].cmddelete.disabled=true;
		  	document.forms[0].cmdsave.disabled=true;
		  	document.forms[0].cmdcancel.disabled=true;
		  	document.forms[0].cmdclose.disabled=false;
			
			
		}
		disableFields(false);
	}
	if(val=="disableall")
	{
		if(document.forms[0].btnenable.value =='N')
	  	{
			//document.forms[0].cmdnew.disabled=true;
		  	document.forms[0].cmdedit.disabled=true;
		  	document.forms[0].cmddelete.disabled=true;
		  	document.forms[0].cmdsave.disabled=true;
		  	document.forms[0].cmdcancel.disabled=true;
		  	document.forms[0].cmdclose.disabled=false;
	 	}
	}
}

function onLoading()
{
	if(selratification=="")
	{
		document.forms[0].sel_ratification.value="0";
	}
	else
	{
		document.forms[0].sel_ratification.value=selratification;
		
	}
	if(document.forms[0].hidNonPoolFlag.value=="Y")
	{
		
	}	
	else
	{
		disableCommandButtons("load");
	}
	 disableFields(true);
	 EditorEnableDisable1("id_div","block","id_editor","none");
	 getDetails();

	 if(document.forms[0].sel_ratification.value=="6" && varSanctioningDept!=varOrgLevel)
		{
			document.forms[0].cmdedit.disabled=true;
		}
}

function disableFields(val)
{
	  for(var i=0;i<document.forms[0].length;i++)
	  {
		  
		  if(document.forms[0].elements[i].type=='textarea')
		  {
			document.forms[0].elements[i].readOnly=val;
		  }
		  if(document.forms[0].elements[i].type=='text')
		  {
			document.forms[0].elements[i].readOnly=val;
		  }
		  	  
	  }
	  
}

function doCancel()
{   
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="executive";
	    document.forms[0].hidPage.value="ratification";
		document.forms[0].hidBeanGetMethod.value="getRatificationComments";
		document.forms[0].action=appURL+"action/com_ratification.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
}
function EditorEnableDisable1(name1,val1,name2,val2)
{
	document.getElementById(name1).style.display=val1;
	document.getElementById(name2).style.display=val2;
}
function getData()
{
	document.forms[0].hidBeanId.value="executive";
	document.forms[0].hidBeanGetMethod.value="getRatificationComments";
	document.forms[0].action=appURL+"action/com_ratification.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
	onLoading();
}


function callCalender_mul(name,rowindex,obj) 
{
	var varflag="false";
		var tab  = document.getElementById("tabid_valuerlist");
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
			if(name=="txt_duedate")
			{
				for(var i=0;i<document.all.idcal2.length;i++)
				{
					if(obj==document.all.idcal2[i])
					{
						name="txt_duedate["+(i)+"]";
					}
				}
			}
			if(name=="txt_regulardate")
			{
				for(var i=0;i<document.all.idcal1.length;i++)
				{
					if(obj==document.all.idcal1[i])
					{
						name="txt_regulardate["+(i)+"]";
					}
				}
			}
			if (document.forms[0].cmdsave.disabled == false) 
			{
				showCal(appURL, name);
			}
		}
}


function Addvaluer(tabid)
{
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
				if(new_RowCell.childNodes[j].type=="textarea")
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
						document.forms[0].txt_slno.value="";  
						document.forms[0].txt_accountno.value="";
						document.forms[0].txt_todsancrefno.value="";  
						document.forms[0].txt_todsancamt.value="";  
						document.forms[0].txt_duedate.value="";  
						document.forms[0].txt_regulardate.value="";  
						document.forms[0].txt_reguarcomments.value="";  
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

function getDetails(){
	var position=document.forms[0].sel_ratification.value;

	if(position=="5")
	{
		document.all.tabid_valuerlist.style.display="table";
	}
	else 
	{
		document.all.tabid_valuerlist.style.display="none";
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
	}
}

</script>

</head>
<body onload="onLoading()">
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
	<form method = post class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top" colSpan=5><jsp:include
			page="../com/proposallinks.jsp" flush="true">
			<jsp:param name="pageid" value="27" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />

		</jsp:include></td>
	</tr>
	<tr>
	<%String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim(); %>
	<%if(strSessionModuleType.equals("AGR")){%>
		<td class="page_flow">Home&nbsp;-&gt;&nbsp;Agriculture-&gt;&nbsp;Proposal-&gt;&nbsp;Recommendation/Ratification--&gt;&nbsp;Ratification</td>
	<%}else{%>
		<td class="page_flow">Home&nbsp;-&gt;&nbsp;Corporate&nbsp; &amp; SME -&gt;&nbsp;Proposal-&gt;&nbsp;Recommendation/Ratification--&gt;&nbsp;Ratification</td>
		</td>
		<%} %>		
	</tr>
</table>
		 
<span style="display:none;"><lapschoice:borrowertype /></span><lapschoice:application />
<%if(!strPropformat.equalsIgnoreCase("4")){ %>
<table width="50%" border="0" cellspacing="1" cellpadding="3"> 
	<tr align="center">
		
		 <td width="9%" height="14" class="sub_tab_inactive" nowrap="nowrap">
		 <a href="javascript:callLink1('com_recommendation.jsp','executive','getRecommendationData')">Recommendation</a></td> 
		  <td width="9%" height="14" class="sub_tab_active" nowrap="nowrap">Ratification</td>
		 
	</table>
<%} %>
	
  <table width="100%" border="0" cellspacing="0" cellpadding="5" align="center" class="outertable">
    <tr> 
      <td valign="top"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr> 
            <td valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable" align="center">
                <tr> 
                <td valign="top">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                      <tr> 
                        <td valign="top"> 
                          <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1" align="center" >
                            <tr> 
                             
                                <table width="90%" border="0" cellspacing="0" cellpadding="4" class="outertable border1" align="center" >
                                  <tr>
                                  <td>Ratification On
                                  <select name="sel_ratification" onchange="getData();getDetails();">
								   <option value="0" selected="selected">--Select--</option>
                      				<lapschoice:StaticDataTag apptype="133"/> 
								</select></td>
								</tr>
								
								<tr>
									<td>
							  			<table width="90%" border="0"   class="outertable"  align="center" cellpadding="4"  id="tabid_valuerlist">
							  			<tr class="dataheader" >
													<td width="5%" align="center"><span style=""><a onClick="Addvaluer('tabid_valuerlist');"><img
														src="<%=ApplicationParams.getAppUrl()%>img/add.png"
														border="0" tabindex="38"></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
												 		<a onClick="deleteRow1('tabid_valuerlist','0');"><img
														src="<%=ApplicationParams.getAppUrl()%>img/cancel.png"
														border="0"></a> </span> </td>
													<td  width="15%" align="center"> Account Number</td>
													<td width="15%" align="center"> TOD Sanc. Ref.No</td>
													<td  width="15%" align="center"> TOD Amount</td>
													<td  width="15%" align="center"> Due Date</td>
													<td  width="15%" align="center"> Regularisation date</td>
													<td  width="15%" align="center"> Comments if not regularised</td>
										</tr>	
											
								 <%if(arrRow!=null && arrRow.size()>0){ 
									for(int i=0;i<arrRow.size();i++){
									arrCol=(ArrayList)arrRow.get(i);%>
								<tr id="0">	
									<td width="5%" class="datagrid" align="center"><input type="checkbox" name="chk1" style="border: none;"></td>	
									<td width="15%" class="datagrid" align="center"><input type="text" name="txt_accountno" value="<%=Helper.correctNull((String)arrCol.get(1)) %>"   onKeyPress="allowNumber(this)" >	</td>
									<td width="15%" class="datagrid" align="center"><input type="text" name="txt_todsancrefno" value="<%=Helper.correctNull((String)arrCol.get(2)) %>"  onKeyPress=""></td>
									<td width="15%" class="datagrid" align="center"><input type="text" name="txt_todsancamt" value="<%=Helper.correctNull((String)arrCol.get(3)) %>"   align="right" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);"></td>
									<td width="15%" class="datagrid" align="center">
										<input type="text" name="txt_duedate" value="<%=Helper.correctNull((String)arrCol.get(4)) %>"  onblur="checkDate(this);">
										<a alt="Select date from calender"
											onClick="callCalender_mul('txt_duedate',this.parentNode.parentNode.id,this);"
											onMouseOver="window.status='Date Picker';return true;"
											onMouseOut="window.status='';return true;" id="idcal2"> <img
											src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
											alt="Select date from calender"></a>
									</td>
									<td width="15%" class="datagrid" align="center">
										<input type="text" name="txt_regulardate" value="<%=Helper.correctNull((String)arrCol.get(5)) %>"  onblur="checkDate(this);">
										<a alt="Select date from calender"
											onClick="callCalender_mul('txt_regulardate',this.parentNode.parentNode.id,this);"
											onMouseOver="window.status='Date Picker';return true;"
											onMouseOut="window.status='';return true;" id="idcal1"> <img
											src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
											alt="Select date from calender"></a>
									</td>
									<td class="datagrid">
									<textarea name="txt_reguarcomments"  onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)arrCol.get(6)) %>
                                     </textarea>
									</td>
								
									<!--<td width="15%" class="datagrid" align="center"><input type="text" name="txt_reguarcomments" value="<%=Helper.correctNull((String)arrCol.get(6)) %>" ></td>
								
								--></tr>
								<%}}else{ %>
								<tr id="0">	
									<td width="5%" class="datagrid"  align="center"><input type="checkbox" name="chk1" style="border: none;"></td>	
									<td width="15%" class="datagrid" align="center"><input type="text" name="txt_accountno"  onKeyPress="allowNumber(this)" ></td>
									<td width="15%" class="datagrid" align="center"><input type="text" name="txt_todsancrefno"  onKeyPress="" ></td>
									<td width="15%" class="datagrid" align="center"><input type="text" name="txt_todsancamt"  onkeypress="allowNumber(this)"  onblur="roundtxt(this)" align="right"></td>
									<td width="15%" class="datagrid" align="center"><input type="text" name="txt_duedate"    onblur="checkDate(this);">
										<a alt="Select date from calender"
											onClick="callCalender_mul('txt_duedate',this.parentNode.parentNode.id,this);"
											onMouseOver="window.status='Date Picker';return true;"
											onMouseOut="window.status='';return true;" id="idcal2"> <img
											src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
											alt="Select date from calender"></a>
									</td>
									<td width="15%" class="datagrid" align="center"><input type="text" name="txt_regulardate"   onblur="checkDate(this);">
										<a alt="Select date from calender"
											onClick="callCalender_mul('txt_regulardate',this.parentNode.parentNode.id,this);"
											onMouseOver="window.status='Date Picker';return true;"
											onMouseOut="window.status='';return true;" id="idcal1"> <img
											src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
											alt="Select date from calender"></a>
									</td>
									<td class="datagrid">
									<textarea name="txt_reguarcomments"  onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)">
                                     </textarea>
									</td>
								
								</tr>
								<%} %>			
											
									</table>							
								</td>
							   </tr>
								
								
								
                                  <tr class="dataheader"> 
                                    <td>Comments</td>
                                  </tr>
                                  <tr> 
                                   <td>
            <div id="id_div"><div class="EditorClassNew"> <%=Helper.correctNull((String)hshValues.get("COM_COMMENTS")) %></div></div>
             <div id="id_editor"> <textarea name="txt_comments" cols="110" rows="25" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)">
         		     <%=Helper.correctNull((String)hshValues.get("COM_COMMENTS")) %>
              </textarea></div>
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
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
<lapschoice:combuttonnew btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' btnnames='Edit_Save_Cancel_Delete'/>
<input type="hidden" name="hidPage" value="ratification">
<input type="hidden" name="hidBeanId" value="">
 <input type="hidden" name="hidBeanMethod" value=""> 
 <input type="hidden" name="hidBeanGetMethod" value=""> 
<input type="hidden" name="hidAction" value="">
<input type="hidden" name="hidSourceUrl" value=""> 
</form>  
</body>
</html>