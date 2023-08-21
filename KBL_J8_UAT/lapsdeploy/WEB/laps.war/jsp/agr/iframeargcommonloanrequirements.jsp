<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />

<%
    String particulars="";
    String units="";
    String unitCost="";
    String amount="";
    String seqno="";
    String type="";
    
    
    
    ArrayList gridData= new ArrayList();
    ArrayList data=new ArrayList();
    if(hshValues.get("vecData")!=null)
    	gridData=(ArrayList)hshValues.get("vecData");
        
    for(int i=0;i<=gridData.size()-1;i++){ 
         data=(ArrayList)gridData.get(i);    
         seqno=data.get(1).toString();
         particulars=data.get(2).toString();
         type=data.get(3).toString();
         units=data.get(4).toString();
         unitCost=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(data.get(5).toString())));
         amount=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(data.get(6).toString())));      
    }
%>
<html>

<Script language="javascript"> 
 function load(){
   
   parent.document.forms[0].txt_agrcommon_particulars.value="<%=particulars%>";
   parent.document.forms[0].sel_agrcommon_type.value="<%=type%>";
   parent.document.forms[0].txt_agrcommon_units.value="<%=units%>";
   parent.document.forms[0].txt_agrcommon_unitcost.value="<%=unitCost%>";
   parent.document.forms[0].txt_agrcommon_amount.value="<%=amount%>";
   parent.document.forms[0].seqno.value="<%=seqno%>";   
   
  
   
    
   
   
   } 
</script>

<body onload="load()">
<form name="frm" method="post">
</form>
</body>
</html>
