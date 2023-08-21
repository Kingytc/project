<%@include file="../share/directives.jsp"%>
<%
ArrayList arrVehSec=(ArrayList)hshValues.get("arrVehSec");
ArrayList arrPropSec=(ArrayList)hshValues.get("arrPropSec");
ArrayList arrCol=new ArrayList();
int intPropSize=0,intVehSize=0;
if(arrVehSec!=null)
	intVehSize=arrVehSec.size();
if(arrPropSec!=null)
	intPropSize=arrPropSec.size();
String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
String strAppId = Helper.correctNull((String)hshValues.get("strappId"));

%>
<head>
<title>Due Diligence Report-General Info</title>
<script type="text/javascript">
var appURL="<%=ApplicationParams.getAppUrl()%>";
var curdate = "<%=Helper.getCurrentDateTime()%>";
function callUsersHelp(val,obj)
{
	var varfields="",varfields1="";
	if(document.forms[0].cmdsave.disabled==false)
	{
		if(document.all.iddate.length==undefined)
		{
			varfields="txt_staffidaccompanied";
			varfields1="txt_accompaniedstaff";
		}
		else
		{
			for(var i=0;i<document.all.iddate.length;i++)
			{
				if(obj==document.all.iddate[i])
				{
					varfields="txt_staffidaccompanied["+i+"]";
					varfields1="txt_accompaniedstaff["+i+"]";
				}
			}
		}
		var pagefield="ddr"+val;
		var varQryString = appURL+"action/setUserSearch.jsp?pagefrom="+pagefield+"&hidField="+varfields+"&hidField1="+varfields1;
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
function doEdit()
{
	disableFields(false);
	disableCommandButtons(true,false,false,false,true);	
	document.forms[0].txt_convertedid.readOnly=true;
	document.forms[0].txt_convertedname.readOnly=true;
}
function disableCommandButtons(cmdedit,cmdsave,cmdcancel,cmddelete,cmdclose)
{
 	document.forms[0].cmdedit.disabled=cmdedit;
	document.forms[0].cmdsave.disabled=cmdsave;
	document.forms[0].cmdcancel.disabled=cmdcancel;
	document.forms[0].cmddelete.disabled=cmddelete;
	document.forms[0].cmdclose.disabled=cmdclose;
}
function disableFields(val)
{
	  for(var i=0;i<document.forms[0].length;i++)
	  {
		  if(document.forms[0].elements[i].type=='text')
		  {
			document.forms[0].elements[i].readOnly=val;
			if(document.forms[0].elements[i].name=='txt_staffidaccompanied' || document.forms[0].elements[i].name=='txt_accompaniedstaff')
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
function doCancel()
{
	if(ConfirmMsg('102'))
	{
		document.forms[0].hidBeanId.value="documentsupport";
		document.forms[0].hidBeanGetMethod.value="getdueReportGeneralInfo";
		document.forms[0].action=appURL+"action/due_report_general.jsp";
		document.forms[0].submit();
	}
}
function callCalender(obj,val)
{
	var varfields;
	if(document.forms[0].cmdsave.disabled==false)
	{
		if(val=="0")
		{
			if(document.all.idrcptdate.length==undefined)
			{
				varfields="txt_invoicerecptdt";
			}
			else
			{
				for(var i=0;i<document.all.idrcptdate.length;i++)
				{
					if(obj==document.all.idrcptdate[i])
					{
						varfields="txt_invoicerecptdt["+i+"]";
					}
				}
			}
		}
		else if(val=="1")
		{
			if(document.all.idrcptdate1.length==undefined)
			{
				varfields="txt_dealerconfirmdate";
			}
			else
			{
				for(var i=0;i<document.all.idrcptdate1.length;i++)
				{
					if(obj==document.all.idrcptdate1[i])
					{
						varfields="txt_dealerconfirmdate["+i+"]";
					}
				}
			}
		}
		else if(val=="2")
		{
			if(document.all.idrcptdate2.length==undefined)
			{
				varfields="txt_verificationdate";
			}
			else
			{
				for(var i=0;i<document.all.idrcptdate2.length;i++)
				{
					if(obj==document.all.idrcptdate2[i])
					{
						varfields="txt_verificationdate["+i+"]";
					}
				}
			}
		}
		showCal(appURL,varfields);
	}
}
function enablemaindealerfields()
{
	if(document.forms[0].txt_dealername.length==undefined)
	{
		if(document.forms[0].sel_subdealer.value=="y")
		{
			document.all.idMaindealer.style.display="table-row";
			document.all.idMaindealer1.style.display="table-row";
			document.all.idMaindealer2.style.display="table-row";
			document.all.idMaindealer3.style.display="table-row";
		}
		else
		{
			document.all.idMaindealer.style.display="none";
			document.all.idMaindealer1.style.display="none";
			document.all.idMaindealer2.style.display="none";
			document.all.idMaindealer3.style.display="none";
		}
	}
	else
	{
		for(var i=0;i<document.forms[0].txt_dealername.length;i++)
		{
			if(document.forms[0].sel_subdealer[i].value=="y")
			{
				document.all.idMaindealer[i].style.display="table-row";
				document.all.idMaindealer1[i].style.display="table-row";
				document.all.idMaindealer2[i].style.display="table-row";
				document.all.idMaindealer3[i].style.display="table-row";
			}
			else
			{
				document.all.idMaindealer[i].style.display="none";
				document.all.idMaindealer1[i].style.display="none";
				document.all.idMaindealer2[i].style.display="none";
				document.all.idMaindealer3[i].style.display="none";
			}
		}
	}
}
function callUsersHelp1(val)
{
	if(document.all.cmdsave.disabled==false)
	{
		var pagefield="ddr"+val;
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
function callOnLoad()
{
	disableFields(true);
	<%if(arrVehSec!=null && arrVehSec.size()>0)
	{
		for(int i=0;i<arrVehSec.size();i++)
		{ 
			arrCol=(ArrayList)arrVehSec.get(i);
			
			if(arrVehSec.size()==1)
			{	%>	
				document.forms[0].sel_authoriseddealer.value="<%=Helper.correctNull((String)arrCol.get(2))%>";
				document.forms[0].sel_subdealer.value="<%=Helper.correctNull((String)arrCol.get(4))%>";
			<%}else{%>
				document.forms[0].sel_authoriseddealer[<%=i%>].value="<%=Helper.correctNull((String)arrCol.get(2))%>";
				document.forms[0].sel_subdealer[<%=i%>].value="<%=Helper.correctNull((String)arrCol.get(4))%>";
			<%}
		}%>
		enablemaindealerfields();
	<%}%>

}
function doSave()
{
	document.forms[0].hidAction.value ="I";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidBeanId.value="documentsupport";
	document.forms[0].hidBeanMethod.value="updatedueReportGeneralInfo";
	document.forms[0].hidBeanGetMethod.value="getdueReportGeneralInfo";
	document.forms[0].hidSourceUrl.value="/action/due_report_general.jsp";
	document.forms[0].submit();
}
function doDelete()
{
	document.forms[0].hidAction.value ="D";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidBeanId.value="documentsupport";
	document.forms[0].hidBeanMethod.value="updatedueReportGeneralInfo";
	document.forms[0].hidBeanGetMethod.value="getdueReportGeneralInfo";
	document.forms[0].hidSourceUrl.value="/action/due_report_general.jsp";
	document.forms[0].submit();
}
function callDDRDetails()
{
	document.forms[0].hidBeanId.value="documentsupport";
	document.forms[0].hidBeanGetMethod.value="getdueReport";
	document.forms[0].action=appURL+"action/due_report.jsp";
	document.forms[0].submit();
}
function callBIRdetails()
{
	document.forms[0].hidBeanId.value="appraisal";
	document.forms[0].hidBeanGetMethod.value="getBIRData";
	document.forms[0].action=appURL+"action/per_bir.jsp";
	document.forms[0].submit();
}
</script>
</head>
<body onload="callOnLoad();">
<form name="appform" method="post" class="normal">

<%if(strSessionModuleType.equals("RET") || strSessionModuleType.equals("DIGI")) { %>

<%if(strSessionModuleType.equals("DIGI")) { %>
<table width="100%" border="0" cellpadding="0" cellspacing="0"
	class="outertable">
	<tr>
		<td id="mainlnk1"><jsp:include page="../share/applurllinkerdigi.jsp"
			flush="true">
			<jsp:param name="pageid" value="10" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">

	<tr>
		<td class="page_flow">Home -&gt; Digi Retail
		-&gt; Appraisal -&gt; Due Diligence Report -&gt; Due Diligence Report
		- New Page</td>
	</tr>
</table>
<% } else { %>
<table width="100%" border="0" cellpadding="0" cellspacing="0"
	class="outertable">
	<tr>
		<td id="mainlnk1"><jsp:include page="../share/Applurllinkper.jsp"
			flush="true">
			<jsp:param name="pageid" value="10" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">

	<tr>
		<td class="page_flow">Home -&gt; Retail(including schematic)
		-&gt; Appraisal -&gt; Due Diligence Report -&gt; Due Diligence Report
		- New Page</td>
	</tr>
</table>
<% } %>
<span style="display: none;"><lapschoice:borrowertype /></span> <lapschoice:application />

<table width="100%" border="0" cellpadding="0" cellspacing="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../share/apprlinktab.jsp" flush="true">
			<jsp:param name="tabid" value="10" />
		</jsp:include></td>
	</tr>
</table>
<table width="30%" border="0" cellspacing="0" cellpadding="0" class="outertable">
<tr>
	<td>
		<table width="100%" border="0" cellspacing="1" cellpadding="3" align="left" class="outertable">
		<tr align="center">
			<td width="50%" class="sub_tab_inactive">
				<a href="JavaScript:callDDRDetails();">Due Diligence - Applicant Info</a>
			</td>
			<td width="50%" class="sub_tab_active" nowrap="nowrap">Due Diligence - Security Info</td>
		</tr>
		</table>
	</td>
</tr>
</table>

<% } else{ %>    

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
	  <td class="page_flow">Home-&gt; Agriculture -&gt;Application -&gt; Due Diligence Report (Security Info) </td>
	  <%}else{ %>
	  <td class="page_flow">Home-&gt; Corporate & SME -&gt;Application -&gt; Due Diligence Report (Security Info)</td>
	  <%} %>
	</tr>
 </table>
 
    <span style="display:none;"><lapschoice:borrowertype /></span> <lapschoice:application/>
 
 <table width="60%" border="0" cellspacing="0" cellpadding="0" class="outertable">
<tr>
	<td>
		<table width="100%" border="0" cellspacing="1" cellpadding="3" align="left" class="outertable">
		<tr align="center">
			<td width="30%" class="sub_tab_inactive">
				<a href="JavaScript:callDDRDetails();">Due Diligence - Applicant Info</a>
			</td>
			<td width="30%" class="sub_tab_active" nowrap="nowrap">Due Diligence - Security Info</td>
			<td width="50%" class="sub_tab_inactive">
			<a href="JavaScript:callBIRdetails();">Background Information Report(BIR)</a></td>
		</tr>
		</table>
	</td>
</tr>
</table>

   <% }  %>
<br>
<table width="95%" border="0" cellpadding="3" cellspacing="0"
	class="outertable border1">
	<tr>
		<td>
		<%if(arrPropSec!=null && arrPropSec.size()>0){%> 
		<table width="98%" border="0" cellpadding="3" cellspacing="0"
			class="outertable" align="center">
			<tr class="dataheader">
				<td>Security - Property</td>
			</tr>
			<tr>
			<td>
			<table width="98%" border="0" cellpadding="3" cellspacing="0"
			class="outertable">
			<%for(int i=0;i<arrPropSec.size();i++) {
			arrCol=(ArrayList)arrPropSec.get(i);%>
				<tr>
				<td colspan="2" class="datagrid">Security ID :<%=Helper.correctNull((String)arrCol.get(0)) %>&nbsp;
				<input type="hidden" name="hid_propsecid" value="<%=Helper.correctNull((String)arrCol.get(0)) %>"/>
				<input type="hidden" name="hid_propsectype" value="<%=Helper.correctNull((String)arrCol.get(1)) %>"/>
				</td>
				</tr>
				<tr>
				<td>Observation on CERSAI verification</td>
				<td><textarea name="txt_cersai_verification" cols="40" rows="3" onKeyPress="textlimit(this,499)" onkeyup="textlimit(this,499)"><%=Helper.correctNull((String)arrCol.get(2)) %></textarea></td>
				</tr>
				<tr>
				<td>The description of property as per Valuer's report (including area and boundary of property)</td>
				<td><textarea name="txt_propdesc_vr" cols="40" rows="3" onkeyup="textlimitcorp1(this,500);" onkeydown="textlimitcorp1(this,500);"><%=Helper.correctNull((String)arrCol.get(3)) %></textarea></td>
				</tr>
				<tr>
				<td>The description of property as per legal opinion (including measurement/location/boundary of property)</td>
				<td><textarea name="txt_propdesc_lo" cols="40" rows="3" onkeyup="textlimitcorp1(this,500);" onkeydown="textlimitcorp1(this,500);"><%=Helper.correctNull((String)arrCol.get(4)) %></textarea></td>
				</tr>
				<tr>
				<td>Reason for variation(if any), pertaining to description of property</td>
				<td><textarea name="txt_propdesc_diff" cols="40" rows="3" onKeyPress="textlimit(this,499)" onkeyup="textlimit(this,499)"><%=Helper.correctNull((String)arrCol.get(5)) %></textarea></td>
				</tr>
				<tr>
				<td>Name of the officer who has accompanied the valuer.</td>
				<td><input type="text" name="txt_staffidaccompanied" size="15" value="<%=Helper.correctNull((String)arrCol.get(6)) %>" readonly="readonly">
							<input type="text" name="txt_accompaniedstaff" value="<%=Helper.correctNull((String)arrCol.get(7)) %>">
							<a href="#" onClick="javascript:callUsersHelp('1',this)" id="iddate">
							<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0"> </a></td>
				</tr>
				<%} %>
			</table>
			</td>
			</tr>
		</table>
		<%} %>
		</td>
	</tr>
	<tr>
	<td>
	<%if(arrVehSec!=null && arrVehSec.size()>0){ %>
	<table width="98%" border="0" cellpadding="3" cellspacing="0"
			class="outertable" align="center">
			<tr class="dataheader">
				<td>Security - Vehicle/Machinery</td>
			</tr>
			<tr>
			<td>
			<table width="98%" border="0" cellpadding="3" cellspacing="0"
			class="outertable">
			<%for(int i=0;i<arrVehSec.size();i++){ 
			arrCol=(ArrayList)arrVehSec.get(i);%>
			<tr>
				<td colspan="2" class="datagrid">Security ID :<%=Helper.correctNull((String)arrCol.get(0)) %>&nbsp;
				<input type="hidden" name="hid_vehsecid" value="<%=Helper.correctNull((String)arrCol.get(0)) %>"/>
				<input type="hidden" name="hid_vehsectype" value="<%=Helper.correctNull((String)arrCol.get(1)) %>"/>
				</td>
				</tr>
			<tr>
			<td>Whether dealer's name is appearing in the list of authorised dealers</td>
			<td>
			<select name="sel_authoriseddealer">
			<option value=""><--Select--></option>
			<option value="y">Yes</option>
			<option value="n">No</option>
			</select>
			</td>
			</tr>
			<tr>
			<td>Date of genuineness of the Invoice/Advance payment receipts produced have been ascertained by contacting the dealer</td>
			<td> 
			<input type="text" name="txt_invoicerecptdt" onBlur="checkDate(this);checkmaxdate(this,curdate);"
						value="<%=Helper.correctNull((String)arrCol.get(3))%>" size="15" alt="Select date from calender" href="#">
						<a style="vertical-align: middle" onClick="callCalender(this,'0')" id="idrcptdate"
						onMouseOver="window.status='Date Picker';return true;"
						onMouseOut="window.status='';return true;"><img
						src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
						alt="Select date from calender"></a>&nbsp;&nbsp;
			</td>
			</tr>
			<tr>
			<td>Whether Dealer is Sub Dealer?</td>
			<td><select name="sel_subdealer" onchange="enablemaindealerfields();">
			<option value=""><--select--></option>
			<option value="y">Yes</option>
			<option value="n">No</option>
			</select></td>
			</tr>
			<tr id="idMaindealer" style="display: none;">
			<td>Main Dealer Name</td>
			<td><input type="text" name="txt_dealername" size="15" maxlength="25" value="<%=Helper.correctNull((String)arrCol.get(5))%>"></td>
			</tr>
			<tr id="idMaindealer1" style="display: none;">
			<td>Contact Details of the Main Dealer</td>
			<td><textarea name="txt_dealeraddress" cols="40" rows="3" onKeyPress="textlimit(this,199)" onkeyup="textlimit(this,199)"><%=Helper.correctNull((String)arrCol.get(6))%></textarea></td>
			</tr>
			<tr id="idMaindealer2" style="display: none;">
			<td>Date of Confirmation obtained from main dealer about the sub dealer</td>
			<td> 
			<input type="text" name="txt_dealerconfirmdate" onBlur="checkDate(this);"
						value="<%=Helper.correctNull((String)arrCol.get(7))%>" size="15" alt="Select date from calender" href="#">
						<a style="vertical-align: middle" onClick="callCalender(this,'1')"  id="idrcptdate1"
						onMouseOver="window.status='Date Picker';return true;"
						onMouseOut="window.status='';return true;"><img
						src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
						alt="Select date from calender"></a>&nbsp;&nbsp;
			</td>
			</tr>
			<tr id="idMaindealer3" style="display: none;">
			<td>TIN No. of the sub dealer</td>
			<td><input type="text" name="txt_tinno" size="15" maxlength="15" value="<%=Helper.correctNull((String)arrCol.get(8))%>"></td>
			</tr>
			<tr>
			<td>How the mode of repayment is independently ascertained(In case of reimbursement)</td>
			<td><textarea name="txt_modeofrepayment" cols="40" rows="3" onKeyPress="textlimit(this,499)" onkeyup="textlimit(this,499)"><%=Helper.correctNull((String)arrCol.get(9))%></textarea></td>
			</tr>
			<tr>
			<td>Date of verification of The Vehicle No., Chassis No. and Engine No. mentioned in the RC Book and valuation report shall be duly verified</td>
			<td> 
			<input type="text" name="txt_verificationdate" onBlur="checkDate(this);"
						value="<%=Helper.correctNull((String)arrCol.get(10))%>" size="15" alt="Select date from calender" href="#">
						<a style="vertical-align: middle" onClick="callCalender(this,'2')"  id="idrcptdate2"
						onMouseOver="window.status='Date Picker';return true;"
						onMouseOut="window.status='';return true;"><img
						src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
						alt="Select date from calender"></a>&nbsp;&nbsp;
			</td>
			</tr>
			<%} %>
			</table>
			</td>
			</tr>
		</table>
		<%} %>
	</td>
	</tr>
	
	<tr>
		<td>
		<table width="98%" border="0" cellpadding="3" cellspacing="0"
			class="outertable" align="center">
			<tr class="dataheader">
				<td>GENERAL OPINION (Market Intelligence Report)</td>
			</tr>
			<tr>
			<td>
			<table width="98%" border="0" cellpadding="3" cellspacing="0"
			class="outertable">
			<tr>
             	<td>Market report about the borrower</td>
             	<td><textarea name="txt_market_report" cols="40" rows="3" onKeyPress="textlimit(this,499)" onkeyup="textlimit(this,499)" ><%=Helper.correctNull((String)hshValues.get("strMarketReport"))%></textarea></td>
            </tr>
            <tr> 	
            	<td>Enquiry Made with :</td>
             	<td><textarea name="txt_enq_name" cols="40" rows="3" onkeyup="textlimitcorp1(this,500);" onkeydown="textlimitcorp1(this,500);"><%=Helper.correctNull((String)hshValues.get("strEnquiremadewith"))%></textarea></td>
            </tr>
            <tr> 	
            	<td>Contact No</td>
             	<td><input type="text" name="txt_enq_contactno" onkeypress="allowPhone()" value="<%=Helper.correctNull((String)hshValues.get("strContactno")) %>"></td>
            </tr>
            <tr>
             	<td>Opinion about the borrower/s</td>
             	<td><textarea name="txt_opin_borr" cols="40" rows="3" onKeyPress="textlimit(this,499)" onkeyup="textlimit(this,499)"><%=Helper.correctNull((String)hshValues.get("stropionionabtbor"))%></textarea></td>
            </tr>
            <tr>
             	<td>Due diligence conducted by</td>
            	<td><input type="text" name="txt_convertedid" size="10" value="<%=Helper.correctNull((String)hshValues.get("strDDRcontactedby"))%>" readonly="readonly">
				<input type="text" name="txt_convertedname" size="30" value="<%=Helper.correctNull((String)hshValues.get("strDDRcontactedbyName"))%>">
				<a href="#" onClick="javascript:callUsersHelp1('2')">
				<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0"> </a>
				</td>
            </tr>
			</table>
			</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br/>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete'
	btnenable='<%=Helper.correctNull((String) request
							.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>' />
<input type="hidden" name="hidPropCnt" value="<%=intPropSize %>">
<input type="hidden" name="hidVehCnt" value="<%=intVehSize %>">
</form>
</body>
</html>
