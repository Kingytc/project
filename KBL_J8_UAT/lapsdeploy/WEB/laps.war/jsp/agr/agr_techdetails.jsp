<%@include file = "../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />

<%
if (objValues instanceof java.util.HashMap) {
				hshValues = (java.util.HashMap) objValues;
			}
	
%>
<html>
<head>
<title>Technical Aspects</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>

var appURL = "<%=ApplicationParams.getAppUrl()%>";
var txt_grown="<%=Helper.correctNull((String)hshValues.get("txt_grown"))%>";
var cbofacilities="<%=Helper.correctNull((String)hshValues.get("cbofacilities"))%>";
var txt_adequate="<%=Helper.correctNull((String)hshValues.get("txt_adequate"))%>";
var txt_supply="<%=Helper.correctNull((String)hshValues.get("txt_supply"))%>";
var txt_produce="<%=Helper.correctNull((String)hshValues.get("txt_produce"))%>";
var txt_barns="<%=Helper.correctNull((String)hshValues.get("txt_barns"))%>";
var txt_dimensions="<%=Helper.correctNull((String)hshValues.get("txt_dimensions"))%>";
var txt_loc="<%=Helper.correctNull((String)hshValues.get("txt_loc"))%>";
var txt_bran="<%=Helper.correctNull((String)hshValues.get("txt_bran"))%>";
var cbocredit="<%=Helper.correctNull((String)hshValues.get("cbocredit"))%>";
var txt_fact="<%=Helper.correctNull((String)hshValues.get("txt_fact"))%>";
var cboagree="<%=Helper.correctNull((String)hshValues.get("cboagree"))%>";
var cbougc="<%=Helper.correctNull((String)hshValues.get("cbougc"))%>";
var txt_agr="<%=Helper.correctNull((String)hshValues.get("txt_agr"))%>";
var txt_receivedRH="<%=Helper.correctNull((String)hshValues.get("txt_receivedRH"))%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
function check()
{
	if(document.forms[0].cbocredit.value == "1")
	{
		document.all.r1.style.visibility="visible";
		document.all.r1.style.position="relative";
		document.all.r2.style.visibility="visible";
		document.all.r2.style.position="relative";
		document.all.ra.style.visibility="visible";
		document.all.ra.style.position="relative";
	}
	else
	{
		document.all.r1.style.visibility="hidden";
		document.all.r1.style.position="absolute";
		document.all.r2.style.visibility="hidden";
		document.all.r2.style.position="absolute";
		document.all.ra.style.visibility="hidden";
		document.all.ra.style.position="absolute";
		document.forms[0].txt_fact.value="";
		document.forms[0].address.value="";
	}
}

function check1()
{
	if(document.forms[0].cboagree.value == "1")
	{
		document.all.r3.style.visibility="visible";
		document.all.r3.style.position="relative";
		document.all.r4.style.visibility="visible";
		document.all.r4.style.position="relative";
		document.all.r5.style.visibility="visible";
		document.all.r5.style.position="relative";
		document.all.r6.style.visibility="visible";		
		document.all.r6.style.position="relative";
	}
	else
	{
		document.all.r3.style.visibility="hidden";
		document.all.r3.style.position="absolute";
		document.all.r4.style.visibility="hidden";
		document.all.r4.style.position="absolute";
		document.all.r5.style.visibility="hidden";
		document.all.r5.style.position="absolute";
		document.all.r6.style.visibility="hidden";
		document.all.r6.style.position="absolute";
		document.forms[0].txt_agr.value="";
		document.forms[0].txt_receivedRH.value="";
	}
}

function callCalender(name)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal(appURL,name);		
	}
}

function callhelp()
{
	var varQryString = appURL+"/jsp/perhlp/hlp_educourse.jsp";
	var title = "ApplicantDemographics";
	var prop = "scrollbars=no,width=600,height=450";	
	prop = prop + ",left=200,top=150";
	window.open(varQryString,title,prop);
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

function doSave()
{   
	if(document.forms[0].cbougc.value=="0")
		{
		alert("Select Proposal Based On");
		document.forms[0].cbougc.focus();
		return;
		}
	enableButtons( true, true, true, true, false);
	document.forms[0].hidRecordflag.value=varRecordFlag;
	document.forms[0].hidBeanId.value="agrcrops";		
	document.forms[0].hidSourceUrl.value="/action/agr_techdetails.jsp";
	document.forms[0].hidBeanMethod.value="updatetechdetails";
	document.forms[0].hidBeanGetMethod.value="gettechdetails";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function doEdit()
{
 	disableFields(false);
	document.forms[0].hideditflag.value ="Y";
	document.forms[0].hidAction.value ="insert";
	document.forms[0].cbougc.focus();
	enableButtons( true, false, false, false, true);		
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidSourceUrl.value="/action/agr_techdetails.jsp";
		document.forms[0].hidBeanId.value="agrcrops";
		document.forms[0].hidBeanGetMethod.value="gettechdetails";
		document.forms[0].action=appURL +"controllerservlet";
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

function doDelete()
{
	if(varRecordFlag=="Y") {
		
	if( ConfirmMsg(101)) {
		
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appURL+"action/ControllerServlet";	
		document.forms[0].hidBeanMethod.value="updatetechdetails";
		document.forms[0].hidBeanGetMethod.value="gettechdetails";
		document.forms[0].hidBeanId.value="agrcrops";
		document.forms[0].hidSourceUrl.value="action/agr_techdetails.jsp";	
		document.forms[0].method="post";			
		document.forms[0].submit();	
		
	}} else {
		
		ShowAlert(158);
	}	
}
	
function onloading()
{	  
	document.forms[0].txt_grown.value=txt_grown;
	document.forms[0].txt_adequate.value=txt_adequate;
	document.forms[0].txt_supply.value=txt_supply;
	document.forms[0].txt_produce.value=txt_produce;
	document.forms[0].txt_barns.value=txt_barns;
	document.forms[0].txt_dimensions.value=txt_dimensions;
	document.forms[0].txt_loc.value=txt_loc;
	document.forms[0].txt_bran.value=txt_bran;
	document.forms[0].txt_fact.value=txt_fact;
	document.forms[0].txt_agr.value=txt_agr;
	document.forms[0].txt_receivedRH.value=txt_receivedRH;
	if(cbofacilities!="")
	{
		document.forms[0].cbofacilities.value=cbofacilities;
	}
	if(cbocredit!="")
	{
		document.forms[0].cbocredit.value=cbocredit;
	}
	if(cboagree!="")
	{
		document.forms[0].cboagree.value=cboagree;
	}	
	if(cbougc!="")
	{
		document.forms[0].cbougc.value=cbougc;
	}	
	disableFields(true);
	//enableButtons(false, true, true, true);
	check();
	check1();
}

function enableButtons(bool2, bool3, bool4, bool5, bool6)
{	
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool5;
	document.forms[0].cmdclose.disabled = bool6;
}

function call_page(url)
{	
	document.forms[0].action=appURL+"action/"+url;
	document.forms[0].submit();	
}
</script>


</head>
<body onload="onloading()">
<form name="frmpri" method="post" class="normal">
<br>
  <table width="95%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable border1">
    <tr>
      <td>
        <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
        	<tr>
        	<td width="1%">&nbsp;</td>
            <td width="42%">Proposal Based On <b><span class="mantatory"> *</span> </b></td>
            <td colspan="2"> 
              <select name="cbougc">
                <option value="0" selected>----Select----</option>
                <option value="1">Scale of finance</option>
                <option value="2">Without Scale of finance</option>
               	<option value="3">Land Holding Eligibility</option>
              </select>
            </td>
        	</tr>
          <tr> 
            <td width="1%">1.</td>
            <td width="42%">Seasonality of 
              crops to be grown for which financial assistance is required</td>
            <td colspan="2"> 
              <input type="text" name="txt_grown" size='45'
					maxlength='50'
					value="<%=Helper.correctNull((String)hshValues.get("txt_grown"))%>">
            </td>
          </tr>
          <tr> 
            <td width="1%">2.</td>
            <td width="42%">(i) Details of 
              irrigation facilities available </td>
            <td colspan="2">
              <input type="text" name="txt_adequate" size='45' maxlength='50'
					value="<%=Helper.correctNull((String)hshValues.get("txt_adequate"))%>">
            </td>
          </tr>
          <tr> 
            <td width="1%">&nbsp;</td>
            <td width="42%">(ii) Are they 
              adequate? </td>
            <td colspan="2"> 
              <select
					name="cbofacilities" id="select">
                <option value="0" selected>----Select----</option>
                <option value="1">Yes</option>
                <option value="2">No</option>
              </select>
              </td>
          </tr>
          <tr> 
            <td width="1%">3.</td>
            <td width="42%"><b>Arrangements 
              for the following</b></td>
            <td colspan="2">&nbsp;</td>
          </tr>
          <tr> 
            <td width="1%">&nbsp;</td>
            <td width="42%">(i) Supply of 
              inputs</td>
            <td colspan="2">
              <input type="text" name="txt_supply" size='45' maxlength='50'
					value="<%=Helper.correctNull((String)hshValues.get("txt_supply"))%>">
            </td>
          </tr>
          <tr> 
            <td width="1%">&nbsp;</td>
            <td width="42%">(ii) Marketing 
              of produce</td>
            <td colspan="2">
              <input type="text" name="txt_produce" size='45' maxlength='50'
					value="<%=Helper.correctNull((String)hshValues.get("txt_produce"))%>">
            </td>
          </tr>
          <tr> 
            <td width="1%">4.</td>
            <td width="42%"><b>In case of 
              tobacco crop:</b></td>
            <td colspan="2">&nbsp;</td>
          </tr>
          <tr> 
            <td width="1%">&nbsp;</td>
            <td width="42%">(i) Number of 
              Barns</td>
            <td colspan="2">
              <input type="text" name="txt_barns" size='10' maxlength='9' onkeypress="allowInteger()"
					value="<%=Helper.correctNull((String)hshValues.get("txt_barns"))%>">
            </td>
          </tr>
          <tr> 
            <td width="1%">&nbsp;</td>
            <td width="42%">(ii) Dimension 
              of the Barns</td>
            <td colspan="2">
              <input type="text" name="txt_dimensions" size='45'
					maxlength='50'
					value="<%=Helper.correctNull((String)hshValues.get("txt_dimensions"))%>">
            </td>
          </tr>
          <tr> 
            <td width="1%">&nbsp;</td>
            <td width="42%">(iii) Their location</td>
            <td colspan="2">
              <input type="text" name="txt_loc" size='15' maxlength='25'
					value="<%=Helper.correctNull((String)hshValues.get("txt_loc"))%>">
            </td>
          </tr>
          <tr> 
            <td width="1%">&nbsp;</td>
            <td width="42%">(iv) Distance 
              from the Branch</td>
            <td colspan="2">
              <input type="text" name="txt_bran" size='45' maxlength='50'
					value="<%=Helper.correctNull((String)hshValues.get("txt_bran"))%>">
            </td>
          </tr>
          <tr> 
            <td width="1%">5.</td>
            <td width="42%"><b>In case of 
              Tie up</b></td>
            <td colspan="2">&nbsp;</td>
          </tr>
          <tr> 
            <td width="1%">&nbsp;</td>
            <td width="42%">(i) Credit is 
              linked with marketing</td>
            <td colspan="2">
              <select name="cbocredit" id="select3" onChange="check()">
                <option value="0" selected>----Select----</option>
                <option value="1">Yes</option>
                <option value="2">No</option>
              </select>
            </td>
          </tr>
          <tr> 
            <td width="1%">&nbsp;</td>
            <td id="r1" width="42%">(ii) If 
              yes,name and address of the tie up agency</td>
            <td id="r2" width="23%"> 
              <input type="text" name="txt_fact" size='30' maxlength='49'
					value="<%=Helper.correctNull((String)hshValues.get("txt_fact"))%>">
            </td>
            <td id="ra" width="34%">
              <textarea
											name="address" cols="50" style="text-align:left"
											wrap="VIRTUAL" rows="5" onKeyPress="textlimit(address,3999);notAllowSingleAndDoubleQuote()" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("address"))%></textarea>
            </td>
          </tr>
          <tr> 
            <td width="1%">&nbsp;</td>
            <td width="42%">(iii) Whether 
              an Agreement letter from the factory in the prescribed proforma 
              has been obtained / deposited and our lien over sale proceeds payable 
              to applicant has been got registered. </td>
            <td colspan="2">
              <select name="cboagree" id="select5" onChange="check1()">
                <option value="0" selected>----Select----</option>
                <option value="1">Yes</option>
                <option value="2">No</option>
              </select>
            </td>
          </tr>
          <tr> 
            <td width="1%">&nbsp;</td>
            <td  id="r3" width="42%">(iv) 
              If yes,Agreement No.and date</td>
            <td colspan="2" > 
              <table border="0" width="30%" cellspacing="0" cellpadding="3">
                <tr> 
                  <td nowrap id="r4">
                    <input type="text" name="txt_agr" size='30' maxlength='49'
							value="<%=Helper.correctNull((String)hshValues.get("txt_agr"))%>">
                  </td>
                  <td nowrap id="r5">
                    <input type="text" name="txt_receivedRH"
							size="11"
							value="<%=Helper.correctNull((String)hshValues.get("txt_receivedRH"))%>"
							onBlur="dateDOBCheck(document.forms[0].txt_receivedRH);checkmaxdate(this,'<%=Helper.getCurrentDateTime()%>');"> 
                  </td>
                  <td nowrap id="r6"><a alt="Select date from calender" href="#"
							onClick="callCalender('txt_receivedRH')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border=0
							alt="Select date from calender"></a></td>
                </tr>
              </table>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table><br>
  <lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
 
	<input type="hidden" name="selsno" value=""> 
	<input type="hidden" name="hidval"> 
	<input type="hidden" name="hidcroptype" value=""> 
	<input type="hidden" name="txt_cost1" value="0.0">
	<input type="hidden" name="hidRecordflag" > 
	<lapschoice:agrihiddentag pageid='<%=PageId%>'/>
	</form>
</body>

</html>

