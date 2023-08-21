<%@ page import="com.sai.laps.helper.*" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>

<laps:handleerror />
<%
	//java.util.ArrayList arrWorkid=(java.util.ArrayList)hshValues.get("prd_sno");
   //java.util.ArrayList arrTermFrom=(java.util.ArrayList)hshValues.get("prd_termfrom");
	//java.util.ArrayList arrTermTo=(java.util.ArrayList)hshValues.get("prd_termto");
   //java.util.ArrayList arrIntRate=(java.util.ArrayList)hshValues.get("prd_interest");
 /*  String strType = Helper.correctNull(request.getParameter("hidval"));
    String strWrkflowtype=Helper.correctNull(request.getParameter("wrk_flowtype"));
	 String section="" ;
  ArrayList v = null;
  if(objValues instanceof java.util.HashMap)
   {
	   hshValues=(java.util.HashMap)objValues;
   }
   
  if(strType.equalsIgnoreCase("show_cat")|| strType.equalsIgnoreCase("update_cat"))
{
	
		 v = (ArrayList)hshValues.get("vecVal");
	
}
int vecsize=0;
if(v!=null)
{
	vecsize =v.size();

}*/
   %>
<html>
<head>
<title>Setup(Products)</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script  src="<%//=ApplicationParams.getAppUrl()%>js/share/validation.js" >
</script>
<script  src="<%//=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js" >
</script>





<script>
<!--
 var val = "<%//=request.getParameter("val")%>";
var appUrl="<%=ApplicationParams.getAppUrl()%>";
 
var workid=new Array();
 var termfrom=new Array();
 var termto= new Array();
 var termint=new Array();

 
 
function callFlowtype(type)
{
	
	document.forms[0].wrk_flowtype.value=type;
	document.forms[0].action=appUrl+"action/setprdintterms.jsp";
	document.forms[0].submit();

}
function loadValues()
{
	document.forms[0].wrk_flowtype.value="fixed";
	
}

function changlbl(par)
{
	if(par =="a")
	{
	document.all.labelchange.innerText="Create Rule";
	document.all.labelhelp.style.visibility="hidden";
	//document.rating.ratetype.value="";
	//document.forms[0].ratetype.disabled = false;	
	
	}
	else if(par=="e")
	{
	//	if (document.forms[0].ratetype.value == "")
	//	{
	//		alert("select rating");
	//		return false;
	//	}
	document.all.labelchange.innerText="Select Rule Id";
	document.all.labelhelp.style.visibility="visible";
	//document.rating.ratetype.disabled=false;
	}
	//enableButtons(true,true,false,false,true);
}

function doSave()
{
		document.forms[0].apply.disabled = true;
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidBeanId.value="setproducts";
		document.forms[0].hidval.value="insert_terms";
		document.forms[0].hidBeanMethod.value="interestTerm";
		document.forms[0].hidSourceUrl.value="/action/setprdintterms.jsp";
		document.forms[0].submit();
}
//-->
</script>
<style>
select {  font-family: "MS Sans Serif"; font-size: 9px; color: #003399 ;border-style: groove}
textarea {  font-family: "MS Sans Serif"; font-size: 9px; color: #003399; border-style: groove}
input {  font-family: "MS Sans Serif"; font-size: 9px; color: #003399;border-style: groove}
a:hover {  color: #FF3300}
</style>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
<script language="JavaScript1.2" src="<%//=ApplicationParams.getAppUrl()%>js/share/headmenu.js"></script>
<script language="JavaScript1.2" src="<%//=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="JavaScript1.2" src="<%//=ApplicationParams.getAppUrl()%>js/share/keytrap.js"></script>
</head>
<body bgcolor="#EEEAE3" text="#000000"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadValues()">
<!--<div id="ie5menu" class="skin0" onMouseover="highlightie5()" onMouseout="lowlightie5()" onClick="jumptoie5();">
<div class="menuitems" url=""></div>
</div>
<script language="JavaScript1.2">
if (document.all && window.print)
{
ie5menu.className = menuskin;
document.oncontextmenu = showmenuie5;
document.body.onclick = hidemenuie5;
}
</script>-->
<form name="documentsfrm" method="post" >
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td>
	  <table width="100%" border="0" cellspacing="0" cellpadding="0" >
	  <tr> 
      <td valign="top" colSpan=5>
	  		<jsp:include page="../share/help.jsp" flush="true"/> 
		</td>
	    </tr>
 		</table>		
      </td>
    </tr>
 </table>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr> 
      <td><font face="Times New Roman" size="3"><b><i>Home <font face="Times New Roman" size="3"><b><font face="Times New Roman" size="3"><b><i><font face="Times New Roman" size="3"><b><font face="Times New Roman" size="3"><b><font face="MS Sans Serif">-&gt;</font></b></font></b></font></i><font face="MS Sans Serif"> 
        </font> <i> Setup</i></b></font></b></font> -&gt; Products -&gt; Search 
        Products -&gt; Terms and Interest</i></b></font></td>
    </tr>
    <tr> 
      <td align="right">&nbsp; </td>
    </tr>
  </table>
  <table width="100%" border="0" cellspacing="0" cellpadding="3" align="center">
    <tr> 
      <td> 
        <table width="95%" border="0" cellspacing="2" cellpadding="3" align="left">
          <tr> 
            <td height="2" width="11%" bgcolor="#EEEAE3" align="center"><font color="#FFFFFF" size="1" face="MS Sans Serif"><b><a href="javascript:callOtherTab('setproducts.jsp')" class="blackfont">Products</a></b></font></td>
            <td height="2" width="9%" align="center" bgcolor="#EEEAE3"><font size="1" face="MS Sans Serif"><b><font color="#FFFFFF"><a href="javascript:callOtherTab('produsedby.jsp')" class="blackfont">Used 
              By</a></font></b></font></td>
            <td height="2" width="10%" bgcolor="#EEEAE3" align="center"><font size="1" face="MS Sans Serif"><b><a href="javascript:callOtherTab('setprdauth.jsp')" class="blackfont">Authority</a></b></font></td>
            <td height="2" width="10%" bgcolor="#EEEAE3" align="center"><font size="1" face="MS Sans Serif"><b><a href="javascript:callOtherTab('setprddoc.jsp')" class="blackfont">Documents</a></b></font></td>
            <td height="2" width="11%" bgcolor="#EEEAE3" align="center"><font size="1" face="MS Sans Serif"><b><a href="javascript:callOtherTab('setprdworkflow.jsp')" class="blackfont">Flowpoints</a></b></font></td>
            <td height="2" width="15%" bgcolor="#EEEAE3" align="center"><font size="1" face="MS Sans Serif"><b><a href="javascript:callOtherTab('prodinterest.jsp')" class="blackfont">Other 
              Charges </a></b></font></td>
            <td height="2" width="11%" bgcolor="#EEEAE3" align="center"><font size="1" face="MS Sans Serif"><b><a href="javascript:callOtherTab('prodsanclimit.jsp')" class="blackfont">Passing Powers Amount wise</a></b></font></td>
            <td height="2" width="13%" bgcolor="#71694F" align="center"><font size="1" face="MS Sans Serif"><b><font color="#FFFFFF">Int. 
              Terms </font></b></font></td>
         
            <td height="2" width="10%" bgcolor="#EEEAE3" align="center"><font size="1" face="MS Sans Serif"><b><a href="javascript:callOtherTab('proddisbursement.jsp')" class="blackfont">Disbursement 
              </a></b></font></td>		  
		  </tr>
        </table>
      </td>
    </tr>
  </table>
  <table width="100%" border="0" cellspacing="0" cellpadding="3" height="400"  bordercolorlight="#8F8369" bordercolordark="#FFFFFB" align="center">
    <tr> 
      <td valign="top" height="133"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%" align="center" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF">
          <tr> 
            <td valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="3" height="0%">
                <tr> 
                  <td colspan="4">
                    <table width="100%" border="0" cellspacing="0" cellpadding="3"  >
                      <tr> 
                                          <td colspan="6"><fieldset> 
                                            <table width="100%" border="0" cellspacing="0" cellpadding="3"  >
                                              <tr> 
                                                <td><laps:products /></td>
                                              </tr>
                                            </table>
                                            </fieldset> </td>
                                        </tr>
                    </table>
                  </td>
                </tr>
                <tr>
                  <td colspan="4">
                    <table width="37%" border="0" cellspacing="3" cellpadding="3">
                      <tr bgcolor="#EEEAE3"> 
                        <td width="27%" align="center" <%//if(strWrkflowtype.equals("fixed") || strWrkflowtype.equals("") ){%>
                                                  bgcolor="#71694F"<%//}%> ><font size="1" face="MS Sans Serif" <%//if(strWrkflowtype.equals("fixed")|| strWrkflowtype.equals("") ){%>
                                                  color="#Ffffff"<%//}%> ><b> <a href="javascript:callFlowtype('fixed')" class="blackfont"> 
                          Fixed Rate</a></b></font></td>
                        <td width="35%" align="center" <%//if(strWrkflowtype.equals("floating")){%>
                                                  bgcolor="#71694F"<%//}%>><font size="1" face="MS Sans Serif" <%//if(strWrkflowtype.equals("floating")){%>
                                                  color="#Ffffff"<%//}%>><b> <a href="javascript:callFlowtype('floating')" class="blackfont"> 
                          Floating Rate</a></b></font></td>
                        <td width="38%" align="center" <%//if(strWrkflowtype.equals("stepup")){%>
                                                  bgcolor="#71694F"<%//}%>><font size="1" face="MS Sans Serif" <%//.if(strWrkflowtype.equals("stepup")){%>
                                                  color="#Ffffff"<%//}%>><b> <a href="javascript:callFlowtype('stepup')" class="blackfont"> 
                          Step Up Rate</a></b></font></td>
                      </tr>
                    </table>
                    <table width="100%" border="0">
                      <tr> 
                        <td width="10%"><font size="1" face="MS Sans Serif"><span  id="labelchange">Select rule Id 
                          </span></font></td>
                        <td width="14%" id="labelhelp">
                          <select name="select">
                          </select>
                        </td>
                      </tr>
                    </table>
                    <table width="100%" border="0">
                      <tr>
                        <td width="14%"><font face="MS Sans Serif" size="1">Amount 
                          Range From</font></td>
                        <td width="20%"> 
                          <input type="text" name="amtfrom" maxlength="18" onKeyPress="allowInteger()" size="18">
                        </td>
                        <td width="17%"><font face="MS Sans Serif" size="1">Amount 
                          Range To</font></td>
                        <td width="25%"> 
                          <input type="text" name="amtto" maxlength="18" onKeyPress="allowInteger()" size="18">
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
              </table>
              <table width="100%" border="0">
                <tr bgcolor="#8F8369"> 
                  <td width="7%" height="19"> 
                    <div align="center"><b><font color="#FFFFFF"><font size="1" face="MS Sans Serif">S.No</font></font></b></div>
                  </td>
                  <td width="21%" height="19"> 
                    <div align="center"><b><font color="#FFFFFF"><font size="1" face="MS Sans Serif">Terms 
                      From</font></font></b></div>
                  </td>
                  <td width="24%" height="19"> 
                    <div align="center"><b><font color="#FFFFFF"><font size="1" face="MS Sans Serif">Terms 
                      To</font></font></b></div>
                  </td>
				  <%
					//if(strWrkflowtype.equals("floating")){
				  %>
                  <td width="17%" height="19"> 
                    <div align="center"><b><font color="#FFFFFF"><font size="1" face="MS Sans Serif">Reference 
                      Rate </font></font></b></div>
                  </td>
                  <td width="13%" height="19"> 
                    <div align="center"><font color="#FFFFFF"><b><font color="#FFFFFF"><font size="1" face="MS Sans Serif">Adjusted 
                      Rate </font></font></b></font></div>
                  </td>
						<%
				//	}
						%>
                  <td width="18%" height="19"> 
                    <div align="center"><b><font color="#FFFFFF"><font size="1" face="MS Sans Serif">Interest 
                      Rate (%)</font></font></b></div>
                  </td>
                </tr>
              </table>
              <table width="758" border="0" height="">
               <%/* ArrayList g1=null;
					 for (int l=0;l<5;l++)
					 {
					    int colSize=0;
						 if(l<vecsize)
						 {
							 g1 = (ArrayList)v.get(l);
							if(g1!=null)
							{
							   colSize = g1.size();
       						}
						 }

						  if(colSize>0)		
						  {
						*/	
					  %>
                <tr> 
                  <td width="7%"> 
                    <div align="center"><font size="1" face="MS Sans Serif"><%//=l+1%></font></div>
                  </td>
                  <td width="21%"> 
                    <div align="center"> 
                      <input type="text" name="from" maxlength="8" onKeyPress="allowInteger()" size="12">
                    </div>
                  </td>
                  <td width="24%"> 
                    <div align="center"> 
                      <input type="text" name="to" maxlength="8" onKeyPress="allowInteger()" size="12">
                    </div>
                  </td>
						   <%
					//if(strWrkflowtype.equals("floating")){
				  %>
                  <td width="17%"> 
                    <div align="center">
                      <input type="text" name="baserate" maxlength="8" onKeyPress="allowInteger()" size="12">
                    </div>
                  </td>
                  <td width="13%"> 
                    <div align="center">
                      <input type="text" name="adjust" maxlength="8" onKeyPress="allowInteger()" size="12">
                    </div>
                  </td>
						  <%
				//	}
						%>
                  <td width="18%"> 
                    <div align="center"> 
                      <input type="text" name="total" maxlength="8" onKeyPress="allowNumber(this)" size="12" onblur="checkPercentage(this),roundtxt(this)">
                    </div>
                  </td>
                  
                </tr>
                <%
				/*		  }
					else
						  {
						*/
						%>
							<tr> 
                  <td width="7%"> 
                    <div align="center"><font size="1" face="MS Sans Serif"><%//=l+1%></font></div>
                  </td>
                  <td width="21%"> 
                    <div align="center"> 
                      <input type="text" name="from" maxlength="8" onKeyPress="allowInteger()" size="12">
                    </div>
                  </td>
                  <td width="24%"> 
                    <div align="center"> 
                      <input type="text" name="to" maxlength="8" onKeyPress="allowInteger()" size="12">
                    </div>
                  </td>
						   <%
				//	if(strWrkflowtype.equals("floating")){
				  %>
                  <td width="17%"> 
                    <div align="center">
                      <input type="text" name="baserate" maxlength="8" onKeyPress="allowInteger()" size="12">
                    </div>
                  </td>
                  <td width="13%"> 
                    <div align="center">
                      <input type="text" name="adjust" maxlength="8" onKeyPress="allowInteger()" size="12">
                    </div>
                  </td>
						  <%
				//	}
						%>
                  <td width="18%"> 
                    <div align="center"> 
                      <input type="text" name="total" maxlength="8" onKeyPress="allowNumber(this)" size="12" onblur="checkPercentage(this),roundtxt(this)">
                    </div>
                  </td>
                  
                </tr>
						  <%					//	  }
				//	 }
					%>
              </table>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <br>
  <table border="0" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" align="center">
    <tr> 
      <td height="21"> 
        <table width="64%" border="0" cellspacing="0" cellpadding="2" align="center">
          <tr valign="top"> 
			<td width="10%"> 
              <div align="center"> 
                <input type="button" name="New" value="New" class="buttonStyle" onClick="changlbl('a')">
              </div>
            </td>
            <td width="10%"> 
              <div align="center"> 
                <input type="button" name="edit" value="Edit" class="buttonStyle" onClick="changlbl('e')">
              </div>
            </td>
            <td width="10%"> 
              <div align="center"> 
                <input type="button" name="apply" value="Save" class="buttonStyle" onClick="doSave()">
              </div>
            </td>
            <td width="10%"> 
              <div align="center"> 
                <input type="button" name="cancel" value="Cancel" class="buttonStyle" onClick="doCancel()">
              </div>
            </td>
            <td width="10%"> 
              <div align="center"> 
                <input type="button" name="help" value="Help" class="buttonHelp" onClick="doHelp('products.htm#authority')">
              </div>
            </td>
            <td width="10%"> 
              <div align="center"> 
                <input type="button" name="close" value="Close" class="buttonClose" onClick="doClose()">
              </div>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <input type="hidden" name="hidBeanId" value="setproducts" >
<input type=hidden name="hidBeanMethod" value="" >
<input type=hidden name="hidBeanGetMethod" value="" >
<input type="hidden" name="hidSourceUrl" value="/action/setprdintterms.jsp" >
<input type="hidden" name="hidAction">
<input type="hidden" name="prd_code" >
<input type="hidden" name="checkApp" value="<%//=request.getParameter("checkApp")%>">
<input type="hidden" name="wrk_flowtype" >
<input type="hidden" name="hidval" >
</form>
</body>
</html>
  