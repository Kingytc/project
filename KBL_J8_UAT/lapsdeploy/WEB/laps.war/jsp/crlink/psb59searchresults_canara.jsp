<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>
<lapschoice:handleerror />
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
	<%
	ArrayList arryCol=null;
	ArrayList arryRow=(ArrayList)hshValues.get("arryRow");
	HashMap myhsh = (HashMap)hshValues.get("extfld");
	String strmsg=Helper.correctNull((String)hshValues.get("message"));
	String hsh_str_sectortype=Helper.correctNull((String)hshValues.get("hsh_str_sectortype"));
	String strApplicantMigVal=Helper.correctNull((String)hshValues.get("CBSIDUpdatedValue"));
	String strMessage=Helper.correctNull((String)hshValues.get("strMessage"));
	//out.println(arryRow);
	
	%>

<html>
<head>
<title>searchresultsCanara</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript">
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var var_hsh_str_sectortype="<%=hsh_str_sectortype%>";
var varApplicantMigval="<%=strApplicantMigVal%>";
var varBranchMigVal="<%=Helper.correctNull((String)session.getAttribute("BranchMigValue"))%>";
var varstrOrgLevel="<%=Helper.correctNull((String)session.getAttribute("strOrgLevel"))%>";
function callLink(demoid)
{
	if(varstrOrgLevel =="A")
	{
	if(varApplicantMigval =="0" && varBranchMigVal=="1")
	  {
		  alert("Please Migrate The Customer ID into New CBS Version");
		  return;
	  }
	  var flag=false;
	  if(varBranchMigVal =="0" && varApplicantMigval =="1")
	  {
		   flag = confirm("Customer Id belongs to new CBS version. So branch has to Disburse the Loan in new CBS version. Kindly Confirm and Proceed Further");
		  
	  }
	  else
	  {
		  flag=true;
	  }
	} else
	  {
		  flag=true;
	  }
	  if(flag)
	  {
		/*//window.parent.close();
		var	varQryString = appUrl+"action/psb59perapplicant.jsp?hidBeanId=NationalPortal&hidBeanGetMethod=getpsb59demographics";
		var title = "CBSIDSerach";
		var prop = "scrollbars=yes,width=800,height=500,menubar=no";	
		var xpos = (screen.width - 350) / 2;
		var ypos = (screen.height - 120) / 2;
		prop = prop + ",left=20,top=20";
		window.open(varQryString,title,prop);*/
		  window.parent.close();
			document.forms[0].hidmode.value = "<%=Helper.correctNull((String)myhsh.get("mode"))%>"
			document.forms[0].hidAppType.value="";
			document.forms[0].hidDemoId.value=demoid;
			document.forms[0].hidBeanId.value="NationalPortal";		
			document.forms[0].hidBeanGetMethod.value="getpsb59demographics";		
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/psb59perapplicant.jsp?applnt=P&scode=yyy";
			document.forms[0].target="mainFrame";
			document.forms[0].submit();
		
	  }
}
function enableSearchBtn()
{
	parent.frames.document.forms[0].cmdOK2.disabled = false;
	///parent.frames.document.forms[0].hsh_str_sectortype.value=var_hsh_str_sectortype;
}

</SCRIPT>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
</head>
<body onLoad="enableSearchBtn();"  text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" link="#000000" vlink="#000000" alink="#000000" class="bgcolor">
<form name="isearch" method="post">
  <table width="100%" border="0" cellpadding="1" cellspacing="2" bordercolorlight="#EBEBF8" bordercolordark="#82829F" >
    <%
	if(arryRow!=null && arryRow.size()>0)
	{
		for(int i=0;i<arryRow.size();i++)
		{
			arryCol=(ArrayList)arryRow.get(i);
			if(arryCol!=null)
			{
			
%>
    <tr class="outertablecolor"  > 
      <td width="37%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="JavaScript:callLink('<%=arryCol.get(0)%>')" class="blackfont"><b><font size="1" face="MS SansSerif" >
		 	 <%  
				String title;
				String fn;
				String ln;
				String mn;
				title =Helper.correctNull((String)arryCol.get(1));
				fn=Helper.correctNull((String)arryCol.get(2));
				ln=Helper.correctNull((String)arryCol.get(3));
				mn=Helper.correctNull((String)arryCol.get(4));
				title=title.toUpperCase();
				fn=fn.toUpperCase();
				mn=mn.toUpperCase();
				ln=ln.toUpperCase();
				%> <%=title%>&nbsp;<%=fn%>&nbsp;<%=mn%>&nbsp;<%=ln%>&nbsp;</font></b><a><font size="1" face="MS Sans Serif"></font></a></a>
	  </td>
      <td width="17%" align="left"><b><font size="1" face="MS Sans Serif"><%=Helper.correctNull((String)arryCol.get(5))%>&nbsp;</font></b></td>
       <!-- <td width="17%" align="left"><b><font size="1" face="MS Sans Serif"><%=Helper.correctNull((String)arryCol.get(0))%>&nbsp;</font></b></td> -->
	  
	  <td width="36%" align="center"> 
        <font size="1" face="MS Sans Serif"><%=Helper.correctNull((String)arryCol.get(6))%>&nbsp;</font>
      </td>
	  
	  
	  <!--<td width="36%" align="center"> 
        <div align="left"><b><font size="1" face="MS Sans Serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%//=Helper.correctNull((String)arryCol.get(4))%><%=Helper.correctNull((String)hshValues.get("orgname"))%>&nbsp;</font></b></div>
      </td>
    -->
    
    </tr>
		 
    <%
			}
		}
	}
	else
	{ 
		if(!strMessage.equalsIgnoreCase(""))
		{ %>
			<tr> 
      <td width="37%"><a><font size="3" face="MS Sans Serif"><center><%out.println(strMessage);%></center></font></a></td>
	  </tr>
		<%}
		else
		{
		%>
	
		<tr> 
	      <td width="37%"><a><font size="3" face="MS Sans Serif"><center><%out.println("-----NO DATA FOUND-----");%></center></font></a></td>
		  </tr>
		  <%} %>
	<%
	}
%>
  </table>
  <INPUT TYPE="hidden" name="hidAppType">
  <INPUT TYPE="hidden" name="hidBeanId">
  <INPUT TYPE="hidden" name="hidBeanGetMethod">
  <input type="hidden" name="hidDemoId" >
<input type="hidden" name="hidmode"  >

   <input type="hidden" name="hid_sectortyp" value="<%=hsh_str_sectortype%>">
</form>
</body>
</html>
