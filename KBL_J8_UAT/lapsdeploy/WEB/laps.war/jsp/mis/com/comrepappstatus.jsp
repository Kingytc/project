<%@ include file="../../share/directives.jsp"%>
<%

String str_report=(String)request.getParameter("report");
String str_multiple="";
if(str_report.equalsIgnoreCase("C"))
{
	str_multiple="multiple";
}
else
{
	str_multiple="";
}
%>
<html>
<head>
<title>Commercial Reports</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">

<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/com/comrepappstatus.js">
</script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>	
<script>

var path="<%=ApplicationParams.getAppUrl()%>";
var param="";
var userid ="<%=(String)session.getAttribute("strUserId")%>";
var rights ="<%=(String)session.getAttribute("strGroupRights")%>";
var per="";
var report = "<%=str_report%>";
function menuOptionDivMouseDown (url) {
			document.currentMenu.style.display='none';
			document.currentMBarOpt.style.border='1px solid lightgrey';
			document.menuIsActive = false;
			document.forms[0].action=url;
			document.forms[0].submit();
		}
//-->

function closeWindow()
{
	if (ConfirmMsg("100"))
	{
		document.forms[0].hidPage.value="Navigation";
		//document.forms[0].hidusr_id.value="<%=session.getAttribute("strUserid")%>";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/comrepappnav.jsp";
		document.forms[0].submit();
	}
	
}


function setParam()
{
	var opfields="";
	var dbfields="";
	var orgcode="";
	var orgname="";
	var count=0;
	var org="";
	var org_name="";
	param="";
	
	//if (document.forms[0].txtDate.value == "")
	//{
	//	document.forms[0].txtDate.value="All";
	//}
   var dt =document.forms[0].txtDate.value;
   
	if(document.forms[0].sellevel.selectedIndex != 0 
		&& document.forms[0].cmbstatus.selectedIndex != 0  
		&&	document.forms[0].rpselect1.selectedIndex != -1 ) 
	{
	
	var stat =document.forms[0].cmbstatus.options[document.forms[0].cmbstatus.selectedIndex].value;
		
		
	for (i=0;i<document.forms[0].rpselect2.length;i++)
        {
			if (document.forms[0].rpselect2.options[i].selected == true)
			{
				count++;
			}
        }
        
		if(count == 0)
		{
			for(i=0;i<6;i++)
			{
				document.forms[0].rpselect2.options[i].selected = true;
			}
		}
	orgcode =document.forms[0].sellevel.options[document.forms[0].sellevel.selectedIndex].text;
   
   count =0;
		for(x=0;x<document.forms[0].rpselect1.length;x++)
		{
			if (document.forms[0].rpselect1[x].selected)
			{
				count++;
				var c = document.forms[0].rpselect1.options[x].value;
				if(report!='C')
				{
				c = c.substring(2,c.length);
				}
				org =org + "'"+c+"'"+",";
				c = document.forms[0].rpselect1.options[x].text;
				org_name =org_name + "," + c ;	
						
			}
		}
		if (count > 0)
		{
			org= org.substring(0,org.length-1);
			org_name= org_name.substring(1,org_name.length);
		}
				
		
   
    param =orgcode+";"+org+";"+stat+";"+dt+";";
	
		 count =0;
		for(x=0;x<document.forms[0].rpselect2.length;x++)
		{
			if (document.forms[0].rpselect2[x].selected)
			{
				count++;
				if(document.forms[0].rpselect2.options[x].text=='Date')
				{
					if(document.forms[0].cmbstatus.value=='A')
					{
					dbfields =dbfields + "Approved Date,";
					}
					else if(document.forms[0].cmbstatus.value=='R')
					{
					dbfields =dbfields + "Rejected Date,";
					}
					else if(document.forms[0].cmbstatus.value=='P')
					{
					dbfields =dbfields;
					}
				}
				else if(document.forms[0].rpselect2.options[x].text=='Branch')
				{
				    if(document.forms[0].sellevel.value!='A')
					{
					dbfields =dbfields + "Branch,";
					}
					else if(document.forms[0].sellevel.value=='A')
					{
					dbfields =dbfields;
					}
				}
				else
				{
				dbfields =dbfields +document.forms[0].rpselect2.options[x].text+",";
				}
				opfields =opfields +document.forms[0].rpselect2.options[x].value+",";
							
			}
		}
		if(document.forms[0].cmbstatus.value=='A')
		{
		dbfields =dbfields + "Approved By,";
		}
		else if(document.forms[0].cmbstatus.value=='R')
		{
		dbfields =dbfields + "Rejected By,";
		}
		else if(document.forms[0].cmbstatus.value=='P'||document.forms[0].cmbstatus.value=='L')
		{
		dbfields =dbfields + "Pending with,";
		}
		if(document.forms[0].cmbstatus.value=='A')
		{
		opfields =opfields + "usr_fname,";
		}
		else if(document.forms[0].cmbstatus.value=='R')
		{
		opfields =opfields + "usr_fname,";
		}
		else if(document.forms[0].cmbstatus.value=='P'||document.forms[0].cmbstatus.value=='L')
		{
		opfields =opfields + "usr_fname as createdby,";
		}
		if(document.forms[0].cmbstatus.value!='L'){
		dbfields =dbfields + "Proposal Type,";
		opfields =opfields + "app_renew_flag,";
		}
		if (count > 0)
		{
			dbfields= dbfields.substring(0,dbfields.length-1);
			opfields= opfields.substring(0,opfields.length-1);
		}
	
	param +=opfields+";";
	param +=dbfields;

	document.forms[0].hidParam.value=param;
	document.forms[0].hidOrgCode.value =org;	
	document.forms[0].hidOpFields.value =opfields;	
	document.forms[0].hidSelFields.value =dbfields;	
	document.forms[0].hidStatus.value =stat;	
	document.forms[0].hidOrgName.value =org_name;	
	}
	else if(document.forms[0].sellevel.selectedIndex == 0)
	{
		ShowAlert('111',"Organisation Level");
		document.forms[0].sellevel.focus();
		return false;
	}
	else if(document.forms[0].cmbstatus.selectedIndex == 0)
	{
		ShowAlert('111',"Process Status");
		document.forms[0].cmbstatus.focus();
		return false;
	}
	else if(document.forms[0].rpselect1.selectedIndex == -1)
	{
		ShowAlert('111','Organisation');
		document.forms[0].rpselect1.focus();
		return false;
	}
	
	return param;
}

</script>
</head>

<body onload="callonLoad()">
<form name="orgfrm" method="post" class="normal">
  <iframe  height="0" width="0" id="ifrm" frameborder='0' style="border:0" ></iframe> 
  <br>
  <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="0">
  <%if("C".equals((String)request.getParameter("report"))){ %>
   <tr>
    <td class='page_flow'>Home -&gt; Reports -&gt; Corporate Reports & Agriculture -&gt; State / City Wise Application Search </td>
  </tr>
  <%}else{ %>
  <tr>
    <td class='page_flow'>Home -&gt; Reports -&gt; Corporate & Agriculture Reports -&gt; Application Status Pending/Approved/Rejected/Lodged </td>
  </tr>
  <%} %>
</table>
  <table class="outertable border1" width="100%" border="0" cellspacing="0" cellpadding="20" height="400" >
    <tr> 
      <td valign="middle"> 
        <table class="outertable border1" border="0" cellspacing="0" cellpadding="3" align="center"   width="60%">
          <tr> 
            <td> 
              <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="5" align="center">
                <tr> 
                  <td height="30">  
                    <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="3">
                      <tr> 
                        <td width="36%" align="center">Organisation 
                          Level </td>
                      	<td width="30%" align="center"> Product Type</td>			  
                        <td align="center" width="37%" >Process 
                          Status</td>
                      </tr>
                      <tr align="center"> 
                        <%if("C".equals((String)request.getParameter("report"))){ %>
                        <td width="36%" align="center"  > 
                          <select name="sellevel" style="width:120" onChange="LoadValues()" >
                            <option value="" selected="selected">---Select---</option>
                            <option value="State">State</option>
                            <option value="City">City</option>
                            <option value="S/C">City within a State</option>
                          </select>
                           </td>
                        <%}else{ %>
                        <td width="37%"> 
                          <select name="sellevel" style="width:100" onChange="selectValues()" >
                            <option selected="selected">---Select---</option>
                            <lapschoice:reptag beanid="setupreport" methodname="getLevels" param="" /> 
                          </select>
                           </td>
                        <%} %>
                        
						 <td align="center" width="30%">
						 <select name="selprodtype" style="width:100" tabindex="1" >
                                    <option selected value="S">---Select---</option>
                                    <option value="A">Agriculture</option>
                                    <option value="C">Corporate</option>
                                  </select>
						 </td>
                        <td align="center" width="27%" > 
                          <select name="cmbstatus" style="width:100">
                            <option selected="selected">---Select---</option>
                            <option value="P">Pending</option>
                            <option value="A">Approved</option>
                            <option value="R">Rejected</option>
                            <option value="L">Lodged</option>
                          </select></td>
                      </tr>
                      <%if("C".equals((String)request.getParameter("report"))){ %>
                      <tr id="state"> 
                        <td width="36%"  align="center" height="35" > 
                          <select name="sel_state"  onchange="LoadcityValues()">
                            <option value="0" selected="selected">--Select--</option>
                            <lapschoice:stateflexmaster /> 
                          </select>
                        </td>
                        
                      </tr>
                      <%} %>
                    </table>
                  </td>
                </tr>
               
                <tr> 
                  <td width="75%" valign="top"> 
                     
                    <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="4">
                      <tr align="center"> 
                        <td align="center">Select 
                          Organisation </td>
                        <td align="center" style="visibility:hidden;position:obsolute"> </td>
                      </tr>
                      <tr align="center"> 
                        <td> 
                          <select name="rpselect1" size="11"  style="width:180"  <%=str_multiple%> >
                          </select>
                          </td>
                        <td style="visibility:hidden;position:obsolute"> 
                          <select name="rpselect2" size="11"  style="width:130"  multiple="multiple">
                            <option value="app_no">Proposal Number</option>
                            <option value="perapp_fname">Applicant Name</option>
                            <option value="to_char(app_createdate,'dd/mm/yyyy') as app_date,to_char(inward_docreceivedon,'dd/mm/yyyy') as inward_date">Applied 
                            Date</option>
                            <option value="sum(facility_proposed) as proposedamt,app_valuesin">Amount</option>
                            <option value="to_char(app_processdate,'DD/MM/YYYY') as app_processdate">Date</option>
                            <option value="org_name">Branch</option>
                          </select>
                          </td>
                      </tr>
                      <tr align="center"> 
                        <td align="center" colspan="2"> 
                           
                          <table class="outertable" width="80%" border="0" cellspacing="0" cellpadding="3" align="center" >
                            <tr> 
                              <td height="37"> 
                                <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="6" align="center">
                                  <tr> 
                                    <td width="21%" align="center">Period 
                                      </td>
                                    <td width="79%" align="center"> 
                                      <input type="text" name="txtDate" maxlength="21" readonly="readonly" size="25" onFocus="document.forms[0].rprunreport.focus();">
                                      <a href="#" onClick="JavaScript:showPeriod()" class="blackfont"><b>?</b></a> 
                                      </td>
                                  </tr>
                                  <tr> 
                                    <td width="21%" align="center" nowrap="nowrap"> Amount
                                      From </td>
                                    <td width="79%" align="center"> <lapschoice:CurrencyTag  name="txtfromamt" maxlength="15" size="18" tabindex="6"/> 
                                    &nbsp;&nbsp;&nbsp;  To &nbsp;&nbsp;&nbsp;<lapschoice:CurrencyTag name="txttoamt" maxlength="15" size="18" tabindex="7"/> 
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
  
  <table class="outertable border1" width="1%" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr> 
      <td> 
        <table class="outertable" border="0" cellspacing="0" cellpadding="2">
          <tr valign="top"> 
            <td height="0" width="16%"> 
              <div align="center"> 
                <input type="button" name="rprunreport" value="Run Report" class="buttonothers" onClick="runrep()">
              </div>
            </td>
                <td height="0" width="15%"> 
              <div align="center"> 
                <input type="reset" name="rpreset" value="Reset" class="buttonothers"  onClick="JavaScript:resetValues()">
              </div>
            </td>
            <td height="0" width="21%"> 
              <div align="center"> 
                <input type="button" name="rpclose" value="Close" class="buttonClose" onClick="JavaScript:closeWindow()">
              </div>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
<lapschoice:hiddentag pageid='<%=PageId%>'/> 
<input type="hidden" name="hidOrgCode"  >
<input type="hidden" name="hidOpFields"  >
<input type="hidden" name="hidSelFields"  >
<input type="hidden" name="hidStatus"  >
<input type="hidden" name="userid" >
<input type="hidden" name="repname" value ="Commercial Application Status Report">
<input type="hidden" name="txtprofile_name" >
<input type="hidden" name="hidParam">
<input type="hidden" name="hidPage" value="comrunappstatus.jsp">
<input type="hidden" name="txtSaveDate" value='<%=Helper.getCurrentDateTime()%>'>
 <input type="hidden" name="hidOrgName">
</form>
</body>
</html>
