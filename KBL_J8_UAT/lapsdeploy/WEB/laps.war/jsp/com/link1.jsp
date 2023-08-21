<%@ page import="com.sai.laps.helper.*"%>
<html>
<head>
<script>
function callLink1(page,bean,method)
{	
	 document.forms[0].hidAction.value="";
	 document.forms[0].hidBeanGetMethod.value=method;
	 document.forms[0].hidBeanId.value=bean;
	 document.forms[0].action=appUrl+"action/"+page+"?pageval1=FI";
	
	 document.forms[0].submit();
	
}
</script>
</head>
<body>
<%if((Helper.correctNull((String)request.getParameter("cattype")).equalsIgnoreCase("SRE"))){
//out.println("------------->>>>>>>.............. "+Helper.correctNull((String)request.getParameter("tabid")));
%>

<%if((Helper.correctNull((String)request.getParameter("tabid")).equalsIgnoreCase("1"))){%>
<font color="#999999">1</font>
 <%}else{%>
 <a href="javascript:callLink('exec_page1.jsp','executive','getData')" class="blackfont">1</a>
 <%} %>
 
 <%if((Helper.correctNull((String)request.getParameter("tabid")).equalsIgnoreCase("2"))){%>
<font color="#999999">2</font>
 <%}else{%>
 <a href="javascript:callLink('exec_page2.jsp','executive','getData2')" class="blackfont">2</a>
 <%} %>
 
 <%if((Helper.correctNull((String)request.getParameter("tabid")).equalsIgnoreCase("3"))){%>
<font color="#999999">3</font>
 <%}else{%>
 <a href="javascript:callLink('exec_page5.jsp','executive','getData5')" class="blackfont">3</a>
 <%} %>
 
 <%if((Helper.correctNull((String)request.getParameter("tabid")).equalsIgnoreCase("4"))){%>
<font color="#999999">4</font>
 <%}else{%>
 <a href="javascript:callLink('exec_page10.jsp','executive','getData10')" class="blackfont">4</a>
 <%} %>
 
 <%if((Helper.correctNull((String)request.getParameter("tabid")).equalsIgnoreCase("5"))){%>
<font color="#999999">5</font>
 <%}else{%>
 <a href="javascript:callLink('exec_page6.jsp','executive','getData6')" class="blackfont">5</a>
 <%} %>
 
 <%if((Helper.correctNull((String)request.getParameter("tabid")).equalsIgnoreCase("6"))){%>
	<font color="#999999">6</font>
 <%}else{%>
  <a href="javascript:callLink('comsre_othermatters.jsp','modsancterms','getModsoughtData')" class="blackfont">6</a>
  <%} %>
  
  <%if((Helper.correctNull((String)request.getParameter("tabid")).equalsIgnoreCase("7"))){%>
	<font color="#999999">7</font>
 <%}else{%>
  <a href="javascript:callLink('comsre_justification.jsp?type=8','comproposal','getDataComment')" class="blackfont">7</a>
  <%} %>
  
  <%if((Helper.correctNull((String)request.getParameter("tabid")).equalsIgnoreCase("8"))){%>
	<font color="#999999">8</font>
 <%}else{%>
  <a href="javascript:callLink('comsre_rating.jsp','executive','getDataSRERatingDetails')" class="blackfont">8</a>
  <%} %>
  
   <%if((Helper.correctNull((String)request.getParameter("tabid")).equalsIgnoreCase("9"))){%>
<font color="#999999">9</font>
 <%}else{%>
  <a href="javascript:callLink('exec_page11.jsp','executive','getData11')" class="blackfont">9</a>
   <%} %>
 
 <%}
else if((Helper.correctNull((String)request.getParameter("cattype")).equalsIgnoreCase("STL"))){
//out.println("------------->>>>>>>.............. "+Helper.correctNull((String)request.getParameter("tabid")));
//out.println("------------->>>>>>>.............. "+Helper.correctNull((String)request.getParameter("cattype")));
%>

<%if((Helper.correctNull((String)request.getParameter("tabid")).equalsIgnoreCase("1"))){%>
	<font color="#999999">1</font>
 <%}else{%>
 	<a href="javascript:callLink('exec_page1.jsp','executive','getData')" class="blackfont">1</a>
 <%} %>
 
 <%if((Helper.correctNull((String)request.getParameter("tabid")).equalsIgnoreCase("4"))){%>
	<font color="#999999">2</font>
 <%}else{%>
 	<a href="javascript:callLink('exec_page10.jsp','executive','getData10')" class="blackfont">2</a>
 <%} %>
 
 <%if((Helper.correctNull((String)request.getParameter("tabid")).equalsIgnoreCase("2"))){%>
	<font color="#999999">3</font>
 <%}else{%>
  	<a href="javascript:callLink('comstl_comments.jsp?type=9&hidpage=norms~bplr','comproposal','getDataComment')" class="blackfont">3</a>
 <%} %>
   
  <%if((Helper.correctNull((String)request.getParameter("tabid")).equalsIgnoreCase("8"))){%>
	<font color="#999999">4</font>
 <%}else{%>
  	<a href="javascript:callLink('comsre_rating.jsp','executive','getDataSRERatingDetails')" class="blackfont">4</a>
   <%} %>  
   
    <%if((Helper.correctNull((String)request.getParameter("tabid")).equalsIgnoreCase("9"))){%>
	<font color="#999999">5</font>
 <%}else{%>
  	<a href="javascript:callLink('exec_page11.jsp','executive','getData11')" class="blackfont">5</a>
   <%} %>  
   
 <%}else if((Helper.correctNull((String)request.getParameter("cattype")).equalsIgnoreCase("ADC"))){
//out.println("------------->>>>>>>.............. "+Helper.correctNull((String)request.getParameter("tabid")));
//out.println("------------->>>>>>>.............. "+Helper.correctNull((String)request.getParameter("cattype")));
%>

<%if((Helper.correctNull((String)request.getParameter("tabid")).equalsIgnoreCase("1"))){%>
	<font color="#999999">1</font>
 <%}else{%>
 	<a href="javascript:callLink('exec_page1.jsp','executive','getData')" class="blackfont">1</a>
 <%} %>
 
 <%if((Helper.correctNull((String)request.getParameter("tabid")).equalsIgnoreCase("9"))){%>
	<font color="#999999">2</font>
 <%}else{%>
  	<a href="javascript:callLink('exec_page11.jsp','executive','getData11')" class="blackfont">2</a>
 <%} %>  
  
 <%}
else
{
%>
 <a href="javascript:callLink('exec_page1.jsp','executive','getData')" class="blackfont">1</a>
 <a href="javascript:callLink('exec_page2.jsp','executive','getData2')" class="blackfont">2</a>
 <!--<a href="javascript:callLink('exec_page3.jsp','executive','getData3')" class="blackfont">3</a>-->
 <a href="javascript:callLink('exec_page4.jsp','executive','getData4')" class="blackfont">3</a>
 <a href="javascript:callLink('exec_page5.jsp','executive','getData5')" class="blackfont">4</a>
 <a href="javascript:callLink('exec_page10.jsp','executive','getData10')" class="blackfont">5</a>
 <a href="javascript:callLink('exec_page6.jsp','executive','getData6')" class="blackfont">6</a>
 <!--<a href="javascript:callLink('exec_page7.jsp','executive','getData7')" class="blackfont">7</a>
 <a href="javascript:callLink('exec_page8.jsp','executive','getData8')" class="blackfont">6</a>-->
 <a href="javascript:callLink('exec_page9.jsp','executive','getData9')" class="blackfont">7</a> 
 <a href="javascript:callLink('exec_page11.jsp','executive','getData11')" class="blackfont">8</a>
 
 <%}%>
</body>
</html>
