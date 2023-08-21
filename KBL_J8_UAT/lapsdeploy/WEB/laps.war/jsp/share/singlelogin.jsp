<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="java.net.InetAddress" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<lapschoice:handleerror />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<%
	String strUserId = Helper.correctNull((String)hshValues.get("usr_id")).trim();
	String strOrgCode = Helper.correctNull((String)hshValues.get("usr_orgcode")).trim();
	String strGroupRights = Helper.correctNull((String)hshValues.get("grp_rights")).trim();
	String strUserClass = Helper.correctNull((String)hshValues.get("usr_class")).trim();
	String strOrgName = Helper.correctNull((String)hshValues.get("org_name")).trim();
	String strOrgLevel = Helper.correctNull((String)hshValues.get("org_level")).trim();
	String strOrgShortCode = Helper.correctNull((String)hshValues.get("org_scode")).trim();
	String strUserName = Helper.correctNull((String)hshValues.get("usr_name")).trim();
	String strUserDepartment=Helper.correctNull((String)hshValues.get("usr_department")).trim();
	String strUserDesignation = Helper.correctNull((String)hshValues.get("user_designation")).trim();
	String strNPA = Helper.correctNull((String)hshValues.get("NPA")).trim();
	String strFVC = Helper.correctNull((String)hshValues.get("FVC")).trim();
	String strNSDL = Helper.correctNull((String)hshValues.get("NSDL")).trim();
	String strKalypto = Helper.correctNull((String)hshValues.get("strKalyptoAddress")).trim();

	//String strIsSaral=Helper.correctNull((String)hshValues.get("issaral"));
	String strClientIP=Helper.correctNull((String)request.getRemoteAddr());
	InetAddress thisip = InetAddress.getLocalHost();
	strClientIP=thisip.getHostAddress();
	//String irb_desc=Helper.correctNull((String)hshValues.get("irb_desc"));
	String strSolid=Helper.correctNull((String)hshValues.get("solid"));
	//String strONLINELAPS=Helper.correctNull((String)hshValues.get("ONLINELAPS"));
	String strGrpPrivilege=Helper.correctNull((String)hshValues.get("grp_privilege"));
	String strStatus=Helper.correctNull((String)hshValues.get("strStatus"));
	String strLoginType=Helper.correctNull((String)hshValues.get("strLoginType"));
	String strUserGrpId = Helper.correctNull((String)hshValues.get("usr_grpid")).trim();
	String strRLPFUser = Helper.correctNull((String)hshValues.get("usr_rlpftype"));
	String val = request.getParameter("val");
	String strlastlogindate = Helper.correctNull((String)hshValues.get("LAST_LOGINDATE")).trim();
	String strlastlogoutdate = Helper.correctNull((String)hshValues.get("LAST_LOGOUTDATE")).trim();
	String strRRM = Helper.correctNull((String)hshValues.get("RRM")).trim();
	String strSHG = Helper.correctNull((String)hshValues.get("SHG")).trim();

	String strOrgSelect="";
	if (strOrgLevel.equalsIgnoreCase("C"))
	{
		strOrgSelect=strOrgCode.substring(0,3);
	}
	else if (strOrgLevel.equalsIgnoreCase("R"))
	{
		strOrgSelect=strOrgCode.substring(0,6);
	}
	else if (strOrgLevel.equalsIgnoreCase("D"))
	{
		strOrgSelect=strOrgCode.substring(0,9);
	}
	else if (strOrgLevel.equalsIgnoreCase("A"))
	{
		strOrgSelect=strOrgCode.substring(0,12);
	}
	else if (strOrgLevel.equalsIgnoreCase("B"))
	{
		strOrgSelect=strOrgCode.substring(0,15);
	}
	if(strGroupRights.length()==16)
	{
		 if((strGroupRights.charAt(0) == '1' )){
			 strGroupRights=strGroupRights.concat("1111");
		 }
		 else
		 {
			 strGroupRights=strGroupRights.concat("1110");
		 }
	}
	else if(strGroupRights.length()==19)
	{
		if((strGroupRights.charAt(0) == '1' )){
			strGroupRights=strGroupRights.concat("1");
		}
		else
		{
			strGroupRights=strGroupRights.concat("0");
		}
	}
	session.setAttribute("strUserId",strUserId);
	session.setAttribute("strOrgCode",strOrgCode);
	session.setAttribute("strGroupRights",strGroupRights);
	session.setAttribute("strUserClass",strUserClass);
	session.setAttribute("strOrgName",strOrgName);
	session.setAttribute("strOrgLevel",strOrgLevel);
	session.setAttribute("strOrgShortCode",strOrgShortCode);
	session.setAttribute("strUserName",strUserName);
	session.setAttribute("strClientIP",strClientIP);
	session.setAttribute("strOrgSelect",strOrgSelect);
	//session.setAttribute("strIsSaral",strIsSaral);
	session.setAttribute("strSolid",strSolid);
	//session.setAttribute("irb_desc",irb_desc);
	session.setAttribute("strGrpPrivilege",strGrpPrivilege);
	//session.setAttribute("strONLINELAPS",strONLINELAPS);
	session.setAttribute("hidlogincount",Helper.correctNull((String)hshValues.get("hidlogincount")));
	session.setAttribute("Logintype","NL");
	session.setAttribute("strUserDepartment",strUserDepartment);
	session.setAttribute("strUserGrpId",strUserGrpId);
	session.setAttribute("strUserDesignation",strUserDesignation);
	session.setAttribute("NPA",strNPA);
	session.setAttribute("FVC",strFVC);
	session.setAttribute("NSDL",strNSDL);
	session.setAttribute("strKalypto",strKalypto);
	session.setAttribute("strRLPFUser",strRLPFUser);
	session.setAttribute("RRM",strRRM);
	session.setAttribute("SHG",strSHG);
%>
<script type="text/javascript">

var FromWhichPage ="<%=Helper.correctNull((String)hshValues.get("FromWhichPage"))%>";
var varLockFlag = "<%=Helper.correctNull((String)hshValues.get("boolLockFlag"))%>";
var varUserID = "<%=Helper.correctNull((String)hshValues.get("strUserID"))%>";
var varUserExceed = "<%=Helper.correctNull((String)hshValues.get("strUserExceedFlag"))%>";
var varUserPermitted = "<%=Helper.correctNull((String)hshValues.get("strPermittedUser"))%>";
function Redirect()
{

	var varStatus='<%=strStatus%>';
	var val='<%=val%>';	
	if(FromWhichPage == "Navigation")
	{
		if(val=="exit")
		{
			top.close();
			return;
		}
	}
	else
	{
		if(varUserExceed=="Y")
		{
			alert("User Login restricted. Only "+varUserPermitted+" User/s allowed to Login in this organisation");
			window.open('','_self');
			window.close();
			return;
		}
		else if(varStatus=="success")
		{
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/frame.jsp";
			document.forms[0].submit();
		}
		else if(varLockFlag =="true")
		{
			if(confirm("User already logged in. Do you want to SAC yourself?"))
			{
				alert("Existing Session has been Expired, Please login again");
				document.forms[0].strSelfSAC.value="Y";
				document.forms[0].USERID.value=varUserID;
				document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/login.jsp";
				document.forms[0].submit();
				window.close();
				
			}
			else
			{
				alert("User already logged in. Use \"SAC\" option to unlock the user");
				window.open('','_self');
				window.close();
				return;
			}
			
		}
		else
		{
			alert("Kindly Login into Finacle before login to LAPS");
			window.open('','_self');
			window.close();
			return;
		}
	}

}

</script>
</head>

<body onLoad ="Redirect()">
<form action="" method="post">
<input type="hidden" name="hidlogincount" value="<%=Helper.correctNull((String)hshValues.get("hidlogincount"))%>">
<input type="hidden" name="strSelfSAC">
<input type="hidden" name="USERID">
</form>
</body>
</html>