<%@ page import="com.sai.laps.helper.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<lapschoice:handleerror />
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />

<html>
<head>
<title>LAPS</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%
	String LoginType=Helper.correctNull((String)session.getAttribute("Logintype"));
	String strImageEnable=ApplicationParams.getImageEnabled();

	String topframe="";
	if(strImageEnable.equalsIgnoreCase("Y"))
	{
		topframe="topframe";
	}
	else
	{
		topframe="topframeNOIMG";
	}
	String strRLPFFlag=Helper.correctNull((String)session.getAttribute("strRLPFUser"));
	if(strRLPFFlag.equalsIgnoreCase("012"))
		strRLPFFlag="CLPH";
	else if(strRLPFFlag.equalsIgnoreCase("999"))
		strRLPFFlag="CLPU";
	else
		strRLPFFlag="";
	
	String strTemp="";
	
	String strExpiryDate=Helper.correctNull((String)session.getAttribute("strPwdExpiryDate"));
	int intDateDiff=Integer.parseInt(Helper.correctInt((String)session.getAttribute("strPwdExpiryDays")));
	
	
	if(intDateDiff>1)
	{
		strTemp=intDateDiff+" days";
	}
	else
	{
		strTemp=intDateDiff+" day";
	}
	
	
%>
<style>
 body{
	margin: 0;
    padding: 0;
  
    font-weight: normal;
    font-family: 'Trebuchet MS';
} 
body td{
font-size: 13px; 
}
.topframeNOIMG{
	height: 90px;
    width: 100%;
    color: #fff !important;
    background: #942188;
    background: -moz-linear-gradient(-45deg, #942188 83%, #ffffff 83%, #ffffff 100%);
    background: -webkit-linear-gradient(-45deg, #942188 83%,#ffffff 83%,#ffffff 100%);
    background: linear-gradient(135deg, #942188 83%,#ffffff 83%,#ffffff 100%);
    filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#942188', endColorstr='#ffffff',GradientType=1 );
    border-bottom: 1px solid #942188;
}/*background:url(../img/topframeBg.gif) right top no-repeat #942188;*/
.topframe{height:90px; background:url(../img/topframeBg.gif) right top no-repeat #942188; ;width:100%;color:#fff !important;}/*background:url(../img/topframeBg.gif) right top no-repeat #942188;*/
.bgColor {
    background: #eccbe8;
}
.iconCir {
    display: inline-block;
    background: #8d61aa;
    width: 30px;
    height: 30px;
    border-radius: 50%;
    text-align: center;
}
.iconCir img {
    padding-top: 3px;
}
.smallHeader td {
    /* font-size: 12px; */
    padding: 2px;
}
.verColor {
    color: #942188;
    font-weight: bold;
}
.textAlert {
    color: red;
}
.pageHdr {
    /* font-size: 16px; */
    font-weight: bold;
    color: #fff;
}
.pageUser {
    font-size: 13px;
    font-weight: normal;
    color: #fff;
}
.imgRight-head img{ 
margin-right:20px;
}
.padleft{
	padding-left: 10px;
}
span#titleimg {
    font-size: 16px;
}
@media (max-width:1024px){
	.smallHeader td {
		/* font-size: 10px !important; */
	}
	.imgRight-head img{
		margin-right: -15px !important;	}
	}
</style>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
	<script 
	src="<%=ApplicationParams.getAppUrl()%>js/share/jquery.js"></script>
	<script 
	src="<%=ApplicationParams.getAppUrl()%>js/share/custom.js"></script>
<script language="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";

function MM_reloadPage(init) {  //reloads the window if Nav4 resized
  if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
    document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
}
function callHome()
{
	document.forms[0].action=appURL+"action/mainnav.jsp";
	document.forms[0].target="mainFrame";
	document.forms[0].submit();	
}
function callLogout()
{
	var logintype='<%=LoginType%>';
	if(logintype=="NL")
	{
		document.forms[0].hidPage.value = "Navigation";
		document.forms[0].hidusr_id.value = "<%=session.getAttribute("strUserId")%>";
		document.forms[0].action=appURL+"action/singlelogin.jsp?val=exit";
		document.forms[0].submit();	
	}
	else
	{
		document.forms[0].hidPage.value = "Navigation";
		document.forms[0].hidusr_id.value = "<%=session.getAttribute("strUserId")%>";
		document.forms[0].action=appURL+"action/hidlogin.jsp?val=exit";
		document.forms[0].submit();	
	}
}
MM_reloadPage(true);

function callUnLoad()
{
	callLogout()
}
//window.onunload= function(){callUnLoad();}

// -->







</script>
</head>

<body bgcolor="#EEEAE3" text="#000000" leftmargin="0" topmargin="0"
	marginwidth="0" marginheight="0">

<div id="ie5menu" class="skin0" onMouseover="highlightie5()" onMouseout="lowlightie5()" onClick="jumptoie5()"> 
	<div class="menuitems" url="">
    	<script language="JavaScript1.2">
			if (document.all && window.print)
				{
				ie5menu.className = menuskin;
				document.oncontextmenu = showmenuie5;
				document.body.onclick = hidemenuie5;
				}
		</script>
	</div>
</div>

<form name="colForm" method="post">
<table width="100%" border="0" cellspacing="0" cellpadding="0"  class="<%=topframe%>">
  <tr>
    <td height="61">
<table width="100%" border="0" cellspacing="0" cellpadding="0" >
  <tr>
    <td>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="left" valign="middle"><img src="<%=ApplicationParams.getAppUrl()%>img/karnatakaLogo_hdr.png" alt="Karnataka Bank Logo" style="margin-left:20px;" />
<!--    <td width="22%" align="left" valign="middle"><img src="<%=ApplicationParams.getAppUrl()%>img/ubiLogo.png" alt="Karnataka Bank Logo" style="margin-left:20px;" />-->
    	
    </td>
    <td >
<table width="80%" border="0" cellspacing="0" cellpadding="5" align="center" style="margin:0 auto;">
  <tr>
    <td class="pageUser">User Name &amp; ID: <%=session.getAttribute("strUserName")%> - [<%=session.getAttribute("strUserId")%>]</td>
  </tr>
  <tr>
    <td class="pageUser">Location : <%=session.getAttribute("strOrgName")%> <%if(!strRLPFFlag.equalsIgnoreCase("")){ %>- [ <%=strRLPFFlag %> ]<%} %></td>
  </tr>
</table>
	</td>
	<td  align="left" class="pageHdr" ><span id="titleimg"></span></td>
    <td  align="right" class="imgRight-head" valign="middle"  ><img src="<%=ApplicationParams.getAppUrl()%>img/hdrLapsLogo.png" alt="Laps Logo" /></td>

  
  </tr>
</table>
	</td>
  </tr>
</table>
</td></tr>
<tr><td>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
 
	<tr class="bgColor">
		<td class="padleft">Fields marked
		with (<b>*</b>) are mandatory.</font></td>
		<td style="color:#8b1c7f"><b>KBL_UAT 6.2.138</b>
		</td>
		<td  >Date: <%=Helper.getCurrentDateTime()%></td>
		<%if(LoginType.equalsIgnoreCase("")){ %>
			<td class="textAlert" nowrap="nowrap">Your password will expire in <%=strTemp %> (<%=Helper.correctNull((String)session.getAttribute("strPwdExpiryDate")) %>)</td>
		<%} %>
		<%if(!Helper.correctNull((String)session.getAttribute("strlastlogindate")).equalsIgnoreCase("")){ %>
		 <td nowrap="nowrap">Last Login: <%=session.getAttribute("strlastlogindate")%></td>
           <%} %>         
         <%if(!Helper.correctNull((String)session.getAttribute("strlastlogoutdate")).equalsIgnoreCase("")){ %>
		 <td  nowrap="nowrap">Last Logout: <%=session.getAttribute("strlastlogoutdate")%></td>
           <%} %>         
		<td ><a class="iconCir" href="javascript:callHome()"><img
			src="<%=ApplicationParams.getAppUrl()%>img/lapstitle/home.png" border="0" alt=""></a>&nbsp;</td>
		<td><a class="iconCir" href="javascript:callLogout()"><img
			src="<%=ApplicationParams.getAppUrl()%>img/lapstitle/logout.png" border="0" alt=""></a>&nbsp;</td>
	</tr>
</table>
</td></tr>

</table>
<input type="hidden" name="hidPage"> 
<input type="hidden" name="hidusr_id" value="<%=Helper.correctNull((String)session.getAttribute("strUserId"))%>">
</form>
</body>
</html>
