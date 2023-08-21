<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Due Diligence Report-New Page</title>
</head>
<%
String appno=Helper.correctNull((String)hshValues.get("appno"));
String strDemoId=Helper.correctNull((String)hshValues.get("DemoId"));
String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
String strAppId = Helper.correctNull((String)hshValues.get("strappId"));
if(strAppId.equals(""))
{
	strAppId=Helper.correctNull((String)hshValues.get("hidapplicantid"));
}
%>
<script>

var appURL="<%=ApplicationParams.getAppUrl()%>";
var varDemoId="<%=strDemoId%>";
var varWHT_PHYINSP="<%=Helper.correctNull((String)hshValues.get("DDR_WHT_PHYINSP"))%>";
var curdate = "<%=Helper.getCurrentDateTime()%>";
var varpanno="<%=Helper.correctNull((String)hshValues.get("perapp_panno"))%>";
var varemploymentstatus="<%=Helper.correctNull((String)hshValues.get("perapp_employment"))%>";
var varPEREMP_SALARYROUTED="<%=Helper.correctNull((String)hshValues.get("PEREMP_SALARYROUTED"))%>";
var varDDRRecordFlag="<%=Helper.correctNull((String)hshValues.get("strDDRRecordFlag"))%>";
var varStockExchange="<%=Helper.correctNull((String)hshValues.get("DDR_LISTEDEMPLOYER"))%>";

function callCalender(fname)
{
	if(document.all.cmdedit.disabled==true)
	{
		showCal(appURL,fname);
	}else{
		alert("Enable the edit Mode");
	}
}

function getdata2()
{
	if(document.all.sel_phyinsp.value=="Y")
	{
		document.all.p1.style.display="table-row";	
		document.all.p2.style.display="none";		
			
	}
	else if(document.all.sel_phyinsp.value=="N")
	{
		document.all.p2.style.display="table-row";	
		document.all.p1.style.display="none";			
	}
	else if(document.all.sel_phyinsp.value=="")
	{
		document.all.p2.style.display="none";	
		document.all.p1.style.display="none";			
	}
}

function get_FNo()
{
	if(document.all.sel_fno.value=="Y")
	{
		document.all.f1.style.display="table-cell";	
	}
	else if(document.all.sel_fno.value=="N"||document.all.sel_fno.value=="")
	{
		document.all.f1.style.display="none";			
	}
}
function showOrganizationSearch(path, forgscode, forgname)
{  
	if(document.forms[0].cmdedit.disabled==true)
	{

		var varQryString = path+"action/searchOrg.jsp?forgscode="+forgscode+"&forgname="+forgname;
		var title = "Organization";
		var prop = "scrollbars=yes,width=500,height=400,menubar=yes";	
		var xpos = (screen.width - 450) / 2;
		var ypos = (screen.height - 120) / 2;
		prop = prop + ",left=50,top=50";
		window.open(varQryString,title,prop);
		
	}else{
		alert("Enable the edit Mode");
		
	}
}

function hidd()
{
	document.all.f1.style.display="none";
	document.all.p2.style.display="none";	
	document.all.p1.style.display="none";
}

function callBankmaster(id,val,rowIndex)
{   
	var tab  = document.getElementById("id_presentBank");
	var rowcount = tab.rows.length;
	var pagename="DDR"+val;
	if(document.forms[0].cmdedit.disabled==true)
	{
			var varQryString = appURL+"action/ops_sanctionhelp.jsp?hidBeanGetMethod=getSearch&hidBeanId=additionalParameter&pagename="+pagename+"&id="+id+"&rowcount="+rowcount+"&rowIndex="+rowIndex;
			var title = "Bank_Master";
			var prop = "scrollbars=no,width=650,height=400";
			var xpos = "50";
			var ypos = "50";
			prop = prop+","+xpos+","+ypos+",left=200,top=200";
			window.open(varQryString,title,prop);
}else{
	alert("Enable the edit Mode");
}
	
}
function callUsersHelp(val)
{
	if(document.forms[0].cmdedit.disabled==true)
	{
		var pagefield="DDR"+val;
		var varQryString = appURL+"action/setUserSearch.jsp?pagefrom="+pagefield;
		var title = "Users";
		var prop = "scrollbars=yes,width=650,height=400,menubar=yes";	
		var xpos = (screen.width - 350) / 2;
		var ypos = (screen.height - 120) / 2;
		prop = prop + ",left=50,top=50";
		window.open(varQryString,title,prop);
	}else{
		alert("Enable the edit Mode");
	}
}

function placevalues()
{
	document.all.sel_fno.value="<%=Helper.correctNull((String)hshValues.get("DD_FNO60DETAILS"))%>";
	document.all.sel_appnt_act.value="<%=Helper.correctNull((String)hshValues.get("DD_CARRYINGACTIVITYIN"))%>";
	
	var varfno=document.all.sel_fno.value;      //4
	if(varfno!="")
	{
		document.all.sel_fno.value =varfno;
	}
	else
	{
		document.all.sel_fno.value = "";
	}
	
	var varappntact=document.all.sel_appnt_act.value;     //6
	if(varappntact!="")
	{
		document.all.sel_appnt_act.value =varappntact;
	}
	else
	{
		document.all.sel_appnt_act.value = "";
	}
	

}

function onload()
{
	if(varDDRRecordFlag=="N")
	{
		if(confirm("Whether Due diligence needs to be copied from previous sanctioned proposal"))
		{
			document.forms[0].hidAction.value ="C";
			document.forms[0].hidSourceUrl.value="/action/due_report.jsp";
			document.forms[0].hidBeanId.value="documentsupport";
			document.forms[0].hidBeanMethod.value="updatedueReport";
			document.forms[0].hidBeanGetMethod.value="getdueReport";
			document.forms[0].action=appURL+"controllerservlet";
			document.forms[0].submit();
		}
	}
	if(varDemoId!="")
	{
		document.forms[0].hidDemoId.value=varDemoId;
	}
	if(varWHT_PHYINSP!="")
	{
		document.forms[0].sel_phyinsp.value=varWHT_PHYINSP;
	}
	if(varStockExchange!="")
	{
		document.forms[0].sel_stocexchange.value=varStockExchange;
	}
	enablestockname();
	placevalues();
	hidd();
	getdata2();
	if(varpanno=="")
	{
		document.all.id_panno.style.display="table-row";
	}
	else
	{
		document.all.id_panno.style.display="none";
	}
	if(varemploymentstatus=="4")
	{
		document.all.id_agriActivity.style.display="table-row";
	}
	else
	{
		document.all.id_agriActivity.style.display="none";
	}
	if(varemploymentstatus=="1")
	{
		document.all.idsalariedDet.style.display="table-row";
	}
	else
	{
		document.all.idsalariedDet.style.display="none";
	}
	if(varemploymentstatus=="2" || varemploymentstatus=="3")
	{
		document.all.idSelfEmpDet.style.display="table-row";
	}
	else
	{
		document.all.idSelfEmpDet.style.display="none";
	}
	
	get_FNo();

	//clearrows("id_presentBank");	
	document.forms[0].cmdedit.disabled=true;
	presBankDisp();
	disableFields(true);
	document.forms[0].hidDemoId.disabled=false;
	if(document.forms[0].btnenable.value=='Y')
	{
		document.forms[0].cmdedit.disabled=false;
	}
	else
	{
		document.forms[0].cmdedit.disabled=true;
	}

	if(document.forms[0].hidDemoId.value=="")
	{
		document.forms[0].cmdedit.disabled=true;
	}
	
}
function clearrows(tabid)
{
	var table=document.getElementById(tabid);
	var rowCount=table.rows.length;
	if(rowCount > 1)
	{
		for(var i=rowCount-1;i>0;i--)
		{
			table.deleteRow(i);      
		}
	}
}
function displayval()
{
	
	if(document.all.sel_phyinsp.value=="Y")
	{
		document.forms[0].txt_Phy_no.value ="";	
			
	}
	else if(document.all.sel_phyinsp.value=="N")
	{
		document.forms[0].txt_phyinsp_Userid.value ="";
		document.forms[0].txt_phyinsp_username.value ="";
		document.forms[0].txt_phyinsp_design.value ="";
	}
	else if(document.all.sel_phyinsp.value=="")
	{
		document.forms[0].txt_phyinsp_Userid.value ="";
		document.forms[0].txt_phyinsp_username.value ="";
		document.forms[0].txt_phyinsp_design.value =""; 
		document.forms[0].txt_Phy_no.value ="";		
	}

	if(document.all.sel_fno.value=="N"||document.all.sel_fno.value=="")
	{
		document.forms[0].txt_sel_fno.value ="";			
	}
	
}

function doSave()
{
	var varbool="true";
	if(document.forms[0].sel_phyinsp.value=="")
	{
		alert("Select Whether Physical Inspection done");
		document.forms[0].sel_phyinsp.focus();
		return;
	}
	else if(document.forms[0].sel_phyinsp.value=="Y" && document.forms[0].txt_phyinsp_Userid.value=="")
	{
		alert("Select Name of the official who has confirmed the Physical address");
		document.forms[0].txt_phyinsp_Userid.focus();
		return;
	}
	else if(document.forms[0].sel_phyinsp.value=="N" && document.forms[0].txt_Phy_no.value=="")
	{
		alert("Enter the Reason for not physically verifying the address");
		document.forms[0].txt_Phy_no.focus();
		return;
	}
	else if(document.forms[0].txt_passport_number.value=="" && document.forms[0].txt_DL_number.value=="" &&
			document.forms[0].txt_ElectionCard_number.value=="" && document.forms[0].txt_otherDoc1_number.value=="" &&
			document.forms[0].txt_otherDoc2_number.value=="" && document.forms[0].txt_otherDoc3_number.value=="")
	{
		alert("atleast one document details needs to be entered");
		return;
	}
	else if(document.forms[0].txt_passport_number.value!="" && document.forms[0].txt_passport_expdate.value=="")
	{
		alert("Select Passport Expiry Date");
		document.forms[0].txt_passport_expdate.focus();
		return;
	}
	else if(document.forms[0].txt_passport_number.value!="" && document.forms[0].txt_passport_place.value=="")
	{
		alert("Select Passport Issued Place");
		document.forms[0].txt_passport_place.focus();
		return;
	}
	else if(document.forms[0].txt_DL_number.value!="" && document.forms[0].txt_DL_expdate.value=="")
	{
		alert("Select Driving License Expiry Date");
		document.forms[0].txt_DL_expdate.focus();
		return;
	}
	else if(document.forms[0].txt_DL_number.value!="" && document.forms[0].txt_DL_place.value=="")
	{
		alert("Select Driving License Issued Place");
		document.forms[0].txt_DL_place.focus();
		return;
	}
	else if(document.forms[0].txt_ElectionCard_number.value!="" && document.forms[0].txt_ElectionCard_expdate.value=="")
	{
		alert("Select Election Card Expiry Date");
		document.forms[0].txt_ElectionCard_expdate.focus();
		return;
	}
	else if(document.forms[0].txt_ElectionCard_number.value!="" && document.forms[0].txt_ElectionCard_place.value=="")
	{
		alert("Select Election Card Issued Place");
		document.forms[0].txt_ElectionCard_place.focus();
		return;
	}
	else if(document.forms[0].txt_otherDoc1_number.value!="" && document.forms[0].txt_otherdoc1_name.value=="")
	{
		alert("Select Document Name");
		document.forms[0].txt_otherdoc1_name.focus();
		return;
	}
	else if(document.forms[0].txt_otherDoc1_number.value!="" && document.forms[0].txt_otherDoc1_expdate.value=="")
	{
		alert("Select Document Expiry Date");
		document.forms[0].txt_otherDoc1_expdate.focus();
		return;
	}
	else if(document.forms[0].txt_otherDoc1_number.value!="" && document.forms[0].txt_otherDoc1_place.value=="")
	{
		alert("Select Document Issued Place");
		document.forms[0].txt_otherDoc1_place.focus();
		return;
	}
	else if(document.forms[0].txt_otherDoc2_number.value!="" && document.forms[0].txt_otherdoc2_name.value=="")
	{
		alert("Select Document Name");
		document.forms[0].txt_otherdoc2_name.focus();
		return;
	}
	else if(document.forms[0].txt_otherDoc2_number.value!="" && document.forms[0].txt_otherDoc2_expdate.value=="")
	{
		alert("Select Document Expiry Date");
		document.forms[0].txt_otherDoc2_expdate.focus();
		return;
	}
	else if(document.forms[0].txt_otherDoc2_number.value!="" && document.forms[0].txt_otherDoc2_place.value=="")
	{
		alert("Select Document Issued Place");
		document.forms[0].txt_otherDoc2_place.focus();
		return;
	}
	else if(document.forms[0].txt_otherDoc3_number.value!="" && document.forms[0].txt_otherdoc3_name.value=="")
	{
		alert("Select Document Name");
		document.forms[0].txt_otherdoc3_name.focus();
		return;
	}
	else if(document.forms[0].txt_otherDoc3_number.value!="" && document.forms[0].txt_otherDoc3_expdate.value=="")
	{
		alert("Select Document Expiry Date");
		document.forms[0].txt_otherDoc3_expdate.focus();
		return;
	}
	else if(document.forms[0].txt_otherDoc3_number.value!="" && document.forms[0].txt_otherDoc3_place.value=="")
	{
		alert("Select Document Issued Place");
		document.forms[0].txt_otherDoc3_place.focus();
		return;
	}
	else if(eval(document.forms[0].hidresidence.value)<1 && (document.forms[0].txt_app_residing.value==""))
	{
		alert("Enter the Details of residence");
		document.forms[0].txt_app_residing.focus();
		return;
	}
	else if(document.forms[0].txt_staffid.value=="")
	{
		alert("Select Name of the official who has complied with KYC at the time of opening the operative account");
		document.forms[0].txt_staffid.focus();
		return;
	}
	if(varPEREMP_SALARYROUTED=="O" && varemploymentstatus=="1")
	{
		if(document.forms[0].txt_bankname.value=="")
		{
			alert("Select Bank Name");
			document.forms[0].txt_bankname.focus();
			return;
		}
		else if(document.forms[0].txt_salbrnch_name.value=="")
		{
			alert("Enter Branch Name");
			document.forms[0].txt_salbrnch_name.focus();
			return;
		}
		else if(document.forms[0].txt_salacc_num.value=="")
		{
			alert("Enter Account Number");
			document.forms[0].txt_salacc_num.focus();
			return;
		}
	}
	displayval();
	//disablefields(true);
	if(document.forms[0].txt_Bank.length==undefined)
	{
		//if(document.forms[0].txt_Bank.value=="")
		{
			//alert("Select Bank name");
			//return;
		}
	}
	else
	{
		for(var i=0;i<document.forms[0].txt_Bank.length;i++)
		{
			if(document.forms[0].txt_Bank[i].value=="")
			{
				alert("Select Bank name");
				document.forms[0].txt_Bank[i].focus();
				return;
			}
		}
	}
	document.forms[0].hidAction.value ="I";
	document.forms[0].hidSourceUrl.value="/action/due_report.jsp";
	document.forms[0].hidBeanId.value="documentsupport";
	document.forms[0].hidBeanMethod.value="updatedueReport";
	document.forms[0].hidBeanGetMethod.value="getdueReport";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();

}
function doEdit()
{ 	
	disableFields(false);
	disableCommandButtons(true,false,false,false,true);
	document.forms[0].txt_since_bank.readOnly=true;	
	document.forms[0].txt_LoanDisbBranch.readOnly=true;	
	document.forms[0].txt_staffid.readOnly=true;	
	document.forms[0].txt_staffname.readOnly=true;	
	document.forms[0].txt_phyinsp_Userid.readOnly=true;	
	document.forms[0].txt_phyinsp_username.readOnly=true;
	document.forms[0].txt_convertedid.readOnly=true;
	document.forms[0].txt_convertedname.readOnly=true;
	document.forms[0].ddrverifidate.readOnly=true;	
		
}

function disableCommandButtons(cmdedit,cmdsave,cmdcancel,cmddelete,cmdprint)
{
 	document.forms[0].cmdedit.disabled=cmdedit;
	document.forms[0].cmdsave.disabled=cmdsave;
	document.forms[0].cmdcancel.disabled=cmdcancel;
	document.forms[0].cmddelete.disabled=cmddelete;
	//document.all.cmdclose.disabled=cmdclose;
}
function doDelete()
{	
	document.forms[0].hidAction.value ="D";
	document.forms[0].hidSourceUrl.value="/action/due_report.jsp";
	document.forms[0].hidBeanId.value="documentsupport";
	document.forms[0].hidBeanMethod.value="updatedueReport";
	document.forms[0].hidBeanGetMethod.value="getdueReport";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit(); 
}
function doCancel()
{
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
		document.forms[0].hidBeanId.value="documentsupport";
		document.forms[0].hidBeanGetMethod.value="getdueReport";
		document.forms[0].action=appURL+"action/due_report.jsp";
		document.forms[0].submit();
	}
}		

function disableFields(val)
{
	  for(var i=0;i<document.forms[0].length;i++)
	  {
		  if(document.forms[0].elements[i].type=='text')
		  {
			document.forms[0].elements[i].readOnly=val;
			if(document.forms[0].elements[i].name=='txt_Bank')
			{
				document.forms[0].elements[i].readOnly=true;
			}
		  }
		  if(document.forms[0].elements[i].type=='select-one')
		  {
			document.forms[0].elements[i].disabled=val;
		  }
		  if(document.forms[0].elements[i].type=="textarea")
		  {
			  document.forms[0].elements[i].disabled=val;		  
		  }
		  
	  }
	   
}

function checkPACSdate(obj)
{
	var pagedate=obj.value;
	var pgdt=changeDateformat(pagedate);
	var maxdt=changeDateformat(document.forms[0].txt_pacsvari_from.value);
	if(obj.value!="")
		{
			if(Date.parse(pgdt) > Date.parse(maxdt))
			{
				alert("Verification date cannot be lesser than " + document.forms[0].txt_pacsvari_from.value );
				obj.value="";
				obj.focus();
			}
		}
}

function showDDR()
{
	if(document.forms[0].hidDemoId.value!="")
	{
		document.forms[0].hidAction.value ="I";
		document.forms[0].hidBeanGetMethod.value="getdueReport";			
		document.forms[0].hidBeanId.value="documentsupport";
		document.forms[0].method="post";
		document.forms[0].action=appURL+"action/due_report.jsp";
		document.forms[0].submit();
	}
}

function addpresentBank()
{
	if(document.forms[0].cmdedit.disabled==true)
	{	
	var tab  = document.getElementById("id_presentBank");
	var rowsLength = tab.rows.length;
	if(rowsLength<=200)
	{
		var new_Row    = tab.insertRow(rowsLength);
		var rwlength=rowsLength;
		new_Row.id=""+rowsLength;
		new_Row.className="datagrid";
		new_Row.align="center";
		var previous_RowCells=tab.rows[rowsLength-1].cells; 
		for(i=0;i<previous_RowCells.length;i++)
		{
			var new_RowCell=new_Row.insertCell(i);
			new_RowCell.innerHTML=previous_RowCells[i].innerHTML;
			new_RowCell.align="center";
			var new_CellElement=new_RowCell.childNodes[0];
			if(i==0)
	        {
	        	new_RowCell.align="center";
	        }
			for(var j=0;j<new_RowCell.childNodes.length;j++)
			{
				if(new_RowCell.childNodes[j].type=="text")
				{
					new_RowCell.childNodes[j].value="";
					new_RowCell.width="13%";	 
					new_RowCell.childNodes[j].disabled=false;
				}
				if(new_RowCell.childNodes[j].type=="textarea")
				{
					new_RowCell.childNodes[j].value="";
					new_RowCell.width="19%";	 		  
					new_RowCell.childNodes[j].disabled=false;
				}
				if(new_RowCell.childNodes[j].type=="checkbox")
				{
					new_RowCell.childNodes[j].checked=false;	
					new_RowCell.width="3%";	  
					new_RowCell.childNodes[j].disabled=false;
				}
				
			}
			 
		}
	//	document.forms[0].txt_Bank[rowsLength-1].value="";
	//	document.forms[0].bank_address[rowsLength-1].value="";
	//	document.forms[0].txt_prebankSince[rowsLength-1].value="";
	//	document.forms[0].txt_accverified_From[rowsLength-1].value="";
	//	document.forms[0].txt_accverified_to[rowsLength-1].value="";
	//	document.forms[0].txt_noofcheques[rowsLength-1].value="";
	//	document.forms[0].txt_maxBalance[rowsLength-1].value="";
		 
		
	}
	else
	{
		alert("Cannot add more rows");
	}
	//ClearFields();
	}

	if(document.forms[0].cmdedit.disabled==true)
	{	
	var tab  = document.getElementById("id_presentBank2");
	var rowsLength = tab.rows.length;
	if(rowsLength<=200)
	{
		var new_Row    = tab.insertRow(rowsLength);
		var rwlength=rowsLength;
		new_Row.id=""+rowsLength;
		new_Row.className="datagrid";
		var previous_RowCells=tab.rows[rowsLength-1].cells; 
		for(i=0;i<previous_RowCells.length;i++)
		{
			var new_RowCell=new_Row.insertCell(i);
			new_RowCell.innerHTML=previous_RowCells[i].innerHTML;
			new_RowCell.align="center";
			var new_CellElement=new_RowCell.childNodes[0];
			if(i==0)
	        {
	        	new_RowCell.align="center";
	        }
			for(var j=0;j<new_RowCell.childNodes.length;j++)
			{
				if(new_RowCell.childNodes[j].type=="text")
				{
					new_RowCell.childNodes[j].value="";
					new_RowCell.width="11%";	 
					new_RowCell.childNodes[j].disabled=false;
				}
				if(new_RowCell.childNodes[j].type=="textarea")
				{
					new_RowCell.childNodes[j].value="";
					new_RowCell.width="21%";	 		  
					new_RowCell.childNodes[j].disabled=false;
				}
				if(new_RowCell.childNodes[j].type=="select-one")
				{
					new_RowCell.childNodes[j].value="";	
					new_RowCell.width="11%";	  
					new_RowCell.childNodes[j].disabled=false;
				}
			}
			 
		}
		 
	//	document.forms[0].txt_minBalance[rowsLength-1].value="";
	//	document.forms[0].txt_TotCredit_turnover[rowsLength-1].value="";
	//	document.forms[0].txt_difin_sales[rowsLength-1].value="";
	//	document.forms[0].sel_wht_confiReportObt[rowsLength-1].value="";
	//	document.forms[0].txt_confiRepObt_date[rowsLength-1].value="";
	//	document.forms[0].reason_ConfRepObt[rowsLength-1].value="";
		
	}
	else
	{
		alert("Cannot add more rows");
	}
	//ClearFields();
	}
}
function deleteRow1(tableid)
{
	var table=document.getElementById(tableid);
	var rowCount=table.rows.length; 
		
	if(rowCount==1)
	{
	      alert("Atleast one data is needed");
	      return;
	}
	else
	{	
		 table.deleteRow(rowCount-1);
	}
}

function presBankDisp()
{
	 var presbank="<%= Helper.correctNull((String)hshValues.get("DDR_PRESBANK_code")) %>";	
	 var presbank=presbank.split("@");
	 var valuerlen=presbank.length;
	 var DDR_PRESBANK_name="<%= Helper.correctNull((String)hshValues.get("DDR_PRESBANK_name")) %>";
	 var DDR_PRESBANK_name=DDR_PRESBANK_name.split("@");
	 var DDR_PRESBANK_ADDRESS="<%= Helper.replaceForJavaScriptString(Helper.correctNull((String)hshValues.get("DDR_PRESBANK_ADDRESS"))) %>";
	 var DDR_PRESBANK_ADDRESS=DDR_PRESBANK_ADDRESS.split("@");
	 var DDR_PRESBANK_BANKSINCE="<%= Helper.correctNull((String)hshValues.get("DDR_PRESBANK_BANKSINCE")) %>";
	 var DDR_PRESBANK_BANKSINCE=DDR_PRESBANK_BANKSINCE.split("@");
	 var DDR_PRESBANK_ACCVER_FROM="<%= Helper.correctNull((String)hshValues.get("DDR_PRESBANK_ACCVER_FROM")) %>";
	 var DDR_PRESBANK_ACCVER_FROM=DDR_PRESBANK_ACCVER_FROM.split("@");
	 var DDR_PRESBANK_ACCVER_TO="<%= Helper.correctNull((String)hshValues.get("DDR_PRESBANK_ACCVER_TO")) %>";
	 var DDR_PRESBANK_ACCVER_TO=DDR_PRESBANK_ACCVER_TO.split("@");
	 var DDR_PRESBANK_CHEQUERETURN="<%= Helper.correctNull((String)hshValues.get("DDR_PRESBANK_CHEQUERETURN")) %>";
	 var DDR_PRESBANK_CHEQUERETURN=DDR_PRESBANK_CHEQUERETURN.split("@");
	 var DDR_PRESBANK_MAXBAL="<%= Helper.correctNull((String)hshValues.get("DDR_PRESBANK_MAXBAL")) %>";
	 var DDR_PRESBANK_MAXBAL=DDR_PRESBANK_MAXBAL.split("@");
	 var DDR_PRESBANK_MINBAL="<%= Helper.correctNull((String)hshValues.get("DDR_PRESBANK_MINBAL")) %>";
	 var DDR_PRESBANK_MINBAL=DDR_PRESBANK_MINBAL.split("@");
	 var DDR_PRESBANK_TOTCTO="<%= Helper.correctNull((String)hshValues.get("DDR_PRESBANK_TOTCTO")) %>";
	 var DDR_PRESBANK_TOTCTO=DDR_PRESBANK_TOTCTO.split("@");
	 var DDR_PRESBANK_DIFINSALES="<%= Helper.correctNull((String)hshValues.get("DDR_PRESBANK_DIFINSALES")) %>";
	 var DDR_PRESBANK_DIFINSALES=DDR_PRESBANK_DIFINSALES.split("@");
	 var DDR_PRESBANK_VARIATIONRSN="<%= Helper.replaceForJavaScriptString(Helper.correctNull((String)hshValues.get("DDR_PRESBANK_VARIATIONRSN"))) %>";
	 var DDR_PRESBANK_VARIATIONRSN=DDR_PRESBANK_VARIATIONRSN.split("@");
	 var DDR_PRESBANK_WHT_CONFREPOBT="<%= Helper.correctNull((String)hshValues.get("DDR_PRESBANK_WHT_CONFREPOBT")) %>";
	 var DDR_PRESBANK_WHT_CONFREPOBT=DDR_PRESBANK_WHT_CONFREPOBT.split("@");
	 var DDR_PRESBANK_CONFREPDATE="<%= Helper.correctNull((String)hshValues.get("DDR_PRESBANK_CONFREPDATE")) %>";
	 var DDR_PRESBANK_CONFREPDATE=DDR_PRESBANK_CONFREPDATE.split("@");
	 var DDR_PRESBANK_RSN_CONFREPOBT="<%= Helper.correctNull((String)hshValues.get("DDR_PRESBANK_RSN_CONFREPOBT")) %>";
	 var DDR_PRESBANK_RSN_CONFREPOBT=DDR_PRESBANK_RSN_CONFREPOBT.split("@");
	 
	 for(var i=0;i<(valuerlen);i++)
     {
    	 addpresentBank();
    	 if(valuerlen==1)
    	 {
    		 document.forms[0].hid_LeadBank[i].value=presbank[i];
    		 document.forms[0].txt_Bank[i].value=DDR_PRESBANK_name[i];
    		 document.forms[0].bank_address[i].value=DDR_PRESBANK_ADDRESS[i];
    		 document.forms[0].txt_prebankSince[i].value=DDR_PRESBANK_BANKSINCE[i];
    		 document.forms[0].txt_accverified_From[i].value=DDR_PRESBANK_ACCVER_FROM[i];
    		 document.forms[0].txt_accverified_to[i].value=DDR_PRESBANK_ACCVER_TO[i];
    		 document.forms[0].txt_noofcheques[i].value=DDR_PRESBANK_CHEQUERETURN[i];
    		 document.forms[0].txt_maxBalance[i].value=DDR_PRESBANK_MAXBAL[i];
    		 document.forms[0].txt_minBalance[i].value=DDR_PRESBANK_MINBAL[i];
    		 document.forms[0].txt_TotCredit_turnover[i].value=DDR_PRESBANK_TOTCTO[i];
    		 document.forms[0].txt_difin_sales[i].value=DDR_PRESBANK_DIFINSALES[i];
    		 document.forms[0].reason_for_variations[i].value=DDR_PRESBANK_VARIATIONRSN[i];
    		 document.forms[0].sel_wht_confiReportObt[i].value=DDR_PRESBANK_WHT_CONFREPOBT[i];
    		 document.forms[0].txt_confiRepObt_date[i].value=DDR_PRESBANK_CONFREPDATE[i];
    		 document.forms[0].reason_ConfRepObt[i].value=DDR_PRESBANK_RSN_CONFREPOBT[i];
    	 }
    	 else
    	 {
    		 document.forms[0].hid_LeadBank[i].value=presbank[i];
    		 document.forms[0].txt_Bank[i].value=DDR_PRESBANK_name[i];
    		 document.forms[0].bank_address[i].value=DDR_PRESBANK_ADDRESS[i];
    		 document.forms[0].txt_prebankSince[i].value=DDR_PRESBANK_BANKSINCE[i];
    		 document.forms[0].txt_accverified_From[i].value=DDR_PRESBANK_ACCVER_FROM[i];
    		 document.forms[0].txt_accverified_to[i].value=DDR_PRESBANK_ACCVER_TO[i];
    		 document.forms[0].txt_noofcheques[i].value=DDR_PRESBANK_CHEQUERETURN[i];
    		 document.forms[0].txt_maxBalance[i].value=DDR_PRESBANK_MAXBAL[i];
    		 document.forms[0].txt_minBalance[i].value=DDR_PRESBANK_MINBAL[i];
    		 document.forms[0].txt_TotCredit_turnover[i].value=DDR_PRESBANK_TOTCTO[i];
    		 document.forms[0].txt_difin_sales[i].value=DDR_PRESBANK_DIFINSALES[i];
    		 document.forms[0].reason_for_variations[i].value=DDR_PRESBANK_VARIATIONRSN[i];
    		 document.forms[0].sel_wht_confiReportObt[i].value=DDR_PRESBANK_WHT_CONFREPOBT[i];
    		 document.forms[0].txt_confiRepObt_date[i].value=DDR_PRESBANK_CONFREPDATE[i];
    		 document.forms[0].reason_ConfRepObt[i].value=DDR_PRESBANK_RSN_CONFREPOBT[i];
    		 
    	 }
     }
        deleteRow1("id_presentBank");
        deleteRow1("id_presentBank2");
}

function changeConfRep(rowid)
{
	var tab  = document.getElementById("id_presentBank2");
	var rowcount = tab.rows.length;

	if(rowcount>2)
	{
		if(document.forms[0].sel_wht_confiReportObt[rowid-1].value=="Y")
		{
			document.forms[0].reason_ConfRepObt[rowid-1].readOnly=true;
		}
		else
		{
			document.forms[0].reason_ConfRepObt[rowid-1].readOnly=false;
		}
	}
	else
	{
		if(document.forms[0].sel_wht_confiReportObt.value=="Y")
		{
			document.forms[0].reason_ConfRepObt.readOnly=true;
		}
		else
		{
			document.forms[0].reason_ConfRepObt.readOnly=false;
		}
	}
	
	
	
}
function callCalender_mul(name,rowindex,obj) 
{

	var tab  = document.getElementById("id_presentBank");
	var rowsLength = tab.rows.length;
	if(rowsLength==1)
	{
		if (document.forms[0].cmdsave.disabled == false) {

			showCal(appURL, name);
		}
	}
	else
	{
		if(name=="txt_prebankSince")
		{
			for(var i=0;i<document.all.idcal1.length;i++)
			{
				if(obj==document.all.idcal1[i])
				{
					name="txt_prebankSince["+(i)+"]";
				}
			}
		}
		else if(name=="txt_accverified_From")
		{
			for(var i=0;i<document.all.idcal2.length;i++)
			{
				if(obj==document.all.idcal2[i])
				{
					name="txt_accverified_From["+(i)+"]";
				}
			}
		}
		else
		{
			for(var i=0;i<document.all.idcal3.length;i++)
			{
				if(obj==document.all.idcal3[i])
				{
					name="txt_accverified_to["+(i)+"]";
				}
			}
		}
		if (document.forms[0].cmdsave.disabled == false) 
		{
			showCal(appURL, name);
		}
	}
}


function callCalender_mul1(name,rowindex,obj) {

	var tab  = document.getElementById("id_presentBank2");
	var rowsLength = tab.rows.length;
	if(rowsLength==1)
	{
		if (document.forms[0].cmdsave.disabled == false) {

			showCal(appURL, name);
		}
	}
	else
	{
		if(name=="txt_confiRepObt_date")
		{
			for(var i=0;i<document.all.idcal4.length;i++)
			{
				if(obj==document.all.idcal4[i])
				{
					name="txt_confiRepObt_date["+(i)+"]";
				}
			}
		}
		if (document.forms[0].cmdsave.disabled == false)
		{
			showCal(appURL, name);
		}
	}
}
function callDDRDetails()
{
	document.forms[0].hidBeanId.value="documentsupport";
	document.forms[0].hidBeanGetMethod.value="getdueReportGeneralInfo";
	document.forms[0].action=appURL+"action/due_report_general.jsp";
	document.forms[0].submit();
}
function enablestockname()
{
	if(document.forms[0].sel_stocexchange.value=="Y")
	{
		document.all.idstock.style.display="inline";
	}
	else
	{
		document.all.idstock.style.display="none";
	}
}


function deleterow(tabid,tdcount)
{
	if(document.forms[0].cmdedit.disabled==true)
	{
		var tab = document.getElementById(tabid);
		var rowsLength = tab.rows.length;
	//	alert(rowsLength);
		var varCheckedFlag=false;

		var tab1 = document.getElementById("id_presentBank2");
		var rowsLength1 = tab.rows.length;
	//	alert(rowsLength1);
		if(rowsLength>=1)
		{
			for(var i=0;i<rowsLength;i++)
			{
				var current_row = tab.rows[i];
				var chkbox = current_row.cells[tdcount].childNodes[0];
				if(chkbox != null && chkbox.checked == true)
				{
					if(tabid=="id_presentBank")
					{
						if(rowsLength==1 || rowsLength<=1)
							{
						    	 document.forms[0].txt_Bank.value="";  
						    	 document.forms[0].bank_address.value="";
						    	 document.forms[0].txt_prebankSince.value="";  
						    	 document.forms[0].txt_accverified_From.value="";
						    	 document.forms[0].txt_accverified_to.value="";  
						    	 document.forms[0].txt_noofcheques.value="";
						    	 document.forms[0].txt_maxBalance.value="";
	
						    	 document.forms[0].txt_minBalance.value="";  
						    	 document.forms[0].txt_TotCredit_turnover.value="";
						    	 document.forms[0].txt_difin_sales.value="";  
						    	 document.forms[0].reason_for_variations.value=""; 
						    	 document.forms[0].sel_wht_confiReportObt.value="";
						    	 document.forms[0].txt_confiRepObt_date.value="";  
						    	 document.forms[0].reason_ConfRepObt.value="";  
						    	 chkbox.checked=false;
						    	 return;
							}
							else
							{
								tab.deleteRow(i);
								tab1.deleteRow(i);
								rowsLength--;
								rowsLength1--;
								i--;
							}

					}

					if(!varCheckedFlag)
					{
						varCheckedFlag=true;
					}
				}
			}
			if(!varCheckedFlag)
			{
				alert("please select the check box for deletion");
			}
		}
	}
}

function callBIRdetails()
{
	document.forms[0].hidBeanId.value="appraisal";
	document.forms[0].hidBeanGetMethod.value="getBIRData";
	document.forms[0].action=appURL+"action/per_bir.jsp";
	document.forms[0].submit();
}
function callUsersHelp1(val)
{
	if(document.all.cmdsave.disabled==false)
	{
		var pagefield="ddr"+val;
		var varQryString = appURL+"action/setUserSearchforbirddr.jsp?pagefrom="+pagefield;
		var title = "Users";
		var prop = "scrollbars=yes,width=650,height=400,menubar=yes";	
		var xpos = (screen.width - 350) / 2;
		var ypos = (screen.height - 120) / 2;
		prop = prop + ",left=50,top=50";
		window.open(varQryString,title,prop);
	}else{
		alert("Enable the edit Mode");
	}
}


</script>
<body onload="onload();">
<form name="appform" method="post" class="normal">

<%if(strSessionModuleType.equals("RET") || strSessionModuleType.equals("DIGI")) { %>

<%if(strSessionModuleType.equals("DIGI")) { %>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
	<tr>
		<td id="mainlnk1">
			<jsp:include page="../share/applurllinkerdigi.jsp" flush="true">
			<jsp:param name="pageid" value="10" />
			</jsp:include>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    
    <tr>		
      <td class="page_flow">Home -&gt; Digi Retail -&gt; Appraisal -&gt; Due Diligence Report -&gt; Due Diligence Report - New Page</td>
	</tr>
    </table>
<% } else { %>    
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
	<tr>
		<td id="mainlnk1">
			<jsp:include page="../share/Applurllinkper.jsp" flush="true">
			<jsp:param name="pageid" value="10" />
			</jsp:include>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    
    <tr>		
      <td class="page_flow">Home -&gt; Retail(including schematic) -&gt; Appraisal -&gt; Due Diligence Report -&gt; Due Diligence Report - New Page</td>
	</tr>
    </table>
    
<% } %>
<span style="display:none;"><lapschoice:borrowertype /></span> <lapschoice:application/>

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
	<tr>
		<td><jsp:include page="../share/apprlinktab.jsp" flush="true">
			<jsp:param name="tabid" value="10" />
			</jsp:include>
		</td>
	</tr>
</table>
<table width="30%" border="0" cellspacing="0" cellpadding="0" class="outertable">
<tr>
	<td>
		<table width="100%" border="0" cellspacing="1" cellpadding="3" align="left" class="outertable">
		<tr align="center">
		<td width="50%" class="sub_tab_active" nowrap="nowrap">Due Diligence - Applicant Info</td>
			<td width="50%" class="sub_tab_inactive">
				<a href="JavaScript:callDDRDetails();">Due Diligence - Security Info</a>
			</td>
		</tr>
		</table>
	</td>
</tr>
</table>

		 <table width="80%" border="0" cellspacing="1" cellpadding="3" class="outertable" align="center">
          <tr> 
            <td nowrap align="center">Select  Applicant/ Guarantor</td>
            <td> 
              <select name="hidDemoId" onChange="showDDR()">
			<option selected value="">&lt;--Select--&gt;</option>
			<%
                	String strAppType="A','C','G','O";
                %>
			<lapschoice:coappguarantorsec apptype="<%=strAppType%>" />
		</select>
            </td>
           </tr>       
        </table>
   <% } else { %>    
   
   <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr> 
			<td valign="top"> 
              <jsp:include page="../com/proposallinks.jsp" flush="true"> 
              <jsp:param name="pageid" value="35" />
			   <jsp:param name="cattype" value="<%=strCategoryType%>" />
			  <jsp:param name="ssitype" value="<%=strSSIType%>" />
			
              </jsp:include>
            </td>
          </tr>
  </table>
  
  <table width="100%" border="0" cellspacing="0" cellpadding="0"  class="outertable">
	<tr>
	 <%if(strSessionModuleType.equals("AGR")){%>
	  <td class="page_flow">Home-&gt; Agriculture -&gt;Application -&gt; Due Diligence Report (Applicant Info) </td>
	  <%}else{ %>
	  <td class="page_flow">Home-&gt; Corporate & SME -&gt;Application -&gt; Due Diligence Report  (Applicant Info)</td>
	  <%} %>
	</tr>
 </table>
 
    <span style="display:none;"><lapschoice:borrowertype /></span> <lapschoice:application/>
 <table width="60%" border="0" cellspacing="0" cellpadding="0" class="outertable">
<tr>
	<td>
		<table width="100%" border="0" cellspacing="1" cellpadding="3" align="left" class="outertable">
		<tr align="center">
		<td width="30%" class="sub_tab_active" nowrap="nowrap">Due Diligence - Applicant Info</td>
			<td width="30%" class="sub_tab_inactive">
				<a href="JavaScript:callDDRDetails();">Due Diligence - Security Info</a>
			</td>
			<td width="50%" class="sub_tab_inactive">
			<a href="JavaScript:callBIRdetails();">Background Information Report(BIR)</a></td>
		</tr>
		</table>
	</td>
</tr>
</table>
<table width="100%" cellspacing="0" cellpadding="3" align="center" class="outertable" border="0">
     <tr>
         <td width="35%">&nbsp;</td>
         <td width="10%" align="center">Select Applicant</td>
         <td>
	         <select name="hidDemoId" class="selectwidth" tabindex="1" onChange="showDDR()">
					<%
					String appidval = request.getParameter("appno");
					String strcompanyname = request.getParameter("appname");
					%>							
				    <option value="">&lt;---select---&gt;</option>
				    <option value="<%=strAppId%>"><%=strcompanyname%></option>
				   <lapschoice:compromoter />
		     </select>
		  </td></tr>
</table>
 
 
   <% }  %>

	<table width="98%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable border1">
 	 <tr>
		<td>
	 	<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
           		<tr class="dataHeader">
                	<td colspan="5"><b>PARTICULARS OF THE INTRODUCER :</b></td>
           		</tr>
           		<tr>
	              	<td width="20%">Since Banking with us </td>
	                <td width="80%">
	                 <input type="text" name="txt_since_bank" onBlur="checkDate(this);checkmaxdate(this,curdate)"
										value="<%=Helper.correctNull((String)hshValues.get("DDR_BANKWITHUS"))%>" maxlength="10" size="15" alt="Select date from calender">
										<a style="vertical-align: middle" onClick="callCalender('txt_since_bank')"
										onMouseOver="window.status='Date Picker';return true;"
										onMouseOut="window.status='';return true;"><img
										src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
										alt="Select date from calender"></a>
	                </td>
	               	
	           </tr>
	           <tr>
	              	<td width="20%">Conduct of the Account</td>
	               	<td width="80%"><textarea name="txt_cond_acc" cols="40" rows="3" onKeyPress="textlimit(this,399)" onKeyUp="textlimit(this,399)"><%=Helper.correctNull((String)hshValues.get("DDR_ACC_CONDUCT"))%></textarea></td>
	           </tr>
	           
	           <tr>
	           		<td width="20%">Reputation / Status of introducer in Society (If not Acc holder)</td>
	           		<td width="80%"><textarea name="txt_rep_stat" cols="40" rows="3" onKeyPress="textlimit(this,399)" onKeyUp="textlimit(this,399)" ><%=Helper.correctNull((String)hshValues.get("DDR_REPUT_INTRODUCER"))%></textarea></td>
	           		</tr>
	           <tr>
	           		<td width="20%">Self introduced with relevant documents</td>
	           		<td width="80%"><textarea name="txt_self_intro" cols="40" rows="3" onKeyPress="textlimit(this,399)" onKeyUp="textlimit(this,399)"><%=Helper.correctNull((String)hshValues.get("DDR_SELFINTRO_DOC"))%></textarea></td>
	           </tr>
        </table>
      </td>
 </tr>
 <tr>
	 <td>
	 	 <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
	           <tr class="dataHeader">
	                <td colspan="5"><b>RE-VERIFICATION OF PERSONAL DETAILS :</b></td>
	           </tr>
	           
	           <tr>
		           <td width="20%">Whether Physical Inspection done</td>
				   <td width="80%" ><select name="sel_phyinsp" onChange="getdata2()">
		                    <option value="">--Select--</option>
		                    <option value="Y">Yes</option>
		                    <option value="N">No</option>
		                  	</select>
		            </td>
		        </tr>
		        <tr id="p1"> 
		        	<td width="20%">Name of the official who has confirmed the address </td>   
					<td width="80%">User Name : <input type="text" name="txt_phyinsp_Userid"  size="10" value="<%=Helper.correctNull((String)hshValues.get("DDR_PHYINSP_USERID"))%>" readonly="readonly">
						<input type="text" name="txt_phyinsp_username" size="30" value="<%=Helper.correctNull((String)hshValues.get("DDR_PHYINSP_USERNAME"))%>" readonly="readonly">
						<a href="#" onClick="javascript:callUsersHelp('1')">
						<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0"> </a> &nbsp;
						Designation : <input type="text" name="txt_phyinsp_design" size="30" value="<%=Helper.correctNull((String)hshValues.get("DDR_PHYINSP_USERDESIG"))%>" readonly="readonly">
						
					</td>		     
				 </tr>
		        <tr id="p2">
		        	<td width="20%">Reason for not physically verifying the address to be justified</td>   
		           	<td  width="80%"><textarea name="txt_Phy_no" cols="40" rows="3" onKeyPress="textlimit(this,399)" onKeyUp="textlimit(this,399)"><%=Helper.correctNull((String)hshValues.get("DDR_PHYINSP_REASON"))%></textarea></td>
	            </tr>
	            
	            
	            <tr>
	            	<td valign="top">ID Proof</td>
	            	<td>  
	            		<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable" >
								<tr class="datagrid">
									<td>&nbsp; </td>
									<td>Number </td>
									<td>Expiry Date </td>
									<td>Issued at (Place) </td>
								</tr>	
								<tr>
									<td>Passport</td>
									<td><input type="text" name="txt_passport_number" value="<%= Helper.correctNull((String) hshValues.get("passportNum"))%>"> </td>
									<td>
					                  <input type="text" name="txt_passport_expdate" onBlur="checkDate(this);checkmindate(this,curdate);"
										value="<%=Helper.correctNull((String)hshValues.get("passportdate"))%>" maxlength="10" size="15" alt="Select date from calender">
										<a style="vertical-align: middle" onClick="callCalender('txt_passport_expdate')"
										onMouseOver="window.status='Date Picker';return true;"
										onMouseOut="window.status='';return true;"><img
										src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
										alt="Select date from calender"></a>&nbsp;&nbsp;
									</td>
									<td><input type="text" name="txt_passport_place" value="<%=Helper.correctNull((String)hshValues.get("passportplace"))%>" > </td>
								</tr>      
								<tr >
									<td>Driving Licence</td>
									<td><input type="text" name="txt_DL_number" value="<%= Helper.correctNull((String) hshValues.get("drivinglicNum"))%>"> </td>
									<td>
					                  <input type="text" name="txt_DL_expdate" onBlur="checkDate(this);checkmindate(this,curdate);"
										value="<%=Helper.correctNull((String)hshValues.get("drivinglicdate"))%>" maxlength="10" size="15" alt="Select date from calender">
										<a style="vertical-align: middle" onClick="callCalender('txt_DL_expdate')"
										onMouseOver="window.status='Date Picker';return true;"
										onMouseOut="window.status='';return true;"><img
										src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
										alt="Select date from calender"></a>&nbsp;&nbsp;
									</td>
									<td><input type="text" name="txt_DL_place" value="<%= Helper.correctNull((String) hshValues.get("drivinglicplace"))%>"> </td>
								</tr>
								<tr >
				            	<td>Election Card</td>
								<td><input type="text" name="txt_ElectionCard_number" value="<%= Helper.correctNull((String) hshValues.get("electionNum"))%>"> </td>
								<td>
				                  <input type="text" name="txt_ElectionCard_expdate" onBlur="checkDate(this);checkmindate(this,curdate);"
									value="<%=Helper.correctNull((String)hshValues.get("electiondate"))%>" maxlength="10" size="15" alt="Select date from calender">
									<a style="vertical-align: middle" onClick="callCalender('txt_ElectionCard_expdate')"
									onMouseOver="window.status='Date Picker';return true;"
									onMouseOut="window.status='';return true;"><img
									src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
									alt="Select date from calender"></a>&nbsp;&nbsp;
								</td>
								<td><input type="text" name="txt_ElectionCard_place" value="<%= Helper.correctNull((String) hshValues.get("electionplace"))%>"> </td>
				            	</tr>
								<tr>
									<td>Other Valid Documents </td>
									<td colspan="3"> </td>
								</tr>
								<tr>
									<td>a) <input type="text" name="txt_otherdoc1_name" value="<%= Helper.correctNull((String) hshValues.get("otherdoc1Name"))%>"> </td>
									<td><input type="text" name="txt_otherDoc1_number" value="<%= Helper.correctNull((String) hshValues.get("otherdoc1Num"))%>"> </td>
									<td>
					                  <input type="text" name="txt_otherDoc1_expdate" onBlur="checkDate(this);checkmindate(this,curdate);"
										value="<%=Helper.correctNull((String)hshValues.get("otherdoc1date"))%>" maxlength="10" size="15" alt="Select date from calender">
										<a style="vertical-align: middle" onClick="callCalender('txt_otherDoc1_expdate')"
										onMouseOver="window.status='Date Picker';return true;"
										onMouseOut="window.status='';return true;"><img
										src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
										alt="Select date from calender"></a>&nbsp;&nbsp;
									</td>
									<td><input type="text" name="txt_otherDoc1_place" value="<%= Helper.correctNull((String) hshValues.get("otherdoc1place"))%>"> </td>
	            				</tr>
								<tr>
									<td>b) <input type="text" name="txt_otherdoc2_name" value="<%= Helper.correctNull((String) hshValues.get("otherdoc2Name"))%>"> </td>
									<td><input type="text" name="txt_otherDoc2_number" value="<%= Helper.correctNull((String) hshValues.get("otherdoc2Num"))%>">  </td>
									<td>
					                  <input type="text" name="txt_otherDoc2_expdate" onBlur="checkDate(this);checkmindate(this,curdate);"
										value="<%=Helper.correctNull((String)hshValues.get("otherdoc2date"))%>" maxlength="10" size="15" alt="Select date from calender">
										<a style="vertical-align: middle" onClick="callCalender('txt_otherDoc2_expdate')"
										onMouseOver="window.status='Date Picker';return true;"
										onMouseOut="window.status='';return true;"><img
										src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
										alt="Select date from calender"></a>&nbsp;&nbsp;
									</td>
									<td><input type="text" name="txt_otherDoc2_place" value="<%= Helper.correctNull((String) hshValues.get("otherdoc2place"))%>"> </td>
	            				</tr>
								<tr>
									<td>c) <input type="text" name="txt_otherdoc3_name" value="<%= Helper.correctNull((String) hshValues.get("otherdoc3Name"))%>"> </td>
									<td><input type="text" name="txt_otherDoc3_number" value="<%= Helper.correctNull((String) hshValues.get("otherdoc3Num"))%>"> </td>
									<td>
					                  <input type="text" name="txt_otherDoc3_expdate" onBlur="checkDate(this);checkmindate(this,curdate);"
										value="<%=Helper.correctNull((String)hshValues.get("otherdoc3date"))%>" maxlength="10" size="15" alt="Select date from calender">
										<a style="vertical-align: middle" onClick="callCalender('txt_otherDoc3_expdate')"
										onMouseOver="window.status='Date Picker';return true;"
										onMouseOut="window.status='';return true;"><img
										src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
										alt="Select date from calender"></a>&nbsp;&nbsp;
									</td>
									<td><input type="text" name="txt_otherDoc3_place" value="<%= Helper.correctNull((String) hshValues.get("otherdoc3place"))%>"> </td>
	            				</tr>
	            		</table>
	            	</td>
	            </tr>
	            
	           <%
	           if(Integer.parseInt(Helper.correctInt((String)hshValues.get("CON_YEARS"))) < 1 ) { %> 
		            <tr>
			            <td width="20%">If applicant is residing for less than one year, details of residence to be mentioned.</td>
			            <td width="80%"><textarea name="txt_app_residing" cols="40" rows="3" onKeyPress="textlimit(this,199)" onkeyup="checkTextArealimit(this,199);textlimit(this,199)" ><%=Helper.correctNull((String)hshValues.get("DDR_APPRESIDENCE"))%></textarea></td>
			        </tr>
		        <%} %>
            	<tr>
	            	<td width="20%">Name of the branch nearest to the residence of the applicant</td>
	            	<td width="80%">
					<input type="hidden" name="hid_LoanDisbBranch" value="<%=Helper.correctNull((String)hshValues.get("DD_BRNAMENEARBYCODE")) %>" >
					<input type="text" name="txt_LoanDisbBranch" size="38" value="<%=Helper.correctNull((String)hshValues.get("DD_BRNAMENEARBYNAME"))%>">
					<b><a href="#" onClick="showOrganizationSearch('<%=ApplicationParams.getAppUrl()%>','hid_LoanDisbBranch','txt_LoanDisbBranch')"
					style="cursor: hand">
					<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0" ></a></b>
    				</td>
	            	</tr>
          		<tr>
          			<td width="20%">Name of the official who has complied with KYC at the time of opening the operative account of the applicant</td>
          			<td width="80%"><input type="text" name="txt_staffid" size="10" value="<%=Helper.correctNull((String)hshValues.get("DD_KYC_DONEBYCODE"))%>" readonly="readonly">
						<input type="text" name="txt_staffname" size="30" value="<%=Helper.correctNull((String)hshValues.get("DD_KYC_DONEBYNAME"))%>">
						<a href="#" onClick="javascript:callUsersHelp('2')">
						<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0"> </a>
					
					</td>
          		</tr>
          		
          		<tr>
          		<td width="20%" valign="top">  
          			<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
					  		<tr>	
								<td>Present Bankers &nbsp;</td>
								<td id="idJewelApp1"> <a onClick="addpresentBank();"><img
												src="<%=ApplicationParams.getAppUrl()%>img/add.png"
												width="10" height="10" border="0" tabindex="38"></a>&nbsp;&nbsp;&nbsp;
									<a onClick="deleterow('id_presentBank','0');"><img
											src="<%=ApplicationParams.getAppUrl()%>img/cancel.png"
											width="10" height="10" border="0" tabindex="38"></a>
								</td>
							</tr>
					</table>
          		</td>
          		<td width="80%">
       				<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable" >
						<tr>
							<td>
							<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable" > 
								<tr class="dataheader" align="center">
									<td width="3%"> Sl.no </td>
									<td width="13%">Bank Name</td>
									<td width="19%">Bank Address</td>
									<td width="13%">Banking since</td>
									<td width="13%">Statement of account verified From </td>
									<td width="13%">Statement of account verified To</td>
									<td width="13%">Number of cheque returns during FY</td>
									<td width="13%">Maximum Balance</td>
								</tr>
								
							</table>	
							<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable"  id="id_presentBank"> 
								<tr class="datagrid" align="center" id="1">
									<td width="3%"><input type="checkbox" name="chk" style="border:none;" ></td>
									<td width="13%">
											<input type="text" name="txt_Bank" value="" readOnly="readonly" size="15" 
												maxlength="50"  onKeyPress="notAllowSingleAndDoubleQuote();notAllowSplChar()"
												 tabindex="2"/>
												 <input type="hidden" name="hid_LeadBank" value=""/>
										<a onClick="callBankmaster('147','01',this.parentNode.parentNode.id)" style="cursor: hand">
										<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0">
										</a>
									</td>
									<td width="19%"><textarea name="bank_address" cols="20" rows="3" onKeyPress="textlimit(this,599)" onkeyup="textlimit(this,599)"> </textarea></td>
									<td width="13%"><input type="text" name="txt_prebankSince" onBlur="checkDate(this);checkmaxdate(this,curdate);"
										value="<%=Helper.correctNull((String)hshValues.get("otherdoc2date"))%>" maxlength="10" size="10" alt="Select date from calender">
										<a style="vertical-align: middle" id="idcal1"  onClick="callCalender_mul('txt_prebankSince',this.parentNode.parentNode.id,this)"
										onMouseOver="window.status='Date Picker';return true;"
										onMouseOut="window.status='';return true;"><img
										src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
										alt="Select date from calender"></a>
									</td>
									<td width="13%">From <input type="text" name="txt_accverified_From" onBlur="checkDate(this);checkmaxdate(this,curdate);"
										value="<%=Helper.correctNull((String)hshValues.get("otherdoc2date"))%>" maxlength="10" size="10" alt="Select date from calender">
										<a style="vertical-align: middle" id="idcal2"  onClick="callCalender_mul('txt_accverified_From',this.parentNode.parentNode.id,this)"
										onMouseOver="window.status='Date Picker';return true;"
										onMouseOut="window.status='';return true;"><img
										src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
										alt="Select date from calender"></a>
									</td>
									<td width="13%">
									To<input type="text" name="txt_accverified_to" onBlur="checkDate(this);checkmaxdate(this,curdate)"
										value="<%=Helper.correctNull((String)hshValues.get("otherdoc2date"))%>" maxlength="10" size="10" alt="Select date from calender">
										<a style="vertical-align: middle" id="idcal3"  onClick="callCalender_mul('txt_accverified_to',this.parentNode.parentNode.id,this)"
										onMouseOver="window.status='Date Picker';return true;"
										onMouseOut="window.status='';return true;"><img
										src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
										alt="Select date from calender"></a>
									</td>
									<td width="13%"><input type="text" name="txt_noofcheques" onKeyPress="allowNumber(this)"></td>
									<td width="13%"><input type="text" name="txt_maxBalance"  onKeyPress="allowNumber(this)" style="text-align: right" onblur="roundtxt(this);"></td>
									
								</tr>
							</table>
							</td>
						</tr>
						
						<tr>
							<td>
							<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable" > 
								<tr class="dataheader" align="center">
									<td width="3%"> &nbsp;</td>
									<td width="11%">Minimum Balance</td>
									<td width="11%">Total credit turnover in the account</td>
									<td width="11%">Difference in sales and credit turnover in the account </td>
									<td width="21%">Reasons for more than 10% variation (If applicable) </td>
									<td width="11%">Whether confidential report obtained in case of takeover</td>
									<td width="11%">Date of confidential report obtained from above bank</td>
									<td width="21%">Reasons for not obtaining confidential opinion</td>
								</tr> 
							</table>							
							<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable"  id="id_presentBank2"> 
								<tr class="datagrid" align="center" id="1">
									<td width="3%">&nbsp; </td>
									<td width="11%"><input type="text" name="txt_minBalance"  size="15" onKeyPress="allowNumber(this)"  style="text-align: right" onblur="roundtxt(this);"></td>
									<td width="11%"><input type="text" name="txt_TotCredit_turnover"  size="15" onKeyPress="allowNumber(this)"  style="text-align: right" onblur="roundtxt(this);"></td>
									<td width="11%"><input type="text" name="txt_difin_sales" size="15"  onKeyPress="allowNumber(this)"  style="text-align: right" onblur="roundtxt(this);"></td>
									<td width="21%"><textarea rows="3" cols="20" name="reason_for_variations" onKeyPress="textlimit(this,599)" onKeyUp="textlimit(this,599)"></textarea> </td>
									<td width="11%">
											<select name="sel_wht_confiReportObt" onchange="changeConfRep(this.parentNode.parentNode.id)"> 
												<option value=""><-select-></option>
												<option value="NA">NA</option>
											 	<option value="Y">Yes</option>
											 	<option value="N">No</option>
											</select> 
									</td>
									<td width="11%"><input type="text" name="txt_confiRepObt_date" onBlur="checkDate(this);checkmaxdate(this,curdate);"
										value="<%=Helper.correctNull((String)hshValues.get("otherdoc2date"))%>" maxlength="10" size="10" alt="Select date from calender">
										<a style="vertical-align: middle" id="idcal4"  onClick="callCalender_mul1('txt_confiRepObt_date',this.parentNode.parentNode.id,this)"
										onMouseOver="window.status='Date Picker';return true;"
										onMouseOut="window.status='';return true;"><img
										src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
										alt="Select date from calender"></a>
									</td>
									<td width="21%"><textarea rows="3" cols="20" name="reason_ConfRepObt" onKeyPress="textlimit(this,599)" onKeyUp="textlimit(this,599)"></textarea> </td>
								</tr>   
							</table>
							</td>
						</tr>
						
        			</table>
          		</td>
          		</TR>
          		
          		
          	</table>	
        </td>  		
   </tr>
	<tr id="id_agriActivity">
		<td>            
          	<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
		           <tr class="dataHeader">
		                <td colspan="5"><b>AGRICULTURISTS/PLANTERS :</b></td>
		           </tr>
		           <tr>
		            	<td width="20%">Date of visit to the farm </td>
		             	<td width="10%">
		                  <input type="text" name="txt_farm_visit" onBlur="checkDate(this);"
							value="<%=Helper.correctNull((String)hshValues.get("DD_FARM_VISITDATE"))%>" maxlength="10" size="15" alt="Select date from calender" href="#">
							<a style="vertical-align: middle" onClick="callCalender('txt_farm_visit')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender"></a>&nbsp;&nbsp;
						</td>
						<td width="50%">&nbsp;</td>
					</tr>
					<tr>	
						<td width="20%">Extent of land</td>
						<td width="10%"><input type="text" name="txt_extend_land" onKeyPress="allowNumber(this)" value="<%=Helper.correctNull((String)hshValues.get("DD_EXTENDOFLAND"))%>"></td>
		           		<td width="50%">&nbsp;</td>
		           </tr> 
		           <tr>
		            	<td width="20%">Standing crops at the time of visit</td>
		            	<td width="10%"><textarea name="txt_stand_crops" cols="40" rows="3" onKeyPress="textlimit(this,199)" onkeyup="textlimit(this,199)" ><%=Helper.correctNull((String)hshValues.get("DD_STAND_CROPSDETAILS"))%></textarea></td>
		            	<td width="50%">&nbsp;</td>
		           </tr>
		           <tr>
		            	<td width="20%">Crops grown during the year</td>
		            	<td width="10%"><textarea name="txt_crops_grown" cols="40" rows="3" onKeyPress="textlimit(this,199)" onkeyup="textlimit(this,199)" ><%=Helper.correctNull((String)hshValues.get("DD_CROPS_GROWNDETAILS"))%></textarea></td>
		            	<td width="50%">&nbsp;</td>
		           </tr>
		           <tr>
		            	<td width="20%">Liability with Primary Agricultural Co-operative Society(PACS)</td>
		            	<td width="10%"><input type="text" name="txt_liab_pacs" onKeyPress="allowNumber(this)" style=" text-align: right" onblur="roundtxt(this);" value="<%=Helper.correctDouble((String)hshValues.get("DD_LIAB_PACS"))%>"></td>
		            	<td width="50%">&nbsp;</td>
		           </tr>
		           <tr>
		            	<td width="20%">Date of NOC obtained from PACS</td>
		            	<td width="10%">
		                  <input type="text" name="txt_noc_pacs" onBlur="checkDate(this);"
							value="<%=Helper.correctNull((String)hshValues.get("DD_NOC_RECVDDATE"))%>" maxlength="10" size="15" alt="Select date from calender" href="#">
							<a style="vertical-align: middle" onClick="callCalender('txt_noc_pacs')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender"></a>&nbsp;&nbsp;
						</td>
						<td width="50%">&nbsp;</td>
					</tr>
		            <tr>
		            	<td width="20%">Period of bank statement of PACS verified</td>
		            	<td width="10%">From:
		            		<input type="text" name="txt_pacsvari_from" onBlur="checkDate(this);checkmindate(this,document.forms[0].txt_pacsvari_to.value)"
							value="<%=Helper.correctNull((String)hshValues.get("DD_STAT_VERIFIED_FROM"))%>" maxlength="10" size="15" alt="Select date from calender" href="#">
							<a style="vertical-align: middle" onClick="callCalender('txt_pacsvari_from')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender"></a>&nbsp;&nbsp;
						</td>
		            	<td width="50%">To:
		            		<input type="text" name="txt_pacsvari_to" onBlur="checkDate(this);checkmindate(this,document.forms[0].txt_pacsvari_from.value);"
							value="<%=Helper.correctNull((String)hshValues.get("DD_STAT_VERIFIED_TO"))%>" maxlength="10" size="15" alt="Select date from calender" href="#">
							<a style="vertical-align: middle" onClick="callCalender('txt_pacsvari_to')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender"></a>&nbsp;&nbsp;
						</td>
					</tr>
					<tr>	
						<td width="20%">Status of Account </td>
						<td width="15%"><textarea name="txt_status_acc" cols="40" rows="3" onKeyPress="textlimit(this,199)" onkeyup="textlimit(this,199)" ><%=Helper.correctNull((String)hshValues.get("DD_STAT_ACC"))%></textarea></td>
						<td width="45%">&nbsp;</td>
		            	
		            </tr>
		            <tr id="id_panno">
		            	<td width="20%">F.No.60 obtained (When PAN not available)</td>
		                <td width="10%"><select name="sel_fno" onChange="get_FNo()">
		                    <option value="">--Select--</option>
		                    <option value="Y">Yes</option>
		                    <option value="N">No</option>
		                  </select>
		                </td>
		                <td id="f1" width="50%">
		                  <input type="text" name="txt_sel_fno" onBlur="checkDate(this);"
							value="<%=Helper.correctNull((String)hshValues.get("DD_FNO60OBTAINEDON"))%>" maxlength="10" size="15" alt="Select date from calender" href="#">
							<a style="vertical-align: middle" onClick="callCalender('txt_sel_fno')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender"></a>&nbsp;&nbsp;
						</td>
		            </tr>
		      </table>    
		  </td>       
	</tr>            
	<tr id="idsalariedDet">	
		  <td>	            
		       <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">     
		            <tr class="dataHeader">
		                <td colspan="5"><b>SALARIED EMPLOYEES :</b></td>
		            </tr>
		             <tr>
		            	<td width="20%">Whether employer is listed in the stock Exchange</td>
		            	<td width="80%"><select name="sel_stocexchange" onchange="enablestockname();">
		            	<option value=""><--select--></option>
		            	<option value="Y">Yes</option>
		            	<option value="N">No</option>
		            	</select></td>	
		            </tr>
		            <tr id="idstock" style="display: none;">
		            <td>Name of the stock Exchange</td>
		            <td><input type="text" name="txt_exchange" value="<%=Helper.correctNull((String)hshValues.get("DDR_STOCKEXCHANGENAME")) %>" onkeypress="allowAlphabetsForName();"> </td>
		            </tr>
		            <tr>
		            	<td width="20%">Employer's latest sales turnover and Profit </td>
		            	<td width="80%">&nbsp;</td>	
		            </tr>
		            <tr>	
		            	<td width="20%">Sales Turnover </td>
		            	<td width="80%"><input type="text" name="txt_empsal_turnover" onKeyPress="allowNumber(this)" style=" text-align: right" onblur="roundtxt(this);" value="<%=Helper.correctDouble((String)hshValues.get("DD_SALES_TURNOVER"))%>"></td>
		            </tr>
		            <tr>
		            	<td width="20%">Profit </td>
		            	<td width="80%"><input type="text" name="txt_empsal_profit" onKeyPress="allowNumber(this)" style=" text-align: right" onblur="roundtxt(this);" value="<%=Helper.correctDouble((String)hshValues.get("DD_SALES_PROFIT"))%>"></td>
		            </tr>
		        
		    <%if(Helper.correctNull((String)hshValues.get("PEREMP_SALARYROUTED")).equals("O")) { %>    
		            <tr>
		            	<td width="20%">Present A/c where salary is being credited :</td>
		            	<td width="80%">&nbsp; </td>
		             </tr>
		            <tr>
		            	<td width="20%">Bank Name </td>
					     <td width="80%"><input type="text" name="txt_bankname" onKeyPress="" maxlength="40" size="30" tabindex="1" readonly="readonly" value="<%=Helper.correctNull((String)hshValues.get("DD_SAL_CREDITED_BANK_NAME")) %>">
										<input type="hidden" name="hid_LeadBankcode" value="<%=Helper.correctNull((String)hshValues.get("DD_SAL_CREDITED_BANK_CODE")) %>" >
										<span onClick="callBankmaster('147','02','')" style="cursor: hand">
										<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0"></span>
						</td>
		            </tr>
		            <tr>
						<td width="20%">Branch Name</td>	
		            	<td width="80%"><input type="text" name="txt_salbrnch_name" value="<%=Helper.correctNull((String)hshValues.get("DD_SAL_CREDITED_BRANCH_NAME"))%>"></td>
	            	</tr>
		            <tr>
						<td width="20%">Account Number</td>	
		            	<td width="80%"><input type="text" name="txt_salacc_num"  value="<%=Helper.correctNull((String)hshValues.get("DD_SAL_CREDITED_ACC_NUM"))%>"></td>
	            	</tr>
		        
		     <% } %>   
		        
		          <tr>
						<td width="20%">Details about Installment/Interest proposed to be serviced to the loan account</td>
						<td width="80%"><textarea name="txt_inst_laonacc" cols="40" rows="3" onKeyPress="textlimit(this,199)" onkeyup="textlimit(this,199)" ><%=Helper.correctNull((String)hshValues.get("DD_DETAILSOFINSTALLMENT"))%></textarea>	</td>
		            	</tr>
		            <tr>
						<td width="20%">Permission Ref No.(If the Institution/Employer is not in the approved list) </td>	
		            	<td width="80%"><input type="text" name="txt_refno_credit" size="50" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("DD_INSTITUTION_PERM_RFNO"))%>"></td>
		            	</tr>
		            <tr>
						<td width="20%">Salary as per bank statement of account</td>	
		            	<td width="80%"><input type="text" name="txt_sal_bankstat" onKeyPress="allowNumber(this)" style=" text-align: right" onblur="roundtxt(this);" value="<%=Helper.correctNull((String)hshValues.get("DD_SAL_BANK_ACC"))%>"></td>
		            	</tr>
		            <tr>
						<td width="20%">Reasons for variations if any in salary slip and bank statement of account</td>	
		            	<td width="80%"><textarea name="txt_vari_salslip_bankacc" cols="40" rows="3" onKeyPress="textlimit(this,199)" onkeyup="textlimit(this,199)"><%=Helper.correctNull((String)hshValues.get("DD_REASONFORSALARYVARIATION"))%></textarea></td>
		            </tr> 
		            <tr>
		            	<td>Genuineness of the undertaking letters have been independently verified after contacting the employer : </td>
		            	<td>&nbsp; </td>
		            </tr>
		            <tr>
		            	<td>Contacted on </td>
		            	<td width="80%">
		                  <input type="text" name="txt_empContacted_Date" onBlur="checkDate(this);checkmaxdate(this,curdate);"
							value="<%=Helper.correctNull((String)hshValues.get("DDR_SALEMP_EMPCONT_DATE"))%>" maxlength="10" size="15" alt="Select date from calender" href="#">
							<a style="vertical-align: middle" onClick="callCalender('txt_empContacted_Date')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender"></a>&nbsp;&nbsp;
						</td>
		            </tr>
		            <tr>
		            	<td>Contacted Person </td> 
		            	<td><input type="text" name="txt_contact_person" value="<%=Helper.correctNull((String)hshValues.get("DDR_SALEMP_EMPCONT_NAME"))%>"> </td>
		            </tr>
		            <tr>
		           		 <td> Designation </td>
		            	<td><input type="text" name="txt_contact_persondesign" value="<%=Helper.correctNull((String)hshValues.get("DDR_SALEMP_EMPCONT_DESIGN"))%>">  </td>
		            </tr>
		            <tr>
		            	<td>Contact No./Mobile No </td>
		            	<td><input type="text" name="txt_contact_number" onKeyPress="allowNumber(this)" value="<%=Helper.correctNull((String)hshValues.get("DDR_SALEMP_EMPCONT_NUM"))%>"> </td>
		            </tr>
		       </table>     
		  </td>          
	</tr>	            
	
	<tr id="idSelfEmpDet">
			<td> 
		   		<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
				    <tr class="dataHeader">
		                <td colspan="5"><b>SELF EMPLOYED :</b></td>
		            </tr>
		            <tr>
		            	<td width="20%">Name of the nearest branch of our bank to the unit/employer</td>
		             	<td width="80%">
						<input type="hidden" name="hid_LoanDisbBranch1" value="<%=Helper.correctNull((String)hshValues.get("DD_SF_BRANCHNEARBYCODE"))%>">
						<input type="text" name="txt_LoanDisbBranch1" size="38" value="<%=Helper.correctNull((String)hshValues.get("DD_SF_BRANCHNEARBYNAME"))%>">
						<b><a href="#" onClick="showOrganizationSearch('<%=ApplicationParams.getAppUrl()%>','hid_LoanDisbBranch1','txt_LoanDisbBranch1')"
						style="cursor: hand">
						<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0" ></a></b>
    				</td>
		           </tr>
		           <tr>
		           		<td width="20%">The applicant is carrying out the activity in</td>
		                <td width="80%"><select name="sel_appnt_act" >
		                    <option value="">--Select--</option>
		                    <option value="O">Owned premises</option>
		                    <option value="R">Rented premises</option>
		                    <option value="L">Leased premises</option>
		                  </select>
		                </td>
		            </tr>
		            <tr>
		             	<td width="20%">Place and address of the business</td>
		             	<td width="80%"><textarea name="txt_addr_place" cols="40" rows="3" onKeyPress="textlimit(this,199)" onkeyup="textlimit(this,199)" ><%=Helper.correctNull((String)hshValues.get("DD_BUSINESSADDRESS"))%></textarea></td>
		            </tr>	 
		            <tr>
		             	<td width="20%">Date of visit to the unit/office
		             	<td width="80%">
		                  <input type="text" name="txt_visit_unit" onBlur="checkDate(this);checkmaxdate(this,curdate);"
							value="<%=Helper.correctNull((String)hshValues.get("DD_DATE_VISIT_OFC"))%>" maxlength="10" size="15" alt="Select date from calender" href="#">
							<a style="vertical-align: middle" onClick="callCalender('txt_visit_unit')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender"></a>&nbsp;&nbsp;
						</td>  
					</tr>
					
		      </table>
		  </td>
		  <tr>
						<td>
						<table width="80%" border="0" cellspacing="1" cellpadding="3" class="outertable" > 
								<tr>
									<td>DDR Verified by :</td>
									<td><input type="text" name="txt_convertedid" size="10" value="<%=Helper.correctNull((String)hshValues.get("DDR_VERIFIED_BY"))%>" readonly="readonly">
				<input type="text" name="txt_convertedname" size="30" value="<%=Helper.correctNull((String)hshValues.get("DDR_verified_name"))%>">
				<a href="#" onClick="javascript:callUsersHelp1('2')">
				<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0"> </a>
				</td>
								</tr> 
								<tr>
								<td>DDR Verified Date :</td>
							    <td>
	                 <input type="text" name="ddrverifidate" onBlur="checkDate(this);checkmaxdate(this,curdate)"
										value="<%=Helper.correctNull((String)hshValues.get("DDR_VERIFIED_DATE"))%>" maxlength="10" size="15" alt="Select date from calender">
										<a style="vertical-align: middle" onClick="callCalender('ddrverifidate')"
										onMouseOver="window.status='Date Picker';return true;"
										onMouseOut="window.status='';return true;"><img
										src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
										alt="Select date from calender"></a>
	                </td>
								</tr>
							</table>	
						</td>
						</tr>
	</tr>
	 </table>
	 <br>
     <lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete' btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>'/> 
<input type="hidden" name="hidresidence" value="<%=Integer.parseInt(Helper.correctInt((String)hshValues.get("CON_YEARS")))%>">
</form>
</body>
</html>
