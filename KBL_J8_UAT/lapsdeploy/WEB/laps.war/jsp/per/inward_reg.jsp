<%@include file="../share/directives.jsp"%>

<%
	ArrayList arrRow=new ArrayList();
	ArrayList arrCol=new ArrayList();
	if(hshValues!=null)
	{
	arrRow = (ArrayList)hshValues.get("arrRow");
	}
	%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Outward</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" 	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<link rel="stylesheet" href="../htm/link.css" type="text/css">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<script LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/PageLoadTime.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/editor.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>ckeditor/ckeditor.js"></script>


<script>	
var currentDate="<%=Helper.getCurrentDateTime()%>";
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var appURL="<%=ApplicationParams.getAppUrl()%>";
var maxval="<%=Helper.correctNull((String)hshValues.get("maxval"))%>"



function callCalender1(name)
{	
	if(document.forms[0].cmdnew.disabled==true && document.forms[0].cmdedit.disabled==true)
	{
		showCal(appURL,name);
	}
}
//vindhya begin
	function doNew() 
	{
		callDisable(false);
		disableControls(true,true,false,false,false);
		document.forms[0].hidAction.value="Insert";
		document.forms[0].txt_inwarddate.readOnly=true;
		document.forms[0].txt_solid.readOnly=true;
		document.forms[0].txt_BranchName.readOnly=true;
		document.forms[0].txt_RegionName.readOnly=true;
		document.forms[0].txt_inwardrefno.value= maxval;
		document.forms[0].txt_inwardrefno.readOnly=true;
		document.forms[0].active_flag.value="Y";
		document.forms[0].txt_custid.readOnly=true;
		document.forms[0].txt_Name.readOnly=true;
		document.forms[0].txt_inwarddate.value= currentDate;

	}
	function doEdit() 
	{
		callDisable(false);
		disableControls(true,true,false,false,false);
		document.forms[0].hidAction.value="Update";
		document.forms[0].txt_inwarddate.readOnly=true;
		document.forms[0].txt_solid.readOnly=true;
		document.forms[0].txt_BranchName.readOnly=true;
		document.forms[0].txt_RegionName.readOnly=true;
		document.forms[0].txt_inwardrefno.readOnly=true;
		document.forms[0].txt_custid.readOnly=true;
		document.forms[0].txt_Name.readOnly=true;
		document.all.iddatepicker.style.visibility="visible";
		document.all.iddatepicker.style.position="relative";
		if(document.forms[0].sel_type.value=="2")
		{
		document.all.idforcustomer.style.visibility="visible";
		document.all.idforcustomer.style.position="relative";
		document.forms[0].txt_custid.readOnly=true;
		document.forms[0].txt_Name.readOnly=true;
		}
	else
		{
		document.all.idforcustomer.style.visibility="hidden";
		document.all.idforcustomer.style.position="absolute";
		document.forms[0].txt_custid.readOnly=false;
		document.forms[0].txt_Name.readOnly=false;
		}
	}
	//vindhya end
	function doCancel()
	{
		
		if(ConfirmMsg('102'))
		{
			document.forms[0].action=appURL+"action/inward_reg.jsp";
			document.forms[0].hidBeanId.value = "lapsReport";
			document.forms[0].hidBeanGetMethod.value = "getinwarddetails";
			document.forms[0].submit();
		}
		
	}
	function callonLoad()
	{
			callDisable(true);
			disableControls(false,true,true,true,false);		
	
	}
	
	function disableControls(cmdNew,cmdEdit,cmdApply,cmdcancle,cmdClose)
	{
		document.forms[0].cmdnew.disabled=cmdNew;
		document.forms[0].cmdedit.disabled=cmdEdit;
		document.forms[0].cmdsave.disabled=cmdApply;
		document.forms[0].cmdcancel.disabled=cmdApply;
		document.forms[0].cmdclose.disabled=cmdClose;
	}

	function callDisable(one)
	{
		for(var i=0;i<document.forms[0].elements.length;i++)
		{
			if(document.forms[0].elements[i].type=="text")
			{
			  document.forms[0].elements[i].readOnly=one;
			}
			if(document.forms[0].elements[i].type=="textarea")
			{
			  document.forms[0].elements[i].readOnly=one;
			}
			if(document.forms[0].elements[i].type=="select-one")
			{
				document.forms[0].elements[i].disabled=one;
			}
			
		}
		
		
	}

function doClose()
{
	   if(ConfirmMsg(100))
		 {
		   document.forms[0].action=appURL+"action/inwardoutward.jsp";
			document.forms[0].submit();
		 }
}

function doSave()  
{
	
	if(document.forms[0].txt_inwardrefno.value=="")
	{
		ShowAlert(121,"Inward Ref No ");
		document.forms[0].txt_inwardrefno.focus();
		return;
	}
	
	if(document.forms[0].txt_inwarddate.value=="")
	{
		ShowAlert(121,"Inward Date");
		document.forms[0].txt_inwarddate.focus();
		return;
	}
	if(document.forms[0].sel_type.value=="")
	{
		ShowAlert(121,"Type of Borrower");
		document.forms[0].sel_type.focus();
		return;
	}
	if(document.forms[0].txt_solid.value=="")
	{
		alert("Please Select Sold Id.");
		document.forms[0].txt_solid.focus();
		return;
	}
	if(document.forms[0].txt_BranchName.value=="")
	{
		ShowAlert(121,"Branch Name");
		document.forms[0].txt_BranchName.focus();
		return;
	}
	
	/*if(document.forms[0].txt_custid.value=="")
	{
		ShowAlert(121,"Cust ID");
		document.forms[0].txt_custid.focus();
		return;
	}*/
	if(document.forms[0].txt_Name.value=="")
	{
		ShowAlert(121,"Name");
		document.forms[0].txt_Name.focus();
		return;
	}
	
	if(document.forms[0].txt_inwarddetailsreceived.value=="")
	{
		ShowAlert(121,"Details of Inward Received ");
		document.forms[0].txt_inwarddetailsreceived.focus();
		return;
	}
	if(document.forms[0].sel_typeofinward.value=="0")
		{
		alert("Please select Type of Inward");
		document.forms[0].sel_typeofinward.focus();
		return;
		}
	
	document.forms[0].cmdsave.disabled = true;	
	//document.forms[0].hidAction.value="Insert";
	document.forms[0].hidBeanId.value="lapsReport";	
	document.forms[0].hidBeanMethod.value="updateinwarddetails";
	document.forms[0].hidBeanGetMethod.value="getinwarddetails";
	document.forms[0].hidSourceUrl.value="/action/inward_reg.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();

}

function allow()
{
	var key = window.event.keyCode;
	if(!(key>47 && key<58))
	{
		window.event.returnValue = false;
	}
}
function palceValues(val0,val1,val2,val3,val4,val5,val6,val7,val8,val9,val10,val11,val12)
{
	
	document.forms[0].txt_inwardrefno.value=val0;
	document.forms[0].txt_inwarddate.value=val1;
	document.forms[0].txt_LAR.value=val2;
	document.forms[0].txt_solid.value=val3;
	document.forms[0].txt_BranchName.value=val4;
	document.forms[0].txt_RegionName.value=val5;
	document.forms[0].txt_custid.value=val6;
	document.forms[0].txt_Name.value=val7;
	document.forms[0].sel_typeofinward.value=val8;
	document.forms[0].txt_inwarddetailsreceived.value=val9;
	document.forms[0].txt_remarks.value=val10;
	document.forms[0].sel_type.value=val11;
	document.forms[0].active_flag.value=val12;
	disableControls(true,false,true,true,false);	//vindhya
}
function searchbranch()
{
	if(document.forms[0].cmdnew.disabled==true && document.forms[0].cmdedit.disabled==true)
		{
   var varQryString = appURL+"action/searchbranch.jsp?hidBeanId=lapsReport&hidBeanGetMethod=getbrachlist";
   var title = "Acknowledgement";
   var prop = "scrollbars=yes,width=650,height=400,menubar=yes";	
   var xpos = (screen.width - 350) / 2;
   var ypos = (screen.height - 120) / 2;
    prop = prop + ",left=50,top=50";
    window.open(varQryString,title,prop);	
		}
}
function DisableCopyPastealert(e) 
{
 // Message to display
 var message = "Insert key and Right Click Option is disabled";
 // check mouse right click or Ctrl key press
var kCode = e.keyCode; 
//FF and Safari use e.charCode, while IE use e.keyCode
 if (kCode == 17 || kCode == 0 || kCode == 45)
 {
 alert(message);
 return false;
 }
 else{
	 allowNumeric(kCode)
 }
}
function specialcharalert(event) {
	//alert("alert2");
	  var x = event.which || event.keyCode;
	  
	  /*if((x>=65 && x<=90)||(x>=97 && x<=122)||(x>=48 && x<=57)|| x==32)
	  {
		  return true;
	  }
	  else
	  {
		  alert("Only allow for Alphabet and Numbers")
		  return false;
		    
	  }*/
	       if(x==34||x==39)
		  {
		   alert("Double or single quotes not allowed");
		   return false;
		  }
	       else
	    	   {
	    	   return true;
	    	   }
	  
	}
function callDescCBS()
{	
	if(document.forms[0].cmdnew.disabled==true && document.forms[0].cmdedit.disabled==true)
	{
	var varQryString = appURL+"action/CBSIDhelp.jsp?hidPagename=inward";
	var title = "SelectCBSID";
	var prop = "scrollbars=yes,menubar=yes,status=yes,width=500,height=400";
	prop = prop + ",left=50,top=150";
    window.open(varQryString,title,prop);
	}
}
function funchkforcustomer()
{
	if(document.forms[0].sel_type.value=="2")
		{
		document.all.idforcustomer.style.visibility="visible";
		document.all.idforcustomer.style.position="relative";
		document.forms[0].txt_custid.readOnly=true;
		document.forms[0].txt_Name.readOnly=true;
		}
	else
		{
		document.all.idforcustomer.style.visibility="hidden";
		document.all.idforcustomer.style.position="absolute";
		document.forms[0].txt_custid.readOnly=false;
		document.forms[0].txt_Name.readOnly=false;
		}
	document.forms[0].txt_custid.value="";
	document.forms[0].txt_Name.value="";
}
function allowalwysOldDate(obj)
{
	var pagedate=obj.value;
	var pgdt=changeDateformat(pagedate);
	var varc = changeDateformat(currentDate);
	if(obj.value!="")
	{
	
	if(Date.parse(pgdt) > Date.parse(varc))
	{
		alert("Date Can not be future date");
		obj.value="";
		obj.focus();
		return false;
	}
	}
		
		
	return true;
}
</script>
</head>
<body onload="callonLoad();">
<form class="normal" method="post">


<table width="95%" border="1" cellspacing="0" cellpadding="3"
	class="outertable" align="center" style="margin-left: 20px; margin-right: 20px; margin-top: 5px;">
<tr>
<td>
<table class="outertable" width="100%"  border="0" cellspacing="0" cellpadding="3" align="center">

	<tr class="dataheader" style="text-align: center">
		<td style="text-align: center;width:100%;">Inward Details</td><td></td>	
	</tr>
</table>	
<table class="outertable" width="100%"  border="0" cellspacing="0" cellpadding="3" align="center">	
	<tr>
		<td width="10%">Inward Ref No <b><span class="mantatory">*</span></b></td>
		 <td width="15%"><input type="text" name="txt_inwardrefno"  maxlength="30" value="" ></td>
		<td width="10%">Inward Date<b><span class="mantatory">*</span></b></td>
		 <td width="15%"><input type="text" name="txt_inwarddate" size="12"
							maxlength="10" 
							value="<%=Helper.correctNull((String)hshValues.get("txt_inwarddate"))%>"
							onBlur="checkDate(this);allowalwysOldDate(this);">
							 <a id="iddatepicker" style="visibility: hidden; position: absolute;" href="#"
							onClick="callCalender1('txt_inwarddate')"
								onMouseOver="window.status='Date Picker';return true;"
									onMouseOut="window.status='';return true;"
							title="Click to view calender" border=0><img
							src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
							border="0"></a></td>
							
<td>Type of Inward<b><span class="mantatory">*</span></b></td>
		<td> <select name="sel_typeofinward">
								          <option value="0" selected="selected">&lt;---Select---&gt;</option>
								          <option value="1">Proposal</option>
								          <option value="2">Credit Enquiry</option>
								           <option value="3">Short Note</option>
								           <option value="4">Other Letters</option>
								        </select></td>
		
		</tr>
	
	<tr>
			<td width="15%">Type of Borrower <b><span class="mantatory">*</span></b></td>
		 <td width="10%"> <select name="sel_type" onchange="funchkforcustomer();">
								          <option value="0" selected="selected">&lt;---Select---&gt;</option>
								          <option value="1">NTB</option>
								          <option value="2">ETB</option>
								           <option value="3">Others</option>
								        </select></td>
		<td>Cust ID</td>
		 <td><input type="text" name="txt_custid"  value="" >
		  <span id="idforcustomer" style="visibility: hidden; position: absolute;"  onClick="javascript:callDescCBS()" style="cursor: hand" id="idsearch"><img
					src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
					border="0"></span></td>
		<td>Name<b><span class="mantatory">*</span></b></td>
		 <td><input type="text" name="txt_Name" value="" ></td>
							
		</tr>
	
		<tr>
		<td>Sol ID <b><span class="mantatory">*</span></b></td>
		 <td><input type="text" name="txt_solid"  value="" >
		 <span id="applsearch" onClick="searchbranch()"
													style="cursor:hand"><img
													src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
													border="0" ></span></td>
		<td>Branch Name<b><span class="mantatory">*</span></b></td>
		 <td><input type="text" name="txt_BranchName"   value="" ></td>
							
		<td>Region Name <b><span class="mantatory">*</span></b></td>
		<td> <input type="text" name="txt_RegionName" value="" ></td>
					
	</tr>
		<tr>
	<td width="10%">LAR</td>
		 <td width="15%"><input type="text" name="txt_LAR"   value="" onkeypress="allowNumber(this);"></td>						        
		<td>Details of Inward Received  <b><span class="mantatory">*</span></b> </td>
		 <td> 
		 
		  <textarea name="txt_inwarddetailsreceived" onKeyDown="return DisableCopyPastealert(event)" onkeypress="return specialcharalert(event)" maxlength="3999"  cols="46" rows="2"></textarea>
		
		 </td>
		<td>Remarks  <b></b> </td>
		 <td> 
		  <textarea name="txt_remarks" onKeyDown="return DisableCopyPastealert(event)" onkeypress="return specialcharalert(event)" maxlength="3999"  cols="46" rows="2"></textarea>
</td>
		
		</tr>
		<tr>
		<td>
		Active
		</td>
		 <td width="10%"> <select name="active_flag">
								          <option value="0" selected="selected">&lt;---Select---&gt;</option>
								          <option value="Y">Yes</option>
								          <option value="N">No</option>
								        </select></td>
		</tr>
		
		
</table>

</td>
</tr>

<!-- Button Portion in table -->
<tr>
<td>
		<table width="12%" border="0" cellspacing="0" cellpadding="0"	align="center" class="outertable">
			<tr>
				<lapschoice:combuttonnew btnnames='New_Edit_Save_Cancel' btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />	
			</tr>
		</table>
		
</td>
</tr>
<table class="outertable linebor" width="100%" border="0" cellspacing="0" cellpadding="3">
	<tr align="center">
		<td class="tabactivenew" width="2%">&nbsp;</td>
		<td class="tabactivenew" width="10%"><b>Inward Reg No</b></td>
		<td class="tabactivenew" width="10%"><b>Inward Date</b></td>
		<td class="tabactivenew" width="10%"><b>Type of Inward</b></td>
		<td class="tabactivenew" width="10%"><b>Type of Borrower</b></td>
		<td class="tabactivenew" width="10%"><b>CBS Id</b></td>
		<td class="tabactivenew" width="20%"><b>Name</b></td>
		

		<td class="tabactivenew" width="20%"><b>Branch Name</b></td>
	</tr>
	<%if (arrRow != null && arrRow.size() > 0) {
				for (int i = 0; i < arrRow.size(); i++) {
					arrCol = (ArrayList) arrRow.get(i);

					%>
	<tr bgcolor="#EAE4DB" valign="top">
		<td width="2%"><input type="radio" name="rdosec"
			onclick="palceValues('<%=Helper.correctNull((String)arrCol.get(0))%>',
			'<%=Helper.correctNull((String)arrCol.get(1))%>','<%=Helper.correctNull((String)arrCol.get(2))%>',
			'<%=Helper.correctNull((String)arrCol.get(3))%>',
			'<%=Helper.correctNull((String)arrCol.get(4))%>','<%=Helper.correctNull((String)arrCol.get(5))%>',
			'<%=Helper.correctNull((String)arrCol.get(6))%>', '<%=Helper.correctNull((String)arrCol.get(7))%>',
			'<%=Helper.correctNull((String)arrCol.get(8))%>', '<%=Helper.correctNull((String)arrCol.get(9))%>'
			,'<%=Helper.correctNull((String)arrCol.get(10))%>','<%=Helper.correctNull((String)arrCol.get(11))%>'
			,'<%=Helper.correctNull((String)arrCol.get(12))%>')"
			style="border: none">
		</td>
		 <td width="10%%" align="center"><%=Helper.correctNull((String)arrCol.get(0))%></td>
         <td width="10%" align="center"><%=Helper.correctNull((String)arrCol.get(1))%></td>
          <%if(Helper.correctNull((String)arrCol.get(8)).equalsIgnoreCase("1")){ %>
	     <td width="10%" align="center">Proposal</td>
	     <%}else if(Helper.correctNull((String)arrCol.get(8)).equalsIgnoreCase("2")){ %>
	      <td width="10%" align="center">Credit Enquiry</td>
	      <%}else if(Helper.correctNull((String)arrCol.get(8)).equalsIgnoreCase("3")) {%>
	       <td width="10%" align="center">Short Note</td>
	      <%}else if(Helper.correctNull((String)arrCol.get(8)).equalsIgnoreCase("4")) {%>
	      <td width="10%" align="center">Other Letters</td>
	      <%}%>
	        <%if(Helper.correctNull((String)arrCol.get(11)).equalsIgnoreCase("1")){ %>
	     <td width="10%" align="center">NTB</td>
	     <%}else if(Helper.correctNull((String)arrCol.get(11)).equalsIgnoreCase("2")) {%>
	     <td width="10%" align="center">ETB</td>
	     <%} else if(Helper.correctNull((String)arrCol.get(11)).equalsIgnoreCase("3")) {%>
	     <td width="10%" align="center">Other</td>
	     <%} %>
	     <td width="10%" align="center"><%=Helper.correctNull((String)arrCol.get(6))%></td>
         <td width="20%" align="center"><%=Helper.correctNull((String)arrCol.get(7))%></td>
      
	     <td width="20%" align="center"><%=Helper.correctNull((String)arrCol.get(4))%></td>
	</tr>
	<%}
			}

			%>
</table>
</table>
			
<lapschoice:hiddentag pageid="<%=PageId %>" /> 
<input type="hidden" name="hidUsername" value="<%=Helper.correctNull((String)session.getAttribute("strUserName"))%>"> 
<input type="hidden" name="hidOrgcode" value="<%=Helper.correctNull((String)session.getAttribute("strOrgCode"))%>">


<input type ="hidden" name="hidfacility" value="">

</form>
</body>
</html>
