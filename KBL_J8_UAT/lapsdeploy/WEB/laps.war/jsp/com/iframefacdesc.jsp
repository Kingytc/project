<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />

<%
   ArrayList vecRow=new ArrayList();
   ArrayList vecCol=new ArrayList();
   if(hshValues!=null)
   {
	   
	   vecRow=(ArrayList)hshValues.get("vecRow");
   }
   
   String subFacFlag=Helper.correctNull((String)hshValues.get("subFacFlag"));
   String strFacSelCode=Helper.correctNull((String)hshValues.get("strFacSelCode"));
%>

<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script>
var varsubFacFlag="<%=subFacFlag%>";
var varstrFacSelCode="<%=strFacSelCode%>";

function loadValues()
{
	<%

      int sel_length=vecRow.size();
    
    %>

   // alert(<%=sel_length+1%>);

    //alert(varsubFacFlag);

    //alert(varstrFacSelCode);

    if(varsubFacFlag=="N")
    {

	parent.frames.document.facility.facilitydesc.length="<%=sel_length+1%>";
	parent.frames.document.facility.facilitydesc.options[0].text = "-- Select --";
	parent.frames.document.facility.facilitydesc.options[0].value = "";	
	parent.frames.document.facility.facilitydesc.options[0].title="";

	        <%
	          if(vecRow.size()>0){
	        	  
	        	  for(int i=0;i<vecRow.size();i++)
	        	  {
	        		  vecCol=(ArrayList)vecRow.get(i);
	        		  if(vecCol.size()>0)
	        		  {
	        			  %>

	        			 // str.search
	        			 alert( parent.frames.document.facility.elements["facilitydesc"].options[<%=(i+1)%>].text);
	        				    parent.frames.document.facility.elements["facilitydesc"].options[<%=(i+1)%>].text="<%=Helper.correctNull((String)vecCol.get(1))+"-"+Helper.correctNull((String)vecCol.get(2))+"-"+Helper.correctNull((String)vecCol.get(3))+"-"+Helper.correctNull((String)vecCol.get(4))+"-"+Helper.correctNull((String)vecCol.get(5))+"-"+Helper.correctNull((String)vecCol.get(6))%>";
	        					parent.frames.document.facility.elements["facilitydesc"].options[<%=(i+1)%>].value="<%=Helper.correctNull((String)vecCol.get(0))+"-"+Helper.correctNull((String)vecCol.get(2))+"-"+Helper.correctNull((String)vecCol.get(3))+"-"+Helper.correctNull((String)vecCol.get(5))+"-"+Helper.correctNull((String)vecCol.get(6))%>";	        					
	        					parent.frames.document.facility.facilitydesc.options[<%=(i+1)%>].title="<%=Helper.correctNull((String)vecCol.get(1))+"-"+Helper.correctNull((String)vecCol.get(2))+"-"+Helper.correctNull((String)vecCol.get(3))+"-"+Helper.correctNull((String)vecCol.get(4))+"-"+Helper.correctNull((String)vecCol.get(5))+"-"+Helper.correctNull((String)vecCol.get(6))%>";
	        			   
	        			  <%
	        			 
	        		  
	        		  }
	        	  }
	        	  
	        	  
	        	  
	          }
	        
	        %>	

	        if(varstrFacSelCode!="")
	        {

	        	parent.frames.document.facility.facilitydesc.value=varstrFacSelCode;	        	 
	        }
	        else
	        {

	        	parent.frames.document.facility.facilitydesc.value="";

	        }

	        
	        

    }

    else if(varsubFacFlag=="Y")
    {

    	parent.frames.document.facility.facilitydescsub.length="<%=sel_length+1%>";
    	parent.frames.document.facility.facilitydescsub.options[0].text = "-- Select --";
    	parent.frames.document.facility.facilitydescsub.options[0].value = "";	
    	parent.frames.document.facility.facilitydescsub.options[0].title = "";

    	        <%
    	          if(vecRow.size()>0){
    	        	  
    	        	  for(int i=0;i<vecRow.size();i++)
    	        	  {
    	        		  vecCol=(ArrayList)vecRow.get(i);
    	        		  if(vecCol.size()>0)
    	        		  {
    	        			  %>

    	        			  str.search
    	        				    parent.frames.document.facility.elements["facilitydescsub"].options[<%=(i+1)%>].text="<%=Helper.correctNull((String)vecCol.get(1))+"-"+Helper.correctNull((String)vecCol.get(2))+"-"+Helper.correctNull((String)vecCol.get(3))+"-"+Helper.correctNull((String)vecCol.get(4))+"-"+Helper.correctNull((String)vecCol.get(5))+"-"+Helper.correctNull((String)vecCol.get(6))%>";
    	        					parent.frames.document.facility.elements["facilitydescsub"].options[<%=(i+1)%>].value="<%=Helper.correctNull((String)vecCol.get(0))+"-"+Helper.correctNull((String)vecCol.get(2))+"-"+Helper.correctNull((String)vecCol.get(3))+"-"+Helper.correctNull((String)vecCol.get(5))+"-"+Helper.correctNull((String)vecCol.get(6))%>";
    	        					parent.frames.document.facility.facilitydescsub.options[<%=(i+1)%>].title="<%=Helper.correctNull((String)vecCol.get(1))+"-"+Helper.correctNull((String)vecCol.get(2))+"-"+Helper.correctNull((String)vecCol.get(3))+"-"+Helper.correctNull((String)vecCol.get(4))+"-"+Helper.correctNull((String)vecCol.get(5))+"-"+Helper.correctNull((String)vecCol.get(6))%>";
    	        			   
    	        			  <%
    	        			 
    	        		  
    	        		  }
    	        	  }
    	        	  
    	        	  
    	        	  
    	          }
    	        
    	        %>	
    	        
    	        if(varstrFacSelCode!="")
    	        {

    	        	parent.frames.document.facility.facilitydescsub.value=varstrFacSelCode;	        	 
    	        }
    	        else
    	        {

    	        	parent.frames.document.facility.facilitydescsub.value="";

    	        }



    }
    
		   
	

}

</script>
</head>

<body  text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadValues()">
<form name="frm" method="post">
</form>
</body>
</html>
