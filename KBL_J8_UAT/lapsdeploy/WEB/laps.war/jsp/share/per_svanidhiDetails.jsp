<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%if (objValues instanceof java.util.HashMap) {
	hshValues = (java.util.HashMap) objValues;
}

String strModuleType="";
	strModuleType=Helper.correctNull((String) session.getAttribute("sessionModuleType"));
	
	String strEmployment="";
	strEmployment=(String)session.getAttribute("strEmployment");

	String strProfilestatus = Helper.correctNull((String) hshValues.get("strProfilestatus"));
	String strPageName=Helper.correctNull((String)hshValues.get("strIncompletepage"));

	ArrayList arrRow=new ArrayList();
	ArrayList arrCol=new ArrayList();
	arrRow=(ArrayList)hshValues.get("arrRow");
	
String strProfilestatus1=request.getParameter("strProfilestatus");
	
	String Status="";
	
	if(strProfilestatus.equalsIgnoreCase("Y"))
	{
		Status="Completed";
	}
	else
	{
		Status="Not Completed";
	}
	
	String pageid = request.getParameter("pageid");
	String strapptype = Helper.correctNull((String)request.getParameter("corp"));
	String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();

	ArrayList arrRowSchemes=new ArrayList();
	ArrayList arrcolSchemes=new ArrayList();
	arrRowSchemes=(ArrayList)hshValues.get("arrRowSchemes");
	int arrRowSchemeslen=0; 
	if(arrRowSchemes!=null)
	{
		arrRowSchemeslen=arrRowSchemes.size();
	}
	
    String strGovtScheme = Helper.correctNull((String) hshValues.get("perapp_govtschemes"));

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Land Holdings</title>
<STYLE>
DIV.cellContainer {
	width: 100%;
	height: 150;
	overflow: auto;
}
</STYLE>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var varCIG="<%=Helper.correctNull((String)hshValues.get("PERAPP_CIG"))%>";
var varJLG="<%=Helper.correctNull((String)hshValues.get("PERAPP_JLG"))%>";
var varNativity="<%=Helper.correctNull((String)hshValues.get("PERAPP_NATIVITY"))%>";
var varPWD="<%=Helper.correctNull((String)hshValues.get("perapp_pwd"))%>";
var varFamilyAvailable="<%=Helper.correctNull((String)hshValues.get("PERAPP_FAMILYAVAILABLE"))%>";
var varPLACEOFVENDING="<%=Helper.correctNull((String)hshValues.get("PERAPP_PLACEOFVENDING"))%>";
var varQRCODE="<%=Helper.correctNull((String)hshValues.get("PERAPP_QRCODE"))%>";
var varTermcertified1="<%=Helper.correctNull((String)hshValues.get("PERAPP_TERM1CERTIFIED"))%>";
var varTermcertified2="<%=Helper.correctNull((String)hshValues.get("PERAPP_TERMCERTIFIED2"))%>";
var appstatus ="<%=Helper.correctNull((String) hshValues.get("appstatus"))%>";
var userid ="<%=Helper.correctNull((String)session.getAttribute("strUserId"))%>";
var varwhtapplundertaken="<%=Helper.correctNull((String)hshValues.get("perapp_whtapplundertaken"))%>";
var varGovtScheme="<%=strGovtScheme%>";
var varGovtSchemeArray = varGovtScheme.split('@');
var len = varGovtSchemeArray.length;


var arrRowSchemeslen = <%=arrRowSchemeslen%> ;


function load()
{
	for ( var j = 0; j < len; j++) 
	{
		for ( var i = 0; i < document.forms[0].chk_schemes.length; i++) 
		{
			if (document.forms[0].chk_schemes[i].value == varGovtSchemeArray[j]) 
			{
				document.forms[0].chk_schemes[i].checked = true;
				if(varGovtSchemeArray[j]=="025")
				{
					document.forms[0].hidbankscheme.value="Y";
				}
			}
		}
	}
}

function enableButtons(bool2, bool3, bool4, bool5,bool6)
{
	
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool5;
	document.forms[0].cmdclose.disabled = bool6;
}

function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appURL+"action/mastersearchper.jsp";
		document.forms[0].submit();
	}
}

function disableFields(one)
{	
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
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
		if(document.forms[0].elements[i].type=="checkbox")
		{
			document.forms[0].elements[i].disabled=one;		  
		}		
	}
}

function doSave()
{  
	if(document.forms[0].sel_familyavailable.value == "")
	{
		ShowAlert('111','Do you have a family');
		document.forms[0].sel_familyavailable.focus();
		return;
	}

	if(document.forms[0].txt_svanidhino.value=="")
	{
		alert("Enter Unique Application No.");
		document.forms[0].txt_svanidhino.focus();
		return;
	}
	
	if(document.forms[0].sel_familyavailable.value=="Y")
	{
		var tab  = document.getElementById("tab_MemberDetails");
		var rowsLength = tab.rows.length;
		if(rowsLength==1)
		{
			if(document.forms[0].txt_name.value=="")
			{
				alert("Enter Name");
				document.forms[0].txt_name.focus();
				return;
			}
			if(document.forms[0].sel_relationship.value=="")
			{
				alert("Select Relationship with Applicant");
				document.forms[0].sel_relationship.focus();
				return;
			}
			if(document.forms[0].txt_age.value=="")
			{
				alert("Enter Age");
				document.forms[0].txt_age.focus();
				return;
			}
		}
		else if(rowsLength>=1)
		{
			for(var i=0;i<rowsLength;i++)
			{
				if(document.forms[0].txt_name[i].value=="")
				{
					alert("Enter Name");
					document.forms[0].txt_name[i].focus();
					return;
				}
				if(document.forms[0].sel_relationship[i].value=="")
				{
					alert("Select Relationship with Applicant");
					document.forms[0].sel_relationship[i].focus();
					return;
				}
				if(document.forms[0].txt_age[i].value=="")
				{
					alert("Enter Age");
					document.forms[0].txt_age[i].focus();
					return;
				}
			}
		}
	}
	
	if(document.forms[0].txt_venderidno.value == "")
	{
		ShowAlert('121','Vendor ID Card No');
		document.forms[0].txt_venderidno.focus();
		return;
	}
	
	if(document.forms[0].txt_vendercertno.value == "")
	{
		ShowAlert('121','Certificate of Vending No');
		document.forms[0].txt_vendercertno.focus();
		return;
	}
		
	if(document.forms[0].txt_lorno.value == "")
	{
		ShowAlert('121','Letter of Recommendation No (LoR)');
		document.forms[0].txt_lorno.focus();
		return;
	}	
	
	if(document.forms[0].txt_nameofactivity.value == "")
	{
		ShowAlert('121','Name of the Activity');
		document.forms[0].txt_nameofactivity.focus();
		return;
	}	
	
	if(document.forms[0].sel_placeofvending.value == "")
	{
		ShowAlert('111','Place of Vending');
		document.forms[0].sel_placeofvending.focus();
		return;
	}	
	
	if(document.forms[0].txt_vendingyears.value == "")
	{
		ShowAlert('121','Duration of Vending');
		document.forms[0].txt_vendingyears.focus();
		return;
	}
	
	if(document.forms[0].txt_vendingmonths.value == "")
	{
		ShowAlert('121','Duration of Vending');
		document.forms[0].txt_vendingmonths.focus();
		return;
	}

	if(document.forms[0].sel_placeofvending.value == "F")
	{
		if(document.forms[0].txt_fixedlocation.value == "")
		{
			ShowAlert('121','Stationary Vendor (Fixed Location)');
			document.forms[0].txt_fixedlocation.focus();
			return;
		}
	}
	if(document.forms[0].sel_placeofvending.value == "M")
	{
		if(document.forms[0].txt_fixedlocation.value == "")
		{
			ShowAlert('121','Mobile Vendor (Locality)');
			document.forms[0].txt_fixedlocation.focus();
			return;
		}
	}
	
	if(document.forms[0].txt_wardno.value == "")
	{
		ShowAlert('121','Ward No');
		document.forms[0].txt_wardno.focus();
		return;
	}
	
	if(document.forms[0].txt_District.value == "")
	{
		ShowAlert('111','District');
		document.forms[0].txt_District.focus();
		return;
	}	
	
	if(document.forms[0].txt_pincode.value == "")
	{
		ShowAlert('121','Pin Code');
		document.forms[0].txt_pincode.focus();
		return;
	}
	
	if(document.forms[0].txt_monthlysales.value == "")
	{
		ShowAlert('121','Average Monthly Sales (In Rs.)');
		document.forms[0].txt_monthlysales.focus();
		return;
	}	
	
	if(document.forms[0].txt_bankname.value == "")
	{
		ShowAlert('121','Name of the Bank');
		document.forms[0].txt_bankname.focus();
		return;
	}
	
	if(document.forms[0].txt_branch.value == "")
	{
		ShowAlert('121','Name of the Branch');
		document.forms[0].txt_branch.focus();
		return;
	}
		
	if(document.forms[0].txt_ifsccode.value == "")
	{
		ShowAlert('121','IFSC Code');
		document.forms[0].txt_ifsccode.focus();
		return;
	}
	
	if(document.forms[0].txt_accountno.value == "")
	{
		ShowAlert('121','Account No');
		document.forms[0].txt_accountno.focus();
		return;
	}
	
	if(document.forms[0].txt_payment.value == "")
	{
		ShowAlert('121','Payment Aggregator/s');
		document.forms[0].txt_payment.focus();
		return;
	}
	if(document.forms[0].txt_upiid.value == "")
	{
		ShowAlert('121','UPI ID/VPA');
		document.forms[0].txt_upiid.focus();
		return;
	}
	if(document.forms[0].sel_durableqr.value == "")
	{
		ShowAlert('111','Durable QR Code');
		document.forms[0].sel_durableqr.focus();
		return;
	}

	var flag = false;
	if(arrRowSchemeslen==1)
	{
		if(document.forms[0].chk_schemes.checked==true)
		{
			flag=true;
		}
	}
	else
	{
		for(var j=0;j<arrRowSchemeslen;j++)
		{
			if(document.forms[0].chk_schemes[j].checked==true)
			{
				flag=true;
				if(document.forms[0].hidbankscheme.value=="Y" && document.forms[0].chk_schemes[j].value!="025")
				{
					alert("Not Applicable");
					document.forms[0].chk_schemes[j].checked=false;
					return;
				}
			}
		}
	}

	if(flag==false)
	{
		ShowAlert('111','Govt. Schemes');
		return;
	}

	if(document.forms[0].sel_whtapplUndertaken.value == "")
	{
		ShowAlert('111','Whether the applicant has undertaken the below mentioned statements in the loan application form');
		document.forms[0].sel_whtapplUndertaken.focus();
		return;
	}
	
	if(document.forms[0].chk_trust.checked==false || document.forms[0].chk_trust1.checked==false )
	{
		alert("Check the Declaration");
		return;
	}

	if(document.forms[0].chk_trust.checked)
	{
		document.forms[0].hidcert.value="Y";
	}
	if(document.forms[0].chk_trust1.checked)
	{
		document.forms[0].hidcert1.value="Y";
	}
    document.forms[0].cmdsave.disabled = true;
    document.forms[0].hidBeanId.value="mastapplicant";
	document.forms[0].hidSourceUrl.value="/action/per_svanidhiDetails.jsp";
	document.forms[0].hidBeanMethod.value="updSvanidhiDetails";
	document.forms[0].hidBeanGetMethod.value="getSvanidhiDetails";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}


function doEdit()
{
 	document.forms[0].hidAction.value ="insert";
	disableCommandButtons("edit");
}
function disableCommandButtons(val)
{
	if(val=="edit")
	{		  
		disableFields(false);
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmddelete.disabled=false;
		document.forms[0].cmdsave.disabled=false;
		document.forms[0].cmdcancel.disabled=false;	
		document.forms[0].cmdclose.disabled=true;	 
	}
} 

function doCancel()
{   
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="mastapplicant";
		document.forms[0].hidBeanGetMethod.value="getSvanidhiDetails";
		document.forms[0].action=appURL+"action/per_svanidhiDetails.jsp";
		document.forms[0].submit(); 		
	}
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].hidBeanId.value="mastapplicant";
		document.forms[0].hidSourceUrl.value="/action/per_svanidhiDetails.jsp";
		document.forms[0].hidBeanMethod.value="updSvanidhiDetails";
		document.forms[0].hidBeanGetMethod.value="getSvanidhiDetails";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
	}
}
	
function onloading()
{	
	disableFields(true);
	if(appstatus=="true")
  	{
		enableButtons(true,true,true,true,true,false);
  	}
  	else
  	{
  		enableButtons(false,true,true,true,true,false);
  	}

	if(varCIG!="")
	{
		document.forms[0].sel_cig.value=varCIG;
	}
	if(varJLG!="")
	{
		document.forms[0].sel_jlg.value=varJLG;
	}
	if(varNativity!="")
	{
		document.forms[0].sel_nativity.value=varNativity;
	}
	if(varPWD!="")
	{
		document.forms[0].sel_pwd.value=varPWD;
	}
	if(varFamilyAvailable!="")
	{
		document.forms[0].sel_familyavailable.value=varFamilyAvailable;
	}
	if(varPLACEOFVENDING!="")
	{
		document.forms[0].sel_placeofvending.value=varPLACEOFVENDING;
	}
	if(varwhtapplundertaken!="")
	{
		document.forms[0].sel_whtapplUndertaken.value=varwhtapplundertaken;
	}
	
	if(document.forms[0].sel_placeofvending.value=="F")
	{
		document.all.id_stationVendor.style.display="table-row";
		document.all.id_MobileVendor.style.display="none";
	}
	else if(document.forms[0].sel_placeofvending.value=="M")
	{
		document.all.id_stationVendor.style.display="none";
		document.all.id_MobileVendor.style.display="table-row";
	}
	else
	{
		document.all.id_stationVendor.style.display="table-row";
		document.all.id_MobileVendor.style.display="none";
	}
	
	if(varQRCODE!="")
	{
		document.forms[0].sel_durableqr.value=varQRCODE;
	}

	if(document.forms[0].hidcert.value=="Y")
	{
		document.forms[0].chk_trust.checked=true;
		
	}
	if(document.forms[0].hidcert1.value=="Y")
	{
		document.forms[0].chk_trust1.checked=true;
		
	}
	enablefields('sel_jlg');
	enablefields('sel_cig');
	enablefields('sel_familyavailable');


	<%if(arrRow!=null && arrRow.size()>0){ 
		for(int i=0;i<arrRow.size();i++){
		arrCol=(ArrayList)arrRow.get(i);
		if(arrRow.size()==1){%>
		document.forms[0].sel_relationship.value="<%=Helper.correctNull((String)arrCol.get(1))%>";
		<%}else{%>
		document.forms[0].sel_relationship[<%=i%>].value="<%=Helper.correctNull((String)arrCol.get(1))%>";

		<%}
		}
	}%>

}
function Addvaluer(){

	if(document.forms[0].cmdsave.disabled==false)
	{	
	var tab  = document.getElementById("tab_MemberDetails");
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
				if(new_RowCell.childNodes[j].type=="select-one")
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
	if(document.forms[0].cmdsave.disabled==false)
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
					 if(tabid=="tab_MemberDetails" && rowsLength=="1")
					{
						document.forms[0].txt_fromyear.value="";  
						document.forms[0].txt_toyear.value="";  
						document.forms[0].txt_ftppl.value="";  
						document.forms[0].txt_ftpyield.value="";
						document.forms[0].txt_rorac.value="";  
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
function enablefields(varname)
{
	if(varname=="sel_familyavailable")
	{
		document.all.idTable.style.display="none";
		if(document.forms[0].sel_familyavailable.value=="Y")
		document.all.idTable.style.display="table-row";
	}
	else if(varname=="sel_cig")
	{
		document.all.idcig.style.display="none";
		if(document.forms[0].sel_cig.value=="Y")
			document.all.idcig.style.display="table-row";
	}
	else if(varname=="sel_jlg")
	{
		document.all.idjlg.style.display="none";
		if(document.forms[0].sel_jlg.value=="Y")
			document.all.idjlg.style.display="table-row";
	}
	else
	{
		document.all.idcig.style.display="none";
		document.all.idjlg.style.display="none";
		document.all.idTable.style.display="none";
	}
}
function callDistrict() {


			var varQryString = appURL

					+ "action/searchDistrict.jsp?hidBeanId=mastapplicant&hidBeanGetMethod=getDistrictSearch&code=svanidhi";

			var title = "District";

			var prop = 'scrollbars=yes,menubar=yes,status=yes,width=750,height=520';

			prop = prop + ",left=200,top=200";

			window.open(varQryString, title, prop);

}
function callBankmasterNew(id)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
			var varQryString = appURL+"action/ops_sanctionhelp.jsp?hidBeanGetMethod=getSearch&hidBeanId=additionalParameter&pagename=svanidhi&id="+id+"&LeadBank=Y";
			var title = "Bank_Master";
			var prop = "scrollbars=no,width=650,height=400";
			var xpos = "50";
			var ypos = "50";
			prop = prop+","+xpos+","+ypos+",left=200,top=200";
			window.open(varQryString,title,prop);
	}
}
function checkUser(name)
{
	if(name=="chk_trust1")
	{
		if(document.forms[0].chk_trust1.checked==true)
		{
			document.forms[0].hidTerm1checkedby.value=userid;
		}
		else
		{
			document.forms[0].hidTerm1checkedby.value="";
		}
	}
	else
	{
		if(document.forms[0].chk_trust.checked==true)
		{
			document.forms[0].hidTermcheckedby.value=userid;
		}
		else
		{
			document.forms[0].hidTermcheckedby.value="";
		}
	}
}

function chkMonths()
{
	if(document.forms[0].txt_vendingmonths.value!="")
	{
		if(eval(document.forms[0].txt_vendingmonths.value)>12)
		{
			alert("value should not be more than 12 Months");
			document.forms[0].txt_vendingmonths.value="";
			document.forms[0].txt_vendingmonths.focus();
			return;
		}
	}
}

function callIFSCcheck()
{
	if(document.forms[0].txt_ifsccode.value!="")
	{
		var varlen=document.forms[0].txt_ifsccode.value.length;
		if(varlen<11)
		{
			alert("IFSC Code should be 11 digit");
			document.forms[0].txt_ifsccode.focus();
			document.forms[0].txt_ifsccode.value="";
			return;
		}
	}
}

function chnVendingLoc()
{
	if(document.forms[0].sel_placeofvending.value=="F")
	{
		document.all.id_stationVendor.style.display="table-row";
		document.all.id_MobileVendor.style.display="none";
	}
	else if(document.forms[0].sel_placeofvending.value=="M")
	{
		document.all.id_stationVendor.style.display="none";
		document.all.id_MobileVendor.style.display="table-row";
	}
	else
	{
		document.all.id_stationVendor.style.display="table-row";
		document.all.id_MobileVendor.style.display="none";
	}
}

function chk_mobile1()
{
	if(document.forms[0].txt_localref1_mobile.value!="")
	{
		var varlen=document.forms[0].txt_localref1_mobile.value.length;
		if(varlen<10)
		{
			alert("Mobile numebr should be 10 digit");
			document.forms[0].txt_localref1_mobile.focus();
			document.forms[0].txt_localref1_mobile.value="";
			return;
		}
	}
}
function chk_mobile2()
{
	if(document.forms[0].txt_localref2_mobile.value!="")
	{
		var varlen=document.forms[0].txt_localref2_mobile.value.length;
		if(varlen<10)
		{
			alert("Mobile numebr should be 10 digit");
			document.forms[0].txt_localref2_mobile.focus();
			document.forms[0].txt_localref2_mobile.value="";
			return;
		}
	}
}
function checkno()
{
	if(document.forms[0].txt_svanidhino.value=="" && document.forms[0].cmdsave.disabled==false)
	{
		document.forms[0].txt_svanidhino.value="PMS";
	}
}
function checkvalues(obj)
{
	if(obj.value=="025")
	{
		if(obj.checked==true)
		{
			document.forms[0].hidbankscheme.value="Y";
		}
		else
		{
			document.forms[0].hidbankscheme.value="";
		}
	}
	if(obj.checked==true && document.forms[0].hidbankscheme.value=="Y" && obj.value!="025")
	{
		alert("Not Applicable");
		obj.checked=false;
		return;
	}
}
</script>
</head>
<body onLoad="onloading();load()">
<form class="normal" method="post">
<%if(Helper.correctNull((String)session.getAttribute("sessionModuleType")).equals("")) { %>

<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>

		<td class="page_flow">Home -&gt; Customer Profile -&gt;SVANidhi
		Details</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
		<table width="98%" border="0" cellspacing="1" cellpadding="3"
			align="left" class="outertable">
			<tr>
				<td><jsp:include page="../share/Cusurllink.jsp" flush="true">
					<jsp:param name="pageid" value="13" />
					<jsp:param name="employmenttype" value="<%=strEmployment%>" />
					<jsp:param name="strProfilestatus" value="<%=strProfilestatus%>" />
					<jsp:param name="hidincompletedpagename" value="<%=strPageName%>" />
				</jsp:include></td>
			</tr>
		</table>
		</td>
	</tr>
</table>

<% } else {  %> <%
if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){ 
if(!strSessionModuleType.equalsIgnoreCase("RET")){%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../com/postsanctionlinks.jsp" flush="true">
			<jsp:param name="pageid" value="1" />
			<jsp:param name="subpageid" value="115" />
			<jsp:param name="subsubpageid" value="13" />
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
		<td><jsp:include page="../set/postsanctionlinksper.jsp"
			flush="true">
			<jsp:param name="pageid" value="2" />
			<jsp:param name="subsubpageid" value="13" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<%} %> <jsp:include page="../share/Cusurllinkdisp.jsp" flush="true">
	<jsp:param name="pageid" value="" />
	<jsp:param name="subsubpageid" value="13" />
	<jsp:param name="employmenttype" value="<%=strEmployment%>" />
	<jsp:param name="demoid" value="<%=strapptype%>" />
</jsp:include> <%}else{ %> <%if(strapptype.equalsIgnoreCase("C")){ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="1" />
			<jsp:param name="cattype" value="CORP" />
			<jsp:param name="ssitype" value="" />
			<jsp:param name="applevel" value="A" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td class="page_flow">Home -&gt;Corporate &amp; SME -&gt;
		Application -&gt; Applicant -&gt; Customer Profile -&gt; SHG</td>
	</tr>
</table>
<%} else if(strapptype.equalsIgnoreCase("R")){ %> <jsp:include
	page="../share/Applurllinkper.jsp" flush="true">
	<jsp:param name="pageid" value="<%=pageid%>" />
</jsp:include>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	align="center" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Retail -&gt; Application -&gt;
		Applicant/Guarantor -&gt; SHG</td>
	</tr>
</table>
<%} %> <lapschoice:application />

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
				<td><jsp:include page="../share/Cusurllinkdisp.jsp"
					flush="true">
					<jsp:param name="pageid" value="13" />
					<jsp:param name="employmenttype" value="<%=strEmployment%>" />
					<jsp:param name="demoid" value="<%=strapptype%>" />
				</jsp:include></td>
			</tr>
			<%} %>
		</table>
		</td>
	</tr>
</table>
<%} %> <% } %>

<table width="97%" border="0" cellspacing="0" cellpadding="3"
	class="outertable border1" align="center">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="1" cellpadding="3"
			class="outertable" align="center">
			
			<tr>
			<td>Unique Application No. (given by PM Svanidhi)</td>
			<td><input type="text" name="txt_svanidhino" onkeypress="allowAlphaNumeric();" onfocus="checkno();" value="<%=Helper.correctNull((String)hshValues.get("PER_SVANIDHIAPPNO")) %>" maxlength="14"></td>
			</tr>
			<tr>
			<td>Member of CIG</td>
			<td><select name="sel_cig" onchange="enablefields('sel_cig');">
			<option value=""><--select--></option>
			<option value="Y">Yes</option>
			<option value="N">No</option>
			</select></td>
			</tr>
			<tr id="idcig">
			<td width="25%">Name of the CIG</td>
			<td width="25%"><input type="text" name="txt_cigname" value="<%=Helper.correctNull((String)hshValues.get("PERAPP_CIGNAME")) %>" maxlength="50" onkeypress="allowAlphabetsForName();"></td>
			<td width="25%">Code</td>
			<td width="25%"><input type="text" name="txt_cigcode" value="<%=Helper.correctNull((String)hshValues.get("PERAPP_CIGCODE")) %>" maxlength="25" onkeypress="allowAlphaNumeric();"></td>
			</tr>
			<tr>
			<td>Member of JLG</td>
			<td><select name="sel_jlg" onchange="enablefields('sel_jlg');">
			<option value=""><--select--></option>
			<option value="Y">Yes</option>
			<option value="N">No</option>
			</select></td>
			</tr>
			<tr id="idjlg">
			<td width="25%">Name of the JLG</td>
			<td width="25%"><input type="text" name="txt_jigname" value="<%=Helper.correctNull((String)hshValues.get("PERAPP_JLGNAME")) %>" maxlength="50" onkeypress="allowAlphabetsForName();"></td>
			<td width="25%">Code</td>
			<td width="25%"><input type="text" name="txt_jigcode" value="<%=Helper.correctNull((String)hshValues.get("PERAPP_JLGCODE")) %>" maxlength="25" onkeypress="allowAlphaNumeric();"></td>
			</tr>
			<tr>
			<td>Nativity</td>
			<td>
			<select name="sel_nativity">
			<option value=""><--select--></option>
			<lapschoice:StaticDataTag apptype="237" />
			</select>
			</td>
			<td>PWD</td>
			<td><select name="sel_pwd">
			<option value=""><--select--></option>
			<option value="Y">Yes</option>
			<option value="N">No</option>
			</select></td>
			</tr>
			<tr>
			<td>Do you have a family <span class="mantatory">*&nbsp;</span></td>
			<td><select name="sel_familyavailable" onchange="enablefields('sel_familyavailable');">
			<option value=""><--select--></option>
			<option value="Y">Yes</option>
			<option value="N">No</option>
			</select></td>
			</tr>
			<tr id="idTable" style="display: none;">
<td colspan="4">
<table width="100%"  border="0"   cellpadding="4"  class="outertable" align="center"  style="border: 1px solid #bbb;" >
 <tr class="dataheader">
	<td width="10%" align="center"><span style=""><a onClick="Addvaluer();"><img
		src="<%=ApplicationParams.getAppUrl()%>img/add.png"
		border="0" tabindex="38"></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 		<a onClick="deleteRow1('tab_MemberDetails','0');"><img
		src="<%=ApplicationParams.getAppUrl()%>img/cancel.png"
			border="0"></a> </span> </td>
		<td width="20%" align="center"> Name</td>
		<td  width="25%" align="center"> Relationship with Applicant</td>
		<td  width="25%" align="center"> Age</td>
</tr>
</table>
<table width="100%" border="0"   class="outertable"  align="center" cellpadding="3" style="border: 1px solid #bbb;" id="tab_MemberDetails">
 <%if(arrRow!=null && arrRow.size()>0){ 
	for(int i=0;i<arrRow.size();i++){
	arrCol=(ArrayList)arrRow.get(i);%>
<tr id="0"  align="center">	
	<td width="10%" class="datagrid"><input type="checkbox" name="chk1" style="border: none;"></td>	
	<td width="20%" class="datagrid"><input type="text" name="txt_name" size="25" onkeypress="allowAlphabetsForName(this)" value="<%=Helper.correctNull((String)arrCol.get(0)) %>"  maxlength="50" ></td>
	<td width="25%" class="datagrid"><select name="sel_relationship"><option value=""><--select--></option>
			<lapschoice:StaticDataTag apptype="238" />
			</select></td>
	<td width="25%" class="datagrid"><input type="text" name="txt_age" size="7" onkeypress="allowWholeNumber(this)"  value="<%=Helper.correctNull((String)arrCol.get(2)) %>" maxlength="3"></td>
</tr>
<%}}else{ %>
<tr id="0"  align="center">	
	<td width="10%" class="datagrid"><input type="checkbox" name="chk1" style="border: none;"></td>	
	<td width="20%" class="datagrid"><input type="text" name="txt_name" size="25" onkeypress="allowAlphabetsForName(this)" maxlength="50"></td>
	<td width="25%" class="datagrid"><select name="sel_relationship"><option value=""><--select--></option>
			<lapschoice:StaticDataTag apptype="238" />
			</select></td>
	<td width="25%" class="datagrid"><input type="text" name="txt_age" size="7" onkeypress="allowWholeNumber(this)" maxlength="3" ></td>

</tr>
<%} %>
</table>
</td>
</tr>
<tr>
<td colspan="6" class="dataheader">Proof of Vending</td>
</tr>

<tr>
<td>Vendor ID Card No. <span class="mantatory">*&nbsp;</span></td>
<td><input type="text" name="txt_venderidno" value="<%=Helper.correctNull((String)hshValues.get("PERAPP_VENDERIDCARDNO")) %>" maxlength="25" onkeypress="allowAlphaNumeric();"></td>
<td>Certificate of Vending No <span class="mantatory">*&nbsp;</span></td>
<td><input type="text" name="txt_vendercertno" value="<%=Helper.correctNull((String)hshValues.get("PERAPP_CARTVENDINGNO")) %>" maxlength="30" onkeypress="allowAlphaNumeric();"></td>
</tr>
<tr>
<td>Letter of Recommendation No (LoR) <span class="mantatory">*&nbsp;</span></td>
<td><input type="text" name="txt_lorno" value="<%=Helper.correctNull((String)hshValues.get("PERAPP_LETTEROFRECOMMD")) %>" maxlength="25" onkeypress="allowAlphaNumeric();"></td>
</tr>
<tr>
<td colspan="6" class="dataheader">Vending Activity</td>
</tr>

<tr>
<td>Name of the Activity (Please Specify)<span class="mantatory">*&nbsp;</span></td>
<td><input type="text" name="txt_nameofactivity" value="<%=Helper.correctNull((String)hshValues.get("PERAPP_NATIVEOFACTIVITY")) %>" maxlength="25" onkeypress="allowAlphaNumeric();"></td>
<td>Place of Vending (Fixed Location/Mobile) <span class="mantatory">*&nbsp;</span></td>
<td><select name="sel_placeofvending" onchange="chnVendingLoc()">
			<option value=""><--select--></option>
			<option value="F">Fixed Location</option>
			<option value="M">Mobile</option>
			</select></td>
</tr>
<tr>
<td>Duration of Vending <span class="mantatory">*&nbsp;</span></td>
<td><input type="text" name="txt_vendingyears"
	size="5" maxlength="4" tabindex=""
	style="text-align:left"
	value="<%=Helper.correctNull((String)hshValues.get("PERAPP_DUROFVENDINGYRS")) %>"
	 onKeyPress="allowInteger()"> Years
&nbsp;&nbsp;&nbsp; <input type="text" name="txt_vendingmonths" size="5" value="<%=Helper.correctNull((String)hshValues.get("PERAPP_DUROFVENDINGMONTH")) %>"
	onKeyPress="allowInteger();" onblur="chkMonths();"> Months</td>
</tr>
<tr>
<td colspan="6" class="dataheader">Location/Area of Vending</td>
</tr>
<tr >
<td id="id_stationVendor">Stationary Vendor (Fixed Location)	<span class="mantatory">*&nbsp;</span></td>
<td id="id_MobileVendor">Mobile Vendor (Locality) 		<span class="mantatory">*&nbsp;</span>	</td>
<td><input type="text" name="txt_fixedlocation" value="<%=Helper.correctNull((String)hshValues.get("PERAPP_STATIONARYVEYNDOR")) %>" maxlength="50"></td>
<td>Nearest Landmark	</td>
<td><input type="text" name="txt_nearestlandmark" value="<%=Helper.correctNull((String)hshValues.get("PERAPP_NEARESTLANDMARK")) %>" maxlength="100"></td>
</tr>
<tr >
<td><input type="hidden" name="txt_mobilelocation" value="<%=Helper.correctNull((String)hshValues.get("PERAPP_MOBILEVEYNDOR")) %>" maxlength="100"></td>
<td><input type="hidden" name="txt_mobilenearestlandmark" value="<%=Helper.correctNull((String)hshValues.get("PERAPP_MOBILENEARESTLANDMARK")) %>" maxlength="100"></td>
</tr>
<tr>
<td>Ward No.<span class="mantatory">*&nbsp;</span></td>
<td><input type="text" name="txt_wardno" value="<%=Helper.correctNull((String)hshValues.get("PERAPP_WARDNO")) %>" maxlength="50"></td>
<td>District <span class="mantatory">*&nbsp;</span></td>
<td><input type="text" name="txt_DistrictDesc" value="<%=Helper.correctNull((String)hshValues.get("PERAPP_DISTRICTDesc")) %>"><a href="#" onClick="callDistrict();" style="cursor: hand" tabindex="14">
									<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0">
								</a><input type="hidden" name="txt_District"  value="<%=Helper.correctNull((String)hshValues.get("PERAPP_DISTRICT")) %>"></td>
</tr>
<tr>
<td>Pin Code <span class="mantatory">*&nbsp;</span></td>
<td><input type="text" name="txt_pincode" onKeyPress="allowInteger()" value="<%=Helper.correctNull((String)hshValues.get("PERAPP_PINCODE")) %>" maxlength="6"></td>
</tr>

<tr>
<td>Average Monthly Sales (In Rs.) <span class="mantatory">*&nbsp;</span></td>
<td><input type="text" name="txt_monthlysales" value="<%=Helper.correctNull((String)hshValues.get("PERAPP_AVERAGEMONTHLY")) %>" onKeyPress="allowNumber(this)" onblur="roundtxt(this)";></td>
</tr>
<tr>
<td colspan="4" class="dataheader">Aadhaar Linked Bank Account(s)</td>
</tr>
<tr>
<td>Name of the Bank<span class="mantatory">*&nbsp;</span></td>
<td><input type="text" name="txt_bankname" value="<%=Helper.correctNull((String)hshValues.get("PERAPP_BANKNAMEDesc")) %>"><a href="#" onClick="callBankmasterNew('147')" style="cursor: hand">
										<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0">
										</a><input type="hidden" name="txt_bankcode" value="<%=Helper.correctNull((String)hshValues.get("PERAPP_BANKCode")) %>"></td>
<td>Name of the Branch<span class="mantatory">*&nbsp;</span></td>
<td><input type="text" name="txt_branch" value="<%=Helper.correctNull((String)hshValues.get("PERAPP_BRANCHNAME")) %>"></td>
</tr>
<tr>
<td>IFSC Code<span class="mantatory">*&nbsp;</span></td>
<td><input type="text" name="txt_ifsccode"  onblur="callIFSCcheck()" maxlength="11" value="<%=Helper.correctNull((String)hshValues.get("PERAPP_IFSCCODE")) %>"></td>
<td>Account No<span class="mantatory">*&nbsp;</span></td>
<td><input type="text" name="txt_accountno" value="<%=Helper.correctNull((String)hshValues.get("PERAPP_ACCOUNTNO")) %>"></td>
</tr>
<tr>
<td colspan="4" class="dataheader">Digital Payment Details</td>
</tr>
<tr>
<td>Payment Aggregator/s<span class="mantatory">*&nbsp;</span></td>
<td><input type="text" name="txt_payment" value="<%=Helper.correctNull((String)hshValues.get("PERAPP_PAYMENTAGGREGATOR")) %>"></td>
<td>UPI ID/VPA<span class="mantatory">*&nbsp;</span></td>
<td><input type="text" name="txt_upiid" value="<%=Helper.correctNull((String)hshValues.get("PERAPP_UPIID")) %>"></td>
</tr>
<tr>
			<td>Durable QR Code<span class="mantatory">*&nbsp;</span></td>
			<td><select name="sel_durableqr">
			<option value=""><--select--></option>
			<option value="Y">Yes</option>
			<option value="N">No</option>
			</select></td>
</tr>

<tr>
<td colspan="4" class="dataheader">Local references</td>
</tr>
<tr>
	<td colspan="2">Reference No 1 </td>
	<td colspan="2">Reference No 2 </td>
</tr>
<tr>
	<td>Name </td>
	<td><input type="text" name="txt_localref1_name" value="<%=Helper.correctNull((String)hshValues.get("perapp_localref1_name")) %>"> </td>
	<td>Name </td>
	<td><input type="text" name="txt_localref2_name" value="<%=Helper.correctNull((String)hshValues.get("perapp_localref2_name")) %>"> </td>
</tr>
<tr>
	<td>Mobile Number </td>
	<td><input type="text" name="txt_localref1_mobile" value="<%=Helper.correctNull((String)hshValues.get("perapp_localref1_mobile")) %>" onKeyPress="allowInteger()" maxlength="10" onblur="chk_mobile1()"> </td>
	<td>Mobile Number </td>
	<td><input type="text" name="txt_localref2_mobile" value="<%=Helper.correctNull((String)hshValues.get("perapp_localref2_mobile")) %>" onKeyPress="allowInteger()" maxlength="10" onblur="chk_mobile2()"> </td>
</tr>
<tr>
	<td>Address </td>
	<td> <textarea name="txt_localref1_address" onKeyDown="textlimit(this,200)" onKeyUp="textlimit(this,200)" tabindex="91" rows="5" cols="40">
	 <%=Helper.correctNull((String)hshValues.get("perapp_localref1_address")) %></textarea> </td>
	<td>Address </td>
	<td> <textarea name="txt_localref2_address" onKeyDown="textlimit(this,200)" onKeyUp="textlimit(this,200)" tabindex="91" rows="5" cols="40">
	 <%=Helper.correctNull((String)hshValues.get("perapp_localref2_address")) %></textarea> </td>
</tr>
			
			<tr><td colspan="4" class="dataheader">Benefits availed under other Govt. Schemes </td></tr>
			<tr>
			<td> 
				<table class="outertable">
				
				<%for(int i=0;i<arrRowSchemes.size();i++)
				{
					arrcolSchemes=(ArrayList)arrRowSchemes.get(i);
					%>
				<tr>
				<td>
					<input type="checkbox" name="chk_schemes" style="border: none;"  onclick="checkvalues(this);" value="<%=arrcolSchemes.get(0)%>"> <%=arrcolSchemes.get(1) %>
				</tr>
				<%} %>
				</table>
			</td>
			</tr>		
	
	<tr><td colspan="4" class="dataheader"> Declarations </td></tr>		
			<tr>
				<td>Whether the applicant has undertaken the below <br>mentioned statements in the loan application form </td>
				<td> 
					<select name="sel_whtapplUndertaken">
					<option value=""><--select--></option>
					<option value="Y">Yes</option>
					<option value="N">No</option>
					</select>
				</td>
			</tr>
			<tr>
			<td colspan="4"><input type="checkbox" name="chk_trust" style="border: none;" onclick="checkUser('chk_trust')"><input type="hidden" name="hidTermcheckedby" value="<%=Helper.correctNull((String)hshValues.get("PERAPP_TERM1CERTIFIEDBY")) %>">I here certify that all information furnished by me/us is true,correct and complete.I have no borrowing arrangements except as indicated in the application form.I have not applied to any lending institution. There is/are no overdue/statutory due owed by me.The information may also be exchanged by you with the agency,you may deem fit.You, your representatives or MoHUA,or any other agency as authorized by you,may  at any time,inspect/verify my/our assets etc. You may take appropriate safeguards/action for recovery of lending institutions dues.	</td>
			</tr>
			<tr><td>&nbsp;</td></tr>
			<tr>
			<td colspan="4"><input type="checkbox" name="chk_trust1" style="border: none;" onclick="checkUser('chk_trust1')"><input type="hidden" name="hidTerm1checkedby" value="<%=Helper.correctNull((String)hshValues.get("PERAPP_TERM2CERTIFIEDBY")) %>">I have no objection to authenticate my Aadhaar number, share the same with other Ministries/Departments under the Government of India for the purpose of extension of benefits under any of their Schemes,carry out e-KYC and accessing my credit history & credit score by credit bureau,lenders and  their authorized agents. The consent and purpose of collecting Aadhaar has been explained to me/us in local language.MoHUA/Lending Institution has informed me that my Aadhaar submitted shall not be used for any purpose other than mentioned above, or as per requirements of law. I have been informed that this consent and my Aadhaar  will be stored along with my accounts details with MoHUA.</td>
			</tr>
			
			

		</table>
		</td>
	</tr>
</table>


<%if(Helper.correctNull((String)session.getAttribute("sessionModuleType")).equals("")) { %>

<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete_Audit Trail"
	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<% }  else { %> <span style="display: none;">
<div><lapschoice:combuttonnew
	btnnames="Edit_Save_Cancel_Delete_Audit Trail"
	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
</div>
</span> <lapschoice:combuttonnew
	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<% } %> <lapschoice:hiddentag pageid="<%=PageId%>" />
</tr>
</table>
<input type="hidden" name="app_constitution"
	value="<%=Helper.correctNull((String)hshValues.get("app_constitution"))%>">
<input type="hidden" name="hidDemoId"
	value="<%=Helper.correctNull((String)request.getParameter("hidDemoId"))%>">
<input type="hidden" name="txtperapp_appid"
	value="<%=Helper.correctNull((String)hshValues.get("perapp_id"))%>">
<input type="hidden" name="hidappstatus"
	value="<%=Helper.correctNull((String)hshValues.get("appstatus"))%>">
<input type="hidden" name="hidcert" value="<%=Helper.correctNull((String)hshValues.get("PERAPP_TERM1CERTIFIED"))%>">
<input type="hidden" name="hidcert1"  value="<%=Helper.correctNull((String)hshValues.get("PERAPP_TERMCERTIFIED2"))%>">
<input type="hidden" name="hidbankscheme">
</form>
</body>
</html>