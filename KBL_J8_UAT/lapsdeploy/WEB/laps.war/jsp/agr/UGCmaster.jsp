<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%if (objValues instanceof java.util.HashMap) {
	hshValues = (java.util.HashMap) objValues;
}
ArrayList vecData = new ArrayList();
ArrayList vecRow = new ArrayList();
int vecsize = 0;
if (hshValues != null) {
	vecData = (ArrayList) hshValues.get("vecData");
}%>
<html>
<head>
<title>Finance Details</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>	
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currdate = "<%=Helper.getCurrentDateTime()%>";
var mode ="load";
var txt_minacre = "<%=Helper.correctNull((String)hshValues.get("txt_minacre"))%>";
var txt_maxacre= "<%=Helper.correctNull((String)hshValues.get("txt_maxacre"))%>";
var txt_value= "<%=Helper.correctNull((String)hshValues.get("txt_value"))%>";
var selsno="<%=Helper.correctNull((String)hshValues.get("selsno"))%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
function selectValues(val1, val2, val3, val4)
{
    document.forms[0].hidsno.value = val1;	
    document.forms[0].txt_minacre.value = val2;
	document.forms[0].txt_maxacre.value = val3;
	document.forms[0].txt_value.value = val4;	
	enableButtons(true, false, true, false, false, true);
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
	if(document.forms[0].txt_minacre.value=="")
	{
		document.forms[0].txt_minacre.value="0";
	} 
	if(document.forms[0].txt_maxacre.value=="")
	{
		alert("Enter the Maximum Acre Field");
		document.forms[0].txt_maxacre.focus();
		return false;
	} 
	if(document.forms[0].txt_value.value=="")
	{
		alert("Enter the Eligible Loan Amount");
		document.forms[0].txt_value.focus();
		return false;
	} 
	
	var minvalue = parseFloat(document.forms[0].txt_minacre.value);
	var maxvalue = parseFloat(document.forms[0].txt_maxacre.value);
	if(minvalue >= maxvalue){
		alert("Minimum Acre should be lesser than Maximum Acre");
		return;
	}
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidBeanId.value="staticdata";
	document.forms[0].hidRecordflag.value=varRecordFlag;
	document.forms[0].hidBeanMethod.value="updateUGCData";
	document.forms[0].hidBeanGetMethod.value="getUGCData";
	document.forms[0].hidSourceUrl.value="/action/UGCmaster.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appURL+"action/setagriparam.jsp";
		document.forms[0].submit();
	}
}

function doCancel()
{
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
		document.forms[0].hidAction.value="Cancel";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidBeanId.value="staticdata";
		document.forms[0].hidBeanMethod.value="getUGCData";
		document.forms[0].hidBeanGetMethod.value="getUGCData";
		document.forms[0].hidSourceUrl.value="/action/UGCmaster.jsp";		
		document.forms[0].submit();
	}
}

function doNew() 
{
	ClearFields();
	document.forms[0].hidAction.value="insert";
   	enableButtons(true, true, false, false, true,false, true);
   	disableFields(false);   
   	mode = "new";
}
function doEdit() 
{
	if(document.forms[0].hidsno.value != ""){
   	document.forms[0].hidAction.value="update";  
	enableButtons(true, true, false, false, true,false, true);
	disableFields(false);
	mode ="edit";	
}else{
	alert("Select Data to Edit");
	return;
}}

function doDelete() 
{
	if(document.forms[0].hidsno.value != ""){
  if( ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appUrl+"action/ControllerServlet";	
		document.forms[0].hidBeanMethod.value="updateUGCData";
		document.forms[0].hidBeanGetMethod.value="getUGCData";
		document.forms[0].hidBeanId.value="staticdata";
		document.forms[0].hidSourceUrl.value="action/UGCmaster.jsp";	
		document.forms[0].method="post";			
		document.forms[0].submit();			
	}
	}else{
		alert("Select Data to Delete");
		return;
	}
}  
function enableButtons(bool1, bool2, bool3, bool4, bool5, bool6)
{
	document.forms[0].cmdnew.disabled=bool1;
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool5;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool6;
}
function callCalender(fname)
{
	var action  =document.forms[0].hidAction.value;
	if(action =="insert" || action =="update")
	{
		showCal(appURL,fname);
	}
}
function callonLoad()
{		
	enableButtons(false,true,true,true,false,false,false);	
	disableFields(true);
}
function checkminmax(){
	var minvalue = parseFloat(document.forms[0].txt_minacre.value);
	var maxvalue = parseFloat(document.forms[0].txt_maxacre.value);
	if(minvalue >= maxvalue){
		alert("Minimum Acre should be lesser than Maximum Acre");
		return;
	}
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="callonLoad()">
<form name="frmpri" method="post" class="normal">
  <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>		
      <td class="page_flow">Home -&gt; Setup -&gt; Retail & Agriculture Products -&gt; Agri Parameters -&gt; UGC Parameters</td>
	</tr>
</table><br><iframe height="0" width="0" id="ifrm" frameborder=0 style="border:0"></iframe> <br>
		<table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="2">
			<tr>
				<td>
				<table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>
						<table class="outertable border1" width="100%" border="0" cellspacing="0" cellpadding="3">
							<tr>
								<td>								
                          <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="2">
                            <tr> 
                              <td width="11%" > 
                                <b>Minimum Acre</b></td>
                              <td width="18%" ><b>  
                                <input type="text" name="txt_minacre" value="" maxlength="15" onKeyPress="allowNumber(this)" onblur="checkminmax();">
                                </b></td>
                              <td width="12%" ><b>Maximum Acre</b><b><span class="mantatory">*</span></b></td>
                              <td width="19%" > <b>  
                                <input type="text" name="txt_maxacre" value="" maxlength="15" onKeyPress="allowNumber(this)" onblur="checkminmax();">
                                </b></td>
                              <td width="16%" ><b>Eligible Loan Amount</b><strong>(Rs.)</strong><b><span class="mantatory">*</span></b></td>
                              <td width="29%" >&nbsp;  
                                <input type="text" name="txt_value" value="" onKeyPress="allowNumber(this)" onBlur="roundtxt(document.forms[0].txt_value)"; maxlength="15" style="text-align: right">
                                <b> </b></td>
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
								<br>
							 <lapschoice:combuttonnew btnnames="New_Edit_Save_Cancel_Delete_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
							<br>								
                          <table class="outertable linebor" width="98%" border="0" cellspacing="0" cellpadding="2" align="center">
                            <tr class="dataheader"> 
                              <td width="4%" >&nbsp;</td>
                              <td width="17%" align="center" >Minimum Acre </td>
                              <td width="17%" align="center" >Maximum Acre </td>
                              <td width="16%" align="center" >Eligible Loan Amount(Rs.)</td>
                            </tr>
                            <%if (vecData != null) 
                            {
                            	vecsize = vecData.size();			
                            }
			String strSno = "";
			for (int i = 0; i < vecsize; i++) {
				vecRow = (ArrayList) vecData.get(i);
				if (vecRow != null) {
					strSno = Helper.correctNull((String) vecRow.get(0));%>
                            <tr align="center" class="datagrid"> 
                              <td width="4%" >
                                <input type="radio" name="sno" style="border-style:none"
											onClick="selectValues('<%=Helper.correctNull((String) vecRow.get(0))%>', '<%=Helper.correctNull((String) vecRow.get(1)) %>','<%=Helper.correctNull((String) vecRow.get(2))%>','<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) vecRow.get(3))))%>')">
                                <input type="hidden" name="hid" value="<%=strSno%>">
                              </td>
                              <td width="17%" align="left"  >&nbsp;<%=Helper.correctNull((String) vecRow.get(1))%>
                                &nbsp; &nbsp; &nbsp;</td>
                              <td width="17%" align="left" >&nbsp;<%=Helper.correctNull((String) vecRow.get(2))%>&nbsp; 
                                &nbsp; &nbsp; &nbsp;</td>
                              <td width="16%" align="right" >&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) vecRow.get(3))))%> 
                                &nbsp; &nbsp;</td>
                            </tr>
                            <%}}%>
                          </table>
                          <br>
<lapschoice:hiddentag pageid='<%=PageId%>'/>                       
<input type="hidden" name="hidorg_code" value="<%=Helper.correctNull((String)hshValues.get("ORG_CODE"))%>"> 
<input type="hidden" name="hidsno" value=""> 
<input type="hidden" name="hidcat_parent" value="0">  
<input type="hidden" name="selsno" value="">
<input type ="hidden" name ="hidkeyid" value="set">
</form>
</body>
</html>


