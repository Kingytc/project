<%@ include file="../../share/directives.jsp"%>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld"%>

<html>
<head>
<title>monitoring Status</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/per/perrepappstatus.js">
</script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js">
</script>
<script>
<!--
var annexure = "<%=(String)request.getParameter("annexure")%>";
var path="<%=ApplicationParams.getAppUrl()%>";
var param="";
var userid ="<%=(String)session.getAttribute("strUserId")%>";
var rights ="<%=(String)session.getAttribute("strGroupRights")%>";
//var txtfromamt=window.opener.document.forms[0].txtfromamt.value;
//var txttoamt=window.opener.document.forms[0].txttoamt.value;
function menuOptionDivMouseDown (url) {
		//if (! isMac) {
			document.currentMenu.style.display='none';
			document.currentMBarOpt.style.border='1px solid lightgrey';
			document.menuIsActive = false;
			//window.location=url;
			document.forms[0].action=url;
			document.forms[0].submit();
			//}
		}
//-->

function doClose()
{
	callFunction('repnav.jsp');
}


function callFunction(pagename)
{
	document.forms[0].action = path+"action/"+pagename;
	document.forms[0].submit();
}

function doRunReport()
{
	if(document.forms[0].sellevel.value=="")
	{
		alert("Select Organisation Level");
		return;
	}
	if(annexure!='D')
	{
		if(annexure!='S')
		{	
			if(document.forms[0].accountclasssel.value=="")
			{
				alert("Select Account classification");
				return;
			}
		}
		/*if(document.forms[0].parameterselect.value=="")
		{
			alert("Select Parameters");
			return;
		}*/
	}	
	if(document.forms[0].rpselect1.value=="")
	{
		alert("Select Organisation");
		return;
	}
	
	
	if(document.forms[0].txtlimitfrom.value=="")
	{
		alert("Limit Range From cannot be empty");
		return;
	}	
	if(document.forms[0].txtlimitto.value=="")
	{
		alert("Limit Range To cannot be empty");
		return;
	}
	if(document.forms[0].accountstatus.value=="")
	{
		alert("Select Status of Account");
		return;
	}
	if(annexure!='D')
	{	
		if(document.forms[0].rowsrange.value=="")
		{
			document.forms[0].rowsrange.value="50";
		}
		if(isNaN(document.forms[0].rowsrange.value))
		{
			alert("Enter Valid number in No of Results per page");
			return;
		}
		
		if(eval(document.forms[0].rowsrange.value)>50)
		{
			alert("No of Results per page cannot be greater than 50");
			return;
		}	
	
		var rowsrange="";
		var  accountclasssel="";
		
		if(annexure=='S')
		{
			 accountclasssel='005';
		}
		else
		{
			accountclasssel = document.forms[0].accountclasssel.value;
		}
		
		//var parameterselect = document.forms[0].parameterselect.value;
		rowsrange =document.forms[0].rowsrange.value;
		//var txtoutstandingfrom = document.forms[0].txtoutstandingfrom.value;
		//var txtoutstandingto = document.forms[0].txtoutstandingto.value;
		
		/*if(txtoutstandingfrom!='')
		{
			 if(txtoutstandingto=='')
			 {
			 alert("O/s Range To cannot be empty");
			 document.forms[0].txtoutstandingto.focus();
			 return;
			 }
		}
		
		if(txtoutstandingto!='')
		{
			 if(txtoutstandingfrom=='')
			 {
			 alert("O/s Range From cannot be empty");
			 document.forms[0].txtoutstandingfrom.focus();
			 return;
			 }
		}
		
		if(eval(txtoutstandingfrom) > eval(txtoutstandingto))
		{
			alert("O/s  Range To amount cannot be less than O/s Range From");
			document.forms[0].txtoutstandingto.value=="";
			document.forms[0].txtoutstandingto.focus();
			return;
		}*/
		
		//var txtexcessfrom = document.forms[0].txtexcessfrom.value;
		//var txtexcessto = document.forms[0].txtexcessto.value;
		
		/*if(txtexcessfrom=='0.00' || txtexcessfrom=='0')
		{
			 alert("Excess / Overdue Range From Should higher than 0.00");
			 document.forms[0].txtexcessfrom.value="";
			 document.forms[0].txtexcessfrom.focus();
			 return;
		}
		
		if(txtexcessfrom!='')
		{
			 if(txtexcessto=='')
			 {
			 alert("Excess / Overdue Range To cannot be empty")
			 document.forms[0].txtexcessto.focus();
			 return;
			 }
		}*/
		
		/*if(txtexcessto!='')
		{
			 if(txtexcessfrom=='')
			 {
			 alert("Excess / Overdue Range From cannot be empty")
			 document.forms[0].txtexcessfrom.focus();
			 return;
			 }
		}
		
		if(eval(txtexcessfrom) > eval(txtexcessto))
		{
			alert("Excess / Overdue Range To amount cannot be less than Excess / Overdue Range From");
			document.forms[0].txtexcessto.value=="";
			document.forms[0].txtexcessto.focus();
			return;
		}*/
		document.forms[0].offset.value=document.forms[0].rowsrange.value;
	
		var schemecode = document.forms[0].schemecode.value;
		if(schemecode=='')
		{
				alert("Select Report for")
				document.forms[0].schemecode.focus();
				return;
		}
		/*if(document.forms[0].parameterselect.value=='001')
		{
			
		}*/
	}
	/*if(document.forms[0].txtoutstandingfrom.value=="")
	{
		alert("O/s Range From cannot be empty");
		return;
	}	
	if(document.forms[0].txtoutstandingto.value=="")
	{
		alert("O/s Range  To cannot be empty");
		return;
	}
	if(document.forms[0].txtexcessfrom.value=="")
	{
		alert("Excess / Overdue Range From cannot be empty");
		return;
	}	
	if(document.forms[0].txtexcessto.value=="")
	{
		alert("Excess / Overdue Range To cannot be empty");
		return;
	}*/
	var sellevel = document.forms[0].sellevel.value;
	
	var rpselect1="",org="",orgC="",org_name="";
	
	
	var txtlimitfrom = document.forms[0].txtlimitfrom.value;
	var txtlimitto = document.forms[0].txtlimitto.value;
	var limit = document.forms[0].limit.value;
	var offset = document.forms[0].offset.value;
	var tempTableCheck = document.forms[0].tempTableCheck.value;
	var tempRowcount = document.forms[0].tempRowcount.value;
	var accstatus=document.forms[0].accountstatus.value;
	var count =0;
	for(x=0;x<document.forms[0].rpselect1.length;x++)
	{
		if (document.forms[0].rpselect1[x].selected)
		{
			count++;
			var c = document.forms[0].rpselect1.options[x].value;
			c = c.substring(2,c.length);
			org =org + "'"+c+"'"+",";
			if(annexure=='S' || annexure=='C' ||annexure=='E' ||annexure=='D')
			{
				c = document.forms[0].rpselect1.options[x].text;
				org_name =org_name + "," + c ;
			}
		}
	}
	if (count > 0)
	{
		org= org.substring(0,org.length-1);
		if(annexure=='S' || annexure=='C' ||annexure=='E' ||annexure=='D')
			{
				org_name= org_name.substring(1,org_name.length);
			}
	}
	if(annexure=='C'||annexure=='E')
	{
		var len = document.forms[0].accountclasssel.length;	
		for(i=0;i<len;i++)
		{
			 if(document.forms[0].accountclasssel.options[i].selected==true)
			 {
				 var hidaccclass_text = document.forms[0].accountclasssel.options[i].text; 
				break;
			 }
		}
	}
	/*if(annexure!='D')
	{
		var len = document.forms[0].parameterselect.length;	
			for(i=0;i<len;i++)
			{
				 if(document.forms[0].parameterselect.options[i].selected==true)
				 {
					 var hidparameterselect_text = document.forms[0].parameterselect.options[i].text; 
					break;
				 }
			}
	}*/
	 len = document.forms[0].accountstatus.length;	
		for(i=0;i<len;i++)
		{
			 if(document.forms[0].accountstatus.options[i].selected==true)
			 {
				 var hidaccountstatus_text = document.forms[0].accountstatus.options[i].text; 
				break;
			 }
		}
	
	rpselect1 =org;
	if(annexure=='C')
	{
		window.open(path+"action/mon_annexurec_print.jsp?hidBeanId=perrepappstatus&hidBeanMethod=getData&hidMethod=getMonitoringReport&sellevel="+sellevel+"&accountclasssel="+accountclasssel+"&rpselect1="+rpselect1+"&txtlimitfrom="+txtlimitfrom+"&txtlimitto="+txtlimitto+"&limit="+limit+"&offset="+offset+"&tempTableCheck="+tempTableCheck+"&rowsrange="+rowsrange+"&tempRowcount="+tempRowcount+"&hidaccclass_text="+hidaccclass_text+"&org_name="+org_name+"&accstatus="+accstatus+"&hidaccountstatus_text="+hidaccountstatus_text+"&schemecode="+schemecode,"","scrollbars=Yes,toolbars=NO,menubar=NO ,width=900 , height=500,top=10,left=10");
	}
	else if (annexure=='D')	
	{
		window.open(path+"action/mon_annexured_print.jsp?hidBeanId=perrepappstatus&hidBeanMethod=getData&hidMethod=getMonitoringAnnexureD&sellevel="+sellevel+"&rpselect1="+rpselect1+"&txtlimitfrom="+txtlimitfrom+"&txtlimitto="+txtlimitto+"&org_name="+org_name+"&accstatus="+accstatus,"","scrollbars=Yes,toolbars=No,menubar=yes ,width=900 , height=800,top=10,left=10");
	}
	else if(annexure=='E')
	{
		window.open(path+"action/mon_annexuree_print.jsp?hidBeanId=perrepappstatus&hidBeanMethod=getData&hidMethod=getMonitoringReport&sellevel="+sellevel+"&accountclasssel="+accountclasssel+"&rpselect1="+rpselect1+"&txtlimitfrom="+txtlimitfrom+"&txtlimitto="+txtlimitto+"&limit="+limit+"&offset="+offset+"&tempTableCheck="+tempTableCheck+"&rowsrange="+rowsrange+"&tempRowcount="+tempRowcount+"&hidaccclass_text="+hidaccclass_text+"&org_name="+org_name+"&accstatus="+accstatus+"&hidaccountstatus_text="+hidaccountstatus_text+"&schemecode="+schemecode,"","scrollbars=Yes,toolbars=NO,menubar=NO ,width=900 , height=500,top=10,left=10");
	}
	else if(annexure=='F')
	{
		window.open(path+"action/mon_annexuref_print.jsp?hidBeanId=perrepappstatus&hidBeanMethod=getData&hidMethod=getMonitoringReport&sellevel="+sellevel+"&accountclasssel="+accountclasssel+"&rpselect1="+rpselect1+"&txtlimitfrom="+txtlimitfrom+"&txtlimitto="+txtlimitto,"","scrollbars=Yes,toolbars=No,menubar=no ,width=900 , height=500,top=10,left=10");
	}
	else if (annexure=='S')	
	{
		window.open(path+"action/mon_overstressedaccount_print.jsp?hidBeanId=perrepappstatus&hidBeanMethod=getData&hidMethod=getMonitoringReportOthers&sellevel="+sellevel+"&accountclasssel="+accountclasssel+"&rpselect1="+rpselect1+"&txtlimitfrom="+txtlimitfrom+"&txtlimitto="+txtlimitto+"&limit="+limit+"&offset="+offset+"&tempTableCheck="+tempTableCheck+"&rowsrange="+rowsrange+"&tempRowcount="+tempRowcount+"&org_name="+org_name+"&accstatus="+accstatus+"&hidaccountstatus_text="+hidaccountstatus_text+"&schemecode="+schemecode,"","scrollbars=Yes,toolbars=NO,menubar=NO ,width=900 , height=500,top=10,left=10");
	}
	else if (annexure=='C1')	
	{
		window.open(path+"action/mon_annexurec_print.jsp?hidBeanId=perrepappstatus&hidBeanMethod=getData&hidMethod=getMonitoringReportOthers&sellevel="+sellevel+"&accountclasssel="+accountclasssel+"&rpselect1="+rpselect1+"&txtlimitfrom="+txtlimitfrom+"&txtlimitto="+txtlimitto+"&limit="+limit+"&offset="+offset+"&tempTableCheck="+tempTableCheck+"&rowsrange="+rowsrange+"&tempRowcount="+tempRowcount+"&hidaccclass_text="+hidaccclass_text+"&org_name="+org_name+"&accstatus="+accstatus+"&hidaccountstatus_text="+hidaccountstatus_text+"&schemecode="+schemecode,"","scrollbars=Yes,toolbars=NO,menubar=NO ,width=900 , height=500,top=10,left=10");
	}
}


function selectValues()
{
	document.forms[0].rpselect1.selectedIndex =-1;
	var bnkname = document.forms[0].sellevel.options[document.forms[0].sellevel.selectedIndex].value;
	document.all.ifrm.src=path+"action/iframeapprep.jsp?hidBeanMethod=getData&hidMethod=getOrgnames&hidBeanId=repappper&bnklevel="+bnkname;
	document.forms[0].rpselect1.style.width="250";
	
	
}
/*
function paramSelect(obj1)
{
	
	if(annexure !='D')
	{
		var a = obj1.value;
		if(a=='001')
		{
			//document.all.hidrange.style.visibility="visible";
			//document.all.osrange.style.visibility="visible";
			//document.all.hidschcode.style.visibility="visible";
			
			//document.all.hidrange.style.position="relative";
			//document.all.osrange.style.position="relative";
			//document.all.hidschcode.style.position="relative";
		}
		else
		{	
			//document.forms[0].txtoutstandingfrom.value="";	
			//document.forms[0].txtoutstandingto.value="";
			//document.forms[0].txtexcessfrom.value="";
			//document.forms[0].txtexcessto.value="";
			//document.forms[0].schemecode.value="";
			//document.all.hidrange.style.visibility="hidden";
			//document.all.osrange.style.visibility="hidden";
			//document.all.hidschcode.style.visibility="hidden";
			
			//document.all.hidrange.style.position="absolute";
			//document.all.osrange.style.position="absolute";
			//document.all.hidschcode.style.position="absolute";
			
		}	
	}
}*/

function removeoption()
{
	if(annexure !='S' && annexure !='D')
	{
	var x=document.getElementById("acctclass")
   	x.options[3] = null; 
   	}
}

</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>

<body  onload="removeoption();">
<form name="perappstat" method="post" class="normal">
<iframe  height="0" width="0" id="ifrm" frameborder=0 style="border:0" ></iframe> 

  <table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td class="page_flow">Home&nbsp;-&gt;&nbsp;Monitoring&nbsp;-&gt;&nbsp;Reports&nbsp;-&gt;
      <%=Helper.correctNull((String)request.getParameter("annexure")).equalsIgnoreCase("S")?"Over Stressed Accounts":"Annexure " +Helper.correctNull((String)request.getParameter("annexure"))%>
      </td>
    </tr>
  </table>
  <table class="outertable border1"  width="100%" border="0" cellspacing="0" cellpadding="20" height="400" >
    <tr> 
      <td valign="middle"> 
        <table class="outertable border1"  border="0" cellspacing="0" cellpadding="3" align="center" width="65%" >
          <tr> 
            <td> 
              <table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="5" align="center">
                <tr> 
                  <td colspan="2" height="30"> 
                     
                    <table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="3">
                      <tr> 
                        <td width="50%" align="center" height="24">Organisation 
                          Level </td>
                         <%if(!"D".equals((String)request.getParameter("annexure")) && !"S".equals((String)request.getParameter("annexure")))
                         { %>
                        <td width="50%" align="center" height="24">Account 
                          classification </td>
                          <%} %>
                      </tr>
                      <tr> 
                        <td width="50%" align="center"> 
                          <select name="sellevel" style="width:100" onChange="selectValues()" tabindex="1" >
                            <option value="" selected>---Select---</option>
                           <%if(!"D".equals((String)request.getParameter("annexure")))
                         { %>
                            	<laps:reptag beanid="setupreport" methodname="getLevels" param="" /> 
                         	<%}else{ %> 	
                         
                         	<laps:reptag beanid="setupreport" methodname="getAnnexureDLevels" param="D" /> 
                         	
                         	<%} %>
                          </select>
                          </td>
                        <%if(!"D".equals((String)request.getParameter("annexure")) && !"S".equals((String)request.getParameter("annexure"))){ %>
                        <td width="50%" align="center"> 
                          <select name="accountclasssel" style="width:150" tabindex="3" id="acctclass">
                            <option value="" selected>---Select---</option>
                            <laps:StaticDataNewTag apptype="33"/> 
                          </select>
                        </td>
                        <%} %>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr> 
                  <td width="75%" valign="top" colspan="2"> 
                     
                    <table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="4">
                      <tr align="center"> 
                        <td align="center" width="50%">Select 
                          Organisation </td>
						  <%--if(!"D".equals((String)request.getParameter("annexure")))
                         { %>
                        <td align="center" width="50%">Parameters</td>
                      	<%}--%>
					  </tr>
                      <tr align="center"> 
                        <td width="50%">
                          <select name="rpselect1" size="11"   tabindex="2" style="width:150px">
                          </select>
                          
                          </td>
						   <%--if(!"D".equals((String)request.getParameter("annexure")) && !"S".equals((String)request.getParameter("annexure")))
                         { %>
                        <td width="50%" valign="top"> 
                          <select name="parameterselect" style="width:150" tabindex="4" size="11" onClick="paramSelect(this)" >
                            <option value="" selected>---Select---</option>
                            <option value="001">Loan default</option>
                            <option value="003">Non Renewal of Limits</option>
                            <option value="004">Non - Inspection of Securities</option>
                            <option value="005">Deficiency in Documentation </option>
                            <option value="006">Other Defaults</option>
                          </select>
                          <!-- <option value="convert(varchar,mail_date,103) as mail_date">Flowpoint 
                            Received Date</option>
                            <option value="wrk_flowname">Current Flowpoint Action</option>  -->
                        </td>
						<%}
						else if ("S".equals((String)request.getParameter("annexure"))){%>
						<td width="50%" valign="top"> 
                          <select name="parameterselect" style="width:150" tabindex="4" size="11" onClick="paramSelect(this)" >
                            <option value="" selected>---Select---</option>
                            <option value="001">Loan default</option>
                            <option value="003">Non Renewal of Limits</option>
                            <option value="006">Other Defaults</option>
                          </select>
                        </td>
                        <%}--%>
                      </tr>
                      <tr align="center"> 
                        <td align="center" colspan="2">
                          <table class="outertable"  width="77%" border="1" cellspacing="0" cellpadding="3" align="center" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
                            <tr> 
                              <td> 
                                <table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
                                  <tr> 
                                    <td width="29%" align="center" nowrap height="35"> 
                                      Limit Range From </td>
                                    <td width="71%" align="center" height="35"> 
                                      <laps:CurrencyTag name="txtlimitfrom" maxlength="15" size="18"  tabindex="5" /> 
                                      To &nbsp; <laps:CurrencyTag name="txtlimitto" maxlength="15" size="18"  tabindex="6" /> 
                                      </td>
                                  </tr>
								  <tr>
								  <td align="center" nowrap height="35">
								  Status of Account 
								  </td>
								  <td width="71%" align="left" height="35" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                      <select name="accountstatus"   style="width:100" tabindex="7" >
									   <option value="" selected>---Select---</option>
										<option value="NONRS">Normal</option>
										<option value="RESTR">Restructured</option>
                                      </select>
                                    </td>
								  </tr>
								   <%if(!"D".equals((String)request.getParameter("annexure")))
                        		 { %>
								<%--<tr id="hidrange"> 
                                    <td width="29%" align="center" nowrap height="35">O/s 
                                      Range From</td>
                                    <td width="71%" align="center" height="35"> 
									  <input type="text" name="txtoutstandingfrom" maxlength="15" size="18" onKeyPress="allowNegtiveNumber(this)" style="text-align:right" >
                                      To &nbsp; <laps:CurrencyTag name="txtoutstandingto" maxlength="15" size="18" /> 
                                      </td>
                                  </tr>
                                  <tr id="osrange"> 
                                    <td width="29%" align="center" nowrap height="35">Excess 
                                      / Overdue Range From</td>
                                    <td width="71%" align="center" height="35"> 
									  <input type="text" name="txtexcessfrom" maxlength="15" size="18" onKeyPress="allowNegtiveNumber(this)" style="text-align:right" >
                                      To &nbsp; <laps:CurrencyTag name="txtexcessto" maxlength="15" size="18"  /> 
                                      </td>
                                  </tr>--%>
								   <tr  id="hidschcode">
								  <td align="center" nowrap height="35">
								  Report for
								  </td>
								  <td width="71%" align="left" height="35" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                      <select name="schemecode"   style="width:100" tabindex="8" >
									   <option value="" selected>---Select---</option>
										<option value="G">General</option>
										<option value="F">FOREX</option>
                                      </select>
                                    </td>
								  </tr>
                                 <%-- <tr>
                                    <td width="29%" align="center" nowrap height="35">No 
                                      of Results per page</td>
                                    <td width="71%" align="left" height="35">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									 </td>
                                  </tr>--%>
                                  <input type="hidden" name="rowsrange" maxlength="20" size="10" onKeyPress="allowNumber(this)" >
								  <%}%>
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
  <br>
<lapschoice:combuttonnew btnnames="Run Report_Reset"
							btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
   <lapschoice:hiddentag pageid='<%=PageId%>'/>
  <input type="hidden" name="limit" value="0" >
  <input type="hidden" name="offset" value="50" >
  <input type="hidden" name="tempTableCheck" value="1" >
  <input type="hidden" name="tempRowcount" value="0">
  
</form>
</body>
</html>
