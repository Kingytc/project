<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%if(objValues instanceof java.util.HashMap)
{
	hshValues=(java.util.HashMap)objValues;
}


%>
<html>
<head>
<title>Limit Master</title>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/set/navigate.js"></script>
<SCRIPT language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var path = "<%=ApplicationParams.getAppUrl()%>";
var selindex;
var isnew="false";
var strtermid = "";
var strtermdesc ="";
var strtermcont="";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";

function onloading()
{   
	for(i=0;i<document.forms[0].selectlimit.length;i++)
	{	if(document.forms[0].hidId.value == document.forms[0].selectlimit[i].value)
		{
			document.forms[0].selectlimit.selectedIndex=i;
		}
	}	
	selindex=document.forms[0].selectlimit[document.forms[0].selectlimit.selectedIndex].value;
	if(selindex=='')
	{
	document.forms[0].cmdedit.disabled=true;
	document.forms[0].cmddelete.disabled=true;
	}
	else
	{
	document.forms[0].cmdedit.disabled=false;
	document.forms[0].cmddelete.disabled=false;
	}
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].cmdcancel.disabled=true;
}

function getValue()
{		
	selindex=document.forms[0].selectlimit[document.forms[0].selectlimit.selectedIndex].value;
 		if(selindex=='')		
		{	
			document.forms[0].txtlimit_from.value="";
			document.forms[0].txtlimit_to.value="";
			document.forms[0].txtlimit_class.value="";
			document.forms[0].txtskip_class.value="";

			document.forms[0].cmdedit.disabled=true;
			document.forms[0].cmdsave.disabled=true;
			document.forms[0].cmdcancel.disabled=true;
		}
		else if(selindex=='0')
		{
			document.forms[0].hidId.value="";
			document.forms[0].txtlimit_from.value="";
			document.forms[0].txtlimit_to.value="";
			document.forms[0].txtlimit_class.value="";
			document.forms[0].txtskip_class.value="";
			doNew();
		}
		else
		{
		document.forms[0].hidId.value = selindex;
		document.forms[0].action=path+"controllerservlet";
		document.forms[0].hidBeanId.value="limitmaster";
		document.forms[0].hidBeanMethod.value="getData";
		document.forms[0].hidSourceUrl.value="/action/ops_limitmaster.jsp";
		document.forms[0].submit();
		}
}
function doNew()
{	
	isnew="true";
	varRecordFlag="N";
	document.forms[0].txtlimit_from.readOnly=false;
	document.forms[0].txtlimit_to.readOnly=false;
	document.forms[0].txtlimit_class.readOnly=false;
	document.forms[0].txtskip_class.readOnly=false;

	document.forms[0].cmdedit.disabled=true;
	document.forms[0].cmddelete.disabled=true;
	document.forms[0].cmdsave.disabled=false;
	document.forms[0].cmdcancel.disabled=false;
	document.forms[0].cmdclose.disabled=true;
	
}
function doEdit()
{
	document.forms[0].txtlimit_from.readOnly=false;
	document.forms[0].txtlimit_to.readOnly=false;
	document.forms[0].txtlimit_class.readOnly=false;
	document.forms[0].txtskip_class.readOnly=false;

	document.forms[0].cmdedit.disabled=true;
	document.forms[0].cmddelete.disabled=true;
	document.forms[0].cmdsave.disabled=false;
	document.forms[0].cmdcancel.disabled=false;
	document.forms[0].cmdclose.disabled=true;
}



function doSave()
{
			if(isnew=="true")
			{
			document.forms[0].hidAction.value="insert";
			}
			else
			{
			document.forms[0].hidAction.value="update";
			}
			if(checktrim(document.forms[0].txtlimit_from.value)=="")
			{		
				ShowAlert('121','Limit From');
				document.forms[0].txtlimit_from.focus();
				return false;
			}

			if(checktrim(document.forms[0].txtlimit_to.value)=="")
			{		
				ShowAlert('121','Limit To');
				document.forms[0].txtlimit_to.focus();
				return false;
			}

			if(checktrim(document.forms[0].txtlimit_class.value)=="")
			{		
				ShowAlert('121','User Class');
				document.forms[0].txtlimit_class.focus();
				return false;
			}
			var minvalue = parseFloat(document.forms[0].txtlimit_from.value);
			var maxvalue = parseFloat(document.forms[0].txtlimit_to.value);

			if(minvalue >= maxvalue){
				alert("Loan limit from should be lesser than Loan limit To");
				return;
			}
			document.forms[0].hidRecordflag.value=varRecordFlag;
			document.forms[0].hidId.value =
			document.forms[0].selectlimit[document.forms[0].selectlimit.selectedIndex].value;
			document.forms[0].cmdsave.disabled = true;
			document.forms[0].action=path+"controllerservlet";			
			document.forms[0].hidBeanId.value="limitmaster";
			document.forms[0].hidBeanMethod.value="updateData";
			document.forms[0].hidSourceUrl.value="/action/ops_limitmaster.jsp";
			document.forms[0].submit();
}

function doDelete()
{
	if(varRecordFlag=="Y")
	{
		if(ConfirmMsg('101'))
		{
			document.forms[0].hidAction.value="delete";
			document.forms[0].hidId.value =
			document.forms[0].selectlimit[document.forms[0].selectlimit.selectedIndex].value;
			document.forms[0].action=path+"controllerservlet";		
			document.forms[0].hidBeanId.value="limitmaster";
			document.forms[0].hidBeanMethod.value="updateData";
			document.forms[0].hidSourceUrl.value="/action/ops_limitmaster.jsp";
			document.forms[0].submit();
		}
	}
	else
	{
		ShowAlert(158);
	}
}

function doCancel()
{
	if(ConfirmMsg('102'))
	{
		selindex=document.forms[0].selectlimit[document.forms[0].selectlimit.selectedIndex].value;
		document.forms[0].hidId.value = selindex;
		document.forms[0].action=path+"controllerservlet";
		document.forms[0].hidBeanId.value="limitmaster";
		document.forms[0].hidBeanMethod.value="getData";
		document.forms[0].hidSourceUrl.value="/action/ops_limitmaster.jsp";
		document.forms[0].submit();

		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmddelete.disabled=false;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;
	}
}
function doClose()
{
	if(ConfirmMsg('100'))
	{
		document.forms[0].action=path+"action/setupnav.jsp";
		document.forms[0].submit();
	}
}

function menuOptionDivMouseDown (url)
{		
	if(!document.forms[0].cmdsave.disabled)
	{
		ShowAlert(103);
		return;
	}
	document.currentMenu.style.display='none';
	document.currentMBarOpt.style.border='1px solid lightgrey';
	document.menuIsActive = false;
	document.forms[0].action=url;
	document.forms[0].submit();
} 
function checkMinMax(){
	var minvalue = parseFloat(document.forms[0].txtlimit_from.value);
	var maxvalue = parseFloat(document.forms[0].txtlimit_to.value);

	if(minvalue >= maxvalue){
		alert("Loan limit from should be lesser than Loan limit To");
		return;
	}
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onloading()">
<form class="normal">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <td class="page_flow">Home -&gt;Setup -&gt; Tertiary Products -&gt;Limit Master</td>
    </tr>
  </table>
  <br>
  <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
    <tr> 
      <td> 
        <table width="60%" border="0" cellspacing="0" cellpadding="5" align="center" class="outertable border1">
          <tr> 
            <td> 
              <table width="100%" border="0" cellspacing="0" cellpadding="8" align="center" class="outertable">
                <tr> 
                  <td colspan="2"  valign="middle">Select 
                    Existing Limits </td>
                  <td width="64%"> 
                    <select name="selectlimit" onChange="getValue()" >
                      <lapschoice:limitlist/> 
                    </select>
                  </td>
                </tr>
                <tr> 
                  <td colspan="2" valign="middle"> 
                    Loan limit from (Rs.)</td>
                  <td width="64%"> 
                    <input type="text" name="txtlimit_from" size="25" maxlength="15" onkeypress="allowNumber(this);" onblur="roundtxt(this);checkMinMax();" value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("prd_rng_from"))))%>" style = "text-align: right;" readonly>
                  </td>
                </tr>
                <tr> 
                  <td colspan="2" valign="middle">Loan limit To (Rs.)</td>
                  <td width="64%"> 
                    <input type="text" name="txtlimit_to" size="25" maxlength="15" onkeypress="allowNumber(this);" onblur="roundtxt(this);checkMinMax();" value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("prd_rng_to"))))%>" style = "text-align: right;" readonly>
                  </td>
                </tr>
              <tr> 
                  <td colspan="2" valign="middle">Minimum Class for Approval / Rejection  </td>
                  <td width="64%"> 
                    <input type="text" name="txtlimit_class" size="25" maxlength="3"  value="<%=Helper.correctNull((String)hshValues.get("prd_maxappclass"))%>" readonly>
                  </td>
                </tr>
                     <tr> 
                  <td colspan="2" valign="middle">Minimum Class for Skip flowpoints</td>

                        <td> 
                          <input type="text" name="txtskip_class" size="25" maxlength="3"  value="<%=Helper.correctNull((String)hshValues.get("prd_maxskipclass"))%>" readonly>
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
  <lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
  <lapschoice:hiddentag pageid='<%=PageId%>'/> 
  <input type="hidden" name="hidId" value="<%=request.getParameter("hidId") %>">
  <input type="hidden" name="txt_facility" value="0">
  <input type="hidden" name="prdtype" value="T">
  <input type ="hidden" name ="hidkeyid" value="set">
</form>
</body>
</html>
