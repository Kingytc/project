<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%@ page import="com.sai.laps.helper.*,java.util.*" %>

<%
ArrayList v= new ArrayList();
String strFromLink =Helper.correctNull((String)request.getParameter("strfrom1"));
%>
<html>
<head>
<title>Application Details</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="JavaScript" type="text/javascript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var path      ="<%=ApplicationParams.getAppUrl()%>";
var from_link = "<%=strFromLink%>";

function showLink(val1, val2)
{

    if (from_link == "Branch1")
	{ 
		window.opener.document.forms[0].txtperapp_appcode.value = val1;
		window.opener.document.forms[0].txtperapp_app.value =val2;
		window.close();
	}
}

</SCRIPT>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
<style> 
Div.cellContainer
{
	width:100%;
	Height:300px;
    overflow: auto;
}
</style>
<body bgcolor="#FBF5E9" text="#000000">
<FORM name="" method="post">
<table border="0" width="98.3%" cellspacing="0" cellpadding="3" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" width="95%" align="center">
 <tr> 
   <td> 
     <table border="0" cellspacing="1" cellpadding="3" width="98.3%">
       <tr class="dataHeadColor"> 
       <td width="3%">&nbsp;</td>  
         <td width="33%"><b><font color="">Branch Name</font></b></td>
       </tr>
     </table>
   </td>
 </tr>
 <tr> 
   <td> 
     <div class="cellcontainer"> 
       <table width="100%" border="0" cellspacing="1" cellpadding="3" class="innertablecolor" align="center">
        <%
        ArrayList vecRow = (ArrayList)hshValues.get("vecData");

		if(vecRow!=null && vecRow.size()>0)
		 {
			v = (ArrayList) hshValues.get("vecData");
			for(int i=0;i<vecRow.size();i++)
			{
				v = (ArrayList)vecRow.get(i);
				if(v.size() >0)
				{ 	
				   %>
	                 <tr bgcolor="#EEEAE3"> 
	                 <td width="3%"><%=i+1%></td>
                     <td width="30%"><a href="javascript:showLink('<%=Helper.correctNull((String)v.get(0))%>','<%=Helper.correctNull((String)v.get(1))%>')"><b><%=Helper.correctNull((String)v.get(1))%></b></a></td>
               	<%
				}
			}
		}
         %>                   
          <tr bgcolor="#EEEAE3"> 
           <td width="3%">&nbsp;</td> 
           <td width="32%">&nbsp;</td>
          </tr>                         
          <tr bgcolor="#EEEAE3"> 
           <td>&nbsp;</td> 
           <td>&nbsp;</td>
          </tr> 
          <tr bgcolor="#EEEAE3"> 
           <td>&nbsp;</td> 
           <td>&nbsp;</td>
          </tr>  
          <tr> 
           <td>&nbsp;</td> 
           <td>&nbsp;</td>
          </tr> 
          <tr> 
           <td>&nbsp;</td> 
           <td>&nbsp;</td>
          </tr> 
         <tr> 
           <td>&nbsp;</td> 
           <td>&nbsp;</td>
          </tr>                       
          <tr> 
           <td>&nbsp;</td> 
           <td>&nbsp;</td>
          </tr>                       
         <tr> 
           <td>&nbsp;</td> 
           <td>&nbsp;</td>
          </tr> 
          <tr> 
           <td>&nbsp;</td> 
           <td>&nbsp;</td>
          </tr> 
          <tr> 
           <td>&nbsp;</td> 
           <td>&nbsp;</td>
          </tr> 
          <tr> 
           <td>&nbsp;</td> 
           <td>&nbsp;</td>
          </tr> 
          <tr> 
           <td>&nbsp;</td> 
           <td>&nbsp;</td>
          </tr> 
          <tr> 
           <td>&nbsp;</td> 
           <td>&nbsp;</td>
          </tr> 
          <tr> 
           <td>&nbsp;</td> 
           <td>&nbsp;</td>
          </tr> 
          <tr> 
           <td>&nbsp;</td> 
           <td>&nbsp;</td>
          </tr> 
          <tr> 
           <td>&nbsp;</td> 
           <td>&nbsp;</td>
          </tr> 
        </table>
      </div>
    </td>
  </tr>                    
</table>
<br>
<table width="" border="1" cellspacing="0" cellpadding="3" align="center"bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
  <tr> 
	<td> 
      <input type=button style="background-color:#CC3300;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" value="Close" name="closebtn" tabindex="25"  onClick=window.close()>
    </td>
  </tr>
</table>
</FORM>
</body>
</html> 