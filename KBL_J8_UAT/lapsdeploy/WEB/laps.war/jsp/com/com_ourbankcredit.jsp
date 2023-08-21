<%@include file="../share/directives.jsp"%>
<%String strappno = Helper.correctNull((String)request.getParameter("strAppno"));

ArrayList arrRow	= new ArrayList();
ArrayList arrCol	= new ArrayList();
if(hshValues!=null)
{
	arrRow	= (ArrayList)hshValues.get("arrRow");
}
int intSize=0;
if(arrRow!=null&&arrRow.size()>0)
{ intSize	= arrRow.size();}
%>
<html>
<head>
<title>Credit Facility from Our Bank</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var strAppno = "<%=Helper.correctNull((String)hshValues.get("appno"))%>";
var appstatus = "<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
var currdate = "<%=Helper.getCurrentDateTime()%>";
function callCalender(fname)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
	 showCal("<%=ApplicationParams.getAppUrl()%>",fname);
	}
}

function onloading()
{	
	if(appstatus=="Open/Pending")
	{
		if(document.forms[0].hidNonPoolFlag.value=="Y")
		{
			disableCommandButtons("disableall");
		}
		else
		{
			disableCommandButtons("load");
		}
	}
	else
	{
		disableCommandButtons("disableall");
	}
  	disableFields(true);
  	document.getElementById("workcapital").style.display = "none";
 	document.getElementById("termloan1").style.display = "none";
	document.getElementById("termloan2").style.display = "none";
	document.getElementById("mand").style.display = "none";
	document.getElementById("Share").style.display = "none";
	document.getElementById("share1").style.display = "none";
}

function selectValues(val1,val2,val3,val4,val5,val6,val7,val8,val9,val10,val11,val12,val13,val14,val15,val16,val17,val18,val19,val20,val21,val22)
{
	document.forms[0].strAppno.value = val1;
	document.forms[0].hidgen_sno.value = val2;
	document.forms[0].facilityname.value = val3;
	document.forms[0].hidsno.value = val3;
	document.forms[0].txt_membname.value = val4;
	document.forms[0].txt_Exishare.value = val5;
	document.forms[0].txt_Propshare.value = val21;
	document.forms[0].txt_share1.value = val6;
	document.forms[0].txt_existfund.value = val7;
	document.forms[0].txt_share2.value = val8;
	document.forms[0].txt_existnonfund.value = val9;
	document.forms[0].txt_share3.value = val10;
	document.forms[0].txt_proposalfund.value = val11;
	document.forms[0].txt_share4.value = val12;
	document.forms[0].txt_proposalnonfund.value = val13;
	document.forms[0].txt_limit.value = val14;
	document.forms[0].txt_outstanding.value = val15;
	document.forms[0].txt_outstandingason.value = val16;
	document.forms[0].hidbanking.value = val17;
	document.forms[0].hidcredit.value = val18;
	document.forms[0].hidourother.value = val19;
	document.forms[0].facilityname.value = val20;
	document.forms[0].hidmembnamecode.value = val22;
	disableFields(true);
	showhide();
			 
	if(appstatus=="Open/Pending")
	{		
		disableCommandButtons("radioselect");
	}
	else
	{
		disableCommandButtons("disableall");
	}
}

function showhide()
{
	var selval = document.forms[0].facilityname.value;
	var type = selval.split("~");
	if(type[1]=="1" || type[1]=="W")
	{
		document.getElementById("workcapital").style.display = "none";
		document.getElementById("termloan1").style.display = "table";
		document.getElementById("termloan2").style.display = "table";
		//document.getElementById("normal").style.display = "block";
		document.getElementById("mand").style.display = "table-cell";
		document.getElementById("Share").style.display = "table-cell";
		document.getElementById("share1").style.display = "table-row";
	}
	else if(type[1]=="2" || type[1]=="T")
	{
		document.getElementById("workcapital").style.display = "table";
		document.getElementById("termloan1").style.display = "none";
		document.getElementById("termloan2").style.display = "none";
		//document.getElementById("normal").style.display = "none";
		document.getElementById("mand").style.display = "none";
		document.getElementById("Share").style.display = "none";
		document.getElementById("share1").style.display = "none";
	}
}

function clearFields()
{
	document.forms[0].txt_Exishare.value ="";
	document.forms[0].txt_existfund.value = "";
	document.forms[0].txt_existnonfund.value= "";
	document.forms[0].txt_proposalfund.value= "";
	document.forms[0].txt_proposalnonfund.value= "";
	document.forms[0].txt_membname.value= "";
	document.forms[0].txt_share1.value= "0";
	document.forms[0].txt_share2.value= "0";
	document.forms[0].txt_share3.value= "0";
	document.forms[0].txt_share4.value= "0";
	document.forms[0].txt_outstandingason.value= "";
	document.forms[0].txt_outstanding.value= "";
	document.forms[0].txt_limit.value= "";	
}

function doSave()
{	
	if(document.forms[0].facilityname.value=="0")
	{
		ShowAlert(111,"Facility");
		document.forms[0].facilityname.focus();
		return;
	}
	if(trim(document.forms[0].txt_membname.value)=="" )
	{
		ShowAlert(111,"Name Of The Member Bank");
		return;
	}
	var selval = document.forms[0].facilityname.value;
	var type = selval.split("~");
	if(type[1]=="1" || type[1]=="W")
	{
		if(trim(document.forms[0].txt_Exishare.value)==""||trim(document.forms[0].txt_Exishare.value)=="0")
		{
			ShowAlert(121,"Existing Percentage Share");
			document.forms[0].txt_share1.value="";
			document.forms[0].txt_share1.focus();
			return;
		}

		if(trim(document.forms[0].txt_Propshare.value)==""||trim(document.forms[0].txt_Propshare.value)=="0")
		{
			ShowAlert(121,"Proposed Percentage Share");
			document.forms[0].txt_share3.value="";
			document.forms[0].txt_share3.focus();
			return;
		}			
	}		
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidBeanId.value="comproposal";
	document.forms[0].hidSourceUrl.value="/action/com_ourbankcredit.jsp?appstatus="+appstatus;
	document.forms[0].hidBeanMethod.value="updateourBankcreditDetails";
	document.forms[0].hidBeanGetMethod.value="getourBankcreditDetails";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();	
}

function disableCommandButtons(val)
{
	if(val=="load")
	{  
		disableFields(true);
		document.forms[0].cmdnew.disabled =false;
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;		 
		document.forms[0].cmdcomments.disabled=false;		 
	}
	if(val=="edit")
	{	 
		 document.forms[0].cmdnew.disabled =true;
		 document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmddelete.disabled=true;
		 document.forms[0].cmdsave.disabled=false;
		 document.forms[0].cmdcancel.disabled=false;		 
		 document.forms[0].cmdclose.disabled=true;	
		 document.forms[0].cmdcomments.disabled=false;
		 disableFields(false);
	}
	if(val=="radioselect")
	{	 
		disableFields(true);
		document.forms[0].cmdnew.disabled =true;
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmddelete.disabled=false;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=false;
		document.forms[0].cmdclose.disabled=false;
		document.forms[0].cmdcomments.disabled=false;
	}	  
	if(val=="disableall")
	{
		disableFields(true);
		document.forms[0].cmdnew.disabled =true;
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;
		document.forms[0].cmdcomments.disabled=true;
	}
}

function doEdit()
{
	disableFields(false);
	document.forms[0].hidAction.value = "update";
	disableCommandButtons("edit");
	document.forms[0].txt_membname.readOnly="readonly";
	document.forms[0].strAppno.value = "<%=strappno%>";
	document.forms[0].txt_Exishare.readOnly = true;
	document.forms[0].txt_Propshare.readOnly = true;	
}

function doNew()
{	
	disableCommandButtons("edit");	  
	clearFields();
	document.forms[0].facilityname.value ="0";	
	document.forms[0].hidAction.value ="insert";
	document.forms[0].strAppno.value = "<%=strappno%>";
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='radio')
	 	{
			document.forms[0].elements[i].checked=false;
		}	  
	}
	document.forms[0].txt_membname.readOnly=true;
	document.forms[0].txt_Exishare.readOnly = true;
	document.forms[0].txt_Propshare.readOnly = true;
}

function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanGetMethod.value="getourBankcreditDetails";
		document.forms[0].hidBeanId.value="comproposal";
		document.forms[0].action=appURL+"action/com_ourbankcredit.jsp?appstatus="+appstatus;
		document.forms[0].submit();		
	}	
}

function disableFields(val)
{
  for(var i=0;i<document.forms[0].length;i++)
  {
	  if(document.forms[0].elements[i].type=='text'  )
	  {
		document.forms[0].elements[i].readOnly=val;
	  }	  
	   if(document.forms[0].elements[i].type=='textarea'  )
	  {
		document.forms[0].elements[i].readOnly=val;
	  }	  
	  if(document.forms[0].elements[i].type=='select-one'  )
	  {
		document.forms[0].elements[i].disabled=val;
	  }	 
  }	  
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value="delete";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidBeanId.value="comproposal";
		document.forms[0].hidSourceUrl.value="/action/com_ourbankcredit.jsp?appstatus="+appstatus;
		document.forms[0].hidBeanMethod.value="updateourBankcreditDetails";
		document.forms[0].hidBeanGetMethod.value="getourBankcreditDetails";	
		document.forms[0].submit();
    }
}

function hidedata()
{
	clearFields();
	var selval = document.forms[0].facilityname.value;
	var type = selval.split("~");
	if(type[1]=="1" || type[1]=="W")
	{
	document.getElementById("workcapital").style.display = "none";
	document.getElementById("termloan1").style.display = "table";
	document.getElementById("termloan2").style.display = "table";
	//document.getElementById("normal").style.display = "block";
	document.getElementById("mand").style.display = "table-cell";
	document.getElementById("Share").style.display = "table-cell";
	document.getElementById("share1").style.display = "table-row";
		
	}
	else if(type[1]=="2" || type[1]=="T")
	{
	
		document.getElementById("workcapital").style.display = "table";
		document.getElementById("termloan1").style.display = "none";
		document.getElementById("termloan2").style.display = "none";
		//document.getElementById("normal").style.display = "none";
		document.getElementById("mand").style.display = "none";
		document.getElementById("Share").style.display = "none";
		document.getElementById("share1").style.display = "none";
	}
	document.forms[0].hidsno.value = type[2];
	document.forms[0].hidcredit.value = type[3];
	document.forms[0].hidbanking.value = type[4];
}

function chkmaxpercentage(obj)
{
	if(obj.value=="")
		obj.value="0";
	var a = parseInt(document.forms[0].txt_share1.value);
	var b = parseInt(document.forms[0].txt_share2.value);
	var c = parseInt(document.forms[0].txt_share3.value);
	var d = parseInt(document.forms[0].txt_share4.value);
	var share = parseInt(document.forms[0].txt_Exishare.value);
	var totpercent = eval(a)+eval(b)+eval(c)+eval(d);
	if(eval(totpercent)>eval(share))
	{
		alert("Total percentage should not be greater than "+share+"%");
		obj.value = "";
		obj.focus();		
	}
}

function sumExistingpercent(obj)
{
	var a = parseFloat(document.forms[0].txt_share1.value);
	var b = parseFloat(document.forms[0].txt_share2.value);
	var totpercent=eval(a)+eval(b);

	if(eval(totpercent)>100)
	{
		alert("Sum of Existing funded and non-funded Share(%) should not be greater than 100%");
		obj.value = "";
		obj.focus();
	}
	else
	{
		document.forms[0].txt_Exishare.value=totpercent;
	}
		
}

function sumProposedpercent(obj)
{
	var a = parseFloat(document.forms[0].txt_share3.value);
	var b = parseFloat(document.forms[0].txt_share4.value);
	var totpercent=eval(a)+eval(b);

	if(eval(totpercent)>100)
	{
		alert("Sum of Proposed funded and non-funded Share(%) should not be greater than 100%");
		obj.value = "";
		obj.focus();
	}
	else
	{
		document.forms[0].txt_Propshare.value=totpercent;
	}
		
}

function chklimit(obj)
{
	var limit = document.forms[0].txt_limit.value;
	var os = document.forms[0].txt_outstanding.value;
	if(eval(os)>eval(limit))
	{
		alert("The Outstanding Amount Should be lesser than the Limit given");
		obj.value = "";
		obj.focus();
	}
}

function doComments()
{
	var hidAppNo = <%=strappno%>;
	var prop = "scrollbars=no,width=750,height=550,top=25,left=180";
	var url=appURL+"action/com_bankingcomments.jsp?hidBeanId=facilities&hidBeanGetMethod=getComments&hidAppNo="+hidAppNo+"&hidPage1=ourbankcomments";
	window.open(url,"Comments",prop);
}

function callBankmaster(id)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
			var varQryString = appURL+"action/ops_sanctionhelp.jsp?hidBeanGetMethod=getSearch&hidBeanId=additionalParameter&pagename=Bankingdetail&id="+id;
			var title = "Bank_Master";
			var prop = "scrollbars=no,width=650,height=400";
			var xpos = "50";
			var ypos = "50";
			prop = prop+","+xpos+","+ypos+",left=200,top=200";
			window.open(varQryString,title,prop);
	}
}

function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		window.close();
	}
} 
</script>
</head>
<body onload="onloading();">
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
</script>
</div></div>
<form name="ourcredit" method="post" class="normal"><br>
<!-- <span style="visibility: hidden;"><lapschoice:application /></span>-->
<table width="100%" border="0" cellpadding="2" cellspacing="0" class="outertable" align="center">
 <tr>
	<td>
		<table width="100%" border="0" cellspacing="1" cellpadding="2" class="outertable">
				<tr>
				<td colspan="4">
				<table width="100%" border="0" cellspacing="1" cellpadding="2" class="outertable">
				<tr class="dataheader">
					<td align="center" width="33%">Nature&nbsp;<span class="mantatory">*</span></td>
					<td align="center" width="34%">Name of Member Bank&nbsp;<span class="mantatory">*</span></td>
					<td align="center" width="33%" id="mand">Share(%)<span class="mantatory">*</span></td>
				</tr>
				<tr class="dataheader" id="share1">
				<td colspan="2">&nbsp;</td>
				<td><table width="100%" border="0"><tr class="dataheader"><td align="center">Existing</td><td align="center">Proposed</td></tr></table></td>
				</tr>
				<tr class="datagrid">
					<td align="center"><select
						name="facilityname" onChange="hidedata();">
						<option value="0" selected>&lt;----Select----&gt;</option>
						<lapschoice:bafacility bankflag="our"/>
					</select></td>
					<td align="center"><INPUT TYPE="text"
						NAME="txt_membname" SIZE="30" MAXLENGTH="20"
						ONKEYPRESS="allowAlphabetsAndSpaceInt(this)" readonly="readonly">
						<INPUT TYPE="hidden" name="hidmembnamecode" value="">
						<a href="#" onClick="callBankmaster('147')" style="cursor: hand">
									<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0">
									</a>
						</td>
					<td align="center" id="Share">
					<table width="100%" border="0"><tr><td align="center">
					<input type="text"
						name="txt_Exishare" style="text-align: right" size="20"
						maxlength="20" onBlur="checkPercentage(this)"
						onKeyPress="allowNumber(this)" readonly="readonly">
						</td>
						<td align="center">
					<input type="text"
						name="txt_Propshare" style="text-align: right" size="20"
						maxlength="20" onBlur="checkPercentage(this)"
						onKeyPress="allowNumber(this)" readonly="readonly">
						</td>
						</tr></table>
					</td>
				</tr>
				</table>
				</td></tr><tr><td>
				<table id="termloan1" width="100%" border="0" cellspacing="1" cellpadding="4" align="center" class="outertable">
					<tr>
						<td colspan="4"><B>Existing:</B></td>
					</tr>
					<tr class="dataheader">
						<td colspan="2" align="center">Funded</td>
						<td colspan="2" align="center">Non-funded</td>
					</tr>
					<tr class="dataheader">
						<td align="center" width="25%">Share(%)
						</td>
						<td align="center" width="25%">Amount
						</td>
						<td align="center" width="25%">Share(%)
						</td>
						<td align="center" width="25%">Amount
						</td>
					</tr>
					<tr class="datagrid">
						<td align="center"><INPUT TYPE="text" NAME="txt_share1"
							style="text-align: right" size="20" maxlength="20"
							onBlur="checkPercentage(this);sumExistingpercent(this)" onKeyPress="allowNumber(this)"></td>
						<td align="center"><input type="text" name="txt_existfund"
							style="text-align: right" onKeyPress="allowNumber(this)"
							maxlength="45" onBlur="roundtxt(txt_existfund)"></td>
						<td align="center"><INPUT TYPE="text" NAME="txt_share2"
							style="text-align: right" size="20" maxlength="20"
							onBlur="checkPercentage(this);sumExistingpercent(this)" onKeyPress="allowNumber(this)"></td>
						<td align="center"><input type="text" name="txt_existnonfund"
							style="text-align: right" onKeyPress="allowNumber(this)"
							size="20" maxlength="20" onBlur="roundtxt(txt_existnonfund)"></td>
					</tr>
					</table>
					</td></tr>
					</table>
					</td>
					</tr>
					<tr>
					<td>
								
                        <table id="termloan2" width="100%" border="0" cellspacing="1" cellpadding="4" class="outertable">
                          <tr> 
                            <td colspan="4"><b>Proposed:</b></td>
                          </tr>
                          <tr class="dataheader"> 
                            <td  align="center" colspan="2">Funded</td>
                            <td  align="center" colspan="2">Non-funded</td>
                          </tr>
                          <tr class="dataheader"> 
                            <td align="center" width="25%">Share(%)</td>
                            <td align="center" width="25%">Amount</td>
                            <td align="center" width="25%">Share(%) </td>
                            <td align="center" width="25%">Amount</td>
                          </tr>
                          <tr class="datagrid"> 
                            <td align="center">
                              <input type="text" name="txt_share3"
									style="text-align: right" size="20" maxlength="20"
									onBlur="checkPercentage(this);sumProposedpercent(this);" onKeyPress="allowNumber(this)">
                            </td>
                            <td align="center">
                              <input type="text" name="txt_proposalfund" size="20"
									maxlength="15" onKeyPress="allowNumber(this)"
									onBlur="roundtxt(txt_proposalfund)" style="text-align: right">
                            </td>
                            <td align="center">
                              <input type="text" name="txt_share4"
									style="text-align: right" size="20" maxlength="20"
									onBlur="checkPercentage(this);sumProposedpercent(this);" onKeyPress="allowNumber(this)">
                            </td>
                            <td align="center">
                              <input type="text" name="txt_proposalnonfund"
									size="20" maxlength="20" onKeyPress="allowNumber(this)"
									onBlur="roundtxt(txt_proposalnonfund)"
									style="text-align: right">
                            </td>
                          </tr>
                          <tr> 
                            <td colspan="4">&nbsp;</td>
                          </tr>
                         </table>
						</td></tr>
						<tr><td>
						<table id="workcapital" border="0" width="100%" cellspacing="1" cellpadding="4" class="outertable">
						<tr class="dataheader">
						<td width="33%" align="center">Limit</td>
						<td width="34%" align="center">Outstanding</td>
						<td width="33%" align="center">Outstanding as on</td>
						</tr>
						<tr class="datagrid">
						<td width="33%" align="center"><input type="text" name="txt_limit"
									size="15" maxlength="10" onKeyPress="allowNumber(this)"
									onBlur="chklimit(this)" style="text-align: right">
						</td>
						<td width="34%" align="center"><input type="text" name="txt_outstanding"
									size="15" maxlength="10" onKeyPress="allowNumber(this)"
									onBlur="chklimit(this)" style="text-align: right">
						</td>
						<td width="33%" align="center"><input type="text" name="txt_outstandingason"
									size="12" maxlength="10" onBlur="checkDate(this);checkmaxdate(this,currdate);"
									style="text-align: left">
									 <a alt="Select date from calender"  href="javascript:callCalender('txt_outstandingason')">
									 <img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"></a> 
						</td>
						</tr>
						</table>
						</td></tr>
			<tr>
				<td>
				<table width="43%" border="0" cellspacing="0" cellpadding="1"
					align="center" class="outertable">
					<tr valign="top">
						<td>
						<lapschoice:combuttonnew btnnames="New_Edit_Save_Cancel_Delete_Comments"
							btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />								
						</td>
					</tr>
				</table>

				</td>
			</tr>
			<%if(intSize!=0){ %>
			<tr>
				<td>
				<br>
				<table width="100%" border="0" cellspacing="0" cellpadding="1" class="outertable border1">
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="1" cellpadding="4" class="outertable">
							<tr class="dataheader">
								<td rowspan="3" width="3%">&nbsp;</td>
								<td rowspan="3" width="22%">
								<DIV ALIGN="CENTER">Name of Member Bank</DIV>
								</td>
								<td colspan="6">
								<DIV ALIGN="CENTER">Working Capital</DIV>
								</td>
								<td colspan="3">
								<DIV ALIGN="CENTER">Term Loan</DIV>
								</td>
								</tr>
								<tr class="dataheader">
								<td colspan="3" align="center">Existing</td>
								<td colspan="3" align="center">Proposal</td>
								<td width="9%" rowspan="2" align="center">Limit</td>
								<td width="10%" rowspan="2" align="center">Outstanding</td>
								<td width="10%" rowspan="2" align="center">Outstanding as on</td>
							</tr>
							<tr class="dataheader">
								<td  width="7%" align="center">Share(%)</td>
								<td width="9%" align="center">Funded</td>
								<td width="10%" align="center">Non-Funded</td>
								<td width="7%" align="center">Share(%)</td>
								<td width="9%" align="center">Funded</td>
								<td width="10%" align="center">Non-Funded</td>
							</tr>
						</table>
						<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
							<tr>
								<td></td>
							</tr>
							<tr>
								<td>
								<div>
								<table width="100%" border="0" cellspacing="1" cellpadding="2" class="outertable">
									<%if(arrRow!=null && intSize>0){
									for(int i=0;i<intSize;i++){
									arrCol = (ArrayList)arrRow.get(i); %>
									<tr class="datagrid">
										<td align="center" width="3%">
										<div align="center"><INPUT TYPE="radio"
											STYLE="border: none" NAME="rdoUser"
											ONCLICK="javascript:selectValues('<%=Helper.correctNull((String)arrCol.get(0))%>',
											'<%=Helper.correctNull((String)arrCol.get(1))%>',
											'<%=Helper.correctNull((String)arrCol.get(2))%>',
											'<%=Helper.correctNull((String)arrCol.get(3))%>',
											'<%=Helper.correctNull((String)arrCol.get(4))%>',
											'<%=Helper.correctNull((String)arrCol.get(5))%>',
											'<%=Helper.correctNull((String)arrCol.get(6))%>',
											'<%=Helper.correctNull((String)arrCol.get(7))%>',
											'<%=Helper.correctNull((String)arrCol.get(8))%>',
											'<%=Helper.correctNull((String)arrCol.get(9))%>',
											'<%=Helper.correctNull((String)arrCol.get(10))%>',
											'<%=Helper.correctNull((String)arrCol.get(11))%>',
											'<%=Helper.correctNull((String)arrCol.get(12))%>',
											'<%=Helper.correctNull((String)arrCol.get(13))%>',
											'<%=Helper.correctNull((String)arrCol.get(14))%>',
											'<%=Helper.correctNull((String)arrCol.get(15))%>',
											'<%=Helper.correctNull((String)arrCol.get(16))%>',
											'<%=Helper.correctNull((String)arrCol.get(17))%>',
											'<%=Helper.correctNull((String)arrCol.get(18))%>',
											'<%=Helper.correctNull((String)arrCol.get(19))%>','<%=Helper.correctDouble((String)arrCol.get(20))%>','<%=Helper.correctNull((String)arrCol.get(21))%>')"></div>
										</td>
										<td width="22%"><%=Helper.correctNull((String)arrCol.get(3))%></td>
										<td width="7%" align="right"><%=Helper.correctNull((String)arrCol.get(4))%></td>
										<td width="9%" align="right"><%=Helper.correctNull((String)arrCol.get(6))%></td>
										<td width="10%" align="right"><%=Helper.correctNull((String)arrCol.get(8))%></td>
										<td width="7%" align="right"><%=Helper.correctDouble((String)arrCol.get(20))%></td>
										<td width="9%" align="right"><%=Helper.correctNull((String)arrCol.get(10))%></td>
										<td width="10%" align="right"><%=Helper.correctNull((String)arrCol.get(12))%></td>
										<td width="9%" align="right"><%=Helper.correctNull((String)arrCol.get(13))%></td>
										<td width="10%" align="right"><%=Helper.correctNull((String)arrCol.get(14))%></td>
										<td width="10%" align="center"><%=Helper.correctNull((String)arrCol.get(15))%></td>
									</tr>
									<%}}%>
								</table>
								</div>
								
								</td>
							</tr>
						</table>
						</td></tr></table>				
		</td>
	</tr>
	<%} %>
</table>
<br>
<input type="hidden" name="strAppno" value="">
<input type="hidden" name="hidAction">
<input type="hidden" name="hidBeanId" value="">
<input type="hidden" name="hidBeanMethod" value="">
<input type="hidden" name="hidBeanGetMethod" value="">
<input type="hidden" name="hidSourceUrl" value="">
<input type="hidden" name="hidMakerFlag" value="Y">
<input type="hidden" name="hidsno" value="">
<input type="hidden" name="hidgen_sno" value="">
<input type="hidden" name="hidcredit" value="">
<input type="hidden" name="hidbanking" value="">
<input type="hidden" name="hidourother" value="our">
<input type="hidden" name="hidfacvalue" value="">
</form>
</body>
</html>