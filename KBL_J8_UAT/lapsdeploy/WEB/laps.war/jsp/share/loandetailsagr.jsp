<%@include file="../share/directives.jsp"%>
<%
		    String bstate = Helper.correctNull((String) hshValues.get("bstate"));
			String strInitialLoad = (String) request.getParameter("initial");
			String prd_type = Helper.correctNull((String)session.getAttribute("strProductType"));
			String hidBeanMethod = Helper.correctNull((String) request.getParameter("hidBeanMethod1"));
			String hidBeanGetMethod = Helper.correctNull((String) request.getParameter("hidBeanGetMethod1"));
			
%>
<html>
<head>
<title>Appraisal - LoanDetails</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"> </script>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currdate = "<%=Helper.getCurrentDateTime()%>";
var bstate ="<%=bstate%>";
var prd_type="<%=prd_type%>";
var sanction_amt="<%=Helper.correctNull((String)hshValues.get("eliAmount"))%>" ;
var pagename ="";
var hidBeanGetMethod = "<%=hidBeanGetMethod%>";
var hidBeanMethod = "<%=hidBeanMethod%>";

function callfarmm(pagename)
{
	if(document.forms[0].producttype.value="aF")
	{
	document.all.f.style.visibility="visible";		
	appno=document.forms[0].appno.value;
	
	var purl ="<%=ApplicationParams.getAppUrl()%>action/"+pagename+"?hidBeanGetMethod=getfarmMechreport&hidBeanId=agreconomic&appno="+appno;
	
		
			var prop = 'scrollbars=yes,menubar=yes,width=775,height=520';	
			var xpos = (screen.width - 775) / 2;
			var ypos = (screen.height - 520) / 2;
			prop = prop + ",left="+xpos+",top="+ypos;
			window.open(purl,'title',prop);
       }
    else
    {
    document.all.f.style.visibility="hidden";	
    }

}


function callcropgenloan(pagename)
{
	
appno=document.forms[0].appno.value;

var purl ="<%=ApplicationParams.getAppUrl()%>action/"+pagename+"?hidBeanGetMethod=getsanctionAdvice&hidBeanId=sanctionadvice&appno="+appno;

	
		var prop = 'scrollbars=yes,menubar=yes,width=775,height=520';	
		var xpos = (screen.width - 775) / 2;
		var ypos = (screen.height - 520) / 2;
		prop = prop + ",left="+xpos+",top="+ypos;
		window.open(purl,'title',prop);


	
}
function callprocessnote()
	{
	appno=document.forms[0].appno.value;
	var purl ="<%=ApplicationParams.getAppUrl()%>action/agr_processnote.jsp?hidBeanGetMethod=getAgriprocessnoteGeneral&hidBeanId=processNote&appno="+appno;
	var prop = 'scrollbars=yes,menubar=yes,width=775,height=520';	
	var xpos = (screen.width - 775) / 2;
	var ypos = (screen.height - 520) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,'title',prop);
	}
function callMinorEconomic(pagename)
	{
	appno=document.forms[0].appno.value;
	var purl ="<%=ApplicationParams.getAppUrl()%>action/agr_minorirrieconomic_print.jsp?hidBeanGetMethod=getCroppingPatterns&hidBeanId=agrcrops&appno="+appno;
	var prop = 'scrollbars=yes,menubar=yes,width=775,height=520';	
	var xpos = (screen.width - 775) / 2;
	var ypos = (screen.height - 520) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,'title',prop);
	}
function callFormMechnisation(pagename)
{
	
appno=document.forms[0].appno.value;

var purl ="<%=ApplicationParams.getAppUrl()%>action/"+pagename+"?hidBeanGetMethod=getfarmMechreport&hidBeanId=agreconomic&appno="+appno;

	
		var prop = 'scrollbars=yes,menubar=yes,width=775,height=520';	
		var xpos = (screen.width - 775) / 2;
		var ypos = (screen.height - 520) / 2;
		prop = prop + ",left="+xpos+",top="+ypos;
		window.open(purl,'title',prop);
		
}

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

function callCalender1()
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal(appURL,'appraisaldate');
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
	document.forms[0].appraisedby.readOnly=true;
}

function enableButtons( bool2, bool3, bool4, bool5,bool6)
{
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool5;
	document.forms[0].cmdclose.disabled=bool6;
}

function callonLoad()
{
	disablefields(true);
}

function doEdit()
{
	enableButtons( true, false, false, false,true);
	disablefields(false);
	document.forms[0].hideditflag.value="Y";
	document.forms[0].hidAction.value="edit";
	document.forms[0].appraisaldate.focus();
	document.forms[0].txt_sanction_amount.readOnly=false;
}

function doSave()
{
	var loan_amt_check = "<%=Helper.correctNull((String) hshValues.get("loanamount_check"))%>"; 
	
	if(loan_amt_check=="")
	{
		alert("Please enter Loan Recommended amount in Appraisal Confirmation");
		document.forms[0].txt_sanction_amount.value="";
		return;
	}
	
	if(document.forms[0].appraisaldate.value=="")
	{
		alert("Enter the appraisal date");
		document.forms[0].appraisaldate.focus();
		return;
	}	
	else if(document.forms[0].txt_userid.value=="")
	{
		alert("Enter the Appraised by");
		document.forms[0].txt_userid.focus();
		return;
	}
	else if(document.forms[0].txt_sanction_amount.value=="" || document.forms[0].txt_sanction_amount.value=="0.00")
	{
		alert("Enter the Sanction Loan amount");
		document.forms[0].txt_sanction_amount.focus();
		return;
	}
	else
	{
		enableButtons(true, true, true, true,false);
		document.forms[0].hidBeanId.value="appraisal";
		document.forms[0].hidBeanMethod.value="insertdates";
		document.forms[0].hidBeanGetMethod.value="getloandetails";
		document.forms[0].hidSourceUrl.value="/action/loandetailsagr.jsp";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
	}	
}
function doDelete()
{
	if(ConfirmMsg(101))
	{
       document.forms[0].hidAction.value="delete";
       document.forms[0].hidBeanId.value="appraisal";
		document.forms[0].hidBeanMethod.value="insertdates";
		document.forms[0].hidBeanGetMethod.value="getloandetails";
		document.forms[0].hidSourceUrl.value="/action/loandetailsagr.jsp";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
	}
}
function doCancel()
{
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
		document.forms[0].hidBeanId.value="appraisal";
		document.forms[0].hidBeanGetMethod.value="getloandetails";
		document.forms[0].action=appURL+"action/loandetailsagr.jsp";
		document.forms[0].submit();
	}
}

function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].target="_parent";
		document.forms[0].action=appURL+"action/"+"retailpge.jsp";				
		document.forms[0].submit();

	}
}

function callUsersHelp()
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		var prop="scrollbars=no,width=500,height=340,top=100,left=250";
		var url=appURL+"action/selectusers.jsp?hidBeanId=appraisal&hidBeanGetMethod=getuserslist";
		window.open(url,"",prop);
	}
}
function clearSelection() 
{
	if ('<%=strInitialLoad%>'!= "yes") 
	{
		window.parent.topFrame.clearSelection();
	}
}
function checkamt()
{
	
	
	var varloanrecomend=document.forms[0].txt_sanction_amount.value;
	
	if(varloanrecomend=="")
	{
		varloanrecomend=0;
	}
	
	if(document.forms[0].hideditflag.value=="Y" && (prd_type=="aH" || prd_type=="aR"))
	{
		document.all.ifrm.src=appURL+"action/iframeeligibility.jsp?hidBeanGetMethod=checkagrieligibility&hidBeanId=agriapprisal&appno="+document.forms[0].appno.value+"&txt_sanction_amount="+varloanrecomend;
	}
	else if(eval(sanction_amt)<eval(varloanrecomend))
	{
		alert("Sanction Loan amount cannot be greater than Eligible Loan Amount");
		document.forms[0].txt_sanction_amount.value="";
		document.forms[0].txt_sanction_amount.focus();
		return;
	}
	
	
}

</SCRIPT>
</head>
<body onload="callonLoad()">
<form name="appform" method="post" class="normal">
<table width="100%" border="0" cellpadding="3" cellspacing="0" class="outertable border1" align="center">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable border1">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
							<tr>
								<td valign="top">
								<table width="100%%" border="0" cellspacing="0" cellpadding="4" class="outertable">
									<tr>
										<td width="15%" height="38">Product</td>
										<td width="85%" height="38"><%=Helper.correctNull((String) hshValues.get("prodcategory"))%> - <%=Helper.correctNull((String) hshValues.get("subcategory"))%> - <%=Helper.correctNull((String) hshValues.get("prd_desc"))%></td>
									</tr>
									<tr>
										<td width="15%" height="32">Purpose of Loan</td>
										<td width="85%" height="32"><%=Helper.correctNull((String) hshValues
							.get("loan_purposeofloan"))%></td>
									</tr>
								</table>
								</td>
							</tr>
							<tr>
								<td><b>Loan Details</b></td>
							</tr>
							<tr>
								<td>
								<table width="100%" border="0" cellspacing="1" cellpadding="2" class="outertable">
									<tr class="dataheader">
										<td width="15%" align="center"><b>Loan Amount Applied </b>Rs.</td>
										<td width="19%" align="center"><b>Rate of Interest</b></td>
										<td width="16%" align="center"><b>Instalment amount</b>&nbsp;Rs.</td>
										<td width="11%" align="center"><b>Repayment Period</b></td>
									</tr>
									<tr>
										<td width="15%" align="center"><%=Helper.correctNull((String) hshValues.get("amtreqd"))%>
										</td>
										<td width="19%" align="center"><%=Helper.correctNull((String) hshValues.get("mintrate"))%>%
										</td>
										<td width="16%" align="center"><lapschoice:CurrencyTag name="txt_EMI"	
								 	value='<%=Helper.correctNull((String) hshValues.get("emi"))%>' other="readOnly" /></td>
										<td width="11%" align="center"><%=Helper.correctNull((String) hshValues.get("lreqterms"))%>
										<input type="hidden" name="txt_repaycapacity"
								 	value='<%=Helper.correctNull((String) hshValues.get("repaycapacity"))%>' other="readOnly" />&nbsp; </td>
									</tr>
								</table>
								</td>
							</tr>
							<!-- <tr>
								<td><b>Experience and Service</b></td>
							</tr> -->
							<tr>
								<td>
								<table width="100%" border="0" cellspacing="1" cellpadding="2"  class="outertable">
									<tr class="dataheader">
										<td width="14%" align="center" nowrap><b>Type</b></td>
										<td width="18%" align="center" nowrap><b>Name</b></td>
										<td width="15%" align="center" nowrap><b>Relationship</b></td>
										<td width="10%" align="center" nowrap><b>Date of Birth</b></td>
										
                             		</tr>
									<%ArrayList vecReport = new ArrayList();
			int vecRsize = 0;
			if (hshValues != null) {
				vecReport = (ArrayList) hshValues.get("vecReport");
			}
			if (vecReport != null) {
				vecRsize = vecReport.size();
			}
			ArrayList b1 = null;
			for (int l = 0; l < vecRsize; l++) {
				int colSize = 0;
				if (l < vecRsize) {
					b1 = (ArrayList) vecReport.get(l);
					if (b1 != null) {
						colSize = b1.size();
					}
				}
				if (colSize > 0) {
					%>
									<tr>
										<td nowrap><%=Helper.correctNull((String) b1
											.get(0))%></td>
										<td><%=Helper.correctNull((String) b1
											.get(1))%></td>
										<td nowrap><%=Helper.correctNull((String) b1
											.get(5))%></td>
										<td nowrap align="center"><%=Helper.correctNull((String) b1
											.get(6))%></td>
									<%--<td><%=Helper.correctNull((String) b1
											.get(8))%></td>
											<td nowrap><%=Helper.correctNull((String) b1
											.get(6))%></td>
										<td nowrap><%=Helper.correctNull((String) b1
											.get(9))%></td>
										<td nowrap align="right"><%=Helper.correctNull((String) b1.get(18))%>
										</td> --%>
									</tr>
									<%}
			}

			%>
									<tr>
										<td bgcolor="" width="14%">&nbsp;</td>
										<td bgcolor="" width="18%">&nbsp;</td>
										<td bgcolor="" width="15%">&nbsp;</td>
										<td bgcolor="" nowrap width="10%">&nbsp;</td>
										<%--<td bgcolor="" nowrap width="10%">&nbsp;</td>
										<td bgcolor="" nowrap width="11%">&nbsp;</td>
										 <td bgcolor="" nowrap width="9%">&nbsp;</td>
										<td bgcolor="" nowrap width="13%">&nbsp;</td>--%>
									</tr>
								</table>
								</td>
							</tr>
							<tr>
								<td>
								
                          <table width="100%%" border="0" cellspacing="1" cellpadding="3" class="outertable">
                            <tr> 
                              <td width="15%">Date of Appraisal</td>
                              <td width="15%"> 
                                <table border="0" cellspacing="0" cellpadding="4">
                                  <tr> 
                                    <td>
                                      <input type="text" name="appraisaldate" size="11"
													maxlength="10" readOnly onBlur="checkDate(this);checkmaxdate(this,currdate)"
													value="<%=Helper.correctNull((String)hshValues.get("apprisal_Date"))%>" >
                                    </td>
                                    <td><a alt="Select date from calender" href="#"
													onClick="callCalender1()"
													onMouseOver="window.status='Date Picker';return true;"
													onMouseOut="window.status='';return true;"><img
													src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
													border=0 alt="Select date from calender" align="middle"></a></td>
                                  </tr>
                                </table>
                              </td>
                              <td width="15%" nowrap>Appraised by</td>
                              <td width="35%"> 
                                <table border="0" cellspacing="0" cellpadding="4" class="outertable">
                                  <tr> 
                                    <td>
                                      <input type="hidden" name="txt_userid" size="10"
													maxlength="30" readonly
													value="<%=Helper.correctNull((String)hshValues.get("Apprised_by"))%>">
                                      <input type="text" name="appraisedby" size="30"
													maxlength="30" readonly
													value="<%=Helper.correctNull((String)hshValues.get("username"))%>">
                                      <a href="#" onClick="javascript:callUsersHelp()"><b
													class="blackfont"><img
													src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
													border="0"> </b></a></td>
                                  </tr>
                                </table>
                              </td>
                            </tr>
                            <tr>
                            <%
                            String strsanctionedamt="";
                            if(!(Helper.correctNull((String)hshValues.get("username")).trim().equals("")))
                            {
                            	strsanctionedamt=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("sanction_amount"))));
                            }
                            %>
                              <td width="15%">Sanction Loan amount</td>
                              <td width="15%">
                              	<lapschoice:CurrencyTag name="txt_sanction_amount" value='<%=strsanctionedamt%>' 
                              	size="13" maxlength="9" onBlur="checkamt();" /> 
							</td>
                              <td width="15%" nowrap>&nbsp;</td>
                              <td width="35%">&nbsp;</td>
                            </tr>
                          </table>
								</td>
							</tr>
							<tr>
								<td><br>
								<table width="12%" border="0" align="center" cellpadding="0" cellspacing="0" class="outertable">
									<tr>
										<td>
										<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
											<tr valign="top">
												
												<td><input type="button" name="cmdcropgenlab"
													value="Sanction Advice"
													onClick="callcropgenloan('sanctionadvice_dairy.jsp')"
													class="buttonPrint" style="width:100">
												</td>
												
												<%if (prd_type.equalsIgnoreCase("aF")) {%>

												<td><input type="button" name="cmdcropgenlab"
													value="Farm Mechanisation Economics"
													onClick="callFormMechnisation('agr_farmmech.jsp')"
													class="buttonPrint" style="width:190">
												</td>
												<%}%>
												
												<%if (prd_type.equalsIgnoreCase("aU")) {%>

												<td><input type="button" name="cmdcropgenlab" value="Minor Irrigation Economics"
													onClick="callMinorEconomic('agr_minorirrieconomic.jsp')"
													class="buttonPrint" style="width:190">
												</td>
												<%}%>
												
                                    <td><input type="button" name="cmdprocessnote" value="Process Note" 
                                    		onClick="callprocessnote()" class="buttonPrint" style="width:120">
												</td>
												
                                    											
											</tr>
										</table>
										</td>
									</tr>
								</table>
								</td>
							</tr>
		<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
							
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
<lapschoice:agrihiddentag pageid='<%=PageId%>'/>
<input type="HIDDEN" name="prdcode" value="<%=Helper.correctNull((String)hshValues.get("prdcode")) %>"> 
<input type="hidden" name="hidBeanMethod1" value=""> 
<input type="hidden" name="txtverf_doneby" >	
<input type="hidden" name="hidBeanGetMethod1" value="">	
<input type="hidden" name="hidCheckAgr" value="Y">	
<input type="hidden" name="hidValid" value = "Y">	
<iframe name="ifrm" width="0" height="0" border="0">
<input type="hidden" name="hidRecordflag" value="<%=Helper.correctNull((String)hshValues.get("recordflag"))%>"> 
</form>
</body>
</html>