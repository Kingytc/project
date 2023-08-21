<%@include file="../share/directives.jsp"%>
<%
	ArrayList arrRow = new ArrayList();
	ArrayList arrCol = new ArrayList();
	arrRow = (ArrayList) hshValues.get("arrRow");
	String strApplicationExist=Helper.correctNull((String)hshValues.get("ApplicationExist_Mstr"));
	String strpermission_Freezeflag =Helper.correctNull((String)session.getAttribute("strpremission_freezeflag")).trim();

%>
<html>
<head>
<title>Deviation Assessment</title>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var amtType="<%=Helper.correctNull((String)hshValues.get("strOrgLevel"))%>";
var app_exist="<%=Helper.correctNull((String)hshValues.get("ApplicationExist_Mstr"))%>";
var varpermission_Freezeflag="<%=strpermission_Freezeflag%>";

function doClose()
{
	if (ConfirmMsg(100)) 
	{
		document.forms[0].action = appURL + "action/mainnav.jsp";
		document.forms[0].submit();
	}
}
function doCancel()
{
	if(ConfirmMsg(102))
	{
	document.forms[0].hidBeanId.value = "perDeviation";
	document.forms[0].hidBeanGetMethod.value = "getAssessment";
	document.forms[0].action = appURL + "action/perdeviationassessment.jsp";
	document.forms[0].submit();
	}
}
function callDisableControls(cmdEdit, cmdSave, cmdDelete, cmdCancel,cmdClose)
{
	document.forms[0].cmdedit.disabled = cmdEdit;
	document.forms[0].cmdsave.disabled = cmdSave;
	document.forms[0].cmddelete.disabled = cmdDelete;
	document.forms[0].cmdcancel.disabled = cmdCancel;
	document.forms[0].cmdclose.disabled = cmdClose;
}
function callOnLoad() 
{
	//callDisableControls(false, true, true, false, false);
	disablefields(true);

	<%if(arrRow!=null && arrRow.size()>0)
	{ 
		for(int i=0;i<arrRow.size();i++)
		{
			arrCol=(ArrayList)arrRow.get(i);
			if(Helper.correctNull((String)arrCol.get(2)).equalsIgnoreCase("R"))
			{
				if(arrRow.size()==1)
				{%>
					document.forms[0].sel_asstype1.value="<%=Helper.correctNull((String)arrCol.get(7))%>";
					document.forms[0].txt_mark.value="<%=Helper.correctNull((String)arrCol.get(6))%>";
				<%}else{%>
					document.forms[0].sel_asstype1[<%=i%>].value="<%=Helper.correctNull((String)arrCol.get(7))%>";
					document.forms[0].txt_mark[<%=i%>].value="<%=Helper.correctNull((String)arrCol.get(6))%>";
				<%}
			}
		}
	}%>

	var AssessmentParam=document.forms[0].hidassessment.value;
	var FinancialParam=document.forms[0].hidfinancial.value;
	if(AssessmentParam=="Y")
	{
		document.all.idAssessment.style.display="table-cell";
	}
	else
	{
		document.all.idAssessment.style.display="none";
	}
	if(FinancialParam=="Y")
	{
		document.all.idFinancial.style.display="table-cell";
	}
	else
	{
		document.all.idFinancial.style.display="none";
	}
	if(document.forms[0].hidDevCat.value=="7")
	{
		document.all.more_det.style.display="none";
	}	
	
}
function doEdit()
{	
	document.forms[0].hidAction.value = "insert";
	callDisableControls(true, false, false, false, false);
	disablefields(false);
	<%if(arrRow!=null && arrRow.size()>0){ 
		for(int i=0;i<arrRow.size();i++){
		arrCol=(ArrayList)arrRow.get(i);
		if((Helper.correctNull((String)arrCol.get(2)).equalsIgnoreCase("V"))){ 
		%>
			document.forms[0].txt_mark[<%=i%>].value="<%=Helper.correctNull((String)arrCol.get(1)) %>";
	<%}}} %>
		<%for(int i=0;i<arrRow.size();i++)
		{
			if(arrRow.size()==1)
			{
				if(Helper.correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("A"))
				{%>
			
				document.forms[0].txt_hovalue.readOnly=true;
				<%}
				else if(Helper.correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("C")||Helper.correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("R"))
				{%>
					document.forms[0].txt_branchvalue.readOnly=true;
				<%}}
				else
				{
					if(Helper.correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("A"))
					{%>
	                       document.forms[0].txt_hovalue[<%=i%>].readOnly=true;
	                       
					<%}else if(Helper.correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("C")||Helper.correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("R")){%>
						
						document.forms[0].txt_branchvalue[<%=i%>].readOnly=true;
					<%}
				}
					
				}
			
				
			
		
	%>

}
function doSave() {
   
	var tab  = document.getElementById("idtable");
	var rowsLength = tab.rows.length;
	if(rowsLength==2)
	{
		if(document.forms[0].hid_type.value=="R" && document.forms[0].sel_asstype1.value=="")
		{
			alert("Select Range Parameter");
			document.forms[0].sel_asstype1.focus();
			return;
		}
		else if(document.forms[0].txt_branchvalue.value=="" && (amtType=="A") )
		{
			alert("Enter Mark Prescribed by Branch");
			document.forms[0].txt_branchvalue.focus();
			return;
		}
		else if(document.forms[0].txt_hovalue.value=="" && ((amtType=="C")||(amtType=="R")))
		{
			alert("Enter Mark Awarded at HO/RO");
			document.forms[0].txt_hovalue.focus();
			return;
		}
	}
	else if(rowsLength>2)
	{
		for(var i=0;i<document.forms[0].hid_type.length;i++)
		{
			if(document.forms[0].hid_type[i].value=="R" && document.forms[0].sel_asstype1[i].value=="")
			{
				alert("Select Range Parameter");
				document.forms[0].sel_asstype1[i].focus();
				return;
			}
			else if(document.forms[0].txt_branchvalue[i].value=="" && (amtType=="A"))
			{
				alert("Enter Mark Prescribed by Branch");
				document.forms[0].txt_branchvalue[i].focus();
				return;
			}
			else if(document.forms[0].txt_hovalue[i].value=="" && ((amtType=="C")||(amtType=="R")))
			{
				alert("Enter Mark Awarded at HO/RO");
				document.forms[0].txt_hovalue[i].focus();
				return;
			}
		}
	}
	
	document.forms[0].hidBeanId.value = "perDeviation";
	document.forms[0].hidBeanMethod.value = "updateAssessment";
	document.forms[0].hidBeanGetMethod.value = "getAssessment";
	document.forms[0].hidSourceUrl.value = "/action/perdeviationassessment.jsp";
	document.forms[0].action = appURL + "controllerservlet";
	document.forms[0].submit();
}
function doDelete()
{
	var varconfirm=ConfirmMsg('101');
	if(varconfirm)
	{
	document.forms[0].hidAction.value = "delete";
	document.forms[0].hidBeanId.value = "perDeviation";
	document.forms[0].hidBeanMethod.value = "updateAssessment";
	document.forms[0].hidBeanGetMethod.value = "getAssessment";
	document.forms[0].hidSourceUrl.value = "/action/perdeviationassessment.jsp";
	document.forms[0].action = appURL + "controllerservlet";
	document.forms[0].submit();
	}
}
function callChange(obj,id) {

	var tab  = document.getElementById("idtable");
	var rowsLength = tab.rows.length;
	var varVal=obj.value;
	var varArr=varVal.split("@");
	if(rowsLength==2)
	{
    	document.forms[0].txt_mark.value=varArr[0];
    	if(amtType=="A")
    		document.forms[0].txt_branchvalue.value="";
    	if((amtType=="C")||(amtType=="R"))
    		document.forms[0].txt_hovalue.value="";
	}else if(rowsLength>=2)
	{
		document.forms[0].txt_mark[id].value=varArr[0];
		if(amtType=="A")
			document.forms[0].txt_branchvalue[id].value="";
		if((amtType=="C")||(amtType=="R"))
			document.forms[0].txt_hovalue[id].value="";
	}
}
function callLink(url,bean,method)
{

	if(url=="permissiongist_addDetails.jsp" && varpermission_Freezeflag!="Y")
	{	
	 	alert("Kindly click on freeze button in Permission Tab");
		return;
	}
	else
	{
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+url;
		document.forms[0].submit();
	}
}
function disablefields(bool)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].disabled=bool;
		}	  
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=bool;
		}
	}
}
function chkMark(vartype,varVal)
{
	var tab  = document.getElementById("idtable");
	var rowsLength = tab.rows.length;
	if(rowsLength==2)
	{
		if(document.forms[0].hid_type.value=="R" && document.forms[0].sel_asstype1.value=="")
    	{
        	alert("Select Range Parameter");
        	document.forms[0].sel_asstype1.focus();
        	return;
    	}
    	if(vartype=="B")
    	{
        	if(eval(document.forms[0].txt_mark.value)<eval(document.forms[0].txt_branchvalue.value))
        	{
            	alert("Score should not be more than the Max Value");
            	document.forms[0].txt_branchvalue.value="";
            	document.forms[0].txt_branchvalue.focus();
            	return;
        	}
    	}
    	else if(vartype=="H")
    	{
    		if(eval(document.forms[0].txt_mark.value)<eval(document.forms[0].txt_hovalue.value))
        	{
    			alert("Score should not be more than the Max Value");
            	document.forms[0].txt_hovalue.value="";
            	document.forms[0].txt_hovalue.focus();
            	return;
        	}
    	}
    	
	}else if(rowsLength>=2)
	{
		if(document.forms[0].hid_type[varVal].value=="R" && document.forms[0].sel_asstype1[varVal].value=="")
    	{
        	alert("Select Range Parameter");
        	document.forms[0].sel_asstype1[varVal].focus();
        	return;
    	}
		if(vartype=="B")
    	{
        	if(eval(document.forms[0].txt_mark[varVal].value)<eval(document.forms[0].txt_branchvalue[varVal].value))
        	{
            	alert("Score should not be more than the Max Value");
            	document.forms[0].txt_branchvalue[varVal].value="";
            	document.forms[0].txt_branchvalue[varVal].focus();
            	return;
        	}
    	}
    	else if(vartype=="H")
    	{
    		if(eval(document.forms[0].txt_mark[varVal].value)<eval(document.forms[0].txt_hovalue[varVal].value))
        	{
    			alert("Score should not be more than the Max Value");
            	document.forms[0].txt_hovalue[varVal].value="";
            	document.forms[0].txt_hovalue[varVal].focus();
            	return;
        	}
    	}
	}
}
</SCRIPT>
</head>
<body onload="callOnLoad()">
<form class="normal" method="post">
<table width="100%" border="0" cellpadding="3" cellspacing="0" class="outertable">
	<tr>
		<td><jsp:include page="../share/devurllinker.jsp" flush="true">
			<jsp:param name="pageid" value="1" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Permission -&gt; Proposal -&gt; Deviation Assessment</td>
			</tr>
			</table>
		<lapschoice:ApplDevHeaderTag />
	

<table width="100%"  border="0" cellpadding="3" cellspacing="0" class="outertable">
  		
  		<tr>
  			<td>
  			<table border="0" cellspacing="0" cellpadding="3" align="left" class="outertable">
			<tr>
			<td class="sub_tab_inactive" id="prin" width="150px;" align="center"><b><a href="#" onclick="javascript:callLink('permission_gist.jsp','perDeviation','getPermissionGistData')">Permission Gist</a></b></td>
			<td class="sub_tab_inactive" id="more_det" align="center" width="250px;"><b><a href="#" onclick="javascript:callLink('permissiongist_addDetails.jsp','perDeviation','getPermissionGistMoreDet')">Permission Gist- More Information</a></b></td>	
			<td class="sub_tab_inactive" id="prin" width="200px;" align="center"><b><a href="#" onclick="javascript:callLink('perm_appbackground_info.jsp','perDeviation','get_PermApplBackgroundData')">Background of the Applicant</a></b></td>
			<td class="sub_tab_active" id="idAssessment" width="200px;" align="center"><b>Interest concession Assessment</b></td>
			<td class="sub_tab_inactive" id="prin" width="150px;" align="center"><b><a href="#" onclick="javascript:callLink('permission_parameters.jsp','perDeviation','getPermissionData')">Permission Paramters</a></b></td>
			<td class="sub_tab_inactive" id="idFinancial" width="200px;" align="center"><b><a href="#" onclick="javascript:callLink('perm_financial.jsp','perDeviation','getdataFinancial')">Gist of Balance Sheet Analysis</a></b></td>
			</tr>
			</table>
  			</td>
  		</tr>
  </table>
  <br/>
			<table width="80%" border="0" cellspacing="0" cellpadding="3"
	class="outertable" align="center">
	<tr>
	<td>
	<table width="100%" border="0" cellspacing="1" cellpadding="3"
	class="outertable" id="idtable">
	<tr class="dataheader"  align="center">
	<td width="40%" colspan="2">General Assessment of the Party</td>
	<td width="15%">Marks</td>
	<td width="15%">Mark Prescribed by Branch</td>
	<td width="15%">Mark Awarded at HO/RO</td>
	</tr>
		<%if(arrRow!=null && arrRow.size()>0){ 
			for(int i=0;i<arrRow.size();i++){
			arrCol=(ArrayList)arrRow.get(i);
			%>
			<tr class="datagrid">
					<td><%=Helper.correctNull((String)arrCol.get(0)) %>&nbsp;
					<input type="hidden" name="txt_id" value="<%=Helper.correctNull((String)arrCol.get(3)) %>">
					<input type="hidden" name="hid_type" value="<%=Helper.correctNull((String)arrCol.get(2)) %>">
					 </td>	
					
					<%if((Helper.correctNull((String)arrCol.get(2)).equalsIgnoreCase("R"))){ %>
					 <td><select name="sel_asstype1"  onchange="callChange(this,'<%=i %>');">
						<option value=""> &lt;---Select---&gt;</option>
					<%
                    	String parenttype =Helper.correctNull((String)arrCol.get(3));
                    %>
                    <lapschoice:PermInterestConTag value='<%=parenttype%>'/>
						</select> </td>
						<td align="center"><input type="text" name="txt_mark" value="" readonly="readonly" ></td>
						<%}else{ %>
						<td align="center"><input type="hidden" name="sel_asstype1">&nbsp;</td>
							<%if(strApplicationExist.equalsIgnoreCase("Y")){%>
								<td align="center"><input type="text" name="txt_mark" value="<%=Helper.correctNull((String)arrCol.get(1)) %>" readonly="readonly" ></td>
								<%}else{ %>
									<td align="center"><input type="text" name="txt_mark" value="" readonly="readonly" ></td>
						<%} }%>
					<td align="center"><input type="text" name="txt_branchvalue" onkeypress="allowNumber(this);" onblur="chkMark('B','<%=i %>')" size="7" value="<%=Helper.correctNull((String)arrCol.get(4)) %>"> </td>
					<td align="center"><input type="text" name="txt_hovalue" onkeypress="allowNumber(this);" onblur="chkMark('H','<%=i %>')" size="7" value="<%=Helper.correctNull((String)arrCol.get(5)) %>"> </td>	
					</tr>
				<%} %>
					<%} %>
		
		</table>
		<br>
	<lapschoice:combuttonnew btnnames='Edit_Save_Delete_Cancel'
		btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>' />

</form>
</body>
</html>
