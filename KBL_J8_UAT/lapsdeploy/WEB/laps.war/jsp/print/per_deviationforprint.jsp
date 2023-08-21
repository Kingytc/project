<%@include file="../share/directives.jsp"%>
<% 
   ArrayList arrDevCol = new ArrayList();
   ArrayList arrDevRow = new ArrayList();
   if(hshValues!=null)
   {
	   arrDevRow = (ArrayList)hshValues.get("arrDevRow");
   }
   String strPno = Helper.correctNull((String)request.getParameter("pno"));
   String StrsessionModuleType=Helper.correctNull((String)  session
			.getAttribute("sessionModuleType"));

%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Deviation Details</title>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/report.css" type="text/css">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js">
</script>
<SCRIPT LANGUAGE="JavaScript">
</SCRIPT>
</head>

<body>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	align="center" class="outertable">
  <tr>
		<td>
		
      <table width="100%" border="0" cellpadding="0" cellspacing="0"  align="center" class="outertable">		
	
			<tr>
			<td>
			<div id="top">
			<table width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" class="outertable">
			<tr>
			<td colspan="5"><span style="float: left;"><b><%=strPno%>. Deviation Details</b></span><span style="float: right;">[Amount in Rs.]</span></td>
			<tr class="tblhead">
			<td align="center" width="25%"> Description </td>
			<td align="center" width="12%"> Old Value </td>
			<td align="center" width="12%"> New Value</td>
			<td align="center" width="40%"> Remarks </td>
			<td align="center" width="10%"> Status </td>
			</tr>
			<%
			if (arrDevRow != null && arrDevRow.size() > 0) 
			{
			for (int i = 0; i < arrDevRow.size(); i++) 
			{
				arrDevCol = (ArrayList) arrDevRow.get(i);
				
				if(i==2)
				{
			%>
			<tr >
			<td width="25%"><%=Helper.correctNull((String)arrDevCol.get(0)) %></td>
			<td align="right" width="12%"><%=Helper.correctNull((String)arrDevCol.get(1)) %></td>
			<td align="right" width="12%"><%=Helper.correctNull((String)arrDevCol.get(2)) %></td>
			<td align="left" width="40%"><%=Helper.correctNull((String)arrDevCol.get(3)) %></td>
			<td align="center" width="10%"><%=Helper.correctNull((String)arrDevCol.get(4)) %></td>
			</tr> 
			<%}else{%>
	
			
			<tr >
			<td width="20%"><%=Helper.correctNull((String)arrDevCol.get(0)) %></td>
			<td align="right" width="12%"><%=Helper.checkDecimal((String)arrDevCol.get(1)) %></td>
			<td align="right" width="12%"><%=Helper.checkDecimal((String)arrDevCol.get(2)) %></td>
			<td align="left" width="40%"><%=Helper.correctNull((String)arrDevCol.get(3)) %></td>
			<td align="center" width="10%"><%=Helper.correctNull((String)arrDevCol.get(4)) %></td>
			</tr> 
			<%}}}else{  %>
			<tr >
			<td colspan="5" align="center">- Nil -</td>
			</tr> 
			<%} %>
			</table>
			</div>
			</td>
			</tr>		
		</table>
		</td>
	</tr>

<% if(StrsessionModuleType.equalsIgnoreCase("DIGI")){
	   	  	         String arrAmbersName=Helper.correctNull((String)hshValues.get("arrcol"));
					 if(!arrAmbersName.equalsIgnoreCase("")){
	%>
	                	<div id="top">
	                	<table  width="100%" border="1" align="center" cellpadding="2"  cellspacing="0" 
				    		class="outertable">
				    		
				    		<tr>
	<td  colspan=""  border="0" width="25%" cellpadding="3"  cellspacing="0" 
	class="outertable"><b>Applicant Name</b>	
	
	<td colspan=""  border="0" width="75%" cellpadding="3"  cellspacing="0" 
	class="outertable"> <b>Amber Rules </b></td>
	    </tr>
	    
	       <tr>         
	         	  <table >
	         	    
	         	<%
	         	 String arrtempName=Helper.correctNull((String)hshValues.get("arrName"));	
	         	 %>
     	      	
	   <td colspan=""  border="1" width="35%" class="outertable" align="left" >
	   
	   	<table  width="100%" border="1" align="center" cellpadding="2"  cellspacing="0" 
				    		class="outertable">
          			<%
          			String []name=arrtempName.split(","); 
          			String [] amberName=arrAmbersName.split(",");
          			if(!amberName.equals("")){
          			for(int i=0;i<amberName.length;i++){
          			%>	
	                				<tr>
									<td colspan="4" width="25%" border="1"   cellpadding="3"  cellspacing="1" 
								class="outertable" valign="top" ><%=name[i]%></td>
								
								<td colspan="4"  border="1"   cellpadding="3"  cellspacing="1" 
								class="outertable" valign="top" ><%=amberName[i]%></td>
									
									</tr>								
	<%}} %>
			</table>						
	   			</td>
	                		</tr>
	                		 <div id="top">  
	                		<table width="100%" border="1" align="center" cellpadding="3"  cellspacing="0" 
				    		class="outertable">

			<tr>
				<td colspan="4" width="38%" border="0" cellpadding="3"
					cellspacing="0" class="outertable"><b>Recommendation
				by the Branch / CLPH</b></td>
				<td>
				<table>
					<tr>
						<td valign="top" width="66%"><%=Helper.correctNull((String) hshValues
									.get("strBranchRec"))%>
						</td>
					</tr>
				</table>
				</td>
			</tr>

			<tr>
				    		<td colspan="4" width="25%" border="0"  cellpadding="3"  cellspacing="0" class="outertable"><b>Recommendation by the Head Office</b>
				    		
				    		</td>
		    				<td>
		    				<table>
							<tr>
				    		<td  valign="top"><%=Helper.correctNull((String) hshValues
							.get("strHeadOfficeRec"))%>
				    		</td>
				    		</tr>
							</table>
				    		</tr>    	
	                		</table>                		
	                		</table>
	                		
	                		 </div>  
	                	</td>
	                	</table>
	                	</tr>
	         <%}} %> 
	        <div id="top">  
	      <table    width="100%" border="1" align="center" cellpadding="2"  cellspacing="0" 
				    		class="outertable">
				    		
				    	
</table>
</body>
</html>