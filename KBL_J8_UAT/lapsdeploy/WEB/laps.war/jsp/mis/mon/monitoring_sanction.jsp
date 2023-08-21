<%@ include file="../../share/directives.jsp"%>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<html>
<head>
<title>Application Status</title>
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
var path="<%=ApplicationParams.getAppUrl()%>";
var param="";
var userid ="<%=(String)session.getAttribute("strUserId")%>";
var rights ="<%=(String)session.getAttribute("strGroupRights")%>";
function doRunReport()
{
	var param = setParam();
	var outf =document.forms[0].hidOpFields.value;
	var dbf =document.forms[0].hidSelFields.value;	 
	var code =document.forms[0].hidOrgCode.value;
	var orglevel=document.forms[0].sellevel.value;
	
	var dt=document.forms[0].txtDate.value;
	var sdt=document.forms[0].txtSaveDate.value;
	var txtfromamt=document.forms[0].txtfromamt.value;
	var txttoamt=document.forms[0].txttoamt.value;
	var orgname = document.forms[0].hidOrgName.value;
	var limit = document.forms[0].limit.value;
	var offset = document.forms[0].offset.value;
	var tempRowcount = document.forms[0].tempRowcount.value;
	var rowsrange =document.forms[0].rowsrange.value;
	document.forms[0].offset.value=document.forms[0].rowsrange.value;
	if(txtfromamt=="" && txttoamt=="")
	{
		alert("Enter From and To Amount");
		document.forms[0].txtfromamt.focus();
	}
	
	else if (param !="")
	{
		window.open(path+"action/monitoring_sanctionprint.jsp?hidBeanId=perrepappstatus&hidBeanMethod=getData&hidMethod=getMonitoringSanction&txtDate="+dt+"&txtSaveDate="+sdt+"&txtfromamt="+txtfromamt+"&txttoamt="+txttoamt+"&hidOrgCode="+code+"&hidOpFields="+outf+"&hidSelFields="+dbf+"&orglevel="+orglevel+"&hidOrgName="+orgname+"&limit="+limit+"&offset="+offset+"&tempRowcount="+tempRowcount+"&rowsrange="+rowsrange,"stat","scrollbars=Yes,toolbars=No,menubar=no ,width=750 , height=550,top=10,left=10");
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
	
	if(document.forms[0].sellevel.selectedIndex != 0 
		&&	document.forms[0].rpselect1.selectedIndex != -1 ) 
	{
	if (document.forms[0].txtDate.value == "")
	{
		document.forms[0].txtDate.value="All";
	}
   var dt =document.forms[0].txtDate.value;


		

	
	
		
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
				
		
   
    param =orgcode+";"+org+";"+dt+";";
		
	document.forms[0].hidParam.value=param;
	document.forms[0].hidOrgCode.value =org;	
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

function doReset()
{
	document.forms[0].sellevel.options[0].selected =true;
	document.forms[0].rpselect1.length =0;
	//document.forms[0].cmbstatus.options[0].selected =true;
	document.forms[0].txtDate.value="";

}

function selectValues()
{
	document.forms[0].rpselect1.selectedIndex =-1;
	var bnkname = document.forms[0].sellevel.options[document.forms[0].sellevel.selectedIndex].value;
 	document.all.ifrm.src=path+"action/iframeapprep.jsp?hidBeanMethod=getData&hidMethod=getOrgnames&hidBeanId=repappper&bnklevel="+bnkname;
 	document.forms[0].rpselect1.style.width="250";
}

function doClose()
{
	if (ConfirmMsg("100"))
	{
	document.forms[0].hidBeanId.disabled=true;
	document.forms[0].action=path+"action/mon_front_selectreport.jsp";
	document.forms[0].submit();
	}
	
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>

<body>
<form name="perappstat" method="post" class="normal">
<iframe  height="0" width="0" id="ifrm" frameborder=0 style="border:0" ></iframe> 
  <br>
  <table class="outertable border1"  width="100%" border="0" cellspacing="0" cellpadding="20" >
    <tr> 
      <td valign="middle"> 
        <table class="outertable border1"  border="0" cellspacing="0" cellpadding="3" align="center" width="65%">
          <tr> 
            <td> 
              <table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="5" align="center">
                <tr> 
                  <td colspan="2" height="30">
                    <table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="3">
                      <tr> 
                        <td width="50%" align="center">Organisation 
                          Level</td>
                        
                      </tr>
                      <tr> 
                        <td width="50%" align="center">
                          <select name="sellevel" style="width:100" onChange="selectValues()" tabindex="1" >
                            <option selected>---Select---</option>
                            <laps:reptag beanid="setupreport" methodname="getLevels" param="" /> 
                          </select>
                          </td>
                       
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
                        
                      </tr>
                      <tr align="center"> 
                        <td width="50%">
                          <select name="rpselect1" size="11" tabindex="3" style="width:150px">
                          </select>
                          </td>
                       
                      </tr>
                      <tr align="center"> 
                        <td align="center" colspan="2"> 
                          <table class="outertable border1"  width="60%" border="0" cellspacing="0" cellpadding="3" align="center">
                            <tr> 
                              <td> 
                                <table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
                                  <tr> 
                                    <td width="21%" align="center">Period 
                                      </td>
                                    <td width="79%" align="center">&nbsp;
                                      <input type="text" name="txtDate" maxlength="21" readonly size="27" onFocus="document.forms[0].cmdrunreport.focus();">
                                      <a href="#" onClick="showPeriod()" class="blackfont" tabindex="5"><b>?</b></a> 
                                      </td>
                                   </tr>
                                   <tr>
                                       <td width="21%" align="center" nowrap>
                                      Amount From </td>
                                    
                                      <td width="79%" align="center"> 
                                       <laps:CurrencyTag  name="txtfromamt" maxlength="15" size="18" tabindex="6"/> 
                                      	To &nbsp;<laps:CurrencyTag name="txttoamt" maxlength="15" size="18" tabindex="7"/>
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
  <br>
<lapschoice:combuttonnew btnnames="Run Report_Reset"
							btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
   <lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidOrgCode"  >
<input type="hidden" name="hidOpFields"  >
<input type="hidden" name="hidSelFields"  >
<input type="hidden" name="hidStatus"  >
<input type="hidden" name="userid" >
<input type="hidden" name="repname" value ="Personal Application Status Report">
<input type="hidden" name="txtprofile_name" >
<input type="hidden" name="hidParam">
<input type="hidden" name="hidPage" value="perrunappstatus.jsp">
<input type="hidden" name="hidusr_id" >
<input type="hidden" name="txtSaveDate" value='<%=Helper.getCurrentDateTime()%>'>
 <input type="hidden" name="hidOrgName">
 <input type="hidden" name="limit" value="0" >
 <input type="hidden" name="offset" value="50" >
 <input type="hidden" name="tempRowcount" value="0">
 <input type="hidden" name="rowsrange" value="50">
</form>
</body>
</html>
