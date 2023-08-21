<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
if (objValues instanceof java.util.HashMap) {
				hshValues = (java.util.HashMap) objValues;
			}
			ArrayList arrCol = new ArrayList();
			ArrayList arrRow = new ArrayList();%>

<html>
<head>
<title>Document Consortium Meeting </title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var path      ="<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";

function placevalues()
{
	disableFields(true);
	disableCommandButtons(false,true,true,true,false);
}

function doNew()
	{
	disableFields(false); 
	disableCommandButtons(true,true,false,false,true);
	document.forms[0].hidAction.value ="insert";
	
	}

function doEdit()
{ 	
	document.forms[0].hidAction.value ="insert";
	disableFields(false); 
	disableCommandButtons(true,false,false,false,true);
}

function doSave()
{
	if(document.forms[0].txtmon_dateofmet.value=="")
	{
		alert("Please enter Date Of Meeting");
		document.forms[0].txtmon_dateofmet.focus();
		return;
	}	
	document.forms[0].hidBeanId.value="mmrcommon";
	document.forms[0].hidSourceUrl.value="/action/mon_consortiummeeting.jsp";
	document.forms[0].hidBeanMethod.value="updatemonConsortiumMeeting";
	document.forms[0].hidBeanGetMethod.value="getmonConsortiumMeeting";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidBeanGetMethod.value="getmonConsortiumMeeting";
		document.forms[0].hidBeanId.value="mmrcommon";
		document.forms[0].action=appURL+"action/mon_consortiummeeting.jsp";	
		document.forms[0].submit();
	}	
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
	document.forms[0].hidAction.value="delete";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidBeanId.value="mmrcommon";
	document.forms[0].hidSourceUrl.value="/action/mon_consortiummeeting.jsp";
	document.forms[0].hidBeanMethod.value="updatemonConsortiumMeeting";
	document.forms[0].hidBeanGetMethod.value="getmonConsortiumMeeting";	
	document.forms[0].submit();
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

function selectValues(val1, val2, val3, val4)
{
   	document.forms[0].hidsno.value =val1;
	document.forms[0].txtmon_dateofmet.value =val2;
	document.forms[0].txtmon_minutesmet.value=val3;
	document.forms[0].txtmon_received.value=val4;
	
	disableCommandButtons(false,false,true,false,false);

}

function disableCommandButtons(cmdedit,cmddelete,cmdapply,cmdcancel,cmdclose)
{
		document.forms[0].cmdedit.disabled=cmdedit;
		document.forms[0].cmddelete.disabled=cmddelete;
		document.forms[0].cmdsave.disabled=cmdapply;
		document.forms[0].cmdcancel.disabled=cmdcancel;
		document.forms[0].cmdclose.disabled=cmdclose;	
}  
	
function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}	
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}	  
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=val;
		}
		if(document.forms[0].elements[i].type=='radio')
		{
			document.forms[0].elements[i].disabled=!val;
		}	 
	}
}

function callCalender(fname)
{
	if (document.forms[0].cmdsave.disabled==false){
		 showCal(appURL,fname);
	}
}

function callLink(page,bean,method)
{
	if (document.forms[0].cmdsave.disabled)
	{
		document.forms[0].hidSourceUrl.value=page;
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
		document.forms[0].action=appURL+"action/"+page;
		document.forms[0].submit();
	}
	else
	{
		ShowAlert(103);
	}
}

</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="placevalues()">
<form name="frmstock" method="post" class="normal">  
  <table width="100%" border="0" cellpadding="5" cellspacing="0" class="outertable">
    <tr> 
      <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr> 
            <td class="page_flow">Home -&gt;Monitoring -&gt; Monthly Monitoring Reports-&gt;Consortium 
              -&gt;Borrower Info -&gt; Consortium Meeting</td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
 <lapschoice:MonthlyMonitor />
  <lapschoice:MonConsortiumTag pageid="2"/>
  <br>
  <table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable border1">
    <tr> 
      <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr> 
            <td> 
              <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                <tr> 
                  <td  width="14%">Date of Meeting<span class="mantatory">*&nbsp;</span></td>
                  <td  width="34%"> 
                    <table border="0" cellspacing="0" cellpadding="3" width="40%" class="outertable">
                      <tr> 
                        <td> 
                          <input type="text" name="txtmon_dateofmet" size="12"
											maxlength="10" tabindex="8" value="<%=Helper.correctNull((String)hshValues.get("mon_dateofmet"))%>" 										
											onBlur="checkDate(this);checkmaxdate(this,currentDate);">
                        </td>
                        <td><a href="#" onClick="callCalender('txtmon_dateofmet')"
											title="Click to view calender" border="0"><img
											src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
											width="0" border="0" tabindex="7"></a></td>
                        <td>&nbsp;(dd/mm/yyyy)</td>
                      </tr>
                    </table>
                  </td>
                  <td  width="18%">Minutes of Meeting / Major Observations</td>
                  <td  width="34%"> 
                    <textarea name="txtmon_minutesmet" wrap="VIRTUAL" onKeyPress="textlimit(document.forms[0].txtmon_minutesmet,3998)" onKeyUp="textlimit(this,3998)"><%=Helper.correctNull((String)hshValues.get("mon_minutesmet"))%></textarea>
                  </td>
                </tr>
                <tr> 
                  <td  width="14%">Minutes Received/Not received</td>
                  <td  width="34%"> 
                    <textarea name="txtmon_received" wrap="VIRTUAL" onKeyPress="textlimit(document.forms[0].txtmon_received,3998)" onKeyUp="textlimit(this,3998)"><%=Helper.correctNull((String)hshValues.get("mon_received"))%></textarea>
                  </td>
                  <td  width="18%">No of Meetings held during the 
                    Financial year.</td>
                  <td  width="34%">&nbsp; <input type="text" name="meetingheld" maxlength="20" size="10" onKeyPress="allowNumber(this)" tabindex="6" value="<%=Helper.correctNull((String)hshValues.get("mon_noofmeetingheld"))%>"> </td>
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
              <br> 
<lapschoice:hiddentag pageid='<%=PageId%>'/>
  <input type="hidden" name="hidsno" >
  <input type="hidden" name="cbsaccno" value="<%=request.getParameter("cbsaccno")%>">
  <input type="hidden" name="cbsid" value="<%=Helper.correctNull((String)request.getParameter("cbsid"))%>">
  <input type="hidden" name="mon_year" value="<%=Helper.correctNull((String)request.getParameter("mon_year"))%>">
  <input type="hidden" name="mon_month" value="<%=Helper.correctNull((String)request.getParameter("mon_month"))%>">
  <input type="hidden" name="cbsname" value="<%=Helper.correctNull((String)request.getParameter("cbsname"))%>">
  <input type="hidden" name="mon_accno" value="<%=Helper.correctNull((String)request.getParameter("mon_accno"))%>">
</form>
</body>
</html>
