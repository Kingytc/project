<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="java.net.InetAddress" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<lapschoice:handleerror />
<html>
<head>
<script>
function callLogout()
	{
		try
		{
			parent.window.opener.reloadfunc();
			parent.window.close();
		}
		catch(e)
		{
			
		}	

	}
</script>
<%
	String strUserId = Helper.correctNull((String)hshValues.get("usr_id")).trim();
	String strOrgCode = Helper.correctNull((String)hshValues.get("usr_orgcode")).trim();
	String strGroupRights = Helper.correctNull((String)hshValues.get("grp_rights")).trim();
	String strUserClass = Helper.correctNull((String)hshValues.get("usr_class")).trim();
	String strOrgName = Helper.correctNull((String)hshValues.get("org_name")).trim();
	String strOrgLevel = Helper.correctNull((String)hshValues.get("org_level")).trim();
	String strOrgShortCode = Helper.correctNull((String)hshValues.get("org_scode")).trim();
	String strUserName = Helper.correctNull((String)hshValues.get("usr_name")).trim();
	String strIsSaral=Helper.correctNull((String)hshValues.get("issaral"));
	String strClientIP=Helper.correctNull((String)request.getRemoteAddr());
	InetAddress thisip = InetAddress.getLocalHost();
	strClientIP=thisip.getHostAddress();
	String irb_desc=Helper.correctNull((String)hshValues.get("irb_desc"));
	String strSolid=Helper.correctNull((String)hshValues.get("solid"));
	String strONLINELAPS=Helper.correctNull((String)hshValues.get("ONLINELAPS"));
	String strGrpPrivilege=Helper.correctNull((String)hshValues.get("grp_privilege"));
	String strUserDepartment=Helper.correctNull((String)hshValues.get("usr_department")).trim();
	String strUserGrpId = Helper.correctNull((String)hshValues.get("usr_grpid")).trim();
	String strUserDesignation = Helper.correctNull((String)hshValues.get("user_designation")).trim();
	String strNPA = Helper.correctNull((String)hshValues.get("NPA")).trim();
	String strFVC = Helper.correctNull((String)hshValues.get("FVC")).trim();
	String strNSDL = Helper.correctNull((String)hshValues.get("NSDL")).trim();
	String strKalypto = Helper.correctNull((String)hshValues.get("strKalyptoAddress")).trim();
	String strRLPFUser = Helper.correctNull((String)hshValues.get("usr_rlpftype"));
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
	session.setAttribute("strIsSaral",strIsSaral);
	session.setAttribute("strSolid",strSolid);
	session.setAttribute("irb_desc",irb_desc);
	session.setAttribute("strGrpPrivilege",strGrpPrivilege);
	session.setAttribute("strONLINELAPS",strONLINELAPS);
	session.setAttribute("hidlogincount",Helper.correctNull((String)hshValues.get("hidlogincount")));
	session.setAttribute("strUserDepartment",strUserDepartment);
	session.setAttribute("strUserGrpId",strUserGrpId);
	session.setAttribute("strUserDesignation",strUserDesignation);
	session.setAttribute("NPA",strNPA);
	session.setAttribute("FVC",strFVC);
	session.setAttribute("NSDL",strNSDL);
	session.setAttribute("strKalypto",strKalypto);
	session.setAttribute("strRLPFUser",strRLPFUser);
	session.setAttribute("strPwdExpiryDate",Helper.correctNull((String)hshValues.get("strPwdExpiryDate")));
	session.setAttribute("strPwdExpiryDays",Helper.correctNull((String)hshValues.get("strPwdExpiryDays")));
	session.setAttribute("strlastlogindate",strlastlogindate);
	session.setAttribute("strlastlogoutdate",strlastlogoutdate);
	session.setAttribute("RRM",strRRM);
	session.setAttribute("SHG",strSHG);

	String val = request.getParameter("val");
	
	response.addHeader("P3P","CP=\"IDC DSP COR ADM DEVi TAIi PSA PSD IVAi IVDi CONi HIS OUR IND CNT\"");
	response.addHeader("X-UA-Compatible","IE=EmulateIE8");
	response.setHeader("Cache-Control", "no-cache, no-store"); // HTTP 1.1.
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
    response.setHeader("Expires", "0");
    
	
    response.addHeader("X-Frame-Options", "SAMEORIGIN");
    response.addHeader("Content-Security-Policy", "frame-ancestors 'self';");
    response.setHeader("Strict-Transport-Security","max-age=31536000;includeSubdomains"); 
    response.setHeader("X-XSS-Protection", "1; mode=block");
    response.addHeader("X-Content-Type-Option", "nosniff");
	if(val!=null && val.equals("exit"))
	{
		%>
		<script>
		callLogout();
		</script>
		<%
	}
%>
<script>
var authenticate = "<%=Helper.correctNull((String)hshValues.get("authenticate"))%>";
var sucess = "<%=Helper.correctNull((String)hshValues.get("sucess"))%>";
var purge = "<%=Helper.correctNull((String)hshValues.get("Purge"))%>";
var FromWhichPage ="<%=Helper.correctNull((String)hshValues.get("FromWhichPage"))%>";
var PurgeUser ="<%=Helper.correctNull((String)hshValues.get("PurgeUser"))%>";
var Passwords ="<%=Helper.correctNull((String)hshValues.get("Passwords"))%>";
var DeleteUserid ="<%=Helper.correctNull((String)hshValues.get("DeleteUserid"))%>";
var strResetFlg = "<%=Helper.correctNull((String)hshValues.get("strResetFlg"))%>";
var strPasswordAge = "<%=Helper.correctNull((String)hshValues.get("password_age"))%>";
var varLockFlag = "<%=Helper.correctNull((String)hshValues.get("boolLockFlag"))%>";
var varUserID = "<%=Helper.correctNull((String)hshValues.get("strUserID"))%>";
var varUserExceed = "<%=Helper.correctNull((String)hshValues.get("strUserExceedFlag"))%>";
var varUserPermitted = "<%=Helper.correctNull((String)hshValues.get("strPermittedUser"))%>";
<%
session.setAttribute("c_password",hshValues.get("c_password"));
%>
var bstate = false;
function Redirect()
{	
	if(FromWhichPage == "LoginPage" || FromWhichPage == "PurgeUser")
	{
		if(FromWhichPage == "LoginPage")
		{
			if(authenticate == "" && sucess == "" && purge == "" && strResetFlg != "Y" && strPasswordAge != "Y" && varLockFlag!="true" && varUserExceed!="Y")
			{
				bstate = true;
			}
			else if(authenticate == "Grp")
			{
				bstate = false;
				alert("User don't have Group Rights to access LAPS");	
			}
			else if(authenticate =="User Account Locked")
			{
				bstate = false;
				alert("Your account has been locked. Please contact administrator");
				//document.forms[0].strSelfSAC.value="Y";
				//document.forms[0].USERID.value=varUserID;
				document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/login.jsp";
				document.forms[0].submit();
				//window.close();
			}
			else if(authenticate !="")
			{
				bstate = false;
				alert("Invalid User Name / Password");
				//document.forms[0].strSelfSAC.value="Y";
				//document.forms[0].USERID.value=varUserID;
				//window.opener.document.forms[0].txtusr_id.value="";
				//window.opener.document.forms[0].txtusr_password.value="";
				document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/login.jsp";
				document.forms[0].submit();
				//window.close();
			}
			else if(strResetFlg=="Y")//Password Reset Flag ...by.*venu
			{
				bstate = false;
				alert("Your Password has been reset! Please Change your Password");
		   	}
			else if(strPasswordAge == "Y")
		   	{
		   	    bstate = false;
		   	    alert("Your Password has been expired! Please change your Password");
		   	}
			else if(purge !="")
			{
				bstate = false;
				alert("User Already Exist Please Purge");
			}
			else if(varUserExceed=="Y")
			{
				alert("User Login restricted. Only "+varUserPermitted+" User/s allowed to Login in this organisation");
				bstate = false;
			}
			else if(varLockFlag !="")
			{
				if(confirm("User already logged in. Do you want to SAC yourself?"))
				{
					alert("Existing Session has been Expired, Please login again");
					document.forms[0].strSelfSAC.value="Y";
					document.forms[0].USERID.value=varUserID;
					document.forms[0].hidPage.value="Navigation";
					document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/login.jsp";
					document.forms[0].submit();
					//window.close();
				}
				else
				{
					bstate = false;
					//alert("User already logged in. Use \"SAC\" option to unlock the user");
				}
			}
		}
		if(bstate == false)
		{
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/login.jsp";
			document.forms[0].submit();
		}
		else
		{
			if(PurgeUser=="Purged")
			{
				alert("Your previous session has been terminated....");
			}
    		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/frame.jsp";
			document.forms[0].submit();
		}
	}
	else if(FromWhichPage == "ChangePassword")
	{
		if(Passwords == "NotCorrected")
		{
			bstate = false;
			alert("Problem In Change the Password");
		}
		else if(authenticate == "Grp")
		{
			bstate = false;
			alert("User don't have Group Rights to access LAPS");	
		}
		else if(authenticate !="")
		{
			bstate = false;
			alert("Invalid User Name / Old Password");
		}
		else
		{
			bstate = true;

		}
		if(bstate)
		{
			alert("Your Password is Changed.. Please Login Again !!");
			window.opener.document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/login.jsp";
			window.opener.document.forms[0].target="_parent";
			window.opener.document.forms[0].submit();
			window.close();
			
		}
		else
		{
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/changepassword.jsp";
			document.forms[0].submit();
			
		}
	}
	else if(FromWhichPage == "Navigation")
	{
	
		if(DeleteUserid == "")
		{
			bstate = false;
			alert("Problem In Exit ");
		}
		else if(DeleteUserid != "")
		{
			bstate = true;
			
		}
		if(bstate)
		{
			document.forms[0].target='_parent';
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/login.jsp";
			document.forms[0].submit();
			
		}

			
	}


}
function WinClose()
		{
			parentwin = window.self;           // Make handle for current window named "parentwin"
			parentwin.opener = window.self;    // Tell current window that it opened itself
			parentwin.close();                 // Close window's parent (e.g. the current window)
			return true;
		}

</script>
</head>
<body onLoad ="Redirect()">
<form name="hidlogin" method="post">
<input type="hidden" name="hidlogincount" value="<%=Helper.correctNull((String)hshValues.get("hidlogincount"))%>">
<input type="hidden" name="strSelfSAC">
<input type="hidden" name="USERID">
<input type="hidden" name="hidPage">
</form>
</body>
</html>


