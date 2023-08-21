<%@ page import="com.sai.laps.helper.*" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>

<lapschoice:handleerror />
<%
	String grpRights = (String)session.getAttribute("strGroupRights");
	session.setAttribute("pageType","New");
	
	session.setAttribute("strAppid","");
	session.removeAttribute("strAppid");
	String strFormType=Helper.correctNull((String)request.getParameter("strFormType"));
	if(!strFormType.equals(""))
	{
			session.setAttribute("strFormType",strFormType);
	}
	String strloanname=strFormType;
%>

<HTML>
<HEAD>
<TITLE>NSDL  Navigation</TITLE> <META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1"> 
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>

<script language="JavaScript">
var grpRights = "<%=session.getAttribute("strGroupRights")%>";
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";


function callNSDLReceive(pagename)
{
	document.forms[0].hidBeanId.value="nsdl";
	document.forms[0].hidBeanGetMethod.value="getNSDLApplications";
	document.forms[0].action = appURL+"action/"+pagename;
	document.forms[0].submit();
}

function callNSDLReallocation(pagename)
{
	document.forms[0].hidBeanId.value="nsdl";
	document.forms[0].hidBeanGetMethod.value="getNSDLReallocation";
	document.forms[0].action = appURL+"action/"+pagename;
	document.forms[0].submit();
}
function callFunction(pagename)
{
	
	document.forms[0].hidBeanId.value="nsdl";
  document.forms[0].hidBeanGetMethod.value="getnsdlReport";
  document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+pagename;
  document.forms[0].submit();
}
</script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/headmenu.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/keytrap.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/imageload.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/menudropdown.js"></script>
<!-- This script is used for Home buttons - start -->
<script type="text/JavaScript">

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0

  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}

function callclose()
{
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/mainnav.jsp";
	document.forms[0].submit();
}
function showCount()
{
	/*
	var	varQryString = appURL+"action/NsdlCountPopUp.jsp?hidBeanGetMethod=getNsdlCount&hidBeanId=nsdl";	
	var title = "ApplicationStatus";
	var prop = "scrollbars=no,width=600,height=450";	
	prop = prop + ",left=200,top=150";
	window.open(varQryString,title,prop);*/

	var maskHeight = $(document).height();  
	var maskWidth = $(document).width();
	var dialogTop =  ((maskHeight/3) - ($('#popup-box').height()));  
	var dialogLeft = ((maskWidth/2) - ($('#popup-box').width()/2)); 
	$("#popup-overlay").css({filter:'alpha(opacity=95)'});
	$('#popup-overlay').css({height:maskHeight, width:maskWidth}).show();
	$('#popup-box').css({top:dialogTop, left:dialogLeft}).show('slow');
	$("#popup-box").load(appURL+"action/NsdlCountPopUp.jsp",{hidBeanId:'nsdl',hidBeanGetMethod:'getNsdlCount'});
	
}
function showCountCanara()
{
	/*
	var	varQryString = appURL+"action/NsdlCountPopUp.jsp?hidBeanGetMethod=getNsdlCount&hidBeanId=nsdl";	
	var title = "ApplicationStatus";
	var prop = "scrollbars=no,width=600,height=450";	
	prop = prop + ",left=200,top=150";
	window.open(varQryString,title,prop);*/

	var maskHeight = $(document).height();  
	var maskWidth = $(document).width();
	var dialogTop =  ((maskHeight/3) - ($('#popup-box').height()));  
	var dialogLeft = ((maskWidth/2) - ($('#popup-box').width()/2)); 
	$("#popup-overlay").css({filter:'alpha(opacity=95)'});
	$('#popup-overlay').css({height:maskHeight, width:maskWidth}).show();
	$('#popup-box').css({top:dialogTop, left:dialogLeft}).show('slow');
	$("#popup-box").load(appURL+"action/NsdlCountPopUpCanara.jsp",{hidBeanId:'nsdl',hidBeanGetMethod:'getNsdlCountCanara'});
	
}
function generateXMLResponseFiles()
{
	document.all.downloadresponse.src = appURL+"action/iframeNSDLDownloadCheck.jsp?hidBeanGetMethod=generateXMLResponseFiles&hidBeanId=nsdl";
}
function generateXMLResponseFilesCanara()
{
	document.all.downloadresponse.src = appURL+"action/iframeNSDLDownloadCheck.jsp?hidBeanGetMethod=generateXMLResponseFilesCanara&hidBeanId=nsdl";
}
function showXMLResponseFiles()
{
	var	varQryString = appURL+"action/NsdlXMLShowPopUp.jsp?hidBeanGetMethod=ShowXMLResponseFiles&hidBeanId=nsdl";	
	var title = "ApplicationShowStatus";
	var prop = "scrollbars=yes,width=600,height=450";	
	prop = prop + ",left=200,top=150";
	window.open(varQryString,title,prop);

}
function callStatusAlert(val)
{	
	if(val.length>0){
		alert(val);
	}else{
		alert("Response Download Failed");
	}
}
</script>
<!-- This script is used for Home buttons  - end-->
<link rel="stylesheet"	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<link rel="stylesheet"	href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css"	type="text/css">
<style>
.announce_container
{
	width: 100%;
	height: 80px;
	overflow: auto;
}
</style>
</HEAD>

<BODY onLoad="onNavLoad(appURL,'vidyalakshmi.jpg')">
	<div id="ie5menu" class="skin0" onMouseover="highlightie5()" onMouseout="lowlightie5()" onClick="jumptoie5()"> 
  <div class="menuitems" >
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
<form name="navigation" method="post">
<br> <br>
<div id="popup-overlay" style="width:250px;height:500px;position: absolute">
  					<div id="popup-box" style="display:none;"> </div>
  					</div>
<table width="100%" border="0" cellspacing="0" cellpadding="0"> <tr> <td class="topstripcolor">&nbsp;</td></tr> 
<tr> <td class="bottomstripcolor">&nbsp;</td></tr> 
    <tr> 
      <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#FFFFFF" align="center" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF">
          <tr> 
            <td width="53%" align="center"> <br>
              <TABLE WIDTH="30%" BORDER="0" CELLSPACING="0" CELLPADDING="4" ALIGN="center"  id="setup_style">
					<TR>
					<td align="center"><a href="javascript:callNSDLReceive('NsdlRecvapplication.jsp');"><b>National Portal Applications</b></a></td>
					</TR> 
						<%if(Helper.correctNull((String)session.getAttribute("strOrgLevel")).equalsIgnoreCase("C") || Helper.correctNull((String)session.getAttribute("strOrgLevel")).equalsIgnoreCase("R")){ %>
					<TR>
					<td align="center"><a href="javascript:callNSDLReallocation('nsdlapplicationsearch.jsp')"><b>National Portal Application Reallocation</b></a></td>
					</TR> 
					<%} %>					
					<%if(Helper.correctNull((String)session.getAttribute("strOrgLevel")).equalsIgnoreCase("C")){ %>
					<TR>
					<td align="center"><a href="javascript:showCount()"><b>National Portal Response Upload (e-Synd)</b></a>
					
					</td>
					</TR>	
					<%} %>	
					<TR>
					<%if(Helper.correctNull((String)session.getAttribute("strOrgLevel")).equalsIgnoreCase("C")){ %>
					<TR>
					<td align="center"><a href="javascript:showCountCanara()"><b>National Portal Response Upload (Canara)</b></a>
					
					</td>
					</TR>	
					<%} %>	
					<TR>
					<td align="center">
					<a href="JavaScript:callFunction('nsdlreports.jsp')"><b>Reports</b></a> 
					</td>
					</TR>		

              </TABLE>
            
             <br>  </td>
            
          </tr>
        </table>
      </td>
    </tr>
    <tr> <td class="topstripcolor">&nbsp;</td></tr> 
	<tr> <td class="bottomstripcolor">&nbsp;</td></tr> 
  </table>
  <br>
  <table border="0" cellspacing="0" cellpadding="0" align="center">
	<tr valign="middle">
		<td><input type="button" name="cmdclose" value="Close" style="width:50"
			class="buttoncolorclose" onClick="callclose();"></td>
	</tr>
	
</table>

<iframe height="0" width="0" id="downloadresponse" frameborder=0 style="border: 0"></iframe> 
<input type="hidden" name="hidPage" value=""> 
<input type="hidden" name="hidusr_id" value=""> 
<input type="hidden" name="hidPageType" value="">
<input type="hidden" name="hidBeanId" value="">
<input type="hidden" name="hidBeanMethod" value="">
<input type="hidden" name="hidBeanGetMethod" value="">
<input type="hidden" name="hidSourceUrl" value ="">
<input type="hidden" name="hidReallocationFlag" value="">  
 
</form>
	<script type="text/javascript" src="<%=ApplicationParams.getAppUrl()%>js/bounceSlider/jquery-1.2.6.min.js"></script>
<script type="text/javascript" src="<%=ApplicationParams.getAppUrl()%>js/bounceSlider/jquery-ui-personalized-1.5.2.packed.js"></script>
<script type="text/javascript" src="<%=ApplicationParams.getAppUrl()%>js/bounceSlider/sprinkle.js"></script>

</BODY>

</HTML>
