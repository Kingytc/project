<%@include file="../share/directives.jsp"%>
<%
ArrayList arrRow=new ArrayList();
ArrayList arrCol=null;	
arrRow=(ArrayList)hshValues.get("arrRow");
String mon_month=Helper.correctNull((String)request.getParameter("mon_month"));
String mon_year=Helper.correctNull((String)request.getParameter("mon_year"));
String mon_cbsname=Helper.correctNull((String)request.getParameter("cbsname"));
String hidmontype1=Helper.correctNull((String)request.getParameter("strhidmontype"));
String strprinttype=Helper.correctNull((String)hshValues.get("hidprinttype"));
if(mon_cbsname.equalsIgnoreCase(""))
{
	mon_cbsname=Helper.correctNull((String)hshValues.get("cbsname"));  
}

//System.out.println(hshValues);%>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>	
<script>
var varmontype="<%=hidmontype1%>";
var varprinttype="<%=strprinttype%>";
var varOrgShortCode = "<%=Helper.correctNull((String)session.getAttribute("strOrgShortCode"))%>";

var mail_user="<%=Helper.correctNull((String)hshValues.get("mail_user"))%>";
var user_id="<%=Helper.correctNull((String)session.getAttribute("strUserId"))%>";
var varClass = "<%=Helper.correctNull((String)request.getParameter("classid"))%>";
function loaddata()
{
	<%if(Helper.correctNull((String)(hshValues.get("canprepare"))).equalsIgnoreCase("N"))
	{
	%>
		alert("<%=Helper.correctNull((String)hshValues.get("mmrreason"))%>");
	<%}	
	else if(Helper.correctNull((String)(hshValues.get("canprepare"))).equalsIgnoreCase("Y"))
	{%>
			var varyear="<%=mon_year%>";
			var varmonth="<%=mon_month%>";
			var varname="<%=mon_cbsname%>";
	
			document.forms[0].hidBeanId.value="mmrcommon";
			document.forms[0].hidBeanGetMethod.value="getMonfacility";
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/mon_facilitiesenjoyed.jsp?&cbsname="+varname;
			document.forms[0].target="mainFrame";
			document.forms[0].submit();
		<%
	} else{
		String strflag=Helper.correctNull((String)(hshValues.get("flag")));
		if(strflag.equalsIgnoreCase("false"))
		{%>
			alert("Data is not available");
		<%
		}
	%>	
		<%}%>
}	
function callFacilitiesenjoyed(year,month,org_code,statusflag,mmrno,mmrappholder,mmrapporgname)
{
	if(varmontype=="MONTHMONIT")
	{
		var mon_year=year;
		var mon_month=month;
		var varbtnenable="N";
		var varname="<%=mon_cbsname%>";
		if(statusflag=="O")
		{
			if(org_code==varOrgShortCode)
			{
				statusflag = 'O';
				varbtnenable="Y";
			}
			else
			{
				statusflag = 'C';
				varbtnenable="N";
			}
		}
		else if(statusflag=="P")
		{
			if(mmrappholder=="<%=Helper.correctNull((String)session.getAttribute("strUserId"))%>")
			{
				if(org_code==varOrgShortCode)			
				{
					statusflag = 'O';
					varbtnenable="Y";
				}
				else
				{
					statusflag = 'C';
					varbtnenable="N";
				}
			}
			else
			{
				statusflag = 'C';
				varbtnenable="N";
			}			
		}
		if(varClass == '002'){
			statusflag= 'C';
		}
		document.forms[0].hidBeanId.value="mmrcommon";
		document.forms[0].hidBeanGetMethod.value="getMMRFacility";
		document.forms[0].mon_year.value=mon_year;
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/mon_facilitiesenjoyed.jsp?mon_month="+mon_month+"&cbsname="+varname+"&statusflag="+statusflag+"&mmrno="+mmrno+"&mmrappholder="+mmrappholder+"&mmrapporgname="+mmrapporgname+"&btnenable="+varbtnenable;
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}			
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="loaddata()">
<form name="framresult" method="post" class="normal">
  <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable linebor">
    
   <%
   String Months[]={"","January","February","March","April","May","June","July","August","September","October","November","December"};
   String strStatus="";
    arrRow=(ArrayList)hshValues.get("arrRow");
		if(arrRow!=null && arrRow.size()>0 )
		{
			for(int i=0;i<12;i++)
			{
				if(i>=arrRow.size())
				{%>
					<tr class="datagrid"> 
				      <td>
				      &nbsp;      
				      </td>
				      </tr> 
				 <%}
				else
				{
			arrCol = (ArrayList)arrRow.get(i);
			if(arrCol!=null && arrCol.size()>0)
			{
				strStatus=Helper.correctNull((String)arrCol.get(3));
		%>
		<tr class="datagrid"> 
      <td>
      <a  class="blackfont" href="javascript:callFacilitiesenjoyed('<%=Helper.correctNull((String)arrCol.get(0))%>','<%=Helper.correctNull((String)arrCol.get(1))%>','<%=Helper.correctNull((String)arrCol.get(2))%>','<%=Helper.correctNull((String)arrCol.get(3))%>','<%=Helper.correctNull((String)arrCol.get(4))%>','<%=Helper.correctNull((String)arrCol.get(5))%>','<%=Helper.correctNull((String)arrCol.get(6))%>')">
      <b><%=Helper.correctNull((String)arrCol.get(0))%>&nbsp; - &nbsp;<%
      String str=Helper.correctNull((String)arrCol.get(1));
      int mon=Integer.parseInt(str);%>
      <%=Months[mon]%>&nbsp;      
      </b></a>
      </td>
      </tr> 
      <%}}}}%>
		</table>
		<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="mon_year" value="<%=Helper.correctNull((String)request.getParameter("mon_year")) %>">
<input type="hidden" name="mon_smonth" value="<%=Helper.correctNull((String)request.getParameter("mon_month")) %>">
<input type="hidden" name="mon_mmrno" value="<%=Helper.correctNull((String)request.getParameter("mon_mmrno")) %>">
<input type="hidden" name="hidmontype" value="<%=request.getParameter("hidmontype")%>">
<input type="hidden" name="hidprinttype" value="<%=Helper.correctNull((String)hshValues.get("hidprinttype"))%>">
<input type="hidden" name="mon_accno" value="<%=Helper.correctNull((String)request.getParameter("mon_accno")) %>">
<input type="hidden" name="cbsid" value="<%=Helper.correctNull((String)request.getParameter("cbsid"))%>">
<input type="hidden" name="solid" value="<%=Helper.correctNull((String)request.getParameter("solid"))%>">
<input type="hidden" name="cbsaccno" value="<%=request.getParameter("cbsaccno")%>">
<input type="hidden" name="app_status" value="<%=strStatus%>">
</form>
</body>
</html>
