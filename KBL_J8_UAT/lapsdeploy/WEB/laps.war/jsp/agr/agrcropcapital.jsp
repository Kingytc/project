<%@include file = "../share/directives.jsp"%>

<%ArrayList arryCol = new ArrayList();
			ArrayList arryRow = new ArrayList();
			arryRow = (ArrayList) hshValues.get("arryRow");
			if (arryRow == null) {
				arryRow = new ArrayList();
			}
			String d1 = "", d11 = "", d21 = "";
			String d31 = "", d41 = "", d51 = "";
			String s1 = "", s2 = "", s3 = "";
			String s11 = "", s12 = "", s13 = "";
			String s21 = "", s22 = "", s23 = "";
			String s31 = "", s32 = "", s33 = "";
			String s41 = "", s42 = "", s43 = "";
			String s51 = "", s46 = "", s47 = "";
			String Repayment= "",intrate = "";
			
%>
<html>
<head>
<title>LAPS - Working Capital Details</title>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var id ="";
var apptype="";
var varApptype=new Array();
var varAcctype=new Array();
var varAcctype1=new Array();
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var  strid="<%=Helper.correctNull((String)hshValues.get("strid"))%>";
var  strAction="<%=Helper.correctNull((String)hshValues.get("strAction"))%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
function checkintrate()
{
var txt_roiWC=document.forms[0].txt_roiWC.value;
if(txt_roiWC=="")
{
txt_roiWC="0";
}
if(txt_roiWC>100)
{
alert("rate of interest cannot exceed 100%");
document.forms[0].txt_roiWC.value="";
document.forms[0].txt_roiWC.focus();
return;
}
}
function placevalues()
{	
	<%
	if((arryRow.size()!= 0) || (arryRow!=null))
	{	
		for(int i=0;i<arryRow.size();i++)
		{
			arryCol=(ArrayList)arryRow.get(i);		
			if((arryCol!=null) || (arryCol.size()!=0))
			{																
				%> 
		        document.forms[0].txt_activity[<%=i%>].value="<%=Helper.correctNull((String)arryCol.get(4))%>"; 
				document.forms[0].txt_units[<%=i%>].value="<%=Helper.correctNull((String)arryCol.get(5))%>";
				document.forms[0].txt_particular[<%=i%>].value="<%=Helper.correctNull((String)arryCol.get(6))%>";
				document.forms[0].txt_req[<%=i%>].value="<%=Helper.correctNull((String)arryCol.get(7))%>";
				<%
			}
		}	
	}	
%>
}

function enableButtons( booledit, boolsave , boolcancel, booldelete, boolclose)
{
	document.forms[0].cmdedit.disabled=booledit;
	document.forms[0].cmdsave.disabled=boolsave;
	document.forms[0].cmdcancel.disabled=boolcancel;
	document.forms[0].cmddelete.disabled=booldelete;
	document.forms[0].cmdclose.disabled = boolclose;
}

function doClose()
{
	if( ConfirmMsg(100))
	{
		document.forms[0].target="_parent";
		document.forms[0].action=appURL+"action/"+"retailpge.jsp";				
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
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=one;
		}
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=one;		  
		}		
	}	
}

function doSave()

{   
//roundtxt(document.forms[0].txt_roiWC);  
	if(document.forms[0].txt_roiWC.value == "")
	{
	alert("Enter the Margin");
	document.forms[0].txt_roiWC.focus();
	return;
	
	}
	if(document.forms[0].txt_repaymentWC.value == "")
	{
	alert("Enter the Repayment Period");
	document.forms[0].txt_repaymentWC.focus();	
	return;
	}
	enableButtons(true, true, true, true, false);	
	document.forms[0].hidBeanId.value="agrcrops";
	document.forms[0].hidSourceUrl.value="/action/agrcropcapital.jsp";
	document.forms[0].hidBeanMethod.value="updateCapitalData";
	document.forms[0].hidBeanGetMethod.value="getCapitalData";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
	
}

function doEdit()
{
 	disableFields(false); 	
	document.forms[0].hideditflag.value ="Y";
	document.forms[0].hidAction.value ="insert";
	enableButtons(true, false, false, false, true);	
}

function callhelp()
{
	var varQryString = appURL+"/jsp/perhlp/hlp_cropwc.jsp"
	var title = "ApplicantDemographics";
	var prop = "scrollbars=no,width=600,height=450";	
	prop = prop + ",left=200,top=150";
	window.open(varQryString,title,prop);
}
 
function doCancel()
{   
	if(ConfirmMsg(102))
	{
		//document.forms[0].hidSourceUrl.value="/action/agrcropcapital.jsp";
		document.forms[0].hidBeanId.value="agrcrops";
		//document.forms[0].hidBeanMethod.value="getCapitalData";
		document.forms[0].hidBeanGetMethod.value="getCapitalData";
		document.forms[0].action=appURL+"action/agrcropcapital.jsp";
		document.forms[0].submit(); 		
	}
	
}

function doDelete()
{
   if( ConfirmMsg(101))
	{
	document.forms[0].hidAction.value ="delete";
	document.forms[0].action=appURL+"action/ControllerServlet";		
	document.forms[0].hidBeanMethod.value="updateCapitalData";
	document.forms[0].hidBeanId.value="agrcrops";
	document.forms[0].hidSourceUrl.value="action/agrcropcapital.jsp";	
	document.forms[0].hidBeanGetMethod.value="getCapitalData";
	document.forms[0].method="post";			
	document.forms[0].submit();		
	}
}
	
function onloading()
{	 
	disableFields(true);	
}

function call_page(url)
{	
	document.forms[0].action=appURL+"action/"+url;
	document.forms[0].submit();	
}

function totamount()
{
	var temp=0;
	var temp1=0;
	for(var i=0; i<6; i++)
	{
		temp = document.forms[0].txt_req[i].value;
		roundtxt(document.forms[0].txt_req[i]);
		if(temp=="")
		{
			temp=0;
		}
		temp1 = eval(temp1) + eval(temp);
	}
	document.forms[0].txt_totalreq.value=temp1;
	roundtxt(document.forms[0].txt_totalreq);
	
	
}

</script>

</head>
<body onLoad="onloading();totamount()">
<form name="aa" method=post  class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3"
			class="outertable border1">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                <tr> 
                  <td colspan="5"> <table width="100%" border="0" cellspacing="1"
							cellpadding="3" class="outertable">
                      <tr class="dataheader"> 
                        <td colspan="4"><b>
									Working Capital Requirement 
                          for allied activities</b></td>
                      </tr>
                      <tr align="center" class="dataheader"> 
                        <td width="30%"><b>Activity</b></td>
                        <td width="23%"><b>Physical Units</b></td>

                        <td width="23%"><b>Particulars</b></td>
                        <td width="23%"><b>Amount 
                          Required</b> </td>
                      </tr>
                    </table></td>
                </tr>
                <tr > 
                  <%if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(0);
				if (arryCol.size() != 0) {
					s1 = Helper.correctNull((String) arryCol.get(4));
					d1 = Helper.correctNull((String) arryCol.get(5));
					s2 = Helper.correctNull((String) arryCol.get(6));
					s3 = Helper.correctNull((String) arryCol.get(7));
					Repayment = Helper.correctNull((String) arryCol.get(10));
					intrate = Helper.correctNull((String) arryCol.get(9));
				}

			} else if (arryRow.size() == 0) {

			}

			%>
                  <td width="30%"><input type="text" name="txt_activity" size="50"
							maxlength="40" value="<%=s1%>" onKeyPress="notAllowSingleQuote();notAllowSplChar()"></td>
                  <td width="23%" align="center"><input type="text" name="txt_units"
							size="30" maxlength="9" value="<%=d1%>"
							onKeyPress="allowNumber(this)" style="text-align:left"></td>
                  <td colspan="2" align="center"> <input type="text"
							name="txt_particular" size="30" maxlength="20" value="<%=s2%>"
							onKeyPress="notAllowSingleQuote();notAllowSplChar()"></td>
                  <td width="24%" align="center"> <input type="text" name="txt_req"
							size="30" maxlength="6" value="<%=s3%>"
							onKeyPress="allowNumber(this)" style="text-align:right" onBlur="totamount()"></td>
                </tr>
                <tr > 
                  <%if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(1);

				if (arryCol.size() != 0) {

					s11 = Helper.correctNull((String) arryCol.get(4));
					d11 = Helper.correctNull((String) arryCol.get(5));
					s12 = Helper.correctNull((String) arryCol.get(6));
					s13 = Helper.correctNull((String) arryCol.get(7));

				}
			} else if (arryRow.size() == 0) {
			}

			%>
                  <td><input type="text" name="txt_activity" size="50"
							maxlength="40" value="<%=s11%>"
							onKeyPress="notAllowSingleQuote();notAllowSplChar()"></td>
                  <td align="center"><input type="text" name="txt_units" size="30"
							maxlength="9" value="<%=d11%>" onKeyPress="allowNumber(this)"
							style="text-align:left"></td>
                  <td colspan="2" align="center"><input type="text" name="txt_particular"
							size="30" maxlength="20" value="<%=s12%>"
							onKeyPress="notAllowSingleQuote();notAllowSplChar()"></td>
                  <td align="center"><input type="text" name="txt_req" size="30"
							maxlength="6" value="<%=s13%>" onKeyPress="allowNumber(this)" onBlur="totamount()"
							style="text-align:right"></td>
                </tr>
                <tr > 
                  <%if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(2);

				if (arryCol.size() != 0) {

					s21 = Helper.correctNull((String) arryCol.get(4));
					d21 = Helper.correctNull((String) arryCol.get(5));
					s22 = Helper.correctNull((String) arryCol.get(6));
					s23 = Helper.correctNull((String) arryCol.get(7));
				}
			} else if (arryRow.size() == 0) {
				
			}
			%>
                  <td><input type="text" name="txt_activity" size="50"
							maxlength="40" value="<%=s21%>"
							onKeyPress="notAllowSingleQuote();notAllowSplChar()"></td>
                  <td id="r1" align="center"><input type="text" name="txt_units"
							size="30" maxlength="9" value="<%=d21%>"
							onKeyPress="allowNumber(this)" style="text-align:left"></td>
                  <td colspan="2" align="center" id="r2"><input type="text"
							name="txt_particular" size="30" maxlength="20" value="<%=s22%>"
							onKeyPress="notAllowSingleQuote();notAllowSplChar()"></td>
                  <td id="r2" align="center"><input type="text" name="txt_req"
							size="30" maxlength="6" value="<%=s23%>"
							onKeyPress="allowNumber(this)" onBlur="totamount()" style="text-align:right"></td>
                </tr>
                <tr > 
                  <%if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(3);

				if (arryCol.size() != 0) {

					s31 = Helper.correctNull((String) arryCol.get(4));
					d31 = Helper.correctNull((String) arryCol.get(5));
					s32 = Helper.correctNull((String) arryCol.get(6));
					s33 = Helper.correctNull((String) arryCol.get(7));

				}

			} else if (arryRow.size() == 0) {
			}

			%>
                  <td><input type="text" name="txt_activity" size="50"
							maxlength="40" value="<%=s31%>"
							onKeyPress="notAllowSingleQuote();notAllowSplChar()"></td>
                  <td id="r7" align="center"><input type="text" name="txt_units"
							size="30" maxlength="9" value="<%=d31%>"
							onKeyPress="allowNumber(this)" style="text-align:left"></td>
                  <td colspan="2" align="center"><input type="text" name="txt_particular"
							size="30" maxlength="20" value="<%=s32%>"
							onKeyPress="notAllowSingleQuote();notAllowSplChar()"></td>
                  <td align="center"><input type="text" name="txt_req" size="30"
							maxlength="6" value="<%=s33%>" onKeyPress="allowNumber(this)" onBlur="totamount()"
							style="text-align:right"></td>
                </tr>
                <tr > 
                  <%if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(4);

				if (arryCol.size() != 0) {

					s41 = Helper.correctNull((String) arryCol.get(4));
					d41 = Helper.correctNull((String) arryCol.get(5));
					s42 = Helper.correctNull((String) arryCol.get(6));
					s43 = Helper.correctNull((String) arryCol.get(7));

				}

			} else if (arryRow.size() == 0) {

			}

			%>
                  <td><input type="text" name="txt_activity" size="50"
							maxlength="40" value="<%=s41%>"
							onKeyPress="notAllowSingleQuote();notAllowSplChar()"></td>
                  <td align="center"><input type="text" name="txt_units" size="30"
							maxlength="9" value="<%=d41%>" onKeyPress="allowNumber(this)"
							style="text-align:left"></td>
                  <td colspan="2" align="center"><input type="text" name="txt_particular"
							size="30" maxlength="20" value="<%=s42%>"
							onKeyPress="notAllowSingleQuote();notAllowSplChar()"></td>
                  <td align="center"><input type="text" name="txt_req" size="30"
							maxlength="6" value="<%=s43%>" onKeyPress="allowNumber(this)" onBlur="totamount()"
							style="text-align:right"></td>
                </tr>
                <tr > 
                  <%if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(5);

				if (arryCol.size() != 0) {

					s51 = Helper.correctNull((String) arryCol.get(4));
					d51 = Helper.correctNull((String) arryCol.get(5));
					s46 = Helper.correctNull((String) arryCol.get(6));
					s47 = Helper.correctNull((String) arryCol.get(7));

				}

			} else if (arryRow.size() == 0) {
			}

			%>
                  <td><input type="text" name="txt_activity" size="50"
							maxlength="40" value="<%=s51%>"
							onKeyPress="notAllowSingleQuote();notAllowSplChar()"></td>
                  <td align="center"><input type="text" name="txt_units" size="30"
							maxlength="9" value="<%=d51%>" onKeyPress="allowNumber(this)"
							style="text-align:left"></td>
                  <td colspan="2" align="center"><input type="text" name="txt_particular"
							size="30" maxlength="20" value="<%=s46%>"
							onKeyPress="notAllowSingleQuote();notAllowSplChar()"></td>
                  <td align="center"><input type="text" name="txt_req" size="30"
							maxlength="6" value="<%=s47%>" onKeyPress="allowNumber(this)" onBlur="totamount()"
							style="text-align:right"></td>
                </tr>
                <tr > 
                  <td>&nbsp;</td>
                  <td align="center">&nbsp;</td>
                  <td width="3%" align="left">&nbsp;</td>
                  <td width="20%" align="left"><b>Total 
                    Amount </b></td>
                  <td align="center"><input type="text" name="txt_totalreq" size="30"
							maxlength="9" value="" onKeyPress="allowNumber(this)"
							style="text-align:right" ></td>
                </tr>
                <tr > 
                  <td>&nbsp;</td>
                  <td align="center">&nbsp;</td>
                  <td align="left"><b></b></td>
                  <td align="left"><b>Margin 
                    %&nbsp;<span class="mantatory">&nbsp;*</span></b></td>
                  <td align="center"><input type="text" name="txt_roiWC" size="30"
							maxlength="6" value="<%=intrate%>" onKeyPress="allowNumber(this)"
							style="text-align:right" onBlur="checkPercentage(this);" ></td>
                </tr>
                <tr > 
                  <td>&nbsp;</td>
                  <td align="center">&nbsp;</td>
                  <td align="left"><b></b></td>
                  <td align="left"><b>Renewal period
                    &nbsp;<span class="mantatory">*</span></b></td>
                  <td align="center"><input type="text" name="txt_repaymentWC" size="30"
							maxlength="3" value="<%=Repayment%>" onKeyPress="allowNumber(this)"
							style="text-align:right" ></td>
                </tr>
              </table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	
	 <lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
 
	<tr>
		<td>
		<table>
			<tr>
				<td><lapschoice:agrihiddentag pageid='<%=PageId%>'/>
				
				
				<input type="hidden" name="selsno" value=""> 
				<input type="hidden" name="hidcroptype" value=""> 
				<input type="hidden" name="hid_sno" value="<%=Helper.correctNull((String)hshValues.get("strid"))%>">
				<input type="hidden" name="hidRecordflag" value="<%=Helper.correctNull((String)hshValues.get("recordflag")) %>"> 
			</tr>
		</table>
		</td>
	</tr>
</table>

</form>
</body>
</html>
