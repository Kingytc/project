<%@ include file="../../share/directives.jsp"%>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>

<html>
<head>
<title>MMR_Report</title>
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
	
	if(document.forms[0].rpselect1.value=="")
	{
		alert("Select Organisation");
		return;
	}
	
	if(document.forms[0].selrepstatus.value=="S")
	{
		alert("Select Report status");
		return;
	}
	
	if(document.forms[0].fromdate.value!="")
	{
		if(document.forms[0].todate.value=="")
		{
			alert("Select To Date");
			return;
		}
	}
	
	
	/*if(document.forms[0].txtfromamt.value=="")
	{
		alert("Amount From cannot be empty");
		return;
	}	
	if(document.forms[0].txttoamt.value=="")
	{
		alert("Amount To cannot be empty");
		return;
	}*/
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
		
	var rowsrange = document.forms[0].rowsrange.value;
	var sellevel = document.forms[0].sellevel.value;
	var varstatus = document.forms[0].selrepstatus.value;
	
	var	varfromdate= document.forms[0].fromdate.value;
	var	vartodate= document.forms[0].todate.value;
	
	var rpselect1="",org="",org_name="";
	
	
	//var txtlimitfrom = document.forms[0].txtlimitfrom.value;
	//var txtlimitto = document.forms[0].txtlimitto.value;
	
	var limit = document.forms[0].limit.value;
	var offset = document.forms[0].offset.value;
	
	var tempTableCheck = document.forms[0].tempTableCheck.value;
	var tempRowcount = document.forms[0].tempRowcount.value;
	document.forms[0].offset.value=document.forms[0].rowsrange.value;
	var count =0;
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
	
	rpselect1 =org;
    window.open(path+"action/mon_mmr_print.jsp?hidBeanId=perrepappstatus&hidBeanMethod=getData&hidMethod=getMMRReport&sellevel="
			+sellevel
			+"&rpselect1="+rpselect1
			+"&offset="+offset
			+"&tempTableCheck="+tempTableCheck
			+"&tempRowcount="+tempRowcount
			+"&org_name="+org_name
			+"&limit="+limit
			+"&varstatus="+varstatus
			+"&rowsrange="+rowsrange
			+"&fromdate="+varfromdate
			+"&todate="+vartodate
			,"","scrollbars=Yes,toolbars=NO,menubar=NO ,width=900 , height=500,top=10,left=10");
}


function selectValues()
{
	document.forms[0].rpselect1.selectedIndex =-1;
	var bnkname = document.forms[0].sellevel.options[document.forms[0].sellevel.selectedIndex].value;
 document.all.ifrm.src=path+"action/iframeapprep.jsp?hidBeanMethod=getData&hidMethod=getOrgnames&hidBeanId=repappper&bnklevel="+bnkname;
}

function doReset()
{
	document.forms[0].sellevel.options[0].selected =true;
	document.forms[0].rpselect1.length =0;
	document.forms[0].txtDate.value="";

}

function callCalender(fname)
 {
	 showCal("<%=ApplicationParams.getAppUrl()%>",fname);
 }
function doClose()
{
	callFunction('mon_front_selectreport.jsp');
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>

<body >
<form name="mmrstatus" method="post" class="normal">
<iframe  height="0" width="0" id="ifrm" frameborder=0 style="border:0" ></iframe> 
  <br>
  <table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td class="page_flow">Home 
        -&gt; Monitoring -&gt;Reports -&gt;Status Of Monthly Monitoring report </td>
    </tr>
    <tr> 
      <td align="right">&nbsp; </td>
    </tr>
  </table>
  <table class="outertable border1"  width="100%" border="0" cellspacing="0" cellpadding="20" >
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
                        <td width="49%" align="center">Organisation Level</td>
                        <td width="51%" align="center">Report Status </td>
                      </tr>
                      <tr> 
                        <td width="49%" align="center"  >
                          <select name="sellevel" style="width:100" onChange="selectValues()" tabindex="1" >
                                <option selected>--Select--</option>
                        <laps:reptag beanid="setupreport" methodname="getAnnexureDLevels" param="MMR" /> 
                         </select>
                         </td>
                        <td width="51%" align="center"> 
                          <select name="selrepstatus" style="width:100" tabindex="1" >
                              <option selected value="S">---Select---</option>
                              <option value="O">Generated</option>
                              <option value="P">Submitted</option>
                            </select></td>
							</tr>
                    </table>
                  </td>
                </tr>
                <tr> 
                  <td width="75%" valign="top" colspan="2">
                    <table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="4">
                      <tr align="center"> 
                        <td align="center" width="96%">Select Organisation </td>
                        
                  	    </tr>
                      <tr align="center"> 
                        <td width="96%"> 
                          <select name="rpselect1" size="11"  style="width:230" tabindex="3" >
                          </select>
                         
                      </tr>
                      <tr align="center"> 
                        <td align="center" colspan="2"> 
                          <table class="outertable border1"  width="80%" border="0" cellspacing="0" cellpadding="3" align="center" >
                            <tr> 
                              <td> 
                                <table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
                                  <tr> 
                                    <td width="42%" align="center">Period </td>
                                    <td width="58%"> 
                                    <table class="outertable">
                                    <tr>
                                    <td>
                                      From  &nbsp;&nbsp;</td><td><input type="text" name="fromdate" maxlength="20" size="12" onKeyPress="allowNumber(this)" > 
									  </td><td><a alt="Select date from calender"  href="javascript:callCalender('fromdate')"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"></a>&nbsp;&nbsp;
									  </td><td>To&nbsp;&nbsp;
									 </td><td> <input type="text" name="todate" maxlength="20" size="12" onKeyPress="allowNumber(this)" >
									 </td><td> <a alt="Select date from calender"  href="javascript:callCalender('todate')"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"></a>
                                     </td>
                                     </tr>
                                     </table>
                                      </td>
                                   </tr>
                                   <tr>
                                    <td width="42%" align="center" nowrap height="35">No 
                                      of Results per page</td>
                                    <td width="58%" align="left" height="35">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                      <input type="text" name="rowsrange" maxlength="20" size="10" onKeyPress="allowNumber(this)" > </td>
                                  </tr>
                                   <tr style="visibility: hidden;">
                                       
                                    <td width="42%" align="center" nowrap> Amount 
                                      From </td>
                                    
                                      
                                    <td width="58%" align="center"> <laps:CurrencyTag  name="txtfromamt" maxlength="15" size="18" tabindex="6"/> 
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
<input type="hidden" name="hidSelFields"  >
<input type="hidden" name="hidStatus"  >
<input type="hidden" name="userid" >
<input type="hidden" name="hidusr_id" >
<input type="hidden" name="hidOrgName">
<input type="hidden" name="limit" value="0" >
<input type="hidden" name="offset" value="50" >
 <input type="hidden" name="tempTableCheck" value="1" >
  <input type="hidden" name="tempRowcount" value="0">
</form>
</body>
</html>