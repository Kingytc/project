<%@include file="../share/directives.jsp"%>
<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<%
java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);
nf.setGroupingUsed(false);
String sectype = Helper.correctNull((String) request.getParameter("hidsectype"));
String strsecID = Helper.correctNull((String) request.getParameter("hidsecid"));
String strPagefrom = Helper.correctNull((String) request.getParameter("pagefrom"));
String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
String pageid = request.getParameter("pageid");
String grpRights = Helper.correctNull((String) session.getAttribute("strGroupRights"));
String VALUER_VALUEDLOC=Helper.correctNull((String)hshValues.get("VALUER_VALUEDLOC"));
String strSEC_CLASSIFICATION=Helper.correctNull((String)hshValues.get("CUS_SEC_CLASSIFICATION"));
String strsectypes = Helper.correctNull((String)hshValues.get("cus_sec_type"));
String strcersaimindate="31/03/2011";
%>
<lapschoice:handleerror />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Security - Property Details</title>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varPropertyType="<%=Helper.correctNull((String)hshValues.get("sec_propertytype"))%>";
var varMeasurement="<%=Helper.correctNull((String)hshValues.get("sec_measurement"))%>";
var varAcquired="<%=Helper.correctNull((String)hshValues.get("sec_propertyacq"))%>";
var varExtnMeasurement="<%=Helper.correctNull((String)hshValues.get("sec_extofbuildmeas"))%>";
var varCoveredMeasurement="<%=Helper.correctNull((String)hshValues.get("sec_extofbuildmeas"))%>";
var varNotCoveredMeasurement="<%=Helper.correctNull((String)hshValues.get("sec_extnotcoveredmeas"))%>";
var varsecboundaries="<%=Helper.correctNull((String)hshValues.get("SEC_BOUNDARIES"))%>";
var varVerificationFlag="<%=Helper.correctNull((String)hshValues.get("hid_VerificationFlag"))%>";
var curdate = "<%=Helper.getCurrentDateTime()%>";
var cersaimindate = "<%=strcersaimindate%>";
var VALUER_VALUEDLOC="<%=Helper.correctNull((String)hshValues.get("VALUER_VALUEDLOC"))%>";
var varselpropacquisition="<%=Helper.correctNull((String)hshValues.get("SEC_PROPACQUISITION"))%>";
var varselpropnewtype="<%=Helper.correctNull((String)hshValues.get("SEC_PROP_STAGE"))%>";
var varValuerCode="<%=Helper.correctNull((String)hshValues.get("strValuerCode"))%>";
var varServeyNo="<%=Helper.correctNull((String)hshValues.get("sec_surveyno"))%>";
var varCersaiID="<%=Helper.correctNull((String)hshValues.get("SEC_CERSAI_ID"))%>";
var varCersaiDate="<%=Helper.correctNull((String)hshValues.get("SEC_CERSAI_DATE"))%>";
var varWHT_PROJECTAPPROVED="<%=Helper.correctNull((String)hshValues.get("SEC_WHT_PROJECTAPPROVED"))%>";
var varSec_Classify="<%=strSEC_CLASSIFICATION%>";
var cersailIDCorp=null;
var varcussectype="<%=Helper.correctNull((String)hshValues.get("cus_sec_type"))%>";

var varseccersirefno="<%=Helper.correctNull((String)hshValues.get("SEC_CERSAIREFNO"))%>";
var varcersaidate1="<%=Helper.correctNull((String)hshValues.get("SEC_SEARCHPERFORM_DATE"))%>";
var varcersairemarks="<%=Helper.correctNull((String)hshValues.get("sec_remarks"))%>";
var VARSECPROPOBSERVED="<%=Helper.correctNull((String)hshValues.get("SEC_ALREADY_MORTG"))%>";
var VARCHARGREFLECT="<%=Helper.correctNull((String)hshValues.get("SEC_CHARG_REFLECT"))%>";
var VARPROPOBSERVED="<%=Helper.correctNull((String)hshValues.get("SEC_PROP_OBSERVED"))%>";
var VARCROPTYPE="<%=Helper.correctNull((String)hshValues.get("SEC_CROPTYPE"))%>";
var varsectype="<%=strsectypes%>";
var varsecurity_type="<%=Helper.correctNull((String)hshValues.get("security_type"))%>";
var varleasehold="<%=Helper.correctNull((String)hshValues.get("chk_property_leasehold"))%>";
var varnetval="<%=Helper.correctNull((String)hshValues.get("netsecurity_val"))%>";

function callOnLoad1()
{
	disableFields(true);
	disableButtons(false,true,true,true,false);
	document.forms[0].sel_PropertyType.value=varPropertyType;
	document.forms[0].sel_propacquisition.value=varselpropacquisition;   
	document.forms[0].sel_whtprojapr.value=varWHT_PROJECTAPPROVED;   
	document.forms[0].sel_Measurement.value=varMeasurement;
	document.forms[0].sel_Acquired.value=varAcquired;
	document.forms[0].sel_extofbuildMeas.value=varExtnMeasurement;
	document.forms[0].sel_extofgroundMeas.value=varCoveredMeasurement;
	document.forms[0].sel_extnotcoveredMeas.value=varNotCoveredMeasurement;
	document.forms[0].sel_boundaries.value=varsecboundaries;
	document.forms[0].sel_whtalrmortobnk.value=VARSECPROPOBSERVED;   
	document.forms[0].sel_whtbnkchrgreflct.value=VARCHARGREFLECT;   
	document.forms[0].sel_anychrgonprop.value=VARPROPOBSERVED;
	document.forms[0].sel_corpType.value=VARCROPTYPE;
	
	document.all.sel123.style.visibility = "hidden";
	document.all.sel123.style.position = "absolute";
	//document.all.txtarea123.style.visibility = "hidden";
	//document.all.txtarea123.style.visibility = "absolute";
	document.all.txtarea124.style.visibility = "hidden";
	document.all.txtarea124.style.position = "absolute";
	document.all.showval.style.display="none";

	if(document.forms[0].sel_PropertyType.value=="F" || document.forms[0].sel_PropertyType.value=="H" )
	{
		document.all.sel123.style.visibility = "visible";
		document.all.sel123.style.position = "relative";
		addNewVal();		
	}
	if(document.forms[0].sel_propacquisition.value=="T")
	{
		document.all.txtarea124.style.visibility = "visible";
		document.all.txtarea124.style.position = "relative";
	}
	//callShowMeasurement();
	if(varSec_Classify=='61'){
		document.all.BA.style.visibility = "visible";
		document.all.BA.style.position = "relative";
		document.all.BA1.style.visibility = "visible";
		document.all.BA1.style.position = "relative";
		document.all.BA2.style.visibility = "visible";
		document.all.BA2.style.position = "relative";
		
	}
	else{
		document.all.BA.style.visibility = "hidden";
		document.all.BA.style.position = "absolute";
		document.all.BA1.style.visibility = "hidden";
		document.all.BA1.style.position = "absolute";
		document.all.BA2.style.visibility = "hidden";
		document.all.BA2.style.position = "absolute";
	}
	<%if(grpRights.charAt(18)=='r'){%>
	document.forms[0].cmdedit.disabled=true;
<%}%>

	if(varVerificationFlag=="V")
	{
		document.forms[0].cmdedit.disabled=true;
	}
	chkProjApproved('load');

	if(varsectype=="14")
	{
		document.all.showagr.style.visibility = "visible";
		document.all.showagr.style.position = "relative";
		document.all.showagr1.style.visibility = "visible";
		document.all.showagr1.style.position = "relative";
	}else{
		document.all.showagr.style.visibility = "hidden";
		document.all.showagr.style.position = "absolute";
		document.all.showagr1.style.visibility = "hidden";
		document.all.showagr1.style.position = "absolute";
	}

	questionery();
	
}
function disableButtons(cmdEdit,cmdSave,cmdCancel,cmdDelete,cmdClose)
{
	document.forms[0].cmdedit.disabled=cmdEdit;
	document.forms[0].cmdsave.disabled=cmdSave;
	document.forms[0].cmdcancel.disabled=cmdCancel;
	document.forms[0].cmddelete.disabled=cmdDelete;
	document.forms[0].cmdclose.disabled=cmdClose;
}
function showCitySearch(varTextControl,varTextControl1,varHidControl,varHidControl1,varTextControl2,varHidControl2)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		var varQryString = appURL+"action/searchCity.jsp?hidcitycontrol="+varTextControl+"&hidstatecontrol="+varTextControl1+"&hidcitycodecontrol="+varHidControl+"&hidstatecodecontrol="+varHidControl1+"&hidzipcontrol="+varTextControl2+"&hidzipvaildatorcontrol="+varHidControl2;
		var title = "City";
		var prop = "scrollbars=yes,width=650,height=400,menubar=yes";	
		var xpos = (screen.width - 350) / 2;
		var ypos = (screen.height - 120) / 2;
		prop = prop + ",left=50,top=50";
		window.open(varQryString,title,prop);
	}
}
function showDistSearch(val)
{  

	var varstate = document.forms[0].hidstate.value;
	if(document.forms[0].cmdsave.disabled==false)
	{
	if(document.forms[0].hidstate.value=="")
	{
		alert("Please Reselect the City");
		document.forms[0].txt_City.focus();
		return;
	}
	if(document.forms[0].txt_City.value=="")
	{
		ShowAlert(112,"City");
		document.forms[0].txt_City.focus();
		return;
	}	
	else		
	{
    var varQryString = appURL+"action/searchDistrict.jsp?hidBeanId=mastapplicant&hidBeanGetMethod=getDistrictSearch&statecode="+varstate+"&code="+val;
	var title = "District";
	var prop = 'scrollbars=yes,menubar=yes,status=yes,width=750,height=520';	
	prop = prop + ",left=200,top=200";
	window.open(varQryString,title,prop);
	}
	}	
	
}
function showOrganisationSearch(varAppUrl,varSelLoc,varTxtLoc)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showOrgSearch(varAppUrl,varSelLoc,varTxtLoc);
	}
}
function dobtnClose()
{
	if (ConfirmMsg(100)) 
	{
	<%if(strPagefrom.equalsIgnoreCase("appl")&&(strSessionModuleType.equalsIgnoreCase("RET"))){%>
		document.forms[0].hidBeanId.value="bankappfi"
		document.forms[0].hidBeanGetMethod.value="getSecurityRetailDetails";
		document.forms[0].action=appURL+"action/securitymaster_retail.jsp";
		document.forms[0].submit();
	<%}else if(strPagefrom.equalsIgnoreCase("secmailbox")){%>
		window.close();
	<%}else{%>
		document.forms[0].hidBeanId.value="securitymaster"
		document.forms[0].hidBeanGetMethod.value="getSecurityValuesDetails";
		document.forms[0].action=appURL+"action/securitiesMasterPage.jsp";
		document.forms[0].submit();
	<%}%>
	}
}
function addOtherList()
{
	if(document.forms[0].sel_propacquisition.value=="T")
	{
		document.all.txtarea124.style.visibility = "visible";
		document.all.txtarea124.style.position = "relative";
	}
	else
	{
		document.all.txtarea124.style.visibility = "hidden";
		document.all.txtarea124.style.position = "absolute";
	}
}

function addNewVal(){

	if(document.forms[0].sel_PropertyType.value=="F" || document.forms[0].sel_PropertyType.value=="H" ){

		document.all.sel123.style.visibility = "visible";
		document.all.sel123.style.position = "relative";
	}
	else{
		document.all.sel123.style.visibility = "hidden";
		document.all.sel123.style.position = "absolute";
		document.forms[0].sel_prop.value="";
	}	


	if((document.forms[0].sel_PropertyType.value=="F"||document.forms[0].sel_PropertyType.value=="H") && (document.forms[0].sel_prop.value=="C"))
	{
		document.all.showval.style.display = "table-row";
	}
	else
	{
		document.all.showval.style.display = "none";
		document.forms[0].txt_AgeOfBuilding.value= "";
	}
	if(document.forms[0].sel_PropertyType.value=="F" || document.forms[0].sel_PropertyType.value=="H" ){
		document.all.ext_build.style.visibility = "visible";
	}
	else{
		document.all.ext_build.style.visibility = "hidden";
	}
}

function addSerValued()
{
	
	if(document.forms[0].cmdedit.disabled==true)
	{	
	var tab  = document.getElementById("tabid_SerValue");
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
					new_RowCell.childNodes[j].disabled=false;
				}
			}
			 
		}
	}
	else
	{
		alert("Cannot add more rows");
	}
	//ClearFields();
}
}

function Addvaluer_date()
{
	if(document.forms[0].cmdedit.disabled==true)
	{	
	var tab  = document.getElementById("tabid_CersaiDate");
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
					new_RowCell.childNodes[j].disabled=false;
				}
			}
			 
		}
	}
	else
	{
		alert("Cannot add more rows");
	}
	//ClearFields();
}
}

function Addvaluer()
{
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
			new_RowCell.align="left";
			new_RowCell.className="datagrid";
			var new_CellElement=new_RowCell.childNodes[0];
			if(i==0)
	        {
	        	new_RowCell.align="left";
	        }
			for(var j=0;j<new_RowCell.childNodes.length;j++)
			{
				if(new_RowCell.childNodes[j].type=="text")
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
	//ClearFields();
}
}

function Addvaluer1(){

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
			new_RowCell.align="center";
			new_RowCell.className="datagrid";
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
					new_RowCell.childNodes[j].disabled=false;
				}
			}
			 
		}
	}
	else
	{
		alert("Cannot add more rows");
	}
	//ClearFields();
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
					if(tabid=="idorgName" && rowsLength=="1")
					{
					    	 document.forms[0].org_code.value="";  
					    	 document.forms[0].hidarea.value="";
					    	 chkbox.checked=false; 
					    	 return;
					}
					else if(tabid=="tabid_valuerlist" && rowsLength=="1")
					{
						document.forms[0].txt_SurveyNo.value=""; 
						document.forms[0].txt_CERSAIrefnum.value="";
						document.forms[0].txt_CersaIDate1.value=""; 
						document.forms[0].txt_CersaId.value="";  
						document.forms[0].txt_CersaiDate.value="";
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

function callCalender_mul(name,rowindex) 
{
	if(rowindex=="0")
	{
		var tab  = document.getElementById("tabid_CersaiDate");
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
			name=name+"["+(rowindex)+"]";
			if (document.forms[0].cmdsave.disabled == false) 
			{

				showCal(appURL, name);
			}
		}
	}
	else
	{
		name=name+"["+(rowindex)+"]";
		if (document.forms[0].cmdsave.disabled == false) 
		{
			showCal(appURL, name);
		}
	}
}
function callCalender_mul_Ec(name,rowindex) 
{
	if(document.forms[0].sel_whtalrmortobnk.value == "N" && name=="txt_CersaiDate")
	{
		alert("Please make Whether property offered is already mortgaged to our Bank as YES before captuing CERSAI ASSET ID and CERSAI ASSET ID Creation Date");
		return;
	}
	if(rowindex=="0")
	{
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
			name=name+"["+(rowindex)+"]";
			if (document.forms[0].cmdsave.disabled == false) 
			{

				showCal(appURL, name);
			}
		}
	}
	else
	{
		name=name+"["+(rowindex)+"]";
		if (document.forms[0].cmdsave.disabled == false) 
		{
			showCal(appURL, name);
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


function Totalvalue()
{
	var a="";
	var b="";
	var c="";
	if(varServeyNo!="")
	{
		var temp= varServeyNo.split("@");
		var temp_ID=varCersaiID.split("@");
		var temp_Date=varCersaiDate.split("@");
		var temp_refno=varseccersirefno.split("@");
		var temp_Date1=varcersaidate1.split("@");
		var valuerlen=temp.length;
		for(var i=0;i<valuerlen;i++)
		{
			 Addvaluer1();
			 if(temp[i]==undefined){temp[i]="";}
			 if(temp_ID[i]==undefined){temp_ID[i]="";}
			 if(temp_Date[i]==undefined){temp_Date[i]="";}
			 if(valuerlen==1)
			 {
				 document.forms[0].txt_SurveyNo[i].value=temp[i];
				 document.forms[0].txt_CersaId[i].value =temp_ID[i];
				 document.forms[0].txt_CersaiDate[i].value = temp_Date[i];
				 document.forms[0].txt_CERSAIrefnum[i].value = temp_refno[i];
				 document.forms[0].txt_CersaIDate1[i].value = temp_Date1[i];
		    	 
			 }else
			 {
				 document.forms[0].txt_SurveyNo[i].value=temp[i];
				 document.forms[0].txt_CersaId[i].value =temp_ID[i];
				 document.forms[0].txt_CersaiDate[i].value = temp_Date[i];
				 document.forms[0].txt_CERSAIrefnum[i].value = temp_refno[i];
				 document.forms[0].txt_CersaIDate1[i].value = temp_Date1[i];
		    }
		 }
	}
	
	else
	{
		 Addvaluer1();
	}
deleteRow("tabid_valuerlist");
}

function cerDuplicateCheck(val,rowindex,name){
	var varIndex=0;
	var cersailIDCorp1=val.value;
	var SecurityId=document.forms[0].hidSecurityId.value;

	if(rowindex=="0")
	{
		var tab  = document.getElementById("tabid_valuerlist");
		var rowsLength = tab.rows.length;
		if(rowsLength==1)
		{
			name=name;
		}
		else
		{
			name=name+"["+(rowindex)+"]";
		}
	}
	else
	{
		name=name+"["+(rowindex)+"]";
	}

	var tab  = document.getElementById("tabid_valuerlist");
	var rowsLength = tab.rows.length;
	
	if(rowsLength==1)
	{
	 var varcersaiid=document.forms[0].txt_CersaId.value;
	if(varcersaiid.length==12)
	{
	document.all.ifrmcersaiIDcheckduplicate.src = appURL+"action/ifrmcersaiIDcheckduplicate.jsp?hidBeanGetMethod=getcersaiIDCheckDuplicate&hidBeanId=securitymaster&strcersailIDCorp="+cersailIDCorp1
	+ "&strrowindexname="+name+"&strSecurityId="+SecurityId;
	}
	}else if((rowsLength>=1)){
		for(var i=1;i<rowsLength;i++)
		{
			 var varcersaiid=document.forms[0].txt_CersaId[i].value;
			 if(varcersaiid.length==12){
				 document.all.ifrmcersaiIDcheckduplicate.src = appURL+"action/ifrmcersaiIDcheckduplicate.jsp?hidBeanGetMethod=getcersaiIDCheckDuplicate&hidBeanId=securitymaster&strcersailIDCorp="+cersailIDCorp1
					+ "&strrowindexname="+name+"&strSecurityId="+SecurityId;
			 }

		}

	}
	
}
function checkSplDotCQ(obj){
	val1=obj.value;
	var arrCodePdtType=['~','!','@','#','$','%',"'",'^','&','*','(',')','-','{','}','"','>','<','?','|','+','\\','.'];
	for(var i=0;i<arrCodePdtType.length;i++){
		if(val1.indexOf(arrCodePdtType[i]) >= 0){
			alert("Special characters not allowed on this field");
			return;
		}
	}
	}
function questionery()
{

	if(document.forms[0].sel_whtalrmortobnk.value == "N")
	{
		var tab  = document.getElementById("tabid_valuerlist");
		var rowsLength = tab.rows.length;
		
		if(rowsLength==1)
		{
		document.forms[0].txt_CersaId.value="";
		document.forms[0].txt_CersaiDate.value="";
		}else if(rowsLength>=1)
		{
			for(var i=0;i<rowsLength;i++)
			{
			document.forms[0].txt_CersaId[i].value="";
			document.forms[0].txt_CersaiDate[i].value="";
			}
		}
	}
	
	if(document.forms[0].sel_whtalrmortobnk.value == "Y")
	{
	document.all.sel_anychrgonprop.style.visibility = "hidden";
	document.all.sel_anychrgonprop.style.position = "absolute";
	}
	
	if(document.forms[0].sel_whtalrmortobnk.value == "Y")
	{

		document.all.mrtbnk.style.visibility = "visible";
		document.all.mrtbnk.style.position = "relative";

		document.all.mrtbnk1.style.visibility = "visible";
		document.all.mrtbnk1.style.position = "relative";

		document.all.sel_whtbnkchrgreflct.style.visibility = "visible";
		document.all.sel_whtbnkchrgreflct.style.position = "relative";

		document.all.mrtbnkY.style.visibility = "hidden";
		document.all.mrtbnkY.style.position = "absolute";

		document.all.sel_anychrgonprop.style.visibility = "hidden";
		document.all.sel_anychrgonprop.style.position = "absolute";

		

	}else 
	{
		
			document.all.mrtbnkY.style.visibility = "visible";
			document.all.mrtbnkY.style.position = "relative";

			document.all.sel_anychrgonprop.style.visibility = "visible";
			document.all.sel_anychrgonprop.style.position = "relative";
	
			document.all.mrtbnk.style.visibility = "hidden";
			document.all.mrtbnk.style.position = "absolute";

			document.all.mrtbnk1.style.visibility = "hidden";
			document.all.mrtbnk1.style.position = "absolute";

			document.all.sel_whtbnkchrgreflct.style.visibility = "hidden";
			document.all.sel_whtbnkchrgreflct.style.position = "absolute";

			document.all.mrtbnknR.style.visibility = "hidden";
			document.all.mrtbnknR.style.position = "absolute";

			document.all.mrtbnknR1.style.visibility = "hidden";
			document.all.mrtbnknR1.style.position = "absolute"

	}
	
	if(document.forms[0].sel_whtalrmortobnk.value == "Y" && document.forms[0].sel_whtbnkchrgreflct.value == "YO")
	{

		document.all.mrtbnkyo.style.visibility= "visible";
		document.all.mrtbnkyo.style.position = "relative";

		document.all.txt_remarkschrgonprop.style.visibility = "visible";
		document.all.txt_remarkschrgonprop.style.position = "relative";

		document.all.mrtbnkn.style.visibility = "hidden";
		document.all.mrtbnkn.style.position = "absolute";

		document.all.txt_remarkschrgnotref.style.visibility = "hidden";
		document.all.txt_remarkschrgnotref.style.position = "absolute"
		
	}else if(document.forms[0].sel_whtalrmortobnk.value == "Y" && document.forms[0].sel_whtbnkchrgreflct.value == "N"){
		
		document.all.mrtbnkn.style.visibility = "visible";
		document.all.mrtbnkn.style.position = "relative";

		document.all.txt_remarkschrgnotref.style.visibility = "visible";
		document.all.txt_remarkschrgnotref.style.position = "relative"

		document.all.mrtbnkyo.style.visibility= "hidden";
		document.all.mrtbnkyo.style.position = "absolute";

		document.all.txt_remarkschrgonprop.style.visibility = "hidden";
		document.all.txt_remarkschrgonprop.style.position = "absolute";
			
	}else{
		document.all.mrtbnkyo.style.visibility = "hidden";
		document.all.mrtbnkyo.style.position = "absolute";

		document.all.txt_remarkschrgonprop.style.visibility = "hidden";
		document.all.txt_remarkschrgonprop.style.position = "absolute"

		document.all.mrtbnkn.style.visibility = "hidden";
		document.all.mrtbnkn.style.position = "absolute";

		document.all.txt_remarkschrgnotref.style.visibility = "hidden";
		document.all.txt_remarkschrgnotref.style.position = "absolute"
	}

	if( document.forms[0].sel_whtalrmortobnk.value == "N" && document.forms[0].sel_anychrgonprop.value == "Y")
	{
		document.all.mrtbnknR.style.visibility = "visible";
		document.all.mrtbnknR.style.position = "relative";

		document.all.mrtbnknR1.style.visibility = "visible";
		document.all.mrtbnknR1.style.position = "relative"
			
	}else{

		document.all.mrtbnknR.style.visibility = "hidden";
		document.all.mrtbnknR.style.position = "absolute";

		document.all.mrtbnknR1.style.visibility = "hidden";
		document.all.mrtbnknR1.style.position = "absolute"
	}
}
function blockCersaiId()
{
	var tab  = document.getElementById("tabid_valuerlist");
	var rowsLength = tab.rows.length;
	if(rowsLength==1)
	{
		if(document.forms[0].sel_whtalrmortobnk.value == "N"){




			document.forms[0].txt_CersaId.value="";
			document.forms[0].txt_CersaiDate.value="";
			alert("Please make Whether property offered is already mortgaged to our Bank as YES before captuing CERSAI ID and CERSAI ID Creation Date");
			document.forms[0].txt_CersaId.readOnly=true;
		}else{
			document.forms[0].txt_CersaId.readOnly=false;
			document.forms[0].txt_CersaiDate.readOnly=true;
		}
	}else if(rowsLength>=1)
	{
		for(var i=0;i<rowsLength;i++)
		{
			if(document.forms[0].sel_whtalrmortobnk.value == "N"){
				document.forms[0].txt_CersaId[i].value="";
				document.forms[0].txt_CersaiDate[i].value="";
				alert("Please make Whether property offered is already mortgaged to our Bank as YES before captuing CERSAI ASSET ID and CERSAI ASSET ID Creation Date");
				document.forms[0].txt_CersaId[i].readOnly=true;
			}else{
				document.forms[0].txt_CersaId[i].readOnly=false;
				document.forms[0].txt_CersaiDate.readOnly=true;
			}
		}
	}
}
function callcropType()
{
	var varselcorpType=document.forms[0].sel_corpType.value;
	document.all.ifrmcorptype.src=appURL+"action/croptype.jsp?hidBeanId=securitymaster&hidBeanGetMethod=getcropType&corptype="+varselcorpType;
}

function callMinVAl()
{
	var tab  = document.getElementById("tabid_valuerlist");
	var rowsLength = tab.rows.length;
	
	if(rowsLength==1)
	{
		var varcersairefnum=document.forms[0].txt_CERSAIrefnum.value;
		 if(varcersairefnum.length!=15 && varcersairefnum.length>0){

			alert("Please Enter 15 - Digit Valid CERSAI Search Ref. No");
			document.forms[0].txt_CERSAIrefnum.value="";
			return;
		}

		 var varcersaiid=document.forms[0].txt_CersaId.value;
		 if(varcersaiid.length!=12 && varcersaiid.length>0){

			alert("Please Enter 12 - Digit Valid CERSAI ASSET ID");
			document.forms[0].txt_CersaId.value="";
			return;
		}
	}else if(rowsLength>=1)
	{
		for(var i=0;i<rowsLength;i++)
		{
			var varcersairefnum=document.forms[0].txt_CERSAIrefnum[i].value;
			 if(varcersairefnum.length!=15 && varcersairefnum.length>0){

				alert("Please Enter 15 - Digit Valid CERSAI Search Ref. No");
				document.forms[0].txt_CERSAIrefnum[i].value="";
				return;
			}

			 var varcersaiid=document.forms[0].txt_CersaId[i].value;
			 if(varcersaiid.length!=12 && varcersaiid.length>0){

				alert("Please Enter 12 - Digit Valid CERSAI ASSET Id");
				document.forms[0].txt_CersaId[i].value="";
				return;
			}
			
		}
	}	
}
function fsvamtchk()
{
	
	
	var fsv = document.forms[0].txt_ForcedSale.value;
	var value_as_per  = document.forms[0].txt_Valuation.value;
	
	if(varleasehold=="Y")
        {
		if(varsecurity_type=="15")
		{
			if(parseFloat(varnetval)!=parseFloat(value_as_per))
				{
				alert("Amount entered does not tally the  amount entered in Security Details  'Total Security Value/Market Value -"+varnetval)
				 document.forms[0].txt_ForcedSale.value="";
				  return;
				}
		}
		
		
	else if(varsecurity_type=="10"||varsecurity_type=="11"||varsecurity_type=="12"||varsecurity_type=="13"
		||varsecurity_type=="14"||varsecurity_type=="16"||varsecurity_type=="17")
	{
		if(parseFloat(varnetval)!=parseFloat(value_as_per))
		{
		alert("Amount entered does not tally the  amount entered in Security Details  'Total Security Value/Market Value -"+varnetval)
		document.forms[0].txt_Valuation.value="";
		 return;
		}
	}
        }
	else if(varleasehold=="N")
		{
		
		if(varsecurity_type=="15")
		{
			if(parseFloat(varnetval)!=parseFloat(fsv))
				{
				alert("Amount entered does not tally the  amount entered in Security Details  'Total Security Value/Market Value -"+varnetval)
				 document.forms[0].txt_ForcedSale.value="";
				  return;
				}
		}
		
		
	else if(varsecurity_type=="10"||varsecurity_type=="11"||varsecurity_type=="12"||varsecurity_type=="13"
		||varsecurity_type=="14"||varsecurity_type=="16"||varsecurity_type=="17")
	{
		if(parseFloat(varnetval)!=parseFloat(value_as_per))
		{
		alert("Amount entered does not tally the  amount entered in Security Details  'Total Security Value/Market Value -"+varnetval)
		document.forms[0].txt_Valuation.value="";
		 return;
		}
	}
		
		}
	
	
	if(parseFloat(fsv)>0 && parseFloat(value_as_per)>0)
		{
	if(parseFloat(fsv)>=parseFloat(value_as_per))
		{
		alert("Amount entered in Forced sale value should always be less than Value as per valuation ");
	     document.forms[0].txt_ForcedSale.value="";
	     return;
	     
		}
		}
}
</script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/securities/sec_propertydet.js"></script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="callOnLoad();callOnLoad1();">
<form name="frmpropdet" method="post" class="normal">
<%if(strPagefrom.equalsIgnoreCase("appl")){
	if(!(strSessionModuleType.equalsIgnoreCase("RET"))){
	if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){ %>
	 <table width="100%" border="0" cellspacing="0" cellpadding="0"
		class="outertable">
		<tr>
			<td><jsp:include page="../com/postsanctionlinks.jsp" flush="true">
				<jsp:param name="pageid" value="33" />
				<jsp:param name="subpageid" value="207" />
				<jsp:param name="cattype" value="<%=strCategoryType%>" />
				<jsp:param name="ssitype" value="<%=strSSIType%>" />
			</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
			</td>
		</tr>
	</table>
	<%}else{%>
 <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="33" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Security Master -&gt; Property Details</td>
	</tr>
</table>
<span style="display: none"><lapschoice:borrowertype /></span> <lapschoice:application />
<%} %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../set/appurlsectabs.jsp" flush="true">
			<jsp:param name="pageid" value="11" />
		</jsp:include>
		</td>
	</tr>
</table>
<%}else if(strSessionModuleType.equalsIgnoreCase("RET")){
if(!Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){%>
<jsp:include page="../share/Applurllinkper.jsp" flush="true"> 
        <jsp:param name="pageid" value="<%=pageid%>" />
        </jsp:include>
<table width="98%" border="0" cellspacing="1" cellpadding="3" class="outertable" align="center">
<tr>
	<td class="page_flow" colspan="2">Home -&gt; Retail -&gt; Application -&gt; Security Master -&gt; Property Details</td>
</tr>
</table>
<span style="display: none"><lapschoice:borrowertype /></span> <lapschoice:application />
<%} else{ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../set/postsanctionlinksper.jsp" flush="true">
			<jsp:param name="pageid" value="4" />
			<jsp:param name="subpageid" value="207" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<%} %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../set/appurlsectabs.jsp" flush="true">
			<jsp:param name="pageid" value="11" />
		</jsp:include>
		</td>
	</tr>
</table>
<%
}}else if(strPagefrom.equals("secmailbox")) { %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
<tr>
	<td valign="top">
	<jsp:include page="../set/appurlsectabs.jsp" flush="true">
		<jsp:param name="pageid" value="11" />
	</jsp:include>
	</td>
</tr>
</table>		
<%}else{%>
<table width="98%" border="0" cellspacing="1" cellpadding="3"	class="outertable" align="center">
	<tr class="dataheader">
		<td align="left" width="10%"><b>Customer Name</b></td>
		<td align="left" width="30%"><b><%=Helper.correctNull((String)hshValues.get("perapp_fname"))%>&nbsp;</b></td>
		<td align="left" width="10%"><b>Customer CBSID</b></td>
		<td align="left" width="20%"><b><%=Helper.correctNull((String)hshValues.get("perapp_cbsid"))%>&nbsp;</b></td>
		<td align="left" width="10%"><b>Customer LAPS ID</b></td>
		<td align="left" width="20%"><b><%=Helper.correctNull((String)hshValues.get("perapp_oldid"))%>&nbsp;</b></td>
	</tr>
</table> 
<table width="98%" border="0" cellspacing="1" cellpadding="3" class="outertable" align="center">
<tr>
	<td class="page_flow" colspan="2">Home -&gt; Securities -&gt; Property Details</td>
</tr>
</table>
<table width="98%" border="0" cellspacing="1" cellpadding="3" class="outertable" align="center">
<tr>
<td>
<table width="38%" border="0" cellspacing="0" cellpadding="0" class="outertable">
<tr>
<td class="sub_tab_inactive" align="center">
	<b><a href="JavaScript:gototab('securitymaster','getSecurities','customer_securities.jsp')">
	Security Details</a></b>
</td>
<td  class="sub_tab_active_new" align="center"><b>Property Details</b></td>
<td  class="sub_tab_inactive_new" align="center">
	<b><a href="JavaScript:gototab('securitymaster','getLegalOpinion','sec_property_legalopinion.jsp')">Legal Opinion</a></b>
</td>
</tr>
</table>
</td>
</tr>
</table>
<%}%>
<table width="98%" border="0" cellpadding="3" cellspacing="0" align="center" class="outertable" style="border: 2px solid #dccada;">
<tr>
	<td>
		<table width="90%" border="0" cellspacing="0" cellpadding="5" class="outertable" align="center">
		<tr>
			<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable" align="center">
				<tr>
					<td> Security ID :  <span style="color:#750b6a"> <%=Helper.correctNull((String)hshValues.get("strSecID"))%> </span>  </td>	
				</tr>
				<tr>
					<td>Property Type <span class="mantatory">*&nbsp;</span></td>
					<td>&nbsp;</td>
					<td colspan="2">
						<table> 	
							<tr> 
							<Td>
								<select name="sel_PropertyType"  onchange="addNewVal()" tabindex="10">
									<%String apptypecon="120"; %>
									<!--<lapschoice:StaticDataNewTag apptype='<%=apptypecon%>' />
									-->
									<option value="" selected="selected">--Select--</option>
					                <option value="L">Land</option>
					                <option value="F">Flat / Apartment</option>
					                <option value="H">House / Building</option>
								</select>
							</Td>
								<td id="sel123">
							
								<select name="sel_prop" onchange="addNewVal();">
									<option value="" selected="selected">--Select--</option>
									<option value="C">Completed</option>
									<option value="U">Under Construction</option>
								</select>
							</td>
						</tr>
						</table>
					</td>
					<td style="padding: 0" colspan="2" width=""><b>Location of Asset</b></td>
					<td>&nbsp;</td>
				</tr>
			<tr>
					<td>Plot No.<span class="mantatory">*&nbsp;</span></td>
					<td>&nbsp;</td>
					<td colspan="2">
						<input type="text" name="txt_PlotNo" size="30" value="<%=Helper.correctNull((String)hshValues.get("sec_plotno"))%>" maxlength="15" tabindex="3">
					</td>					
					<td width="20%">Address <span class="mantatory">*&nbsp;</span></td>
					<td colspan="2">
						<input type="text" name="txt_Address1" size="30" value="<%=Helper.correctNull((String)hshValues.get("sec_address"))%>" maxlength="25" tabindex="13">
					</td>
				</tr>
				<tr>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td  colspan="2">&nbsp;</td>
				<td>&nbsp;</td>
				<td colspan="2">
						<input type="text" name="txt_Address2" size="30" value="<%=Helper.correctNull((String)hshValues.get("sec_address1"))%>" maxlength="25" tabindex="14">
					</td>
				</tr>
				<tr>
					<td>Street No. <span class="mantatory">*&nbsp;</span> </td>
					<td>&nbsp;</td>
					<td colspan="2">
						<input type="text" name="txt_StreetNo" size="30" value="<%=Helper.correctNull((String)hshValues.get("sec_streetno"))%>" maxlength="15" tabindex="3">
					</td>
					<td>Ward No. <span class="mantatory">*&nbsp;</span></td>
					
					<td colspan="2">
						<input type="text" name="txt_WardNo" size="30" value="<%=Helper.correctNull((String)hshValues.get("sec_wardno"))%>" maxlength="15" tabindex="3">
					</td>
				</tr>			
				<tr>
					<td width="20%">Total Area <span class="mantatory">*&nbsp;</span></td>
					<td width="5%">&nbsp;</td>
					<td width="10%">
						<input type="text" name="txt_TotalArea" size="12" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("sec_totalarea"))))%>" maxlength="10" tabindex="4" onKeyPress="allowNumber(this);" onBlur="roundtxt(this);callNotCovered();">&nbsp;
						<select name="sel_Measurement"  tabindex="5" >
                    	<option value="">--Select--</option>
                    	<lapschoice:StaticDataNewTag apptype="135"/></select>
					</td>
					<td width="25%">&nbsp;</td>
					<td width="10%">City/Town <span class="mantatory">*&nbsp;</span></td>
					<td width="15%">
						<input type="text" name="txt_City" size="30" value="<%=Helper.correctNull((String)hshValues.get("custcity"))%>" maxlength="10">
					</td>
					<td width="15%">
						<input type="hidden" name="hidcity" value="<%=Helper.correctNull((String)hshValues.get("sec_city")) %>">
						<input type="hidden" name="hidstate" value="<%=Helper.correctNull((String) hshValues.get("sec_state"))%>">
						<a href="#"
							onClick="showCitySearch('txt_City','txt_State','hidcity','hidstate','txt_PinCode','hidzip')"
							style="cursor: hand"> <img
							src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
							border="0" tabindex="15"></a>
					</td>
				</tr>
				<tr>
					<td>Extent of Building <span id="ext_build" class="mantatory">*&nbsp;</span></td>
					<td>&nbsp;</td>
					<td width="10%">
						<input type="text" name="txt_ExtOfBuilding" size="12" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("sec_extentofbuilding"))))%>" maxlength="10" tabindex="6" onKeyPress="allowNumber(this);" onBlur="roundtxt(this);">&nbsp;
						<select name="sel_extofbuildMeas" tabindex="5">
						<option value="">--Select--</option>
						<lapschoice:StaticDataNewTag apptype="135"/>
						</select>
					</td>
					<td>&nbsp;</td>
					<td>District <span class="mantatory">*&nbsp;</span></td>
					<td>
						<input type="text" name="txt_District" size="30" value="<%=Helper.correctNull((String)hshValues.get("sec_districtDesc"))%>"
						readonly="readonly" maxlength="10" tabindex="16"></td>
						<td width="15%">
						<a href="#"
									onClick="showDistSearch('PROP');"
									style="cursor:hand" tabindex="22"><img
									src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
									border="0" ></a>
							<input type="hidden" name="hid_District" size="5" value="<%=Helper.correctNull((String)hshValues.get("sec_district")) %>">	
													
					</td>
					<td></td>
				</tr>
				<tr>
					<td>Extent of Ground floor covered under the building</td>
					<td>&nbsp;</td>
					<td width="10%">
						<input type="text" name="txt_ExtOfGround" size="12" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("sec_extentofground"))))%>" maxlength="10" tabindex="7" onKeyPress="allowNumber(this);" onBlur="roundtxt(this);callNotCovered();">&nbsp;
						<select name="sel_extofgroundMeas" tabindex="5">
							<option value="">--Select--</option>
							<lapschoice:StaticDataNewTag apptype="135"/>
						</select>
					</td>
					<td>&nbsp;</td>
					<td>State <span class="mantatory">*&nbsp;</span></td>
					<td>
						<input type="text" name="txt_State" size="30" value="<%=Helper.correctNull((String)hshValues.get("custstate"))%>" maxlength="10">
					</td>
					<td></td>
				</tr>
				<tr>
					<td>Extent of land not covered under building</td>
					<td>&nbsp;</td>
					<td width="10%">
						<input type="text" name="txt_ExtOfNotCovered" size="12" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("sec_extentofland"))))%>" maxlength="10" readOnly="readonly" onKeyPress="allowNumber(this);" onBlur="roundtxt(this);">&nbsp;
						<select name="sel_extnotcoveredMeas" tabindex="5" onChange="">
							<option value="">--Select--</option>
							<lapschoice:StaticDataNewTag apptype="135"/>
						</select>
					</td>
					<td>&nbsp;</td>
					<td>Pin Code <span class="mantatory">*&nbsp;</span></td>
					<td>
						<input type="text" name="txt_PinCode" size="15" value="<%=Helper.correctNull((String)hshValues.get("sec_zip"))%>" maxlength="6" tabindex="17" onKeyPress="allowInteger();">
					</td>
					<td></td>
				</tr>
				<tr>
					<td>Year Built</td>
					<td>&nbsp;</td>
					<td colspan="2">
						<input type="text" name="txt_YearBuilt" size="12" value="<%=Helper.correctNull((String)hshValues.get("sec_year"))%>" maxlength="4" tabindex="8" onblur="checkcurrentyear(this)" onKeyPress="allowInteger();">
					</td>
					<td style="padding: 0"><b>Boundary</b></td>
					<td colspan="2">&nbsp;</td>
				</tr>
				<tr>
					<td>Value as per valuation report <span  class="mantatory">*&nbsp;</span></td>
					<td align="right" >Rs.</td>
					<td colspan="2">
						<input type="text" style="text-align: right;" name="txt_Valuation" size="30" value="<%=Helper.checkDecimal(Helper.correctDouble((String)hshValues.get("sec_valuervalue")))%>" maxlength="15" tabindex="9" onKeyPress="allowNumber(this);" onBlur="roundtxt(this);fsvamtchk();">
					</td>
					<td>West</td>
					<td colspan="2">

						<textarea name="txt_BoundWest" cols="30" rows="3" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" tabindex="18"><%=Helper.replaceForJavaScriptString((String)hshValues.get("sec_west"))%></textarea>
					</td>
				</tr>
				<tr>
					<td >Forced sale value as per report <span class="mantatory" >*&nbsp;</span></td>
					<td align="right">Rs.</td>
					<td colspan="2">
						<input type="text"  style="text-align: right;"  name="txt_ForcedSale" size="30" value="<%=Helper.checkDecimal(Helper.correctDouble((String)hshValues.get("sec_salevalue")))%>" maxlength="15" tabindex="10" onKeyPress="allowNumber(this);" onBlur="roundtxt(this);fsvamtchk();">
					</td>
					<td>East</td>
					<td colspan="2">
						
						<textarea name="txt_BoundEast" cols="30" rows="3" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" tabindex="19"><%=Helper.replaceForJavaScriptString((String)hshValues.get("sec_east"))%></textarea>
					</td>
				</tr>
				<tr>
					<td>Branch where title deeds deposited <span class="mantatory">*&nbsp;</span></td>
					<td>&nbsp;</td>
					<td>
						<input type="text" name="txt_Branch" size="30" value="<%=Helper.correctNull((String)hshValues.get("org_name"))%>" maxlength="15">
					</td>
					<td>
						<INPUT type="hidden" name="select_loc" style="width: 200" value="<%=Helper.correctNull((String)hshValues.get("sec_branch"))%>">
						<b><a href="#"
							onClick="showOrganisationSearch('<%=ApplicationParams.getAppUrl()%>','select_loc','txt_Branch')"
							style="cursor: hand"><img
							src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
							border="0" tabindex="11"></a></b>
					</td>
					<td>North</td>
					<td colspan="2">
								
						<textarea name="txt_BoundNorth" cols="30" rows="3" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" tabindex="20"><%=Helper.replaceForJavaScriptString((String)hshValues.get("sec_north"))%></textarea>
					</td>
				</tr>
				<tr>
				 <td> Date of Title Deed deposited </td>
                  <td>&nbsp;</td>
                  <td colspan="2"><input type="text" name="txt_titledeeddepposit_date" size="11"
							value="<%=Helper.correctNull((String)hshValues.get("SEC_DEPOSIT_DATE"))%>"
							onBlur="checkDate(this);checkmaxdate(this,curdate);" maxlength="10" tabindex="15">
		    				<a alt="Select date from calender" href="#"
							onClick="callCalender('txt_titledeeddepposit_date')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" tabindex="29"></a> </td>
					<td>South</td>
					<td colspan="2">
					
					<textarea name="txt_BoundSouth" cols="30" rows="3" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" tabindex="21"><%=Helper.replaceForJavaScriptString((String)hshValues.get("sec_south"))%></textarea>
					</td>
				</tr>
				<tr>
					<td>Property acquired from</td>
					<td>&nbsp;</td>
					<td colspan="2">
						<select name="sel_Acquired" tabindex="12">
							<option value="">--Select--</option>
							<%apptypecon="122"; %>
							<lapschoice:StaticDataNewTag apptype='<%=apptypecon%>' />
						</select>
					</td>
				</tr>
				<tr>
					<td>Other Information</td>
					<td>&nbsp;</td>
					<td colspan="2">
						<textarea name="txt_OtherInf" cols="30" rows="3" onkeyup="textlimitcorp1(this,100);" onkeydown="textlimitcorp1(this,100);" tabindex="22"><%=Helper.replaceForJavaScriptString((String)hshValues.get("sec_otherinfo"))%></textarea>
					</td>
					<td>Whether actual boundaries tallies with sale deed</td>
					<td colspan="2">
					<select name="sel_boundaries" tabindex="15">
							<option value="">--Select--</option>
							<option value="1">Yes</option>
							<option value="2">No</option>
						</select>
					</td>
				</tr>
				
				<tr>
					<td>Sale Amount</td>
					<td>&nbsp;</td>
					<td colspan="2">
						<input type="text" name="txt_SaleAmount" onKeyPress="allowNumber(this);" size="30" value="<%=Helper.correctNull((String)hshValues.get("sec_saleamount"))%>">
					</td>
					<td id="BA">Whether Project approved by our Bank <span class="mantatory">*&nbsp;</span></td>
					<td id="BA1">	<select name="sel_whtprojapr" onchange="chkProjApproved('edit')" tabindex="10">
							<option value="">--Select--</option>
							<option value="Y">Yes</option>
							<option value="N">No</option>
							<option value="NA">Not Applicable</option>
						</select>
					</td>
				</tr>
				<TR id="BA2">
					<td>Name of the builder <span id="pro" class="mantatory">*&nbsp;</span></td>
					<td>&nbsp;</td>
					<td colspan="2">
						<input type="text" name="txt_BuilderName" onKeyPress="allowAlphabetsForName();" size="30" value="<%=Helper.correctNull((String)hshValues.get("sec_buildername"))%>" maxlength="25" >
						<input type="hidden" name="hid_buildercode" value="<%=Helper.correctNull((String)hshValues.get("SEC_BUILDERCODE"))%>"> 
						<span id="id_buildsearch" onClick="callsupnam()" style="cursor:hand"><img
								src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
								border="0" tabindex="54"></span>
					</td>
					<td>Name of the project <span id="pro1" class="mantatory">*&nbsp;</span></td>
					<td colspan="2">
						<input type="text" name="txt_ProjectName" onKeyPress="allowAlphabetsAndSpaceInt(this);" size="30" value="<%=Helper.correctNull((String)hshValues.get("SEC_PROJECTNAME"))%>" maxlength="25" >
					</td>
				</TR>
				<tr>
					<td>Reference no. of the approval approving the project</td>
					<td>&nbsp;</td>
					<td colspan="2">
						<input type="text" name="txt_RefnoApprov" size="30" value="<%=Helper.correctNull((String)hshValues.get("sec_refnoapprov"))%>" maxlength="15" >
					</td>
					<td>No. of floors</td>
					<td colspan="2">
						<input type="text" name="txt_NoFloor" size="30" onKeyPress="allowNumber(this);" value="<%=Helper.correctNull((String)hshValues.get("sec_nofloor"))%>" maxlength="5">
					</td>
				</tr>
				
				<tr id="showval">
					<td>Age of the building</td>
					<td>&nbsp;</td>
					<td colspan="4">
						<input type="text" name="txt_AgeOfBuilding" onKeyPress="allowNumber(this);" maxlength="3" size="4" value="<%=Helper.correctNull((String)hshValues.get("sec_ageofbuilding"))%>">
					</td>
					
				</tr>
			
				
				<tr>
					<td>Details of property acquisition  <span class="mantatory">*&nbsp;</span> </td>
					<td>&nbsp;</td>
					<td colspan="2">
					<table> 	
							<tr> 
							<Td>
						<select name="sel_propacquisition" onchange="addOtherList()" tabindex="10">
							<option value="">--Select--</option>
							<option value="P"> Purchase</option>
							<option value="I">Inheritance/Will</option>
							<option value="G">Gift</option>
							<option value="T">Others</option>
						</select>
						</Td>
						
						<td id="txtarea124">
						<textarea name="txt_propothers" rows="3" cols="30"> <%=Helper.replaceForJavaScriptString((String)hshValues.get("SEC_PROPACQUISITION_OTHERS"))%></textarea>
					</td>
					
					</tr>
					</table>
					</td>				
					<td id="showagr">Crop Type </td>	
					<td id="showagr1" colspan="2"><select name="sel_corpType" tabindex="10" onchange="callcropType()">
					<option value="">--Select--</option>
							<lapschoice:StaticDataNewTag apptype="267"/>
						</select></td>			
					</tr>
					<!--<tr>
						<td>CERSAI Search Ref. No<span class="mantatory">*&nbsp;</span> </td>
						<td>&nbsp;</td>
						<td><input type="text" name="txt_CERSAIrefno" onKeyPress="allowNumber(this);" maxlength="15" size="30" value="<%=Helper.correctNull((String)hshValues.get("SEC_CERSAIREFNO"))%>"></td>
						<td>&nbsp;</td>
						<td> CERSAI search Date <span class="mantatory">*&nbsp;</span>  </td>
							
							 <td colspan="2"><input type="text" name="txt_SearchPerformed_date" size="11"
							value="<%=Helper.correctNull((String)hshValues.get("SEC_SEARCHPERFORM_DATE"))%>"
							onBlur="checkDate(this);checkmaxdate(this,curdate);" maxlength="10" tabindex="15">
		    				<a href="#" onClick="callCalender('txt_SearchPerformed_date')" title="Click to view calender">
								<img src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif" border="0" tabindex="2"></a></td>
							
							
					</tr>-->
					<tr>
						<td> Whether property offered is already mortgaged to our Bank <span class="mantatory">*&nbsp;</span> </td>
						<td>&nbsp;</td>
						<td colspan="2"><select name="sel_whtalrmortobnk" onchange="questionery()" tabindex="10">
							<option value="">--Select--</option>
							<option value="Y">Yes</option>
							<option value="N">No</option>
						</select></td>
						
						<td id="mrtbnk1"> Whether our bank charge reflected <span class="mantatory">*&nbsp;</span> </td>
						<td><select name="sel_whtbnkchrgreflct" onchange="questionery()" tabindex="10">
							<option value="">--Select--</option>
							<option value="Y">Yes</option>
							<option value="YO">Yes, but along with other bank</option>
							<option value="N">No</option>
						</select></td>
					</tr>
					<tr id="mrtbnk">
						<td id="mrtbnkyo"> Reason for other bank charge being reflected<span class="mantatory">*&nbsp;</span> </td>
							<td>&nbsp;</td>
							<td colspan="2" >
							<textarea name="txt_remarkschrgonprop" cols="30" rows="3" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" tabindex="21"><%=Helper.replaceForJavaScriptString((String)hshValues.get("SEC_OTHERBNK_REMARK"))%></textarea>
							</td>
							<td></td>
							<td id="mrtbnkn"> Reason for our bank charge not reflecting<span class="mantatory">*&nbsp;</span> </td>
							<td><textarea name="txt_remarkschrgnotref" cols="30" rows="3" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" tabindex="21"><%=Helper.replaceForJavaScriptString((String)hshValues.get("SEC_REMARK_NOT_REFLECT"))%></textarea>
							</td>
					</tr>
					<tr>
						<td id="mrtbnkY"> Any charge on the property observed <span class="mantatory">*&nbsp;</span> </td>
						<td>&nbsp;</td>
						<td colspan="2"><select name="sel_anychrgonprop" tabindex="10" onchange="questionery()">
							<option value="">--Select--</option>
							<option value="Y">Yes</option>
							<option value="N">No</option>
						</select></td>
						
						<td id="mrtbnknR"> Reason/Remarks For Any charge on the property observed <span class="mantatory">*&nbsp;</span> </td>
					<td id="mrtbnknR1"><textarea name="txt_remarks" cols="30" rows="3" onkeyup="textlimitcorp1(this,150);" onkeydown="textlimitcorp1(this,150);" onKeyPress="checkEnter(this);checkSplDotCQ(this);"><%=Helper.replaceForJavaScriptString((String)hshValues.get("sec_remarks"))%></textarea>
					</td>
					</tr>
					<tr>
				<td colspan="6" valign="top" width="70%" id="ValuerDetails2">
				<table width="98%" border="0"  align="center" class="outertable"  style="border: 1px solid #bbb;">
				<tr class="dataheader" align="center" >
						<td width="5%"><span style=""><a onClick="Addvaluer1();"><img
							src="<%=ApplicationParams.getAppUrl()%>img/add.png"
							border="0" tabindex="38"></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					 		<a onClick="deleteRow1('tabid_valuerlist','0');"><img
							src="<%=ApplicationParams.getAppUrl()%>img/cancel.png"
							border="0" tabindex="38"></a> </span> </td>
						<td width="20%"> Survey No</td>
						<td width="20%"> CERSAI Search Ref. No</td>
						<td width="20%"> CERSAI search Date </td>
						<td width="20%"> CERSAI ASSET ID</td>
						<td width="20%"> CERSAI ASSET ID Creation Date</td>

				</tr>
				<tr class="datagrid">
				<td colspan="6"> 
				<table width="100%" border="1"  align="center" class="outertable"  style="border: 1px solid #bbb;" id="tabid_valuerlist">
				<tr align="center" id="0">	
					<td width="5%"><input type="checkbox" name="chk1" style="border: none;"></td>	
					<td width="20%"><input type="text" name="txt_SurveyNo" size="25" value="" maxlength="30" onkeypress="allowAlphabetsAndSpaceInt(this)" tabindex="2"></td>
					<td width="20%"><input type="text" name="txt_CERSAIrefnum" size="25" value=""  maxlength="15" onkeypress="allowInteger();" onChange="callMinVAl()" tabindex="2"></td>
					<td width="20%"><input type="text" name="txt_CersaIDate1" size="20"
							value="" onBlur="checkDate(this);checkmaxdate(this,curdate);" maxlength="10" tabindex="15">
		   					 <a alt="Select date from calender" 
							onClick="callCalender_mul_Ec('txt_CersaIDate1',this.parentNode.parentNode.id)"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" tabindex="29"></a> </td>
					<td width="20%"><input type="text" name="txt_CersaId" size="23" value="" maxlength="12" onkeypress="allowInteger();blockCersaiId()" tabindex="13" onChange="callMinVAl()" onblur="cerDuplicateCheck(this,this.parentNode.parentNode.id,'txt_CersaId');"></td>
					<td width="20%"><input type="text" name="txt_CersaiDate" size="20"
							value="" onBlur="checkDate(this);checkmaxdate(this,curdate);checkmindate(this,cersaimindate);" maxlength="10" tabindex="15">
		   					 <a alt="Select date from calender" 
							onClick="callCalender_mul_Ec('txt_CersaiDate',this.parentNode.parentNode.id)"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" tabindex="29"></a> </td>
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
<br>
<%if(strPagefrom.equalsIgnoreCase("appl")||strPagefrom.equalsIgnoreCase("secmailbox")){%>
 <table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable" align="center">
  <tr><td align="center"> 
    <input type="button" name="cmdclose" value="Close" onClick="dobtnClose()"  class="buttonClose">
    <input type="hidden" name="cmdedit" disabled> 
    <input type="hidden" name="cmdsave" disabled> 
    <input type="hidden" name="cmdcancel" disabled> 
    <input type="hidden" name="cmddelete" disabled> 
    <input type="hidden" name="cmdclose" disabled> 
  </td></tr>
 </table>
<%}else{ %>
<lapschoice:combuttonnew
	btnnames='Edit_Save_Cancel_Delete_Audit Trail'
	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<%} %>
<br>
<input type="hidden" name="hidzip" value="<%=Helper.correctNull((String) hshValues.get("state_validatepin"))%>" />
<lapschoice:hiddentag pageid='<%=PageId%>' />
<input type="hidden" name="txtperapp_appid" value="<%=Helper.correctNull((String) hshValues.get("applicantId"))%>">
<input type="hidden" name="hidDemoId" value="<%=Helper.correctNull((String) request.getParameter("hidDemoId"))%>">
<input type="hidden" name="hidSecurityId" value="<%=Helper.correctNull((String)request.getParameter("hidSecurityId"))%>">
<input type="hidden" name="hidsectype" value="<%=sectype%>">
<input type="hidden" name="hidsecid" value="<%=strsecID%>">

<input type="hidden" name="hidmodifiedvalue">  
<input type="hidden" name="hidmodifiedField">  

<input type="hidden" name="old_txt_SurveyNo" value="<%=Helper.correctNull((String) hshValues.get("sec_surveyno"))%>" />
<input type="hidden" name="old_txt_Address1" value="<%=Helper.correctNull((String) hshValues.get("sec_address"))%>" />
<input type="hidden" name="old_txt_PlotNo" value="<%=Helper.correctNull((String) hshValues.get("sec_plotno"))%>" />
<input type="hidden" name="old_txt_Address2" value="<%=Helper.correctNull((String) hshValues.get("sec_address1"))%>" />
<input type="hidden" name="old_txt_TotalArea" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String) hshValues.get("sec_totalarea"))))%>" />
<input type="hidden" name="old_txt_City" value="<%=Helper.correctNull((String) hshValues.get("custcity"))%>" />
<input type="hidden" name="old_txt_ExtOfBuilding" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String) hshValues.get("sec_extentofbuilding"))))%>" />
<input type="hidden" name="old_txt_District" value="<%=Helper.correctNull((String) hshValues.get("sec_districtDesc"))%>" />
<input type="hidden" name="old_txt_ExtOfGround" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String) hshValues.get("sec_extentofground"))))%>" />
<input type="hidden" name="old_txt_State" value="<%=Helper.correctNull((String) hshValues.get("custstate"))%>" />
<input type="hidden" name="old_txt_ExtOfNotCovered" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String) hshValues.get("sec_extentofland"))))%>" />
<input type="hidden" name="old_txt_PinCode" value="<%=Helper.correctNull((String) hshValues.get("sec_zip"))%>" />
<input type="hidden" name="old_txt_YearBuilt" value="<%=Helper.correctNull((String) hshValues.get("sec_year"))%>" />
<input type="hidden" name="old_txt_Valuation" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String) hshValues.get("sec_valuervalue"))))%>" />
<input type="hidden" name="old_txt_BoundWest" value="<%=Helper.correctNull((String) hshValues.get("sec_west"))%>" />
<input type="hidden" name="old_txt_ForcedSale" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String) hshValues.get("sec_salevalue"))))%>" />
<input type="hidden" name="old_txt_BoundEast" value="<%=Helper.correctNull((String) hshValues.get("sec_east"))%>" />
<input type="hidden" name="old_txt_Branch" value="<%=Helper.correctNull((String) hshValues.get("org_name"))%>" />
<input type="hidden" name="old_txt_BoundNorth" value="<%=Helper.correctNull((String) hshValues.get("sec_north"))%>" />
<input type="hidden" name="old_txt_BoundSouth" value="<%=Helper.correctNull((String) hshValues.get("sec_south"))%>" />
<input type="hidden" name="old_txt_OtherInf" value="<%=Helper.correctNull((String) hshValues.get("sec_otherinfo"))%>" />

<input type="hidden" name="old_txt_SaleAmount" value="<%=Helper.correctNull((String) hshValues.get("sec_saleamount"))%>" />
<input type="hidden" name="old_txt_BuilderName" value="<%=Helper.correctNull((String) hshValues.get("sec_buildername"))%>" />
<input type="hidden" name="old_txt_RefnoApprov" value="<%=Helper.correctNull((String) hshValues.get("sec_refnoapprov"))%>" />
<input type="hidden" name="old_txt_NoFloor" value="<%=Helper.correctNull((String) hshValues.get("sec_nofloor"))%>" />
<input type="hidden" name="old_txt_AgeOfBuilding" value="<%=Helper.correctNull((String) hshValues.get("sec_ageofbuilding"))%>" />



<input type="hidden" name="old_sel_AcquiredText" />
<input type="hidden" name="old_sel_boundariesText" />
<input type="hidden" name="old_sel_PropertyTypeText" />
<input type="hidden" name="old_sel_MeasurementText" />
<input type="hidden" name="old_sel_extnotcoveredMeasText" />
<input type="hidden" name="old_sel_extofgroundMeasText" />
<input type="hidden" name="old_sel_extofbuildMeasText" />
<input type="hidden" name="old_txt_StreetNo" value="<%=Helper.correctNull((String)hshValues.get("sec_streetno"))%>"/>
<input type="hidden" name="old_txt_WardNo" value="<%=Helper.correctNull((String)hshValues.get("sec_wardno"))%>"/>
<input type="hidden" name="old_sel_propacquisitionText" />
<input type="hidden" name="old_txt_propothers" />

<input type="hidden" name="sel_AcquiredText" />
<input type="hidden" name="sel_boundariesText" />
<input type="hidden" name="sel_PropertyTypeText" />
<input type="hidden" name="sel_MeasurementText" />
<input type="hidden" name="sel_extnotcoveredMeasText" />
<input type="hidden" name="sel_extofgroundMeasText" />
<input type="hidden" name="sel_extofbuildMeasText" />
<input type="hidden" name="sel_propacquisitionText" />
<input type="hidden" name="sel_propText" />
<input type="hidden" name="old_sel_propText" />
<input type="hidden" name="old_txt_remarks" value="<%=Helper.correctNull((String)hshValues.get("sec_remarks"))%>"/>
<input type="hidden" name="sel_whtprojaprText" />
<input type="hidden" name="old_sel_whtprojaprText" />
<input type="hidden" name="hid_SurveyNo" />
<input type="hidden" name="hid_VerificationFlag" value="<%=Helper.correctNull((String) hshValues.get("hid_VerificationFlag"))%>" />
<input type="hidden" name="old_hid_SurveyNo" value="<%=Helper.correctNull((String) hshValues.get("sec_surveyno"))%>"/>
<input type="hidden" name="hid_CersaiID" />
<input type="hidden" name="old_hid_CersaiID" value="<%=Helper.correctNull((String) hshValues.get("SEC_CERSAI_ID"))%>"/>
<input type="hidden" name="hid_CersaiDate" />
<input type="hidden" name="old_hid_CersaiDate" value="<%=Helper.correctNull((String) hshValues.get("SEC_CERSAI_DATE"))%>"/>
<input type="hidden" name="hid_Ser_no" />
<input type="hidden" name="old_txt_ProjectName" value="<%=Helper.correctNull((String) hshValues.get("SEC_PROJECTNAME"))%>"/>

<input type="hidden" name="hid_CERSAIrefnum" />
<input type="hidden" name="old_hid_CERSAIrefnum" value="<%=Helper.correctNull((String) hshValues.get("SEC_CERSAIREFNO"))%>"/>

<input type="hidden" name="hid_CersaiDate1" />
<input type="hidden" name="old_hid_CersaiDate1" value="<%=Helper.correctNull((String) hshValues.get("SEC_SEARCHPERFORM_DATE"))%>"/>

<input type="hidden" name="sel_whtalrmortobnktext" />
<input type="hidden" name="sel_whtbnkchrgreflcttext" />
<input type="hidden" name="sel_anychrgonproptext" />
<input type="hidden" name="old_sel_whtalrmortobnktext" />
<input type="hidden" name="old_sel_whtbnkchrgreflcttext" />
<input type="hidden" name="old_txt_remarkschrgonprop" />
<input type="hidden" name="old_txt_remarkschrgnotref" />
<input type="hidden" name="old_sel_anychrgonproptext" />
<input type="hidden" name="old_sel_corpTypetext" />
<input type="hidden" name="sel_corpTypetext" />

<input type="hidden" name="hid_sel_whtalrmortobnk" />
<input type="hidden" name="hid_sel_whtbnkchrgreflct" />
<input type="hidden" name="hid_sel_anychrgonprop" />

<input type="hidden" name="hid_croptypefromstat" />

<iframe height="0" width="0" id="ifrmcersaiIDcheckduplicate" frameborder="0"	style="border: 0"></iframe>
<iframe height="0" width="0" id="ifrmcorptype" frameborder="0"	style="border: 0"></iframe>

</form>
</body>
</html>