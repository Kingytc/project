<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />

<html>
<head>
<title>Contact Details List</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">


<script language="JavaScript" type="text/javascript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var path      ="<%=ApplicationParams.getAppUrl()%>";

function showValues(val1,val2,val3,val4,val5,val6)
{

if(val1=='1')
{
	parent.frames.document.forms[0].sel_scrmod.value ='1';
}
else if(val1=='2')
{
	parent.frames.document.forms[0].sel_scrmod.value ='2';
}
else
{
	parent.frames.document.forms[0].sel_scrmod.value ='3';
}
parent.frames.document.forms[0].txtscr_name.value =val2;
parent.frames.document.forms[0].txtmsg_jspname.value =val3 ;
parent.frames.document.forms[0].txtseq_number.value = val4;
parent.frames.document.forms[0].txtmsg_scrimage.value = val5;
parent.frames.document.forms[0].scrId.value = val6;

parent.frames.document.forms[0].cmdadd.disabled = true;
parent.frames.document.forms[0].cmdedit.disabled = false;
parent.frames.document.forms[0].cmdsave.disabled = true;
parent.frames.document.forms[0].cmdcancel.disabled = false;
parent.frames.document.forms[0].cmddel.disabled = false;
parent.frames.document.forms[0].cmdhelp.disabled = false;

}
</SCRIPT>

<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<link rel="stylesheet" href="blackfont.css" type="text/css">
<body bgcolor="#FBF5E9" text="#000000">
<FORM name="" method="post">
<%

	ArrayList vecRow = (ArrayList)hshValues.get("vecValues");
	ArrayList vecCol = null; 
	int len = vecRow.size();
	


%>
  <table  width="100%" border="0" cellpadding="3" align="center"  bordercolorlight="#8F8369" bordercolordark="#FFFFFB" cellspacing="1">
    <%
    	for(int i=0;i<len;i++)
    	{
    		vecCol = (ArrayList)vecRow.get(i);
    		String mod = (String)vecCol.get(0);
    		%>
    		 <tr> 
    <td width="5%" class="datagrid"> 
        <input type="radio" name="radiobutton" value="radiobutton" onclick="javascript:showValues('<%=Helper.correctNull((String)vecCol.get(0))%>','<%=Helper.correctNull((String)vecCol.get(1))%>','<%=Helper.correctNull((String)vecCol.get(2))%>','<%=Helper.correctNull((String)vecCol.get(3))%>','<%=Helper.correctNull((String)vecCol.get(4))%>','<%=Helper.correctNull((String)vecCol.get(5))%>')">
      </td>
    		<%
    		if(mod.equals("1"))
    		{
    		%>
    		 <td width="30%" class="datagrid">Retail</td>
    		<%
    		}
    		else if(mod.equals("2"))
    		{
    		%>
    		<td width="30%" class="datagrid">Corprate</td>
   	<%
    		}
    		else if(mod.equals("3"))
    		{
    		%>
    		<td width="30%" class="datagrid">Tertiary</td>
   	<%
    		}
   	%>
     
     <%-- <td width="30%" class="datagrid"><%=vecCol%></td>--%>
      <td width="35%" class="datagrid"><%=vecCol.get(1)%></td>
       <td width="30%" class="datagrid"><%=vecCol.get(3)%></td>
          
    </tr>
    <%
    	}
    %>
      <tr> 
      <td class="datagrid">&nbsp;</td>
      <td class="datagrid">&nbsp;</td>
      <td class="datagrid">&nbsp;</td>
      <td class="datagrid">&nbsp;</td>
      <td class="datagrid">&nbsp;</td>
      <td class="datagrid">&nbsp;</td>
      <td class="datagrid">&nbsp;</td>
      <td class="datagrid">&nbsp;</td>
    </tr>
    <tr> 
      <td class="datagrid">&nbsp;</td>
      <td class="datagrid">&nbsp;</td>
      <td class="datagrid">&nbsp;</td>
      <td class="datagrid">&nbsp;</td>
      <td class="datagrid">&nbsp;</td>
      <td class="datagrid">&nbsp;</td>
      <td class="datagrid">&nbsp;</td>
      <td class="datagrid">&nbsp;</td>
    </tr>
    <tr> 
      <td class="datagrid">&nbsp;</td>
      <td class="datagrid">&nbsp;</td>
      <td class="datagrid">&nbsp;</td>
      <td class="datagrid">&nbsp;</td>
      <td class="datagrid">&nbsp;</td>
      <td class="datagrid">&nbsp;</td>
      <td class="datagrid">&nbsp;</td>
      <td class="datagrid">&nbsp;</td>
    </tr>
    <tr> 
      <td class="datagrid">&nbsp;</td>
      <td class="datagrid">&nbsp;</td>
      <td class="datagrid">&nbsp;</td>
      <td class="datagrid">&nbsp;</td>
      <td class="datagrid">&nbsp;</td>
      <td class="datagrid">&nbsp;</td>
      <td class="datagrid">&nbsp;</td>
      <td class="datagrid">&nbsp;</td>
    </tr>
    <tr> 
      <td class="datagrid">&nbsp;</td>
      <td class="datagrid">&nbsp;</td>
      <td class="datagrid">&nbsp;</td>
      <td class="datagrid">&nbsp;</td>
      <td class="datagrid">&nbsp;</td>
      <td class="datagrid">&nbsp;</td>
      <td class="datagrid">&nbsp;</td>
      <td class="datagrid">&nbsp;</td>
    </tr>
    <tr>
      <td class="datagrid">&nbsp;</td>
      <td class="datagrid">&nbsp;</td>
      <td class="datagrid">&nbsp;</td>
      <td class="datagrid">&nbsp;</td>
      <td class="datagrid">&nbsp;</td>
      <td class="datagrid">&nbsp;</td>
      <td class="datagrid">&nbsp;</td>
      <td class="datagrid">&nbsp;</td>
    </tr>
  </table>
 
 </form>
 </body>

</html> 