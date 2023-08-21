<%@include file="../../share/directives.jsp"%><html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>NPA REPORTS</title>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script>
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var userid ="<%=(String)session.getAttribute("strUserId")%>";

function doClose()
{
	if(ConfirmMsg(100))
	 {
		 document.forms[0].action=appUrl+"action/npareplist.jsp";
		 document.forms[0].submit();
	 }
}

function selectValues()
{
	document.forms[0].sel_org.selectedIndex =-1;
	var bnkname = document.forms[0].sel_level.options[document.forms[0].sel_level.selectedIndex].value;
	document.all.ifrm.src=appUrl+"action/iframenpareport.jsp?hidBeanMethod=getData&hidMethod=getOrgnames&hidBeanId=repappper&bnklevel="+bnkname; 
}

function onLoading()
{
	document.forms[0].txt_period.readOnly=true;
}

function checkfields()
{
	var i;
	if(document.forms[0].sel_level.value=="0")
	{
		alert("Select level");
		document.forms[0].sel_level.focus();
		return false;
	}
	
	
	for(i=0;i<document.forms[0].sel_org.length;i++)
	{
		if(document.forms[0].sel_org.options[i].selected==true)
		{
			break;
		}
	}
	if(i==document.forms[0].sel_org.length)
	{
		alert("Select an Organisation");
		document.forms[0].sel_org.focus();
		return false;
	}
	for(i=0;i<document.forms[0].lawyerlist.length;i++)
	{
		if(document.forms[0].lawyerlist.options[i].selected==true)
		{
			break;
		}
	}
	if(i==document.forms[0].lawyerlist.length)
	{
		alert("Select an Advocate Name");
		document.forms[0].lawyerlist.focus();
		return false;
	}
	
	if(document.forms[0].txt_period.value=="")
	{
		alert("Enter Period");
		document.forms[0].txt_period.focus();
		return false;
	}
	
	if(document.forms[0].txt_frmamt.value=="")
	{
		alert("Enter Amount From");
		document.forms[0].txt_frmamt.focus();
		return false;
	}
	if(document.forms[0].txt_toamt.value=="")
	{
		alert("Enter Amount To");
		document.forms[0].txt_toamt.focus();
		return false;
	}
	return true;
}

function runreport()
{
	if(checkfields())
	{
		var varorglevel=document.forms[0].sel_level.value;
		var varorgcode=document.forms[0].sel_org.value;
		var varfrmamt=document.forms[0].txt_frmamt.value;
		var vartoamt=document.forms[0].txt_toamt.value;
		var varperiod=document.forms[0].txt_period.value;
		var varadvocate=document.forms[0].lawyerlist.value;
		window.open(appUrl+"action/npaadvocaterptresult.jsp?hidBeanId=npaapprep&hidBeanGetMethod=getData&hidMethod=getSuitbyAdvocate&hidOrgLevel="+varorglevel+"&hidOrgcode="+varorgcode+"&hidadvocate="+varadvocate+"&txtfromamt="+varfrmamt+"&txttoamt="+vartoamt+"&hidPeriod="+varperiod,"Advocatewise","scrollbars=Yes,toolbars=No,menubar=no ,width=750 , height=550,top=10,left=10");
	}
}

function showPeriod()
{
	var purl = appUrl+"action/npareportdateselect.jsp";
	var title = "ListofPeriod";
	var prop = "scrollbars=no,width=350,height=320";	
	var xpos = (screen.width - 350) / 2;
	var ypos = (screen.height - 320) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,title,prop);
}

function resetValues()
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			document.forms[0].elements[i].value="";
		}
		else
		if(document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].value=0;
		}
		else
		if(document.forms[0].elements[i].type=="select-multiple")
		{
			document.forms[0].elements[i].length=0;
		}
	}
	document.forms[0].sel_org.length=0;
}
function refreshAppno()
{
	count =0;
	var org="";
	if(document.forms[0].sel_org.selectedIndex != -1)
	{
	
		for(x=0;x<document.forms[0].sel_org.length;x++)
			{
	
				if (document.forms[0].sel_org[x].selected)
				{
					count++;
					var c = document.forms[0].sel_org.options[x].value;
					c = c.substring(2,c.length);
					org =org + "'"+c+"'"+",";
							
				}
			}
			if (count > 0)
			{
				org= org.substring(0,org.length-1);
			}
	//var org = document.forms[0].sel_org.options[document.forms[0].sel_org.selectedIndex].value;
    var orglevel =document.forms[0].sel_level.options[document.forms[0].sel_level.selectedIndex].value;	
	document.all.ifrm1.src=appUrl+"action/iframeadvocate.jsp?hidBeanGetMethod=getData&hidMethod=getlayerlist&hidBeanId=comrepapptrack&hidOrgCode="+org+"&orglevel="+orglevel;
	
	}

}
</script>
</head>
<body onload="onLoading()">
<form class="normal">
<iframe  height="0" width="0" id="ifrm" frameborder=0 style="border:0" ></iframe> 
<table cellspacing="0" cellpadding="0"  class="outertable" width="100%" border="0" >
<tr>
	<td class="page_flow">

		 
		Home -> NPA -> NPA Reports -> Advocate wise reports 
		
	</td>
</tr>
</table>
<table cellspacing="0" cellpadding="0"  class="outertable" width="100%" border="0">
<tr>
<td>&nbsp;

</td>
</tr>
<tr>
<td>
	
			<table cellspacing="0" cellpadding="0"  class="outertable border1" width="80%" align="center" valign="middle" border="0" >
			<tr>
			<td>
				    <table cellspacing="0" cellpadding="0"  class="outertable" width="100%" align="center" border="0">
                      <tr> 
                        <td> 
                          <table cellspacing="0" cellpadding="0"  class="outertable" width="100%" border="0">
                            <tr> 
                              <td width="50%" align="center" > Level </td>
                              <td width="50%" align="center" >&nbsp; </td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                      <tr> 
                        <td> 
                          <table cellspacing="0" cellpadding="0"  class="outertable" width="100%" border="0">
                            <tr> 
                              <td width="50%" align="center"> 
                                <select name="sel_level" onChange="selectValues()">
                                  <option value="0" selected>&lt;---select---&gt; 
                                  </option>
                                  <lapschoice:reptag beanid="setupreport" methodname="getLevels" param="" /> 
                                </select>
                              </td>
                              <td width="50%" align="center">&nbsp; </td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                      <tr> 
                        <td > 
                          <table cellspacing="0" cellpadding="0"  class="outertable" width="100%" border="0">
                            <tr> 
                              <td align="center" width="38%"> Select Organisation 
                              </td>
                              <td align="center" width="26%">Advocates name </td>
                            
                            </tr>
                          </table>
                        </td>
                      </tr>
                      <tr> 
                        <td > 
                          <table cellspacing="0" cellpadding="0"  class="outertable" width="100%" border="0">
                            <tr> 
                              <td align="center" width="39%"> 
                                <select name="sel_org" size="10" style="width:250"  onChange="refreshAppno()" >
                                </select>
                              </td>
							  <td align="center" valign="top" width="27%"> 
                                <select name="lawyerlist" style="width:130" size="11" tabindex="4"  >
                            </select>
                            </td>
                              
                            </tr>
                          </table>
                        </td>
                      </tr>
                      <tr> 
                        <td> 
                    <br>      <table cellspacing="0" cellpadding="5"  class="outertable" width="30%" border="0" align="center">
                            <tr> 
                              <td width="25%" align="center"> Period </td>
                              <td width="75%" align="center"> 
                                <input type="text" maxlength="21" name="txt_period" size="23">
                                &nbsp; <a href="#" onClick="JavaScript:showPeriod()" class="blackfont"><b>?</b></a> 
                              </td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                      <tr>
                        <td>
                          <table cellspacing="0" cellpadding="5"  class="outertable" width="70%" border="0" align="center">
                            <tr> 
                              <td width="25%" align="center"> Amount Range from</td>
                              <td width="25%" align="center"> 
                                <lapschoice:CurrencyTag maxlength="15" name="txt_frmamt" size="20"/>
                                &nbsp;</td>
								<td width="25%" align="center"> Amount Range To</td>
                              <td width="25%" align="center"> 
                                 <lapschoice:CurrencyTag maxlength="15" name="txt_toamt" size="20"/>
                                &nbsp;</td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                    </table>
				</td>
				</tr>
				</table><br>
				
	
<tr>
				<td>
			<br>	<table cellspacing="0" cellpadding="0"  class="outertable" width="50%" align="center">
					<tr>
						<td width="100%" align="center">
							<table cellspacing="0" cellpadding="0"  class="outertable" border="0">
							<tr>
							<td>
							<input type="button" name="cmdRunReport" value="Run Report" class="buttonothers" onclick="runreport()">
							<input type="button" name="cmdReset" value="Reset" class="buttonothers" onClick="resetValues()">
							<input type="button" name="cmdClose" value="Close" class="buttonclose" onClick="doClose()">
							</td>
							</tr>
							</table>
						</td>
					</tr>
				</table>	
			</td>
		</tr>
</table><br>
<input type="hidden" name="hidOrgCode">
 <iframe  height="0" width="0" id="ifrm1" frameborder=0 style="border:0" ></iframe> 
</form>
</body>
</html>
