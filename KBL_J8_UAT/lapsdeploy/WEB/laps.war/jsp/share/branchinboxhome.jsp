<%@include file="../share/directives.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Branch Inbox</title>
<script>
function getMailBox(strFormType)
{
	showProgress('imgloading');
	document.all.idtable.style.display="none";
	document.forms[0].optformtype.value=strFormType;
	document.forms[0].hidBeanGetMethod.value="getBranchMailBox";
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/branchinbox.jsp?fromlink=Branchmailbox";
	document.forms[0].submit();
}
</script>
 <style>
 body{background-color:#F4EAF4;}
	    .mainNav{width:80%; height:100px;position:absolute;top:50%;left:30%;margin:-130px 0 0 -400px;}
		a{text-decoration:none;}
		ul.navIcon li{display:inline-block;float:left;margin:10px 5px;list-style-type: none;}
		ul.navIcon li a{display:inline-block;padding:50px 20px;color:#942188; background: #ece1ea;font-size:16px;font-weight:600;
			text-align:center;border:1px solid #cba2c6;
			width:170px;position:relative;}
		ul.navIcon li a img{position:absolute;top:-45px;z-index:10;left:40%;display:none;}
	    	ul.navIcon li a:hover {background: #3BA233;color:#fff;}
		ul.navIcon li a:hover img{display:inline; border: none;}
	 ul.navIcon li a.bg-yellow{ background-color:#dfc7dc; } ul.navIcon li a.bg-yellow:hover{background:#942188} 
	  ul.navIcon li a.bg-green{background-color:#dfc7dc; } ul.navIcon li a.bg-green:hover{background:#942188} 
	 ul.navIcon li a.bg-orange{background-color:#dfc7dc; } ul.navIcon li a.bg-orange:hover{background:#942188} 
	 ul.navIcon li a.bg-blue{background-color:#dfc7dc;} ul.navIcon li a.bg-blue:hover{background:#942188} 
	</style>
</head>
<body>
<div id='imgloading' style="display:none;">
<img src="<%=ApplicationParams.getAppUrl()%>img/processing2.gif"></div>
<form method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="3"
	class="outertable" align="center" id="idtable">
	<tr>
		<td width="100%">
		
		<div class="mainNav">
	       <ul class="navIcon">
	       <li><a  class="setup bg-yellow" href="javascript:getMailBox('P')"> Retail  </a></li>
	       <li><a  class="setup bg-green" href="javascript:getMailBox('A')">  Agriculture  </a></li>
	       <li><a  class="setup bg-orange" href="javascript:getMailBox('C')">  Corporate  </a></li>
	       <li><a  class="setup bg-blue" href="javascript:getMailBox('J')">  Gold & Deposit  </a></li>
	       <li><a  class="setup bg-blue" href="javascript:getMailBox('D')"> Permission  </a></li>
	       <li><a  class="setup bg-blue" href="javascript:getMailBox('F')"> Only for Rating  </a></li>
	       <li><a  class="setup bg-blue" href="javascript:getMailBox('S')"> Solvency  </a></li>
	       <li><a  class="setup bg-blue" href="javascript:getMailBox('K')"> K-Power  </a></li>
	       </ul></div>
		</td>
	</tr>
</table>
<input type="hidden" name="optformtype">
<lapschoice:hiddentag pageid='<%=PageId%>'/>
</form>
</body>
</html>