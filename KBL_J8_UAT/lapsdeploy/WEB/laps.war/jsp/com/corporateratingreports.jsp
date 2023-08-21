<%@include file="../share/directives.jsp"%><html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
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
	
	document.forms[0].action=path+"action/ratingreportnav.jsp";
	document.forms[0].submit();
	}
}

function resetValues()
{
	document.forms[0].sellevel.options[0].selected =true;
	document.forms[0].rpselect1.length =0;
	document.forms[0].txtDate.value="";
	document.forms[0].selprocessstatus.value="S";
	

}
function runrep()
{
	if(document.forms[0].sellevel.value=="")
	{
		alert("Select Organisation Level");
		return;
	}
	if(document.forms[0].selprocessstatus.value=="S")
	{
		alert("Select Process Status");
		return;
	}
	if(document.forms[0].rpselect1.value=="")
	{
		alert("Select Organisation");
		return;
	}
	if (document.forms[0].txtDate.value == "")
		{
		ShowAlert('121',"Period");
		document.forms[0].txtDate.focus();
		return false;
		}
	var level=document.forms[0].sellevel.value;
	var orgselect=document.forms[0].rpselect1.value;
	var processstatus=document.forms[0].selprocessstatus.value;
	var org_name="";
	var period=document.forms[0].txtDate.value;
	var org="";

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
	
	document.forms[0].method="post";
	window.open(path+"action/corpratingreportprint.jsp?hidBeanId=perrepappstatus&hidBeanMethod=getData&hidMethod=getCorpRatingReport&sellevel="
				+level
				+"&orgselect="+orgselect
				+"&org_name="+org
			    +"&txtDate="+period
			    +"&hidprocessstatus="+processstatus
				,"","scrollbars=Yes,toolbars=NO,menubar=NO ,width=900 , height=500,top=10,left=10");

		
	
}

function showPeriod()
{
	document.forms[0].txtDate.value="";
	var purl = path+"jsp/share/repdateselect.jsp";
	var title = "ListofPeriod";
	var prop = "scrollbars=no,width=350,height=320";	
	var xpos = (screen.width - 350) / 2;
	var ypos = (screen.height - 320) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,title,prop);
}
function selectValues()
{
	var bnkname = document.forms[0].sellevel.options[document.forms[0].sellevel.selectedIndex].value;
	 document.all.ifrm.src=path+"action/iframeapprep.jsp?hidBeanMethod=getData&hidMethod=getOrgnames&hidBeanId=repappper&bnklevel="+bnkname;
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>

<body>
<form class="normal" name="perappstat" method="post">
<iframe  height="0" width="0" id="ifrm" frameborder=0 style="border:0" ></iframe> 
  <br>
  <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td class="page_flow">Home 
        -&gt; Reports -&gt; Rating Reports -&gt;Corporate Rating Reports</td>
    </tr>
    <tr> 
      <td align="right">&nbsp; </td>
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
                        <td width="39%" align="center">Organisation Level</td>
                        <td width="22%" align="center">&nbsp;</td>
                        <td width="39%" align="center">Process Status</td>
                      </tr>
                      <tr> 
              
                  
                       <td width="39%" align="center"> <select name="sellevel" style="width:100" onChange="selectValues()" tabindex="1" >
                            <option selected>---Select---</option>
                            <lapschoice:reptag beanid="setupreport" methodname="getLevels" param="" /> 
                          </select></td>
                        <td width="22%" align="center">&nbsp;</td>
                        <td width="39%" align="center"><select name="selprocessstatus" style="width:100" tabindex="3" >
                              <option selected value="S">---Select---</option>
                              <option value="P">Pending</option>
                              <option value="A">Approved</option>
                              <option value="R">Rejected</option>
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
                        <td align="center" width="4%">&nbsp; </td>
                  </tr>
                      <tr align="center"> 
                        <td width="96%"> 
                          <select name="rpselect1" size="11"  style="width:230" tabindex="4" >
                          </select>
                          </td>
                       
                      </tr>
                      <tr align="center"> 
                        <td align="center" colspan="2"> 
                          <table class="outertable border1" width="60%" border="0" cellspacing="0" cellpadding="3" align="center" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
                            <tr> 
                              <td> 
                                <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
                                  <tr> 
                                    <td width="21%" align="center">Period 
                                      </td>
                                    <td width="79%" align="center">&nbsp;
                                      <input type="text" name="txtDate" maxlength="21" readonly size="27" onFocus="document.forms[0].rprunreport.focus();">
                                      <a href="#" onClick="showPeriod()" class="blackfont" tabindex="5"><b>?</b></a> 
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
  </table>
  

</form>
</body>
</html>
