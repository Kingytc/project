<%@include file="../../share/directives.jsp"%><html>
<head>
<title>MMR_Report</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/per/perrepappstatus.js">
</script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<SCRIPT language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js">
</script>
<script>
var path="<%=ApplicationParams.getAppUrl()%>";
var param="";
var userid ="<%=(String)session.getAttribute("strUserId")%>";
var rights ="<%=(String)session.getAttribute("strGroupRights")%>";

function closeData()
{
	if (ConfirmMsg("100"))
	{
	document.forms[0].hidBeanId.disabled=true;
	document.forms[0].action=path+"action/generalreportnav.jsp";
	document.forms[0].submit();
	}
}

function runrep()
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
	
	if(document.forms[0].selloantype.value=="S")
	{
		alert("Select Loan Type");
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
	
	
	
	if(document.forms[0].sel_sanctionlevel.value=="")
	{
			alert("Select Delegated Authority ");
			return;
	}
	
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
	var varloantype = document.forms[0].selloantype.value;
	
	var	varfromdate= document.forms[0].fromdate.value;
	var	vartodate= document.forms[0].todate.value;
	
//	var	varfromamt= document.forms[0].txtfromamt.value;
//	var	vartoamt= document.forms[0].txttoamt.value;

	var	varsanctionlevel= document.forms[0].sel_sanctionlevel.value;
	var varsanctionauth="";
	for(x=0;x<document.forms[0].sel_sanctionlevel.length;x++)
	{
		if (document.forms[0].sel_sanctionlevel[x].selected)
		{
				varsanctionauth = document.forms[0].sel_sanctionlevel.options[x].text;
		}
	}
	
	var rpselect1="",org="",org_name="";
	
	var limit = document.forms[0].limit.value;
	var offset = document.forms[0].offset.value;
	
	var tempTableCheck = document.forms[0].tempTableCheck.value;
	var tempRowcount = document.forms[0].tempRowcount.value;
	document.forms[0].offset.value=document.forms[0].rowsrange.value;
	var moduleType="";
	
	
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
	
	if(varloantype=='All')
	{
		moduleType="P";
	}
	
	rpselect1 =org;
	window.open(path+"action/com_sanctionedloan_print.jsp?hidBeanId=perrepappstatus&hidBeanMethod=getData&hidMethod=getSanctionedloanReport&sellevel="
				+sellevel
				+"&rpselect1="+rpselect1
				+"&offset="+offset
				+"&tempTableCheck="+tempTableCheck
				+"&tempRowcount="+tempRowcount
				+"&org_name="+org_name
				+"&limit="+limit
				+"&varloantype="+varloantype
				+"&rowsrange="+rowsrange
				+"&fromdate="+varfromdate
				+"&todate="+vartodate
				//+"&fromamt="+varfromamt
				+"&sanctionauth="+varsanctionauth
				+"&sanctionlevel="+varsanctionlevel
				+"&moduleType="+moduleType
				,"","scrollbars=Yes,toolbars=NO,menubar=NO ,width=900 , height=500,top=10,left=10");
	
}


function selectValues()
{
	document.forms[0].rpselect1.selectedIndex =-1;
	var bnkname = document.forms[0].sellevel.options[document.forms[0].sellevel.selectedIndex].value;
 	document.all.ifrm.src=path+"action/iframeapprep.jsp?hidBeanMethod=getData&hidMethod=getOrgnames&hidBeanId=repappper&bnklevel="+bnkname;
}

function resetValues()
{
	document.forms[0].sellevel.options[0].selected =true;
	document.forms[0].rpselect1.length =0;
	document.forms[0].selloantype.value="S";
	document.forms[0].fromdate.value="";
	document.forms[0].todate.value="";
//	document.forms[0].txtfromamt.value="";
//	document.forms[0].txttoamt.value="";
}

function callCalender(fname)
 {
	 showCal("<%=ApplicationParams.getAppUrl()%>",fname);
 }
 
 function checkDateRange()
 {
	var fromdate = document.forms[0].fromdate.value;
	var todate = document.forms[0].todate.value;
	fromdate = fromdate.substring(3,5);
	todate = todate.substring(3,5);
	
	if(fromdate != todate)
	{
	 alert("Date cannot go beyond one month");
	 document.forms[0].todate.value="";
	 return ;
	}
 }
 
 function callvalues()
{
	if(document.forms[0].selloantype.value=="C")
	{
		document.all.idvalues.innerHTML='<FONT SIZE=\"1\" color=\"red\"><b> (in Lacs) </b></font>';
	}
	else
	{
		document.all.idvalues.innerHTML='<FONT SIZE=\"1\" color=\"red\"><b> (in Rs.) </b></font>';
	}
}

function removeoption()
{
	
	var x=document.getElementById("class")
   	x.options[0] = null; 
    x.options[11] = null; 
}
 
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>

<body  onload="removeoption()">
<form class="normal" name="mmrstatus" method="post" >
<iframe  height="0" width="0" id="ifrm" frameborder="0" style="border:0" ></iframe> 
  <br>
  <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td class="page_flow">
           Home -&gt; Reports -&gt; General Reports -&gt; M - 27
          </td>
    </tr>
   
  </table>
  
        <table class="outertable border1" border="0" cellspacing="0" cellpadding="3" align="center" width="65%" >
          <tr> 
            <td> 
              <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="5" align="center">
                <tr> 
                  <td colspan="2" height="30">
                    <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="3">
                      <tr> 
                        <td width="49%" align="center">Organisation Level</td>
                        <td width="51%" align="center">Loan Type</td>
                      </tr>
                      <tr> 
                        <td width="49%" align="center"  ><font size="1" face="MS Sans Serif"> 
                          <select name="sellevel" style="width:100" onChange="selectValues()" tabindex="1" >
                                <option selected="selected">--Select--</option>
                        <lapschoice:reptag beanid="setupreport" methodname="getLevels" param="" /> 
                         </select>
                          </font> </td>
                        <td width="51%" align="center"> 
                          <select name="selloantype" style="width:100" tabindex="1" >
                              <option selected="selected" value="S">---Select---</option>
                               <option value="P">Retail</option>
                              <option value="A">Agriculture</option>
                              <option value="T">Tertiary</option>
                              <option value="C">Corporate</option>
                               <option value="All">All</option>
                            </select></td>
							</tr>
                    </table>
                  </td>
                </tr>
                <tr> 
                  <td width="75%" valign="top" colspan="2">
                    <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="4">
                      <tr align="center"> 
                        <td align="center" width="96%">Select Organisation </td>
                        <td align="center" width="96%">Select Delegated Authority </td>
                  	    </tr>
                      <tr align="center"> 
                        <td width="50%"> 
                          <select name="rpselect1" size="11"  style="width:230" tabindex="3" >
                          </select>
                         </td>
                        <td width="50%" align="center" valign="top"> 
                          <select name="sel_sanctionlevel" id="class" style="width:350" size="11"><lapschoice:StaticDataNewTag apptype="7"/></select>
                         </td>
                      </tr>
                      <tr align="center"> 
                        <td align="center" colspan="2"> 
                         
                                <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="3" align="center">
                                  <tr> 
                                    <td width="33%" align="center">Period </td>
                                    <td width="67%"> From &nbsp;&nbsp;
<input type="text" name="fromdate" maxlength="20" size="12" onKeyPress="allowNumber(this)" onblur="checkDate(this)" > 
									  <a alt="Select date from calender"  href="javascript:callCalender('fromdate')"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"></a>&nbsp;&nbsp;
									  To&nbsp;&nbsp;
									  <input type="text" name="todate" maxlength="20" size="12" onKeyPress="allowNumber(this)" onblur="checkDate(this);checkDateRange()">
									  <a alt="Select date from calender"  href="javascript:callCalender('todate')"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"></a>
                                      </td>
                                   </tr>
                                   
                                </table>
                              
                          
                        </td>
                      </tr>
					  <tr style="visibility: hidden;">
                                    <td width="42%" align="center" nowrap="nowrap" >No 
                                      of Results per page</td>
                                    <td width="58%" align="left" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                      <input type="text" name="rowsrange" maxlength="20" size="10" onKeyPress="allowNumber(this)" > </td>
                                  </tr>
                    </table>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
        </table>
     
  <br>
  <table class="outertable border1" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr> 
      <td> 
        <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="2">
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
                <input type="button" name="rpclose" value="Close" class="buttonClose" onClick="JavaScript:closeData()">
              </div>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table><br>
  <input type="hidden" name="hidBeanId" value="perrepappstatus" >
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