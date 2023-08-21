<%@include file="../share/directives.jsp"%>
<%
	ArrayList arrRow=(ArrayList)hshValues.get("arrRow");
	ArrayList arrCol=new ArrayList();	
String strInccount=Helper.correctNull((String)hshValues.get("inccount"));
String strEligInccount=Helper.correctNull((String)hshValues.get("PRD_NOOFAPPLICNTINC"));
String strPrdType=Helper.correctNull((String)hshValues.get("strPrdType"));
String strPageParam = Helper.correctNull(
		(String) session.getAttribute("strModifyterms")).trim();
String strFlag="N";
if(strPageParam.contains("GUAR"))
{
	strFlag="Y";
}
String strGuarantor_check=Helper.correctNull((String)hshValues.get("strGuarantor"));
String strHunterScore = Helper.correctInt(((String) hshValues
		.get("dblHuntScore")));
String strPropNo = Helper.correctNull((String) hshValues
		.get("APP_PERM_NO"));
String strHunterCheck = Helper.correctNull((String) hshValues
		.get("DEV_DEVPARAM"));
String strAppHuntStatus = Helper.correctNull((String) hshValues
		.get("strAppHuntStatus"));
//double dblHunter=Double.parseDouble(Helper.correctDouble((String)hshValues.get("dblHuntScore")));
//out.println(strHunterScore);
String digiGoldFlag = Helper.correctNull((String) session.getAttribute("digiGoldFlag"));
ArrayList arrAppid = new ArrayList();
ArrayList arrAppid1 = new ArrayList();
String StrTemp = "";
StringBuffer strbuff = new StringBuffer();
String temp = "";
String temp1="";
ArrayList arrCol1 = new ArrayList();
ArrayList arrRow1 = new ArrayList();
if (hshValues != null)
	arrRow1 = (ArrayList) hshValues.get("HSCorelist");
if (arrRow1 != null && arrRow1.size() > 0) {
	for (int i = 0; i < arrRow1.size(); i++) {
		arrCol1 = (ArrayList) arrRow1.get(i);
		if (i == 0) {
			temp = temp
					+ Helper.correctNull((String) arrCol1.get(1)
							.toString())
					+ " ("
					+ Helper.correctNull((String) arrCol1.get(0)
							.toString()) + ") ";
		} else {
			temp = temp
					+ " and "
					+ Helper.correctNull((String) arrCol1.get(1)
							.toString())
					+ " ("
					+ Helper.correctNull((String) arrCol1.get(0)
							.toString()) + ") ";

		}
	}
}


ArrayList arrCol12 = new ArrayList();
ArrayList arrRow12 = new ArrayList();
if (hshValues != null)
	arrRow12 = (ArrayList) hshValues.get("HSCorelist");
if (arrRow12 != null && arrRow12.size() > 0) {
	for (int i = 0; i < arrRow12.size(); i++) {
		arrCol12 = (ArrayList) arrRow12.get(i);
		if (i == 0) {
			temp1 = temp1
					+ Helper.correctNull((String) arrCol12.get(1)
							.toString())
					+ " ("
					+ Helper.correctNull((String) arrCol12.get(0)
							.toString()) + ") ";
		} else {
			temp1 = temp1
					+ " and "
					+ Helper.correctNull((String) arrCol12.get(1)
							.toString())
					+ " ("
					+ Helper.correctNull((String) arrCol12.get(0)
							.toString()) + ") ";

		}
	}
}
String flag = "N";
ArrayList arrCol14 = new ArrayList();
ArrayList arrRow14 = new ArrayList();
if (hshValues != null)
	arrRow14 = (ArrayList) hshValues.get("arrCol4");
if (arrRow14 != null && arrRow14.size() > 0) {
	flag = "Y";
}
else
{
	flag = "N";
}

String strcgtmseavail = Helper.correctNull((String)hshValues.get("strcgtmseavail"));
//out.println("hshValues"+hshValues+"sessiontype"+Helper.correctNull((String)session.getAttribute("sessionModuleType")));
%>
<html>
<head>
<title>Personal - CoApplicant/Guarantor</title>
<script>
var includeincome="<%=Helper.correctNull((String)hshValues.get("demo_includeincome"))%>";
var varguarantorincome="<%=Helper.correctNull((String)hshValues.get("PRD_GUARANTOR"))%>";
var varobligantincome="<%=Helper.correctNull((String)hshValues.get("PRD_COOBLIGANT"))%>";
var varjointappincome="<%=Helper.correctNull((String)hshValues.get("PRD_JOINTAPPLICANT"))%>";
var varsoleproperiter="<%=Helper.correctNull((String)hshValues.get("PRD_SOLE_PROPERITER"))%>";
var varFreeze="<%=Helper.correctNull((String)hshValues.get("strFreeze"))%>";
var varSecFreeze="<%=Helper.correctNull((String)hshValues.get("strSecFreezeflag"))%>";
var varInccount="<%=strInccount%>";
var varEligInccount="<%=strEligInccount%>";
var varPrdType="<%=strPrdType%>";
var prodType = "<%=(String)session.getAttribute("strProductType")%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
var varJointCount="<%=Helper.correctInt((String)hshValues.get("strCoappcnt"))%>";
var varGuarantorCount="<%=Helper.correctInt((String)hshValues.get("strGuarcnt"))%>";
var varProperitierCount="<%=Helper.correctInt((String)hshValues.get("strProperitiercnt"))%>";
var varCoobligantcnt="<%=Helper.correctInt((String)hshValues.get("strCoobligantcnt"))%>";
var varPrdPurpose="<%=Helper.correctInt((String)hshValues.get("prd_purpose"))%>";
var varPrdLoanType="<%=Helper.correctInt((String)hshValues.get("prd_loantype"))%>";
var varFlag="<%=strFlag%>";
var varGrpRights="<%=(Helper.correctNull((String)session.getAttribute("strGroupRights"))).charAt(18)%>";
var varGuarantor_check="<%=strGuarantor_check%>";
var varInCompleteID="<%=Helper.correctNull((String)hshValues.get("strInCompleteID"))%>";
var varCoApp_Gua_ID="<%=Helper.correctNull((String)hshValues.get("strCoApp_Gua_ID"))%>";
var varCGTMSE_flag="<%=Helper.correctNull((String)hshValues.get("str_CGTMSEFlag"))%>";
var varNOtRequiredAppid="<%=Helper.correctNull((String)hshValues.get("strNOtRequiredAppid"))%>";
var varNOtRequiredFlag="<%=Helper.correctNull((String)hshValues.get("strNOtRequiredFlag"))%>";
var varStrAppid="<%=temp%>";
var arrRow = "<%=arrRow1.size()%>";

var varStrAppid1="<%=temp1%>";
var arrRow1 = "<%=arrRow12.size()%>";
var strHunterScore="<%=strHunterScore%>";
var strPropNo="<%=strPropNo%>";
var strHunterCheck="<%=flag%>";
var strAppHuntStatus="<%=strAppHuntStatus%>";
var sessionModuleType="<%=(Helper.correctNull((String)session.getAttribute("sessionModuleType")))%>";
var varamberApproved="<%=Helper.correctNull((String)hshValues.get("amberStatus"))%>";
var perappdigiflag="<%=Helper.correctNull((String)hshValues.get("perappdigiflag"))%>";
//vindhya begin
var ExposureChklimit= "<%=Helper.correctNull((String)hshValues.get("strdblExplimit"))%>";
var Explimitchk= "<%=Helper.correctNull((String)hshValues.get("strExplimitchk"))%>";
var varPancount="<%=Helper.correctNull((String)hshValues.get("Pancount"))%>";
var varPanCheck="<%=Helper.correctNull((String)hshValues.get("strPanCheck"))%>";
var Expcheck="<%=Helper.correctNull((String)hshValues.get("strChecklimit"))%>";
//vindhya end
function disablefields()
{
	if(document.forms[0].seltype.value=="c")
	{
		document.forms[0].sel_incomeeligibility.disabled=false;
	}
	else
	{
		document.forms[0].sel_incomeeligibility.disabled=true;
		document.forms[0].sel_incomeeligibility.value="1";
	}
}

function gototab(beanid,methodname,pagename)
{
	//pan check
	if(document.forms[0].freezeflag.value=="Y")
	{
		if(document.forms[0].varPanCheck.value=="Y")
		{ 
			 if(document.forms[0].sessionmodule.value=="RET")
			{
				 if(document.forms[0].Explimitchk.value=="F")
			
				 {
					 if (document.forms[0].varPancount.value=="N")
					{
					 alert("Please obtain PAN number of the Applicants (including co-applicant/Joint borrower/Co-applicant) Co-Obligant/guarantor and capture in CBS for exposure (includes existing and proposed limit) of Rs."+document.forms[0].Expcheck.value+"/- and above ");
						return;
					}	 
				}
			}	 
			
		}
	}
	if(document.forms[0].hideditflag.value=="N")
	{
		document.forms[0].hidBeanId.value=beanid;
		document.forms[0].hidBeanGetMethod.value=methodname;
		document.forms[0].action=appURL+"action/"+pagename;
		document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
	}
}

function callCoAppIDHelp()
{
	if(document.forms[0].hideditflag.value=="Y")
	{
		if(document.forms[0].seltype.value=="S")
		{
			alert("Select Applicant Type");
			return;
		}
		if((varPrdType=="pH" && varPrdPurpose=="T") || varPrdType=="pV")
		{
			if(document.forms[0].seltype.value=="c")
			{
				if(parseFloat(varJointCount)==parseFloat(document.forms[0].txtmaxcoapplicant.value))
				{
					alert("You cannot add any new Co-Applicant for this proposal, Maximum Number of Co-Applicant is "+parseFloat(document.forms[0].txtmaxcoapplicant.value)+" Member/s");
					return;
				}
			}
			else if(document.forms[0].seltype.value=="g")
			{
				if(parseFloat(varGuarantorCount)==parseFloat(document.forms[0].txtmaxguarantor.value))
				{
					alert("You cannot add any new Guarantor for this proposal, Maximum Number of Guarantor is "+parseFloat(document.forms[0].txtmaxguarantor.value)+" Member/s");
					return;
				}
			}
			else if(document.forms[0].seltype.value=="p")
			{
				if(parseFloat(varProperitierCount)==parseFloat(document.forms[0].txtmaxproperitier.value))
				{
					alert("You cannot add any new Properitier for this proposal, Maximum Number of Properitier is "+parseFloat(document.forms[0].txtmaxproperitier.value)+" Member/s");
					return;
				}
			}
			else if(document.forms[0].seltype.value=="o")
			{
				if(parseFloat(varCoobligantcnt)==parseFloat(document.forms[0].txtmaxguarantor.value))
				{
					alert("You cannot add any new Co-obligant for this proposal, Maximum Number of Co-obligant is "+parseFloat(document.forms[0].txtmaxproperitier.value)+" Member/s");
					return;
				}
			}
		}

		if((varPrdType=="pM" && varPrdLoanType=="TL") || (varPrdType=="pA"  && (varPrdPurpose=="N" || varPrdPurpose=="U")))
		{
			if(document.forms[0].seltype.value=="c")
			{
			   if((parseFloat(varJointCount)+1)>parseFloat(document.forms[0].txtmaxcoapplicant.value))
				{
					alert("You cannot add any new Co-Applicant for this proposal, Maximum Number of Co-Applicant is "+parseFloat(document.forms[0].txtmaxcoapplicant.value)+" Member/s");
					document.forms[0].sel_incomeeligibility.value="1";
					document.forms[0].cmdsave.disabled = true;
					document.forms[0].cmdcancel.disabled = false;
				}
			}
		}
		if(document.forms[0].cmdnew.disabled=true)
		{
			var value1=document.forms[0].hidapplicantid.value;	
			var apptype = document.forms[0].seltype.value;
			var prd_cgtmse = document.forms[0].txt_prd_cgtmse.value; 
			var	varQryString = appURL+"action/perapplicantidhelp.jsp?apptype="+apptype+"&appid="+value1+"&prd_cgtmse="+prd_cgtmse+"&PageType=RET";
			var title = "ApplicantIDHelp";
			var prop = "scrollbars=no,width=500,height=500";	
			var xpos = (screen.width - 400) / 2;
			var ypos = (screen.height - 300) / 2;
			prop = prop + ",left="+xpos+",top="+ypos;
			window.open(varQryString,title,prop);
		}
	}
}

function doSave()
{
	var len=document.forms[0].appid.length;
	var id = document.forms[0].hidCoDemoId.value;
	var name= document.forms[0].txtloan_cname.value;
	var rel= document.forms[0].txtrelation.value;
	var bool = false;	
	if(name == "")
	{
		alert("Select CoApplicant/Guarantor Name");
		return;
	}	
	if(rel == "")
	{
		alert("Select Relationship with the Applicant");
		return;
	}	
	if(len==null && id==document.forms[0].appid.value)
	{
		alert("Selected Customer is already attached for this Application");
		document.forms[0].hidCoDemoId.value="";
		bool = true;
		return;
	}
	else
	{
		for(i=0;i<len;i++)
		{
			if(id==document.forms[0].appid[i].value)
			{
				alert("Selected Customer is already attached for this Application");
				document.forms[0].hidCoDemoId.value="";
				bool = true;
				break;
			}
		}			
	}	
	if(document.forms[0].sel_relation_type.value == "0")
	{
		alert("Select Relationship Type");
		document.forms[0].sel_relation_type.focus();
		return;
	}	
	if(document.forms[0].hidCoDemoId.value!="")
	{
		document.forms[0].sel_incomeeligibility.disabled=false;
		document.forms[0].cmdsave.disabled = true;
		document.forms[0].hidBeanGetMethod.value="getCoAppGuarantor";
		document.forms[0].hidBeanMethod.value="updateCoAppGuarantor";
		document.forms[0].hidBeanId.value="perapplicant";
		document.forms[0].action=appURL+"controllerservlet";	
		document.forms[0].hidSourceUrl.value="/action/percoappguarantor.jsp";		
		document.forms[0].submit();
	}		
}

function callCheck()
{
	if(document.forms[0].txtloan_cname.value!="")
	{
		document.all.ifrcoapp.src = appURL+"action/iframecoappgurantor.jsp?hidBeanId=perapplicant&hidBeanGetMethod=getCoAppGuarantorCheck&hidid="+document.forms[0].hidCoDemoId.value;
	}	
}

function checkadd()
{
	document.forms[0].cmdnew.disabled=true;
	document.forms[0].cmdsave.disabled=false;
}

function doDelete()
{
	if(confirm("Do you want to delete the Applicant ?"))
	{
	//If Co-applicant/guarantor is attached in credit report,cannot delete before deatach  
		if((document.forms[0].applevel.value=="S") && (document.forms[0].hidCreditIDCheck.value=="Y")) 
		{
			alert("Please detach the Joint Applicant/Co-Obligant/Guarantor in credit report");
			return;
		}
		document.forms[0].seltype.disabled=false;
		document.forms[0].sel_incomeeligibility.disabled=false;
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidBeanMethod.value="updateCoAppGuarantor";
		document.forms[0].hidBeanGetMethod.value="getCoAppGuarantor";
		document.forms[0].hidBeanId.value="perapplicant";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/percoappguarantor.jsp";	
		document.forms[0].submit();
	}
}

function doNew()
{
	document.forms[0].hideditflag.value="Y";
	document.forms[0].seltype.disabled=false;
	document.forms[0].txtrelation.disabled=false;
	document.forms[0].sel_relation_type.disabled=false;
	document.forms[0].seltype.value="S";
	document.forms[0].txtloan_cname.value="";
	document.forms[0].hidAction.value="insert";
	disabledButtons(true,false,false,true,true,false);
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=='radio')
		{
			document.forms[0].elements[i].disabled=true;
		}
	}
	document.forms[0].sel_incomeeligibility.disabled=false;
}

function disabledButtons(a,b,c,d,e,f)
{
	document.forms[0].cmdnew.disabled=a;
	document.forms[0].cmdsave.disabled=b;
	document.forms[0].cmdcancel.disabled=c;
	document.forms[0].cmddelete.disabled=d;
	document.forms[0].cmdclose.disabled=e;
	document.forms[0].cmdcomments.disabled=f;
}

function selApplicant(creditcheck)
{
	var len=document.forms[0].appid.length;
	if(len==null)
	{
		document.forms[0].hidCoDemoId.value=document.forms[0].appid.value;
		document.forms[0].seltype.value=document.forms[0].coapptype.value;
		document.forms[0].txtloan_cname.value=document.forms[0].coappname.value;
		document.forms[0].txtrelation.value=document.forms[0].corelation.value;
		document.forms[0].sel_incomeeligibility.value=document.forms[0].txt_includeincome.value;
		document.forms[0].sel_relation_type.value=document.forms[0].cbs_reltype.value;
		document.forms[0].hidCreditIDCheck.value=creditcheck;		
	}
	else
	{
		for(i=0;i<len;i++)
		{
			if(document.forms[0].appid[i].checked==true)
			{
				document.forms[0].hidCoDemoId.value=document.forms[0].appid[i].value;
				document.forms[0].seltype.value=document.forms[0].coapptype[i].value;
				document.forms[0].txtloan_cname.value=document.forms[0].coappname[i].value;
				document.forms[0].txtrelation.value=document.forms[0].corelation[i].value;
				document.forms[0].sel_incomeeligibility.value=document.forms[0].txt_includeincome[i].value;
				document.forms[0].sel_relation_type.value=document.forms[0].cbs_reltype[i].value;
				document.forms[0].hidCreditIDCheck.value=creditcheck;
				break;
			}
		}
	}
	if(document.forms[0].btnenable.value=="Y")
	{
		<%if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){%>
		if(varFlag=="Y")
		{
			disabledButtons(true,true,false,false,true,false);
		}
		else
		{
			disabledButtons(true,true,true,true,true,false);
		}
		<%}else{%>
		disabledButtons(false,true,false,false,true,false);
		<%}%>
		
	}
	if(varSecFreeze=="Y")
	{
		disabledButtons(true,true,true,true,true,true);
	}
	if(varFreeze=="Y")
	{
		disabledButtons(true,true,true,true,false,false);
	}
	if(sessionModuleType=="DIGI")
	{
		if(len==null)
		{
			//document.forms[0].cmddelete.disabled=true;
			<%
					ArrayList arrCol5 = new ArrayList();
					ArrayList arrRow5 = new ArrayList();
					if (hshValues != null){
						arrRow5 = (ArrayList) hshValues.get("arrColdigiflag");
						for(int i=0;i<arrRow5.size();i++)
						{
							arrCol5 = (ArrayList)arrRow5.get(i);
							String getAppId = Helper.correctNull((String)arrCol5.get(0));
							String getflag = Helper.correctNull((String)arrCol5.get(1));
					%>
			var getAppId="<%=getAppId%>";
					var getflag="<%=getflag%>";
					if(document.forms[0].appid.value==getAppId)
					{
						if(getflag==""){
						document.forms[0].cmddelete.disabled=false;
						}else{
						document.forms[0].cmddelete.disabled=true;
						}
					}
						<% }}%>
		}
		else
		{
			for(i=0;i<len;i++)
			{
				if(document.forms[0].appid[i].checked==true)
				{
					<%
					 arrCol5 = new ArrayList();
					 arrRow5 = new ArrayList();
					if (hshValues != null){
						arrRow5 = (ArrayList) hshValues.get("arrColdigiflag");
						for(int i=0;i<arrRow5.size();i++)
						{
							arrCol5 = (ArrayList)arrRow5.get(i);
							String getAppId = Helper.correctNull((String)arrCol5.get(0));
							String getflag = Helper.correctNull((String)arrCol5.get(1));
					%>
					var getAppId="<%=getAppId%>";
					var getflag="<%=getflag%>";
					if(document.forms[0].appid[i].value==getAppId)
					{
						if(getflag==""){
						document.forms[0].cmddelete.disabled=false;
						}else{
						document.forms[0].cmddelete.disabled=true;
					}
					}	
					<%}}%>
				}
			}
		}
	}
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanGetMethod.value="getCoAppGuarantor";
		document.forms[0].hidBeanId.value="perapplicant";
		document.forms[0].action=appURL+"action/percoappguarantor.jsp";
		document.forms[0].submit();
	}
}

function onloading()
{
	if(document.forms[0].txtloan_cname.value!="")
	{
		document.forms[0].cmdcheck.disabled=false;
	}
	else
	{
		document.forms[0].cmdcheck.disabled=true;
	}
	if(document.forms[0].seltype.value=="S")
	{
		document.forms[0].sel_incomeeligibility.disabled=true;
	}
	else
	{
		document.forms[0].sel_incomeeligibility.disabled=false;
	}
	if(document.forms[0].sel_relation_type.value=="0")
	{
		document.forms[0].sel_relation_type.disabled=true;
	}
	else
	{
		document.forms[0].sel_relation_type.disabled=false;
	}
	if(appstatus=="Open/Pending")
	{
		if(document.forms[0].btnenable.value=="Y")
		{
			<%if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){%>
			if(varFlag=="Y")
			{
				disabledButtons(false,true,true,true,false,false);
			}
			else
			{
				disabledButtons(true,true,true,true,false,false);
			}
			<%}else{%>
			disabledButtons(false,true,true,true,false,false);
			<%}%>
		}
		else
		{		
			disabledButtons(true,true,true,true,false,false);
		}
		if(varFreeze=="Y")
		{
			document.forms[0].cmdfreeze.disabled=true;
			document.forms[0].cmdundo.disabled=false;
			disabledButtons(true,true,true,true,false,false);
		}
		else
		{
			document.forms[0].cmdfreeze.disabled=false;
			document.forms[0].cmdundo.disabled=true;
		}
		if(varSecFreeze=="Y")
		{
			document.forms[0].cmdfreeze.disabled=true;
			document.forms[0].cmdundo.disabled=true;
			disabledButtons(true,true,true,true,true,true);
		}
	}
	else
	{		
		disabledButtons(true,true,true,true,false,false);
		document.forms[0].cmdfreeze.disabled=true;
		document.forms[0].cmdundo.disabled=true;
	}
	if(varGrpRights=='r')
	{
		document.forms[0].cmdfreeze.disabled=true;
		document.forms[0].cmdundo.disabled=true;
	}
}

function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{		
		document.forms[0].action=appURL+"action/retailpge.jsp";
		document.forms[0].submit();
	}
}
function doComments()
{
	var btnenable=document.forms[0].btnenable.value;
	var hidAppNo = document.forms[0].hidAppNo.value;
	var hidCommentPage = document.forms[0].hidCommentPage.value;
	var prop = "scrollbars=yes,width=750,height=550,top=25,left=180";
	var url=appURL+"action/comments.jsp?hidBeanId=perfinancial&hidBeanGetMethod=getComments&hidAppNo="+hidAppNo+"&hidCommentPage="+hidCommentPage+"&btnenable="+btnenable+"&appstatus="+appstatus;
	window.open(url,"Comments",prop);
}

function disableIncludeIncome()
{
	if(document.forms[0].txt_prd_cgtmse.value == "Y")
	{
		//alert("Co applicant/Guarantor cannot be attached if borrower has CGTMSE coverage");
		//document.forms[0].seltype.value="S";
		//document.forms[0].seltype.focus();
	}
		
	if(document.forms[0].seltype.value=="c")
	{
		if(varjointappincome=="1")
		{
			document.forms[0].sel_incomeeligibility.disabled=true;
			document.forms[0].sel_incomeeligibility.value="1";
		}
		else
		{
			document.forms[0].sel_incomeeligibility.disabled=false;
		}
	}
	else if(document.forms[0].seltype.value=="g")
	{
		if(varobligantincome=="1")
		{
			document.forms[0].sel_incomeeligibility.disabled=true;
			document.forms[0].sel_incomeeligibility.value="1";
		}
		else
		{
			document.forms[0].sel_incomeeligibility.disabled=false;
		}
	}

	else if(document.forms[0].seltype.value=="o"){
		if(varguarantorincome=="1")
		{
			document.forms[0].sel_incomeeligibility.disabled=true;
			document.forms[0].sel_incomeeligibility.value="1";
		}
		else
		{
			document.forms[0].sel_incomeeligibility.disabled=false;
		}
	}
	
	else if(document.forms[0].seltype.value=="p"){
		if(varsoleproperiter=="1")
		{
			document.forms[0].sel_incomeeligibility.disabled=true;
			document.forms[0].sel_incomeeligibility.value="1";
		}
		else
		{
			document.forms[0].sel_incomeeligibility.disabled=false;
		}
	}
	
}
function doFreeze()
{
	//alert(varNOtRequiredFlag);
	
	if(sessionModuleType!="DIGI" || sessionModuleType!="RET")
	{
		if(arrRow>0)
		{
			if(strAppHuntStatus=="Y")
			{
				alert("Hunter Score is less than "+strHunterScore+" for the "+varStrAppid+" further processing shall not be allowed.");
				return;
		
				if(strPropNo=="")
				{
					alert("Kindly attach the Permission Proposal since Hunter Score is less than the minimum score");
					return;
				}
				else if(strPropNo!="" && strHunterCheck=="N")
				{
					alert("Kindly attach the valid Permission Proposal with Deviation in Hunter score");
					return;
				}
			}
		}
		if(arrRow1>0)
		{
			alert("Hunter Score is less than "+strHunterScore+" for the "+varStrAppid1+" further processing shall not be allowed.");
			return;
		}
	}
	
	if(varCoApp_Gua_ID!="")
	{
		if(varCGTMSE_flag=="Y")
		{
		alert("The following Applicant Details are not added in Customer profile("+varCoApp_Gua_ID+").Kindly remove and proceed");
		return;
		}
	}
	
	if(varInCompleteID!="")
	{
		alert("You cannot do this action.The following Applicant Details are partial in Customer profile("+varInCompleteID+")");
		return;
	}
	<%if(Helper.correctNull((String)session.getAttribute("sessionModuleType")).equalsIgnoreCase("RET")){%>
	if(varNOtRequiredFlag=="Y")
	{
		alert("Co applicant/Guarantor/Coobligant is not attached in Customer Profile -Groups / Management People details tab\n"+varNOtRequiredAppid);
		return;
	}
	
	<%if(strcgtmseavail.equalsIgnoreCase("Y") && arrRow.size()>0){%>
	    alert("Co-applicant/Guarantor/Coobligant cannot be attached if borrower has CGTMSE coverage except Proprietors,Partners,Directors, Trustees/Karta who are attached in Customer Profile - Group Management People Details tab");
	    return;
	<%}}%>
		showProgress('imgloading');
		window.scrollTo(0, 0);
		document.forms[0].cmdfreeze.disabled=true;
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidBeanMethod.value="getFreezeData";
		document.forms[0].hidBeanGetMethod.value="getCoAppGuarantor";
		document.forms[0].hidBeanId.value="perapplicant";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/percoappguarantor.jsp";	
		document.forms[0].submit();
}

function doMaxCheck()
{
	
	if((varInccount>=varEligInccount) && (varPrdType=="pM"))
	{
		alert("You cannot add any applicant's income for assessment since you have reached the limit");
		document.forms[0].sel_incomeeligibility.value="1";
	}
}
function doUndo()
{
		document.forms[0].hidAction.value="undo";
		document.forms[0].hidBeanMethod.value="updateCoAppGuarantor";
		document.forms[0].hidBeanGetMethod.value="getCoAppGuarantor";
		document.forms[0].hidBeanId.value="perapplicant";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/percoappguarantor.jsp";	
		document.forms[0].submit();
}
function callLink(url,bean,method)
{
	//pan check
	if(document.forms[0].freezeflag.value=="Y")
	{
		if(document.forms[0].varPanCheck.value=="Y")
		{ 
			if(document.forms[0].sessionmodule.value=="RET")
			{
			 if(document.forms[0].Explimitchk.value=="F")
				 {
					 if (document.forms[0].varPancount.value=="N")
					{
					 alert("Please obtain PAN number of the Applicants (including co-applicant/Joint borrower/Co-applicant) Co-Obligant/guarantor and capture in CBS for exposure (includes existing and proposed limit) of Rs."+document.forms[0].Expcheck.value+"/- and above ");
						return;
					}	 
				}
			}
			
		}
	}
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].hidBeanId.value=bean;
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+url;
	document.forms[0].submit();
}
function callguarchk()
{

	//alert(varPrdType);
	//alert(varPrdPurpose);
	//alert(varJointCount);
    //alert(document.forms[0].txtmaxcoapplicant.value);
	
	if((varPrdType=="pH" && varPrdPurpose=="T") || varPrdType=="pV")
	{
		if(document.forms[0].sel_incomeeligibility.value=="2" || document.forms[0].sel_incomeeligibility.value=="1")
		{
			
			if(document.forms[0].seltype.value=="c")
			{
			   if((parseFloat(varJointCount)+1)>parseFloat(document.forms[0].txtmaxcoapplicant.value))
				{
					alert("You cannot add any new Co-Applicant for this proposal, Maximum Number of Co-Applicant is "+parseFloat(document.forms[0].txtmaxcoapplicant.value)+" Member/s");
					document.forms[0].sel_incomeeligibility.value="1";
					document.forms[0].cmdsave.disabled = true;
					document.forms[0].cmdcancel.disabled = false;
				}
			}
			else if(document.forms[0].seltype.value=="g")
			{
				
				if((parseFloat(varGuarantorCount)+1)>parseFloat(document.forms[0].txtmaxguarantor.value))
				{
					alert("You cannot add any new Guarantor for this proposal, Maximum Number of Guarantor is "+parseFloat(document.forms[0].txtmaxguarantor.value)+" Member/s");
					document.forms[0].sel_incomeeligibility.value="1";
					document.forms[0].cmdsave.disabled = true;
					document.forms[0].cmdcancel.disabled = false;
				}
			}
			else if(document.forms[0].seltype.value=="p")
			{
			
				if((parseFloat(varProperitierCount)+1)>parseFloat(document.forms[0].txtmaxproperitier.value))
				{
					alert("You cannot add any new Properitier for this proposal, Maximum Number of Properitier is "+parseFloat(document.forms[0].txtmaxproperitier.value)+" Member/s");
					document.forms[0].sel_incomeeligibility.value="1";
					document.forms[0].cmdsave.disabled = true;
					document.forms[0].cmdcancel.disabled = false;
				}
			}
		}
	}
	if((varPrdType=="pM" && varPrdLoanType=="TL") || (varPrdType=="pA"  && (varPrdPurpose=="N" || varPrdPurpose=="U")))
	{
		if(document.forms[0].seltype.value=="c")
		{
		   if((parseFloat(varJointCount)+1)>parseFloat(document.forms[0].txtmaxcoapplicant.value))
			{
				alert("You cannot add any new Co-Applicant for this proposal, Maximum Number of Co-Applicant is "+parseFloat(document.forms[0].txtmaxcoapplicant.value)+" Member/s");
				document.forms[0].sel_incomeeligibility.value="1";
				document.forms[0].cmdsave.disabled = true;
				document.forms[0].cmdcancel.disabled = false;
			}
		}
	}
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onloading()">
<div id='imgloading' style="display:none;">
<img src="<%=ApplicationParams.getAppUrl()%>img/processing2.gif"></div>
<form name="appform" method="post" action="" class="normal">
<%if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){%>
	<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../set/postsanctionlinksper.jsp" flush="true">
			<jsp:param name="pageid" value="1" />
			<jsp:param name="subpageid" value="102" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<table width="100%">
  		
  		<tr>
  			<td>
  			<table border="0" cellspacing="2" cellpadding="3" align="left" class="outertable">
			<tr>
			<td class="sub_tab_inactive" id="prin" width="150px;" align="center"><b><b><a
					href="#" onclick="javascript:callLink('perloandetails.jsp','perapplicant','getLoanProducts')">
					Loan Product</a></b></b></td>
			<%if ((strPrdType.equalsIgnoreCase("pI")) && (strPageParam.contains("@SEC@")||strPageParam.contains("@MODSEC@"))) { %>
			<td class="sub_tab_inactive" id="prin"><b><b><a
					href="#" onclick="javascript:callLink('per_instacash.jsp','perapplicant','getinstacash')">
					Insta Cash</a></b></b></td>
					<%} %>
			<%if (strPrdType.equalsIgnoreCase("pE") && strPageParam.contains("@COEX@")) { %>
			<td class="sub_tab_inactive" id="prin" width="150px" align="center"><b>
			<a href="#" onclick="javascript:callLink('eduparticulars.jsp','eduparticulars','getData')">Course Details</a></b>
			</td>
			<%} %>
			<td class="sub_tab_active" id="prin" nowrap width="150px;" align="center"><b>Co-Applicant / Guarantor</b></td>
			<td class="sub_tab_inactive" id="prin" width="150px;" align="center"><b><b><a
			href="#" onclick="javascript:callLink('com_otherpostsanctionparams.jsp?hidPageVal=otherparams','facilities','getComments')">
			Other Post Sanction Parameters</a></b></b></td>
			</tr>
			</table>
  			</td>
  		</tr>
  </table>
  	<%} else if(strCategoryType.equals("DIGI")) { %>
		  	 <jsp:include page="../share/applurllinkerdigi.jsp" flush="true" > 
		        <jsp:param name="pageid" value="1" />
		        </jsp:include>
		  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
		    <tr> 
				<td class="page_flow">Home -&gt; Digi Retail -&gt; Application -&gt; Loan Particulars -&gt; Joint Applicant / Co-Obligant / Guarantor</td>
		    </tr>
		  </table>
		  <lapschoice:application />
		    <%if(digiGoldFlag.equals("PJ")){ %>
		    <jsp:include page="../per/applicanttab.jsp" flush="true">
					<jsp:param name="linkid" value="77" />
				</jsp:include><br>
              <%}else{ %>
              <jsp:include page="../per/applicantTabDigi.jsp" flush="true"> 
   			<jsp:param name="linkid" value="6" />
              </jsp:include><br>
              <%} %>
	<%}else{ %>
        <jsp:include page="../share/Applurllinkper.jsp" flush="true" > 
        <jsp:param name="pageid" value="1" />
        </jsp:include>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <% if(strCategoryType.equals("AGR")){  %>
		<td class="page_flow">Home -&gt; Retail(including schematic) -&gt; Application -&gt; Loan Particulars -&gt; Joint Applicant / Co-Obligant / Guarantor</td>
		 <%}else{%> <td class="page_flow">Home -&gt; Retail(including schematic) -&gt; Application -&gt; Loan Particulars -&gt; Joint Applicant / Co-Obligant / Guarantor</td>
	       <%} %>
    </tr>
  </table>
  <lapschoice:application />
<jsp:include page="../per/applicanttab.jsp" flush="true"> 
             			<jsp:param name="linkid" value="6" />
                        </jsp:include><br>
                        <%} %>
  <table width="100%" border="0" cellspacing="0" cellpadding="3"  align="center" class="outertable">
    <tr> 
      <td valign="top"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
          <tr> 
            <td> 
              <table width="60%" border="1" cellspacing="0" align="center" cellpadding="3" class="outertable">
                <tr align="center"> 
                  <td colspan="2">
                    <table width="75%" border="0" cellspacing="0" cellpadding="5"  align="center" class="outertable">
                      <tr> 
                        <td width="29%">Select 
                            Applicant Type</td>
                        <td width="71%">
                            <select name="seltype" style="width:150" disabled onChange="disableIncludeIncome()";" tabindex="1">
                              <option value="S" selected>&lt;-- Select --&gt;</option>
                              <option value="c">Joint Applicant</option>
                              <option value="g"> Guarantor </option>
                              <option value="p">Sole properitier </option>
                              <option value="o">Co-Obligant </option>
                            </select>
                          </td>
                      </tr>
                      <tr > 
                        <td width="29%">Name 
                            of the Person</td>
                        <td width="71%"> <span onClick="javascript:callCoAppIDHelp()" style="cursor:hand"><b> 
                            </b></span> 
<table width="70%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                              <tr>
                                <td ><input type="text" name="txtloan_cname" size="50" readonly></td>
                                <td><span onClick="javascript:callCoAppIDHelp()" style="cursor:hand" ><b><img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
												 border="0" tabindex="2"></b></span></td>
                                <td >
                                  <input type="button" class="buttonstyle" name="cmdcheck" value="Check" onClick="callCheck(),checkadd()" tabindex="3">
                                </td>
                              </tr>
                            </table>
                          </td>
                      </tr>
                      <tr> 
                        <td width="29%">Relationship 
                            with the Applicant</td>
                        <td width="71%"> 
                            <!--<input type="text" name="txtrelation" size="25" maxlength="50" readOnly tabindex="4">-->
                            <select name="txtrelation" disabled onchange="callguarchk();">
                            	<option value="">--Select--</option>
                            	<lapschoice:CBSStaticDataNewTag apptype="32" />
                            </select>
                        </td>
                      </tr>
                      <tr>
                        <td>Include Income 
                          for Eligibility</td>
                        <td ><select name="sel_incomeeligibility" onChange="callguarchk();">
                            <option value="1">No</option>
                            <option value="2">Yes</option>
                          </select></td>
                      </tr> 
                       <tr><td colspan="2">&nbsp;</td></tr>     
                      <tr>
                        <td colspan="2"><b>Details passing to Finacle</b></td>
                      </tr>
                      <tr>
                      <td>Relation type</td>
                        <td ><select name="sel_relation_type" onChange="">
                            <option value="0" selected>-- Select --</option>
                            <lapschoice:CBSStaticDataNewTag apptype="33" />
                          </select></td>
                      </tr>                  
                    </table>
                    </td>
                    </tr>
                    </table>
                    </td>
                    </tr>
                    </table>
                    </td>
                    </tr>
                    </table>
                    <br>
          <lapschoice:combuttonnew btnnames='New_Save_Cancel_Delete_Audit Trail_Comments_Freeze_Undo' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>                   
         <br>
                    <table width="100%" border="0" cellspacing="0" cellpadding="3"  align="center" class="outertable">
                      <tr> 
                        <td valign="top">                          
                            <table width="80%" border="0" cellspacing="0" cellpadding="2"  align="center" class="outertable linebor">
                              <tr class="dataheader" align="center"> 
                                <td width="5%">&nbsp;</td>
                                <td width="40%"> Name of the Person</td>
                                <td width="20%"> Type</td>
                                <td width="25%"> Relationship</td>
                                <td width="10%"> Include Income</td>
                              </tr>
                              <%
					if(arrRow.size()>0)
					{
						for(int i=0;i<arrRow.size();i++)
						{
						arrCol = (ArrayList)arrRow.get(i);
					%>
                              <tr class="datagrid"> 
                                <td width="5%">  
                                  <input type="radio" name="appid" value="<%=arrCol.get(0)%>" style="border-style:NONE" onClick="selApplicant('<%=arrCol.get(6)%>')">
                                  </td>
                                <td width="40%"> 
                                  &nbsp; 
                                  <input type="hidden" name="coappname" value="<%=arrCol.get(1)%>">
                                  <%=arrCol.get(1)%></td>
                                <td width="20%"> 
                                  &nbsp; 
                                  <input type="hidden" name="coapptype" value="<%=arrCol.get(2)%>">
                                  <%String type = (String)arrCol.get(2);
					  if(type.equals("c"))
					  {
					  type="Joint Applicant";
					  }
					  else if(type.equals("g"))
					  {
					  type="Guarantor";
					  }
					  else if(type.equals("p"))
					  {
					  type="Sole properitier";
					  }
					  else if(type.equals("o"))
					  {
					  type="Co-Obligant";
					  }
					  else
					  {
						  type="";
					  }
					  %>
                                  <%=type %> </td>
                                <td width="25%" >
                                <input type="hidden" name="corelation" value="<%=Helper.correctNull((String)arrCol.get(3))%>">
                                &nbsp;<%=Helper.correctNull((String)arrCol.get(4))%>
                                
                                <input type="hidden" name="cbs_reltype" value="<%=Helper.correctNull((String)arrCol.get(7))%>">
                                  </td>
                                <td width="10%" > 
                                  &nbsp; 
                                  <input type="hidden" name="txt_includeincome" value="<%=Helper.correctNull((String)arrCol.get(5))%>">
                                                <%
					  String includeincome = (String)arrCol.get(5);
               		  if(includeincome.equalsIgnoreCase("1"))
					  {
						  includeincome="No";
					  }
					  else
					  {
						  includeincome="Yes";
					  }%>
                                  <%=includeincome%></td>
                              </tr>
                              <%}}else{%>
                              <input type="hidden" name="coapptype" value="">
                              <input type="hidden" name="coappname" value="">
                              <input type="hidden" name="appid" value="">
                              <input type="hidden" name="corelation" value="">
                              <%}%>
                            </table>
                          
                        </td>
                      </tr>
                    </table>
  <br>
  <lapschoice:hiddentag pageid='<%=PageId%>'/>
<INPUT TYPE="hidden" name="radLoan" value="Y">
<INPUT TYPE="hidden" name="hidCoDemoId" value="">
<INPUT TYPE="hidden" name="hidCreditIDCheck" value="">
<input type="hidden" name="hidCommentPage" value="C">
<input type="hidden" name="cmdedit">
<input type="hidden" name="txtmaxcoapplicant" value="<%=Helper.correctInt((String)hshValues.get("prd_maxnoofjointapp"))%>">
<input type="hidden" name="txtmaxguarantor" value="<%=Helper.correctInt((String)hshValues.get("prd_maxnoofguarantor"))%>">
<input type="hidden" name="txtmaxproperitier" value="<%=Helper.correctInt((String)hshValues.get("prd_maxnoofproperitier"))%>">
<input type="hidden" name="hidAppNo" value="<%=Helper.correctNull((String)hshValues.get("strAppNo"))%>">
<input type="hidden" name="txt_prd_cgtmse" value="<%=Helper.correctNull((String)session.getAttribute("PRD_CGTMSE"))%>">

<input type="hidden" name="freezeflag" value="<%=Helper.correctNull((String)hshValues.get("strFreeze"))%>"> <!--pan check -->
<input type="hidden" name="ExposureChklimit" value="<%=Helper.correctNull((String)hshValues.get("strdblExplimit"))%>"> <!--pan check -->
<input type="hidden" name="Explimitchk" value="<%=Helper.correctNull((String)hshValues.get("strExplimitchk"))%>"> <!--pan check -->
<input type="hidden" name="varPancount" value="<%=Helper.correctNull((String)hshValues.get("Pancount"))%>"> <!--pan check -->
<input type="hidden" name="varPanCheck" value="<%=Helper.correctNull((String)hshValues.get("strPanCheck"))%>"> <!--pan check -->
<input type="hidden" name="ExposureChklimitagr" value=""> <!--pan check -->
<input type="hidden" name="Explimitagrchk" value=""> <!--pan check -->
<input type="hidden" name="Expmainactcheck" value=""> <!--pan check -->
<input type="hidden" name="Expcheck" value="<%=Helper.correctNull((String)hshValues.get("strChecklimit"))%>"> <!--pan check -->
<input type="hidden" name="sessionmodule" value="<%=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim()%>"> 

<iframe src="" id="ifrcoapp" style="visibility:hidden"></iframe>
</form>
</body>
</html>
 