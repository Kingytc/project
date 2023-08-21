<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />

<%
	ArrayList vecFacId =(ArrayList)hshValues.get("vecCodes");
	ArrayList vecFacName =(ArrayList)hshValues.get("vecValues");
	int ind=0;
	String strFacid = Helper.correctNull((String)request.getParameter("factid"));
	String strtype = Helper.correctNull((String)request.getParameter("strtype"));
	
%>

<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script  LANGUAGE="JavaScript">
var facid = "<%=strFacid.trim()%>";
function loadValues()
{
<%
	 if (vecFacId!=null && vecFacId.size() > 0)
	 {
	
		String s = (String)vecFacId.get(0);
		if(strtype.equals("facility"))
		 {
%>
			
			parent.frames.document.facility.elements["facility"].length ="<%=(vecFacId.size()+1)%>";
		    parent.frames.document.facility.elements["facility"].options[0].text="<---Select--->";		
			parent.frames.document.facility.elements["facility"].options[0].value="-";			
<%		 }
		else if(strtype.equals("sublimit"))
		{
%>
			
			parent.frames.document.facility.elements["subfacility"].length ="<%=(vecFacId.size()+1)%>";
		    parent.frames.document.facility.elements["subfacility"].options[0].text="<---Select--->";	
			parent.frames.document.facility.elements["subfacility"].options[0].value="-";			
<%		}
%>
<%			for(int i=0;i<vecFacId.size();i++)
			{
				String b = (String)vecFacId.get(i);
				String c = (String)vecFacName.get(i);
				if(strtype.equals("facility"))
				 {
%>
			
		    parent.frames.document.facility.elements["facility"].options[<%=(i+1)%>].text="<%=c%>";
			parent.frames.document.facility.elements["facility"].options[<%=(i+1)%>].value="<%=b%>";
			if(facid!=null)
			{
				getfacid = "<%=b%>";
				arr = getfacid.split("-");
				if(arr[0]==facid)
				{
				parent.frames.document.facility.elements["facility"].options[<%=(i+1)%>].selected=true;
				}
			}

<%}
		else if(strtype.equals("sublimit"))
		{
	%>
			
		    parent.frames.document.facility.elements["subfacility"].options[<%=(i+1)%>].text="<%=c%>";
			parent.frames.document.facility.elements["subfacility"].options[<%=(i+1)%>].value="<%=b%>";
			if(facid!=null)
			{
				getfacid = "<%=b%>";
				arr = getfacid.split("-");
				if(arr[0]==facid)
				{
				parent.frames.document.facility.elements["subfacility"].options[<%=(i+1)%>].selected=true;
				}
			}

	<%	}
			}

	}
	else
	{
%>
			//	parent.frames.document.forms[0].elements["facility"+ind].length =0;
			parent.frames.document.facility.elements["facility"].length ="<%=(vecFacId.size()+1)%>";
 			parent.frames.document.facility.elements["facility"].options[0].text="<---Select--->";		
			parent.frames.document.facility.elements["facility"].options[0].value="-";	
			
			//parent.frames.document.facility.elements["subfacility"].length ="<%//=(vecFacId.size()+1)%>";
		   // parent.frames.document.facility.elements["subfacility"].options[0].text="<---Select--->";	
			//parent.frames.document.facility.elements["subfacility"].options[0].value="-";
<%  }
%>
	

}

</script>
</head>
<body onLoad="loadValues()">
<form name="frm" method="post">
</form>
</body>
</html>
