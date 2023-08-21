<%@ include file="../../share/directives.jsp"%>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<%	
//	String strLevelOrgCode=(String)session.getAttribute("strOrgCode");
//	out.println("str==>"+strLevelOrgCode);
//	String strUserName=(String)session.getAttribute("strUserName");
//	out.println("str==>"+strUserName);
//	String strUserId=(String)session.getAttribute("strUserId");
//	out.println("str==>"+strUserId);
%>
<html>
<head>
<title>Application Tracking</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/per/perrepapptrack.js">
</script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js">
</script>
<script>
var path="<%=ApplicationParams.getAppUrl()%>";
var param="";
var userid ="<%=(String)session.getAttribute("strUserId")%>";
var rights ="<%=(String)session.getAttribute("strGroupRights")%>";

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
	
	
	if (document.forms[0].txtDate.value == "")
	{
		document.forms[0].txtDate.value="All";
	}
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

//		if(count < 6)
		if(count == 0)
		{
//			for(i=0;i<6;i++)
			for(i=0;i<8;i++)
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
						dbfields =dbfields + "Approved Date,Approved By,";
						opfields =opfields + "usr_fname,";
						}
						else if(document.forms[0].cmbstatus.value=='R')
						{
						dbfields =dbfields + "Rejected Date,Rejected By,";
						opfields =opfields + "usr_fname,";
						}
						else if(document.forms[0].cmbstatus.value=='P'|| document.forms[0].cmbstatus.value=='L')
						{
							dbfields =dbfields + "Pending with,";
							opfields =opfields + "usr_fname,";
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
	//for(x=0;x<document.forms[0].rpselect2.length;x++)
	//{
	//	if (document.forms[0].rpselect2[x].selected)
	//	{
		//		count++;
		//		opfields =opfields +document.forms[0].rpselect2.options[x].value+",";
		//		dbfields =dbfields +document.forms[0].rpselect2.options[x].text+",";
							
	//	}
	//}
	if( document.forms[0].cmbstatus.value!='L'){
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


</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body>
<form name="repapp" method="post" class="normal">
  <iframe  height="0" width="0" id="ifrm" frameborder=0 style="border:0" ></iframe> 
  <br>
  <table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td class="page_flow">Home -&gt; Reports
        -&gt; Retail Reports -&gt; Application Tracking </td>
    </tr>
    <tr> 
      <td align="right">&nbsp; </td>
    </tr>
  </table>
  <table class="outertable border1"  width="100%" border="0" cellspacing="0" cellpadding="20" height="400">
    <tr> 
      <td valign="middle"> 
        <div align="left"> 
          <table class="outertable border1"  width="60%" border="0" cellspacing="0" cellpadding="5" align="center">
            <tr> 
              <td> 
                <table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="5" align="center" height="248">
                  <tr> 
                    <td width="75%" valign="top">
<table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="5">
                        <tr> 
                          <td align="center" width="39%">Organisation Level</td>
                          <td align="center" colspan="2"> 
                            <table class="outertable"  width="100%" border="0">
                              <tr> 
                                <td width="51%" height="19"> Product Type</td>
                                <td width="49%" height="19">Process Status</td>
                              </tr>
                            </table>
                          </td>
                        </tr>
                        <tr> 
                          <td align="center" valign="top" width="39%"> 
                            <p> 
                              <select name="sellevel" style="width:100" onChange="selectValues()" tabindex="1" >
                                <option selected>--Select--</option>
                                <laps:reptag beanid="setupreport" methodname="getLevels" param="" /> 
                              </select>
                            </p>
                          </td>
                          <td align="center" valign="top" colspan="2"> 
                            <table class="outertable"  width="100%" border="0">
                              <tr> 
                                <td height="25">  
                                  <select name="selprodtype" style="width:100" onChange="refreshAppno()" tabindex="1" >
                                    <option selected value="S">---Select---</option>
                                    <option value="P">Retail</option>
                                  </select>
                                </td>
                                <td height="25"> 
                                  <select name="cmbstatus" style="width:100" onChange="resetData()" tabindex="2" >
                                    <option selected>---Select---</option>
                                    <option value="P">Pending</option>
                                    <option value="A">Approved</option>
                                    <option value="R">Rejected</option>
                                    <option value="L">Lodged</option>
                                  </select>
                                </td>
                              </tr>
                            </table>
                          </td>
                        </tr>
                        <tr> 
                          <td align="center" width="39%"> Select Organisation 
                          </td>
                          <td align="center" colspan="2">Application No </td>
                        </tr>
                        <tr> 
                          <td align="center" valign="top" width="39%"> 
                            <select name="rpselect1" size="11" style="width:250" onChange="refreshAppno()" tabindex="3" >
                            </select>
                          </td>
                          <td align="center" valign="top" width="65%"> 
                            <select name="selappno"  accesskey=""style="width:130"  multiple size="11" tabindex="4"  >
                            </select>
                          </td>
                          <td align="center" valign="top" style="visibility: hidden;" width="1%"> 
                            <select name="rpselect2" size="11" style="width:10" multiple tabindex="5" >
                              <option value="app_no">Proposal Number</option>
                              <option value="perapp_fname,perapp_lname">Applicant 
                              Name</option>
                              <option value="to_char(loan_receivedate,'DD/MM/YYYY') as app_date,to_char(inward_docreceivedon,'DD/MM/YYYY') as inward_date">Applied 
                              Date</option>
                              <option value="loan_recmdamt as loan_recmdamt">Amount</option>
                              <option value="(case when LOAN_PERTAINS_BRANCH is not null then (case when app_orglevel='C' then (select org_name from organisations where org_scode=LOAN_PERTAINS_BRANCH) when app_orglevel='D' then (select org_name from organisations where org_scode=LOAN_PERTAINS_BRANCH) else org_name end) else organisations.org_name end )as  org_name">Branch</option>
                              <!-- <option value="app_status">Application Status</option>-->
                              <option value="c.cat_name,c1.cat_name as scatname,prd_desc">Product 
                              Name</option>
                              <option value="to_char(app_processdate,'DD/MM/YYYY') as app_processdate">Date</option>
                              <!-- <option value="p1.prd_flowpoint as curflowpoint">Current 
                              Flowpoint</option>
                              <option value="convert(varchar,mail_date,103) as mail_date">Flowpoint 
                              Received Date</option>
                              <option value="w1.wrk_flowname as action">Current 
                              Flowpoint Action</option>
                              <option value="p2.prd_flowpoint as nextflowpoint">Next 
                              Flowpoint</option>
                              <option value="w2.wrk_flowname as nextaction">Next 
                              Flowpoint Action</option> -->
                            </select>
                          </td>
                        </tr>
                        <tr align="center" style="visibility: hidden;"> 
                          <td align="center" colspan="3"> 
                            <table class="outertable border1"  width="60%" border="0" cellspacing="0" cellpadding="3" align="center" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
                              <tr> 
                                <td> 
                                  <table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="3" align="center">
                                    <tr> 
                                      <td width="21%" align="center">Period </td>
                                      <td width="79%" align="center"> 
                                        <input type="text" name="txtDate" maxlength="21" readonly size="25" onFocus="document.forms[0].cmdrunreport.focus();">
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
<lapschoice:combuttonnew btnnames="Run Report_Reset"
							btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
   <lapschoice:hiddentag pageid='<%=PageId%>'/> 
  <input type="hidden" name="hidOrgCode">
  <input type="hidden" name="hidAppno">
  <input type="hidden" name="hidOpFields">
  <input type="hidden" name="hidStatus">
  <input type="hidden" name="hidSelFields">
  <input type="hidden" name="userid">
  <input type="hidden" name="repname" value ="Personal Application Tracking Report">
  <input type="hidden" name="hidParam">
  <input type="hidden" name="hidPage" value="perrunapptrack1.jsp">
  <input type="hidden" name="hidOrgName">
</form>
</body>
</html>
