<%@include file = "../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />

<html>
<head>
<title>Technical Aspects</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var txt_distanceexp="<%=Helper.correctNull((String)hshValues.get("txt_distanceexp"))%>";
var txt_distanceloc="<%=Helper.correctNull((String)hshValues.get("txt_distanceloc"))%>";
var txt_distancestate="<%=Helper.correctNull((String)hshValues.get("txt_distancestate"))%>";
var txt_source="<%=Helper.replaceForJavaScriptString(Helper.correctNull((String)hshValues.get("txt_source")))%>";
var sel_export="<%=Helper.correctNull((String)hshValues.get("sel_export"))%>";
var sel_local="<%=Helper.correctNull((String)hshValues.get("sel_local"))%>";
var sel_state="<%=Helper.correctNull((String)hshValues.get("sel_state"))%>";
var sel_demand="<%=Helper.correctNull((String)hshValues.get("sel_demand"))%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
function checkexport()
{
if(document.forms[0].sel_export.value=="1")
{
document.all.e1.style.visibility="visible";	
document.all.e1.style.position="relative";		
}
else{
document.all.e1.style.visibility="hidden";
document.all.e1.style.position="absolute";
document.forms[0].txt_distanceexp.value="";
}
}
function checklocal()
{
if(document.forms[0].sel_local.value=="1")
{
document.all.l1.style.visibility="visible";		
document.all.l1.style.position="relative";	
}
else{
document.all.l1.style.visibility="hidden";
document.all.l1.style.position="absolute";
document.forms[0].txt_distanceloc.value="";
}
}
function checkstate()
{
if(document.forms[0].sel_state.value=="1")
{
document.all.s1.style.visibility="visible";	
document.all.s1.style.position="relative";
}
else{
document.all.s1.style.visibility="hidden";
document.all.s1.style.position="absolute";
document.forms[0].txt_distancestate.value="";
}
}
function checkdemand()
{
if(document.forms[0].sel_demand.value=="1")
{
document.all.d1.style.visibility="visible";
document.all.d1.style.position="relative";
document.all.d2.style.visibility="visible";
document.all.d2.style.position="relative";
}
else{
document.all.d1.style.visibility="hidden";
document.all.d1.style.position="absolute";
document.all.d2.style.visibility="hidden";
document.all.d2.style.position="absolute";
document.forms[0].txt_source.value="";
}
}
function callCalender(name)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal(appURL,name);		
	}
}


function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].target="_parent";
		document.forms[0].action=appURL+"action/"+"retailpge.jsp";				
		document.forms[0].submit();
	}
}

function doSave()
{   
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidRecordflag.value=varRecordFlag;
	document.forms[0].hidBeanId.value="agrcoffee";		
	document.forms[0].hidSourceUrl.value="/action/agr_plantation_techasp.jsp";
	document.forms[0].hidBeanMethod.value="updateplantationtechdata";
	document.forms[0].hidBeanGetMethod.value="getplantationtechdata";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function doEdit()
{
 	disableFields(false);
	document.forms[0].hideditflag.value ="Y";
	document.forms[0].hidAction.value ="insert";
	enableButtons( true, false, false, false);		
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="agrcoffee";
		document.forms[0].hidBeanGetMethod.value="getplantationtechdata";
		document.forms[0].action=appURL +"action/agr_plantation_techasp.jsp";
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
	if( ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appURL+"action/ControllerServlet";	
		document.forms[0].hidBeanMethod.value="updateplantationtechdata";
		document.forms[0].hidBeanGetMethod.value="getplantationtechdata";
		document.forms[0].hidBeanId.value="agrcoffee";
		document.forms[0].hidSourceUrl.value="action/agr_plantation_techasp.jsp";	
		document.forms[0].method="post";			
		document.forms[0].submit();	
	}	
}
	
function onloading()
{
 
	disableFields(true);
	
	document.forms[0].txt_distanceexp.value=txt_distanceexp;
	document.forms[0].txt_distanceloc.value=txt_distanceloc;
	document.forms[0].txt_distancestate.value=txt_distancestate;
	document.forms[0].txt_source.value=txt_source;
	if(sel_export!="")
	{
		document.forms[0].sel_export.value=sel_export;
	}
	if(sel_local!="")
	{
	
		document.forms[0].sel_local.value=sel_local;
	}
	if(sel_state!="")
	{
		document.forms[0].sel_state.value=sel_state;
	}
	if(sel_demand!="")
	{
		document.forms[0].sel_demand.value=sel_demand;
		
	}
	checkexport();
    checklocal();
    checkstate();
    checkdemand(); 
	
			
}

function enableButtons( bool1, bool2, bool3, bool4)
{	
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	//document.forms[0].cmdclose.disabled = bool6;
}

</script>

</head>
<body onload="onloading()">
<form name="frmpri" method="post" class="normal">
<br>
  <table width="90%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable border1">
    <tr>
      <td>
        <table width="90%" border="0" cellspacing="0" cellpadding="3" height="133" class="outertable">
          <tr> 
            <td colspan="3"> Backward &amp; 
              Forward Linkages:What are the arrangements/Linkages made? 
            </td>
          </tr>
          <tr> 
            <td width="29%">Any Export tie-up 
              of Production</td>
            <td width="26%"> 
              <select name="sel_export" onChange="checkexport()">
                <option value="0" selected>----Select----</option>
                <option value="1">Yes</option>
                <option value="2">No</option>
              </select>
            </td>
            <td  id="e1">Pick-up point at 
              <input type="text" name="txt_distanceexp" size='10' maxlength='9'
					value="<%=Helper.correctNull((String)hshValues.get("txt_distanceexp"))%>"  onKeyPress="allowNumber(this)">
              (Km) from place 
              of production.</td>
          </tr>
          <tr> 
            <td width="29%">Any Local market 
              tie up from place of production</td>
            <td width="26%"> 
              <select name="sel_local" onChange="checklocal()">
                <option value="0" selected>----Select----</option>
                <option value="1">Yes</option>
                <option value="2">No</option>
              </select>
            </td>
            <td id="l1">Pick-up point at 
              <input type="text" name="txt_distanceloc" size='10' maxlength='9'
					value="<%=Helper.correctNull((String)hshValues.get("txt_distanceloc"))%>"  onKeyPress="allowNumber(this)">
              (Km) from place 
              of production.</td>
          </tr>
          <tr> 
            <td  width="29%" height="37">Out 
              of state tie-up</td>
            <td  width="26%" height="37">
              <select name="sel_state" onChange="checkstate()">
                <option value="0" selected>----Select----</option>
                <option value="1">Yes</option>
                <option value="2">No</option>
              </select>
            </td>
            <td id="s1">Pick-up point 
              at 
              <input type="text" name="txt_distancestate" size='10' maxlength='9'
					value="<%=Helper.correctNull((String)hshValues.get("txt_distanceloc"))%>"  onKeyPress="allowNumber(this)">
              (Km)  
              </td>
          </tr>
          <tr> 
            <td colspan="2" >Any Data on Demand 
              &amp; Supply of concerned crop produce and timing of release of 
              produce to market form cold storage</td>
            <td > 
              <select name="sel_demand" onChange="checkdemand()">
                <option value="0" selected>----Select----</option>
                <option value="1">Yes</option>
                <option value="2">No</option>
              </select>
            </td>
          </tr>
          <tr>
            <td colspan="2" id="d1">Source of Information</td>
            <td id="d2">
              <textarea name="txt_source" cols="70" rows="10" 
									onKeyPress="notAllowSingleQuote();textlimit(txt_source,699)" onKeyUp="textlimit(this,699)"></textarea>
              </td>
          </tr>
        </table>
      </td>
    </tr>
  </table><br>
 <lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
 
	<input type="hidden" name="hidRecordflag" > 
	<lapschoice:agrihiddentag pageid="<%=PageId%>"/>
	</form>
</body>

</html>



