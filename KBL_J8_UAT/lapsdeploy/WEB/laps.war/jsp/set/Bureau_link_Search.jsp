<%@ page import="com.sai.laps.helper.*,java.util.*"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />
<%
	ArrayList glp = null;
	glp = (ArrayList) hshValues.get("arr");
	String grpRights = String
			.valueOf(Helper.correctNull(
					(String) session.getAttribute("strGroupRights"))
					.charAt(18));
%>
<html>
<head>
<title>Bureau Search</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/PageLoadTime.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/menudropdown.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script>
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var level = "<%=session.getAttribute("strOrgCode")%>";
var orglevel = "<%=session.getAttribute("strOrgLevel")%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var vargrprights="<%=grpRights%>";
var varRLPFUser="<%=Helper.correctNull((String)session.getAttribute("strRLPFUser"))%>";
</script>
<STYLE>
DIV.cellContainer {
	width: 100%;
	height: 100%;
	overflow: auto;
}
</STYLE>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad="onloading();" style="overflow: hidden;">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems" url="">
<script language="JavaScript">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
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
				 alert("Enter Proposal No");
			     document.forms[0].txt_value.focus();
			     return false;
			 }
		}
		if(document.forms[0].radiobutton[2].checked==true)
		{
			 if(txtlen<1)
			 {
				 alert("Enter CBS Custemer ID");
			     document.forms[0].txt_value.focus();
			     return false;
			 }			
		}
	return true;
	}
function resetme()
{
	document.forms[0].reset();
	document.all.result.src=appUrl+"action/blank.jsp";

}
function onRadioClick()
{
	if(document.forms[0].radiobutton[0].checked==true)
	{
		document.forms[0].hidvalue.value="name";
	}
	else  if(document.forms[0].radiobutton[1].checked==true)
	{	
		document.forms[0].hidvalue.value="no";
	}
	else  if(document.forms[0].radiobutton[2].checked==true)
	{	
		document.forms[0].hidvalue.value="CBSID";
	}
	document.forms[0].txt_value.value="";
	document.forms[0].txt_value.focus();
}
function checkRadioButton(val)
{
	if(document.forms[0].radiobutton[0].checked==true)
	{
		notAllowSplChar(val);
		document.forms[0].hidvalue.value="name";
	}
	else  if(document.forms[0].radiobutton[1].checked==true)
	{	
		notAllowSplChar(val);
		document.forms[0].hidvalue.value="no";
	}
	else  if(document.forms[0].radiobutton[2].checked==true)
	{	
		notAllowSplChar(val);
		document.forms[0].hidvalue.value="CBSID";
	}
}
function callNew()
{
		document.forms[0].action=appUrl+"action/Bureau_link.jsp?";
		document.forms[0].submit();
}
function setpageid()
{
	
}
function onloading()
{
	if(((orglevel == "A"||orglevel == "C"||orglevel == "R") && vargrprights=="w")||(orglevel == "D" && vargrprights=="w" && varRLPFUser=="012"))
	{
		document.forms[0].cmdnew.disabled=false;
	}
	else
	{
		document.forms[0].cmdnew.disabled=true;
	}
}

// row count to be displayed in screen
function setCount()
{
   
}
function doSearch()
{
    var area1="";
    var area2="";
    var area3="";
    var area4=""; 
    var area5="";

    if(document.forms[0].radiobutton[0].checked==true)
    {
	    if(orglevel == "C")
		{	
			area2 = document.forms[0].hidarea2.value;
			if(area2=="")
			{
				alert("Select a region");
				return;
			}
			area3=document.forms[0].hidarea3.value;
			if(area3=="")
			{
				alert("Select a CLPU");
				return;
			}
			area4=document.forms[0].hidarea4.value;
			if(area4=="")
			{
				alert("Select a Branch");
				return;
			}
		}
		else if(orglevel == "R")
		{
			area3=document.forms[0].hidarea3.value;
			if(area3=="")
			{
				alert("Select a CLPU");
				return;
			}
			area4=document.forms[0].hidarea4.value;
			if(area4=="")
			{
				alert("Select a Branch");
				return;
			}
		}
		else if(orglevel == "D")
		{
			area4=document.forms[0].hidarea4.value;
			if(area4=="" && varRLPFUser!="012")
			{
				alert("Select a Branch");
				return;
			}
		}
		else if(orglevel == "A")
		{
			area4=level;
			if(area4=="")
			{
				alert("Select a Branch");
				return;
			}
		}
    }
	scode="";
	
	hid_rowcount=document.forms[0].hid_rowcount.value;
	
	if(hid_rowcount=="")
	{
		hid_rowcount=0;
	}
    noofrows = document.forms[0].txt_noofrows.value;
	txt_search =  document.forms[0].txt_value.value;
	if(document.forms[0].radiobutton[0].checked==false && document.forms[0].radiobutton[1].checked==false && document.forms[0].radiobutton[2].checked==false)
	{
		alert("Select atleast one option");
		return false;
	}
	
	
	var hid_value = document.forms[0].hidvalue.value;
	if(callack())
	{
			document.all.result.src=appUrl+"action/Bureau_link_result.jsp?hidBeanGetMethod=getInwardSearch&hidBeanId=BureauLink&area1="
	+area1+"&scode="+scode+"&search="+txt_search+"&area2="+area2+"&area3="+area3+"&area4="+area4+"&area5="+area5+"&hid_rowcount="+hid_rowcount+"&noofrows="+noofrows+"&hidvalue="+hid_value;
	}
	
}
function showSystem(val,glpsize)
{
	prop = "scrollbars=yes,width=500,height=355,statusbar=yes";	
	xpos = (screen.width - 700) / 2;
	ypos = (screen.height - 550) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	
	if(orglevel == "C")
	{
		if(val == "2")
		{			
			valsys=level.substring(0,3)+"%%%000000000";
			var purl = appURL+"jsp/com/comborrowerselect.jsp?val="+val+"&valsys="+level+"&glpsize="+glpsize;
		}
		if(val == "3")
		{
			if(document.forms[0].hidarea2.value != "")
			{
				level = document.forms[0].hidarea2.value;
				valsys=level.substring(0,6)+"%%%000000"
				var purl = appURL+"jsp/com/comborrowerselect.jsp?val="+val+"&valsys="+level+"&glpsize="+glpsize;
			}
				else
				{
					alert("select a Zone");
					return;
				}
		}
		    if(val == "4")
			{
				if(document.forms[0].hidarea2.value != "" && document.forms[0].hidarea3.value != "")
				{
				level = document.forms[0].hidarea3.value;
				valsys=level.substring(0,9)+"%%%000"	;
				var purl = appURL+"jsp/com/comborrowerselect.jsp?val="+val+"&valsys="+level+"&glpsize="+glpsize;
				}
				else
				{
					alert("select a Region");
					return;
				}
			}
		if(val == "5")
			{
				if(document.forms[0].hidarea2.value != "" && document.forms[0].hidarea3.value != "" &&  document.forms[0].hidarea4.value != "")
				{
				level = document.forms[0].hidarea4.value;
				valsys=level.substring(0,12)+"%%%"	;
				var purl = appURL+"jsp/com/comborrowerselect.jsp?val="+val+"&valsys="+level+"&glpsize="+glpsize;
				}
				else
				{
					alert("Select a Branch");
					return;
				}
			}
	}
	else if(orglevel == "R")
	{
		
		if(val == "3")
			{
				
				valsys=level.substring(0,9)+"%%%000"	;
				var purl = appURL+"jsp/com/comborrowerselect.jsp?val="+val+"&valsys="+level+"&glpsize="+glpsize;
				
			}
		if(val == "4")
			{
				if(document.forms[0].hidarea3.value != "" )
				{
				level = document.forms[0].hidarea3.value;
				valsys=level.substring(0,12)+"%%%"	;
				var purl = appURL+"jsp/com/comborrowerselect.jsp?val="+val+"&valsys="+level+"&glpsize="+glpsize;
				}
				else
				{
					alert("Select a Branch");
					return;
				}
			}
	}
	else if(orglevel == "D")
	{
		if(val == "4")
			{
				valsys=level.substring(0,9)+"%%%000";
				var purl = appURL+"jsp/com/comborrowerselect.jsp?val="+val+"&valsys="+level+"&glpsize="+glpsize;
			}
		
	}
	
	title="help";
	//alert(purl);
	window.open(purl,title,prop);
	


}
function doClose()
{
	if(ConfirmMsg(100))
	 {
		 document.forms[0].action=appUrl+"action/mainnav.jsp";
		 document.forms[0].submit();
	 }
}

</script>
</div></div>
<form class="normal" name="loanHistory" method="post">
<span class="page_flow">Home -&gt; Application Number Search</span>
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="outertable">
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3"
					class="outertable border1">
					<tr>
						<td valign="top" align="left" class="setuphead"><b>Proposal
						Number Search</b><br>
						<table width="100%" border="0" cellspacing="1" cellpadding="5">
							<tr>
								<td valign="top">
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td valign="top">
										<table width="100%" border="0" cellspacing="0" cellpadding="1"
											class="outertable">
											<tr>
												<td width="76%" valign="top">
												<table width="100%" border="0" cellspacing="1"
													cellpadding="0" class="outertable">
													<tr>
														<%
															int initial = 0;
															String level = (String) session.getAttribute("strOrgLevel");
															if (level.equalsIgnoreCase("C")) {
																initial = 2;
															} else if (level.equalsIgnoreCase("R")) {
																initial = 3;
															} else if (level.equalsIgnoreCase("D")) {
																initial = 4;
															} else if (level.equalsIgnoreCase("A")) {
																initial = 5;
															} else if (level.equalsIgnoreCase("B")) {
																initial = 6;
															}
															
														for (int y = initial; y <= glp.size() - 1; y++) {
																if (!glp.get(y).equals("")) {
														%>
														<td width="8%" nowrap="nowrap"><%=glp.get(y)%></td>
														<td width="25%"><input type="text" name="area<%=y%>"
															size='25'> <input type="hidden"
															name="hidarea<%=y%>"> <b><span
															onClick="showSystem('<%=y%>','<%=glp.size() - initial%>')"
															style="cursor: hand"><img
															src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
															border="0"></span></b> &nbsp;&nbsp;&nbsp;&nbsp;</td>
														<%
															}
															}
														%>
													</tr>
												</table>
												</td>

											</tr>
										</table>
										</td>
									</tr>
									<tr><td>&nbsp;</td></tr>

									<tr>
										<td valign="top">
										<table width="100%" border="0" cellspacing="0" cellpadding="1"
											class="outertable">
											<tr>
												<td valign="top">

												<table width="100%" border="0" cellspacing="1"
													cellpadding="0" class="outertable">
													<tr>
														<td align="right" width="4%"><INPUT TYPE="radio"
															NAME="radiobutton" VALUE="bname"
															STYLE="border-style: none" ONCLICK="onRadioClick()"></td>
														<td width="10%"><b>Applicant Name</b></td>
														<td align="right" width="4%"><INPUT TYPE="radio"
															NAME="radiobutton" VALUE="bid" STYLE="border-style: none"
															ONCLICK="onRadioClick();"></td>
														<td width="10%"><b>Proposal No</b></td>
														
														<td align="right" width="4%"><INPUT TYPE="radio"
															NAME="radiobutton" VALUE="CBSID" STYLE="border-style: none"
															ONCLICK="onRadioClick();"></td>
														<td width="10%"><b>CBS Customer ID</b></td>
														
														<td width="21%" align="center"><input type="text"
															name="txt_value" size="25" maxlength="15"
															onKeyPress="checkRadioButton('txt_value')"></td>

														<td width="9%"><input type="button" name="cmdsearch"
															value="Search" class="buttonStyle" onClick="doSearch()"></td>
														<td width="9%" align="left"><input type="reset"
															name="search2" value="Reset" class="buttonStyle"
															onClick="resetme()"></td>

														<td width="29%" align="left"><input type="button"
															name="cmdnew" value="New" class="buttonStyle"
															onClick="callNew()"></td>
													</tr>
												</table>
												</td>
											</tr>
										</table>
										</td>
									</tr>
									<!-- for no of rows to be displayed -->
									<tr>
										<td colspan="8">
										<table width="100%" border="0" cellspacing="0" cellpadding="0"
											class="outertable">
											<tr>
												<td width="19%" nowrap="nowrap"><b>No. of rows to be
												displayed </b></td>
												<td width="81%"><input type="text" name="txt_noofrows"
													size="4" maxlength="2" value="15"
													onKeyPress="allowInteger()" onBlur="setCount()"> <b>(Value
												should be below 100)</b></td>
											</tr>
										</table>
										</td>
									</tr>
									<tr id="id_app">
										<td colspan="8">
										<table width="98.7%" border="0" cellspacing="1" cellpadding="5" align="" class="outertable">
											<tr class="dataheader">

												<td width="15%" align="center">Application No.</td>

												<td width="31%" align="center">Applicant Name</td>

												<td width="8%" align="center">CBSID</td>
												<td width="25%" align="center">Created UserId</td>

												<td width="21%" align="center">Organisation Name</td>
											</tr>
										</table>
										<!-- next and  previous --></td>
									</tr>


									<tr align="center">
										<td colspan="8"><iframe id="result" src="" width="100%"
											height="240"></iframe></td>
									</tr>
									<tr align="center">
										<td colspan="8">&nbsp;</td>
									</tr>
								</table>
								<table width="100%" border="0" cellspacing="0" cellpadding="3"
									class="outertable">
									<tr>
										<td width="9%" nowrap="nowrap"><a
											href="javascript:rowCount('1')" class="blackfont"><b>&lt;&lt;Previous</b></a></td>
										<td width="84%" align="center"><input type="button"
													name="cmdClose" class="buttonClose" value="Close"
													onClick="doClose()"></td>
										<td align="right" width="7%"><a
											href="javascript:rowCount('2')" class="blackfont"><b>Next&gt;&gt;</b></a></td>
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
<input type="hidden" name="hidCategoryType" value="">
<input type="hidden" name="hid_rowcount" value="" /> 
<input type="hidden" name="hidBeanGetMethod" value=""> 
<input type="hidden" name="hidBeanId" value=""> 
<input type="hidden" name="hidvalue" value="">
</form>
</body>
</html>