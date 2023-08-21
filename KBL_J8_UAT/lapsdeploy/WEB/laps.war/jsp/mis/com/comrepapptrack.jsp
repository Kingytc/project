<%@include file="../../share/directives.jsp"%>
<html>
<head>
<title>Application Tracking</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">

<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/com/comrepapptrack.js">
</script>
<script>

var path="<%=ApplicationParams.getAppUrl()%>";
var param="";
var userid ="<%=(String)session.getAttribute("strUserId")%>";
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
	param="";
	var org_name="";
	if(document.forms[0].sellevel.selectedIndex != 0 
			&& document.forms[0].cmbstatus.selectedIndex != 0  &&
	document.forms[0].selappno.selectedIndex != -1 &&
	document.forms[0].rpselect1.selectedIndex != -1 ) 
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
			c = c.substring(2,c.length);
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
		
		ShowAlert('111',"only 10 Application Numbers");
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
		param =orgcode+";"+org+";"+appno+";";

		for(x=0;x<document.forms[0].rpselect2.length;x++)
		{
			if (document.forms[0].rpselect2[x].selected == true)
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
		 if(document.forms[0].cmbstatus.value=='A'||document.forms[0].cmbstatus.value=='R')
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
		document.forms[0].hidStatus.value =stat;	
		document.forms[0].hidOpFields.value =opfields;	
		document.forms[0].hidSelFields.value =dbfields;	
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
	else if(document.forms[0].selappno.selectedIndex == -1)
	{
		ShowAlert('111','Application Number');
		document.forms[0].selappno.focus();
		return false;
	}

	return param;
}

//-->
</script>
</head>
<body>
<form class="normal" name="comrepapptrack" method="post">
    <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class=page_flow>Home -&gt; Reports -&gt; Corporate & Agriculture Reports -&gt; Proposal Tracking </td>
  </tr>
</table>
  <table class="outertable border1" width="100%" border="0" cellspacing="0" cellpadding="20" height="400" >
    <tr> 
      <td valign="middle"> 
        <div align="left"> 
          <table class="outertable border1" width="57%" border="0" cellspacing="0" cellpadding="10" align="center">
            <tr> 
              <td> 
                <table class="outertable" width="99%" border="0" cellspacing="0" cellpadding="5">
                  <tr align="center"> 
                    <td width="46%">Organisation 
                      Level</td>
                    <td align="center" width="20%"> Product Type&nbsp;</td>
                    <td width="30%">Process 
                      Status</td>
                  </tr>
                  <tr align="center"> 
                    <td valign="top" width="46%"> 
                      <p><font size="1" > 
                        <select name="sellevel" style="width:100" onChange="selectValues()" >
                          <option selected>---Select---</option>
                          <lapschoice:reptag beanid="setupreport" methodname="getLevels" param="" /> 
                        </select>
                         </p>
                    </td>
                   <td align="center" valign="top" width="20%">
                          <select name="selprodtype" style="width:100"  onChange="resetData()">
                                    <option selected value="S">---Select---</option>
                                    <option value="A">Agriculture</option>
                                    <option value="C">Corporate</option>
                                  </select>
                          </td>
                    <td width="30%">
                      <select name="cmbstatus" style="width:100" onChange="resetData()">
                        <option selected>---Select---</option>
                        <option value="P">Pending</option>
                        <option value="A">Approved</option>
                        <option value="R">Rejected</option>
                        <option value="L">Lodged</option>
                      </select>
                      </td>
                  </tr>
                  <tr align="center"> 
                    <td width="46%">Select 
                      Organisation </td>
                    <td width="48%">Proposal 
                      No</td>
                    <td width="6%"></td>
                  </tr>
                  <tr align="center"> 
                    <td width="46%"><font size="1" > 
                      <select name="rpselect1" size="10" style="width:180" onChange="refreshAppno()">
                      </select>
                      </td>
                    <td width="48%"><font size="1" > &nbsp;
                      <select name="selappno"   style="width:130" multiple size="10">
                      </select>
                      </td>
                    <td width="6%"><font size="1"  style="visibility:hidden"> 
                      <select name="rpselect2" size="10" style="width:0" multiple>
                        <option value="app_no">Proposal Number</option>
                        <option value="perapp_fname">Applicant Name</option>
                        <option value="to_char(app_createdate,'dd/mm/yyyy') as app_date,to_char(INWARD_DOCRECEIVEDON,'DD/MM/YYYY') as inward_date">Applied Date</option>
                        <option value="sum(facility_sancamt) as facility_proposed,app_valuesin">Amount</option>
                         <option value="to_char(app_processdate,'DD/MM/YYYY') as app_processdate">Date</option>
                        <option value="(case when COM_PERTAINS_BRANCH is not null then (case when app_orglevel='C' then (select o1.ORG_NAME from organisations o1 where o1.org_scode=COM_PERTAINS_BRANCH) when app_orglevel='D' then (select o2.ORG_NAME from organisations o2 where o2.org_scode=COM_PERTAINS_BRANCH) else org_name end)  else org_name end ) as org_name">Branch</option>
                      </select>
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
  <table class="outertable border1" width="1%" border="0" cellspacing="0" cellpadding="0" align="center" >
    <tr> 
      <td> 
        <table class="outertable" width="69%" border="0" cellspacing="0" cellpadding="2">
          <tr valign="top"> 
            <td height="0" width="16%"> 
              <div align="center"> 
                <input type="button" name="rprunreport" value="Run Report" class="buttonothers" onClick="runrep()">
              </div>
            </td>
            <td height="0" width="15%"> 
              <div align="center"> 
                <input type="reset" name="rpreset" value="Reset" class="buttonothers" onClick="JavaScript:resetValues()">
              </div>
            </td>
            <td height="0" width="21%"> 
              <div align="center"> 
                <input type="button" name="rpclose" value="Close" 
class="buttonclose"  onClick="JavaScript:winClose()">
              </div>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <br>
  <input type="hidden" name="hidBeanId" value="comrepapptrack">
  <input type="hidden" name="hidOrgCode"  >
  <input type="hidden" name="hidAppno"  >
  <input type="hidden" name="hidOpFields"  >
  <input type="hidden" name="hidSelFields"  >
  <input type="hidden" name="userid" >
  <input type="hidden" name="repname" value ="Commercial Application Tracking Report">
  <input type="hidden" name="hidParam">
  <input type="hidden" name="hidPage" value="comrunapptrack.jsp">
  <input type="hidden" name="txtDate" value=''>
    <input type="hidden" name="hidStatus">
    <input type="hidden" name="hidOrgName">
</form>
  <iframe  height="0" width="0" id="ifrm" frameborder=0 style="border:0" ></iframe> 
</body>
</html>
