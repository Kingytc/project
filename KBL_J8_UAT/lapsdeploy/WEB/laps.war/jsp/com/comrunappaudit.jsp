<%@ include file="../share/directives.jsp"%>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />


<%
   if(objValues instanceof java.util.HashMap)
   {
	  hshValues=(java.util.HashMap)objValues;
   }
	//out.println("hshValues----"+hshValues);
  ArrayList vecOrg = new ArrayList();
  vecOrg=(ArrayList)hshValues.get("vecData");
  String align="left";
 // out.println("vecOrg----"+vecOrg);
  //out.println("size"+vecOrg.size());
  	
%>

<html>
<head>
<title>LAPS</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>

<body >
<br>
<h3><center>Application Audit Trail</center></h3>
<form name= "orgfrm" method="post" class="normal">


  
    <table width="95%" border="0" cellspacing="0" cellpadding="0"  align="center" class="outertable">
      <tr> 
        <td height="3"> 
          
        <table width="100%" border="0" cellspacing="2" cellpadding="2" align="left" valign="top" class="outertable linebor">
          <tr align="left" class="dataheader"> 
            <td no wrap>Page Name</td>
            <td valign="top">User 
              Name </td>
            <td valign="top">User ID</td>
			<td valign="top">IP 
              Address</td>
            <td valign="top">Application 
              No</td>
            <td valign="top">Action 
              Date</td>
            <td valign="top">Data</td>
            <td valign="top">Action 
              Type</td>
          </tr>
          <%
          String fontcolor="";
ArrayList g1=null;
	if(vecOrg!=null)
	{
		int colSize=0;
		if (vecOrg.size()> 0)
		{
			
			for(int k=0;k<vecOrg.size();k++)
			{
				g1=(ArrayList)vecOrg.get(k);
				//out.println(g1);
				 colSize=g1.size();
				if( colSize>0)
				{
					if((k%2)==0)
						fontcolor="fontcolor";
					else
						fontcolor="fontcolor1";
	%>
		
          <tr align="left" class="datagrid"> 
            <td no wrap>&nbsp;<%=(String)g1.get(0)%></td>
            <td valign="top">&nbsp;<%=(String)g1.get(7)%> &nbsp; <%=(String)g1.get(8)%></td>
            <td valign="top">&nbsp;<%=(String)g1.get(1)%></td>
            <td valign="top">&nbsp;<%=(String)g1.get(2)%></td>
            <td valign="top"> &nbsp;<%=(String)g1.get(3)%></td>
            <%if((Helper.correctNull((String)g1.get(6))).equalsIgnoreCase("INSERT")){%>
           		<td valign="top" nowrap>&nbsp;<b>Created:<%=(String)g1.get(4)%></b></td>
           	<%}else if((Helper.correctNull((String)g1.get(6))).equalsIgnoreCase("UPDATE")){ %>
           		<td valign="top" nowrap>&nbsp;<b>Modified:<%=(String)g1.get(4)%></b></td>
           	<%}else{%>
           		<td valign="top" nowrap>&nbsp;<b><%=(String)g1.get(4)%></b></td>
           	<%}%>
            <td valign="top">&nbsp;<%=(String)g1.get(5)%></td>
            <td valign="top">&nbsp;<%=(String)g1.get(6)%></td>
            
          </tr>
          
          <%	
				}
			}
		}
	}		
	%>
        </table>
        </td>
      </tr>
    </table>

<br>
  <!-- <table border="1" cellspacing="0" cellpadding="0"  bordercolorlight="#8F8369" bordercolordark="#FFFFFB" align="center">
    <tr> 
      <td height="17"> 
       <table width="100%" border="0" cellspacing="0" cellpadding="2">
          <tr> 
            <td width="45%"> 
              <div align="center"> 
                <input type="button" name="Button232253" value="&lt;&lt; Previous" style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:80;font-weight:bold" onClick="window.close()">
              </div>
            </td>
            <td width="55%"> 
              <div align="center"> 
                <input type="button" name="Button2322532" value="Print Preview" style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:100;font-weight:bold" onclick="printpreview()">
              </div>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>-->
</form>
</body>
</html>
