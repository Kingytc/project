<%@ page import="com.sai.laps.helper.*" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>KARNATAKA BANK LTD.</title>
<style type="text/css">
<!--
body, td, th
		{
		margin:0;
		font-family:"Times New Roman", Times, serif;
		font-size:11px;
		}

#grid
		{
		/*width:1004px;*/
		margin:0;
		}
#hdr
		{
		/*width:1004px;*/
		margin:5px 18 0 18;
		background-color:#fff;
		}
.logo
		{
		/*background-image:url(images/ubi_newlogo.jpg);*/
		height:64px;
		width:201px;
		position:absolute;
		left: 87px;
		top: 64px;
			}
a:link,   {
	color: #5ea3d5;
	text-decoration: underline;
	font-family:"Times New Roman", Times, serif;
		font-weight:bold;
		font-size:30px;
	}
a:hover, a:active, a:visited {
	color: #003366;
	text-decoration: underline;
	font-family:"Times New Roman", Times, serif;
		font-weight:bold;
		font-size:30px;
}

-->
</style>
<script>
function callRAMF()
{   alert('This is exclusive for BM to finalize rating for the propsal falling under DA of Branch');
	var req="<%=Helper.correctNull((String)session.getAttribute("irb_desc"))%>";
	var request1=req.toLowerCase();
	if(request1!="")
	{
		var win=window.open(request1+"?UserName=<%=(String)session.getAttribute("c_username")+"f"%>");
	}
	else
	{
		alert("Specify IP address in Static data Master");
	}
}
function callRAM()
{
	var req="<%=Helper.correctNull((String)session.getAttribute("irb_desc"))%>";
	var request1=req.toLowerCase();
	if(request1!="")
	{
		var win=window.open(request1+"?UserName=<%=(String)session.getAttribute("c_username")%>");
	}
	else
	{
		alert("Specify IP address in Static data Master");
	}
}
function reloadfunc()
{
document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/login.jsp";
document.forms[0].submit();

}

function callLAPS()
{
	var varwidth=screen.width;
	var varheight=screen.height;
	var varparams="left=0,top=0,scrollbars=yes,status=1,menubar=yes,resizable=1,location=0,toolbar=0";
	window.open("<%=ApplicationParams.getAppUrl()%>action/frame.jsp","UBILAS",varparams);
}

</script>
</head>

<body>
<form>
<table border="0" width="80%" align="center" cellpadding="4">
	<tr>
		<td>&nbsp;</td>
	</tr>
		<tr>
		<td>&nbsp;</td>
	</tr>
	
		<tr>
		<td>&nbsp;</td>
	</tr>
	
	<tr>
	
		<td valign="middle"><img src="<%=ApplicationParams.getAppUrl()%>img/ubi_newlogo.jpg" /></td>
	</tr>
		<tr>
		<td>&nbsp;</td>
	</tr>
	
		<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td valign="bottom">
		<table border="0" width="80%" class="outertable border1" cellpadding="4">

			<tr>
				<td width="100%" colspan="2" align="center"><a
					href="javascript:callLAPS()">Loan Processing</a></td>
			</tr>
			<tr>
				<td width="50%" align="center"><a href="javascript:callRAM()">I R B</a></td>
				<td width="50%" align="center"><a href="javascript:callRAMF()">I R B
				-F</a>FOR BM (case for Corporate SME &amp; Tertiary)</td>
			</tr>
			
		</table>
		</td>
	</tr>
</table>
</form>
</body>
</html>
