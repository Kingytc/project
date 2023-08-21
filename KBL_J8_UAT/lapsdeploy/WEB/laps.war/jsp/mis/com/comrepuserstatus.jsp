<%@include file="../../share/directives.jsp"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<%	
	String strLevelOrgCode=(String)session.getAttribute("strOrgCode");
	String strUserName=(String)session.getAttribute("strUserName");
	String strUserId1=(String)session.getAttribute("strUserId");
%>
<html>
<head>
<title>User Tracking</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<STYLE>

DIV.cellContainer {	
  width: 100%; height: 150;
  overflow: auto;
}

</STYLE>

<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/com/comrepuserstatus.js">
</script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>	
<script>

var path="<%=ApplicationParams.getAppUrl()%>";
var param="";
var userid ="<%=(String)session.getAttribute("strUserId1")%>";
var rights ="<%=(String)session.getAttribute("strGroupRights")%>";

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

function setParam()
{
	var opfields="";
	var dbfields="";
	var orgcode="";
	var org="";
	var count=0;
	var appno="";
	var org_name="";
	var appname="";
	param="";
	//if (document.forms[0].txtDate.value == "")
	//{
	///	document.forms[0].txtDate.value="All";
///	}
   var dt =document.forms[0].txtDate.value;

   if(document.forms[0].sellevel.selectedIndex != 0 

		&& document.forms[0].cmbstatus.selectedIndex != 0  
	&& document.forms[0].selappno.selectedIndex != -1 &&
	document.forms[0].rpselect1.selectedIndex != -1 ) 
	{
		
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
   var stat =document.forms[0].cmbstatus.options[document.forms[0].cmbstatus.selectedIndex].value;
    count =0;
	for(x=0;x<document.forms[0].rpselect1.length;x++)
	{
		if (document.forms[0].rpselect1[x].selected)
		{
			count++;
			var c = document.forms[0].rpselect1.options[x].value;
			c = c.substring(2,c.length);
			org =org + "'"+c+"'"+",";
			c = document.forms[0].rpselect1.options[x].text;
			org_name =org_name + "," + c ;		
		}
	}
	for(x=0;x<document.forms[0].selappno.length;x++)
	{
	if (document.forms[0].selappno[x].selected)
		{
		var c = document.forms[0].selappno.options[x].text;
			appname=c;
		}
	}
	if (count > 0)
	{
		org= org.substring(0,org.length-1);
		org_name= org_name.substring(1,org_name.length);
	}
	 
    count =0;
	for(x=0;x<document.forms[0].selappno.length;x++)
	{
		if (document.forms[0].selappno[x].selected)
		{
			count++;
			var n = document.forms[0].selappno.options[x].value;
			appno =appno + "'"+n+"'"+",";
					
		}
	}
	if (count > 10)
	{
		
		ShowAlert('111',"only 10 users");
		for(x=0;x<document.forms[0].selappno.length;x++)
		{
			if (document.forms[0].selappno[x].selected)
			{
				document.forms[0].selappno[x].selected = false;													
			}
		}
		document.forms[0].selappno.focus();
		return false;
	
	}
	if (count > 0)
	{
		appno= appno.substring(0,appno.length-1);
	}
	//param =orgcode+";"+org+";"+appno+";";
      param =orgcode+";"+org+";"+stat+";"+dt+";"+appno+";";
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
	if(document.forms[0].cmbstatus.value!='L')
	{
	dbfields =dbfields + "Proposal Type,";
	opfields =opfields + "app_renew_flag,";
	}
	if (count > 0)
		{
			dbfields= dbfields.substring(0,dbfields.length-1);
			opfields= opfields.substring(0,opfields.length-1);
		}
	
	param +=opfields+";";
	param +=dbfields+";"+stat;

	document.forms[0].hidParam.value=param;
	document.forms[0].hidOrgCode.value=org; 
	document.forms[0].hidAppno.value=appno; 
	document.forms[0].hidOpFields.value =opfields;	
	document.forms[0].hidStatus.value =stat;	
	document.forms[0].hidSelFields.value =dbfields;	
	document.forms[0].hidOrgName.value =org_name;	
	document.forms[0].hidAppName.value =appname;
	}
	else if(document.forms[0].sellevel.selectedIndex == 0)
	{
		ShowAlert('111',"Organisation Level");
		document.forms[0].sellevel.focus();
		return false;
	}
	/*else if(document.forms[0].cmbstatus.selectedIndex == 0)
	{
		ShowAlert('111',"Process Status");
		document.forms[0].cmbstatus.focus();
		return false;
	}*/
	else if(document.forms[0].rpselect1.selectedIndex == -1)
	{
		ShowAlert('111','Organisation');
		document.forms[0].rpselect1.focus();
		return false;
	}
	else if(document.forms[0].selappno.selectedIndex == -1)
	{
		ShowAlert('111','User');
		document.forms[0].selappno.focus();
		return false;
	}
	
	return param;
}
//-->
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body >
<form name="repapp" method="post" class="normal">
  <iframe  height="0" width="0" id="ifrm" frameborder=0 style="border:0" ></iframe> 
  <br>
  <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class=page_flow>Home -&gt; Reports -&gt; Corporate & Agriculture Reports -&gt; Userwise Status of Pending/Approved/Rejected/Lodged  </td>
  </tr>
</table>
  <table class="outertable border1" width="100%" border="0" cellspacing="0" cellpadding="20" height="400" >
    <tr> 
      <td valign="middle"> 
        <div align="left"> 
          <table class="outertable border1" width="60%" border="0" cellspacing="0" cellpadding="5" align="center" >
            <tr> 
              <td> 
                <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="5" align="center" height="248">
                  <tr> 
                    <td width="75%" valign="top"> 
                      <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="5">
                        <tr> 
                          <td align="center" width="44%">Organisation Level</td>
                          <td align="center" width="20%"> Product Type&nbsp;</td>
                          <td align="center" width="40%">Process Status</td>
                        </tr>
                        <tr> 
                          <td align="center" valign="top" width="44%"> 
                            <select name="sellevel" style="width:100" onChange="selectValues()" tabindex="1" >
                                <option selected>--Select--</option>
                                 <laps:reptag beanid="setupreport" methodname="getLevels" param="" /> 
                              </select>
                          </td>
                          <td align="center" valign="top" width="20%">
                          <select name="selprodtype" style="width:100">
                                    <option selected value="S">---Select---</option>
                                    <option value="A">Agriculture</option>
                                    <option value="C">Corporate</option>
                                  </select>
                          </td>
                          <td align="center" valign="top" width="40%"> 
                            <select name="cmbstatus" style="width:100" tabindex="2"  >
                              <option selected>---Select---</option>
                              <option value="P">Pending</option>
                              <option value="A">Approved</option>
                              <option value="R">Rejected</option>
                              <option value="L">Lodged</option>
                            </select>
                          </td>
                          
                        </tr>
                        <tr> 
                          <td align="center" width="44%"> Select Organisation 
                          </td>
                          <td align="center" width="52%">Name of User</td>
                          <td align="center" width="4%">&nbsp;</td>
                        </tr>
                        <tr> 
                          <td align="center" valign="top" width="44%"> 
                            <select name="rpselect1" size="11" style="width:250" onChange="refreshAppno()" tabindex="3" >
                            </select>
                            </td>
                          <td align="center" valign="top" width="52%" > 
                            <select name="selappno"  accesskey=""style="width:200"  size="11" tabindex="4" >
                            </select>
                            </td>
                           
                          <td align="center" valign="top" style="visibility:hidden" width="4%"> 
                            <select name="rpselect2" size="11" style="width:10" multiple tabindex="5" >
	                      <option value="app_no">Proposal Number</option>
	                      <option value="perapp_fname">Applicant  Name</option>
	                      <option value="to_char(app_createdate,'DD/MM/YYYY') as app_date,to_char(INWARD_DOCRECEIVEDON,'DD/MM/YYYY') as inward_date">Applied  Date</option>
	                      <option value="sum(facility_sancamt) as facility_proposed,app_valuesin">Amount</option>
	                      <option value="org_name">Branch</option>
	                      <option value="to_char(app_processdate,'DD/MM/YYYY') as app_processdate">Date</option>
                    </select>
                  </td>
                        </tr>
                        
                                              <tr align="center"> 
                        <td align="center" colspan="2">
                          <table class="outertable" width="60%" border="0" cellspacing="0" cellpadding="5" align="center">
                            <tr> 
                              <td> 
                                <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
                                  <tr> 
                                    <td width="21%" align="center">Period 
                                      </td>
                                    <td width="79%" align="center">
                                      <input type="text" name="txtDate" maxlength="21" readonly size="25" onFocus="document.forms[0].rprunreport.focus();">
                                      <a href="#" onClick="showPeriod()" class="blackfont" tabindex="6" ><b>?</b></a> 
                                      </td>
                                  </tr>
                                </table>
                              </td>
                            </tr>
                          </table>
                          
                        </td>
                      </tr>
                        
                        <tr> 
                          <td align="center" colspan="3">&nbsp; </td>
                        </tr>
                      </table>
                    </td>
                  </tr>
                </table>
              </td>
            </tr>
          </table>
        </div>
      </td>
    </tr>
  </table>
  <br>
  <table class="outertable border1"  border="0" cellspacing="0" cellpadding="0" align="center" >
    <tr> 
      <td> 
        <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="2">
          <tr valign="top"> 
            <td height="0" width="16%"> 
              <div align="center"> 
                <input type="button" name="rprunreport" value="Run Report" class="buttonothers" onClick="runrep()" tabindex="7" >
              </div>
            </td>
          
            <td height="0" width="15%"> 
              <div align="center"> 
                <input type="reset" name="rpreset" value="Reset" class="buttonothers" onClick="JavaScript:resetValues()" tabindex="8" >
              </div>
            </td>
            <td height="0" width="21%"> 
              <div align="center"> 
                <input type="button" name="rpclose" value="Close" class="buttonClose" onClick="JavaScript:nav()" tabindex="10" >
              </div>
            </td>
			
          </tr>
        </table>
      </td>
    </tr>
  </table>
  
 <lapschoice:hiddentag pageid='<%=PageId%>'/> 
  
  <input type="hidden" name="hidOrgCode">
  <input type="hidden" name="hidAppno">
  <input type="hidden" name="hidOpFields">
  <input type="hidden" name="hidStatus">
  <input type="hidden" name="hidSelFields">
  <input type="hidden" name="userid">
  <input type="hidden" name="repname" value ="Personal User Status Tracking Report">
  <input type="hidden" name="hidParam" value="">
  <input type="hidden" name="hidPage" value="perrunapptrack.jsp">
  <input type="hidden" name="hidOrgName">
   <input type="hidden" name="hidAppName">
</form>
</body>
</html>
