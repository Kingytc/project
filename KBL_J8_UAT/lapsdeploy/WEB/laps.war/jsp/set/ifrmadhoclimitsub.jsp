<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />
<%ArrayList arrRow=new ArrayList();
ArrayList arrCol=new ArrayList();
arrRow=(ArrayList)hshValues.get("arrRow");
String strGroup=Helper.correctNull((String)hshValues.get("strGroup"));
String appno=Helper.correctNull((String)hshValues.get("appno"));
String strTemp="";
if(strGroup.equalsIgnoreCase("M"))
	strTemp="seladhocof";
else
	strTemp="selsubadhocof";
String strLimitType=Helper.correctNull((String)hshValues.get("strLimitType"));
%>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script type="text/javascript">
var sno="<%=Helper.correctNull((String)hshValues.get("sno"))%>";
var subsno="<%=Helper.correctNull((String)hshValues.get("subsno"))%>";
function loadValues()
{	
	<%
	if(strLimitType.equalsIgnoreCase("A")||strLimitType.equalsIgnoreCase("D"))
	{
	if (arrRow!=null && arrRow.size() > 0)
	{ %>			
	parent.frames.document.forms[0].<%=strTemp%>.length ="<%=arrRow.size()+1%>";
	parent.frames.document.forms[0].<%=strTemp%>.options[0].text="<--Select-->";
	parent.frames.document.forms[0].<%=strTemp%>.options[0].value="";
	<%	for(int i=0;i<arrRow.size();i++)
		{
			arrCol=(ArrayList)arrRow.get(i);
			if(arrCol!=null && arrCol.size() > 0){
				String strId=Helper.correctNull((String)arrCol.get(0))+"~"+Helper.correctNull((String)arrCol.get(1))+"~"+Helper.correctNull((String)arrCol.get(3))+"~"+Helper.correctNull((String)arrCol.get(4))+"~"+Helper.correctNull((String)arrCol.get(5))+"~"+Helper.correctNull((String)arrCol.get(6));
				String strName=Helper.correctNull((String)arrCol.get(0))+"-"+Helper.correctNull((String)arrCol.get(1))+"-"+Helper.correctNull((String)arrCol.get(2))+"-"+Helper.correctNull((String)arrCol.get(3))+"-"+Helper.correctNull((String)arrCol.get(4));
			%>
			parent.frames.document.forms[0].<%=strTemp%>.options[<%=i+1%>].text="<%=strName%>";
			parent.frames.document.forms[0].<%=strTemp%>.options[<%=i+1%>].value="<%=strId%>";
	  <%}}
	if(!appno.equalsIgnoreCase("new")){
	if(strGroup.equalsIgnoreCase("M"))
	{%>
		if(parent.frames.document.forms[0].elements["hid_adhocfacfor"+sno+subsno]!=undefined)
		{
			var flag=false;
			var a=0;
			if(parent.frames.document.forms[0].elements["hid_adhocfacfor"+sno+subsno].value!="")
			{
				var varTemp=(parent.frames.document.forms[0].elements["hid_adhocfacfor"+sno+subsno].value).split("~");
				for(var i=0;i<parent.frames.document.forms[0].seladhocof.length;i++)
				{
					if((parent.frames.document.forms[0].seladhocof.options[i].value).indexOf(varTemp[0]+"~"+varTemp[1])!=-1)
					{
						flag=true;
						a=i;
					}
				}
			}
			if(flag)
			{
				parent.frames.document.forms[0].seladhocof.options[a].selected=true;
			}
			else
			{
				parent.frames.document.forms[0].seladhocof.selectedIndex="0";
			}
		}
	<%}
	else
	{%>
		if(parent.frames.document.forms[0].elements["hid_subadhocfacfor"+sno+subsno]!=undefined)
		{
			parent.frames.document.forms[0].seladhocof.value=parent.frames.document.forms[0].elements["hid_adhocfacfor"+subsno+"0"].value;
			

			var flag=false;
			var a=0;
			if(parent.frames.document.forms[0].elements["hid_subadhocfacfor"+sno+subsno].value!="")
			{
				var varTemp=(parent.frames.document.forms[0].elements["hid_subadhocfacfor"+sno+subsno].value).split("~");
				for(var i=0;i<parent.frames.document.forms[0].selsubadhocof.length;i++)
				{
					if((parent.frames.document.forms[0].selsubadhocof.options[i].value).indexOf(varTemp[0]+"~"+varTemp[1])!=-1)
					{
						flag=true;
						a=i;
					}
				}
			}
			if(flag)
			{
				parent.frames.document.forms[0].selsubadhocof.options[a].selected=true;
			} 
			else
			{
				parent.frames.document.forms[0].selsubadhocof.selectedIndex="0";
			}
		}
	<%}}
	}else{%>
	parent.frames.document.forms[0].<%=strTemp%>.length =1;
	parent.frames.document.forms[0].<%=strTemp%>.options[0].text="<--Select-->";
	parent.frames.document.forms[0].<%=strTemp%>.options[0].value="";
	<%}}else{
	if(Helper.correctNull((String)hshValues.get("strAvailability")).equalsIgnoreCase("Y")){%>
	alert("The borrower already availed Regular Limit under this category,\n Please select either Adhoc, One time or Addtional Limit");
	<%if(strGroup.equalsIgnoreCase("M")){%>
	parent.frames.document.forms[0].seladhoclimit.value="";
	parent.frames.document.all.idadhoc.style.display="none";
	parent.frames.document.all.idadhoc1.style.display="none";
	<%}else{%>
	parent.frames.document.forms[0].selsubadhoclimit.value="";
	parent.frames.document.all.idsubadhoc.style.display="none";
	parent.frames.document.all.idsubadhoc1.style.display="none";
	<%}}}%>
}

</script>
</head>

<body bgcolor="#E4E2ED" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadValues()">
<form name="appfrm" method="post">
</form>
</body>
</html>
