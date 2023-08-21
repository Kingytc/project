<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
String strType = Helper.correctNull(request.getParameter("hidval"));
String mode=Helper.correctNull(request.getParameter("mode"));
 String aa="",id="";
 String year="",qua="",appno="",button="";
 
 
 if (strType.equalsIgnoreCase("show_qis")||strType.equalsIgnoreCase("insert_main"))
 {
	 if(objValues instanceof java.util.HashMap)
	   {
		   hshValues=(java.util.HashMap)objValues;
	   }
	
		 ArrayList v = null;
		 int vecsize=0;
		 String qisarr ="";
		 v = (ArrayList)hshValues.get("vecVal");
		if(v!=null)
		{
			vecsize =v.size();

		}
		for (int o=0;o<vecsize;o++)
		{
			ArrayList g1=null;
			g1=(ArrayList)v.get(o);
			aa=(String)(g1.get(1))+"^"+aa;
		} 
	 id=request.getParameter("id");
		
 }
 if (strType.equalsIgnoreCase(""))
 {
	id=request.getParameter("id");

 }
 




%>

<html>
<head>
<title>Financial - Assets</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
input {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
-->
</style>
<STYLE>

DIV.cellContainer {	
  width: 100%; height: 255;
  overflow: auto;
}
select {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399}
</STYLE>
<style>
a:hover {  color: #FF3300}
</style>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/rating/rating.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/blackfont.css" type="text/css">
<script language="javascript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var button;

function call_page(url)
{
	if (url != "qismain.jsp")
	{
	if(document.forms[0].cmdedit.disabled != true)
	{
		mode="<%=mode%>";
		id="<%=id%>";
		if (url == "cassets.jsp")
		{
		document.forms[0].hidval.value="show_cas";
		}
		else 
		{
			document.forms[0].hidval.value="show_lia";
		}

		document.forms[0].hidBeanMethod.value="showupdateData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/"+url+"?id="+id+"&mode="+mode;
		document.forms[0].submit();
		
	}
	else
	{
		ShowAlert('103');
		return;
	}
	else
	{
		document.forms[0].action=appURL+"action/"+url;
		document.forms[0].submit();
	}
}
function enableButtons(bool1,bool2,bool3,bool4,bool5)
{	
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;	  	
	document.forms[0].cmdclose.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdcomments.disabled=bool5;
}

function saveContent()
{
	var flag = false;
		for(var i=0;i<document.forms[0].elements.length;i++)
		{
			if(document.forms[0].elements[i].type=="text")
			{
			 if( document.forms[0].elements[i].value == "" || document.forms[0].elements[i].value == ".")
				{
				 alert("Enter The Value For All The Fields");
				 flag=false;
				 return false;
				}
				else
				{
					flag=true;
				}
			}	
		}
	net_sales('a');
	net_sales('e');
	if (flag != false)
	{
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidBeanId.value="QisBean";
	document.forms[0].hidval.value="insert_main";
	document.forms[0].hidBeanMethod.value="insData";
	document.forms[0].hidSourceUrl.value="/action/qis.jsp";
	document.forms[0].submit();
	}

}

function net_sales(val)
{
	if (val =='a')
	{
		document.forms[0].net_ann.value=(parseFloat(trim(document.forms[0].qis[1].value)) + parseFloat(trim(document.forms[0].qis[2].value)));

	}
	else
	{
		document.forms[0].net_qua.value=(parseFloat(trim(document.forms[0].qis[4].value)) + parseFloat(trim(document.forms[0].qis[5].value)));
	}

}


function  changlbl(val)
{
		for(var i=0;i<document.forms[0].elements.length;i++)
		{
			if(document.forms[0].elements[i].type=="text")
			{
				if (val == "a")
				{
			  document.forms[0].elements[i].value="";	
				}
			  document.forms[0].elements[i].readOnly=false;
				    
			}
			else if(document.forms[0].elements[i].type=="select_quater")
			{
			  document.forms[0].elements[i].disabled=false;
		  
			}

		}
	document.forms[0].net_qua.readOnly=true;
	document.forms[0].net_ann.readOnly=true;
	enableButtons(true,true,false,false,true);
}

function loadvalues()
{
	strType="<%=strType%>";
	mode="<%=mode%>";
	id="<%=id%>"
	document.forms[0].id.value=id;
	if  (strType == "show_qis" || strType == "insert_main")
	{
		var	a="<%=aa%>";
		arr1=a.split("^");
		var i=0;
		var arrval = new Array();
		if (arr1.length >1)
		{
			for (k=arr1.length-2;k>-1;k--)
			{
			arrval[i]=arr1[k];
			i=i+1;
			}
			for (k=0;k<arrval.length;k++)
			{
				document.forms[0].qis[k].value=arrval[k];
			}
			net_sales('a');
			net_sales('e');
			enableButtons(true,false,true,true,false);
			button="e";
		
		}
		else
		{
			if(mode == "E")
			{
			alert("Information Not Available For The Application");
			}
			
		for(var i=0;i<document.forms[0].elements.length;i++)
		{
			if(document.forms[0].elements[i].type=="text")
			{
			  document.forms[0].elements[i].readOnly=true;
				 
			}
			
		}
		
			enableButtons(false,true,true,true,false);
			button="a";
			return
		}
			
	}
	if (strType == "")
	{
		enableButtons(false,true,true,true,false);
		button="a";
	}
	
	
		for(var i=0;i<document.forms[0].elements.length;i++)
		{
			if(document.forms[0].elements[i].type=="text")
			{
			  document.forms[0].elements[i].readOnly=true;
				 
			}
			
		}
		

}

function click_cancel()
{
	if (ConfirmMsg(102))
	{
	for(var i=0;i<document.forms[0].elements.length;i++)
		{
			if(document.forms[0].elements[i].type=="text")
			{
			  document.forms[0].elements[i].readOnly=true;
			}
			
		}
		if (button == "a")
		{
			enableButtons(false,true,true,true,false);
		}
		else
		{
			enableButtons(true,false,true,true,false);
		}
	}
	
}

function doClose()
{
	if (ConfirmMsg(100))
	{
		call_page('qismain.jsp');
	}
}

</script>




</head>
<body bgcolor="#EEEAE3"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadvalues()" >
<form name="finass" method="post" >
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" >
          <tr> 
            <td valign="top" colspan=5> 
              <jsp:include page="../share/menus.jsp" flush="true"/> 
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" >
          <tr> 
            <td valign="top" colspan=5><b><i>Quarterly Information System</i></b></td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <br>
  <table width="100%" border="1" cellspacing="0" cellpadding="5" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" onMouseOver=" ">
    <tr> 
      <td valign="top"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
          <tr> 
            <td> 
              <table width="100%" border="1" cellspacing="0" cellpadding="5" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF" height="100%">
                <tr> 
                  <td valign="top"> 
                    <table width="100%" border="0" cellspacing="2" cellpadding="0">
                      <tr> 
                        <td> 
                          <table width="100%" border="0" cellspacing="0" cellpadding="1" align="left">
                            <tr > 
                              <td colspan="2" > 
                                <table width="100%" border="0" cellspacing="0" cellpadding="2"  >
                                  <tr> 
                                    <td width="2%">&nbsp;</td>
                                    <td width="32%"><font color="#FFFFFF"><font size="1" face="MS Sans Serif" color="#000000"><b>Name 
                                      of the borrower :</b></font></font></td>
                                    <td colspan="3">&nbsp;</td>
                                  </tr>
                                  <tr> 
                                    <td width="2%"><font size="1" face="MS Sans Serif"><b>A.</b></font></td>
                                    <td width="32%"><font size="1" face="MS Sans Serif"> 
                                      Estimates for the current accounting year 
                                      indicated in the annual plan</font></td>
                                    <td width="20%"> 
                                     
                                    </td>
                                    <td width="17%"><font size="1" face="MS Sans Serif">a) 
                                      Production </font></td>
                                    <td width="29%"> 
                                      <input type="text" name="qis" size="15"  onkeypress="allowNumber(this)" maxlength="9" >
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td width="2%">&nbsp;</td>
                                    <td width="32%">&nbsp;</td>
                                    <td width="20%">&nbsp;</td>
                                    <td width="17%"><font size="1" face="MS Sans Serif">b) 
                                      Gross Sales</font></td>
                                    <td width="29%">&nbsp;</td>
                                  </tr>
                                  <tr> 
                                    <td width="2%">&nbsp;</td>
                                    <td width="32%">&nbsp;</td>
                                    <td width="20%">&nbsp;</td>
                                    <td width="17%"><font size="1" face="MS Sans Serif">i. 
                                      Domestic</font></td>
                                    <td width="29%"> 
                                      <input type="text" name="qis" size="15" onkeypress="allowNumber(this)"  maxlength="9">
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td width="2%">&nbsp;</td>
                                    <td width="32%">&nbsp;</td>
                                    <td width="20%">&nbsp;</td>
                                    <td width="17%"><font size="1" face="MS Sans Serif">ii. 
                                      Exports</font></td>
                                    <td width="29%"> 
                                      <input type="text" name="qis" size="15" onBlur="net_sales('a')" onkeypress="allowNumber(this)" maxlength="9">
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td width="2%">&nbsp;</td>
                                    <td width="32%">&nbsp;</td>
                                    <td width="20%">&nbsp;</td>
                                    <td width="17%"><font size="1" face="MS Sans Serif">c) 
                                      Net Sales</font></td>
                                    <td width="29%"> 
                                      <input type="text" name="net_ann" size="15" readonly>
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td width="2%"><font size="1" face="MS Sans Serif"><b>B.</b></font></td>
                                    <td width="32%"><font size="1" face="MS Sans Serif">Estimates 
                                      for the ensuing quarter ending</font></td>
                                    <td width="20%"> 
                                     
                                    </td>
                                    <td width="17%"><font size="1" face="MS Sans Serif">a) 
                                      Production </font></td>
                                    <td width="29%"> 
                                      <input type="text" name="qis" size="15" onkeypress="allowNumber(this)" maxlength="9">
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td width="2%">&nbsp;</td>
                                    <td width="32%">&nbsp;</td>
                                    <td width="20%">&nbsp;</td>
                                    <td width="17%"><font size="1" face="MS Sans Serif">b) 
                                      Gross Sales</font></td>
                                    <td width="29%">&nbsp;</td>
                                  </tr>
                                  <tr> 
                                    <td width="2%">&nbsp;</td>
                                    <td width="32%">&nbsp;</td>
                                    <td width="20%">&nbsp;</td>
                                    <td width="17%"><font size="1" face="MS Sans Serif">i. 
                                      Domestic</font></td>
                                    <td width="29%"> 
                                      <input type="text" name="qis" size="15" onkeypress="allowNumber(this)" maxlength="9">
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td width="2%">&nbsp;</td>
                                    <td width="32%">&nbsp;</td>
                                    <td width="20%">&nbsp;</td>
                                    <td width="17%"><font size="1" face="MS Sans Serif">ii. 
                                      Exports</font></td>
                                    <td width="29%"> 
                                      <input type="text" name="qis" size="15" onBlur="net_sales('b')" onkeypress="allowNumber(this)" maxlength="9">
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td width="2%">&nbsp;</td>
                                    <td width="32%">&nbsp;</td>
                                    <td width="20%">&nbsp;</td>
                                    <td width="17%"><font size="1" face="MS Sans Serif">c) 
                                      Net Sales</font></td>
                                    <td width="29%"> 
                                      <input type="text" name="net_qua" size="15" readonly>
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td width="2%"><font size="1" face="MS Sans Serif"><b>C.</b></font></td>
                                    <td width="32%"><font size="1" face="MS Sans Serif">Estimates 
                                      of current assets and current liabilities 
                                      for the ensuing quarter ending</font></td>
                                    <td width="20%"> 
                                    </td>
                                    <td width="17%">&nbsp;</td>
                                    <td width="29%">&nbsp;</td>
                                  </tr>
                                </table>
                              </td>
                            </tr>
                            <tr align="center"> 
                              <td width="50%"> 
                                <input type="button" name="cmdAssets" value="Current Assets" style="background-color:#8F8369;font-weight:bold;font-weight:bold;color:white;font-size=10;font-family:mssansserif" onClick="call_page('cassets.jsp')">
                              </td>
                              <td width="50%"> 
                                <input type="button" name="cmdLiabilities" value="Current Liabilities" style="background-color:#8F8369;font-weight:bold;font-weight:bold;color:white;font-size=10;font-family:mssansserif" onclick="call_page('cliabilities.jsp')">
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
  <table border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" align="center">
    <tr bordercolordark="#FFFFFB" bordercolorlight="#8F8369"> 
      <td> 
       <table width="100%" border="0" cellspacing="0" cellpadding="2">
          <tr valign="top">
            <td width="0">
              <input type="button" name="cmdadd" value="Add" style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" onClick="changlbl('a')">
            </td>
            <td width="0"> 
              <div align="center"> 
                <input type="button" name="cmdedit" value="Edit" style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" onClick="changlbl('e')">
              </div>
            </td>
            <td width="0"> 
              <div align="center"> 
                <input type="button" name="cmdapply" value="Save" style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" onClick="saveContent()" >
              </div>
            </td>
            <td width="0"> 
              <div align="center"> 
                <input type="button" name="cmdcancel" value="Cancel"  style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" onClick="click_cancel()">
              </div>
            </td>
            <td width="0"> 
              <div align="center"> 
                <input type="button" name="cmdhelp" value="Help"  style="background-color:#009966;cursor:help;;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50">
              </div>
            </td>
            <td width="0"> 
              <div align="center"> 
                <input type="button" name="cmdclose" value="Close"  style="background-color:#CC3300;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"  onClick="javascript:doClose()">
              </div>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
			<input type=hidden name="hidBeanId" value="QisBean" >
			<input type=hidden name="hidBeanMethod"  >
			<input type=hidden name="hidBeanGetMethod" >
			<input type=hidden name="hidSourceUrl">
			<input type=hidden name="hidappno" value="ABCI0000010">
			<input type=hidden name="hidval">
			<input type=hidden name="id">
</form>
</body>
</html>
