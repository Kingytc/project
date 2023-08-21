<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"  pageEncoding="ISO-8859-1"%>
<lapschoice:handleerror />
<%
ArrayList arrRow=new ArrayList();
ArrayList arrCol=new ArrayList();
	if(hshValues!=null)
	{
		arrRow = (ArrayList)hshValues.get("arrRow");
	}
 String currdate=Helper.getCurrentDateTime();
%>  
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>SHG Member Details</title>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varsel_bpl="<%=Helper.correctNull((String)hshValues.get("sel_bpl"))%>";
var varsel_apl="<%=Helper.correctNull((String)hshValues.get("sel_apl"))%>";
var varsel_idprooftype="<%=Helper.correctNull((String)hshValues.get("sel_idprooftype"))%>";


function doNew()
{
		disableCommandButtons_agr("edit");
	    document.forms[0].hidAction.value="insert";
}

function callOnload()
{
	if(varsel_bpl!="")
	{
		document.forms[0].sel_bpl.value=varsel_bpl;
	}
	else
	{
		document.forms[0].sel_bpl.value="y";
	}
	if(varsel_apl!="")
	{
		document.forms[0].sel_apl.value=varsel_apl;
	}
	else
	{
		document.forms[0].sel_apl.value="y";
	}
	if(varsel_idprooftype!="")
	{
		document.forms[0].sel_idprooftype.value=varsel_idprooftype;
	}
	else
	{
		document.forms[0].sel_idprooftype.value="s";
	}
	disablefields(true);
	disableCommandButtons_agr("load");	
	}

function disablefields(one)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=one;
		}	  
	}
}	

function doApply()
{
	if(trim(document.forms[0].txt_membername.value)=="")
	{
		alert("Enter the Nominee Name");	
		document.forms[0].txt_membername.focus();
		return false;
	}
	
   		var table = document.all.id_tablemax;
		var rowCount =  table.rows.length;
		if(rowCount>20)
		{ 
		alert("Only Allowed Twenty SHG Members");
	    }
		else{
	document.forms[0].hidBeanId.value="mastapplicant";		
	document.forms[0].hidBeanMethod.value="updateshgmemberData";
	document.forms[0].hidBeanGetMethod.value="getshgmembersData";
	document.forms[0].hidSourceUrl.value="/action/agr_shgmemberdetails.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
		}
}
function doCancel()
{

	if(ConfirmMsg(102))
    {
	document.forms[0].hidBeanId.value="mastapplicant";
	document.forms[0].hidBeanGetMethod.value="getshgmembersData";
	document.forms[0].action=appURL+"action/agr_shgmemberdetails.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
	   }
}

function doDelete()
{ 
	if(ConfirmMsg(101))
  {
	document.forms[0].hidAction.value ="delete";
	document.forms[0].hidBeanMethod.value="updateshgmemberData";
	document.forms[0].hidBeanGetMethod.value="getshgmembersData";
	document.forms[0].hidBeanId.value="mastapplicant";
	document.forms[0].action=appURL+"action/ControllerServlet";	
	document.forms[0].hidSourceUrl.value="action/agr_shgmemberdetails.jsp";
	document.forms[0].submit();		
  }
}
function doClose()
{
	if( ConfirmMsg(100) )
	{
		window.close();
	}

}
function doEdit()
{
	disabledFields(false);
	disableCommandButtons_agr("edit");
	document.forms[0].hidAction.value="update";
}

function selectValues(val1,val2,val3,val4,val5,val6,val7,val8,val9,val10,val11,val12,val13)
{
	document.forms[0].txt_membername.value=val1;
	document.forms[0].txt_so.value=val2;
	document.forms[0].txt_age.value=val3;
	document.forms[0].txt_designation.value=val4;
	document.forms[0].txt_address.value=val5;
	document.forms[0].txt_remrks.value=val6;
	document.forms[0].selsno.value=val13;
	document.forms[0].txt_accno.value=val7;
	document.forms[0].sel_bpl.value=val8;
	document.forms[0].sel_apl.value=val9;
	document.forms[0].txt_accopendate.value=val10;
	document.forms[0].sel_idprooftype.value=val11;
	document.forms[0].txt_idproofno.value=val12;	
	disableCommandButtons_agr("radioselect");	
}
</script>
</head>
<body onload="callOnload()">
<form>
<table align="center" width="98%">
<td align="center"><br><img src="<%=ApplicationParams.getAppUrl()%>img/banklogo.gif"></td>
<tr><td>&nbsp;</td></tr>
<tr class="dataheader" color="#FFFFFF" width ="15">
<td align="center" color="#FFFFFF" width ="15%">SHG MEMBER DETAILS</td>
</tr>
</table>
<table  width="98%" border="1" cellspacing="1" cellpadding="0"
	class="outertable" align="center">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="outertable">
			<tr class="dataheader">
				<td align="center" width ="18%">Member Name<span class="mantatory">*</span></td>
				<td align="center" width ="18%">S/o or W/o or D/o</td>
				<td align="center" width ="10%">Age</td>
				<td align="center" width ="18%">SB Ac/no</td>
				<td align="center" width ="18%">BPL is obtained</td>
				<td align="center" width ="18%">APL is obtained</td>
				</tr>
				<tr>
				<td align="center"><input type="text" name="txt_membername" tabindex="1" style="text-align: left" 
					size="20" onKeyPress="allowAlphabetsAndSpace()" maxlength="50" 
				    VALUE="<%=Helper.correctNull((String)hshValues.get("txt_membername"))%>" onBlur=""></td>
				    <td align="center"><input type="text" name="txt_so"  tabindex="2" style="text-align: left" 
					size="20" onKeyPress="allowAlphabets()"
					VALUE="<%=Helper.correctNull((String)hshValues.get("txt_so"))%>" maxlength="50" onBlur=""></TD>
					<td align="center"><input type="text" name="txt_age"  tabindex="3" style="text-align: right" 
					size="10" onKeyPress="allowNumber(this)" 
					VALUE="<%=Helper.correctNull((String)hshValues.get("txt_age"))%>" maxlength="2"></TD>
					<td align="center"><input type="text" name="txt_accno"  tabindex="4" style="text-align: right" 
					size="23" onKeyPress="allowNumber(this)" 
					VALUE="<%=Helper.correctNull((String)hshValues.get("txt_accno"))%>" maxlength="20" ></TD>
					<td align="center"><select name="sel_bpl" tabindex="5">
												<option value="s" Selected>---- Select ----</option>
												<option value="y">Yes</option>
												<option value="n">No</option>
											</select></TD>
					<td align="center"><select name="sel_apl" tabindex="6">
												<option value="s" Selected>---- Select ----</option>
												<option value="y">Yes</option>
												<option value="n">No</option>
											</select></TD>
				</tr>
			
				<tr>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td></tr>
				<tr class="dataheader">
				<td align="center" width ="15%" nowrap="nowrap">A/c opened date</td>
				<td align="center" width ="15%">Id proof Type</td>
				<td align="center" width ="15%">Id proof No</td>
				<td align="center" width ="20%">Designation</td>
				<td align="center" width ="25%">Address</td>
				<td align="center" width ="25%">Remarks</td>
				
				
				</tr>
				<tr>
				<td align="center"><input type="text" name="txt_accopendate"  tabindex="7" style="text-align: right" 
					size="12" onKeyPress="allowNumber(this)"
					value="<%=Helper.correctNull((String)hshValues.get("txt_accopendate"))%>"
													onBlur="checkDate(this);checkmaxdate1(this,'<%=currdate%>')">&nbsp;<a href="#"
													onClick="callCalender('txt_accopendate')" tabindex="7"  title="Click to view calender"
													border=0><img
													src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
													border="0"></a></TD>
					<td align="center"><select name="sel_idprooftype" tabindex="8">
												<option value="s" Selected>---- Select ----</option>
												<option value="1">Aadhar Card</option>
												<option value="2">Voter Id</option>
												<option value="3">Driving License</option>
												<option value="4">Pan Card</option>
											</select></TD>
					<td align="center"><input type="text" name="txt_idproofno"  tabindex="9" style="text-align: right" 
					size="20" onKeyPress="allowNumber(this)"
					VALUE="<%=Helper.correctNull((String)hshValues.get("txt_idproofno"))%>" maxlength="20"></TD>
					<TD align="center"><input type="text" name="txt_designation" tabindex="10" style="text-align: left"  
					size="21" onKeyPress="allowAlphabetsAndSpace()" 
					VALUE="<%=Helper.correctNull((String)hshValues.get("txt_designation"))%>" maxlength="50" onBlur=""></TD>
					<td align="center" width="20%"><textarea rows="5" cols="25" name="txt_address" tabindex="11"
					VALUE="<%=Helper.correctNull((String)hshValues.get("txt_address"))%>" maxlength="100"></textarea></td>
					<td align="center" width="20%"><textarea rows="5" cols="25" name="txt_remrks" tabindex="12"
					VALUE="<%=Helper.correctNull((String)hshValues.get("txt_remrks"))%>" maxlength="100"></textarea></td>
				    
				</tr>
					</table>
					</td>
					</tr>
					</table>
					<br>
<laps:combuttonnew btnnames='New_Edit_Apply_Cancel_Delete' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
 <br/>
                         <tr> 
                        <td> 
                        <div class = "cellContainer">
                          <table id="id_tablemax" align="center" width="98%" border="0" cellspacing="1" cellpadding="2">
                            <tr class="dataheader"> 
                              <td width="3%">&nbsp;</td>
                              <td width="40%" align="center">Name</td>
                              <td width="20%" align="center">Age</td>
                              <td width="40%" align="center"> 
                                <p>Designation</p>
                              </td>
                            </tr>
                              <%
                          	double dblTotArea=0,dblTotMarket=0,dblTotValLand=0;
                          			if (arrRow != null ) {
                          				if (arrRow.size() > 0) {
                          					for (int i = 0; i < arrRow.size(); i++) {
                          						arrCol = (ArrayList) arrRow.get(i);
                         
                                                 						%>
	<tr class="datagrid" id="id_rowmax">
				<td width="4%" align="center"><input type="radio"
					style="border:1" name="radiobutton" value="radiobutton"
				onClick="javascript:selectValues('<%=Helper.correctNull((String)arrCol.get(2))%>',
				'<%=Helper.correctNull((String)arrCol.get(3))%>',
				'<%=Helper.correctNull((String)arrCol.get(4))%>',
				'<%=Helper.correctNull((String)arrCol.get(5))%>',
			
				'<%=Helper.replaceForJavaScriptString((String)arrCol.get(6))%>',
				'<%=Helper.replaceForJavaScriptString((String)arrCol.get(7))%>',
				'<%=Helper.correctNull((String)arrCol.get(8))%>',
				'<%=Helper.correctNull((String)arrCol.get(9))%>',
				'<%=Helper.correctNull((String)arrCol.get(10))%>',
				'<%=Helper.correctNull((String)arrCol.get(11))%>',
				'<%=Helper.correctNull((String)arrCol.get(12))%>',
				'<%=Helper.correctNull((String)arrCol.get(13))%>',
			
				
				
				'<%=Helper.correctNull((String)arrCol.get(1))%>')"></td>
				<td width="18%" align="left"><%=Helper.correctNull((String)arrCol.get(2))%></td>
				<td width="13%" align="center"><%=Helper.correctNull((String)arrCol.get(4))%></td>
				<td width="16%" align="left"><%=Helper.correctNull((String)arrCol.get(5))%></td>
				</tr>
			<%}
				}%>
			
			<%}%>
                            </table>
                            
                            </div>
                            </td>
                            </tr>
                    <input type="hidden" name="hidAction" >
  <input type="hidden" name="hidBeanId">
  <input type="hidden" name="hidBeanMethod">
  <input type="hidden" name="hidBeanGetMethod"  >
  <input type="hidden" name="hidSourceUrl" >
  <input type="hidden" name="hidflag" >
  <input type="hidden" name="hideditflag">
  <input type="hidden" name="selsno" value="">
  <input type="hidden" name="hidval" >
  <input type="hidden" name="hiddesc" >
  <INPUT TYPE="hidden" name="trapEdit" >
  <INPUT TYPE="hidden" name="page">
  <INPUT TYPE="hidden" name="hidDemoId" value="">
  <INPUT TYPE="hidden" name="hidAppId" value="<%=Helper.correctNull((String)hshValues.get("appid")) %>">
  </form>                       
</body>
</html>
