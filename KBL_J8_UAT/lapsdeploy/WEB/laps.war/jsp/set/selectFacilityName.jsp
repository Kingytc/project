<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<laps:handleerror />
 
<%
   String strPage = "";
   String beanid = "";
   String meth = "";
   String strTagValue ="";
   HashMap h = new HashMap();
   HashMap hp1 = new HashMap();
   String strListName="";
   String strV="";
   String strMsg="";
%>
<%
   strPage = (String)request.getParameter("page");
   beanid = "facilitymaster";
   meth = "getFacilityNames";
   
   strV = (String)request.getParameter("cat");
   String strV1 = (String)request.getParameter("select");
   h.put("value",strV);
   h.put("parent",strV1);
   
   hp1.put("BeanId",beanid);
   hp1.put("MethodName",meth);
   hp1.put("BeanParam",h);
   
  
%>

<html>
<head>
<title>LAPS</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/headmenu.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/keytrap.js"></script>
<script>
var msgname="<%=strMsg%>";
function display(temp1)
{
if(temp1 !="")
{
	window.opener.document.forms[0].elements["txt_facilityname"].value=trim(temp1);
	this.close();
}	
}
</script>
</head>
<body bgcolor="#EEEAE3" text="#000000" >
<div id="ie5menu" class="skin0" onMouseover="highlightie5()" onMouseout="lowlightie5()" onClick="jumptoie5()"> 
  <div class="menuitems" url="">
   <script language="JavaScript1.2">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script>
</div>
  </div>
<form name="purge" action="">
  <table width="300" border="0" cellspacing="0" cellpadding="0" align="center" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" >
    <tr> 
      <td valign="top"> 
        <table width="300" border="0" cellspacing="0" cellpadding="5" align="center">
          <tr> 
            <td align="left" bgcolor="#71694F" id="dis" ><font size="2" face="MS Sans Serif" color="#FFFFFF"><b> 
              <center>
                SELECT THE FACILITY NAMES
              </center>
              </b></font></td>
          </tr>
          <tr id ="unprod" style="visibility:hidden" bgcolor="#71694F"><b>
            <center>
              <font size="2" face="MS Sans Serif" color="#FFFFFF">Select Facility Name</font>
            </center>
            </b> 
			</tr><tr >
            <td align="center" > 
              <select name="selProd" size=15 style="width:400"  onDblClick="display(this.value)">
                <laps:selecttag value='<%=hp1%>' /> 
              </select>
            </td>
          </tr>
          <tr> 
            <td height="17">&nbsp;</td>
          </tr>
          <tr> 
            <td> 
              <table border="0" cellspacing="0" cellpadding="3" align="center">
                <tr> 
                  <td align="center"> 
                    <input type="button" name="cmdok" value="OK" style="background-color:#8F8369;color:white;font-size=10;font-family:mssansserif;width:50;font-weight:bold" onClick="selectProducts('<%=strTagValue%>','<%=strPage%>')"
							>
                  </td>
                  <td align="center"> 
                    <input type="reset" name="cmdCancel" value="Close" style="background-color:#CC3300;color:white;font-size=10;font-family:mssansserif;width:50;font-weight:bold" onClick="window.close()">
                  </td>
                </tr>
              </table>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</form>
</body>
</html>


