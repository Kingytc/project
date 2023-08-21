<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />

<%ArrayList arrValues = new ArrayList();

			if (hshValues != null) {
				arrValues = (ArrayList) hshValues.get("arrCust");
			}

			%>
<html>
<head>
<title>Application Inward Number Search</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
DIV.cellContainer 
{	
  width: 100%; height: 200;
  overflow: auto;
}
</style>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";


	function callSearch()
	{
		var value = document.forms[0].txt_value.value;
		if(value == "")
		{
			return false;
		}
		if(callack())
		{
			document.forms[0].method="post";
			document.forms[0].hidBeanMethod.value="getInwardnoList";
			document.forms[0].hidBeanId.value="inwardRegister";
			document.forms[0].action=appURL+"action/searchAppinwradnolist.jsp";	
			document.forms[0].submit();
		}
	}
	
	function callack()
	{
		var txtval=document.forms[0].txt_value.value;
		var txtlen=txtval.length;
	 
		if(document.forms[0].radiobutton[0].checked==true)
		{
			 if(txtlen<=2)
			 {
				 alert("Enter atleast 3 characters");
			     document.forms[0].txt_value.focus();
			     return false;
		
			 }
		}
		if(document.forms[0].radiobutton[1].checked==true)
		{
			 if(txtlen<1)
			 {
				 alert("Enter atleast 1 characters");
			     document.forms[0].txt_value.focus();
			     return false;
		
			 }
		}
	return true;
	}
	
	function ClearFields()
	{
		for(var i=0;i<document.forms[0].elements.length;i++)
		{
			if(document.forms[0].elements[i].type=="text")
			{
				  document.forms[0].elements[i].value="";		  
			}		
			else if(document.forms[0].elements[i].type=="textarea")
			{
				document.forms[0].elements[i].value="";		  
			}
		}
	}

	function setValues(val1,val2,val3,val4,val5,val6,val7,val8,val9,val10,val11,val12,val13,val14,val15,val16,val17,val18,val19,val20,val21,val22,val23,val24,val25,val26,val27,val28,val29,val30,val31)
	{
		window.opener.document.forms[0].txt_inwardno.value = val1;//ack_no
		window.opener.document.forms[0].txt_date1.value = val2;//filled_date
		window.opener.document.forms[0].txt_appdate.value = val3;//App_date
		window.opener.document.forms[0].txt_comncustame.value = val4;//customer_name
		window.opener.document.forms[0].txt_comcustadd1.value = val5;//customer_add1
		window.opener.document.forms[0].txt_comcustadd2.value = val6;//customer_add2
		window.opener.document.forms[0].hidcity.value = val7;//customer_city
		window.opener.document.forms[0].hidstate.value = val8;//customer_state
		window.opener.document.forms[0].txtcomcust_zip.value = val9;//customer_pin
		window.opener.document.forms[0].txtcomcust_phone.value = val10;//customer_phone
		window.opener.document.forms[0].txtcomcust_mobile.value = val11;//customer_mobile
		window.opener.document.forms[0].txtcomcust_email.value = val12;//customer_email
		window.opener.document.forms[0].txt_comDOB.value = val13;//customer_DOB
		window.opener.document.forms[0].txtcomcust_pan.value = val14;//customer_pan
		window.opener.document.forms[0].txt_comloanpur.value = val15;//customer_loanpurpose
		window.opener.document.forms[0].txt_retschemedesc1.value = val16;//retail_schemedesc
		
		window.opener.document.forms[0].area_details.value = val20;
		window.opener.document.forms[0].txt_receidate.value = val21;
		window.opener.document.forms[0].seldocrecd.value = val22;
		window.opener.document.forms[0].selappcreation.value = val23;
		window.opener.document.forms[0].hidtype.value = val24;
		if(val24=="p")
		{
			window.opener.document.forms[0].choose_type[0].checked="true";
			window.opener.settype('Retail');
			window.opener.document.forms[0].txtret_ftf.value = val17;//retail_termloan
		}
		else if(val24=="a")
		{
			window.opener.document.forms[0].choose_type[1].checked="true";
			window.opener.settype('Agri');
			window.opener.document.forms[0].txtret_ftf.value = val17;//retail_termloan
		}
		else if(val24=="t")
		{
			window.opener.document.forms[0].choose_type[2].checked="true";
			window.opener.settype('Tertiary');
			window.opener.document.forms[0].txtcomcust_ftf.value = val17;//retail_termloan
			window.opener.document.forms[0].txtcomcust_fwc.value = val18;//fund_workingcapital
			window.opener.document.forms[0].txtcomcust_nf.value = val19;//nonfund
		}
		else if(val24=="c")
		{
			window.opener.document.forms[0].choose_type[3].checked="true";
			window.opener.settype('Corp');
			window.opener.document.forms[0].txtcomcust_ftf.value = val17;//retail_termloan
			window.opener.document.forms[0].txtcomcust_fwc.value = val18;//fund_workingcapital
			window.opener.document.forms[0].txtcomcust_nf.value = val19;//nonfund
		}
		window.opener.document.forms[0].txt_comcustcity.value = val25;
		window.opener.document.forms[0].txtcomcust_state.value = val26;
		window.opener.document.forms[0].selcusttype.value = val29;
		window.opener.document.forms[0].txt_cbscustid.value = val30;
		window.opener.document.forms[0].selapplied.value = val31;
		
		window.opener.document.forms[0].hidoldtype.value = val24;
		window.opener.document.forms[0].hidoldapplied.value = val31;
		window.opener.document.forms[0].hidoldappcreation.value = val23;
		window.opener.showcustid();
		window.opener.applied();
		if(val27=="N" && val28=="O")
		{
			window.opener.enableButtons(true,false,true,false,true,false,true);
		}
		else
		{
			window.opener.enableButtons(true,true,true,true,true,false,true);
		}
		window.close();
	}

	function callReset()
	{
		document.forms[0].txt_value.value==""
	}


	
	function checkRadioButton(val)
	{
		if(document.forms[0].radiobutton[0].checked==true)
		{
			notAllowSplChar(val);
			document.forms[0].hidvalue.value="name";
		}
		else
		{
			allowInteger(val);
			document.forms[0].hidvalue.value="no";
		}
	}
	function onRadioClick()
	{
	 document.forms[0].txt_value.value="";
	 document.forms[0].txt_value.focus();
	}
    
</SCRIPT>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css"
	type="text/css">
</head>
<body bgcolor="#EEEAE3" text="#000000" vlink="#330000" alink="#330000"
	leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<jsp:include page="../share/help.jsp" flush="true"/>

<form name="appform" method="post">
<table width="98%" border="0" cellspacing="0" cellpadding="0"
	align="center">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td><b>Application Inward Number Search</b></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>

<table width="98%" border="0" cellpadding="5" cellspacing="0"
	class="outertable border1"
	align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="1">
			<tr>
				<td>

				<table width="100%" border="0" cellspacing="0" cellpadding="1">
					<tr>
						<td align="right" width="5%"><INPUT TYPE="radio"
							NAME="radiobutton" VALUE="bname" STYLE="border-style:none"
							ONCLICK="onRadioClick()"></td>
						<td align="right" width="8%"><FONT FACE="MS Sans Serif" SIZE="1"><b>Name</b></FONT></td>
						<td align="right" width="5%"><INPUT TYPE="radio"
							NAME="radiobutton" VALUE="bid" STYLE="border-style:none"
							ONCLICK="onRadioClick()"></td>
						<td align="right" width="22%"><b>Application Inward No.</b></td>
						<td width="25%" align="center"><input type="text" name="txt_value"
							size="25" maxlength="70" value=""
							onKeyPress="checkRadioButton('txt_value')"></td>

						<td width="35%"><input type="button" name="cmdsearch"
							value="Search"
							style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"
							onClick="callSearch()"></td>
					</tr>
					<tr>

						<td nowrap colspan="3">&nbsp;</td>

					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					bordercolorlight="#EBEBF8" bordercolordark="#82829F">
					<tr>
						<td valign="top">
						<table width="100%" border="0" cellspacing="1" cellpadding="3"
							bordercolorlight="#FFFFFB" bordercolordark="#DEDACF">
							<tr bgcolor="#71694F">
								<td width="10%"><font face="MS Sans Serif" size="1"
									color="#FFFFFF"><b>Sno</b></font></td>

								<td width="45%"><font face="MS Sans Serif" size="1"
									color="#FFFFFF"><b>Name</b></font></td>


								<td width="45%"><font face="MS Sans Serif" size="1"
									color="#FFFFFF"><b>Application Inward Number</b></font></td>

							</tr>
						</table>
						</td>
					</tr>
					<tr>

						<td valign="top" align="center" height="230">
						<DIV class="cellcontainer">
						<table width="100%" border="0" cellspacing="1" cellpadding="2"
							bordercolorlight="#FFFFFB" bordercolordark="#DEDACF">
							<%if (arrValues != null) {
				int arrSize = arrValues.size();
				ArrayList arrCol = null;
				for (int i = 0; i < arrSize; i++) {
					arrCol = new ArrayList();
					if (arrCol != null) {
						arrCol = (ArrayList) arrValues.get(i);

						%>
							<tr>

								<td width="10%"><%=i + 1%></td>
								<td width="45%"><a
									href="javascript:setValues('<%= Helper.correctNull((String)arrCol.get(0))%>','<%= Helper.correctNull((String)arrCol.get(1))%>',
											'<%= Helper.correctNull((String)arrCol.get(2))%>','<%=Helper.correctDoubleQuotesHtml(Helper.replaceForJavaScriptString((String)arrCol.get(3)))%>',
											'<%= Helper.correctDoubleQuotesHtml(Helper.replaceForJavaScriptString((String)arrCol.get(4)))%>','<%=  Helper.correctDoubleQuotesHtml(Helper.replaceForJavaScriptString((String)arrCol.get(5)))%>',
                                            '<%= Helper.correctNull((String)arrCol.get(6))%>','<%= Helper.correctNull((String)arrCol.get(7))%>',
                                            '<%= Helper.correctNull((String)arrCol.get(8))%>','<%= Helper.correctNull((String)arrCol.get(9))%>',
                                            '<%= Helper.correctNull((String)arrCol.get(10))%>','<%= Helper.correctNull((String)arrCol.get(11))%>',
                                            '<%= Helper.correctNull((String)arrCol.get(12))%>','<%= Helper.correctNull((String)arrCol.get(13))%>',
                                            '<%= Helper.correctDoubleQuotesHtml(Helper.replaceForJavaScriptString((String)arrCol.get(14)))%>','<%= Helper.correctNull((String)arrCol.get(15))%>',
                                            '<%= Helper.correctNull((String)arrCol.get(16))%>','<%= Helper.correctNull((String)arrCol.get(17))%>',
                                            '<%= Helper.correctNull((String)arrCol.get(18))%>','<%= Helper.replaceForJavaScriptString((String)arrCol.get(19))%>',
                                            '<%= Helper.correctNull((String)arrCol.get(20))%>','<%= Helper.correctNull((String)arrCol.get(21))%>',
                                            '<%= Helper.correctNull((String)arrCol.get(22))%>','<%= Helper.correctNull((String)arrCol.get(23))%>',
                                            '<%= Helper.correctNull((String)arrCol.get(24))%>','<%= Helper.correctNull((String)arrCol.get(25))%>',
                                            '<%= Helper.correctNull((String)arrCol.get(26))%>','<%= Helper.correctNull((String)arrCol.get(27))%>',
                                            '<%= Helper.correctNull((String)arrCol.get(28))%>','<%= Helper.correctNull((String)arrCol.get(29))%>'
                                            ,'<%= Helper.correctNull((String)arrCol.get(32))%>')"><%=Helper.correctNull((String) arrCol.get(3))%></a>
								</td>
								<td width="45%"><a
									href="javascript:setValues('<%= Helper.correctNull((String)arrCol.get(0))%>','<%= Helper.correctNull((String)arrCol.get(1))%>',
                                            '<%= Helper.correctNull((String)arrCol.get(2))%>','<%= Helper.correctDoubleQuotesHtml(Helper.replaceForJavaScriptString((String)arrCol.get(3)))%>',
                                            '<%= Helper.correctDoubleQuotesHtml(Helper.replaceForJavaScriptString((String)arrCol.get(4)))%>','<%= Helper.correctDoubleQuotesHtml(Helper.replaceForJavaScriptString((String)arrCol.get(5)))%>',
                                            '<%= Helper.correctNull((String)arrCol.get(6))%>','<%= Helper.correctNull((String)arrCol.get(7))%>',
                                            '<%= Helper.correctNull((String)arrCol.get(8))%>','<%= Helper.correctNull((String)arrCol.get(9))%>',
                                            '<%= Helper.correctNull((String)arrCol.get(10))%>','<%= Helper.correctNull((String)arrCol.get(11))%>',
                                            '<%= Helper.correctNull((String)arrCol.get(12))%>','<%= Helper.correctNull((String)arrCol.get(13))%>',                                            
                                            '<%= Helper.correctDoubleQuotesHtml(Helper.replaceForJavaScriptString((String)arrCol.get(14)))%>','<%= Helper.correctNull((String)arrCol.get(15))%>',
                                            '<%= Helper.correctNull((String)arrCol.get(16))%>','<%= Helper.correctNull((String)arrCol.get(17))%>',
                                            '<%= Helper.correctNull((String)arrCol.get(18))%>','<%= Helper.replaceForJavaScriptString((String)arrCol.get(19))%>',
                                            '<%= Helper.correctNull((String)arrCol.get(20))%>','<%= Helper.correctNull((String)arrCol.get(21))%>',
                                            '<%= Helper.correctNull((String)arrCol.get(22))%>','<%= Helper.correctNull((String)arrCol.get(23))%>',
                                            '<%= Helper.correctNull((String)arrCol.get(24))%>','<%= Helper.correctNull((String)arrCol.get(25))%>',
                                            '<%= Helper.correctNull((String)arrCol.get(26))%>','<%= Helper.correctNull((String)arrCol.get(27))%>',
                                            '<%= Helper.correctNull((String)arrCol.get(28))%>','<%= Helper.correctNull((String)arrCol.get(29))%>'
                                            ,'<%= Helper.correctNull((String)arrCol.get(32))%>')"><%=Helper.correctNull((String) arrCol.get(0))%></a>
								</td>
							</tr>
							<%}
				}

			}

			%>
							<tr>
								<td width="10%">&nbsp;</td>
								<td width="45%">&nbsp;</td>
								<td width="45%">&nbsp;</td>
							</tr>
							<tr>
								<td width="10%">&nbsp;</td>
								<td width="45%">&nbsp;</td>
								<td width="45%">&nbsp;</td>
							</tr>
							<tr>
								<td width="10%">&nbsp;</td>
								<td width="45%">&nbsp;</td>
								<td width="45%">&nbsp;</td>
							</tr>
							<tr>
								<td width="10%">&nbsp;</td>
								<td width="45%">&nbsp;</td>
								<td width="45%">&nbsp;</td>
							</tr>
							<tr>
								<td width="10%">&nbsp;</td>
								<td width="45%">&nbsp;</td>

								<td width="45%">&nbsp;</td>
							</tr>
							<tr>
								<td width="10%">&nbsp;</td>
								<td width="45%">&nbsp;</td>
								<td width="45%">&nbsp;</td>
							</tr>
							<tr>
								<td width="10%">&nbsp;</td>
								<td width="45%">&nbsp;</td>
								<td width="45%">&nbsp;</td>
							</tr>
						</table>
						</div>
						<table width="10%" border="0" cellspacing="0" cellpadding="3"
							align="center">
							<tr valign="top">
								<td width="20%"><input type=button class="buttonClose"
									value="Close" name="closebtn" tabindex="25"
									onClick=window.close()></td>
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

<input type="hidden" name="hidBeanMethod" value="getInwardnoList"> <input
	type="hidden" name="hidBeanId" value="inwardRegister"> <input type="hidden"
	name="hidBeanGetMethod" value="getInwardnoList"> <input
	type="hidden" name="hidvalue" value=""> 
</form>
</body>
</html>
