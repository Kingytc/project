<%@ include file="../share/directives.jsp"%>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>

<html>
<head>
<title>Productwise Disposal of loan applications</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<STYLE>

DIV.cellContainer {	
  width: 100%; height: 150;
  overflow: auto;
}
</STYLE>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/per/perrepprddisposal.js">
</script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js">
</script>
<script>

var path="<%=ApplicationParams.getAppUrl()%>";
var bnkname="";
var param="";
var userid ="<%=(String)session.getAttribute("strUserId")%>";
var rights ="<%=(String)session.getAttribute("strGroupRights")%>";


function callCalender(fname)
 {
	 showCal(path,fname);
 }
 
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
		
function changeLoanType()
{
document.forms[0].rpprod.length =0;
deSelect();

 	if(document.forms[0].prodttype.value.toUpperCase()=="A")
 	{
	 	document.forms[0].prodcat.length=22;
	 	document.forms[0].prodcat.options[1] = new Option('Poultry Boiler','A');
	 	document.forms[0].prodcat.options[2] = new Option('Bullock Cart','B');
        document.forms[0].prodcat.options[3] = new Option('Crop Loans','C');
        document.forms[0].prodcat.options[4] = new Option('Diary Farming','D');
        document.forms[0].prodcat.options[5] = new Option('Animal Rearing','E');
        document.forms[0].prodcat.options[6] = new Option('Farm Machinery','F');
        document.forms[0].prodcat.options[7] = new Option('Gobar Gas Plant','G');
        document.forms[0].prodcat.options[8] = new Option('Gold Loan','H');
        document.forms[0].prodcat.options[9] = new Option('Consumption Loan','I');
        document.forms[0].prodcat.options[10] = new Option('Sericulture','J');
        document.forms[0].prodcat.options[11] = new Option('Loan Against Warehouse Receipts','L');
        document.forms[0].prodcat.options[12] = new Option('Vehicle Loan','M');
        document.forms[0].prodcat.options[13] = new Option('Fisheries','N');
        document.forms[0].prodcat.options[14] = new Option('Poultry Layering','P');
        document.forms[0].prodcat.options[15] = new Option('Plantation Term Loan','Q');
        document.forms[0].prodcat.options[16] = new Option('Loan Against deposit','R');
		document.forms[0].prodcat.options[17] = new Option('Minor Irrigation','U');
		document.forms[0].prodcat.options[18] = new Option('Common Product','K');
		document.forms[0].prodcat.options[19] = new Option('Union General Credit Card','V');
		document.forms[0].prodcat.options[20] = new Option('Purchase of fodder','T');
		document.forms[0].prodcat.options[21] = new Option('Union Bhumiheen Card','W');
        document.forms[0].prodcat.options[22] = new Option('Coffee Plantation','O'); 
		
     }
  	if(document.forms[0].prodttype.value.toUpperCase()=="P")
	{
		document.forms[0].prodcat.length=15;
		document.forms[0].prodcat.options[1] = new Option('Housing Loan','H');
		document.forms[0].prodcat.options[2] = new Option('Salaried Person','P');
		document.forms[0].prodcat.options[3] = new Option('Vehicle Loan','A');
		document.forms[0].prodcat.options[4] = new Option('Mortgage Loan','M');
		document.forms[0].prodcat.options[5] = new Option('Gold Loans','G');
		document.forms[0].prodcat.options[6] = new Option('Loan against Deposits','R');
        document.forms[0].prodcat.options[7] = new Option('Mahila Udyog','U');
        document.forms[0].prodcat.options[8] = new Option('Ravi Kiran','K');
        document.forms[0].prodcat.options[9] = new Option('Education Loan','E');
        document.forms[0].prodcat.options[10] = new Option('Leased Loan','L');
        document.forms[0].prodcat.options[11] = new Option('Instacash Loan','I');
        document.forms[0].prodcat.options[12] = new Option('Clean Loan','C');
        document.forms[0].prodcat.options[13] = new Option('NSC Loan','N');
        document.forms[0].prodcat.options[14] = new Option('Suvidha Loan','V');
        document.forms[0].prodcat.options[15] = new Option('General Loan','J');
 	}
}
//-->
</script>

<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>

<body>
<form name="orgfrm" method="post" class="normal">
<iframe  height="0" width="0" id="ifrm" frameborder=0 style="border:0" ></iframe> 
  <br>
  <table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td class="page_flow">Home 
        -&gt; Retail -&gt; Reports -&gt; Productwise Disposal of loan applications</td>
    </tr>
    <tr> 
      <td align="right">&nbsp; </td>
    </tr>
  </table>
  <table class="outertable"  width="100%" border="1" cellspacing="0" cellpadding="20" >
    <tr> 
      <td valign="middle"> 
        <table class="outertable"  width="90%" border="1" cellspacing="0" cellpadding="3" align="center"  >
          <tr> 
            <td> 
              <table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="5" align="center">
                <tr> 
                  <td width="24%">Organisation Level</td>
                  <td rowspan="8"> 
                    <table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="4">
                      <tr align="center"> 
                        <td align="center" width="35%">Select Organisation</td>
                        <td align="center"> Select Product </td>
                        <td align="center"> &nbsp;</td>
                      </tr>
                      <tr align="center"> 
                        <td width="45%">
                            <select name="rpselect1" size="11"  style="width:180" onChange="selectProd()" tabindex="4">
                          </select>
                        </td>
                        <td width="50%"> 
                          <select name="rpprod" size="11" style="width:300" multiple tabindex="5">
                          </select>
                        </td>
                        <td width="26%" style="visibility: hidden"> 
                          <select name="rpselect2" size="11"  style="width:10"  multiple tabindex="6">
                            <option value="1">No of Loans Applied</option>
                            <option value="2">No of loans Sanctioned</option>
                            <option value="3">No of Loans Rejected</option>
                            <option value="4">No of Loans in Process</option>
                            <!-- <option value="5">Loan Availed</option>
                            <option value="6">Interest Rate(%)</option> -->
                          </select>
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr> 
                  <td width="24%"> 
                    <select name="sellevel" style="width:250" onChange="selectValues()" tabindex="1">
                      <option selected>---Select---</option>
                      <laps:reptag beanid="setupreport" methodname="getLevels" param="" /> 
                    </select>
                  </td>
                </tr>
                <tr> 
                  <td width="24%" align="left">Category</td>
                </tr>
                <tr> 
                  <td width="24%"> <iframe  height="0" width="0" id="ifrmp" frameborder=0 style="border:0" src="<%=ApplicationParams.getAppUrl()%>action/iframecreditrep.jsp?hidBeanMethod=getData&hidMethod=getProducts&hidBeanId=repappper&hidProducts=prod&prodtype=p"></iframe> 
                    <select name="prodttype" style="width:250" onChange="changeLoanType()" tabindex="2" >
                      <option selected value="0">---Select---</option>
					    <option  value="p">Retail</option>
                    </select>
                  </td>
                </tr>
                <tr> 
                  <td width="24%">Sub Category</td>
                </tr>
                <tr> 
                  <td width="24%"> 
                    <select name="prodcat" style="width:250" tabindex="2" onchange="deSelect()">
                      <option selected value="0">---Select---</option>
                    </select>
                  </td>
                </tr>
                <tr> 
                  <td> Period </td>
                </tr>
                <tr> 
                  <td> 
                    <input type="text" name="txtDate" maxlength="21" readonly size="25" onFocus="document.forms[0].cmdrunreport.focus();">
                    <a href="#" onClick="showPeriod()"><b class="fontstyle">?</b></a> 
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
<input type="hidden" name="hidCatFields"  >
<input type="hidden" name="userid" >
<input type="hidden" name="repname" value ="Personal SOAR Report">
<input type="hidden" name="txtprofile_name" >
<input type="hidden" name="hidParam">
<input type="hidden" name="hidPage" value="perrunappsoar.jsp">
<input type="hidden" name="txtSaveDate" value='<%=Helper.getCurrentDateTime()%>'>
<input type="hidden" name="hidOrgName">
</form>
</body>
</html>
