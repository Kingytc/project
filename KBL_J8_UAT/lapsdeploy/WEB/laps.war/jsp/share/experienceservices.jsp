<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<lapschoice:handleerror />
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%if (objValues instanceof java.util.HashMap) 
{
	hshValues = (java.util.HashMap) objValues;
}
%>
<html>
<head>
<title>Appraisal - Experience &amp; Services</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<STYLE>
DIV.cellContainer {	
  width: 100%; height: 300;
  overflow: auto;
}
</STYLE>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>

<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/headmenu.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/keytrap.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currdate = "<%=Helper.getCurrentDateTime()%>";
var strper_appid="<%=Helper.correctNull((String)hshValues.get("strper_appid"))%>";
/*var Ques1 = "<%//=Helper.correctNull((String)hshValues.get("Ques1"))%>";
var Ques2 = "<%//=Helper.correctNull((String)hshValues.get("Ques2"))%>";
var Ques3 = "<%//=Helper.correctNull((String)hshValues.get("Ques3"))%>";
var Ques4 = "<%//=Helper.correctNull((String)hshValues.get("Ques4"))%>";
var Ques5 = "<%//=Helper.correctNull((String)hshValues.get("Ques5"))%>";
var Ques6 = "<%//=Helper.correctNull((String)hshValues.get("Ques6"))%>";
var Ques7 = "<%//=Helper.correctNull((String)hshValues.get("Ques7"))%>";*/
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";

function ClearFields()
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			document.forms[0].elements[i].value="";		  
		}
		else if (document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].value="0";	
		}
		else if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].value="";		  
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
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=one;
		}
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=one;		  
		}	
	}
	document.forms[0].chk_apptype.disabled=false;	
}

function enableButtons(bool1, bool2, bool3, bool4, bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdapply.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddel.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
}

function callonLoad()
{
	disablefields(true);
	if(appstatus=="Processed/Rejected" || appstatus=="Processed/Approved" || appstatus=="Closed/Approved" || appstatus=="Closed/Rejected")	 
		{
		enableButtons(true, true, true, true, false);
		}
	else
		{
		enableButtons(false, true, true, true, false);	
		}
	if(strper_appid!="")
	{
		document.forms[0].chk_apptype.value=strper_appid;
	}
	else
	{
		document.forms[0].chk_apptype.value="";
	}
	
}

function callEdit()
{
	if(document.forms[0].chk_apptype.value == "")
	{
	
		alert("Select the Applicant Type");
		return;
	}
	document.forms[0].hidAction.value="Edit"
	enableButtons(true, false, false, false, true);
	disablefields(false);
}

function doSave()
{
	if(document.forms[0].chk_apptype.value == "0")
	{
		alert("Select the Applicant Type");
		return;
	}
	if(document.forms[0].txt_comments.value == "")
	{
		ShowAlert('121','Comments');
		return;
	}
	document.forms[0].cmdapply.disabled = true;
	document.forms[0].hidBeanId.value="appraisal";
	document.forms[0].hidBeanMethod.value="updateAppraisalData";
	document.forms[0].hidBeanGetMethod.value="getAppraisalData";
	document.forms[0].hidSourceUrl.value="/action/experienceservices.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
	enableButtons(true, true, false, false, true);
}
function callDelete()
{
	var varconfirm=ConfirmMsg('101');
	if(varconfirm)
	{
	   document.forms[0].hidAction.value="Delete";
		document.forms[0].hidBeanId.value="appraisal";
	document.forms[0].hidBeanMethod.value="updateAppraisalData";
	document.forms[0].hidBeanGetMethod.value="getAppraisalData";
	document.forms[0].hidSourceUrl.value="/action/experienceservices.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
	}
}
function callCancel()
{
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
		document.forms[0].hidBeanId.value="appraisal";
		document.forms[0].hidBeanMethod.value="getAppraisalData";
		document.forms[0].hidBeanGetMethod.value="getAppraisalData";
		document.forms[0].hidSourceUrl.value="/action/experienceservices.jsp";
		document.forms[0].submit();
	}
}

function getValues()
{
	document.forms[0].hidBeanId.value="appraisal";
	document.forms[0].hidBeanMethod.value="getAppraisalData";
	document.forms[0].hidBeanGetMethod.value="getAppraisalData";
	document.forms[0].hidSourceUrl.value="/action/experienceservices.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function callClose()
{
	var con = ConfirmMsg('100');
	var id="<%=Helper.correctNull((String)hshValues.get("applicantid"))%>";
	var comappname="<%=Helper.correctNull((String)hshValues.get("appname"))%>";
	
	if(con)
	{
	 document.forms[0].action=appURL+"action/retailpge.jsp";
	  document.forms[0].submit();
	}
}
</SCRIPT>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css"
	type="text/css">
</head>
<body bgcolor="#EEEAE3" text="#000000" vlink="#330000" alink="#330000"
	leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"
	onload="callonLoad()">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()" onMouseout="lowlightie5()" onClick="jumptoie5()"> 
  <div class="menuitems" url="">
   <script language="JavaScript1.2">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script>
</div>
  </div>
<jsp:include page="../share/help.jsp" flush="true"/>

<form name="appform" method="post" action="">
<table width="100%" border="0" cellpadding="0" cellspacing="0"
	class="outertable border1">
	<tr>
		<td id="mainlnk1"><jsp:include page="../share/Applurllinkper.jsp"
			flush="true">
			<jsp:param name="pageid" value="10" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		
      <td><font face="Times New Roman" size="3"><b><i>Home -&gt; Retail-&gt; <%= (String)session.getAttribute("pgeLabel")%>-&gt; 
        Appraisal -&gt; Experience &amp; Services</i></b></font></td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td id="mainlnk1"><lapschoice:application /></td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0"
	class="outertable border1">
	<tr>
		<td><jsp:include page="../share/apprlinktab.jsp"
			flush="true">
			<jsp:param name="tabid" value="3" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="5" cellspacing="0"
	 class="outertable border1"
	align="center">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="2"
			class="outertable border1">
			<tr>
				<td>
				<table width="100%" border="0" class="outertable border1" cellspacing="0" cellpadding="2"
					align="center">
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0"
							bordercolorlight="#FFFFFB" bordercolordark="#DEDACF">
							<tr>
								<td valign="top"><b><font face="MS Sans Serif" size="1">Experience
								and Services</font></b></td>
							</tr>
							<tr>
								<td valign="top">
								<table width="100%" border="0" cellspacing="0" cellpadding="2"
									bordercolorlight="#FFFFFB" bordercolordark="#DEDACF">
									<tr>
										<td valign="top">
										<table width="100%" cellspacing="1" cellpadding="3"
											bordercolorlight="#FFFFFB" bordercolordark="#DEDACF">
											<tr align="center" bgcolor="#71694F">
												<td nowrap><b><font face="MS Sans Serif" size="1"
													color="#FFFFFF">Type</font></b></td>
												<td><b><font face="MS Sans Serif" size="1" color="#FFFFFF">Name</font></b></td>
												<td nowrap><b><font face="MS Sans Serif" size="1"
													color="#FFFFFF">Relation</font></b></td>
												<td><b><font face="MS Sans Serif" size="1" color="#FFFFFF">Age</font></b></td>
												<td nowrap><b><font face="MS Sans Serif" size="1"
													color="#FFFFFF">Date of Birth</font></b></td>
												<td nowrap><b><font face="MS Sans Serif" size="1"
													color="#FFFFFF">Retirement Date</font></b></td>
												<td nowrap><b><font face="MS Sans Serif" size="1"
													color="#FFFFFF">Service Left (Months)</font></b></td>
												<td nowrap><b><font face="MS Sans Serif" size="1"
													color="#FFFFFF">Networth</font></b></td>
											</tr>
											<%
											ArrayList vecReport=new ArrayList();
											int vecRsize=0;
											if (hshValues != null)
			 								{
				   								vecReport = (ArrayList)hshValues.get("vecReport");
				   								
				 							}
			 								if(vecReport!=null)
											{
												vecRsize =vecReport.size();
											}
											ArrayList b1=null;
				 							for (int l=0;l<vecRsize;l++)
						 					{
												int colSize=0;
							 					if(l<vecRsize)
						 						{
								 					b1 = (ArrayList)vecReport.get(l);
													if(b1!=null)
													{
								   						colSize = b1.size();
	       											}
							 					}												
							 					if(colSize>0)	
						  						{
							 						int intService=Integer.parseInt(Helper.correctInt((String)b1.get(9)));
							 						if(intService<0)
							 						{
							 							intService=0;
							 						}
							 						
												%>
											<tr>
												<td nowrap><%=Helper.correctNull((String)b1.get(0))%></td>
												<td><%=Helper.correctNull((String)b1.get(1))%></td>
												<td nowrap><%=Helper.correctNull((String)b1.get(5))%></td>
												<td><%=Helper.correctNull((String)b1.get(8))%></td>
												<td nowrap align="center"><%=Helper.correctNull((String)b1.get(7))%></td>
												<td nowrap><%=Helper.correctNull((String)b1.get(6))%></td>
												<td nowrap><%=intService%></td>
												<td nowrap align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) b1.get(10))))%> </td>
											</tr>

											 <%
												}
											}
											%>			
											<tr>
												<td nowrap>&nbsp;</td>
												<td>&nbsp;</td>
												<td nowrap>&nbsp;</td>
												<td>&nbsp;</td>
												<td nowrap>&nbsp;</td>
												<td nowrap>&nbsp;</td>
												<td nowrap>&nbsp;</td>
												<td nowrap>&nbsp;</td>
											</tr>
										</table>
										</td>
									</tr>
									<tr>
										<td valign="top">&nbsp;</td>
									</tr>
									<tr>
										<td valign="top"><font face="MS Sans Serif" size="1">Applicant
										Type : <select name="chk_apptype" style="width:150" onchange="getValues()">
											<option value="">--Select--</option>
											<lapschoice:fincoappguarantor />
										</select> </font></td>
									</tr>
									<!-- <tr>
										<td valign="top">
										<table width="80%" border="0" cellspacing="0" cellpadding="3"
											align="center">
											<tr>
												<td><font face="MS Sans Serif" size="1">Q1. Whether the
												applicant is working with the present organisation for
												satisfactory length of period? </font></td>
												<td><select name="sel_question1">
													<option selected value="1">Yes</option>
													<option value="2">No</option>
												</select></td>
											</tr>
											<tr>
												<td><font face="MS Sans Serif" size="1">Q2. Whether undertaking letter has been obtained from the Employer? </font></td>
												<td><select name="sel_question2">
													<option selected value="1">Yes</option>
													<option value="2">No</option>
												</select></td>
											</tr>
											<tr>
												<td><font face="MS Sans Serif" size="1">Q3. Whether the
												remaining service of the applicant is sufficient to cover
												the proposed Repayment period?</font></td>
												<td><select name="sel_question3" >
													<option selected value="1">Yes</option>
													<option value="2">No</option>
												</select></td>
											</tr>
											<tr>
												<td><font face="MS Sans Serif" size="1">Q4. Creation of mortgage of the property / RC Book lien registration</font></td>
												<td><select name="sel_question4" >
												<option selected value="0">-- Select --</option>
													<option selected value="1">Complied</option>
													<option value="2">Yet to Receive</option>
													<option value="3">Not Complied</option>
												</select></td>
											</tr>
											 <tr>
												<td><font face="MS Sans Serif" size="1">Q5. Other documentation including Insurance renewal/up to date EC/Tax receipts/Registration of Memorandum of Deposit of title deed for Branches </font></td>
												<td><select name="sel_question5" >
													<option selected value="0">-- Select --</option>
													<option selected value="1">Completed</option>
													<option value="2">Not Completed</option>
												</select></td>
											</tr>
											<tr>
												<td><font face="MS Sans Serif" size="1">Q5. Undertaking from the employer to remit the due directly to us</font></td>
												<td><select name="sel_question6" >
													<option selected value="1">Yes</option>
													<option value="2">No</option>
												</select></td>
											</tr>
											<tr>
												<td><font face="MS Sans Serif" size="1">Q6. Tri-partite agreement</font></td>
												<td><select name="sel_question7" >
													<option selected value="1">Yes</option>
													<option value="2">No</option>
												</select></td>
											</tr>
										</table>
										</td>
									</tr> -->
									<tr>
										<td valign="top" align="center"><textarea name="txt_comments"
											cols="80" rows="10" wrap="VIRTUAL" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("Comments"))%></textarea>
										</td>
									</tr>
									<tr>
										<td valign="top" align="center">&nbsp;</td>
									</tr>
									<tr>
										<td valign="top" align="center">
										<table border="0" cellspacing="0" cellpadding="0"
											class="outertable border1" align="center">
											<tr>
												<td>
												<table width="43%" border="0" cellspacing="0"
													cellpadding="2">
													<tr valign="top">
														<td><input type="button" name="cmdedit" value="Edit"
															class="buttonStyle"
															onClick="callEdit()"></td>
														<td><input type="button" name="cmdapply" value="Save"
															class="buttonStyle"
															onClick="doSave()"></td>
														<td><input type="button" name="cmdcancel" value="Cancel"
															class="buttonStyle"
															onClick="callCancel()"></td>
														<td><input type="button" name="cmddel" value="Delete"
															class="buttonStyle"
															onClick="callDelete()"></td>
														<!-- <td><input type="button" name="cmdHelp" value="Help"
															style="background-color:#009966;cursor:help;;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"
															onClick="dohlp()"></td> -->
														<td><input type="button" name="cmdclose" value="Close"
															style="background-color:#CC3300;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"
															onClick="callClose()"></td>
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
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<lapschoice:hiddentag/>
</form>
</body>
</html>
