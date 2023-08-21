<%@include file="../share/CKEditor.jsp"%>
<%@include file="../share/directives.jsp"%>

<html>
<head>
<title>Comments</title>
<!-- WYSWYG TEXTAREA -->
<script src="<%=ApplicationParams.getAppUrl()%>js/share/editor.js">
</script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>ckeditor/ckeditor.js"></script>

<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var module='<%=Helper.correctNull((String)hshValues.get("sel_module"))%>';
var doctype='<%=Helper.correctNull((String)hshValues.get("sel_doctype"))%>';
var docuname='<%=Helper.correctNull((String)hshValues.get("sel_docuname"))%>';
var dynamiccontent='<%=Helper.correctNull((String)hshValues.get("sel_dynamiccontent"))%>';
var strModuleType ="<%=Helper.correctNull((String)hshValues.get("sel_module"))%>";
var sel_docsubtype='<%=Helper.correctNull((String)hshValues.get("sel_docsubtype"))%>';
function rtnKeyword(){
	return;
}

function docTemplateVisibility(){
	if(document.forms[0].sel_dynamiccontent.value=="S"){
		alert("Select Whether document contains dynamic content ");
	}
	else if(document.forms[0].sel_dynamiccontent.value=="Y"){
		document.all.bodycontenttemplate1.style.visibility="visible";
		document.all.bodycontenttemplate1.style.position="relative";

		document.all.bodycontenttemplate2.style.visibility="visible";
		document.all.bodycontenttemplate2.style.position="relative";
	}
	else if(document.forms[0].sel_dynamiccontent.value=="N"){
		document.all.bodycontenttemplate1.style.visibility="hidden";
		document.all.bodycontenttemplate1.style.position="absolute";

		document.all.bodycontenttemplate2.style.visibility="hidden";
		document.all.bodycontenttemplate2.style.position="absolute";
	}
}

function callOnload(){
	EditorEnableDisable("id_div","block","id_editor","none");
	
	disableFields(true);

	if(doctype!=""){
		document.forms[0].sel_doctype.value=doctype;
	}
	else{
		document.forms[0].sel_doctype.value="S";
	}
	
	if(sel_docsubtype!="")
	{
		document.forms[0].sel_docsubtype.value=sel_docsubtype;
	}
	else
	{
		document.forms[0].sel_docsubtype.value="S";
	}
	chktype();
	if(docuname!=""){
		
		document.forms[0].sel_docuname.value=docuname;
	}
	else{
		document.forms[0].sel_docuname.value="S";
	}

	if(dynamiccontent=="Y"){
		document.forms[0].sel_dynamiccontent.value=dynamiccontent;

		document.getElementById("bodycontenttemplate1").style.visibility="visible";
		document.getElementById("bodycontenttemplate1").style.position="relative";
		
		document.getElementById("bodycontenttemplate2").style.visibility="visible";
		document.getElementById("bodycontenttemplate2").style.position="relative";
	}
	else if(dynamiccontent=="N"){
		document.forms[0].sel_dynamiccontent.value=dynamiccontent;

		document.getElementById("bodycontenttemplate1").style.visibility="hidden";
		document.getElementById("bodycontenttemplate1").style.position="absolute";
		
		document.getElementById("bodycontenttemplate2").style.visibility="hidden";
		document.getElementById("bodycontenttemplate2").style.position="absolute";
	}
	else{
		document.forms[0].sel_dynamiccontent.value="S";
	}
	
	var strModuleType_temp =strModuleType.split("@");	
	for(var i=0;i<strModuleType_temp.length-1;i++)
	{
		var selValue=strModuleType_temp[i];

		if(selValue=="ret")	
		{		
			document.forms[0].sel_module.options[0].selected=true;
		}			
		else if(selValue=="corp")
		{			
			document.forms[0].sel_module.options[1].selected=true;
		}
		else if(selValue=="agr")
		{			
			document.forms[0].sel_module.options[2].selected=true;
		}
		else if(selValue=="dev")
		{			
			document.forms[0].sel_module.options[3].selected=true;
		}
		else if(selValue=="rating")
		{			
			document.forms[0].sel_module.options[4].selected=true;
		}
		else if(selValue=="msme")
		{			
			document.forms[0].sel_module.options[5].selected=true;
		}
	}
	
		
}
function callDocName(){
	if(document.forms[0].cmdedit.disabled==false){
	document.forms[0].hidBeanId.value="securitymaster";
    document.forms[0].hidBeanGetMethod.value="getDocumentMaster"; 
	document.forms[0].action=appURL+"action/dynamicdocumentmaster.jsp";
	document.forms[0].submit();
	}
	else{
		alert("Please cancel and change the option");
	}
}
	function disableFields(val)
	{
		for(var i=0;i<document.forms[0].length;i++)
		{
			if(document.forms[0].elements[i].type=='text')
		 	{
				document.forms[0].elements[i].disabled=val;
			}	  
			if(document.forms[0].elements[i].type=='select-one')
			{
				document.forms[0].elements[i].disabled=val;
			}
			if(document.forms[0].elements[i].type=='radio')
			{
				document.forms[0].elements[i].disabled!=val;
			}	
			if(document.forms[0].elements[i].type=='textarea')
		 	{
				document.forms[0].elements[i].disabled=val;
			}
		}
		document.forms[0].txt_docuid.readOnly=true;
		document.forms[0].sel_docuname.disabled=false;
		
	}

function doEdit()
{
	
		EditorEnableDisable("id_div","none","id_editor","block");
		editor_generate('txtarea_documentmaster');
		document.forms[0].hidAction.value="insert";
		disableCommandButtons("edit");
		disableFields(false);	
	
}
function doCancel()
{
	 
			document.forms[0].action=appURL+"action/dynamicdocumentmaster.jsp";		
		 	document.forms[0].submit();
}

function doClose(){

	document.forms[0].action=appURL+"action/setupnav.jsp";		
 	document.forms[0].submit();
}

function doDelete(){
	document.forms[0].hidAction.value="delete";
	document.forms[0].hidBeanId.value="securitymaster";
    document.forms[0].hidBeanGetMethod.value="updateDocumentMaster"; 
    document.forms[0].action=appURL+"action/dynamicdocumentmaster.jsp";
	document.forms[0].submit();
}



function disableCommandButtons(val)
{
	if(val=="edit"){ 
		 
		 document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmdsave.disabled=false;
		 document.forms[0].cmddelete.disabled=true;
		 document.forms[0].cmdcancel.disabled=false;
		 document.forms[0].cmdclose.disabled=true;	 
		 disableFields(false);
	}
	if(val=="radio")
	{
		
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmdsave.disabled=false;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdcancel.disabled=false;
		document.forms[0].cmdclose.disabled=false; 
	}
	         		
}


function doSave()
{
	  	var str_ModuleType ="";
		for(var i=0;i<document.forms[0].sel_module.options.length;i++)
		{
			if(document.forms[0].sel_module.options[i].selected)
			{				
				str_ModuleType=str_ModuleType+document.forms[0].sel_module.options[i].value+"@";
			}		
		}
		
		if(str_ModuleType=="")
		{
			alert("Select the Module");
			return false;
		}

		if(document.forms[0].txt_jspname.value=="")
		{
			alert("Enter Document ID");
			document.forms[0].txt_jspname.focus();
			return;
		}
		
		if(document.forms[0].sel_doctype.value=="A")
		{
			if(document.forms[0].sel_docsubtype.value=="S")
			{
				alert("Select Document type");
				document.forms[0].sel_docsubtype.focus();
				return;
			}
		}
		
		document.forms[0].hidsel_module.value=str_ModuleType;
	
	document.forms[0].hidBeanId.value="securitymaster";
    document.forms[0].hidBeanGetMethod.value="updateDocumentMaster"; 
	document.forms[0].action=appURL+"action/dynamicdocumentmaster.jsp";
	document.forms[0].submit();
}
function editor_generate(name)
{
	CKEDITOR.replace( name, {
		height: 260,
		width: 700,
	} );
}
function CallTemplate()
{
	var prop = "scrollbars=yes,width=850,height=550,menubar=yes";
	var title = "Templates";
	var xpos = 100;
	var ypos = 55;
	prop = prop + ",left="+xpos+",top="+ypos;
	var url=appURL+"action/doc_templates.jsp";
	window.open(url,title,prop);
}
function chktype()
{
	if(document.forms[0].sel_doctype.value=="A" || document.forms[0].sel_doctype.value=="O")
	{
		document.forms[0].sel_dynamiccontent.value="N";
		docTemplateVisibility();

		if(document.forms[0].sel_doctype.value=="A")
		{
			document.all.iddoc_subtype.style.visibility="visible";
			document.all.iddoc_subtype.style.position="relative";
		}
		else
		{
			document.all.iddoc_subtype.style.visibility="hidden";
			document.all.iddoc_subtype.style.position="absolute";
		}
	}
	else
	{
		document.all.iddoc_subtype.style.visibility="hidden";
		document.all.iddoc_subtype.style.position="absolute";
	}
	if(document.forms[0].sel_doctype.value=="I" || document.forms[0].sel_doctype.value=="O")
	{
		document.forms[0].sel_docsubtype.value="post";
	}
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad="callOnload()">
<form method=post class="normal">
<table width="96%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
	
	 <tr>
		<td class="page_flow">Home -&gt; Setup -&gt; Other Setup &amp;  Dynamic Document Master</td>
	</tr>
	</table>
	&nbsp;

<table width="90%" border="0" cellspacing="3" cellpadding="1" align="center" class="outertable border1 tableBg">
		<tr>
	   <td>
<table cellspacing="3" border="0" cellpadding="1"  class="outertable" width="96%"  align="center" height="80%">
    <tr>
        <td class="setuphead" colspan="4">Dynamic Document Master</td >
    </tr>
    <tr>
    
	<tr>
		<td width="35%%">&nbsp;Document Name</td>
		<td >
		     <select name="sel_docuname" style="width:130" onChange="callDocName();">
					<option value="S">---Select---</option>
					 <lapschoice:StaticDataNewTag apptype="191"/>
			</select>
		</td>
	</tr>
	
	

	
	<tr>
	     <td>&nbsp;Document ID</td>
	     <td width="30%"><input type="hidden" name="txt_docuid" size="15" maxlength="15" value="<%=Helper.correctNull((String)hshValues.get("txt_docuid"))%>">
	     <input type="text" name="txt_jspname" size="15" maxlength="15" value="<%=Helper.correctNull((String)hshValues.get("txt_jspname"))%>"></td>
	     
	     <td>&nbsp;Module</td>
	     <td><select multiple="multiple" size="6"  name="sel_module">
	     <option value="ret">Retail</option>
	     <option value="corp">Corporate</option>
	     <option value="agr">Agriculture</option>
	     <option value="dev">Permission</option>
	     <option value="rating">Only for Rating</option>
	     <option value="msme">MSME</option>
	     </select></td>
	    
	      
	</tr>

	<tr>
	<td>&nbsp;Document Type
	</td>
	 <td>
	 	<table border="0" cellspacing="3" cellpadding="1">
			<tr>
			<td><select name="sel_doctype" onchange="chktype()">
				<option value="S">---Select---</option>
				<option value="A">By Applicant</option>
				<option value="I">By Bank</option>
				<option value="O">Others</option></select></td>
			
			<td id="iddoc_subtype"><select name="sel_docsubtype">
				<option value="S">---Select---</option>
				<option value="pre">Pre-Sanction Document</option>
				<option value="post">Post-Sanction Document</option></td>
			</tr>
	 	</table>
	 </td>

	 
	 
	
	 </tr>
	 <tr>
	 <td>&nbsp;Dynamic Content &nbsp;Modification </td>
	 <td><select name="sel_dynamiccontent" onChange="docTemplateVisibility();chktype();">
	 <option value="S">---Select---</option>
	 <option value="Y">Yes</option>
	 <option value="N">No</option>
	 </select>
	</tr>
	<tr id="bodycontenttemplate1">
	   <td colspan="2" >&nbsp;Document Template</td>
	   <td>&nbsp;Keyword </td>
	   <td rowspan="2"  valign="top">
	   	<table>
	   	<tr>
	   	<td>
		 	 <select multiple size="12"  name="keywordlist">
		     <option value="Borrower">BorrowerName---@Borrower</option>
		     <option value="Loanamount">LoanAmount---@Loanamount</option>
		     <option value="Tenor">Tenor---@Tenor</option>
		     <option value="Inwardnumber">Inwardnumber---@Inwardnumber</option>
		     <option value="Applicationnumber">ApplicatioNumber---@Applicationnumber</option>
		     <option value="Interestrate">Interestrate---@Interestrate</option>
		     <option value="Interesttype">Interesttype---@Interesttype</option>
		     <option value="EMI">EMI---@EMI</option>
		     <option value="CBSID">CBSID---@CBSID</option>
		     <option value="Approvername">Approvername---@Approvername</option>
		     <option value="Approverfathername">Approverfathername---@Approverfathername</option>
		     <option value="CBSAccountnumber">CBSAccountnumber---@CBSAccountnumber</option>
		     <option value="Guarantor">Guarantor name---@Guarantor</option>
		     <option value="Branchname">Branch name---@Branchname</option>
		     <option value="Sancreference">Sanction Reference Number---@Sancreference</option>
		     <option value="Sancdate">Sanction Date---@Sancdate</option>
		     <option value="Sancamount">Sanction Amount in Words---@Sancamount</option>
		     <option value="Mclrtype Type">Reference Type---@Mclrtype</option>
		     <option value="Repayment">Repayment---@Repayment</option>
		      <option value="Purpose">Purpose---@Purpose</option>
		   	<option value="TransferorName">TransferorName---@TransferorName</option>
		   	<option value="TransferorAddress">TransferorAddress---@TransferorAddress</option>
		   	<option value="orgHead_name">Branch Head_name---@orgHead_name</option>
		   	<option value="branchDetails">branchDetails---@branchDetails</option>
		   	<option value="Scheme">Scheme---@Scheme</option>
		   	<option value="BranchCity">BranchCity---@BranchCity</option>
		   	<option value="MCLRreset">MCLRreset---@MCLRreset</option>
		   
		   	<option value="date">date---@date</option>
		   	<option value="spreadrate">spreadrate---@spreadrate</option>
		   	<option value="SecurityDesc">SecurityDesc---@SecurityDesc</option>
		   	<option value="noofemi">NumberoofEMI---@noofemi</option>
		    <option value="mclrrate">MclrRate---@mclrrate</option>
		    <option value="VehicleHypothication">Particulars of Hypothecated Machineries---@VehicleHypothication</option>
		    <option value="PageBreak">PageBreak---@PageBreak</option> 		    
		    <option value="GroupBorrowersno">GroupBorrowersno---@GrpBorrowersno</option> 		    
		    <option value="Karta">Karta---@Karta</option> 		    
		    <option value="HUF Minor Member Details">HUF Minor Member Details---@HUFMinorDetails</option> 		    
		    <option value="Aadhar">Aadhaar No---@Aadhaar</option> 		    
		    <option value="date_of release">MCLR Release Date---@date_of_release</option> 		    
		    <option value="natureofactivity">Nature of Activity---@natureofactivity</option> 		    
		    <option value="inwarddate">Inward Created Date---@inwarddate</option> 		    
		    <option value="Account Operated by">Account Operated by---@accountoperation</option> 		    
		    <option value="Due Date">Due Date---@duedate</option> 		    
		    <option value="Existing Limit">Existing Limit---@Existinglimit</option> 		    
		    <option value="Proposed Limit">Proposed Limit---@proposedlimit</option> 		    
		    <option value="Change in Limit">Change in Limit---@changeinlimit</option> 		    
		    <option value="Outstanding Balance">Outstanding Balance---@odosbalance</option> 		    
		    <option value="Security Owner Address">Security Owner Address---@Securityowneraddress</option> 		    
		    <option value="Deed deposited Branch">Deed deposited Branch---@titledeeddepositbranch</option> 		    
		    <option value="Deed Deposited Date">Deed Deposited Date---@titledeeddepositdate</option> 		    
		    <option value="Old Sanctions">Old Sanctions---@oldsanctions</option> 		    
		    <option value="Borrower MDTD Details">Borrower MDTD Details---@borrowermdtd</option> 		    
		    <option value="Other than Borrower MDTD Details">Other than Borrower MDTD Details---@otherborrowermdtd</option> 		    
		    <option value="Borrower Security Description">Borrower Security Description---@borrowersecdesc</option> 		    
		    <option value="Other than Borrower Security Description">Other than Borrower Security Description---@otherborrowersecdesc</option> 		    
		    <option value="Type of Loan">Type of Loan---@Typeofloan</option> 		    
		    <option value="Borrower Security Details">Borrower Security Details---@borrowersecuritydetails</option> 		    
		    <option value="Other Borrower Security Details">Other Borrower Security Details---@otherborrowersecuritydetails</option> 		    
		    <option value="Co-applicant Names">Co-applicant Names---@coapplicant</option> 		    
		    <option value="Co-Obligant Names">Co-Obligant Names---@coobligant</option> 		    
		    <option value="Approver Designation">Approver Designation---@approverdesignation</option> 		    
		    <option value="Staff no">Staff no---@staffno</option> 		    
		    <option value="Staff Designation">Staff Designation---@staffdesignation</option> 		    
		    <option value="Staff Working Branch">Staff Working Branch---@staffworkingbranch</option> 		    
		    <option value="Minimum Product Range">Minimum Product Range---@minprodrange</option> 		    
		    <option value="Minimum Product Interest">Minimum Product Interest---@minprodint</option> 		    
		    <option value="Tenor Excluding Holiday">Tenor Excluding Holiday---@tenorexholiday</option> 		    
		    <option value="Repayment Months">Repayment Months---@repmths</option> 		    
		    <option value="Interest Charging Frequency">Interest Charging Frequency---@intchargedfrequency</option> 		    
		    <option value="Tenor in Years">Tenor in Years---@tenorinyears</option> 		   
		    <option value="Clean Security Description">Clean Security Description---@clsecdesc</option> 			   
		    <option value="Clean Security Owneraddress">Clean Security Owneraddress---@clsecurityowneraddress</option> 		
		    <option value="Clean Security Ownerdetails">Clean Security Ownerdetails---@clsecurityownerdetails</option> 			   
		     
		     <option value="Bankers Certificate ReferencenNo">Bankers Certificate ReferencenNo---@bclcrefno</option> 			   
		    <option value="Bankers Certificate Name">Bankers Certificate Name---@bclcName</option> 		
		    <option value="Bankers Certificate Address">Bankers Certificate Address---@bclcAddr</option> 
		   	
		     
		     <option value="Bankers Certificate NatureofAct">Bankers Certificate NatureofAct---@bclcNatureofAct</option> 
		     <option value="Bankers Certificate BreifWorkers">Bankers Certificate BreifWorkers---@bclcBreifWorkers</option> 
		     <option value="Bankers Certificate bankamt">Bankers Certificate bankamt---@bclcbankamt</option> 
		      
		       <option value="Bankers Certificate Expdate">Bankers Certificate Expdate---@bclcbankExpdate</option> 
		       <option value="Bankers Certificate Branch">Bankers Certificate Branch---@bclcbankBranch</option> 
		 	</select>
		 </td>
		 </tr>
		 <tr>
		 <td align="center"><br/><input type="button" name="cmd_templates" value="Default Templates" onclick="CallTemplate();" class="buttonStyle"></td>
		 </tr>
		 
		</table>
	 </td>
	</tr>
	<tr id="bodycontenttemplate2">
	<td colspan="2">
	<div id="id_div"><div class="EditorClassNew"><%=Helper.correctNull((String)hshValues.get("txtarea_documentmaster"))%></div></div>
		<div id="id_editor">
		<textarea name="txtarea_documentmaster" cols="160" rows="12" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)">
		<%=Helper.correctNull((String)hshValues.get("txtarea_documentmaster"))%>
			</textarea> </div>
	</td>
	</tr>
	<tr>
	<td colspan="2" align="right">
	</td>
	
	
	</tr>

	

</table>


		</td>
	</tr>
</table>


&nbsp;
<lapschoice:combuttonnew btnnames="Edit_Save_Delete_Cancel" btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />

<input type="hidden" name="hidAction">
<input type="hidden" name="hidBeanId">
<input type="hidden" name="hidBeanMethod" value="">
<input type="hidden" name="hidBeanGetMethod" value="">
<input type="hidden" name="hidSourceUrl" value="">
<input type="hidden" name="hidsno" value="<%=Helper.correctNull((String)hshValues.get("sno"))%>">
<input type="hidden" name="hidsel_module" value="">

</form>

</body>


</html>
