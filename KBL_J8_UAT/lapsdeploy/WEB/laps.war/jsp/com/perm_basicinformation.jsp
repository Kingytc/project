<%@include file="../share/directives.jsp"%>
<% String orglevel=Helper.correctNull((String)hshValues.get("strAppCreatedOrg")); %>
<html>
<head>
<title>Proposal</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>ckeditor/ckeditor.js">
</script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currentdate= "<%=Helper.getCurrentDateTime()%>";
var proposal="<%=Helper.correctNull((String)hshValues.get("PERM_PROP_SUBMITTED"))%>";
var sancDept="<%=Helper.correctNull((String)hshValues.get("PERM_SANC_DEPT"))%>";
var sancAuth="<%=Helper.correctNull((String)hshValues.get("PERM_SANC_AUTH"))%>";
var sancInti="<%=Helper.correctNull((String)hshValues.get("PERM_SANC_INTIMATE"))%>";
var sancRefno="<%=Helper.correctNull((String)hshValues.get("PERM_REFNO"))%>";
var sancDate="<%=Helper.correctNull((String)hshValues.get("PERM_SANC_DATE"))%>";
var sancBranch="<%=Helper.correctNull((String)hshValues.get("PERM_SANC_BRANCH"))%>";
var varorglevel="<%=orglevel%>";


function callCalender(fname)
{
	if(document.forms[0].cmdedit.disabled==true)
	{
		showCal(appURL,fname);
	}
}
function disablefields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=val;
		}	  
		else if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=val;
		}
	}
}


function enableButtons(bool1,bool2,bool3,bool4,bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool5;
	document.forms[0].cmdclose.disabled=bool4;
	
	//document.forms[0].cmdcomments.disabled=bool6;
}
function placevalues()
{
	disablefields(true);
	
				if(proposal!="")
				{
				document.forms[0].sel_proposalsubmit.value =proposal;
				}
				if(sancDept!="")
				{
				document.forms[0].sel_SancDept.value =sancDept;
				}
				if(sancInti!="")
				{
				document.forms[0].sel_SancLevel.value =sancInti;
				}
				if(sancAuth!="")
				{
				document.forms[0].sel_SancAuth.value =sancAuth;
				}
				funsancrefno('N');
				funsanctiondept(sancAuth,'N');
				if(sancBranch!="")
				{
					
				document.forms[0].sel_SancBranch.value =sancBranch;
				}
				
				
				
  }
function doCancel()
{
	if (ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="perDeviation";
		document.forms[0].hidBeanGetMethod.value="getBasicInformation";
		document.forms[0].action = appURL + "action/perm_basicinformation.jsp";
		document.forms[0].submit();
		
	}
}
function doEdit()
{	
	<%if(!orglevel.equalsIgnoreCase("C") && Helper.correctNull((String)hshValues.get("RECOMMEND_BRANCH_VAL")).equalsIgnoreCase("Y")){%>
		alert("Please Enter Recommendation by the Branch/CLPH in Permission -> Permission Gist Tab");
		return;
	<%}%>
	disablefields(false);
	document.forms[0].hideditflag.value="Y";
	if(varorglevel=="D"||varorglevel=="C")
	document.forms[0].txt_perbranch.readOnly=true;
	enableButtons(true,false,false,false,false);
}
function doSave()
{

	if(document.forms[0].sel_SancDept.value=="s")
	{
		ShowAlert('111', "Permitting Department"); 	
		document.forms[0].sel_SancDept.focus();
		return;	
	}
	if(document.forms[0].sel_SancDept.value=="010" || document.forms[0].sel_SancDept.value=="008"|| document.forms[0].sel_SancDept.value=="013"|| document.forms[0].sel_SancDept.value=="014"|| document.forms[0].sel_SancDept.value=="015"|| document.forms[0].sel_SancDept.value=="016")
	{
		if(document.forms[0].sel_SancBranch.value=="")
		{
			alert("Select Permitting Branch");
			document.forms[0].sel_SancBranch.focus();
			return;
		}
	}
	if(document.forms[0].sel_SancAuth.value=="s")
	{
		ShowAlert('111', "Permitting Authority"); 	
		document.forms[0].sel_SancAuth.focus();
		return;	
	}

	if(document.forms[0].sel_SancLevel.value=="s")
	{
		ShowAlert('111', "Permission intimation mode"); 	
		document.forms[0].sel_SancLevel.focus();
		return;	
	}
	if(document.forms[0].txt_procfee.value=="")
	{
		ShowAlert('121', "Handling Charge"); 	
		document.forms[0].txt_procfee.focus();
		return;	
	}

	if((document.forms[0].sel_SancAuth.value=="15") || (document.forms[0].sel_SancAuth.value=="16")||(document.forms[0].sel_SancAuth.value=="14"))
	{
		if(document.forms[0].txt_sancrefno.value=="")
		{
			ShowAlert('121', "Permission Reference No"); 	
			document.forms[0].txt_sancrefno.focus();
			return;	
		}
		if(document.forms[0].sanctiondate.value=="")
		{
			ShowAlert('111', "Permission Date"); 	
			document.forms[0].sanctiondate.focus();
			return;	
		}
	}

	if(sancDept!="" && sancDept!=document.forms[0].sel_SancDept.value)
	{
		if(confirm("Changing Sanctioning Department will delete Permitting Department Recommendations. Do you want to Continue?"))
			document.forms[0].hid_sancdept_flag.value="Y";
		else
			return;
	}
	if(varorglevel=="D"||varorglevel=="C")
	{
		if(document.forms[0].hid_perbranch.value=="")
		{
			ShowAlert('111', "Permission pertains to the branch"); 	
			document.forms[0].txt_perbranch.focus();
			return;	
		}
	}

	
	document.forms[0].hidAction.value ="edit";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidBeanId.value="perDeviation";
	document.forms[0].hidBeanMethod.value="updateBasicInformation";
	document.forms[0].hidBeanGetMethod.value="getBasicInformation";
	document.forms[0].hidSourceUrl.value="/action/perm_basicinformation.jsp";
	document.forms[0].submit();

	

}
function doDelete()
{
	var varconfirm=ConfirmMsg('101');
	if(varconfirm)
	{
	document.forms[0].hidAction.value ="delete";
	document.forms[0].action=appURL+"action/ControllerServlet";	
	document.forms[0].hidBeanId.value="perDeviation";
	document.forms[0].hidBeanMethod.value="updateBasicInformation";	
	document.forms[0].hidBeanGetMethod.value="getBasicInformation";				
	document.forms[0].hidSourceUrl.value="action/perm_basicinformation.jsp";	
	document.forms[0].method="post";			
	document.forms[0].submit();	
	}
}
function doClose()
{
   if(ConfirmMsg(100))
	 {
		 document.forms[0].action=appURL+"action/mainnav.jsp";
		 document.forms[0].submit();
	 }
}

function funsancrefno(flag)
{ 
	
	if((document.forms[0].sel_SancAuth.value=="15") || (document.forms[0].sel_SancAuth.value=="16")||(document.forms[0].sel_SancAuth.value=="14"))
	{
		
		document.all.sanrefno.style.display = "table-cell";
		document.all.sanrefval.style.display = "table-cell";
		document.all.sancdate1.style.display = "table-cell";
		document.all.sancdate2.style.display = "table-cell";
		document.forms[0].txt_sancrefno.value=sancRefno;
		
	}
	else
	{ 
		document.all.sanrefno.style.display = "none";
		document.all.sanrefval.style.display = "none";
		document.all.sancdate1.style.display = "none";
		document.all.sancdate2.style.display = "none";	
		if(flag=="Y")
		document.forms[0].txt_sancrefno.value="";
	}		
}
function funsanctiondept(varfname,val)
{
	var varsancdept=document.forms[0].sel_SancDept.value;
	if((varsancdept=="008") || (varsancdept=="010")||(varsancdept=="013") || (varsancdept=="014")||(varsancdept=="015") || (varsancdept=="016"))
	{
		document.all.idsanbranch.style.display="table-cell";
		funsancbranchvalues();
	}
	else{
		document.all.idsanbranch.style.display="none";
		document.forms[0].sel_SancBranch.value="";
	}
	document.all.ifrmsancauthority.src=appURL+"action/iframesancauthority.jsp?hidBeanGetMethod=getSancAuthority&hidBeanId=comproposal&sancdept="+varsancdept+"&sancauth="+varfname;
}
function funsancbranchvalues()
{

	var varsancdept=document.forms[0].sel_SancDept.value;
	document.all.ifrmsancbranch.src=appURL+"action/ifrmsancbranches.jsp?hidBeanGetMethod=getSancBranches&hidBeanId=comproposal&sancdept="+varsancdept+"&sancbranch="+sancBranch;
}

function showOrganizationSearch(path, forgscode, forgname)
{
	
		var varQryString = path+"action/searchOrg.jsp?forgscode="+forgscode+"&forgname="+forgname;
		var title = "Organization";
		var prop = "scrollbars=yes,width=500,height=400,menubar=yes";	
		var xpos = (screen.width - 350) / 2;
		var ypos = (screen.height - 120) / 2;
		prop = prop + ",left=50,top=50";
		window.open(varQryString,title,prop);
	
}

</script>
</head>
<body onload="placevalues()" >
<form name="frmpri" method = "post" class="normal">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
	<tr>
		<td><jsp:include page="../share/devurllinker.jsp" flush="true">
			<jsp:param name="pageid" value="3" />
		</jsp:include></td>
	</tr>
</table>
<table>
   
     <tr>
		<td class="page_flow">Home -&gt; Permission -&gt;  Proposal -&gt; Basic Information </td>
	</tr>
  
  </table>
  <lapschoice:ApplDevHeaderTag />
				<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable border1">
<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
			
			
			<tr>
				<td>Proposal Submitted To</td>
				<td><select name="sel_proposalsubmit" disabled="disabled" >
					<option value="s">--Select--</option>
					<lapschoice:StaticDataNewTag apptype="21"/>
					</select></td>
					</tr>
			<tr>		
			<td>Permitting Department&nbsp;<span class="mantatory"><b>*</b></span></td>
			<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
			<tr>
			<td>
			<select name="sel_SancDept"  onchange="funsanctiondept('s','Y');">
			<option value="s">--Select--</option>
			<lapschoice:CBSStaticDataNewTag apptype="26" />
			</select>
			</td>
				<td id="idsanbranch">
			<select name="sel_SancBranch" >
			<option value="">--Select--</option>
			</select>
			</td>
			
			</tr>
			</table>
			</td>	
			<td>Permission intimation Mode&nbsp;<span class="mantatory"><b>*</b></span></td>
			<td><select name="sel_SancLevel" style="width:200px;">
			<option value="s">--Select--</option>
				<lapschoice:CBSStaticDataNewTag apptype="14"  />		
			</select></td>				
			</tr>
		
		
			<tr>
				<td>Permitting Authority&nbsp;<span class="mantatory"><b>*</b></span></td>
			<td>
			<select name="sel_SancAuth" onChange="funsancrefno('Y')"  style="width:200px;" >
			<option value="s">--Select--</option>
			</select>
			</td>
			</tr>
			<tr>
					<td id="sanrefno">Permission Reference No.&nbsp;<span class="mantatory"><b>*</b></span></td>
				<td id="sanrefval"><input type="text" 	name="txt_sancrefno"  value="<%=Helper.correctNull((String)hshValues.get("PERM_REFNO"))%>" size="30" maxlength="50" /></td></td>			
			</tr>
			<tr>
				<td>&nbsp;&nbsp;</td><td>&nbsp;&nbsp;</td>
				<td id="sancdate1">Permission date &nbsp;<span class="mantatory"><b>*</b></span></td>	
				<td id="sancdate2">
					<input type="text" name="sanctiondate" maxlength="10" 
					 size="12"
					onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String) hshValues.get("PERM_SANC_DATE"))%>" onBlur="checkDate(this);checkmaxdate(this,currentdate);">
				  	&nbsp;<a alt="Select date from calender" href="#" 
									onClick="callCalender('sanctiondate')"
									onMouseOver="window.status='Date Picker';return true;"
									onMouseOut="window.status='';return true;"><img
									src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border=0
									alt="Select date from calender" ></a></td>
			</tr>
		<tr>
				
				<td id="idprocfee">Handling Charges &nbsp;<span class="mantatory"><b>*</b></span></td>
				<td id="idprocfee1"><input type="text"  name="txt_procfee" value='<%=Helper.correctNull((String) hshValues.get("PERM_HANDLING_CHARGE"))%>' size="15" maxlength="12" style="text-align: right;" onblur="roundtxt(this)" onkeypress="allowNumber(this)"/></td>
				<%if (orglevel.equals("D")||orglevel.equals("C")){ %>
				<td>Permission pertains to the branch</td>
				<td><input type="hidden" name="hid_perbranch" value="<%=Helper.correctNull((String) hshValues.get("strBranchCode"))%>">
					<input type="text" name="txt_perbranch" value="<%=Helper.correctNull((String) hshValues.get("strBranchName"))%>"> 
					<b><a href="#" onClick="showOrganizationSearch('<%=ApplicationParams.getAppUrl()%>','hid_perbranch','txt_perbranch')"
					style="cursor: hand">
					<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0" ></a></b></td>
					<%} %>
			</tr>
			</table>
      </td>
      
      
      </tr>
    </table>

<iframe height="0" width="0" name="ifrmsancauthority" frameborder="0" style="border:0"></iframe>
<iframe height="0" width="0" name="ifrmsancbranch" frameborder="0" style="border:0"></iframe>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete'  btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hid_sancdept_flag">
</form>
</body>
</html>
