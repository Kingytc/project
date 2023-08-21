<%@ include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
	if (objValues instanceof java.util.HashMap) {
		hshValues = (java.util.HashMap) objValues;
	}

ArrayList arrRow=new ArrayList();
ArrayList arrCol=new ArrayList();
arrRow=(ArrayList)hshValues.get("arrRow");
%>
<html>
<head>
<title>BSA/DSA Master</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<STYLE>
DIV.cellContainer {
	width: 100%;
	height: 100%;
	overflow: auto;
}
</STYLE>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js">
</script>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currdate = "<%=Helper.getCurrentDateTime()%>";
var action ="<%=Helper.correctNull((String) hshValues
							.get("VALUERS_ACTIVE"))%>";
var blacklist ="<%=Helper.correctNull((String) hshValues
							.get("valuers_blacklist"))%>"
var vartrapedit="<%=Helper.correctNull((String) hshValues.get("trapedit"))%>";
var strAppVar="<%=Helper.correctNull((String) hshValues.get("strAppVal"))%>";

function callAppVal()
{
	if(document.forms[0].rad[0].checked==true)
	{
		strAppVar="BSA";
		enableButtons(false,true,true,true,false);
		BSAfields();
		ClearFields();
		whetheremp();
		document.forms[0].sel_type.disabled=true;
		document.forms[0].sel_type.value="";
	}
	else if(document.forms[0].rad[1].checked==true)
	{
		strAppVar="DSA";
		enableButtons(false,true,true,true,false);
		DSAfields();
		ClearFields();
		whetheremp();
		document.forms[0].sel_type.disabled=true;
		document.forms[0].sel_type.value="";
	}
	else if(document.forms[0].rad[2].checked==true)
	{
		strAppVar="OTH";
		enableButtons(false,true,true,true,false);
		DSAfields();
		ClearFields();
		whetheremp();
		document.forms[0].sel_type.disabled=false;
	}
	LoadValues();

	
}
function doEdit() 
{
   	document.forms[0].hid_action.value="update";
	enableButtons(true, true, false, false, true);
	disablefields(false);
	if(document.forms[0].txtfield1.value=="TEXT FIELD")
	{
		document.forms[0].txtfieldval1.disabled=true;
	}
	else
	{
		document.forms[0].txtfield1.disabled=true;
	}
	if(document.forms[0].txtfield2.value=="TEXT FIELD")
	{
		document.forms[0].txtfieldval2.disabled=true;
	}
	else
	{
		document.forms[0].txtfield2.disabled=true;
	}
	if(document.forms[0].txtfield3.value=="TEXT FIELD")
	{
		document.forms[0].txtfieldval3.disabled=true;
	}
	else
	{
		document.forms[0].txtfield3.disabled=true;
	}
	if(document.forms[0].txtfield4.value=="TEXT FIELD")
	{
		document.forms[0].txtfieldval4.disabled=true;
	}
	else
	{
		document.forms[0].txtfield4.disabled=true;
	}
	if(document.forms[0].txtfield5.value=="TEXT FIELD")
	{
		document.forms[0].txtfieldval5.disabled=true;
	}
	else
	{
		document.forms[0].txtfield5.disabled=true;
	}
	if(document.forms[0].masterfield1.value=="0")
	{
		document.forms[0].selmasterfield1.disabled=true;
	}
	else
	{
		document.forms[0].masterfield1.disabled=true;
	}
	if(document.forms[0].masterfield2.value=="0")
	{
		document.forms[0].selmasterfield2.disabled=true;
	}
	else
	{
		document.forms[0].masterfield2.disabled=true;
	}
	if(document.forms[0].masterfield3.value=="0")
	{
		document.forms[0].selmasterfield3.disabled=true;
	}
	else
	{
		document.forms[0].masterfield3.disabled=true;
	}
	if(document.forms[0].masterfield4.value=="0")
	{
		document.forms[0].selmasterfield4.disabled=true;
	}
	else
	{
		document.forms[0].masterfield4.disabled=true;
	}
	if(document.forms[0].masterfield5.value=="0")
	{
		document.forms[0].selmasterfield5.disabled=true;
	}
	else
	{
		document.forms[0].masterfield5.disabled=true;
	}
	document.forms[0].sel_type.disabled=true;
}
function BSAfields()
{
	document.all.idDSA2.style.display="none";		
	document.all.idDSA1.style.display="none";	
	document.all.idOTH1.style.display="none";	
	document.all.idOTH2.style.display="none";	

	document.all.idBSA3.style.display="table-row";
	document.all.idBSA2.style.display="table-row";		
	document.all.idBSA1.style.display="table-row";
	document.all.BSA1.style.display="table-cell";
	document.all.BSA2.style.display="table-cell";
}
function DSAfields()
{
	document.all.idBSA3.style.display="none";
	document.all.idBSA2.style.display="none";
	document.all.idBSA1.style.display="none";
	document.all.BSA1.style.display="none";
	document.all.BSA2.style.display="none";

	if(document.forms[0].rad[1].checked==true)
	{	
		document.all.idDSA2.style.display="table-row";		
		document.all.idDSA1.style.display="table-row";
		document.all.idOTH1.style.display="none";	
		document.all.idOTH2.style.display="none";	
	}
	else if(document.forms[0].rad[2].checked==true)
	{
		document.all.idDSA2.style.display="table-row";		
		document.all.idDSA1.style.display="table-row";
		document.all.idOTH1.style.display="table-row";	
		document.all.idOTH2.style.display="table-row";
		document.all.idDSA5.style.display="none";
		document.all.idDSA6.style.display="none";
	}			
}

function addRow()
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		var table=document.getElementById("regnumtable");
		var rowCount=table.rows.length; 
		var row=table.insertRow(rowCount++);
	
		var cell1=row.insertCell(0);
		
		cell1.innerHTML="<td><input type='text' size='35' name='txt_regno'></td>";
	}
}


function deleteRow(tableid)
{
	if(document.forms[0].cmdsave.disabled==false)
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

function deleteRowdisabled(tableid)
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

function addRowdsaserv()
{
	if(document.forms[0].cmdsave.disabled==false)
	{
	var table=document.getElementById("dsasertable");
	var rowCount=table.rows.length; 
	var row=table.insertRow(rowCount++);

	var cell1=row.insertCell(0);
	cell1.innerHTML="<td><input type='text' size='30' name='txt_dsaservBank' readOnly='readonly'><input type='hidden' name='hid_dsaservBankcode'> <a href='#' id='"+rowCount+"' onClick='callBankmastermultiple(this.id)' style='cursor: hand'><img src='<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif' border='0'></a></td>";
	}
}


function addRowdbankname()
{
	if(document.forms[0].cmdsave.disabled==false)
	{
	var table=document.getElementById("empbanknametable");
	var rowCount=table.rows.length; 
	var row=table.insertRow(rowCount++);

	var cell1=row.insertCell(0);
	var cell2=row.insertCell(1);
	
	cell1.innerHTML="<td><input type='text' size='30' name='txt_empnameBank' readOnly='readonly'><input type='hidden' name='hid_empnameBankcode'> <a href='#' id='"+rowCount+"' onClick='callBankmastermultiple2(this.id)' style='cursor: hand'><img src='<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif' border='0'></a></td>";

	cell2.innerHTML="<td><input type='text' size='11' name='txt_empanelsince'  id='"+rowCount+"' onBlur='checkdaterow(this.id);checkmaxdate(this,currdate)' ><a alt='Select date from calender' href='#' id='"+rowCount+"' onClick='callCalender1(this.id)'><img src='<%=ApplicationParams.getAppUrl()%>img/calen.gif' border=0 alt='Select date from calender' ></a></td>";

	}
}

function getrowlenth2()
{
	var table=document.getElementById("empbanknametable");
	var rowCount=table.rows.length; 
	return rowCount;
}
function getrowlenth()
{
	var table=document.getElementById("dsasertable");
	var rowCount=table.rows.length; 
	return rowCount;
}

function enableButtons(bool1, bool2, bool3, bool4, bool5)
{
	document.forms[0].cmdnew.disabled=bool1;
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
}


function callonLoad()
{		
	BSAfields();
	nonindvFields();
	disablefields(true);
}


function doSave()
{
	if(document.forms[0].txt_name.value == "")
	{
		ShowAlert('121','Agent Name ');
		document.forms[0].txt_name.focus();
		return;
	} 
	if(document.forms[0].txt_address1.value == "")
	{
		ShowAlert('121','Address ');
		document.forms[0].txt_address1.focus();
		return;
	}
	if(document.forms[0].txt_city.value == "")
	{
		ShowAlert('121','City ');
		document.forms[0].txt_city.focus();
		return;
	}
	if(document.forms[0].txt_state.value == "")
	{
		ShowAlert('121','State ');
		document.forms[0].txt_state.focus();
		return;
	}
	if(document.forms[0].txt_country.value == "")
	{
		ShowAlert('121','Country ');
		document.forms[0].txt_country.focus();
		return;
	}
	if(document.forms[0].txt_zip.value == "")
	{
		ShowAlert('121','Pin code ');
		document.forms[0].txt_zip.focus();
		return;
	}
	if(document.forms[0].sel_applt_constitutionnew.value == "0")
	{
		ShowAlert('121','Constitution');
		document.forms[0].sel_applt_constitutionnew.focus();
		return;
	}
	if(document.forms[0].txt_mobile.value == "")
	{
		ShowAlert('121','Mobile Number');
		document.forms[0].txt_mobile.focus();
		return;
	}
	if(document.forms[0].txt_email.value == "")
	{
		ShowAlert('121','Email ID');
		document.forms[0].txt_email.focus();
		return;
	}
	if(document.forms[0].txt_pannum.value == "")
	{
		ShowAlert('121','PAN number / GST');
		document.forms[0].txt_pannum.focus();
		return;
	}
	if(document.forms[0].sel_banktype.value == "")
	{
		ShowAlert('111','Bank Type');
		document.forms[0].sel_banktype.focus();
		return;
	}
	if(document.forms[0].txt_bankname.value == "")
	{
		ShowAlert('111','Name of the Bank ');
		document.forms[0].txt_bankname.focus();
		return;
	}
	if(document.forms[0].txt_branch.value == "")
	{
		ShowAlert('121','Bank Branch');
		document.forms[0].txt_branch.focus();
		return;
	}
	if(document.forms[0].txt_ifsccode.value == "")
	{
		ShowAlert('121','IFSC');
		document.forms[0].txt_ifsccode.focus();
		return;
	}
	if(document.forms[0].txt_accno.value == "")
	{
		ShowAlert('121','Bank Account number ');
		document.forms[0].txt_accno.focus();
		return;
	}
	if(document.forms[0].txt_empaneldet.value == "")
	{
		ShowAlert('121','Empanelment details ');
		document.forms[0].txt_empaneldet.focus();
		return;
	}
	if(document.forms[0].txt_empaneledon.value == "")
	{
		ShowAlert('111','Empanelment Date ');
		document.forms[0].txt_empaneledon.focus();
		return;
	}
	if(document.forms[0].txt_expirydate.value == "")
	{
		ShowAlert('111','Expiry Date ');
		document.forms[0].txt_expirydate.focus();
		return;
	}
	if(document.forms[0].sel_action.value == "")
	{
		ShowAlert('121','Action');
		document.forms[0].sel_action.focus();
		return;
	}
	if(document.forms[0].sel_region.value == "")
	{
		ShowAlert('111','Region Name');
		document.forms[0].sel_region.focus();
		return;
	}
	if(strAppVar=="BSA")
	{
		if(document.forms[0].sel_whtempanalled.value == "")
		{
			ShowAlert('111','Whether empanelled with other Bank');
			document.forms[0].sel_whtempanalled.focus();
			return;
		}
	}
	else if(strAppVar=="OTH")
	{
		if(document.forms[0].sel_type.value == "")
		{
			ShowAlert('121','Type');
			document.forms[0].sel_type.focus();
			return;
		}
		else if(document.forms[0].txt_dealershipregno.value == "")
		{
			ShowAlert('111','Authorised Dealership Registration Number');
			document.forms[0].txt_dealershipregno.focus();
			return;
		}
		else if(document.forms[0].txt_regdatefrom.value == "")
		{
			ShowAlert('121','Registration Valid from');
			document.forms[0].txt_regdatefrom.focus();
			return;
		}
		else if(document.forms[0].txt_regdateto.value == "")
		{
			ShowAlert('121','Registration Valid upto');
			document.forms[0].txt_regdateto.focus();
			return;
		}
	}

	for(var i=1;i<=5;i++)
	{
		if(eval("document.forms[0].txtfield"+i).value=="")
		{
			eval("document.forms[0].masterfield"+i).value="TEXT FIELD";
		}
		if(eval("document.forms[0].masterfield"+i).value=="")
		{
			eval("document.forms[0].masterfield"+i).value="0";
		}
	}
	disablefields(false);
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].sel_type.disabled=false;
	document.forms[0].hidBeanId.value="staticdata";
	document.forms[0].hidAppVal.value=strAppVar;
	document.forms[0].hidBeanMethod.value="updateBSADSAmasterData";
	document.forms[0].hidBeanGetMethod.value="getBSADSAList";
	document.forms[0].hidSourceUrl.value="/action/BSADSAmaster.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function doNew() 
{
	if(strAppVar=="")
	{
		ShowAlert(111,'BSA/DSA or Others');
		return;
	}
	else if(strAppVar=="OTH")
	{
		if(document.forms[0].sel_type.value=="")
		{
			ShowAlert(111,'Type');
			document.forms[0].sel_type.focus();
			return;
		}
	}
	ClearFields();
	document.forms[0].hidsno.vakue="";
   	enableButtons(true, true, false, false, true);
   	disablefields(false); 
	document.forms[0].hid_action.value="insert";
	if(document.forms[0].txtfield1.value=="TEXT FIELD")
	{
		document.forms[0].txtfieldval1.disabled=true;
	}
	else
	{
		document.forms[0].txtfield1.disabled=true;
	}
	if(document.forms[0].txtfield2.value=="TEXT FIELD")
	{
		document.forms[0].txtfieldval2.disabled=true;
	}
	else
	{
		document.forms[0].txtfield2.disabled=true;
	}
	if(document.forms[0].txtfield3.value=="TEXT FIELD")
	{
		document.forms[0].txtfieldval3.disabled=true;
	}
	else
	{
		document.forms[0].txtfield3.disabled=true;
	}
	if(document.forms[0].txtfield4.value=="TEXT FIELD")
	{
		document.forms[0].txtfieldval4.disabled=true;
	}
	else
	{
		document.forms[0].txtfield4.disabled=true;
	}
	if(document.forms[0].txtfield5.value=="TEXT FIELD")
	{
		document.forms[0].txtfieldval5.disabled=true;
	}
	else
	{
		document.forms[0].txtfield5.disabled=true;
	}
	if(document.forms[0].masterfield1.value=="0")
	{
		document.forms[0].selmasterfield1.disabled=true;
	}
	else
	{
		document.forms[0].masterfield1.disabled=true;
	}
	if(document.forms[0].masterfield2.value=="0")
	{
		document.forms[0].selmasterfield2.disabled=true;
	}
	else
	{
		document.forms[0].masterfield2.disabled=true;
	}
	if(document.forms[0].masterfield3.value=="0")
	{
		document.forms[0].selmasterfield3.disabled=true;
	}
	else
	{
		document.forms[0].masterfield3.disabled=true;
	}
	if(document.forms[0].masterfield4.value=="0")
	{
		document.forms[0].selmasterfield4.disabled=true;
	}
	else
	{
		document.forms[0].masterfield4.disabled=true;
	}
	if(document.forms[0].masterfield5.value=="0")
	{
		document.forms[0].selmasterfield5.disabled=true;
	}
	else
	{
		document.forms[0].masterfield5.disabled=true;
	}
	document.forms[0].sel_type.disabled=true;
	
   	
}

function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appURL+"action/mainnav.jsp";
		document.forms[0].submit();
	}
}

function ClearFields()
{
	var pageid=	document.forms[0].hidPageId.value;
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			if(!(document.forms[0].elements[i].name=="txtfield1"||document.forms[0].elements[i].name=="txtfield2"||document.forms[0].elements[i].name=="txtfield3"
				||document.forms[0].elements[i].name=="txtfield4"||document.forms[0].elements[i].name=="txtfield5"||document.forms[0].elements[i].name=="masterfield1"
					||document.forms[0].elements[i].name=="masterfield2"||document.forms[0].elements[i].name=="masterfield3"||document.forms[0].elements[i].name=="masterfield4"
						||document.forms[0].elements[i].name=="masterfield5"))
			{
			  document.forms[0].elements[i].value="";
			}		  
		}
		else if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].value="";		  
		}
		if(document.forms[0].elements[i].type=='select-one')
		{
			if(!(document.forms[0].elements[i].name=="masterfield1"
					||document.forms[0].elements[i].name=="masterfield2"||document.forms[0].elements[i].name=="masterfield3"||document.forms[0].elements[i].name=="masterfield4"
						||document.forms[0].elements[i].name=="masterfield5"||document.forms[0].elements[i].name=="sel_type"))
			{
			document.forms[0].elements[i].value="";
			}
		}
		else if(document.forms[0].elements[i].type=="select-multiple")
		{
			document.forms[0].elements[i].value="";		  
		}
	}
	document.forms[0].hidPageId.value=pageid;
	document.getElementById("idagentid").innerHTML="";
	clearrows();
}

function clearrows()
{
	var table=document.all.regnumtable;
	var rowCount=table.rows.length;
	if(rowCount > 1)
	{
		for(var i=rowCount-1;i>0;i--)
		{
			table.deleteRow(i);      
		}
	}

	var table=document.all.empbanknametable;
	var rowCount=table.rows.length;
	if(rowCount > 1)
	{
		for(var i=rowCount-1;i>0;i--)
		{
			table.deleteRow(i);      
		}
	}

	var table=document.all.dsasertable;
	var rowCount=table.rows.length;
	if(rowCount > 1)
	{
		for(var i=rowCount-1;i>0;i--)
		{
			table.deleteRow(i);      
		}
	}
}

function disablefields(one)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=one;
		}	  
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].disabled=one;
		}	  
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=one;
		}
		if(document.forms[0].elements[i].type=='select-multiple')
		{
			document.forms[0].elements[i].disabled=one;
		}
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=one;		  
		}	
		if(document.forms[0].elements[i].type=="radio")
		{
			document.forms[0].elements[i].disabled=(!one);		  
		}
		if(document.forms[0].elements[i].name=="txt_empnameBank")
		{
			document.forms[0].elements[i].readOnly=true;
		}		
		if(document.forms[0].elements[i].name=="txt_dsaservBank")
		{
			document.forms[0].elements[i].readOnly=true;
		}		
	}
	document.forms[0].txt_city.readOnly=true;
	document.forms[0].txt_state.readOnly=true;
	document.forms[0].txt_country.readOnly=true;
	document.forms[0].txt_empnameBank.readOnly=true;
	document.forms[0].txt_dsaservBank.readOnly=true;
	document.forms[0].txt_bankname.readOnly=true;
}
function callCalender(pname)
{
	
	var action  =document.forms[0].hid_action.value;
	if(action =="insert" || action =="update")
	{
		showCal(appURL,pname);
	}
}
function callCalender1(rowindex)
{
	var table=document.getElementById("empbanknametable");
	var rowCount=table.rows.length; 
	var pname="";
	if(rowindex==1 && rowCount==1)
	{
		pname="txt_empanelsince";
	}
	else
	{
		pname="txt_empanelsince["+(rowindex-1)+"]";
	}
	var action  =document.forms[0].hid_action.value;
	if(action =="insert" || action =="update")
	{
		showCal(appURL,pname);
	}
}

function checkdaterow(rowindex)
{
	var table=document.getElementById("empbanknametable");
	var rowCount=table.rows.length; 
	var pname="";
	if(rowindex==1 && rowCount==1)
	{
		pname=document.forms[0].txt_empanelsince;
	}
	else
	{
		pname=document.forms[0].txt_empanelsince[(rowindex-1)];
	}
	checkDate(pname);
}



function doCancel()
{
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
		document.forms[0].hidAppVal.value=strAppVar;
		document.forms[0].action=appURL+"action/BSADSAmaster.jsp";
		document.forms[0].hidBeanId.value="staticdata";
		document.forms[0].hid_action.value="cancel";
		document.forms[0].hidBeanGetMethod.value="getBSADSAList";
		//document.forms[0].hidBeanMethod.value="getValuerMasterList";
		//document.forms[0].hidSourceUrl.value="/action/BSADSAmaster.jsp";		
		document.forms[0].submit();
	}
}

function callBankmaster(id)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
			var varQryString = appURL+"action/ops_sanctionhelp.jsp?hidBeanGetMethod=getSearch&hidBeanId=additionalParameter&pagename=Takeover&id="+id;
			var title = "Bank_Master";
			var prop = "scrollbars=no,width=650,height=400";
			var xpos = "50";
			var ypos = "50";
			prop = prop+","+xpos+","+ypos+",left=200,top=200";
			window.open(varQryString,title,prop);
	}
}
function callBankmastermultiple(rowIndex)
{
	var rowcount=getrowlenth();	
	if(document.forms[0].cmdsave.disabled==false)
	{
			var varQryString = appURL+"action/ops_sanctionhelp.jsp?hidBeanGetMethod=getSearch&hidBeanId=additionalParameter&pagename=bsamaster1&id=147&rowcount="+rowcount+"&rowIndex="+rowIndex;
			var title = "Bank_Master";
			var prop = "scrollbars=no,width=650,height=400";
			var xpos = "50";
			var ypos = "50";
			prop = prop+","+xpos+","+ypos+",left=200,top=200";
			window.open(varQryString,title,prop);
	}
}
function callBankmastermultiple2(rowIndex)
{
	var rowcount=getrowlenth2();
	if(document.forms[0].cmdsave.disabled==false)
	{
			var varQryString = appURL+"action/ops_sanctionhelp.jsp?hidBeanGetMethod=getSearch&hidBeanId=additionalParameter&pagename=bsamaster2&id=147&rowcount="+rowcount+"&rowIndex="+rowIndex;
			var title = "Bank_Master";
			var prop = "scrollbars=no,width=650,height=400";
			var xpos = "50";
			var ypos = "50";
			prop = prop+","+xpos+","+ypos+",left=200,top=200";
			window.open(varQryString,title,prop);
	}
}
function callCntrySearch(varTextControl,varHidControl)
{	
	if(document.forms[0].cmdsave.disabled==false)
	{
			var varQryString = appURL+"action/searchCountry.jsp?hidcntrycontrol="+varTextControl+"&hidcntrycodecontrol="+varHidControl;
			var title = "Country";
			var prop = "scrollbars=no,width=750,height=500";	
			prop = prop + ",left=200,top=200";
			window.open(varQryString,title,prop);	
		
			if(!(varTextControl=="txtperapp_country" || varTextControl=="txtperapp_permcountry" ))
			{
				var varQryString = appURL+"action/searchCountry.jsp?hidcntrycontrol="+varTextControl+"&hidcntrycodecontrol="+varHidControl;
				var title = "Country";
				var prop = "scrollbars=no,width=750,height=500";	
				prop = prop + ",left=200,top=200";
				window.open(varQryString,title,prop);	
			}
			else
			{
				//No Function
			}
	}
}

function reraregnodisp()
{
	var reraregno=document.forms[0].hidreraregnodisp.value;
	var var_arr= reraregno.split("@");
	var length=var_arr.length;
	for(var i=0;i<length;i++)
	{
		var table=document.all.regnumtable;
		var rowCount=table.rows.length;

		var row=table.insertRow(rowCount-1);
		var varName=var_arr[i];
		
		var cell1=row.insertCell(0);
		cell1.innerHTML="<td><input type='text' size='35' name='txt_regno' value='"+varName+"'></td>";
	}
	deleteRowdisabled('regnumtable');
}

function banknamedisp()
{
	var bankname=document.forms[0].hidbanknamedisp.value;
	var bankcode=document.forms[0].hidbankcodedisp.value;
	var empdate=document.forms[0].hidempdatedisp.value;

	var var_arr= bankname.split("@");
	var var_arrcode= bankcode.split("@");
	var var_empdate= empdate.split("@");
	
	var length=var_arr.length;
	for(var i=0;i<length;i++)
	{
		var table=document.all.empbanknametable;
		var rowCount=table.rows.length;

		var row=table.insertRow(rowCount-1);
		var varName=var_arr[i];
			
		var varempdate=var_empdate[i];
		if(varempdate==undefined)
		{
			varempdate="";
		}
		
		var cell1=row.insertCell(0);
		var cell2=row.insertCell(1);

		cell1.innerHTML="<td><input type='text' size='30' name='txt_empnameBank' value='"+varName+"' readOnly='readonly'> <input type='hidden' name='hid_empnameBankcode' value="+var_arrcode[i]+"> <a href='#' id='"+rowCount+"' onClick='callBankmastermultiple2(this.id)' style='cursor: hand'><img src='<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif' border='0'></a></td>";
		cell2.innerHTML="<td><input type='text' size='11' name='txt_empanelsince' value='"+varempdate+"'  id='"+rowCount+"' onBlur='checkdaterow(this.id);checkmaxdate(this,currdate)' ><a alt='Select date from calender' href='#' id='"+rowCount+"' onClick='callCalender1(this.id)'><img src='<%=ApplicationParams.getAppUrl()%>img/calen.gif' border=0 alt='Select date from calender' ></a></td>";

	}
	deleteRowdisabled('empbanknametable');
}

function dsaservbankdisp()
{
	var dsaservbank=document.forms[0].hiddsaservbankdisp.value;
	var dsaservcode=document.forms[0].hiddsaservcodedisp.value;
	var var_arr= dsaservbank.split("@");
	var var_arrcode= dsaservcode.split("@");
	
	var length=var_arr.length;
	for(var i=0;i<length;i++)
	{
		var table=document.all.dsasertable;
		var rowCount=table.rows.length;

		var row=table.insertRow(rowCount-1);
		var varName=var_arr[i];
		
		var cell1=row.insertCell(0);
		cell1.innerHTML="<td><input type='text' size='30' name='txt_dsaservBank' value='"+varName+"' readOnly='readonly'><input type='hidden' name='hid_dsaservBankcode' value="+var_arrcode[i]+"><a href='#' id='"+rowCount+"' onClick='callBankmastermultiple(this.id)' style='cursor: hand'><img src='<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif' border='0'></a></td>";
	}
	deleteRowdisabled('dsasertable');
}


function whetheremp()
{
	var varwhtemp=document.forms[0].sel_whtempanalled.value;
	if(varwhtemp=="Y")
	{
		document.all.whtemp1.style.display="table-cell";
		document.all.whtemp2.style.display="table-cell";
	}
	else
	{
		document.all.whtemp1.style.display="none";
		document.all.whtemp2.style.display="none";
	}
}

function checkFieldChange(newfield,oldfield)
{
	var newvalue=newfield.value;
}

function callAgentName()
{
	if(strAppVar=="")
	{
		alert("Please select BSA/DSA or Others");
		return;
	}
	else if(strAppVar=="OTH" && document.forms[0].sel_type.value=="")
	{
		alert("select Type");
		document.forms[0].sel_type.focus();
		return;
	}
	
	var action=document.forms[0].hidAction.value;
	if(document.forms[0].cmdsave.disabled==true)
	{
		var prop = "scrollbars=yes,width=500,height=400,top=100,left=250";
		var url=appURL+"action/BSADSAlist.jsp?hidBeanId=staticdata&hidBeanGetMethod=getBSADSAList&hidAction=search&strfrom=BSADSAmaster&hidAppVal="+strAppVar+"&strType="+document.forms[0].sel_type.value;
		//var url=appURL+"action/valuerslist.jsp?strfrom=ValuersMaster&hidAppVal="+strAppVar;
		window.open(url,"",prop);
	}
}

function nonindvFields()
{
	if((document.forms[0].sel_applt_constitutionnew.value)!="01")
	{
		document.all.nonindv1.style.display="table-cell";
		document.all.nonindv2.style.display="table-cell";
		document.all.nonindv3.style.display="table-row";
	}
	else
	{
		document.all.nonindv1.style.display="none";
		document.all.nonindv2.style.display="none";
		document.all.nonindv3.style.display="none";

	}
}
function enablefield(pos,varfield,varValue)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		if(varfield=="txtfield" && (eval("document.forms[0]."+varfield+pos).value!="" && eval("document.forms[0]."+varfield+pos).value!="TEXT FIELD"))
		{
			eval("document.forms[0]."+varValue+pos).disabled=false;
		}
		if(varfield=="masterfield")
		{
			if(eval("document.forms[0]."+varfield+pos).value=="218")
			{
				alert("Not a valid option");
				eval("document.forms[0]."+varfield+pos).value="0";
				return;
			}
			
			if((eval("document.forms[0]."+varfield+pos).value!="" && eval("document.forms[0]."+varfield+pos).value!="0"))
			{
				var val=eval("document.forms[0]."+varfield+pos).value;
				eval("document.forms[0]."+varValue+pos).disabled=false;
				eval("document.all.ifrm"+pos).src=appURL+"action/ifrmmasterfields.jsp?hidBeanGetMethod=getData&hidBeanId=staticdata&seldataheadtype="+val+"&strPos="+pos;
			}
			else
			{
				eval("document.forms[0].selmasterfield"+pos).length =1;
				eval("document.forms[0].selmasterfield"+pos).options[0].text="<--select-->";
				eval("document.forms[0].selmasterfield"+pos).options[0].value="";
			}
		}
	}
}
function LoadValues()
{
	var varFlag="TRUE";
	<%if(arrRow!=null && arrRow.size()>0)
	{
		for(int i=0;i<arrRow.size();i++)
		{
			arrCol=(ArrayList)arrRow.get(i);%>
			if(strAppVar=="<%=Helper.correctNull((String)arrCol.get(0))%>")
			{
				if(strAppVar!="OTH")
				{
					varFlag="FALSE";
					document.forms[0].txtfield1.value="<%=Helper.correctNull((String)arrCol.get(2))%>";
					document.forms[0].txtfield2.value="<%=Helper.correctNull((String)arrCol.get(3))%>";
					document.forms[0].txtfield3.value="<%=Helper.correctNull((String)arrCol.get(4))%>";
					document.forms[0].txtfield4.value="<%=Helper.correctNull((String)arrCol.get(5))%>";
					document.forms[0].txtfield5.value="<%=Helper.correctNull((String)arrCol.get(6))%>";
					document.forms[0].masterfield1.value="<%=Helper.correctNull((String)arrCol.get(7))%>";
					document.forms[0].masterfield2.value="<%=Helper.correctNull((String)arrCol.get(8))%>";
					document.forms[0].masterfield3.value="<%=Helper.correctNull((String)arrCol.get(9))%>";
					document.forms[0].masterfield4.value="<%=Helper.correctNull((String)arrCol.get(10))%>";
					document.forms[0].masterfield5.value="<%=Helper.correctNull((String)arrCol.get(11))%>";
				}
				else if(strAppVar=="OTH" && (document.forms[0].sel_type.value=="<%=Helper.correctNull((String)arrCol.get(1))%>"))
				{
					varFlag="FALSE";
					document.forms[0].txtfield1.value="<%=Helper.correctNull((String)arrCol.get(2))%>";
					document.forms[0].txtfield2.value="<%=Helper.correctNull((String)arrCol.get(3))%>";
					document.forms[0].txtfield3.value="<%=Helper.correctNull((String)arrCol.get(4))%>";
					document.forms[0].txtfield4.value="<%=Helper.correctNull((String)arrCol.get(5))%>";
					document.forms[0].txtfield5.value="<%=Helper.correctNull((String)arrCol.get(6))%>";
					document.forms[0].masterfield1.value="<%=Helper.correctNull((String)arrCol.get(7))%>";
					document.forms[0].masterfield2.value="<%=Helper.correctNull((String)arrCol.get(8))%>";
					document.forms[0].masterfield3.value="<%=Helper.correctNull((String)arrCol.get(9))%>";
					document.forms[0].masterfield4.value="<%=Helper.correctNull((String)arrCol.get(10))%>";
					document.forms[0].masterfield5.value="<%=Helper.correctNull((String)arrCol.get(11))%>";
				}
			}
			
		
		<%}%>
		if(varFlag=="TRUE")
		{
			document.forms[0].txtfield1.value="TEXT FIELD";
			document.forms[0].txtfield2.value="TEXT FIELD";
			document.forms[0].txtfield3.value="TEXT FIELD";
			document.forms[0].txtfield4.value="TEXT FIELD";
			document.forms[0].txtfield5.value="TEXT FIELD";
			document.forms[0].masterfield1.value="0";
			document.forms[0].masterfield2.value="0";
			document.forms[0].masterfield3.value="0";
			document.forms[0].masterfield4.value="0";
			document.forms[0].masterfield5.value="0";
		}
	<%}
	else
	{%>
	document.forms[0].txtfield1.value="TEXT FIELD";
	document.forms[0].txtfield2.value="TEXT FIELD";
	document.forms[0].txtfield3.value="TEXT FIELD";
	document.forms[0].txtfield4.value="TEXT FIELD";
	document.forms[0].txtfield5.value="TEXT FIELD";
	document.forms[0].masterfield1.value="0";
	document.forms[0].masterfield2.value="0";
	document.forms[0].masterfield3.value="0";
	document.forms[0].masterfield4.value="0";
	document.forms[0].masterfield5.value="0";
	<%}%>

	for(var i=1;i<=5;i++)
	{
		if(eval("document.forms[0].masterfield"+i).value!="0")
		{
			var val=eval("document.forms[0].masterfield"+i).value;
			eval("document.all.ifrm"+i).src=appURL+"action/ifrmmasterfields.jsp?hidBeanGetMethod=getData&hidBeanId=staticdata&seldataheadtype="+val+"&strPos="+i;
		}
		else
		{
			eval("document.forms[0].selmasterfield"+i).length =1;
			eval("document.forms[0].selmasterfield"+i).options[0].text="<--select-->";
			eval("document.forms[0].selmasterfield"+i).options[0].value="";
		}
	}
}
</SCRIPT>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="callonLoad();">
<form name="appform" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Master -&gt; Appraiser/Valuer's Master</td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../set/mastertab.jsp" flush="true">
			<jsp:param name="tabid" value="16" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="3"
	class="outertable">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="3"
			class="outertable border1 tableBg">
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3"
					class="outertable">
				   <tr>
				   <td colspan="7">
				   <input type="radio" name="rad" value="radiobutton" onClick="callAppVal()"
							style="border-style: none" maxlength="75">Business Sourcing Agents &nbsp;
						
						<input type="radio" name="rad" value="radiobutton"
							onClick="callAppVal()" style="border-style: none" maxlength="75">
							Direct Selling Agents  &nbsp; 
							
						<input type="radio" name="rad" value="radiobutton"
							onClick="callAppVal()" style="border-style: none" maxlength="75">
							Others  &nbsp; 
				   </td>
				  </tr>
					
					<tr>
						<td>&nbsp;</td><td> Agent ID : <span id="idagentid" style="color:#750b6a"> </span>  </td>
						<td>&nbsp;</td>
					</tr>
					<tr> 
					<td>&nbsp;</td><td>Name </td>
					<td valign="top" nowrap="nowrap"><input type="text"
							name="txt_name" size="38" maxlength="50" tabindex="1" onblur="checkFieldChange(this,document.forms[0].txt_name.value)"
							onKeyPress="notAllowSplChar()"> &nbsp;&nbsp;<b><span
							onClick="callAgentName()" style="cursor: hand" id="idsearch1"><img
							src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
							border="0"></span></b></td>
							
					<td id="BSA1">Date of Birth/Incorporation </td>
				 	<td id="BSA2">
			          	<input type="text" name="txt_dob" size="11"
						maxlength="11"
						onBlur="checkDate(document.forms[0].txt_dob);checkmaxdate(this,currdate)">
			                      <a alt="Select date from calender" href="#"
						onClick="callCalender('txt_dob')"
						onMouseOver="window.status='Date Picker';return true;"
						onMouseOut="window.status='';return true;"><img
						src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border=0
						alt="Select date from calender" tabindex="17"></a></td>
					</tr>
					<tr id="idOTH1">
					<td>&nbsp;</td> <td>Type</td>
				 	  <td><select name="sel_type" onchange="LoadValues();">
				 	  <option value=""><--select--></option>
				 	  <lapschoice:StaticDataTag apptype="218" />
				 	  </select>
				 	  </td>
				 	  <td> Authorised Dealership Registration Number</td>
				 	  <td> <input type="text" name="txt_dealershipregno" onkeypress="allowAlphaNumeric();">
	                   </td>
				  </tr>
				  <tr id="idOTH2">
					<td>&nbsp;</td> <td>Registration Valid from</td>
				 	  <td><input type="text" name="txt_regdatefrom" size="11"
									maxlength="11"
									onBlur="checkDate(document.forms[0].txt_regdatefrom);checkmaxdate(this,currdate);">
                            <a alt="Select date from calender" href="#"
									onClick="callCalender('txt_regdatefrom')"
									onMouseOver="window.status='Date Picker';return true;"
									onMouseOut="window.status='';return true;"><img
									src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border=0
									alt="Select date from calender"></a>
				 	  </td>
				 	  <td> Registration Valid upto</td>
				 	  <td><input type="text" name="txt_regdateto" size="11"
									maxlength="11"
									onBlur="checkDate(document.forms[0].txt_regdateto);checkmindate(this,currdate);">
                            <a alt="Select date from calender" href="#"
									onClick="callCalender('txt_regdateto')"
									onMouseOver="window.status='Date Picker';return true;"
									onMouseOut="window.status='';return true;"><img
									src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border=0
									alt="Select date from calender"></a>
	                   </td>
				  </tr>
					
					<tr>
					 	<td>&nbsp;</td><td>Address </td>
						<td><input type="text" name="txt_address1" size="38" maxlength="50"> </td>	
						<td align="left">City <b><span class="mantatory">*</span></b>
						<td><input type="text" name="txt_city" size="25"
							maxlength="25" tabindex="10"
							onKeyPress="notAllowSplChar()"> <b><a id="idsearch2"
							href="javascript:showCitySearch('txt_city','txt_state','hidcity','hidstate','txt_zip','hidzip')"
							tabindex="5"><img
							src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
							border="0"></a></b> <input type="hidden" name="hidcity"
							 />
						</td>
					</tr>
					
					<tr>
					<td>&nbsp;</td><td>&nbsp;</td>
					<td><input type="text" name="txt_address2" size="38" maxlength="50"> </td>
						<td>State <b><span class="mantatory">*</span></b></td>
					<td><input type="text" name="txt_state" size="25"
							maxlength="25" tabindex="12"
							onKeyPress="notAllowSplChar()"
							onBlur="changecase(document.forms[0].txt_state)"> <input
							type="hidden" name="hidstate" />
						</td>
					</tr>
					
					<tr>
					<td>&nbsp;</td><td>Country</td>
					<td><input type="text" name="txt_country" size="15"
							maxlength="20" tabindex="13" readonly="readonly"
							onKeyPress="notAllowSplChar()">
							<input type="hidden"
							name="hidperapp_country"
							><a href="#"  id="idsearch3"
							onClick="callCntrySearch('txt_country','hidperapp_country')"
							style="cursor:hand" tabindex="8"><img
							src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
							border="0" tabindex="21"></a> 
					 </td>
					 <td>Pin code</td>
					 <td><input type="text" name="txt_zip" maxlength="6" onKeyPress="allowInteger()"> </td>	
					</tr>
					
					
					<tr>
					 <td>&nbsp;</td><td>Mobile Number </td>
					 <td><input type="text" name="txt_mobile" onKeyPress="allowPhone()" maxlength="10"> </td>	
					 <td>Telephone number / Alternative number</td>
					 <td><input type="text" name="txt_telephone" onKeyPress="allowPhone()" maxlength="15"> </td>	
					</tr>
					
					<tr>
					<td>&nbsp;</td><td>Email ID </td>
						<td><input type="text" name="txt_email" onBlur="isEmailAddr(document.forms[0].txt_email.value,document.forms[0].txt_email)">  </td>
		              
						<td> Constitution </td>
						<td><select name="sel_applt_constitutionnew" 
							onChange="nonindvFields()">
		                    <option value="0">---Select-----</option>
		                    <%String apptypecon = "2";%>
		                    <lapschoice:CBSStaticDataNewTag apptype='<%=apptypecon%>' tagType="value" />
		                  </select>
		                </td>
					</tr>
					
					<tr>
						 <td>&nbsp;</td> 
						<td>PAN / GST No</td> 
						<td><input type="text" name="txt_pannum">  </td>
						
						<td id="nonindv1">Name of Proprietor/Partner/Directors/Others </td>
						<td id="nonindv2"><input type="text" name="txt_nonindname"> </td> 
					
					</tr>
					
					<tr id="nonindv3">
						<td>&nbsp;</td>
						<td>Key person to contact </td> 
						<td><input type="text" name="txt_keyperson" onKeyPress="notAllowSplChar()">  </td>
						<td>Designation of Key Person</td>
						<td><input type="text" name="txt_designkeyperson" onKeyPress="notAllowSplChar()">  </td>
					</tr>
					
				  <tr id="idBSA1"> 
				  	<td>&nbsp;</td><td>Reference Name </td>
				  	<td><input type="text" name="txt_reference" maxlength="50"> </td>
				  	<td>Reference Contact Number </td>
				  	<td><input type="text" name="txt_referenceno" onKeyPress="allowPhone()" maxlength="15"> </td>
				 	
				 	
				  </tr>
				  
				  <tr id="idBSA2">
					<td>&nbsp;</td>  
					<td valign="top"> 
						<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
					  		<tr>	
								<td>RERA Registration Number </td>
								<td><a href="#" onClick="addRow();"><img
												src="<%=ApplicationParams.getAppUrl()%>img/add.png"
												width="10" height="10" border="0" tabindex="38"></a></td>
															
								<td><a href="#" onClick="deleteRow('regnumtable');"><img
											src="<%=ApplicationParams.getAppUrl()%>img/cancel.png"
											width="10" height="10" border="0" tabindex="38"></a></td>
							</tr>
						</table>
					 </td>
					  <td> 
					  	<table width="100%" border="0" cellspacing="0" cellpadding="2" id="regnumtable" >
					  		<tr>	
                               <td>
                                <input
									type="text" name="txt_regno" tabindex="31" maxlength="50"
										wrap="VIRTUAL"  size="35" value="">
                                </td>
                             </tr>
					  		
					  	</table>
					   </td>
				  </tr>
				 
				  <tr id="idBSA3">
					 <td>&nbsp;</td> <td valign="top">Whether empanelled with other Bank/FI </td>
					  <td valign="top">
						  	<select name="sel_whtempanalled" onchange="whetheremp()">
	                       	 	<option value="">-- Select --</option>
	                       	 	<option value="Y">Yes</option>
	                        	<option value="N">No</option>
	                    	</select>
					  </td>
					 <td valign="top" id="whtemp1" >
						<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
					  		<tr>	
								<td>Name of the Bank & Empaneled since</td>
								<td><a href="#" onClick="addRowdbankname();"><img
												src="<%=ApplicationParams.getAppUrl()%>img/add.png"
												width="10" height="10" border="0" tabindex="38"></a></td>
															
								<td><a href="#" onClick="deleteRow('empbanknametable');"><img
											src="<%=ApplicationParams.getAppUrl()%>img/cancel.png"
											width="10" height="10" border="0" tabindex="38"></a></td>
							</tr>
						</table>
				  	 </td>
				  	<td id="whtemp2"> 
					  	<table width="100%" border="0" cellspacing="0" cellpadding="2" id="empbanknametable" >
					  	  <tr>	
							<td>
								<input type="text" name="txt_empnameBank" value="" size="30" readOnly="readonly"  
								maxlength="50"  onKeyPress="notAllowSingleAndDoubleQuote();notAllowSplChar()"
								 tabindex="2">
								 <input type="hidden" name="hid_empnameBankcode">
									<a href="#" id='1' onClick="callBankmastermultiple2(this.id)" style="cursor: hand">
								<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0"></a>
				 			</td>
				 			
				 	  		<td valign="top">
			          			<input type="text" name="txt_empanelsince" size="11"
									maxlength="11"
									onBlur="checkdaterow('1');checkmaxdate(this,currdate)">
						                      <a alt="Select date from calender" href="#"
									onClick="callCalender1('1')"
									onMouseOver="window.status='Date Picker';return true;"
									onMouseOut="window.status='';return true;"><img
									src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border=0
									alt="Select date from calender" tabindex="17"></a>
							</td>
                          </tr>
					  	</table>
					</td>	
				  </tr>
				  
				  <tr id="idDSA1">
					<td>&nbsp;</td> <td>Past experience in this line of business</td>
				 	  <td> <input type="text" name="txt_pastexp"> </td>
				 	  <td> Office Premises own/Rented</td>
				 	  <td> <select name="sel_officepremises">
				 	  		<option value=""> -- Select -- </option>
							<option value="O"> Owned </option>
                    		<option value="R"> Rented </option>
						</select> 
	                   </td>
				  </tr>
				  
				  <tr id="idDSA2">
				  	<td>&nbsp;</td><td valign="top" id="idDSA5">Registration under statutory act/laws (if any)  </td>
				  	<td valign="top" id="idDSA6"><input type="text" name="txt_regis" maxlength="50"> </td>
				  	<td valign="top"> 
				  		<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
					  		<tr>	
								<td>Presently providing DSA services to</td>
								<td><a href="#" onClick="addRowdsaserv();"><img
												src="<%=ApplicationParams.getAppUrl()%>img/add.png"
												width="10" height="10" border="0" tabindex="38"></a></td>
															
								<td><a href="#" onClick="deleteRow('dsasertable');"><img
											src="<%=ApplicationParams.getAppUrl()%>img/cancel.png"
											width="10" height="10" border="0" tabindex="38"></a></td>
							</tr>
						</table>
				  	 </td>
				  	<td> 
					  	<table width="100%" border="0" cellspacing="0" cellpadding="2" id="dsasertable" >
					  	  <tr>	
							<td>
								<input type="text" name="txt_dsaservBank" value="" size="30" readOnly="readonly"  
								maxlength="50"  onKeyPress="notAllowSingleAndDoubleQuote();notAllowSplChar()"
								 tabindex="2">
								 <input type="hidden" name="hid_dsaservBankcode" value="">
									<a href="#" id='1' onClick="callBankmastermultiple(this.id)" style="cursor: hand">
								<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0"></a>
				 			</td>
                          </tr>
					  	</table>
					 </td>	
				  </tr>
				  
				  
				  <tr>
						<td colspan="7">&nbsp;&nbsp;<b><u>Details of Bank Account </u></b></td>
					</tr>	
					
					<tr>
						<td>&nbsp;</td><td>Type </td>
						<td><select name="sel_banktype" tabindex="20">
							<option value=""> -- Select -- </option>
							<lapschoice:StaticDataTag apptype="213" />
						</select></td>
					</tr>
				  <tr>
				  		<td>&nbsp;</td><td>Name of the Bank </td>
				  		 <td>
						<input type="text" name="txt_bankname" value="" size="30" readOnly="readonly"  
						maxlength="50"  onKeyPress="notAllowSingleAndDoubleQuote();notAllowSplChar()"
						 tabindex="2">
						 <input type="hidden" name="hid_LeadBankcode" value="">
							<a href="#" onClick="callBankmaster('147')" style="cursor: hand">
						<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0">
						</a>
				 		 </td>
				  		<td>Bank Account number </td>
				  		<td><input type="text" name="txt_accno">  </td>
				  </tr>
				  <tr>
				  	<td>&nbsp;</td><td>Bank Branch </td>
					 <td><input type="text" name="txt_branch">  </td>
					 <td>IFSC code </td>
					 <td><input type="text" name="txt_ifsccode" onkeypress="allowAlphaNumeric()" maxlength="11">  </td> 	 	
				  </tr>
				  
				  <tr> 
		  	 		 <td>&nbsp;</td><td>Empanelment details </td>
				  	 <td><input type="text" name="txt_empaneldet" maxlength="50" size="50">  </td>
				  	  <td>Empanelment Date </td>
				  	  <td>
                            <input type="text" name="txt_empaneledon" size="11"
									maxlength="11"
									onBlur="checkDate(document.forms[0].txt_empaneledon);checkmaxdate(this,currdate)">
                           		 &nbsp;<a alt="Select date from calender" href="#"
									onClick="callCalender('txt_empaneledon')"
									onMouseOver="window.status='Date Picker';return true;"
									onMouseOut="window.status='';return true;"><img
									src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border=0
									alt="Select date from calender" tabindex="17"></a></td>
				  </tr> 
				  
				  
				  <tr>
				  	<td>&nbsp;</td><td> Expiry Date </td>
				  	<td>
                            <input type="text" name="txt_expirydate" size="11"
									maxlength="11"
									onBlur="checkDate(document.forms[0].txt_expirydate);checkmindate(this,currdate)">
                            <a alt="Select date from calender" href="#"
									onClick="callCalender('txt_expirydate')"
									onMouseOver="window.status='Date Picker';return true;"
									onMouseOut="window.status='';return true;"><img
									src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border=0
									alt="Select date from calender" tabindex="17"></a></td>
				 	 <td> Action </td>
					 <td>
					  	<select name="sel_action">
                 			<option value="">-- Select --</option>
                       	 	<option value="E">Enabled</option>
                        	<option value="D">Disabled</option>
                    	</select>
					 </td>
				  </tr>
				  <tr>
				  <td>&nbsp;</td>
				  <td>Regional Office</td>
				  <td> <select name="sel_region" >
						<option value="" selected><--select--></option>
						<lapschoice:LeadGeneratedRegion/>
					</select>&nbsp; </td>
				  </tr>
				   <tr>
				  <td>&nbsp;</td>
				  <td>1.<input type="text" name="txtfield1" value="TEXT FIELD" onblur="enablefield('1','txtfield','txtfieldval');"></td>
				  <td><textarea name="txtfieldval1" cols="50" rows="5" onKeyPress="textlimit(this,499)" onKeyUp="textlimit(this,499)"></textarea></td>
				  <td>1.<select name="masterfield1" onchange="enablefield('1','masterfield','selmasterfield');">
                                        <option value="0" selected>&lt;----Select----&gt;</option>
                                        <lapschoice:StaticDataHeadsTag/> 
                                      </select></td>
				  <td><select name="selmasterfield1">
				  <option value=""><--select--></option>
				  </select></td>
				  </tr>
				   <tr>
				  <td>&nbsp;</td>
				  <td>2.<input type="text" name="txtfield2" value="TEXT FIELD" onblur="enablefield('2','txtfield','txtfieldval');"></td>
				  <td><textarea name="txtfieldval2" cols="50" rows="5" onKeyPress="textlimit(this,499)" onKeyUp="textlimit(this,499)"></textarea></td>
				  <td>2.<select name="masterfield2" onchange="enablefield('2','masterfield','selmasterfield');">
                                        <option value="0" selected>&lt;----Select----&gt;</option>
                                        <lapschoice:StaticDataHeadsTag/> 
                                      </select></td>
				  <td><select name="selmasterfield2">
				  <option value=""><--select--></option>
				  </select></td>
				  </tr>
				   <tr>
				  <td>&nbsp;</td>
				  <td>3.<input type="text" name="txtfield3" value="TEXT FIELD" onblur="enablefield('3','txtfield','txtfieldval');"></td>
				  <td><textarea name="txtfieldval3" cols="50" rows="5" onKeyPress="textlimit(this,499)" onKeyUp="textlimit(this,499)"></textarea></td>
				  <td>3.<select name="masterfield3"  onchange="enablefield('3','masterfield','selmasterfield');">
                                        <option value="0" selected>&lt;----Select----&gt;</option>
                                        <lapschoice:StaticDataHeadsTag/> 
                                      </select></td>
				  <td><select name="selmasterfield3">
				  <option value=""><--select--></option>
				  </select></td>
				  </tr>
				   <tr>
				  <td>&nbsp;</td>
				  <td>4.<input type="text" name="txtfield4" value="TEXT FIELD" onblur="enablefield('4','txtfield','txtfieldval');"></td>
				  <td><textarea name="txtfieldval4" cols="50" rows="5" onKeyPress="textlimit(this,499)" onKeyUp="textlimit(this,499)"></textarea></td>
				  <td>4.<select name="masterfield4"  onchange="enablefield('4','masterfield','selmasterfield');">
                                        <option value="0" selected>&lt;----Select----&gt;</option>
                                        <lapschoice:StaticDataHeadsTag/> 
                                      </select></td>
				  <td><select name="selmasterfield4">
				  <option value=""><--select--></option>
				  </select></td>
				  </tr>
				   <tr>
				  <td>&nbsp;</td>
				  <td>5.<input type="text" name="txtfield5" value="TEXT FIELD" onblur="enablefield('5','txtfield','txtfieldval');"></td>
				  <td><textarea name="txtfieldval5" cols="50" rows="5" onKeyPress="textlimit(this,499)" onKeyUp="textlimit(this,499)"></textarea></td>
				  <td>5.<select name="masterfield5" onchange="enablefield('5','masterfield','selmasterfield');">
                                        <option value="0" selected>&lt;----Select----&gt;</option>
                                        <lapschoice:StaticDataHeadsTag/> 
                                      </select></td>
				  <td><select name="selmasterfield5">
				  <option value=""><--select--></option>
				  </select></td>
				  </tr>
				  
				  <tr>
				  <td colspan="7">&nbsp;&nbsp;&nbsp; </td>
				  </tr>
				  
				  
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames="New_Edit_Save_Cancel_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<input type="hidden" name="hidorg_code"	value="<%=Helper.correctNull((String) hshValues.get("ORG_CODE"))%>">
<input type="hidden" name="hidsno" >
<input type="hidden" name="hidmastid"/>
 <input	type="hidden" name="hidAppVal">
   	<input type="hidden" name="hid_action">
   	<input type="hidden" name="hidapp_name">
  
	<input type="hidden" name="hidzip">
 <lapschoice:hiddentag pageid='<%=PageId%>'/> 
 <input type="hidden" name="hidExorgcode">
 <input type="hidden" name="hidAgentID">
	<input type="hidden" name="hidrera_regno">
	<input type="hidden" name="hid_dsaservice">
 	<input type="hidden" name="hid_bankname">
 	<input type="hidden" name="hidreraregnodisp">
 
 	<input type="hidden" name="hidbanknamedisp">
 	<input type="hidden" name="hidbankcodedisp">
 	
 	<input type="hidden" name="hiddsaservbankdisp">
 	<input type="hidden" name="hiddsaservcodedisp">
 	<input type="hidden" name="hidempdatedisp">
 <iframe name="ifrm1" width="0" height="0" border="0"></iframe>
 <iframe name="ifrm2" width="0" height="0" border="0"></iframe>
 <iframe name="ifrm3" width="0" height="0" border="0"></iframe>
 <iframe name="ifrm4" width="0" height="0" border="0"></iframe>
 <iframe name="ifrm5" width="0" height="0" border="0"></iframe>
</form>
</body>
</html>
