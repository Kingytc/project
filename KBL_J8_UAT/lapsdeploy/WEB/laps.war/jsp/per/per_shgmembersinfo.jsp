<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />

<%

ArrayList arrRow = new ArrayList();
ArrayList arrCol = new ArrayList();
arrRow = (ArrayList)hshValues.get("arrRow");
String strEmployment=(String)session.getAttribute("strEmployment");
String strProfilestatus = Helper.correctNull((String) hshValues.get("strProfilestatus"));
String strPageName=Helper.correctNull((String)hshValues.get("strIncompletepage"));

String pageid = request.getParameter("pageid");
String strapptype = Helper.correctNull((String)request.getParameter("corp"));
String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();

%>	
	
<html>
<head>
<title>Financial particulars  </title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/PageLoadTime.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
var appstatus ="<%=Helper.correctNull((String) hshValues.get("appstatus"))%>";

function disableEditButtons(bool1, bool2, bool3, bool4,  bool6)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool6;
}

function disabledFields(val)
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
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=val;
		}
		if(document.forms[0].elements[i].type=='radio')
		{
			document.forms[0].elements[i].disabled=!val;
		}	
	}
	
}

function doSave()
{  
	for(var i=0;i<document.forms[0].txt_sno.length;i++)
	{
		for(var j=i+1;j<document.forms[0].txt_sno.length;j++)
		{
			if(document.forms[0].txt_cbsid[i].value !="" && document.forms[0].txt_cbsid[j].value != "" && document.forms[0].txt_cbsid[i].value == document.forms[0].txt_cbsid[j].value)
			{
				alert("Same Customer ID occuring multiple times "+document.forms[0].txt_cbsid[i].value);
				return;
			}
		}
	}
	for(var i=0;i<document.forms[0].txt_sno.length;i++)
	{
		if(document.forms[0].txt_cbsid[i].value != "")
		{
			if(document.forms[0].sel_existing[i].value == "S")
			{
				alert("Please fill the Mandatory fields");
				document.forms[0].sel_existing[i].focus();
				return;
			}
			if(document.forms[0].sel_default[i].value == "S")
			{
				alert("Please fill the Mandatory fields");
				document.forms[0].sel_default[i].focus();
				return;
			}
			if(document.forms[0].sel_concerntype[i].value == "S" || document.forms[0].sel_concerntype[i].value == "")
			{
				alert("Please Select Concern Type");
				document.forms[0].sel_concerntype[i].focus();
				return;
			}
		}
	}
	
	disabledFields(false);
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidAction.value="update";
	document.forms[0].hidBeanId.value="commappmaster";
	document.forms[0].hidBeanMethod.value="updateSHGmembersDetail";
	document.forms[0].hidBeanGetMethod.value="getSHGmembersDetail";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/per_shgmembersinfo.jsp";
	document.forms[0].submit();
}


function doEdit()
{
	disableEditButtons(true, false, false, false, false);
	
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=false;
		}	
	}
}

function doCancel()
{   
	if(ConfirmMsg(102))
	{
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidBeanGetMethod.value="getSHGmembersDetail";
		document.forms[0].hidBeanId.value="commappmaster";
		document.forms[0].action=appUrl+"action/per_shgmembersinfo.jsp";
		document.forms[0].submit(); 		
	}
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appUrl+"action/ControllerServlet";	
		document.forms[0].hidBeanId.value="commappmaster";
		document.forms[0].hidSourceUrl.value="action/per_shgmembersinfo.jsp";	
		document.forms[0].hidBeanMethod.value="updateSHGmembersDetail";
		document.forms[0].hidBeanGetMethod.value="getSHGmembersDetail";
		document.forms[0].submit();	
			
	}
}	

function doRemove(varSno)
{
	if(appstatus == "true")
	{
		return;
	}
	if(document.forms[0].cmdedit.disabled==false)
	{
		alert("Please click Edit");
		return;
	}
	if(document.forms[0].txt_cbsid[varSno-1].value == "")
	{
		alert("There is no borrower information to Remove");
		return;
	}
	if(confirm("Do you want to remove this borrower?"))
	{
		document.forms[0].hid_DelSno.value = varSno;
		document.forms[0].hidAction.value ="remove";
		document.forms[0].action=appUrl+"action/ControllerServlet";	
		document.forms[0].hidBeanId.value="commappmaster";
		document.forms[0].hidSourceUrl.value="action/per_shgmembersinfo.jsp";	
		document.forms[0].hidBeanMethod.value="updateSHGmembersDetail";
		document.forms[0].hidBeanGetMethod.value="getSHGmembersDetail";
		document.forms[0].submit();	
	}
}	

function selectExisting(varSno)
{
	if(document.forms[0].sel_existing[varSno].value=="Y")
	{
		document.all.addn_det1[varSno].style.display = "inline";
	}
	else
	{
		document.all.addn_det1[varSno].style.display = "none";
	}
}

function selectDefault(varSno)
{
	if(document.forms[0].sel_default[varSno].value=="Y")
	{
		document.all.addn_det2[varSno].style.display = "inline";
	}
	else
	{
		document.all.addn_det2[varSno].style.display = "none";
	}
}

function onloading()
{
	disabledFields(true);
	if(appstatus=="true")
  	{
		disableEditButtons(true, true, true, true, false);
  	}
  	else
  	{
  		disableEditButtons(false, true, true, true, false);
  	}

	for(var i=0;i<document.forms[0].txt_sno.length;i++)
	{
		if(document.forms[0].sel_existing[i].value=="Y")
		{
			document.all.addn_det1[i].style.display = "inline";
		}
		else
		{
			document.all.addn_det1[i].style.display = "none";
		}
		if(document.forms[0].sel_default[i].value=="Y")
		{
			document.all.addn_det2[i].style.display = "inline";
		}
		else
		{
			document.all.addn_det2[i].style.display = "none";
		}
	}
}

function callCustId(varSno)
{
	if(document.forms[0].cmdedit.disabled==true && appstatus == "false")
	{
		var varQryString = appURL+"action/CBSIDhelp.jsp?varSno="+varSno;
		var title = "SelectCBSID";
		var prop = "scrollbars=yes,menubar=yes,status=yes,width=500,height=400";
		prop = prop + ",left=50,top=150";
	    window.open(varQryString,title,prop);
	}
}

function callDetails(varSno,varType)
{
	if(document.forms[0].cmdsave.disabled==true)
	{
		var varQryString = appURL+"action/per_shg_additionaldetails.jsp?hidBeanId=commappmaster&hidBeanGetMethod=getSHGAddtnDetail&varSno="+varSno+"&varType="+varType+"&hidDemoId="+document.forms[0].hidDemoId.value+"&appstatus="+appstatus;
		var title = "Additional_Details";
		var prop = "scrollbars=yes,menubar=yes,status=yes,width=500,height=400";
		prop = prop + ",left=50,top=150";
	    window.open(varQryString,title,prop);
	}
}

</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onloading()">
<form name="Financial" method="post" class="normal">

<%if(Helper.correctNull((String)session.getAttribute("sessionModuleType")).equals("")) { %>

<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	
	<tr>
		<td class="page_flow">Home -&gt; Customer Profile -&gt; SHG -&gt; Members details</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
		 <table width="98%" border="0" cellspacing="1" cellpadding="3" align="left" class="outertable">
			
			<tr>
				<td><jsp:include page="../share/Cusurllink.jsp" flush="true">
					<jsp:param name="pageid" value="12"/>
					<jsp:param name="employmenttype" value="<%=strEmployment%>" />
					<jsp:param name="strProfilestatus" value="<%=strProfilestatus%>" />
					<jsp:param name="hidincompletedpagename" value="<%=strPageName%>" />
					</jsp:include>
				</td>
			</tr>
		 </table>
		</td>
	</tr>
</table>

<% } else {  %>
<%
if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){ 
if(!strSessionModuleType.equalsIgnoreCase("RET")){%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../com/postsanctionlinks.jsp" flush="true">
			<jsp:param name="pageid" value="1" />
			<jsp:param name="subpageid" value="115" />
			<jsp:param name="subsubpageid" value="12" />
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
			<jsp:param name="subsubpageid" value="12"/>
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<%} %>
<jsp:include page="../share/Cusurllinkdisp.jsp" flush="true">
			<jsp:param name="pageid" value=""/>
			<jsp:param name="subsubpageid" value="12"/>
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
		</jsp:include>
		</td>
	</tr>
</table>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt;Corporate &amp; SME -&gt; Application -&gt; Applicant -&gt; Customer Profile -&gt; SHG </td>
	</tr>
  </table>
  <%} else if(strapptype.equalsIgnoreCase("R")){ %>
 <jsp:include page="../share/Applurllinkper.jsp" flush="true"> 
        <jsp:param name="pageid" value="<%=pageid%>" />
        </jsp:include>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center"  class="outertable">
    <tr> 
      <td class="page_flow">Home -&gt; 
       Retail -&gt; Application -&gt; Applicant/Guarantor -&gt; SHG </td>
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
		<%}%>
		<%if(strapptype.equalsIgnoreCase("C") || strapptype.equalsIgnoreCase("R")){ %>
			<tr>
		<td><jsp:include page="../share/Cusurllinkdisp.jsp" flush="true">
			<jsp:param name="pageid" value="12"/>
			<jsp:param name="employmenttype" value="<%=strEmployment%>" />
			<jsp:param name="demoid" value="<%=strapptype%>" />
		</jsp:include></td>
			</tr>
			<%} %>
		</table>
		</td>
	</tr>
</table>
<%} %>

<% } %>

<table width="50%" border="0" cellspacing="1" cellpadding="3" class="outertable">
	<tr>
		<td>
		<table width="40%" border="0" cellspacing="1" cellpadding="3"
			align="left" class="outertable">
			<tr>
		<td class="sub_tab_inactive" nowrap align="center"><a href="#" onclick="callShg()"
							onMouseOut="window.status='';return true;" onMouseOver="window.status='SHG Details';return true;"> SHG Group info.</a></td>
		 <td class="sub_tab_active" nowrap align="center">Members Detail</td>
         <td class="sub_tab_inactive" nowrap align="center"><a href="#" onclick="callFin()"
							onMouseOut="window.status='';return true;" onMouseOver="window.status='Financial Details';return true;"> 
           	 				Financial Particulars</a>
           </td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br>
<table width="90%" border="1" cellspacing="0" cellpadding="5" class="outertable" align="center">
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="1" cellpadding="5" class="outertable" align="center">
				<tr class="dataheader" align="center">
					<td align="center" width="4%">S.No</td>	
					<td align="center" width="12%">Member CBS ID</td>	
					<td align="center" width="23%">Member Name</td>	
					<td align="center" width="10%">Member DOB</td>	
					<td align="center" width="10%">Member PAN no.</td>	
					<td align="center" width="10%">Concern Sub type</td>	
					<td align="center" width="15%">Existing loans through other SHG where the individual is a member</td>	
					<td align="center" width="15%">If in default, status of the SHG members loan account, if the SHG loan was distributed to him / her</td>	
					<td align="center" width="5%">Remove</td>	
			    </tr>
				
				<%if(arrRow != null && arrRow.size()>0){
					for(int i=0;i<arrRow.size();i++){
						arrCol = (ArrayList)arrRow.get(i);
				
				if(i%2!=0){%>				
				<tr class="datagrid" align="center" >
					<td align="center"><%=i+1%><input type="hidden" name="txt_sno" size="20" value="<%=i+1%>"></td>
					<td align="center" class="LoanSearch pr30"><input type="text" name="txt_cbsid" size="20" value="<%=Helper.correctNull((String)arrCol.get(1))%>" readonly="readOnly" style="width: 110px;">
					<input type="hidden" name="txt_lapsid" size="20" value="<%=Helper.correctNull((String)arrCol.get(2))%>">
					<span onClick="javascript:callCustId(<%=i%>)" style="cursor: hand;position: absolute;right:5px;top:13px"><img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0"></span>
					</td>	
					<td align="center"><input type="text" name="txt_name" size="50" value="<%=Helper.correctNull((String)arrCol.get(3))%>" readonly="readOnly"></td>	
					<td align="center"><input type="text" name="txt_dob" size="20" value="<%=Helper.correctNull((String)arrCol.get(4))%>" readonly="readOnly"></td>	
					<td align="center"><input type="text" name="txt_panno" size="20" value="<%=Helper.correctNull((String)arrCol.get(5))%>" readonly="readOnly"></td>
					<td align="center"><select name="sel_concerntype">
					<option value="S">---select---</option>
					<lapschoice:StaticDataTag apptype="192" />
					</select></td>
					<td align="center"><select name="sel_existing" onChange="selectExisting('<%=i%>')"><option value="S">-- Select --</option><option value="Y">Yes</option><option value="N">No</option></select>
					<a href="#" onClick="javascript:callDetails('<%=i+1%>','EXE')" > <img src="<%=ApplicationParams.getAppUrl()%>/img/nsdl_docview.png"	border="0" id="addn_det1" > </a></td>
					<td align="center"><select name="sel_default" onChange="selectDefault('<%=i%>')"><option value="S">-- Select --</option><option value="Y">Yes</option><option value="N">No</option></select>
					<a href="#" onClick="javascript:callDetails('<%=i+1%>','DEF')" > <img src="<%=ApplicationParams.getAppUrl()%>/img/nsdl_docview.png"	border="0" id="addn_det2"> </a></td>
					<td align="center"><img alt="Click to Delete Member" src="<%=ApplicationParams.getAppUrl()%>img/delete.png" 
									onclick="doRemove('<%=i+1%>')" style="cursor:hand"/>&nbsp;</td>	
			    </tr>
			    <script>
			    	document.forms[0].sel_existing[<%=i%>].value = "<%=Helper.correctNull((String)arrCol.get(6))%>";
			    	document.forms[0].sel_default[<%=i%>].value = "<%=Helper.correctNull((String)arrCol.get(7))%>";
			    	document.forms[0].sel_concerntype[<%=i%>].value = "<%=Helper.correctNull((String)arrCol.get(8))%>";
			    </script>
			    <%}else{ %>
				<tr align="center" class="datagrid">
					<td align="center"><%=i+1%><input type="hidden" name="txt_sno" size="20" value="<%=i+1%>"></td>
					<td align="center" class="LoanSearch pr30"><input type="text" name="txt_cbsid" size="20" value="<%=Helper.correctNull((String)arrCol.get(1))%>" readonly="readOnly" style="width: 110px;">
					<input type="hidden" name="txt_lapsid" size="20" value="<%=Helper.correctNull((String)arrCol.get(2))%>">
					<span onClick="javascript:callCustId(<%=i%>)" style="cursor: hand;position: absolute;right:5px;top:13px"><img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0"></span>
					</td>	
					<td align="center"><input type="text" name="txt_name" size="50" value="<%=Helper.correctNull((String)arrCol.get(3))%>" readonly="readOnly"></td>	
					<td align="center"><input type="text" name="txt_dob" size="20" value="<%=Helper.correctNull((String)arrCol.get(4))%>" readonly="readOnly"></td>	
					<td align="center"><input type="text" name="txt_panno" size="20" value="<%=Helper.correctNull((String)arrCol.get(5))%>" readonly="readOnly"></td>
					<td align="center"><select name="sel_concerntype">
					<option value="S">---select---</option>
					<lapschoice:StaticDataTag apptype="192" />
					</select></td>	
					<td align="center"><select name="sel_existing" onChange="selectExisting('<%=i%>')"><option value="S">-- Select --</option><option value="Y">Yes</option><option value="N">No</option></select>
					<a href="#" onClick="javascript:callDetails('<%=i+1%>','EXE')" > <img src="<%=ApplicationParams.getAppUrl()%>/img/nsdl_docview.png"	border="0" id="addn_det1"> </a></td>
					<td align="center"><select name="sel_default" onChange="selectDefault('<%=i%>')"><option value="S">-- Select --</option><option value="Y">Yes</option><option value="N">No</option></select>
					<a href="#" onClick="javascript:callDetails('<%=i+1%>','DEF')"> <img src="<%=ApplicationParams.getAppUrl()%>/img/nsdl_docview.png"	border="0" id="addn_det2"> </a></td>
					<td align="center"><img alt="Click to Delete Member" src="<%=ApplicationParams.getAppUrl()%>img/delete.png" 
									onclick="doRemove('<%=i+1%>')" style="cursor:hand"/>&nbsp;</td>
			    </tr>
			     <%if(i==0){ %>
			    <script>
			    	document.forms[0].sel_existing.value = "<%=Helper.correctNull((String)arrCol.get(6))%>";
			    	document.forms[0].sel_default.value = "<%=Helper.correctNull((String)arrCol.get(7))%>";
			    	document.forms[0].sel_concerntype.value = "<%=Helper.correctNull((String)arrCol.get(8))%>";
			    </script>
			    <%} else{ %>
			    <script>
			    	document.forms[0].sel_existing[<%=i%>].value = "<%=Helper.correctNull((String)arrCol.get(6))%>";
			    	document.forms[0].sel_default[<%=i%>].value = "<%=Helper.correctNull((String)arrCol.get(7))%>";
			    	document.forms[0].sel_concerntype[<%=i%>].value = "<%=Helper.correctNull((String)arrCol.get(8))%>";
			    </script>
			    <%} } } }else{%>
			    <tr><td colspan="7">Please fill the SHG Info page</td></tr>
			    <%} %>
			  </table>
		</td>
      </tr>
   </table>
			   <br>
			  <table width="50%" border="0" cellspacing="0" cellpadding="5" class="outertable" align="center">
				<tr>
					<td>			  	
					
		     	<%if(Helper.correctNull((String)session.getAttribute("sessionModuleType")).equals("")) { %>	
					
					 <lapschoice:combuttonnew btnnames='Edit _Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
				<% }  else { %>
				<span style="display: none; "><div >
					 <lapschoice:combuttonnew btnnames='Edit _Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
				</div> </span>
					<lapschoice:combuttonnew  btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
	   		<% } %>		 
					 
					  </td>
			    </tr>
			 </table>
				
				
				<br>
<lapschoice:hiddentag pageid='<%=PageId%>'/> 


<input type="hidden" name="hidDemoId" value="<%=Helper.correctNull((String)request.getParameter("hidDemoId"))%>"> 
<input type="hidden" name="txtperapp_appid" value="<%=Helper.correctNull((String)hshValues.get("perapp_id"))%>">
<input type="hidden" name="hidappstatus" value="<%=Helper.correctNull((String)hshValues.get("appstatus"))%>">
<input type="hidden" name="hid_DelSno">
</form>
</body>
</html>
