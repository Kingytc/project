<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<laps:handleerror />

<html>
<head>
<title>Printing Personal Forms</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<STYLE>

DIV.cellContainer {	
  width: 100%; height:130;
  overflow: auto;
}
</STYLE>
<style type="text/css">
<!--
input {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399}
select {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399}
a:hover {  color: #FF6600}
-->
</style>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script>
<!--

var path="<%=ApplicationParams.getAppUrl()%>";

function selectValues()
{
	document.all.ifrm2.src="";
	var bnkname = document.forms[0].sellevel.options[document.forms[0].sellevel.selectedIndex].value;
 document.all.ifrm.src=path+"action/iframeapprep1.jsp?hidBeanMethod=getData&hidMethod=getOrgnames&hidBeanId=repappcom&bnklevel="+bnkname;
}

function getValues()
{

var regExp =/['']/;
 
	if(document.forms[0].rpselect1.selectedIndex == -1 || document.forms[0].sellevel.selectedIndex == -1 )
	{
		alert("Select the Organisation Level");
	}
	else
	{
		var field='';
var bnkname = document.forms[0].rpselect1.options[document.forms[0].rpselect1.selectedIndex].value;
	    bnkname = bnkname.substring(2,bnkname.length);
		var val = document.forms[0].txtSearch.value;
		if(val.match(regExp)!=null)
		{
			alert("Invalid Character")
			document.forms[0].txtSearch.focus();
		}
		else
		{
			if (document.forms[0].searchby[0].checked == true)
				field = document.forms[0].searchby[0].value;
			else if (document.forms[0].searchby[1].checked == true)
				field = document.forms[0].searchby[1].value;
			else if (document.forms[0].searchby[2].checked == true)
				field = document.forms[0].searchby[2].value;
		
document.all.ifrm2.src=path+"action/iframecashflowbob.jsp?hidBeanMethod=getData&hidMethod=getSearchData&hidBeanId=comrepprint&orgcode="+bnkname+"&field="+field+"&txtSearch="+val;
		}
	}
}

function resetme()
{
	document.forms[0].searchby[0].checked=false;
	document.forms[0].searchby[1].checked=false;
	document.forms[0].searchby[2].checked=false;
	document.forms[0].txtSearch.value="";
	document.forms[0].sellevel.options[0].selected=true;
	document.forms[0].rpselect1.length=0;
	document.all.ifrm2.src="";
}

function closeWindow()
{
	if (ConfirmMsg("100"))
	{
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/comrepappnav.jsp";
		document.forms[0].submit();
	}
	
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
//-->
</script>
</head>
<body bgcolor="#EEEAE3" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form name="frmprintcomm">
<iframe  height="0" width="0" id="ifrm" frameborder=0 style="border:0" ></iframe> 
  <div align="center"> 
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr> 
        <td>
			<font face="Times New Roman" size="3">
				<b><i>Cash Flow</i></b>
			</font>
		</td>
      </tr>
      <tr> 
        <td align="right">&nbsp; </td>
      </tr>
    </table>
	</div>
	
    <table width="100%" border="1" cellspacing="0" cellpadding="3" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
    <tr>
	  <td valign="top">
	  <div align="left"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="3" >
        <tr> 
          <td height="178" valign="top"> 
            <table width="100%" border="1" cellspacing="0" cellpadding="2" height="10" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
              <tr> 
                <td height="97" valign="top"> 
                  <table width="100%" border="0" cellspacing="0" cellpadding="5" height="8">
                    <tr> 
                      <td> 
                        <table width="50%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" align="right">
                          <tr> 
                            <td> 
                              <table width="100%" border="0" cellspacing="0" cellpadding="5">
                                <tr> 
                                      <td width="17%" height="28"> <font size="1" face="MS Sans Serif">Organisation 
                                        Level </font> </td>
                                      <td width="27%" height="28"> <font size="1" face="MS Sans Serif">Select 
                                        Organisation </font> </td>
                                </tr>
                                <tr> 
                                  <td width="17%" valign="top"> 
                                    <select name="sellevel" style="width:100" onChange="selectValues()" >
                                      <option selected>---Select---</option>
                                      <laps:reptag beanid="setupreport" methodname="getLevels" param="" /> 
                                    </select>
                                  </td>
                                  <td width="27%">
									<font size="1" face="MS Sans Serif"> 
										<select name="rpselect1" size="5" style="width:150" ></select>
                                    </font>
								  </td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                    <tr> 
                      <td> 
                        <table width="100%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
                          <tr> 
                            <td> 
                              <table width="100%" border="0" cellspacing="0" cellpadding="5">
                                <tr> 
                                  <td colspan="2">
									<font size="1" face="MS Sans Serif">Search by </font>
								  </td>
                                  <td width="2%">
									<font size="1" face="MS Sans Serif"></font>
								  </td>
                                  <td width="13%">
									<font size="1" face="MS Sans Serif"></font>
								  </td>
                                  <td width="4%">
									<font size="1" face="MS Sans Serif"></font>
								  </td>
                                  <td width="11%">
									<font size="1" face="MS Sans Serif"></font>
								  </td>
                                  <td width="5%">
									<font size="1" face="MS Sans Serif"></font>
								  </td>
                                  <td>
									<font size="1" face="MS Sans Serif"></font>
								  </td>
                                  <td>&nbsp;</td>
                                </tr>
                                <tr> 
                                  <td width="4%">
									<font size="1" face="MS Sans Serif"> 
										<input type="radio" name="searchby" value="app_no" >
                                    </font>
								  </td>
                                  <td width="15%">
									<font size="1" face="MS Sans Serif">Application Number </font>
								  </td>
                                  <td width="2%">
									<font size="1" face="MS Sans Serif"> 
										<input type="radio" name="searchby" value="comapp_companyname" >
                                    </font>
								  </td>
                                  <td width="13%" id="defaultname">
									<font size="1" face="MS Sans Serif">Company Name </font>
								  </td>
                                  <td width="4%"> 
									<font size="1" face="MS Sans Serif"> 
										<input type="radio" name="searchby" value="comapp_companyid">
                                    </font>
								  </td>
                                      <td width="11%" id="defaultid"> <font size="1" face="MS Sans Serif">Company 
                                        ID</font> </td>
                                  <td width="5%">&nbsp;</td>
                                  <td width="12%">
									<font size="1" face="MS Sans Serif"> 
										<input type="text" name="txtSearch" maxlength="50" size="15" >
                                    </font>
								  </td>
                                  <td> 
                                    <input type="button" name="cmbsearch" value="Search" style="background-color:#8F8369;color:white;font-size=10;font-family:mssansserif;width:65;font-weight:bold" onClick ="getValues()" >
                                  </td>

								  <td> 
                                    <input type="button" name="cmdreset" value="Reset" style="background-color:#8F8369;color:white;font-size=10;font-family:mssansserif;width:65;font-weight:bold" onClick ="resetme()">
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
		<tr>
		<td valign="top">
        <table width="100%" border="1" cellspacing="0" cellpadding="0" bordercolor="#FFFFFF" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
		<tr><td height="2">
          <table width="100%" border="0" cellspacing="0" cellpadding="3">
            <tr> 
              <td> </td>
            </tr>
            <tr> 
              <td> 
                <table width="100%" border="0" cellspacing="0" cellpadding="3" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
                  <tr> 
                    <td width="13%" height="20">
						<font size="1" face="MS Sans Serif"><b>Search Results</b></font>
					</td>
                    <td width="18%" height="20">&nbsp;</td>
                    <td width="12%" height="20">&nbsp;</td>
                    <td width="25%" height="20">&nbsp;</td>
                                <td width="15%" height="20">&nbsp;</td>
                                <td width="17%" height="20">&nbsp;</td>
                  </tr>
                  <tr bgcolor="#71694F"> 
                    <td width="13%" height="20" bgcolor="#71694F"> 
						<div align="left"><font  color="#FFFFFF"><b>Application No.
						</b></font>
						</div>
                    </td>
                    <td width="18%" height="20"> 
                        <div align="left"><font  color="#FFFFFF"><b>Company Name</b></font>
						</div>
                    </td>
                    <td width="12%" height="20"> 
						          <div align="left"><font  color="#FFFFFF"><b>Company 
                                    ID</b></font></div>
                    </td>
                    <td width="25%" height="20"> 
                        <div align="center"><font  color="#FFFFFF"><b>Product</b></font></div>
                    </td>
                                <td width="15%" height="20" align="center"> <font  color="#FFFFFF"><b>&nbsp;Date 
                                  Applied</b></font></td>
                                <td width="17%" height="20" align="center"> <font  color="#FFFFFF"><b>Status</b></font></td>
                  </tr>
                </table>
                <iframe  height="154" width="100%" id="ifrm2" frameborder=0 style="border:0"  src="<%=ApplicationParams.getAppUrl()%>/action/blank.jsp"> 
                </iframe> 
			</td>
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
  <br>
    
  <table border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" align="center">
    <tr>
        <td height="2"> 
          
        <table width="100%" border="0" cellspacing="0" cellpadding="2">
          <tr valign="middle"> 
            <td valign="top" width="51%"> 
              <div align="center"> 
                  <input type="button" name="cmdhelp" value="Help" style="background-color:#009966;cursor:help;;color:white;font-size=10;font-family:mssansserif;width:50;font-weight:bold" >
                </div>
              </td>
              
            <td valign="top" width="49%"> 
              <div align="center"> 
                  <input type="button" name="cmdclose" value="Close" style="background-color:#CC3300;color:white;font-size=10;font-family:mssansserif;width:50;font-weight:bold" onClick="JavaScript:closeWindow()">
                </div>
              </td>
            </tr>
          </table>
        </td>
      </tr>
    </table>
 

  </table>
</form>
</body>
</html>
