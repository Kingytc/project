<%@ include file="../share/directives.jsp"%>
<%
	ArrayList g1 = new ArrayList();
	String strFromLink = Helper.correctNull((String) request.getParameter("strfrom"));
	String strvalue = Helper.correctNull((String) hshValues.get("svalue"));
%>
<html>
<title>LAPS: Lawyer Master</title>
<head>
<style type="text/css">
DIV.cellContainer 
{	
  width: 100%; height: 200;
  overflow: auto;
}
</style>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>

<SCRIPT LANGUAGE="JavaScript">	
var from_link = "<%=strFromLink%>";	
var appUrl="<%=ApplicationParams.getAppUrl()%>";
	
function onselect1()
	{
	if (document.forms[0].selradio[0].checked==true)
		{
		document.forms[0].stype.value = document.forms[0].selradio[0].value
		}		
	document.forms[0].txt_ser.disabled = false
	document.forms[0].txt_ser.focus();		
	}
	
function searchData()
	{
	if(trim(document.forms[0].txt_ser.value)=="")
		{
		ShowAlert(121,'Name');
		document.forms[0].txt_ser.focus();
		return;
		}	
	document.forms[0].hidBeanId.value="staticdata";
	document.forms[0].hidAction.value="search";
	document.forms[0].hidBeanGetMethod.value="getLawyerMasterList";
	document.forms[0].stype.value ="N"; 
	document.forms[0].svalue.value = document.forms[0].txt_ser.value; 
	
	document.forms[0].action=appUrl+"action/lawyermasterlist.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
	}
	
function getSelectedValue(val1, val2, val3, val4, val5, val6, val7, val8, val9, 
						val10, val11, val12, val13, val14, val15, val16, val17, 
						val18, val19, val20, val21, val22, val23, val24, val25, val26,val27)
{
	if(from_link.toUpperCase() == "LAWYERMASTER")
	{
		if(val22=="Y")
		{
			alert(val3 +" is Blacked List");
			/*window.opener.document.forms[0].hidsno.value = "";
			window.opener.document.forms[0].txt_name.value="";
			window.opener.document.forms[0].txt_address1.value="";
			window.opener.document.forms[0].txt_address2.value = "";	
			window.opener.document.forms[0].txt_address3.value ="";			
			window.opener.document.forms[0].txt_city.value = "";
			window.opener.document.forms[0].txt_state.value = "";
			window.opener.document.forms[0].txt_zip.value = "";
			window.opener.document.forms[0].txt_country.value = "";
			window.opener.document.forms[0].txt_offphone.value = "";	
			window.opener.document.forms[0].txt_offfaxno.value = "";
			window.opener.document.forms[0].txt_resphone.value = "";
			window.opener.document.forms[0].txt_resmobileno.value = "";
			window.opener.document.forms[0].txt_contactperson.value = "";
			window.opener.document.forms[0].txt_contactmobilephone.value = "";
			window.opener.document.forms[0].txt_desig.value = "";		
			window.opener.document.forms[0].txt_emailid.value = "";		
			window.opener.document.forms[0].txt_empaneledon.value = "";
			window.opener.document.forms[0].txt_action.value = "";	
			window.opener.document.forms[0].txt_comments.value = "";
			window.opener.document.forms[0].txt_desig1.value = "";
			window.opener.document.forms[0].sel_blacklist.value = "";
			window.opener.document.forms[0].txt_blacklistdate.value = "";
			return;*/
			window.opener.document.forms[0].org_code.value = val1;
			window.opener.document.forms[0].hidExorgcode.value = val1;
			window.opener.document.forms[0].hidsno.value = val2;
			window.opener.document.forms[0].txt_name.value=val3;
			window.opener.document.forms[0].txt_address1.value=val4;
			window.opener.document.forms[0].txt_address2.value = val5;	
			window.opener.document.forms[0].txt_address3.value = val6;			
			window.opener.document.forms[0].hidcity.value = val7;
			window.opener.document.forms[0].hidstate.value = val8;
			window.opener.document.forms[0].txt_zip.value = val9;
			window.opener.document.forms[0].txt_country.value = val10;
			window.opener.document.forms[0].txt_offphone.value = val11;		
			window.opener.document.forms[0].txt_offfaxno.value = val12;
			window.opener.document.forms[0].txt_resphone.value = val13;
			window.opener.document.forms[0].txt_resmobileno.value = val14;
			window.opener.document.forms[0].txt_contactperson.value = val15;
			window.opener.document.forms[0].txt_contactmobilephone.value = val16;
			//window.opener.document.forms[0].txt_desig.value = val17;		
			window.opener.document.forms[0].txt_emailid.value = val18;
			window.opener.document.forms[0].txt_empaneledon.value = val19;
			window.opener.document.forms[0].txt_action.value = val20;		
			window.opener.document.forms[0].txt_comments.value = val21;	
			window.opener.document.forms[0].txt_desig1.value = val17;
			window.opener.document.forms[0].hidseqno.value = val26;
			window.opener.document.forms[0].hidmastid.value = val26;
			window.opener.document.forms[0].sel_blacklist.value = val22;
			if(val22=="N")
			{
				window.opener.document.all.t1.style.visibility="hidden";	
				window.opener.document.all.t2.style.visibility="hidden";		
				window.opener.document.forms[0].txt_blacklistdate.value ="";
			}
			else
			{
				window.opener.document.forms[0].txt_blacklistdate.value = val23;		
			}
			window.opener.document.forms[0].txt_city.value = val24;
			window.opener.document.forms[0].txt_state.value = val25;
			window.opener.enableButtons(true, true, true, true, true);
		
			if(window.opener.document.frmlawyermast.sel_blacklist.value=="Y")
	        {
				window.opener.document.all.t1.style.visibility="Visible";
				window.opener.document.all.t2.style.visibility="Visible";	
				if(window.opener.document.frmlawyermast.txt_blacklistdate.value=="01/01/1900")
				{
					window.opener.document.frmlawyermast.txt_blacklistdate.value="";
				}
	        }
			else if(window.opener.document.frmlawyermast.sel_blacklist.value=="N")
			{
				window.opener.document.all.t1.style.visibility="hidden";	
				window.opener.document.all.t2.style.visibility="hidden";			
			}
			window.close();
		}
		else
		{
			window.opener.document.forms[0].org_code.value = val1;
			window.opener.document.forms[0].hidExorgcode.value = val1;
			window.opener.document.forms[0].hidsno.value = val2;
			window.opener.document.forms[0].txt_name.value=val3;
			window.opener.document.forms[0].txt_address1.value=val4;
			window.opener.document.forms[0].txt_address2.value = val5;	
			window.opener.document.forms[0].txt_address3.value = val6;			
			window.opener.document.forms[0].hidcity.value = val7;
			window.opener.document.forms[0].hidstate.value = val8;
			window.opener.document.forms[0].txt_zip.value = val9;
			window.opener.document.forms[0].txt_country.value = val10;
			window.opener.document.forms[0].txt_offphone.value = val11;		
			window.opener.document.forms[0].txt_offfaxno.value = val12;
			window.opener.document.forms[0].txt_resphone.value = val13;
			window.opener.document.forms[0].txt_resmobileno.value = val14;
			window.opener.document.forms[0].txt_contactperson.value = val15;
			window.opener.document.forms[0].txt_contactmobilephone.value = val16;
			//window.opener.document.forms[0].txt_desig.value = val17;		
			window.opener.document.forms[0].txt_emailid.value = val18;
			window.opener.document.forms[0].txt_empaneledon.value = val19;
			window.opener.document.forms[0].txt_action.value = val20;		
			window.opener.document.forms[0].txt_comments.value = val21;	
			window.opener.document.forms[0].txt_desig1.value = val17;
			window.opener.document.forms[0].hidseqno.value = val26;
			window.opener.document.forms[0].hidmastid.value = val26;
			window.opener.document.forms[0].sel_blacklist.value = val22;
			if(val22=="N")
			{
				window.opener.document.all.t1.style.visibility="hidden";	
				window.opener.document.all.t2.style.visibility="hidden";		
				window.opener.document.forms[0].txt_blacklistdate.value ="";
			}
			else
			{
				window.opener.document.forms[0].txt_blacklistdate.value = val23;		
			}
			window.opener.document.forms[0].txt_city.value = val24;
			window.opener.document.forms[0].txt_state.value = val25;
			window.opener.document.forms[0].sel_elitepanel.value = val27;
			window.opener.document.forms[0].hidelitepanel.value = val27;
			window.opener.enableButtons(true, false, true, true, false);
			window.close();
		}	
	}
	else if(from_link == "LegalOpinion")
	{
		if(val22=="Y")
		{
			alert(val3 +" is Blacked List");
			window.opener.document.forms[0].hid_sno.value = "";
			window.opener.document.forms[0].TxtLawDet.value= "";
			window.opener.document.forms[0].TxtDesign.value= "";
			return;
		}
		else
		{			
			window.opener.document.forms[0].hid_sno.value = val26;
			window.opener.document.forms[0].TxtLawDet.value=val3;
			window.opener.document.forms[0].TxtDesign.value=val17;
			window.close();
		}	
	}
	 else if(from_link == "Status SuitFiled")
	{	
		var Lawaddress=val4+""+val5+""+val6+"\n"+val25+"\n"+val26+"\n"+val10+"\n"+val9;
		if(val22=="Y")
		{
			window.opener.document.forms[0].txt_advocatename.value= "";
			window.opener.document.forms[0].txt_advocateaddress.value="";
			window.opener.document.forms[0].txt_phoneno.value="";
			window.opener.document.forms[0].hid_advocateid.value="";
			return;
		}
		else
		{		
			window.opener.document.forms[0].txt_advocatename.value=val3;
			window.opener.document.forms[0].txt_advocateaddress.value=Lawaddress;
			window.opener.document.forms[0].txt_phoneno.value=val11;
			window.opener.document.forms[0].hid_advocateid.value=val26;
			window.close();
		}
	}	
}
function doClose()
{
	window.close();
}
</SCRIPT>
</head>
<body >
<form name="productlisthelp" method="post" class="normal">
<div>
<table width="95%" border="0" cellspacing="0" cellpadding="3"
	align="center" class="outertable">
	<tr>
		<td><br>
		<table width="100%" border="0" cellspacing="0" cellpadding="3"
			class="outertable" align="center">
			<tr>
				<td><b>Search </b>
				<table border="0" cellspacing="0" cellpadding="3" width="100%" align="center" class="outertable">
					<tr>
						<td width="30%">Lawyer Name
						<td width="30%"><input type="text" name="txt_ser" maxlength="40"
							size="40" value="<%=strvalue%>" tabindex="1"
							onKeyPress="notAllowSplChar()"></td>
						<td width="40%" align="center"><input type=button
							class="buttonStyle" value="Search" name="search" tabindex="2"
							onClick="searchData()"></td>
					</tr>
				</table>
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
				class="outertable">
					<tr>
						<td>
						<table width="97%" border="0" cellspacing="1" cellpadding="3"
							class="outertable">
							<tr class="dataheader">
								<td width="15%"><b>Sl. No.</b></td>
								<td width="85%"><b>Lawyer Name </b></td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				<%ArrayList v = (ArrayList) hshValues.get("vecRow");if(v.size()>6){ %><div class="cellContainer"><%} %>
				<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
					<%
			String inside = "N";
			int i=0;
			if (v != null) 
			{
				int vecsize = v.size();
				for (int l = 0; l < vecsize; l++) 
				{
					inside = "Y";
					g1 = (ArrayList) v.get(l);
					if(strFromLink.equalsIgnoreCase("LAWYERMASTER"))
					{
					%>
					<tr valign="top" class="datagrid">
						<td width="15%" align="left"><%=l + 1%>&nbsp;</td>
						<td width="85%" align="left"><a
							href="javascript:getSelectedValue(
		                    '<%=Helper.correctNull((String)g1.get(0))%>','<%=Helper.correctNull((String)g1.get(1))%>',
		                    '<%=Helper.correctDoubleQuotesHtml(Helper.replaceForJavaScriptString((String)g1.get(2)))%>','<%=Helper.correctDoubleQuotesHtml(Helper.replaceForJavaScriptString((String)g1.get(3)))%>',
		                    '<%=Helper.correctDoubleQuotesHtml(Helper.replaceForJavaScriptString((String)g1.get(4)))%>','<%=Helper.correctDoubleQuotesHtml(Helper.replaceForJavaScriptString((String)g1.get(5)))%>',
		                    '<%=Helper.correctNull((String)g1.get(6))%>','<%=Helper.correctNull((String)g1.get(7))%>',
		                    '<%=Helper.correctNull((String)g1.get(8))%>','<%=Helper.correctNull((String)g1.get(9))%>',
		                    '<%=Helper.correctNull((String)g1.get(10))%>','<%=Helper.correctNull((String)g1.get(11))%>',
		                    '<%=Helper.correctNull((String)g1.get(12))%>','<%=Helper.correctNull((String)g1.get(13))%>',
		                    '<%=Helper.correctDoubleQuotesHtml(Helper.replaceForJavaScriptString((String)g1.get(14)))%>','<%=Helper.correctNull((String)g1.get(15))%>',
		                    '<%=Helper.correctNull((String)g1.get(16))%>','<%=Helper.correctNull((String)g1.get(17))%>',
		                    '<%=Helper.correctNull((String)g1.get(18))%>','<%=Helper.correctNull((String)g1.get(19))%>',
		                    '<%=Helper.correctDoubleQuotesHtml(Helper.replaceForJavaScriptString(Helper.correctNull((String)g1.get(20))))%>','<%=Helper.correctNull((String)g1.get(21))%>',
		                    '<%=Helper.correctNull((String)g1.get(22))%>','<%=Helper.correctNull((String)g1.get(23))%>',
		                    '<%=Helper.correctNull((String)g1.get(24))%>','<%=Helper.correctNull((String)g1.get(25))%>',
		                    '<%=Helper.correctNull((String)g1.get(26))%>')"
							 align="center"><b><%=Helper.correctNull((String) g1
											.get(2))%></b></a></td>
					</tr>
					<%
					}
					else
					{
						if(Helper.correctNull((String)g1.get(19)).equalsIgnoreCase("1"))
						{
					%>
							<tr valign="top" class="datagrid">
								<td width="15%" align="left"><%=++i%>&nbsp;</td>
								<td width="85%" align="left"><a
									href="javascript:getSelectedValue(
				                    '<%=Helper.correctNull((String)g1.get(0))%>','<%=Helper.correctNull((String)g1.get(1))%>',
				                    '<%=Helper.correctDoubleQuotesHtml(Helper.replaceForJavaScriptString((String)g1.get(2)))%>','<%=Helper.correctDoubleQuotesHtml(Helper.replaceForJavaScriptString((String)g1.get(3)))%>',
				                    '<%=Helper.correctDoubleQuotesHtml(Helper.replaceForJavaScriptString((String)g1.get(4)))%>','<%=Helper.correctDoubleQuotesHtml(Helper.replaceForJavaScriptString((String)g1.get(5)))%>',
				                    '<%=Helper.correctNull((String)g1.get(6))%>','<%=Helper.correctNull((String)g1.get(7))%>',
				                    '<%=Helper.correctNull((String)g1.get(8))%>','<%=Helper.correctNull((String)g1.get(9))%>',
				                    '<%=Helper.correctNull((String)g1.get(10))%>','<%=Helper.correctNull((String)g1.get(11))%>',
				                    '<%=Helper.correctNull((String)g1.get(12))%>','<%=Helper.correctNull((String)g1.get(13))%>',
				                    '<%=Helper.correctDoubleQuotesHtml(Helper.replaceForJavaScriptString((String)g1.get(14)))%>','<%=Helper.correctNull((String)g1.get(15))%>',
				                    '<%=Helper.correctNull((String)g1.get(16))%>','<%=Helper.correctNull((String)g1.get(17))%>',
				                    '<%=Helper.correctNull((String)g1.get(18))%>','<%=Helper.correctNull((String)g1.get(19))%>',
				                    '<%=Helper.correctNull((String)g1.get(20))%>','<%=Helper.correctNull((String)g1.get(21))%>',
				                    '<%=Helper.correctNull((String)g1.get(22))%>','<%=Helper.correctNull((String)g1.get(23))%>',
				                    '<%=Helper.correctNull((String)g1.get(24))%>','<%=Helper.correctNull((String)g1.get(25))%>',
				                    '<%//=Helper.correctNull((String)g1.get(26))%>')"
									 align="center"><b><%=Helper.correctNull((String) g1.get(2))%></b></a></td>
							</tr>
				<%
						}
				 }
				}
			}
			%>

					<%if (inside.equals("N")) {

			%>
					
					<tr valign="top" class="datagrid">
						<td colspan="2" width="15%" align="center"><b>No Data Found </b>
					</tr>

					<%}%>
				</table>
				<%if(v.size()>6){ %></div><%} %>
		</table>
		</td>
	</tr>
</table>
<br>
<lapschoice:combuttonnew 
	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
</div>
<input type="hidden" name="svalue" value="<%=Helper.correctNull((String)hshValues.get("svalue"))%>"> 
<input type="hidden" name="stype" value="<%=Helper.correctNull((String)hshValues.get("scode"))%>"> 
<input type="hidden" name="strfrom" value="<%=strFromLink%>"> 
<input type="hidden" name="org_name" value="<%=session.getAttribute("strOrgName")%>"> 
<input type="hidden" name="org_code" value="<%=session.getAttribute("strOrgCode")%>">
<input type="hidden" name="namevalue" value="<%=session.getAttribute("strnamevalue")%>">
 <lapschoice:hiddentag pageid='<%=PageId%>'/> 
</form>
</body>
</html>

