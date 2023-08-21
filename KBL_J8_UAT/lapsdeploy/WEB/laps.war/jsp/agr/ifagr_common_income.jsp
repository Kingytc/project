<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />

<%
    String income="";   
    String seqno="";
    String year1="";
    String year2="";
    String year3="";
    String year4="";
    String year5="";
    String year6="";
    String year7="";
    String year8="";
    
   
    
    
    
    ArrayList gridData= new ArrayList();
    ArrayList data=new ArrayList();
    if(hshValues.get("vecData")!=null)
    	gridData=(ArrayList)hshValues.get("vecData");
        
    for(int i=0;i<=gridData.size()-1;i++){ 
          data=(ArrayList)gridData.get(i);    
          seqno=data.get(1).toString();
          income=data.get(3).toString();
          year1=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(data.get(4).toString())));
          year2=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(data.get(5).toString())));
          year3=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(data.get(6).toString())));
          year4=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(data.get(7).toString())));
          year5=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(data.get(8).toString())));
          year6=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(data.get(9).toString())));
          year7=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(data.get(10).toString())));
          year8=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(data.get(11).toString())));
          
    }
%>
<html>

<Script language="javascript"> 
 function load(){
   
    parent.document.forms[0].seqno.value="<%=seqno%>";   
    parent.document.forms[0].txt_agr_common_incomeandexpense.value="<%=income%>";  
    parent.document.forms[0].txt_agr_common_year1.value="<%=year1%>";
    parent.document.forms[0].txt_agr_common_year2.value="<%=year2%>"; 
    parent.document.forms[0].txt_agr_common_year3.value="<%=year3%>"; 
    parent.document.forms[0].txt_agr_common_year4.value="<%=year4%>"; 
    parent.document.forms[0].txt_agr_common_year5.value="<%=year5%>"; 
    parent.document.forms[0].txt_agr_common_year6.value="<%=year6%>"; 
    parent.document.forms[0].txt_agr_common_year7.value="<%=year7%>"; 
    parent.document.forms[0].txt_agr_common_year8.value="<%=year8%>";     
   } 
</script>

<body onload="load()">
<form name="frm" method="post">
</form>
</body>
</html>
