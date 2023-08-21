<%@include file="../share/CKEditor.jsp"%>
<%@include file="../share/directives.jsp"%>
<%@ taglib prefix="lapstab" uri="/WEB-INF/lapstab.tld"%>

<%
String strPageid="35";
String strPageName=Helper.correctNull((String)request.getParameter("flowtype"));
String strapptype=Helper.correctNull((String) session.getAttribute("strAppType"));
if(strPageName.equalsIgnoreCase(""))
	strPageName=Helper.correctNull((String)hshValues.get("flowtype1"));
if(strPageName.equalsIgnoreCase("KSAE")||strPageName.equalsIgnoreCase("KSAE-Restructure"))
	strPageid="38";
else if(strPageName.equalsIgnoreCase("FIDPN"))
	strPageid="39";
else if(strPageName.equalsIgnoreCase("MMithra"))
	strPageid="40";
else if(strPageName.equalsIgnoreCase("GECL")||strPageName.equalsIgnoreCase("GECL-Restructure"))
	strPageid="41";

ArrayList listRow=new ArrayList();
ArrayList listDPN=new ArrayList();
ArrayList listCol=new ArrayList();

listRow=(ArrayList)hshValues.get("listRow");
listDPN=(ArrayList)hshValues.get("listDPN");
String[] strArr={"March","April","May","June*","July*","August*"};

double dblMargin=100-Double.parseDouble(Helper.correctDouble((String)hshValues.get("strMithraMargin")));
//double dblMarginAss1=Double.parseDouble(Helper.correctDouble((String)hshValues.get("strGECL1")));
//double dblMarginAss2=Double.parseDouble(Helper.correctDouble((String)hshValues.get("strGECL2")));
double dblMarginAss1=Double.parseDouble(Helper.correctDouble((String)hshValues.get("COM_GECL1_MAXLIMITNOC")));
double dblMarginAss2=Double.parseDouble(Helper.correctDouble((String)hshValues.get("COM_GECL1_MAXLIMITBORRO")));
double dblMargingecl2limt=Double.parseDouble(Helper.correctDouble((String)hshValues.get("COM_GECL2_ELGLIMITMLIS")));
double dblMargingecl2banklimt=Double.parseDouble(Helper.correctDouble((String)hshValues.get("COM_GECL2_ELIGLIMITBANK")));
double dblMargingecl3limt=Double.parseDouble(Helper.correctDouble((String)hshValues.get("COM_GECL3_MAXLIMITBORROMLIS")));
double dblMargingecl3banklimt=Double.parseDouble(Helper.correctDouble((String)hshValues.get("COM_GECL3_MAXLIMITBANK")));
double dblbaloutstanding=Double.parseDouble(Helper.correctDouble((String)hshValues.get("COM_BAL_OUTSTANDING")));

double COM_GECL2EXT_MAXELGFINANCE=Double.parseDouble(Helper.correctDouble((String)hshValues.get("COM_GECL2EXT_MAXELGFINANCE")));
double COM_GECL2EXT_ELGFINANCE=Double.parseDouble(Helper.correctDouble((String)hshValues.get("COM_GECL2EXT_ELGFINANCE")));
double COM_GECL3EXT_MAXELGFINANCE=Double.parseDouble(Helper.correctDouble((String)hshValues.get("COM_GECL3EXT_MAXELGFINANCE")));
double COM_GECL3EXT_ELGFINANCE=Double.parseDouble(Helper.correctDouble((String)hshValues.get("COM_GECL3EXT_ELGFINANCE")));


double dbgecl1sno10=Double.parseDouble(Helper.correctDouble((String)hshValues.get("gecl1sno10")));
double dbgecl1sno23=Double.parseDouble(Helper.correctDouble((String)hshValues.get("gecl1sno23")));
//double dbgecl1sno24=Double.parseDouble(Helper.correctDouble((String)hshValues.get("gecl1sno24")));
double dbgecl1maxamount=Double.parseDouble(Helper.correctDouble((String)hshValues.get("gecl1maxamount")));
double dbgecl2maxamount=Double.parseDouble(Helper.correctDouble((String)hshValues.get("gecl2maxamount")));
double dbgecl3maxamount=Double.parseDouble(Helper.correctDouble((String)hshValues.get("gecl3maxamount")));
double dbgecl1sno1=Double.parseDouble(Helper.correctDouble((String)hshValues.get("gecl1sno1")));
double dbgecl1sno2=Double.parseDouble(Helper.correctDouble((String)hshValues.get("gecl1sno2")));
double dbgecl1sno4=Double.parseDouble(Helper.correctDouble((String)hshValues.get("gecl1sno4")));
double dbgecl1sno5=Double.parseDouble(Helper.correctDouble((String)hshValues.get("gecl1sno5")));

double dbl_propfundostot=0.00,dbl_propnonfundostot=0.00,dblcriteriaoverdueamt=0.00,dblaccountoverdueamt=0.00;
String strgecltype=Helper.correctNull((String) hshValues.get("strgeclident"));

String strgecltypeval="",strborrowergecl4="",strproductgecl4="",strproductgecl1rest="",strborroweravailed="";
java.text.NumberFormat nf = java.text.NumberFormat
.getNumberInstance();
nf.setGroupingUsed(false);
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);
double dblgeclproposedamt=0.00;
if(strgecltype.equalsIgnoreCase("GECL2")){
	strgecltypeval=Helper.correctNull((String) hshValues.get("strAmount17"));
	//dbl_propfundostot=(Double.parseDouble(Helper.correctDouble((String)hshValues.get("dbl_propfundostot"))));
	//dbl_propnonfundostot=(Double.parseDouble(Helper.correctDouble((String)hshValues.get("dbl_propnonfundostot"))));
	dblcriteriaoverdueamt=Double.parseDouble(Helper.correctDouble(((String)hshValues.get("stramt"))));
	dblaccountoverdueamt=Double.parseDouble(Helper.correctDouble(((String)hshValues.get("strgecl3amt"))));
}
if(strgecltype.equalsIgnoreCase("GECL3")){
	strgecltypeval=Helper.correctNull((String) hshValues.get("strAmount18"));
	dblcriteriaoverdueamt=Double.parseDouble(Helper.correctDouble(((String)hshValues.get("stramt"))));
	dblaccountoverdueamt=Double.parseDouble(Helper.correctDouble(((String)hshValues.get("strgecl3amt"))));

}
if(strgecltype.equalsIgnoreCase("GECL4")){
	strborrowergecl4=Helper.correctNull((String) hshValues.get("strAmount2"));
	dblgeclproposedamt=Double.parseDouble(Helper.correctDouble(((String)hshValues.get("dblgeclproposedamt"))));
	strproductgecl4=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("COM_GECL4_LIMITPROPOSED"))));	
	
}
if(strgecltype.equalsIgnoreCase("GECL1-Restructure")){
	strproductgecl1rest=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("COM_BAL_OUTSTANDING"))));	
	strborroweravailed=Helper.correctNull((String) hshValues.get("strAmount3"));

}

String strgstnnumber=Helper.correctNull((String) hshValues.get("strgstnumber"));
double dbgecl1ext23=(Double.parseDouble(Helper.correctDouble((String)hshValues.get("gecl1sno10"))));
String dbgecl1sno24=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("gecl1sno24"))));
//Helper.correctNull((String)hshValues.get("strAmount1"))

//out.println("hshValues=====>"+hshValues);
//out.println("Helper.correctNull((String) request.getParameter(appstatus))======>"+Helper.correctNull((String) request.getParameter("appstatus")));
%>
<html>
<head>
<title>BG Assessment</title>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</script>

<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var appstatus="<%=Helper.correctNull((String) request.getParameter("appstatus"))%>";
var selcomments="<%=Helper.correctNull((String) hshValues.get("selcoment"))%>";
var varEligBasedon="<%=Helper.correctNull((String) hshValues.get("strEligBasedon"))%>";
var varFacilitysno="<%=Helper.correctNull((String) hshValues.get("strFacilitysno"))%>";
var varFacProposed="<%=Helper.correctNull((String) hshValues.get("strFacProposed"))%>";
var strMithraFacTot="<%=Helper.correctDouble((String) hshValues.get("strMithraFacTot"))%>";
var appno="<%=request.getParameter("appno")%>";
var varMargin="<%=dblMargin%>";
var varMarginAss1="<%=dblMarginAss1%>";
var varMarginAss2="<%=dblMarginAss2%>";
var vargecl1ext23="<%=dbgecl1ext23%>";
var vargecltype="<%=Helper.correctNull((String) hshValues.get("strgecltype"))%>";
var varMargingecl2limt="<%=dblMargingecl2limt%>";
var varMargingecl2banklimt="<%=dblMargingecl2banklimt%>";
var vargecltype="<%=strgecltype%>";
var varlegalchk="<%=Helper.correctNull((String) hshValues.get("strlegalchk"))%>";
var varnameofsector="<%=Helper.correctNull((String) hshValues.get("strnameofsector"))%>";
var vargstnnumber="<%=Helper.correctNull((String) hshValues.get("strgstnumber"))%>";
var vargstnfalg="<%=Helper.correctNull((String) hshValues.get("strgstnfalg"))%>";
var varcriteriaamt="<%=dblcriteriaoverdueamt%>";
var varMargingecl3limt="<%=dblMargingecl3limt%>";
var varMargingecl3banklimt="<%=dblMargingecl3banklimt%>";
var varaccountoverdueamt="<%=dblaccountoverdueamt%>";
var vargecl4prodcutamt="<%=strproductgecl4%>";
var varbaloutstanding="<%=dblbaloutstanding%>";
var vardbgecl1sno10="<%=dbgecl1sno10%>";
var vardbgecl1sno23="<%=dbgecl1sno23%>";
var vardbgecl1sno24="<%=dbgecl1sno24%>";

var varlegalchk1="<%=Helper.correctNull((String) hshValues.get("PERAPP_LEGAL_ENTITYID"))%>";

var varlegalchk2="<%=Helper.correctNull((String) hshValues.get("PERAPP_LEGAL_EXPIRYDATE"))%>";
var varlegalchk3=varlegalchk1+"-"+varlegalchk2;

var varconstitution= "<%=Helper.correctNull((String)hshValues.get("PERAPP_CONSTITUTION"))%>";

var vargecl1sno1="<%=dbgecl1sno1%>";
var vargecl1sno2="<%=dbgecl1sno2%>";
var vargecl1sno4="<%=dbgecl1sno4%>";
var vargecl1sno5="<%=dbgecl1sno5%>";
var vardbgecl1maxamount="<%=dbgecl1maxamount%>";

var  varCOM_GECL2EXT_MAXELGFINANCE="<%=COM_GECL2EXT_MAXELGFINANCE%>";
var  varCOM_GECL2EXT_ELGFINANCE="<%=COM_GECL2EXT_ELGFINANCE%>";
var  varCOM_GECL3EXT_MAXELGFINANCE="<%=COM_GECL3EXT_MAXELGFINANCE%>";
var  varCOM_GECL3EXT_ELGFINANCE="<%=COM_GECL3EXT_ELGFINANCE%>";
var vargecl2sno24="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("gecl2sno24"))))%>";
var vargecl3sno24="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("gecl3sno24"))))%>";
var vardbgecl2maxamount="<%=dbgecl2maxamount%>";
var vardbgecl3maxamount="<%=dbgecl3maxamount%>";
var usr_class="<%=Helper.correctNull((String) hshValues.get("usr_class"))%>";
var org_level="<%=Helper.correctNull((String) hshValues.get("org_level"))%>";
function doClose()
{
	if( ConfirmMsg(100) )
	{
		document.forms[0].method="post";
        document.forms[0].hidBeanId.value="";
	    document.forms[0].action=appURL+"action/"+"corppge.jsp";	
		document.forms[0].submit();
	}
}
function doDelete()
{
	document.forms[0].sel_facilitysno.disabled=false;
	document.forms[0].sel_eligibility.disabled=false;

	document.forms[0].hidAction.value ="delete";
	document.forms[0].hidBeanId.value="comproposal";
    document.forms[0].hidBeanMethod.value="updateBGassessment";
	document.forms[0].hidBeanGetMethod.value="getBGassessment";
	document.forms[0].hidSourceUrl.value="action/com_bgassessment.jsp?flowtype="+document.forms[0].flowtype1.value;	
	document.forms[0].action=appURL+"action/controllerservlet";	
	document.forms[0].submit();
}
function doSave()
{ 	
	if(document.forms[0].flowtype1.value=="KSAE" ||document.forms[0].flowtype1.value=="KSAE-Restructure")
	{
		
		if(document.forms[0].sel_eligibility.value=="")
		{
			alert("Select Type of Borrower");
			document.forms[0].sel_eligibility.focus();
			return;
		}
		if(varlegalchk=="Y"&& vargecltype=="GECL2"){
			alert("Please Update Legal Entity Identification Number and Expiry Date  Details in Customer Profile -> Demographics tab");
			return;
		}
		if(vargstnfalg=="Y"){
			alert("Please Update GST Registration No/Exempted Details in Customer Profile -> Demographics tab");
			return;
		}

		
		<%if(listRow!=null && listRow.size()>0){
			
		if(listRow.size()>1){%>

			for(var i=0;i<document.forms[0].txt_cmtans.length;i++)
			{
				if((vargecltype=="GECL3" || vargecltype=="GECL4" ||vargecltype=="GECL1-Restructure" ) && document.forms[0].hid_cmts[i].value=="LEI CODE AND DUE DATE OF THE SAME"){ 
					//AND DUE DATE OF THE SAME"){
					
						continue;
				}
				//varlegalchk3="";
				if(( vargecltype=="GECL -1 extension" || vargecltype=="GECL -3 extension" ) && document.forms[0].hid_cmts[i].value=="LEI Code and due date of the same"){ 
					//AND DUE DATE OF THE SAME"){
					//alert("varlegalchk3==="+varlegalchk3);
					if(varlegalchk3!="")
					{
						//document.forms[0].txt_cmtans[i].value=varlegalchk3;
						
						
						if(document.forms[0].txt_cmtans[i].value!="")
						{
							//alert("1");
						if(document.forms[0].sel_eligible[i].value=="")
						{
							alert("Select Eligibility");
							document.forms[0].sel_eligible[i].focus();
							return;
						}
						}
						continue;
							//continue;
				}
					else
					{
						//alert("varlegalchk3===else");
						continue;
					}
					}	


				if(( vargecltype=="GECL -2 extension" ) && document.forms[0].hid_cmts[i].value=="LEI Code and due date of the same"){ 
					//AND DUE DATE OF THE SAME"){
					//alert("varlegalchk3==="+varlegalchk3);
					if(varconstitution!="01" && varlegalchk1!="" && varlegalchk2!="" )
					{
						//document.forms[0].txt_cmtans[i].value=varlegalchk3;
						
						if(document.forms[0].txt_cmtans[i].value!="")
						{
							//alert("2");
						if(document.forms[0].sel_eligible[i].value=="")
						{
							alert("Select Eligibility");
							document.forms[0].sel_eligible[i].focus();
							return;
						}
						}
						continue;
						
							//continue;
				    }
					else if(varconstitution!="01" && (varlegalchk1=="" || varlegalchk2==""))
					{

						if(varlegalchk1=="")
						{
						alert("Please Update Legal Entity Identification Number Details in Customer Profile -> Demographics tab");
						return;
						}
						if(varlegalchk2=="")
						{
						alert("Please Update Legal Entity  Expiry Date  Details in Customer Profile -> Demographics tab");
						return;
						}
						
					} 
						
					else
					{
						//alert("varlegalchk3===else");
						continue;
						
					}
					}

					
					
				//alert("1");
				if(document.forms[0].txt_cmtans[i].value=="")
				{
					alert("Enter Details");
					document.forms[0].txt_cmtans[i].focus();
					return;
				}
				if(document.forms[0].sel_eligible[i].value=="")
				{
					alert("Select Eligibility");
					document.forms[0].sel_eligible[i].focus();
					return;
				}
				
			}

		<%}else{%>

		if(document.forms[0].txt_cmtans.value=="")
		{
			if((vargecltype=="GECL3" || vargecltype=="GECL4" ||vargecltype=="GECL1-Restructure" ) && document.forms[0].hid_cmts.value=="LEI CODE AND DUE DATE OF THE SAME"){
							
			}
			//alert("2");
			else{			
			alert("Enter Details");
			document.forms[0].txt_cmtans.focus();
			return;
			}
		}

		if(document.forms[0].sel_eligible.value=="")
		{
			alert("Select Eligibility");
			document.forms[0].sel_eligible.focus();
			return;
		}
		<%}
		}%>
		document.forms[0].sel_eligibility.disabled=false;
	}

	else if(document.forms[0].flowtype1.value=="FIDPN")
	{
		if(document.forms[0].txtAmount[8].value=="" || document.forms[0].txtAmount[8].value=="0.00")
		{
			alert("Enter Recommended Amount");
			return;
		}
	}
	else if(document.forms[0].flowtype1.value=="GECL" || document.forms[0].flowtype1.value=="GECL-Restructure")
	{
		 if(vargecltype=="GECL1"){
		if(document.forms[0].txtAmount3[10].value=="" || document.forms[0].txtAmount3[10].value=="0.00")
		{
			alert("Enter Limit Requested by the borrower");
			document.forms[0].txtAmount3[10].value="";
			document.forms[0].txtAmount3[10].focus();
			return;
		}

		document.forms[0].txtAmount3[2].disabled=false;
		document.forms[0].txtAmount3[5].disabled=false;
		document.forms[0].txtAmount3[6].disabled=false;
		document.forms[0].txtAmount3[8].disabled=false;
		document.forms[0].txtAmount3[9].disabled=false;
		document.forms[0].txtAmount3[11].disabled=false;
		 }else if(vargecltype=="GECL2"){

			chkasscriteraiamtchk();
			if(document.forms[0].txtAmount5[0].value==""){
				alert("Enter Total outstanding balance under term loans of applicant with other banks/FIs");
				document.forms[0].txtAmount5[0].focus();
				return;
			}
			if(document.forms[0].txtAmount5[1].value==""){
				alert("Enter Total outstanding balance under term loans of applicant with our bank ");
				document.forms[0].txtAmount5[1].focus();
				return;
			}
			if(document.forms[0].txtAmount5[3].value==""){
				alert("Enter Total outstanding balance under fund based working capital loans of applicant with other banks/FIs ");
				document.forms[0].txtAmount5[3].focus();
				return;
			}
			if(document.forms[0].txtAmount5[4].value==""){
				alert("Enter Total outstanding balance under fund based working capital loans of applicant with our bank ");
				document.forms[0].txtAmount5[4].focus();
				return;
			}if(document.forms[0].txtAmount5[8].value==""){
				alert("Enter Amount of overdue in savings/current account/credit card account as per bureau report");
				document.forms[0].txtAmount5[8].focus();
				return;
			}if(document.forms[0].txtAmount5[9].value==""){
				alert("Enter Total outstanding balance in fund based limit as on 29-02-2020 as per latest Bureau report");
				document.forms[0].txtAmount5[9].focus();
				return;
			}if(document.forms[0].txtAmount5[14].value==""){
				alert("Enter Total Limit Recommended/Proposed (considering only our Bank's Exposure) Fund Based");
				document.forms[0].txtAmount5[14].focus();
				return;
			}if(document.forms[0].txtAmount5[15].value==""){
				alert("Enter Total Limit Recommended/Proposed (considering only our Bank's Exposure)Non Fund Based");
				document.forms[0].txtAmount5[15].focus();
				return;
			}
			if(document.forms[0].txtAmount5[16].value==""){
				alert("Enter Whether NOC from other MLI's is submitted to avail the eligible limit with our bank?");
				document.forms[0].txtAmount5[16].focus();
				return;
			}
			if(document.forms[0].txtAmount5[16].value=="Yes"){
				if(document.forms[0].txtAmount5[17].value==""){
				alert("Enter Comments");
				document.forms[0].txtAmount5[17].focus();
				return;
			}
				if(document.forms[0].txtAmount5[18].value==""){
					alert("Enter If NOC submitted, limit recommended/proposed (considering the entire exposure with all MLI's) Fund Based");
					document.forms[0].txtAmount5[18].focus();
					return;
				}
				if(document.forms[0].txtAmount5[19].value==""){
					alert("Enter If NOC submitted, limit recommended/proposed (considering the entire exposure with all MLI's) Non Fund Based");
					document.forms[0].txtAmount5[19].focus();
					return;
				}
		}
	}
		if(vargecltype=="GECL3"){
			chkasscriteraiamtchk3();
			if(document.forms[0].txtAmount6[0].value==""){
				alert("Total outstanding balance under term loans of applicant with other banks/FIs as on 29.02.2020  ");
				document.forms[0].txtAmount6[0].focus();
				return;
			}
			if(document.forms[0].txtAmount6[1].value==""){
				alert("Total outstanding balance under term loans of applicant with our bank as on 29.02.2020");
				document.forms[0].txtAmount6[1].focus();
				return;
			}
			if(document.forms[0].txtAmount6[3].value==""){
				alert("Total outstanding balance under working capital loans of applicant with other banks/FIs as on 29.2.2020");
				document.forms[0].txtAmount6[3].focus();
				return;
			}
			if(document.forms[0].txtAmount6[4].value==""){
				alert("Total outstanding balance in working capital loans of applicant with  our Bank as on 29.2.2020");
				document.forms[0].txtAmount6[4].focus();
				return;
			}if(document.forms[0].txtAmount6[8].value==""){
				alert("Amount of overdue in savings/current account/credit card account as per bureau report");
				document.forms[0].txtAmount6[8].focus();
				return;
			}if(document.forms[0].txtAmount6[9].value==""){
				alert("Total outstanding balance in fund based limit  as on 29-02-2020 as per latest Bureau report");
				document.forms[0].txtAmount6[9].focus();
				return;
			}if(document.forms[0].txtAmount6[15].value==""){
				alert("Limit Requested by Borrower");
				document.forms[0].txtAmount6[15].focus();
				return;
			}if(document.forms[0].txtAmount6[16].value==""){
				alert("Limit recommended  considering our Banks Exposure Only");
				document.forms[0].txtAmount6[16].focus();
				return;
			}
			if(document.forms[0].txtAmount6[17].value==""){
				alert("Whether NOC from other MLI's is submitted to avail the eligible limit with our bank?");
				document.forms[0].txtAmount6[17].focus();
				return;
			}
			if(document.forms[0].txtAmount6[17].value=="Yes"){
				if(document.forms[0].txtAmount6[18].value==""){
				alert("Comments");
				document.forms[0].txtAmount6[18].focus();
				return;
			}
				
				if(document.forms[0].txtAmount6[19].value==""){
					alert("If NOC submitted, limit recommended/proposed (considering the entire exposure with all MLI's)");
					document.forms[0].txtAmount6[19].focus();
					return;
				}
		}
		}
		if(vargecltype=="GECL4"){
		chkassesmentgecl4();
		if(document.forms[0].txtAmount7[0].value==""){
			alert("Borrower exposure with our bank as on 31/03/2021");
			document.forms[0].txtAmount7[0].focus();
			return;
		}
		if(document.forms[0].txtAmount7[1].value==""){
			alert("Select Whether borrower accounts are taken over from other Banks after 01/04/2021");
			document.forms[0].txtAmount7[1].focus();
			return;
		}
		if(document.forms[0].txtAmount7[1].value=="Yes"){
			
		if(document.forms[0].txtAmount7[2].value==""||document.forms[0].txtAmount7[2].value=="0" ||eval(document.forms[0].txtAmount7[2].value)<1){
			alert("Borrower exposure with other bank as on 31/03/2021");
			document.forms[0].txtAmount7[2].focus();
			return;
		}
		}
		if(document.forms[0].txtAmount7[3].value==""){
			alert("Enter Project cost as per Quotation/estimation");
			document.forms[0].txtAmount7[3].focus();
			return;
		}
		if(document.forms[0].txtAmount7[4].value==""){
			alert("Enter Margin Amount");
			document.forms[0].txtAmount7[4].focus();
			return;
		}
		var varlimitproposedval=eval(document.forms[0].txtAmount7[6].value);
	
	if(eval(varlimitproposedval)>eval(vargecl4prodcutamt))
	{
		alert("Limit Proposed and Recommended value should not exceed maximum limit of Rs. "+eval(vargecl4prodcutamt));	
		return ;
	}
if(NanNumber(parseInt(document.forms[0].txtAmount7[0].value))>=1){
		alert("Branch to ensure that atleast one facility is released as on 31-03-2021");
	}

		}
		if(vargecltype=="GECL -1 extension"){
			
			if(document.forms[0].txtAmount9[0].value==""){
				alert("Total balance o/s  under TL of the applicant  with other banks/FIs as on 29.02.2020 [A]");
				document.forms[0].txtAmount9[0].focus();
				return;
			}
			if(document.forms[0].txtAmount9[1].value==""){
				alert("Total balance o/s  under TL of the applicant with our Bank as on 29.02.2020 [B]");
				document.forms[0].txtAmount9[1].focus();
				return;
			}
			
			if(document.forms[0].txtAmount9[3].value==""){
				alert("Total balance o/s  under WC of the applicant  with other bank s/FIs as on 29.02.2020 [D]");
				document.forms[0].txtAmount9[3].focus();
				return;
			}
			if(document.forms[0].txtAmount9[4].value==""){
				alert("Total balance o/s  under WC of the applicant with our Bank as on 29.02.2020 [E]");
				document.forms[0].txtAmount9[4].focus();
				return;
			}
			var varlimitproposedval8=eval(document.forms[0].txtAmount9[8].value);
		var varlimitproposedval21=eval(document.forms[0].txtAmount9[21].value);
		if(eval(varlimitproposedval8)>eval(vardbgecl1maxamount))
		{
			alert("Value under column I or V should not exceed the mazimum product limit i.e Rs.   "+eval(vardbgecl1maxamount));	
			return ;
		}
		if(eval(varlimitproposedval21)>eval(vardbgecl1maxamount))
		{
			alert("Value under column I or V should not exceed the mazimum product limit i.e Rs.   "+eval(vardbgecl1maxamount));	
			return ;
		}
		
		

			}
			
			//alert(vargecltype);
			 if(vargecltype=="GECL -1 extension"){

	     	  if(document.forms[0].txtAmount9[0].value==""  && document.forms[0].txtAmount9[1].value=="" 
	         	  && document.forms[0].txtAmount9[3].value==""  && document.forms[0].txtAmount9[4].value=="" )
	     	  {
	    	   document.forms[0].txtAmount9[0].readOnly=false;
	      	  document.forms[0].txtAmount9[1].readOnly=false;
	      	
	      	 document.forms[0].txtAmount9[3].readOnly=false;
	      	 document.forms[0].txtAmount9[4].readOnly=false;
	     	  } 

		      	  if(document.forms[0].txtAmount9[8].value=="" || document.forms[0].txtAmount9[8].value=="0" || 
				      	  document.forms[0].txtAmount9[8].value=="0.0" || document.forms[0].txtAmount9[8].value=="0.00")
		      	  {

		      		document.forms[0].txtAmount9[0].readOnly=false;
			      	  document.forms[0].txtAmount9[1].readOnly=false;
			      	
			      	 document.forms[0].txtAmount9[3].readOnly=false;
			      	 document.forms[0].txtAmount9[4].readOnly=false;
		      	  

		      	if(document.forms[0].txtAmount9[0].value=="0.00"){
					alert("Total balance o/s  under TL of the applicant  with other banks/FIs as on 29.02.2020 [A]");
					document.forms[0].txtAmount9[0].focus();
					return;
				}
				if(document.forms[0].txtAmount9[1].value=="0.00"){
					alert("Total balance o/s  under TL of the applicant with our Bank as on 29.02.2020 [B]");
					document.forms[0].txtAmount9[1].focus();
					return;
				}
				
				if(document.forms[0].txtAmount9[3].value=="0.00"){
					alert("Total balance o/s  under WC of the applicant  with other bank s/FIs as on 29.02.2020 [D]");
					document.forms[0].txtAmount9[3].focus();
					return;
				}
				if(document.forms[0].txtAmount9[4].value=="0.00"){
					alert("Total balance o/s  under WC of the applicant with our Bank as on 29.02.2020 [E]");
					document.forms[0].txtAmount9[4].focus();
					return;
				}  
		      	  }   	  
	       }

			 if(vargecltype=="GECL -2 extension"){
					
					
					var varlimitproposedval8=eval(document.forms[0].txtAmount11[8].value);
				var varlimitproposedval21=eval(document.forms[0].txtAmount11[19].value);
				if(eval(varlimitproposedval8)>eval(vardbgecl2maxamount))
				{
					alert("Value under column I or T should not exceed the mazimum product limit i.e Rs.   "+eval(vardbgecl2maxamount));	
					return ;
				}
				if(eval(varlimitproposedval21)>eval(vardbgecl2maxamount))
				{
					alert("Value under column I or T should not exceed the mazimum product limit i.e Rs.   "+eval(vardbgecl2maxamount));	
					return ;
				}
				
				

					}
					
					//alert(vargecltype);
					 if(vargecltype=="GECL -2 extension"){

				      	  if((document.forms[0].txtAmount11[0].value==""|| document.forms[0].txtAmount11[0].value=="0.00")&&(document.forms[0].txtAmount11[1].value==""|| document.forms[0].txtAmount11[1].value=="0.00")&& 
						      	  (document.forms[0].txtAmount11[3].value=="" || document.forms[0].txtAmount11[3].value=="0.00") &&
								  (document.forms[0].txtAmount11[4].value=="" || document.forms[0].txtAmount11[3].value=="0.00"))
				      	  {

				      		document.forms[0].txtAmount11[0].readOnly=false;
					      	  document.forms[0].txtAmount11[1].readOnly=false;
					      	
					      	 document.forms[0].txtAmount11[3].readOnly=false;
					      	 document.forms[0].txtAmount11[4].readOnly=false;
				      	  

				      	if(document.forms[0].txtAmount11[0].value==""){
						alert("Total balance o/s  under TL of the applicant with other banks/FIs as on 29.02.2020 [A]");
						document.forms[0].txtAmount11[0].focus();
						return;
					}
					if(document.forms[0].txtAmount11[1].value==""){
						alert("Total balance o/s  under TL of the applicant with our Bank as on 29.02.2020 [B]");
						document.forms[0].txtAmount11[1].focus();
						return;
					}
					
					if(document.forms[0].txtAmount11[3].value==""){
						alert("Total balance o/s  under fund based WC of the applicant with other banks/FIs as on 29.02.2020 [D]");
						document.forms[0].txtAmount11[3].focus();
						return;
					}
					if(document.forms[0].txtAmount11[4].value==""){
						alert("Total balance o/s  under fund based WC of the applicant with our Bank as on 29.02.2020 [E]");
						document.forms[0].txtAmount11[4].focus();
						return;
					}

					
				      	  } 

				      	  var ext2limit=parseInt(document.forms[0].txtAmount11[22].value);
							if(ext2limit<0)
							{
							alert("Limit Recommended should not be negative");	
							return;
							}
					      	  
					 }
			
				      	if(vargecltype=="GECL -3 extension"){
							
							
							var varlimitproposedval8=eval(document.forms[0].txtAmount10[12].value);
						var varlimitproposedval21=eval(document.forms[0].txtAmount10[25].value);
						var total=varlimitproposedval8+varlimitproposedval21;

						if(eval(varlimitproposedval8)>eval(vardbgecl3maxamount))
						{
							alert("If value under column Z or M or Z+M exceeds maximum limit of GECL -3 extension product  i.e  Rs.   "+eval(vardbgecl3maxamount));	
							return ;
						}

						if(eval(varlimitproposedval21)>eval(vardbgecl3maxamount))
						{
							alert("If value under column Z or M or Z+M exceeds maximum limit of GECL -3 extension product  i.e  Rs.   "+eval(vardbgecl3maxamount));	
							return ;
						}
						
						if(eval(total)>eval(vardbgecl3maxamount))
						{
							alert("If value under column Z or M or Z+M exceeds maximum limit of GECL -3 extension product  i.e  Rs.   "+eval(vardbgecl3maxamount));	
							return ;
						}
                         var varlimitproposedval26=parseInt(document.forms[0].txtAmount10[25].value);
                         if(varlimitproposedval26<0)
							{
							alert("Limit Recommended should not be negative");	
							return;
							}
						
						//8,22
                       /* var varlimitproposedval8=eval(document.forms[0].txtAmount10[8].value);
						var varlimitproposedval21=eval(document.forms[0].txtAmount10[22].value);
						
						if(eval(varlimitproposedval8)>eval(vardbgecl3maxamount))
						{							
							alert("Value under column (I or W exceeds maximum limit of GECL -3 extension product i.e Rs.   "+eval(vardbgecl3maxamount));	
							return ;
						}
						if(eval(varlimitproposedval21)>eval(vardbgecl3maxamount))
						{							
							alert("Value under column (I or W exceeds maximum limit of GECL -3 extension product i.e Rs.   "+eval(vardbgecl3maxamount));	
							return ;
						}*/


						
							}
							
							//alert(vargecltype);
							 if(vargecltype=="GECL -3 extension"){

						      	  if((document.forms[0].txtAmount10[0].value=="" || document.forms[0].txtAmount10[0].value=="0.00" )&&(document.forms[0].txtAmount10[1].value=="" || document.forms[0].txtAmount10[1].value=="0.00")&& 
								      	  (document.forms[0].txtAmount10[3].value=="" || document.forms[0].txtAmount10[3].value=="0.00" 
							      	  ) &&
										  (document.forms[0].txtAmount10[4].value=="" || document.forms[0].txtAmount10[4].value=="0.00"))
						      	  {

						      		document.forms[0].txtAmount10[0].readOnly=false;
							      	  document.forms[0].txtAmount10[1].readOnly=false;
							      	
							      	 document.forms[0].txtAmount10[3].readOnly=false;
							      	 document.forms[0].txtAmount10[4].readOnly=false;
						      	  

						      	if(document.forms[0].txtAmount10[0].value==""){
								alert("Total balance o/s  under TL of the applicant with other banks/FIs as on 29.02.2020 [A]");
								document.forms[0].txtAmount10[0].focus();
								return;
							}
							if(document.forms[0].txtAmount10[1].value==""){
								alert("Total balance o/s  under TL of the applicant with our Bank as on 29.02.2020 [B]");
								document.forms[0].txtAmount10[1].focus();
								return;
							}
							
							if(document.forms[0].txtAmount10[3].value==""){
								alert("Total balance o/s  under WC of the applicant with other banks/FIs as on 29.02.2020 [D]");
								document.forms[0].txtAmount10[3].focus();
								return;
							}
							if(document.forms[0].txtAmount10[4].value==""){
								alert("Total balance o/s  under WC of the applicant with our Bank as on 29.02.2020 [E]");
								document.forms[0].txtAmount10[4].focus();
								return;
							}
						      	  } 
							 }
		
	}


	
	document.forms[0].cmdsave.disabled=true;
	disableFields(false);
	document.forms[0].hidAction.value ="insert";
	document.forms[0].hidBeanId.value="comproposal";
	document.forms[0].hidBeanMethod.value="updateBGassessment";
	document.forms[0].hidBeanGetMethod.value="getBGassessment";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/com_bgassessment.jsp";
	document.forms[0].submit();
}
function disableCommandButtons(val)
{
	if(val=="load")
	{
		if(appstatus=="Processed/Rejected" || appstatus=="Processed/Approved" || appstatus=="Closed/Approved" || appstatus=="Closed/Rejected")	 
	  	{
			if(document.forms[0].btnenable.value =='N')
		  	{
				document.forms[0].cmdnew.disabled=true;
			  	document.forms[0].cmdedit.disabled=true;
			  	document.forms[0].cmddelete.disabled=true;
			  	document.forms[0].cmdsave.disabled=true;
			  	document.forms[0].cmdcancel.disabled=true;
			  	document.forms[0].cmdclose.disabled=false;
		 	}
	  	}
	 	else
	 	{
	 		document.forms[0].cmdedit.disabled=false;
	 	  	document.forms[0].cmddelete.disabled=true;
		  	document.forms[0].cmdsave.disabled=true;
		  	document.forms[0].cmdcancel.disabled=true;
		  	document.forms[0].cmdclose.disabled=false;
	 	}
	}
	if(val=="edit")
	{
		if(document.forms[0].btnenable.value =='N')
	  	{
			document.forms[0].cmdnew.disabled=true;
		  	document.forms[0].cmdedit.disabled=true;
		  	document.forms[0].cmddelete.disabled=true;
		  	document.forms[0].cmdsave.disabled=true;
		  	document.forms[0].cmdcancel.disabled=true;
		  	document.forms[0].cmdclose.disabled=false;
	 	}
	 	else
	 	{
			document.forms[0].cmdedit.disabled=true;
			document.forms[0].cmddelete.disabled=false;
			document.forms[0].cmdsave.disabled=false;
			document.forms[0].cmdcancel.disabled=false;
			if(document.forms[0].appno.value != "new")
			{
				document.forms[0].cmdclose.disabled=true;
			}
			else
			{
				document.forms[0].cmdclose.disabled=false;
				document.forms[0].cmddelete.disabled=true;
				document.forms[0].cmdcancel.disabled=true;
			}
		}
		disableFields(false);
	}
}
function onLoading()
{
	 disableFields(true);
	 if(document.forms[0].flowtype1.value=="KSAE" ||document.forms[0].flowtype1.value=="KSAE-Restructure")
	 {
		 document.all.idbgass.style.display="none";
		 document.all.idksae.style.display="table";
		 document.all.idfidpn.style.display="none";
		 document.all.idMMithra.style.display="none";
		 document.all.idGECL.style.display="none";
		 <%
		 if(listRow!=null && listRow.size()>0){
			for(int i=0;i<listRow.size();i++)
			{
				listCol=(ArrayList)listRow.get(i);
				if(Helper.correctNull((String)listCol.get(5)).equalsIgnoreCase("NS"))
				{
					if(listRow.size()==1)
					{
						%>
						document.forms[0].txt_cmtans.value="<%=Helper.correctNull((String)listCol.get(1))%>";
						<%
					}
					else
					{
						%>
						document.forms[0].txt_cmtans[<%=i%>].value="<%=Helper.correctNull((String)listCol.get(1))%>";
						<%
					}
				}
			}
		}
		 %>
	 }
	 else if(document.forms[0].flowtype1.value=="FIDPN")
	 {
		 document.all.idbgass.style.display="none";
		 document.all.idksae.style.display="none";
		 document.all.idfidpn.style.display="table";
		 document.all.idMMithra.style.display="none";
		 document.all.idGECL.style.display="none";
		 document.forms[0].sel_facilitysno.disabled=false;
		 document.forms[0].sel_facilitysno.value=varFacilitysno;
	 }
	 else if(document.forms[0].flowtype1.value=="MMithra")
	 {
		 document.all.idbgass.style.display="none";
		 document.all.idksae.style.display="none";
		 document.all.idfidpn.style.display="none";
		 document.all.idMMithra.style.display="table";
		 document.all.idGECL.style.display="none";
		 
	 }
	 else if(document.forms[0].flowtype1.value=="GECL"||document.forms[0].flowtype1.value=="GECL-Restructure")
	 {
		 document.all.idbgass.style.display="none";
		 document.all.idksae.style.display="none";
		 document.all.idfidpn.style.display="none";
		 document.all.idMMithra.style.display="none";
		 document.all.idGECL.style.display="table";
       if(vargecltype=="GECL1"){
		 document.forms[0].txtAmount3[0].readOnly=true;
		 document.forms[0].txtAmount3[1].readOnly=true;
		 document.forms[0].txtAmount3[2].readOnly=true;
		 document.forms[0].txtAmount3[3].readOnly=true;
		 document.forms[0].txtAmount3[4].readOnly=true;
		 document.forms[0].txtAmount3[5].readOnly=true;
		 document.forms[0].txtAmount3[6].readOnly=true;
       }else if(vargecltype=="GECL2"){
    	  document.forms[0].txtAmount5[2].readOnly=true;
  		 document.forms[0].txtAmount5[5].readOnly=true;
  		 document.forms[0].txtAmount5[6].readOnly=true;
  		 document.forms[0].txtAmount5[7].readOnly=true;
  		 document.forms[0].txtAmount5[10].readOnly=true;
  		 document.forms[0].txtAmount5[11].readOnly=true;
  		 document.forms[0].txtAmount5[12].readOnly=true;
  		 document.forms[0].txtAmount5[13].readOnly=true;
  		<% if(!strgecltypeval.equalsIgnoreCase("")){%>
  		document.forms[0].txtAmount5[16].value="<%=strgecltypeval%>";
  		
  		<%}%>
  		selchangeval();
       }
       else if(vargecltype=="GECL3"){
     	  document.forms[0].txtAmount6[2].readOnly=true;
   		 document.forms[0].txtAmount6[5].readOnly=true;
   		 document.forms[0].txtAmount6[6].readOnly=true;
   		 document.forms[0].txtAmount6[7].readOnly=true;
   		 document.forms[0].txtAmount6[10].readOnly=true;
   		 document.forms[0].txtAmount6[11].readOnly=true;
   		 document.forms[0].txtAmount6[12].readOnly=true;
   		 document.forms[0].txtAmount6[13].readOnly=true;
   		<% if(!strgecltypeval.equalsIgnoreCase("")){%>
   		document.forms[0].txtAmount6[17].value="<%=strgecltypeval%>";
   		
   		<%}%>
   		selchangegecl3val();
 		getPercentageofNumbergecl3();   		
        }
       else if(vargecltype=="GECL4"){
    	   <% if(!strborrowergecl4.equalsIgnoreCase("")){%>
      		document.forms[0].txtAmount7[1].value="<%=strborrowergecl4%>";
      		
      		<%}%>
    	   
       selchangevalgecl4();
       }
       else if(vargecltype=="GECL1-Restructure"){

    	
       }

       else if(vargecltype=="GECL -1 extension"){
    	   additionValues9();
    	   getPercentageofNumber9();
    	  // getPercentageofNumber923();
    	   document.forms[0].txtAmount9[0].readOnly=true;
      	  document.forms[0].txtAmount9[1].readOnly=true;
      	 document.forms[0].txtAmount9[2].readOnly=true;
      	 document.forms[0].txtAmount9[3].readOnly=true;
      	 document.forms[0].txtAmount9[4].readOnly=true;
      	 document.forms[0].txtAmount9[5].readOnly=true;
      	 document.forms[0].txtAmount9[6].readOnly=true;
      	 document.forms[0].txtAmount9[7].readOnly=true;
      	 document.forms[0].txtAmount9[8].readOnly=true;
      	 document.forms[0].txtAmount9[9].readOnly=true;
      	 document.forms[0].txtAmount9[10].readOnly=true;
      	 document.forms[0].txtAmount9[11].readOnly=true;
      	 document.forms[0].txtAmount9[12].readOnly=true;
      	 //document.forms[0].txtAmount9[13].readOnly=true;
      	document.forms[0].txtAmount9[15].readOnly=true;
      	document.forms[0].txtAmount9[18].readOnly=true;
      	document.forms[0].txtAmount9[19].readOnly=true;
      	document.forms[0].txtAmount9[20].readOnly=true;
      	document.forms[0].txtAmount9[21].readOnly=true;
      	document.forms[0].txtAmount9[22].readOnly=true;
      	document.forms[0].txtAmount9[23].readOnly=true;
      	document.forms[0].txtAmount9[24].readOnly=true;
      	 
       }

       else if(vargecltype=="GECL -2 extension"){
    	   additionValues11();
    	   getPercentageofNumber11();
    	  // getPercentageofNumber923();
    	   document.forms[0].txtAmount11[0].readOnly=true;
      	  document.forms[0].txtAmount11[1].readOnly=true;
      	 document.forms[0].txtAmount11[2].readOnly=true;
      	 document.forms[0].txtAmount11[3].readOnly=true;
      	 document.forms[0].txtAmount11[4].readOnly=true;
      	 document.forms[0].txtAmount11[5].readOnly=true;
      	 document.forms[0].txtAmount11[6].readOnly=true;
      	 document.forms[0].txtAmount11[7].readOnly=true;
      	 document.forms[0].txtAmount11[8].readOnly=true;
      	 document.forms[0].txtAmount11[9].readOnly=true;
      	 document.forms[0].txtAmount11[10].readOnly=true;
      	 //document.forms[0].txtAmount9[11].readOnly=true;
      	 //document.forms[0].txtAmount9[12].readOnly=true;
      	 document.forms[0].txtAmount11[13].readOnly=true;
      	//document.forms[0].txtAmount9[15].readOnly=true;
      	document.forms[0].txtAmount11[16].readOnly=true;
      	document.forms[0].txtAmount11[17].readOnly=true;
      	document.forms[0].txtAmount11[18].readOnly=true;
      	document.forms[0].txtAmount11[19].readOnly=true;
      	document.forms[0].txtAmount11[20].readOnly=true;
      	document.forms[0].txtAmount11[21].readOnly=true;
      	document.forms[0].txtAmount11[22].readOnly=true;
      	//document.forms[0].txtAmount9[23].readOnly=true;
      	//document.forms[0].txtAmount9[24].readOnly=true;
      	 
       }

       else if(vargecltype=="GECL -3 extension"){
    	   additionValues10();
    	   getPercentageofNumber10();
    	  // getPercentageofNumber923();
    	   document.forms[0].txtAmount10[0].readOnly=true;
      	  document.forms[0].txtAmount10[1].readOnly=true;
      	 document.forms[0].txtAmount10[2].readOnly=true;
      	 document.forms[0].txtAmount10[3].readOnly=true;
      	 document.forms[0].txtAmount10[4].readOnly=true;
      	 document.forms[0].txtAmount10[5].readOnly=true;
      	 document.forms[0].txtAmount10[6].readOnly=true;
      	 document.forms[0].txtAmount10[7].readOnly=true;
      	 document.forms[0].txtAmount10[8].readOnly=true;
      	 document.forms[0].txtAmount10[9].readOnly=true;
      	 document.forms[0].txtAmount10[10].readOnly=true;
      	 document.forms[0].txtAmount10[11].readOnly=true;
      	 document.forms[0].txtAmount10[12].readOnly=true;
      	 document.forms[0].txtAmount10[13].readOnly=true;
      	document.forms[0].txtAmount10[14].readOnly=true;
      	document.forms[0].txtAmount10[17].readOnly=true;
      	//document.forms[0].txtAmount11[17].readOnly=true;
      	//document.forms[0].txtAmount11[18].readOnly=true;
      	//document.forms[0].txtAmount10[19].readOnly=true;
      	document.forms[0].txtAmount10[20].readOnly=true;
      	document.forms[0].txtAmount10[21].readOnly=true;
      	document.forms[0].txtAmount10[22].readOnly=true;
      	document.forms[0].txtAmount10[23].readOnly=true;
      	document.forms[0].txtAmount10[24].readOnly=true;
      	document.forms[0].txtAmount10[25].readOnly=true;
       }
       
	 }
	 
	 else
	 {
		 EditorEnableDisable("id_div","block","id_editor","none"); 
		 document.all.idbgass.style.display="table";
		 document.all.idksae.style.display="none";
		 document.all.idfidpn.style.display="none";
		 document.all.idMMithra.style.display="none";
		 document.all.idGECL.style.display="none";
	 }
	 if(varEligBasedon!="")
	 {
		 document.forms[0].sel_eligibility.value=varEligBasedon;
	 }
}
function doEdit()
{

	disableFields(false);
	document.forms[0].hidAction.value ="update";
	disableCommandButtons("edit");
	if(document.forms[0].flowtype1.value=="KSAE" || document.forms[0].flowtype1.value=="KSAE-Restructure")
	{
		/*if(document.forms[0].sel_eligibility.value!="")
		{
			document.forms[0].sel_eligibility.disabled=true;
		}*/

		<%
		 if(listRow!=null && listRow.size()>0){
			for(int i=0;i<listRow.size();i++)
			{
				listCol=(ArrayList)listRow.get(i);
				if((Helper.correctNull((String)listCol.get(5)).equalsIgnoreCase("LC")&& !Helper.correctNull((String)listCol.get(13)).equalsIgnoreCase("01")))
				{
					if(Helper.correctNull((String)listCol.get(11)).equalsIgnoreCase("Y")){%>
    					if(document.forms[0].txt_gst.length==undefined || document.forms[0].txt_gst.length==1)
    					{
    						document.forms[0].txt_gst.readOnly=true;
    					}
    					else
    					{
        					for(var i=0;i<document.forms[0].txt_gst.length;i++)
        					{
        						document.forms[0].txt_gst[i].readOnly=true;
        					}
    					}
					<%}%>
				<%}
				
				
			}
		}
		 %>

		 if(document.forms[0].hid_cmtstype.length==1)
		 {
			 document.forms[0].txt_cmtans.readOnly=true;
			 document.forms[0].txt_cmtans1.readOnly=true;
		 }
		 else
		 {
			 for(var i=0;i<document.forms[0].hid_cmtstype.length;i++)
			 {
				 if(document.forms[0].hid_cmtstype[i].value=="LC")
				 {
					 document.forms[0].txt_cmtans[i].readOnly=true;
					 document.forms[0].txt_cmtans1[i].readOnly=true;
					 
				 }
				 else if(document.forms[0].hid_cmtstype[i].value=="GRN")
				 {
					 document.forms[0].txt_cmtans[i].readOnly=true;
					 document.forms[0].txt_cmtans1[i].readOnly=true;
					 
				 }
				
			 }
		 }
		 	}
	else if(document.forms[0].flowtype1.value=="MMithra")
	{
		document.forms[0].txtAmount1[3].readOnly=true;
		document.forms[0].txtAmount1[4].readOnly=true;
		document.forms[0].txtAmount1[6].readOnly=true;
	}
	else if(document.forms[0].flowtype1.value=="FIDPN")
	{
		if(document.forms[0].sel_facilitysno.value=="0")
		{
			alert("Select Facilities");
			return;
			
		}
		document.forms[0].txtAmount[0].readOnly=true;
		document.forms[0].txtAmount[7].readOnly=true;
		document.forms[0].sel_facilitysno.disabled=true;
	}
	else if(document.forms[0].flowtype1.value=="GECL" || document.forms[0].flowtype1.value=="GECL-Restructure")
	{ 
		if(vargecltype=="GECL1"){
		document.forms[0].txtAmount3[2].disabled=true;
		document.forms[0].txtAmount3[5].disabled=true;
		document.forms[0].txtAmount3[6].disabled=true;
		document.forms[0].txtAmount3[8].disabled=true;
		document.forms[0].txtAmount3[9].disabled=true;
		document.forms[0].txtAmount3[11].disabled=true;
		}else if(vargecltype=="GECL2"){
		 document.forms[0].txtAmount5[2].readOnly=true;
  		 document.forms[0].txtAmount5[5].readOnly=true;
  		 document.forms[0].txtAmount5[6].readOnly=true;
  		 document.forms[0].txtAmount5[7].readOnly=true;
  		 document.forms[0].txtAmount5[10].readOnly=true;
  		 document.forms[0].txtAmount5[11].readOnly=true;
  		 document.forms[0].txtAmount5[12].readOnly=true;
  		 document.forms[0].txtAmount5[13].readOnly=true;
		}
	else if(vargecltype=="GECL3"){
		 document.forms[0].txtAmount6[2].readOnly=true;
 		 document.forms[0].txtAmount6[5].readOnly=true;
 		 document.forms[0].txtAmount6[6].readOnly=true;
 		 document.forms[0].txtAmount6[7].readOnly=true;
 		 document.forms[0].txtAmount6[10].readOnly=true;
 		 document.forms[0].txtAmount6[11].readOnly=true;
 		 document.forms[0].txtAmount6[12].readOnly=true;
 		 document.forms[0].txtAmount6[13].readOnly=true;
 		 document.forms[0].txtAmount6[14].readOnly=true;
 		 document.forms[0].txtAmount6[15].readOnly=true;
 		 
		}
	else if(vargecltype=="GECL4"){
		 document.forms[0].txtAmount7[5].readOnly=true;
		 document.forms[0].txtAmount7[6].readOnly=true;
			
	}else if(vargecltype=="GECL1-Restructure"){
		document.forms[0].txtAmount8[0].readOnly=true;
		 document.forms[0].txtAmount8[1].readOnly=true;
		 document.forms[0].txtAmount8[2].disabled=true;
		   <%if(Helper.correctNull((String)hshValues.get("strgecl3propstatus")).equalsIgnoreCase("Y")){ %>
    		document.forms[0].txtAmount8[2].value="Yes";
    	   
   	   <%}else{%>
    		document.forms[0].txtAmount8[2].value="No";
    	   
   	   <%}%>
     		getPercentageofgecl1rest();
	}

	 else if(vargecltype=="GECL -1 extension"){
  	   //alert("first");
  	   document.forms[0].txtAmount9[0].readOnly=true;
    	  document.forms[0].txtAmount9[1].readOnly=true;
    	 document.forms[0].txtAmount9[2].readOnly=true;
    	 document.forms[0].txtAmount9[3].readOnly=true;
    	 document.forms[0].txtAmount9[4].readOnly=true;
    	 document.forms[0].txtAmount9[5].readOnly=true;
    	 document.forms[0].txtAmount9[6].readOnly=true;
    	 document.forms[0].txtAmount9[7].readOnly=true;
    	 document.forms[0].txtAmount9[8].readOnly=true;
    	 document.forms[0].txtAmount9[9].readOnly=true;
    	 document.forms[0].txtAmount9[10].readOnly=true;
    	 document.forms[0].txtAmount9[11].readOnly=true;
    	 document.forms[0].txtAmount9[12].readOnly=true;
    	// document.forms[0].txtAmount9[13].readOnly=true;

    	 document.forms[0].txtAmount9[15].readOnly=true;
       	document.forms[0].txtAmount9[18].readOnly=true;
       	document.forms[0].txtAmount9[19].readOnly=true;
       	document.forms[0].txtAmount9[20].readOnly=true;
       	document.forms[0].txtAmount9[21].readOnly=true;
       	document.forms[0].txtAmount9[22].readOnly=true;
       	document.forms[0].txtAmount9[23].readOnly=true;
       	document.forms[0].txtAmount9[24].readOnly=true;
       	
     }
	     

	  if(vargecltype=="GECL -1 extension"){
		  //alert("second");
    	  if(document.forms[0].txtAmount9[0].value==""  && document.forms[0].txtAmount9[1].value=="" 
        	  && document.forms[0].txtAmount9[3].value==""  && document.forms[0].txtAmount9[4].value=="" )
    	  {
        	  //alert("1");
   	   document.forms[0].txtAmount9[0].readOnly=false;
     	  document.forms[0].txtAmount9[1].readOnly=false;
     	
     	 document.forms[0].txtAmount9[3].readOnly=false;
     	 document.forms[0].txtAmount9[4].readOnly=false;
    	  }
     	 
      }

	  if(vargecltype=="GECL -1 extension"){
//alert("third");
   	  if(document.forms[0].txtAmount9[8].value=="" || document.forms[0].txtAmount9[8].value=="0" 
   	   	  || document.forms[0].txtAmount9[8].value=="0.0" || document.forms[0].txtAmount9[8].value=="0.00"  )
   	  {
   		//alert("1");
  	      document.forms[0].txtAmount9[0].readOnly=false;
    	  document.forms[0].txtAmount9[1].readOnly=false;
    	
    	 document.forms[0].txtAmount9[3].readOnly=false;
    	 document.forms[0].txtAmount9[4].readOnly=false;
   	  }
    	 
     }

	  if(vargecltype=="GECL -1 extension" &&  ( parseInt(usr_class)>=130 && (org_level=="C" || org_level=="R" || org_level=="D")))
		  {
		  document.forms[0].txtAmount9[0].readOnly=false;
     	  document.forms[0].txtAmount9[1].readOnly=false;
     	
     	 document.forms[0].txtAmount9[3].readOnly=false;
     	 document.forms[0].txtAmount9[4].readOnly=false;
     	 
		  }
	  
	  else if(vargecltype=="GECL -2 extension"){
   	   additionValues11();
   	   getPercentageofNumber11();
   	  // getPercentageofNumber923();
   	   document.forms[0].txtAmount11[0].readOnly=true;
     	  document.forms[0].txtAmount11[1].readOnly=true;
     	 document.forms[0].txtAmount11[2].readOnly=true;
     	 document.forms[0].txtAmount11[3].readOnly=true;
     	 document.forms[0].txtAmount11[4].readOnly=true;
     	 document.forms[0].txtAmount11[5].readOnly=true;
     	 document.forms[0].txtAmount11[6].readOnly=true;
     	 document.forms[0].txtAmount11[7].readOnly=true;
     	 document.forms[0].txtAmount11[8].readOnly=true;
     	 document.forms[0].txtAmount11[9].readOnly=true;
     	 document.forms[0].txtAmount11[10].readOnly=true;
     	 //document.forms[0].txtAmount9[11].readOnly=true;
     	 //document.forms[0].txtAmount9[12].readOnly=true;
     	 document.forms[0].txtAmount11[13].readOnly=true;
     	//document.forms[0].txtAmount9[15].readOnly=true;
     	document.forms[0].txtAmount11[16].readOnly=true;
     	document.forms[0].txtAmount11[17].readOnly=true;
     	document.forms[0].txtAmount11[18].readOnly=true;
     	document.forms[0].txtAmount11[19].readOnly=true;
     	document.forms[0].txtAmount11[20].readOnly=true;
     	document.forms[0].txtAmount11[21].readOnly=true;
     	document.forms[0].txtAmount11[22].readOnly=true;
     	//document.forms[0].txtAmount9[23].readOnly=true;
     	//document.forms[0].txtAmount9[24].readOnly=true;
     	 
      }


	  if(vargecltype=="GECL -2 extension"){
		 // alert("second");
    	  if((document.forms[0].txtAmount11[0].value=="" || document.forms[0].txtAmount11[0].value=="0.00" ) &&
    	    	   (document.forms[0].txtAmount11[1].value=="" || document.forms[0].txtAmount11[1].value=="0.00")
        	  && (document.forms[0].txtAmount11[3].value=="" || document.forms[0].txtAmount11[3].value=="0.00" ) && 
        	  (document.forms[0].txtAmount11[4].value=="" || document.forms[0].txtAmount11[4].value=="0.00"))
    	  {
        	  //alert("1");
   	   document.forms[0].txtAmount11[0].readOnly=false;
     	  document.forms[0].txtAmount11[1].readOnly=false;
     	
     	 document.forms[0].txtAmount11[3].readOnly=false;
     	 document.forms[0].txtAmount11[4].readOnly=false;
    	  }
     	 
      }

	  if(vargecltype=="GECL -2 extension"){
//alert("third");
   	  if(document.forms[0].txtAmount11[8].value=="" || document.forms[0].txtAmount11[8].value=="0" 
   	   	  || document.forms[0].txtAmount11[8].value=="0.0" || document.forms[0].txtAmount11[8].value=="0.00"  )
   	  {
   		//alert("1");
  	      document.forms[0].txtAmount11[0].readOnly=false;
    	  document.forms[0].txtAmount11[1].readOnly=false;
    	
    	 document.forms[0].txtAmount11[3].readOnly=false;
    	 document.forms[0].txtAmount11[4].readOnly=false;
   	  }
    	 
     }


	  if(vargecltype=="GECL -2 extension" &&   ( parseInt(usr_class)>=130 && (org_level=="C" || org_level=="R" || org_level=="D"))){
			 // alert("second");
	    	 
	        	  //alert("1");
	   	   document.forms[0].txtAmount11[0].readOnly=false;
	     	  document.forms[0].txtAmount11[1].readOnly=false;
	     	
	     	 document.forms[0].txtAmount11[3].readOnly=false;
	     	 document.forms[0].txtAmount11[4].readOnly=false;
	    	  
	     	 
	      }
      

	  else if(vargecltype=="GECL -3 extension"){
   	   //additionValues10();
   	   //getPercentageofNumber10();
   	  // getPercentageofNumber923();
   	   document.forms[0].txtAmount10[0].readOnly=true;
     	  document.forms[0].txtAmount10[1].readOnly=true;
     	 document.forms[0].txtAmount10[2].readOnly=true;
     	 document.forms[0].txtAmount10[3].readOnly=true;
     	 document.forms[0].txtAmount10[4].readOnly=true;
     	 document.forms[0].txtAmount10[5].readOnly=true;
     	 document.forms[0].txtAmount10[6].readOnly=true;
     	 document.forms[0].txtAmount10[7].readOnly=true;
     	 document.forms[0].txtAmount10[8].readOnly=true;
     	 document.forms[0].txtAmount10[9].readOnly=true;
     	 document.forms[0].txtAmount10[10].readOnly=true;
     	 document.forms[0].txtAmount10[11].readOnly=true;
     	 document.forms[0].txtAmount10[12].readOnly=true;
     	 document.forms[0].txtAmount10[13].readOnly=true;
     	//document.forms[0].txtAmount10[14].readOnly=true;
     	document.forms[0].txtAmount10[16].readOnly=true;
     	//document.forms[0].txtAmount11[17].readOnly=true;
     	//document.forms[0].txtAmount11[18].readOnly=true;
     	document.forms[0].txtAmount10[19].readOnly=true;
     	document.forms[0].txtAmount10[20].readOnly=true;
     	document.forms[0].txtAmount10[21].readOnly=true;
     	document.forms[0].txtAmount10[22].readOnly=true;
     	document.forms[0].txtAmount10[23].readOnly=true;
     	document.forms[0].txtAmount10[24].readOnly=true;
     	document.forms[0].txtAmount10[25].readOnly=true;
      }

	  if(vargecltype=="GECL -3 extension"){
		 // alert("second3");
    	  if((document.forms[0].txtAmount10[0].value==""  || document.forms[0].txtAmount10[0].value=="0.00" ) &&
        	  (document.forms[0].txtAmount10[1].value==""  || document.forms[0].txtAmount10[1].value=="0" 
            	  || document.forms[0].txtAmount10[1].value=="0.0"  || document.forms[0].txtAmount10[1].value=="0.00" ) &&
            	  (document.forms[0].txtAmount10[3].value==""  || document.forms[0].txtAmount10[3].value=="0" 
                	  || document.forms[0].txtAmount10[3].value=="0.0"  || document.forms[0].txtAmount10[3].value=="0.00" ) &&
                	  (document.forms[0].txtAmount10[4].value==""  || document.forms[0].txtAmount10[4].value=="0" 
                    	  || document.forms[0].txtAmount10[4].value=="0.0"  || document.forms[0].txtAmount10[4].value=="0.00" ) 
        	  )
    	  {
        	  //alert("1");
   	   document.forms[0].txtAmount10[0].readOnly=false;
     	  document.forms[0].txtAmount10[1].readOnly=false;
     	
     	 document.forms[0].txtAmount10[3].readOnly=false;
     	 document.forms[0].txtAmount10[4].readOnly=false;
    	  }
     	 
      }



	  if(vargecltype=="GECL -3 extension" && ( parseInt(usr_class)>=130 && (org_level=="C" || org_level=="R" || org_level=="D"))){
			 // alert("second3");
	    	 
	        	  //alert("1");
	   	   document.forms[0].txtAmount10[0].readOnly=false;
	     	  document.forms[0].txtAmount10[1].readOnly=false;
	     	
	     	 document.forms[0].txtAmount10[3].readOnly=false;
	     	 document.forms[0].txtAmount10[4].readOnly=false;
	    	  
	     	 
	      }
      
	}
	else
	{
		EditorEnableDisable("id_div","none","id_editor","block");
		editor_generate('txt_comments');
	}
}
function disableFields(val)
{
	  for(var i=0;i<document.forms[0].length;i++)
	  {
		  if(document.forms[0].elements[i].type=='textarea')
		  {
			document.forms[0].elements[i].readOnly=val;
		  }
		  if(document.forms[0].elements[i].type=='select-one')
		  {
			document.forms[0].elements[i].disabled=val;
		  }
		  if(document.forms[0].elements[i].type=='text')
		  {
			document.forms[0].elements[i].readOnly=val;
		  }
	  }
}
function doCancel()
{   
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="comproposal";
		document.forms[0].hidBeanMethod.value="updateBGassessment";
		document.forms[0].hidBeanGetMethod.value="getBGassessment";
		document.forms[0].action=appURL+"action/com_bgassessment.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
}
function getValues()
{
	document.forms[0].hidBeanId.value="comproposal";
	document.forms[0].hidBeanGetMethod.value="getBGassessment";
	document.forms[0].action=appURL+"action/com_bgassessment.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
}
function callCalender(val)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		 showCal(appUrl,val);
	}
}
function calculate()
{
	if(document.forms[0].txtAmount1[0].value=="")
		document.forms[0].txtAmount1[0].value="0.00";
	if(document.forms[0].txtAmount1[1].value=="")
		document.forms[0].txtAmount1[1].value="0.00";
	if(document.forms[0].txtAmount1[2].value=="")
		document.forms[0].txtAmount1[2].value="0.00";
	if(document.forms[0].txtAmount1[5].value=="")
		document.forms[0].txtAmount1[5].value="0.00";
	document.forms[0].txtAmount1[3].value=eval(document.forms[0].txtAmount1[0].value)+eval(document.forms[0].txtAmount1[1].value)-eval(document.forms[0].txtAmount1[2].value);

	document.forms[0].txtAmount1[4].value=(eval(document.forms[0].txtAmount1[3].value)*eval(varMargin))/100;

	if(document.forms[0].txtAmount1[5].value=="")
		document.forms[0].txtAmount1[5].value="0.00";
	
	if(eval(strMithraFacTot)<eval(document.forms[0].txtAmount1[5].value))
	{
		alert("Limit Applied value shuould not be greater than Proposed Limit "+strMithraFacTot);
		document.forms[0].txtAmount1[5].value="";
		return;
		
	}

	if(eval(document.forms[0].txtAmount1[4].value)>eval(document.forms[0].txtAmount1[5].value))
	{
		document.forms[0].txtAmount1[6].value=document.forms[0].txtAmount1[5].value;
	}
	else
	{
		document.forms[0].txtAmount1[6].value=document.forms[0].txtAmount1[4].value;
	}

	document.forms[0].txtAmount1[6].value=roundVal(document.forms[0].txtAmount1[6].value);

}
function calculate1()
{
	if(document.forms[0].txtAmount[1].value=="")
	{
		document.forms[0].txtAmount[1].value="0.00";
	}
	if(document.forms[0].txtAmount[2].value=="")
	{
		document.forms[0].txtAmount[2].value="0.00";
	}
	if(document.forms[0].txtAmount[3].value=="")
	{
		document.forms[0].txtAmount[3].value="0.00";
	}
	if(document.forms[0].txtAmount[4].value=="")
	{
		document.forms[0].txtAmount[4].value="0.00";
	}
	if(document.forms[0].txtAmount[5].value=="")
	{
		document.forms[0].txtAmount[5].value="0.00";
	}
	if(document.forms[0].txtAmount[6].value=="")
	{
		document.forms[0].txtAmount[6].value="0.00";
	}
	document.forms[0].txtAmount[7].value=eval(document.forms[0].txtAmount[1].value)+eval(document.forms[0].txtAmount[2].value)+eval(document.forms[0].txtAmount[3].value)+eval(document.forms[0].txtAmount[4].value)+eval(document.forms[0].txtAmount[5].value)+eval(document.forms[0].txtAmount[6].value);
	document.forms[0].txtAmount[7].value=roundVal(document.forms[0].txtAmount[7].value);

	var varLeastAmount;
	if(eval(document.forms[0].txtAmount[7].value)>eval(varFacProposed))
	{
		varLeastAmount=varFacProposed;
	}
	else
	{
		varLeastAmount=eval(document.forms[0].txtAmount[7].value);
	}

	if(eval(document.forms[0].txtAmount[8].value)>eval(varLeastAmount))
	{
		alert("Recommended Limit should be Total Interest or Proposed Limit which ever is less");
		document.forms[0].txtAmount[8].value="";
		return;
	}
	
}
function calculate3()
{
	if(document.forms[0].txtAmount3[0].value=="")
		document.forms[0].txtAmount3[0].value="0.00";
	if(document.forms[0].txtAmount3[1].value=="")
		document.forms[0].txtAmount3[1].value="0.00";
	if(document.forms[0].txtAmount3[2].value=="")
		document.forms[0].txtAmount3[2].value="0.00";
	if(document.forms[0].txtAmount3[5].value=="")
		document.forms[0].txtAmount3[5].value="0.00";


	document.forms[0].txtAmount3[3].value=(eval(document.forms[0].txtAmount3[2].value)*eval(varMarginAss1))/100;

	document.forms[0].txtAmount3[4].value=(eval(document.forms[0].txtAmount3[0].value)*eval(varMarginAss2))/100;

	if(eval(document.forms[0].txtAmount3[4].value)>eval(document.forms[0].txtAmount3[5].value))
	{
		document.forms[0].txtAmount3[6].value=document.forms[0].txtAmount3[5].value;
	}
	else
	{
		document.forms[0].txtAmount3[6].value=document.forms[0].txtAmount3[4].value;
	}

	document.forms[0].txtAmount3[6].value=roundVal(document.forms[0].txtAmount3[6].value);
}
function additionValues()
{
	if(document.forms[0].txtAmount3[0].value=="")
		document.forms[0].txtAmount3[0].value="0.00";
	if(document.forms[0].txtAmount3[1].value=="")
		document.forms[0].txtAmount3[1].value="0.00";
	if(document.forms[0].txtAmount3[3].value=="")
		document.forms[0].txtAmount3[3].value="0.00";
	if(document.forms[0].txtAmount3[4].value=="")
		document.forms[0].txtAmount3[4].value="0.00";
	document.forms[0].txtAmount3[2].value=roundVal(eval(document.forms[0].txtAmount3[0].value)+eval(document.forms[0].txtAmount3[1].value));
	document.forms[0].txtAmount3[5].value=roundVal(eval(document.forms[0].txtAmount3[3].value)+eval(document.forms[0].txtAmount3[4].value));
	document.forms[0].txtAmount3[6].value=roundVal(eval(document.forms[0].txtAmount3[2].value)+eval(document.forms[0].txtAmount3[5].value));
	
}


function additionValues9()
{
	if(document.forms[0].txtAmount9[11].value=="")
		document.forms[0].txtAmount9[11].value="0.00";
	if(document.forms[0].txtAmount9[10].value=="")
		document.forms[0].txtAmount9[10].value="0.00";
	if(document.forms[0].txtAmount9[13].value=="")
		document.forms[0].txtAmount9[13].value="0.00";
	if(document.forms[0].txtAmount9[14].value=="")
		document.forms[0].txtAmount9[14].value="0.00";
	if(document.forms[0].txtAmount9[15].value=="")
		document.forms[0].txtAmount9[15].value="0.00";
	if(document.forms[0].txtAmount9[19].value=="")
		document.forms[0].txtAmount9[19].value="0.00";
	if(document.forms[0].txtAmount9[16].value=="")
		document.forms[0].txtAmount9[16].value="0.00";
	if(document.forms[0].txtAmount9[17].value=="")
		document.forms[0].txtAmount9[17].value="0.00";
	if(document.forms[0].txtAmount9[18].value=="")
		document.forms[0].txtAmount9[18].value="0.00";
	if(document.forms[0].txtAmount9[20].value=="")
		document.forms[0].txtAmount9[20].value="0.00";
	if(document.forms[0].txtAmount9[21].value=="")
		document.forms[0].txtAmount9[21].value="0.00";

	if(document.forms[0].txtAmount9[0].value=="")
		document.forms[0].txtAmount9[0].value="0.00";
	if(document.forms[0].txtAmount9[1].value=="")
		document.forms[0].txtAmount9[1].value="0.00";

	if(document.forms[0].txtAmount9[3].value=="")
		document.forms[0].txtAmount9[3].value="0.00";
	if(document.forms[0].txtAmount9[4].value=="")
		document.forms[0].txtAmount9[4].value="0.00";


	if(document.forms[0].txtAmount9[6].value=="")
		document.forms[0].txtAmount9[6].value="0.00";
	if(document.forms[0].txtAmount9[7].value=="")
		document.forms[0].txtAmount9[7].value="0.00";
	
	document.forms[0].txtAmount9[2].value=roundVal(eval(document.forms[0].txtAmount9[0].value)+eval(document.forms[0].txtAmount9[1].value));
	document.forms[0].txtAmount9[5].value=roundVal(eval(document.forms[0].txtAmount9[3].value)+eval(document.forms[0].txtAmount9[4].value));
	document.forms[0].txtAmount9[6].value=roundVal(eval(document.forms[0].txtAmount9[3].value)+eval(document.forms[0].txtAmount9[0].value));
	document.forms[0].txtAmount9[7].value=roundVal(eval(document.forms[0].txtAmount9[1].value)+eval(document.forms[0].txtAmount9[4].value));
	
	document.forms[0].txtAmount9[8].value=roundVal(eval(document.forms[0].txtAmount9[6].value)+eval(document.forms[0].txtAmount9[7].value));
	
	document.forms[0].txtAmount9[12].value=roundVal(eval(document.forms[0].txtAmount9[10].value)+eval(document.forms[0].txtAmount9[11].value));
	
	document.forms[0].txtAmount9[15].value=roundVal(eval(document.forms[0].txtAmount9[14].value)+eval(document.forms[0].txtAmount9[13].value));
	document.forms[0].txtAmount9[18].value=roundVal(eval(document.forms[0].txtAmount9[17].value)+eval(document.forms[0].txtAmount9[16].value));
	
	document.forms[0].txtAmount9[19].value=roundVal(eval(document.forms[0].txtAmount9[13].value)+eval(document.forms[0].txtAmount9[16].value));
	document.forms[0].txtAmount9[20].value=roundVal(eval(document.forms[0].txtAmount9[14].value)+eval(document.forms[0].txtAmount9[17].value));
	document.forms[0].txtAmount9[21].value=roundVal(eval(document.forms[0].txtAmount9[20].value)+eval(document.forms[0].txtAmount9[19].value));
	//document.forms[0].txtAmount9[22].value=roundVal(eval(document.forms[0].txtAmount9[15].value)+eval(document.forms[0].txtAmount9[18].value));
	
	//14+17=20
	//15+18=21
	//document.forms[0].txtAmount3[6].value=roundVal(eval(document.forms[0].txtAmount3[2].value)+eval(document.forms[0].txtAmount3[5].value));
	
}


function getPercentageofNumber()
{
	
	{
		//value of I
		var valueOfG=document.forms[0].txtAmount3[6].value;
		var percentOfG=(valueOfG*varMarginAss1)/100;
		document.forms[0].txtAmount3[8].value=NanNumber(percentOfG);
		document.forms[0].txtAmount3[8].value=roundVal(eval(percentOfG));

		//value of J
		var valueOfJ=eval(document.forms[0].txtAmount3[1].value)+eval(document.forms[0].txtAmount3[4].value);
		var percentOfJ=(valueOfJ*varMarginAss2)/100;
		document.forms[0].txtAmount3[9].value=NanNumber(document.forms[0].txtAmount3[9].value);
		document.forms[0].txtAmount3[9].value=roundVal(eval(percentOfJ));

		//value of K
		var valueOfK=document.forms[0].txtAmount3[10].value;
		if(valueOfK=="")
			valueOfK="0.00"
				
		var num1Int = parseInt(percentOfG);
		var num2Int = parseInt(percentOfJ);
		var num3Int = parseInt(valueOfK);
		var valueOfL = Math.min(num1Int, num2Int, num3Int);
		
		document.forms[0].txtAmount3[11].value=roundVal(eval(valueOfL));
		
	}
	
}


function getPercentageofNumber9()
{

		//value of I
		var valueOf7=document.forms[0].txtAmount9[7].value;
		//alert(valueOf7);
		var percentOf10=(valueOf7*vardbgecl1sno10)/100;
		//alert(percentOf10);
		document.forms[0].txtAmount9[9].value=NanNumber(percentOf10);
		document.forms[0].txtAmount9[9].value=roundVal(eval(percentOf10));
	//}
	
	//function getPercentageofNumber923()
	//{
		//alert("document.forms[0].txtAmount9[7].value"+document.forms[0].txtAmount9[7].value);
		//alert("document.forms[0].txtAmount9[20].value"+document.forms[0].txtAmount9[20].value);
		//alert("document.forms[0].txtAmount9[12].value"+document.forms[0].txtAmount9[12].value);
		//alert("document.forms[0].txtAmount9[7].valuevardbgecl1sno23"+vardbgecl1sno23);
		   


		
		var valueOf7=document.forms[0].txtAmount9[7].value;
		var valueOf20=roundVal(eval(document.forms[0].txtAmount9[14].value)+eval(document.forms[0].txtAmount9[17].value));//document.forms[0].txtAmount9[20].value;
		var valueOf12=document.forms[0].txtAmount9[12].value;

		
		/*var percentOf7=(valueOf7*vardbgecl1sno23)/100;
		var percentOf7val=percentOf7-document.forms[0].txtAmount9[12].value;

        var percentof20=(valueOf20*vardbgecl1sno23)/100;
        var percentOf20val=percentof20-document.forms[0].txtAmount9[12].value;*/


        if(appstatus==Open/Pending)
        {
        var value7=valueOf7-document.forms[0].txtAmount9[12].value;
        var percentOf7=(value7*vardbgecl1sno23)/100;
        
		var value20=valueOf20-document.forms[0].txtAmount9[12].value;
		var percentof20=(value20*vardbgecl1sno23)/100;

        var percentOf7valint = parseInt(percentOf7);
		var percentOf20valint = parseInt(percentof20);

		//alert("percentOf7valint   "+percentOf7valint);
		//alert("percentOf20valint  "+percentOf20valint);
        if(percentOf7valint>percentOf20valint)
        {
        	percentOf7=percentOf7-document.forms[0].txtAmount9[12].value;
    		document.forms[0].txtAmount9[22].value=NanNumber(percentOf7);
    		document.forms[0].txtAmount9[22].value=roundVal(eval(percentOf7));
    		var var22val=percentOf7;
        }
        else
        {
        	percentof20=percentof20-document.forms[0].txtAmount9[12].value;
        	document.forms[0].txtAmount9[22].value=NanNumber(percentof20);
    		document.forms[0].txtAmount9[22].value=roundVal(eval(percentof20));
    		var var22val=percentof20;
        }
        }

        var var23=parseInt(vardbgecl1sno24);
        if(appstatus==Open/Pending)
        {
        var var22=parseInt(var22val);
        }
        else
            {
        	 var var22=document.forms[0].txtAmount9[22].value;
            }

        //document.forms[0].txtAmount9[22].value;
//alert("var23"+var23);
//alert("var22"+var22);

//var num1Int = parseInt(var23);
//var num2Int = parseInt(var22);

//var valueOfY = Math.min(num1Int, num2Int);
//alert("valueOfY"+valueOfY);

//document.forms[0].txtAmount9[24].value=roundVal(eval(valueOfY));
//document.forms[0].txtAmount9[23].value=vardbgecl1sno24;
        if(var22>var23)
        {
        	document.forms[0].txtAmount9[24].value=roundVal(eval(var23));
        
         }	
        else

        {
        	document.forms[0].txtAmount9[24].value=roundVal(eval(var22));   
        }
        }	

		//value of J
	/*	var valueOfJ=eval(document.forms[0].txtAmount3[1].value)+eval(document.forms[0].txtAmount3[4].value);
		var percentOfJ=(valueOfJ*varMarginAss2)/100;
		document.forms[0].txtAmount3[9].value=NanNumber(document.forms[0].txtAmount3[9].value);
		document.forms[0].txtAmount3[9].value=roundVal(eval(percentOfJ));

		//value of K
		var valueOfK=document.forms[0].txtAmount3[10].value;
		if(valueOfK=="")
			valueOfK="0.00"
				
		var num1Int = parseInt(percentOfG);
		var num2Int = parseInt(percentOfJ);
		var num3Int = parseInt(valueOfK);
		var valueOfL = Math.min(num1Int, num2Int, num3Int);
		
		document.forms[0].txtAmount3[11].value=roundVal(eval(valueOfL));*/
		
function getPercentageofNumber92()
		{
//alert("1");
//alert("23"+document.forms[0].txtAmount9[23].value);
//alert("22"+document.forms[0].txtAmount9[22].value);
			  if(document.forms[0].txtAmount9[23].value<document.forms[0].txtAmount9[22].value)
		        {
				  //alert("if");
		        	document.forms[0].txtAmount9[24].value=document.forms[0].txtAmount9[23].value;
		        
		         }	
		        else
//alert("else");
		        {
		        	document.forms[0].txtAmount9[24].value=document.forms[0].txtAmount9[22].value;   
		        }
		}
		
function getFacilityDetails()
{
	
	document.forms[0].hidBeanId.value = "comproposal";
	document.forms[0].hidBeanGetMethod.value = "getBGassessment";
	document.forms[0].action = appURL + "action/com_bgassessment.jsp";
	document.forms[0].submit();

}
function chkmaxVal(obj,val)
{
	if(val=="")
	{
		val=0;
	}
	if(eval(obj.value)>eval(val))
	{
		alert("Value should not be grater than "+val);
		obj.value="";
		return;
	}
}
function chkloanAmt(obj)
{
	if(eval(obj.value)>eval(varFacProposed))
	{
		alert("Limit should not be greater than Proposed Limit");
		obj.value="";
		obj.focus();
		return;
	}
}
function additionValuesgecl2()
{
	
	document.forms[0].txtAmount5[2].value=roundVal(eval(document.forms[0].txtAmount5[0].value)+eval(document.forms[0].txtAmount5[1].value));
	document.forms[0].txtAmount5[5].value=roundVal(eval(document.forms[0].txtAmount5[3].value)+eval(document.forms[0].txtAmount5[4].value));
	document.forms[0].txtAmount5[6].value=roundVal(eval(document.forms[0].txtAmount5[0].value)+eval(document.forms[0].txtAmount5[3].value));
	document.forms[0].txtAmount5[7].value=roundVal(eval(document.forms[0].txtAmount5[1].value)+eval(document.forms[0].txtAmount5[4].value));
	
	
}

function getPercentageofNumbergecl2()
{
	
		//value of k
		var valueOfk=eval(document.forms[0].txtAmount5[6].value)+eval(document.forms[0].txtAmount5[7].value);
		var percentOfk=(valueOfk*varMargingecl2limt)/100;
		document.forms[0].txtAmount5[10].value=roundVal(eval(percentOfk));
		//value of l
		var valueOfL=document.forms[0].txtAmount5[7].value;
		var percentOfL=(valueOfL*varMargingecl2banklimt)/100;
		document.forms[0].txtAmount5[11].value=roundVal(eval(percentOfL));
		
	}
function selchangeval(){
	 if(vargecltype=="GECL2"){
	if(document.forms[0].txtAmount5[16].value=="Yes"){
			document.all.id_geclval1.style.visibility = "visible";
			document.all.id_geclval1.style.position = "relative";
			document.all.id_geclval2.style.visibility = "visible";
			document.all.id_geclval2.style.position = "relative";
			document.all.id_geclval3.style.visibility = "visible";
			document.all.id_geclval3.style.position = "relative";
			
		}
		else {	
			document.all.id_geclval1.style.visibility = "hidden";
			document.all.id_geclval1.style.position = "absolute";
			document.all.id_geclval2.style.visibility = "hidden";
			document.all.id_geclval2.style.position = "absolute";
			document.all.id_geclval3.style.visibility = "hidden";
			document.all.id_geclval3.style.position = "absolute";
			document.forms[0].txtAmount5[17].value="";
			document.forms[0].txtAmount5[18].value="";
			document.forms[0].txtAmount5[19].value="";
			
		}	
	 }
}

function selperchkval(){
	var valueOfk=document.forms[0].txtAmount5[10].value;
	var valueOfQ=eval(document.forms[0].txtAmount5[18].value)+eval(document.forms[0].txtAmount5[19].value)
	if(eval(valueOfk)<eval(valueOfQ))
	{
		alert(" limit recommended/proposed (considering the entire exposure with all MLI's) funbased+ nonfundbased  cannot be greater than K");
		document.forms[0].txtAmount5[18].value="";
		document.forms[0].txtAmount5[19].value="";
		return;
	}
}
function selperchkval12(){
	var valueOfL=document.forms[0].txtAmount5[11].value;
	var valueOfN=eval(document.forms[0].txtAmount5[14].value)+eval(document.forms[0].txtAmount5[15].value)
	if(eval(valueOfL)<eval(valueOfN))
	{
		alert("Total Limit Recommended/Proposed (considering only our Bank's Exposure) funbased+ nonfundbased  cannot be greater than L");
		document.forms[0].txtAmount5[14].value="";
		document.forms[0].txtAmount5[15].value="";
		return;
	}
}

function chkmaxValgecl(obj,val1,val2){
	if(val1=="")
	{
		val1="0.00";
	}
	if(val2=="")
	{
		val2="0.00";
			
	}
	if((eval(obj.value)<eval(val1))||(eval(obj.value)>eval(val2)))
	{
		alert("Value should  be with in the range"+val1+"-"+val2);
		obj.value="";
		return;
	}
	
}


function chkamtvalgecl1(obj,val,val2){

	//alert("obj"+obj);
	//alert("val"+val);
	//alert("val2"+val2);
	
	if(val=="")
	{
		val="0.00";
	} 
	if(val2=="")
	{
		val="0";
	} 
	
	
	var percentOfoverdue=(eval(val)*val2)/100;
	//alert("====percentOfoverdue==="+percentOfoverdue);
	if(eval(obj.value)>eval(percentOfoverdue))
	{	
	 
		alert("amount here should not exceed"+ val2+"% of the total proposed amount"+eval(percentOfoverdue));
		obj.value="";
		return;
	}
	
}


function chkamtvalgecl(obj,val,val2){

	//alert("obj"+obj);
	//alert("val"+val);
	//alert("val2"+val2);
	
	if(val=="")
	{
		val="0.00";
	} 
	if(val2=="")
	{
		val="0";
	} 
	
	
	var percentOfoverdue=(eval(val)*val2)/100;
	//alert("====percentOfoverdue==="+percentOfoverdue);
	if(eval(obj.value)>eval(percentOfoverdue))
	{	
	 
		alert("amount here should not exceed"+ val2+"% of the total proposed amount"+eval(percentOfoverdue));
		//obj.value="";
		return;
	}
	
}
function chkmaxValgeclamtchk(obj,val){
	//alert("obj2"+obj);
	//alert("val2"+val);
	if(val=="")
	{
		val="0.00";
	} 
	if(eval(val)!=""||eval(val)!="0.00"){
		//alert("obj.value"+obj.value);
	if(eval(obj.value)!=eval(val)){
		
		alert("Criteria Amount of overdue and assesment Amount Overdue should be equal");
		obj.value="";
		return;
	}
	}
}

function chkasscriteraiamtchk(){
	var varciteraiamt=varcriteriaamt;
	var varassesmentamt=eval(document.forms[0].txtAmount5[8].value);
	if(eval(varcriteriaamt)!=""){
if(eval(varassesmentamt)!=eval(varciteraiamt)){
		
		alert("Assesment Amount of overdue and Criteria Amount Overdue should be equal");
		document.forms[0].txtAmount5[8].value="";
		return;
	}
	}
}
//gecl3 calculations
function additionValuesgecl3()
{
	if(document.forms[0].txtAmount6[12].value=="")
		document.forms[0].txtAmount6[12].value="0.00";
	if(document.forms[0].txtAmount6[13].value=="")
		document.forms[0].txtAmount6[13].value="0.00";
	document.forms[0].txtAmount6[2].value=roundVal(eval(document.forms[0].txtAmount6[0].value)+eval(document.forms[0].txtAmount6[1].value));
	document.forms[0].txtAmount6[5].value=roundVal(eval(document.forms[0].txtAmount6[3].value)+eval(document.forms[0].txtAmount6[4].value));
	document.forms[0].txtAmount6[6].value=roundVal(eval(document.forms[0].txtAmount6[0].value)+eval(document.forms[0].txtAmount6[3].value));
	document.forms[0].txtAmount6[7].value=roundVal(eval(document.forms[0].txtAmount6[1].value)+eval(document.forms[0].txtAmount6[4].value));
	document.forms[0].txtAmount6[14].value=roundVal(eval(document.forms[0].txtAmount6[11].value)-eval(document.forms[0].txtAmount6[12].value)-eval(document.forms[0].txtAmount6[13].value));
	
	
}

function getPercentageofNumbergecl3()
{
	
		//value of k
		var valueOfk=eval(document.forms[0].txtAmount6[6].value)+eval(document.forms[0].txtAmount6[7].value);
		var percentOfk=(valueOfk*varMargingecl3limt)/100;
		document.forms[0].txtAmount6[10].value=roundVal(eval(percentOfk));
		//value of l
		var valueOfL=document.forms[0].txtAmount6[7].value;
		var percentOfL=(valueOfL*varMargingecl3banklimt)/100;
		document.forms[0].txtAmount6[11].value=roundVal(eval(percentOfL));
		
	}
function selchangegecl3val(){
	if(document.forms[0].txtAmount6[17].value=="Yes"){
			document.all.id_gecl3val.style.visibility = "visible";
			document.all.id_gecl3val.style.position = "relative";
			document.all.id_gecl3val1.style.visibility = "visible";
			document.all.id_gecl3val1.style.position = "relative";
		}
		else {	
			document.all.id_gecl3val.style.visibility = "hidden";
			document.all.id_gecl3val.style.position = "absolute";
			document.all.id_gecl3val1.style.visibility = "hidden";
			document.all.id_gecl3val1.style.position = "absolute";
			document.forms[0].txtAmount6[18].value="";
			document.forms[0].txtAmount6[19].value="";
			
		}	
}

function selperchkvalgecl3(){
	var valueOfk=eval(document.forms[0].txtAmount6[10].value);
	var valueOfT=eval(document.forms[0].txtAmount6[19].value);
	var valueOfO=eval(document.forms[0].txtAmount6[14].value);
	var valueOfP=eval(document.forms[0].txtAmount6[15].value);
	var valueOfQ=eval(document.forms[0].txtAmount6[16].value);
	
	if(eval(valueOfT)>eval(valueOfk))
	{
		alert("If NOC submitted, limit recommended/proposed considering the entire exposure with all MLI's cannot be greater than K");
		document.forms[0].txtAmount6[19].value="";
		return;
	}
	
	if(eval(valueOfQ)>eval(valueOfO))
	{
		alert("Limit recommended  considering our Banks Exposure Only cannot be greater than O");
		document.forms[0].txtAmount6[16].value="";
		return;
	}
	if(eval(valueOfQ)>eval(valueOfP))
	{
		alert("Limit recommended  considering our Banks Exposure Only cannot be greater than P");
		document.forms[0].txtAmount6[16].value="";
		return;
	}
}

function chkasscriteraiamtchk3(){
	var varciteraiamt=varcriteriaamt;
	var varassesmentamt=eval(document.forms[0].txtAmount6[8].value);
	
	if(eval(varcriteriaamt)!=""||eval(varcriteriaamt)!="0.00"){
if(eval(varassesmentamt)!=eval(varciteraiamt)){
		
		alert("Assesment Amount of overdue and Criteria Amount Overdue should be equal");
		document.forms[0].txtAmount6[8].value="";
		return;
	}
	}
}
function selchangevalgecl4(){
	if(document.forms[0].txtAmount7[1].value=="Yes"){
		document.all.id_gecl4.style.visibility = "visible";
		document.all.id_gecl4.style.position = "relative";
	}
	else {	
		document.all.id_gecl4.style.visibility = "hidden";
		document.all.id_gecl4.style.position = "absolute";
		document.forms[0].txtAmount7[2].value="0"
	}	
}
function chkassesmentgecl4(){
	var varciteraiamt=eval(document.forms[0].txtAmount7[4].value);
	var varassesmentamt=eval(document.forms[0].txtAmount7[3].value);
	var varlimtrec=eval(document.forms[0].txtAmount7[5].value);
	var varlimitproposed=eval(document.forms[0].txtAmount7[6].value);
	
	
	
	if(eval(varciteraiamt)>eval(varassesmentamt))
	{
		alert("Margin Amount value shuould not be greater than Project cost as per Quotation/estimation ");
		document.forms[0].txtAmount7[4].value="";
		return;
	}
	if(eval(varlimitproposed)>eval(varlimtrec))
	{
		alert("Limit proposed and recommended with in the range of "+eval(varlimtrec));
		document.forms[0].txtAmount7[5].value="";
		return;
	}
	
	
	
}
function vargecl4margin(){
	var varciteraiamt=eval(document.forms[0].txtAmount7[4].value);
	if(eval(varciteraiamt)<=0){
		document.forms[0].txtAmount7[4].value=0;
	}else{
		document.forms[0].txtAmount7[4].value=varciteraiamt;
	}
}
function getPercentageofgecl1rest()
{
	
		//value of k
		var valueOfk=eval(document.forms[0].txtAmount8[0].value);
		var percentOfk=(valueOfk*varbaloutstanding)/100;
		document.forms[0].txtAmount8[1].value=roundVal(eval(percentOfk));
	}




function additionValues11()
{
	if(document.forms[0].txtAmount11[0].value=="")
		document.forms[0].txtAmount11[0].value="0.00";
	if(document.forms[0].txtAmount11[1].value=="")
		document.forms[0].txtAmount11[1].value="0.00";
	if(document.forms[0].txtAmount11[3].value=="")
		document.forms[0].txtAmount11[3].value="0.00";
	if(document.forms[0].txtAmount11[4].value=="")
		document.forms[0].txtAmount11[4].value="0.00";
if(document.forms[0].txtAmount11[5].value=="")
		document.forms[0].txtAmount11[5].value="0.00";
	if(document.forms[0].txtAmount11[6].value=="")
		document.forms[0].txtAmount11[6].value="0.00";
	if(document.forms[0].txtAmount11[7].value=="")
		document.forms[0].txtAmount11[7].value="0.00";		
		if(document.forms[0].txtAmount11[11].value=="")
		document.forms[0].txtAmount11[11].value="0.00";
	if(document.forms[0].txtAmount11[10].value=="")
		document.forms[0].txtAmount11[10].value="0.00";
	if(document.forms[0].txtAmount11[13].value=="")
		document.forms[0].txtAmount11[13].value="0.00";
	if(document.forms[0].txtAmount11[14].value=="")
		document.forms[0].txtAmount11[14].value="0.00";
	if(document.forms[0].txtAmount11[15].value=="")
		document.forms[0].txtAmount11[15].value="0.00";
	if(document.forms[0].txtAmount11[19].value=="")
		document.forms[0].txtAmount11[19].value="0.00";
	if(document.forms[0].txtAmount11[16].value=="")
		document.forms[0].txtAmount11[16].value="0.00";
	if(document.forms[0].txtAmount11[17].value=="")
		document.forms[0].txtAmount11[17].value="0.00";
	if(document.forms[0].txtAmount11[18].value=="")
		document.forms[0].txtAmount11[18].value="0.00";
	if(document.forms[0].txtAmount11[20].value=="")
		document.forms[0].txtAmount11[20].value="0.00";
	if(document.forms[0].txtAmount11[21].value=="")
		document.forms[0].txtAmount11[21].value="0.00";
	
	document.forms[0].txtAmount11[2].value=roundToTwo(eval(document.forms[0].txtAmount11[0].value)+eval(document.forms[0].txtAmount11[1].value));
	document.forms[0].txtAmount11[5].value=roundToTwo(eval(document.forms[0].txtAmount11[3].value)+eval(document.forms[0].txtAmount11[4].value));
	document.forms[0].txtAmount11[6].value=roundToTwo(eval(document.forms[0].txtAmount11[3].value)+eval(document.forms[0].txtAmount11[0].value));
	document.forms[0].txtAmount11[7].value=roundToTwo(eval(document.forms[0].txtAmount11[1].value)+eval(document.forms[0].txtAmount11[4].value));
	document.forms[0].txtAmount11[8].value=roundToTwo(eval(document.forms[0].txtAmount11[2].value)+eval(document.forms[0].txtAmount11[5].value));	
	document.forms[0].txtAmount11[13].value=roundToTwo(eval(document.forms[0].txtAmount11[11].value)+eval(document.forms[0].txtAmount11[12].value));	
	document.forms[0].txtAmount11[16].value=roundToTwo(eval(document.forms[0].txtAmount11[14].value)+eval(document.forms[0].txtAmount11[15].value));
	document.forms[0].txtAmount11[17].value=roundToTwo(eval(document.forms[0].txtAmount11[11].value)+eval(document.forms[0].txtAmount11[14].value));	
	document.forms[0].txtAmount11[18].value=roundToTwo(eval(document.forms[0].txtAmount11[12].value)+eval(document.forms[0].txtAmount11[15].value));
	document.forms[0].txtAmount11[19].value=roundToTwo(eval(document.forms[0].txtAmount11[13].value)+eval(document.forms[0].txtAmount11[16].value));	
}

function getPercentageofNumber11()
{
		//value of I
		var valueOf7=document.forms[0].txtAmount11[7].value;
		//alert(valueOf7);
		var percentOf10=(valueOf7*varCOM_GECL2EXT_MAXELGFINANCE)/100;
		//alert(percentOf10);
		document.forms[0].txtAmount11[9].value=NanNumber(percentOf10);
		//document.forms[0].txtAmount11[9].value=roundVal(eval(percentOf10));
		document.forms[0].txtAmount11[9].value=roundToTwo(eval(percentOf10));
		
		var valueOf7=document.forms[0].txtAmount11[7].value;
		var valueOf18=roundToTwo(eval(document.forms[0].txtAmount11[12].value)+eval(document.forms[0].txtAmount11[15].value));
		var valueOf10=document.forms[0].txtAmount11[10].value;

		//7,18,10
		/*var percentOf7=(valueOf7*varCOM_GECL2EXT_ELGFINANCE)/100;
		var percentOf7val=percentOf7-document.forms[0].txtAmount11[10].value;

        var percentof18=(valueOf18*varCOM_GECL2EXT_ELGFINANCE)/100;
        var percentOf18val=percentof18-document.forms[0].txtAmount11[10].value;*/



        
        var value7=valueOf7;//-document.forms[0].txtAmount11[10].value;
        var percentOf7=(value7*varCOM_GECL2EXT_ELGFINANCE)/100;
        
		var value18=valueOf18-document.forms[0].txtAmount11[10].value;
		var percentof18=(value18*varCOM_GECL2EXT_ELGFINANCE)/100;

        var percentOf7valint = parseInt(percentOf7);
		var percentOf18valint = parseInt(percentof18);

		//alert("percentOf7valint   "+percentOf7valint);
		//alert("percentOf18valint  "+percentOf18valint);
        if(percentOf7valint>percentOf18valint)
        {
        	percentOf7=percentOf7-document.forms[0].txtAmount11[10].value;
    		document.forms[0].txtAmount11[20].value=NanNumber(percentOf7);
    		//document.forms[0].txtAmount11[20].value=roundVal(eval(percentOf7));
    		document.forms[0].txtAmount11[20].value=roundToTwo(eval(percentOf7));
    		var var20val=percentOf7;
        }
        else
        {
        	percentof18=percentof18-document.forms[0].txtAmount11[10].value;
        	document.forms[0].txtAmount11[20].value=NanNumber(percentof18);
    		//document.forms[0].txtAmount11[20].value=roundVal(eval(percentof18));
    		document.forms[0].txtAmount11[20].value=roundToTwo(eval(percentof18));
    		var var20val=percentof18;
        }


        var var21=parseInt(vargecl2sno24);
        var var20=parseInt(var20val);
        if(var20>var21)
        {
        	//document.forms[0].txtAmount11[22].value=roundVal(eval(var21));
        	document.forms[0].txtAmount11[22].value=roundToTwo(eval(vargecl2sno24));
        
         }	
        else

        {
        	//document.forms[0].txtAmount11[22].value=roundVal(eval(var20));   
        	document.forms[0].txtAmount11[22].value=roundToTwo(eval(var20val)); 
        }
        }	


function roundToTwo(trate) { 
	//alert("===="+Math.round(num + "e+2")  + "e-2"));
   return +(Math.round(trate + "e+2")  + "e-2");
   
	/*var temp2="";
	if (trate.value==".") trate.value=0;
	var temp1= new Number(trate.value);
	var floc=0;
	temp=new String(Math.round(temp1*100));
	temp2=String(temp/100);
	if (temp==0)
	{
		temp2="0.00";
	}
	if (temp2.substr(0,1)==".") temp2="0"+temp2;
	if (temp2.substr(temp2.length-2,1)==".") temp2=temp2+"0";
	if (parseInt(temp2.lastIndexOf("."))<0)
	{	
		temp2 = temp2+".00";
	}
	trate.value = temp2;
	return trate.value;*/

	/*var temp2="";
	if (trate==".") trate=0;
	var temp1= new Number(trate);
	var floc=0;
	if (temp1!=0.0)
	{
		if(Math.abs(temp1)>=0.01 && Math.abs(temp1)<0.1 )
		{
			return parseFloat(temp1).toFixed(2);
		}
		else if(Math.abs(temp1)>=0 && Math.abs(temp1)<=0.01 )
		{
			return parseFloat(temp1).toFixed(3);
		}
		else
		{
			temp=new String(Math.round(temp1*100));
			temp2=temp.substr(0,temp.length-2)+"."+temp.substr(temp.length-2,2);
		}
		
	}
	else
	{
		temp2="0.00";
	}
	if (temp2.substr(0,1)==".") 	
	temp2="0"+temp2;
	trate=temp2;	
	return trate;*///round(trate,2);
}


function additionValues10()
{
	

	if(document.forms[0].txtAmount10[0].value=="")
		document.forms[0].txtAmount10[0].value="0.00";
	if(document.forms[0].txtAmount10[1].value=="")
		document.forms[0].txtAmount10[1].value="0.00";

	if(document.forms[0].txtAmount10[3].value=="")
		document.forms[0].txtAmount10[3].value="0.00";
	if(document.forms[0].txtAmount10[4].value=="")
		document.forms[0].txtAmount10[4].value="0.00";

if(document.forms[0].txtAmount10[5].value=="")
		document.forms[0].txtAmount10[5].value="0.00";

	if(document.forms[0].txtAmount10[6].value=="")
		document.forms[0].txtAmount10[6].value="0.00";
	if(document.forms[0].txtAmount10[7].value=="")
		document.forms[0].txtAmount10[7].value="0.00";
		
		if(document.forms[0].txtAmount10[11].value=="")
		document.forms[0].txtAmount10[11].value="0.00";
	if(document.forms[0].txtAmount10[10].value=="")
		document.forms[0].txtAmount10[10].value="0.00";
	if(document.forms[0].txtAmount10[13].value=="")
		document.forms[0].txtAmount10[13].value="0.00";
	if(document.forms[0].txtAmount10[14].value=="")
		document.forms[0].txtAmount10[14].value="0.00";
	if(document.forms[0].txtAmount10[15].value=="")
		document.forms[0].txtAmount10[15].value="0.00";
	if(document.forms[0].txtAmount10[19].value=="")
		document.forms[0].txtAmount10[19].value="0.00";
	if(document.forms[0].txtAmount10[16].value=="")
		document.forms[0].txtAmount10[16].value="0.00";
	if(document.forms[0].txtAmount10[17].value=="")
		document.forms[0].txtAmount10[17].value="0.00";
	if(document.forms[0].txtAmount10[18].value=="")
		document.forms[0].txtAmount10[18].value="0.00";
	if(document.forms[0].txtAmount10[20].value=="")
		document.forms[0].txtAmount10[20].value="0.00";
	if(document.forms[0].txtAmount10[21].value=="")
		document.forms[0].txtAmount10[21].value="0.00";
	
	document.forms[0].txtAmount10[2].value=roundToTwo(eval(document.forms[0].txtAmount10[0].value)+eval(document.forms[0].txtAmount10[1].value));
	document.forms[0].txtAmount10[5].value=roundToTwo(eval(document.forms[0].txtAmount10[3].value)+eval(document.forms[0].txtAmount10[4].value));
	document.forms[0].txtAmount10[6].value=roundToTwo(eval(document.forms[0].txtAmount10[3].value)+eval(document.forms[0].txtAmount10[0].value));
	document.forms[0].txtAmount10[7].value=roundToTwo(eval(document.forms[0].txtAmount10[1].value)+eval(document.forms[0].txtAmount10[4].value));
	
	document.forms[0].txtAmount10[8].value=roundToTwo(eval(document.forms[0].txtAmount10[2].value)+eval(document.forms[0].txtAmount10[5].value));
	
	
	
	
	document.forms[0].txtAmount10[13].value=roundToTwo(eval(document.forms[0].txtAmount10[10].value)+eval(document.forms[0].txtAmount10[11].value)+eval(document.forms[0].txtAmount10[12].value));
	
	document.forms[0].txtAmount10[16].value=roundToTwo(eval(document.forms[0].txtAmount10[14].value)+eval(document.forms[0].txtAmount10[15].value));
	
	document.forms[0].txtAmount10[19].value=roundToTwo(eval(document.forms[0].txtAmount10[17].value)+eval(document.forms[0].txtAmount10[18].value));	
	
	
	document.forms[0].txtAmount10[20].value=roundToTwo(eval(document.forms[0].txtAmount10[14].value)+eval(document.forms[0].txtAmount10[17].value));
	
	document.forms[0].txtAmount10[21].value=roundToTwo(eval(document.forms[0].txtAmount10[15].value)+eval(document.forms[0].txtAmount10[18].value));
	document.forms[0].txtAmount10[22].value=roundToTwo(eval(document.forms[0].txtAmount10[16].value)+eval(document.forms[0].txtAmount10[19].value));
	
}



function getPercentageofNumber10()
{
		//value of I
		var valueOf7=document.forms[0].txtAmount10[7].value;
		//alert(valueOf7);
		var percentOf10=(valueOf7*varCOM_GECL3EXT_MAXELGFINANCE)/100;
		//alert(percentOf10);
		document.forms[0].txtAmount10[9].value=NanNumber(percentOf10);
		document.forms[0].txtAmount10[9].value=roundVal(eval(percentOf10));
		
		var valueOf7=document.forms[0].txtAmount10[7].value;
		var valueOf21=(eval(document.forms[0].txtAmount10[15].value)+eval(document.forms[0].txtAmount10[18].value));
		var valueOf13=document.forms[0].txtAmount10[13].value;

		//7,18,10
		/*var percentOf7=(valueOf7*COM_GECL3EXT_ELGFINANCE)/100;
		var percentOf7val=percentOf7-document.forms[0].txtAmount10[13].value;

        var percentof21=(valueOf21*COM_GECL3EXT_ELGFINANCE)/100;
        var percentOf21val=percentof21-document.forms[0].txtAmount10[13].value;*/



        
        var value7=valueOf7;//-document.forms[0].txtAmount10[13].value;
        var percentOf7=(value7*varCOM_GECL3EXT_ELGFINANCE)/100;
        
		var value21=valueOf21-document.forms[0].txtAmount10[13].value;
		var percentof21=(value21*varCOM_GECL3EXT_ELGFINANCE)/100;

        var percentOf7valint = parseInt(percentOf7);
		var percentOf21valint = parseInt(percentof21);

		//alert("percentOf7valint   "+percentOf7valint);
		//alert("percentOf21valint  "+percentOf21valint);
        if(percentOf7valint>percentOf21valint)
        {
        	percentOf7=percentOf7-document.forms[0].txtAmount10[13].value;
    		document.forms[0].txtAmount10[23].value=NanNumber(percentOf7);
    		//document.forms[0].txtAmount10[23].value=roundVal(eval(percentOf7));
    		document.forms[0].txtAmount10[23].value=roundToTwo(eval(percentOf7));
    		var var23val=percentOf7;
        }
        else
        {
        	percentof21=percentof21-document.forms[0].txtAmount10[13].value;
        	document.forms[0].txtAmount10[23].value=NanNumber(percentof21);
    		//document.forms[0].txtAmount10[23].value=roundVal(eval(percentof21));
    		document.forms[0].txtAmount10[23].value=roundToTwo(eval(percentof21));
    		var var23val=percentof21;
        }


        var var21=parseInt(vargecl3sno24);
        var var23=parseInt(var23val);
        if(var23>var21)
        {
        	//document.forms[0].txtAmount10[25].value=roundVal(eval(var21));
        	document.forms[0].txtAmount10[25].value=roundToTwo(eval(vargecl3sno24));
        
         }	
        else

        {
        	//document.forms[0].txtAmount10[25].value=roundVal(eval(var23));  
        	document.forms[0].txtAmount10[25].value=roundToTwo(eval(var23val)); 
        }
        }	

</script>
</head>
<body onload="onLoading();">
<form method = post class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
<tr>
	<td valign="top"><jsp:include page="../com/proposallinks.jsp"	flush="true">
		<jsp:param name="pageid" value="41" />
		<jsp:param name="cattype" value="<%=strCategoryType%>" />
		<jsp:param name="ssitype" value="<%=strSSIType%>" />
	</jsp:include></td>
</tr>          
<tr>
  	<td class="page_flow"> Home -&gt; Corporate &amp; SME -&gt; Proposal -&gt; Assessment -&gt; Assessment Comments</td>
</tr>         
</table>
<span style="display:none;"><lapschoice:borrowertype /></span><lapschoice:application />

<jsp:include page="../com/com_commentstab.jsp" flush="true">
<jsp:param name="tabid" value="<%=strPageid %>" />
</jsp:include>	

<table width="98%" align="center" border="0" cellspacing="0" cellpadding="0" class="outertable">
<tr>
	<td><br>
	    <table width="90%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center" id="idbgass">
	  	<tr>
			<td width="60%" valign="top" >
		  	<div id="id_div"><div class="EditorClassNew"> <%=Helper.correctNull((String)hshValues.get("com_bgassessment")) %></div></div>
		 	<div id="id_editor">
		  		<textarea name="txt_comments" cols="110" wrap="VIRTUAL" rows="25" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("com_bgassessment"))%>
				</textarea>
			</div>
		  	</td>					  
		</tr>
	 	</table>
	 	<table width="90%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center" id="idksae">
	 	<tr>
	 	<td>
	 	<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
 			<tr>
			<td width="25%">Type of Borrower :  </td>
			<td width="75%"><select name="sel_eligibility" onchange="getValues();">
			
                                       <option value='' selected="selected">----Select----</option>
									<lapstab:GeclIdentificationTag apptype="233"  gecltype="<%=strgecltype%>"/>
                                      </select></td>
		</tr>
		</table>
	 	</td>
	 	</tr>
	  	<tr>
			<td valign="top" >
			
			<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
	  			<tr class="dataheader">
					<td width="5%">S.No</td>
					<td width="40%">Parameters under </td>
					<td width="40%">Instant Case </td>
					<td width="15%">Eligible</td>
				</tr>
				<%if(listRow!=null && listRow.size()>0){
					for(int i=0;i<listRow.size();i++){
					listCol=(ArrayList)listRow.get(i);
					//out.println("listCol"+listCol);
					String strsector="";
					%>
					
					<tr class="datagrid">
					
					<% if((Helper.correctNull((String)listCol.get(5)).equalsIgnoreCase("LC")&&Helper.correctNull((String)listCol.get(13)).equalsIgnoreCase("01"))){
					continue;	
					}%>
					<td><%=i+1 %>.</td>
			<td><input type="hidden" name="hid_cmts" value="<%=Helper.correctNull((String)listCol.get(0)) %>">
			<input type="hidden" name="hid_cmtstype" value="<%=Helper.correctNull((String)listCol.get(5)) %>">
			<%=Helper.correctNull((String)listCol.get(0)) %>
					<%if(Helper.correctNull((String)listCol.get(5)).equalsIgnoreCase("D")){ %>
					<td>
					<select name="txt_cmtans">
					<option value=""><--select--></option>
					<%if(Helper.correctNull((String)listCol.get(1)).equalsIgnoreCase("Y")){ %>
					<option value="Y" selected="selected">Yes</option>
					<%}else{ %>
					<option value="Y">Yes</option>
					<%}if(Helper.correctNull((String)listCol.get(1)).equalsIgnoreCase("N")){ %>
					<option value="N" selected="selected">No</option>
					<%}else{ %>
					<option value="N">No</option>
					<%} %>
					</select>
					<input type="hidden" name="txt_cmtans1">
					</td>
					<%}else if(Helper.correctNull((String)listCol.get(5)).equalsIgnoreCase("EM")){ %>
					<td><input type="text" name="txt_cmtans" value="<%=Helper.correctNull((String)listCol.get(1)) %>"   onKeyPress="allowNumber(this)"  style="text-align: right;" onblur="roundtxt(this);chkmaxVal(this,'<%=Helper.correctNull((String)listCol.get(4)) %>')">
					<input type="hidden" name="txt_cmtans1"></td>
					<%}else if(Helper.correctNull((String)listCol.get(5)).equalsIgnoreCase("DA")){ %>
					<td><input type="text" name="txt_cmtans"  onKeyPress="allowInteger()" value="<%=Helper.correctNull((String)listCol.get(1)) %>" style="text-align: right;" onblur="chkmaxVal(this,'<%=Helper.correctNull((String)listCol.get(4)) %>')">
					<input type="hidden" name="txt_cmtans1"></td>
					<%}else if(Helper.correctNull((String)listCol.get(5)).equalsIgnoreCase("IMM")){ %>
			    	<td><input type="text" name="txt_cmtans" onKeyPress="allowNumber(this)" value="<%=Helper.correctNull((String)listCol.get(1)) %>" style="text-align: right;" onblur="roundtxt(this);chkmaxValgecl(this,'<%=Helper.correctNull((String)listCol.get(4)) %>','<%=Helper.correctNull((String)listCol.get(6))%>')">
			    	<input type="hidden" name="txt_cmtans1"></td>
					<%}
					else if((Helper.correctNull((String)listCol.get(5)).equalsIgnoreCase("LC"))){
					%>
					<td><input type="text" name="txt_cmtans" value="<%=Helper.correctNull((String)listCol.get(8)) %>" style="background: #FFFFCC; font-weight: bold;text-align: right;" > &nbsp;&nbsp;&nbsp;
					<input type="text" name="txt_cmtans1" value="<%=Helper.correctNull((String)listCol.get(9)) %>" style="background: #FFFFCC; font-weight: bold;text-align: right;" > 
					<%}
					else if(Helper.correctNull((String)listCol.get(5)).equalsIgnoreCase("GRN")){
						String strgstnumber="",strexempt="";
						if(Helper.correctNull((String)listCol.get(12)).equalsIgnoreCase("Y")){
						strexempt="Exempted is Yes";
						}else{
							strexempt="";
						}
						if(Helper.correctNull((String)listCol.get(11)).equalsIgnoreCase("Y")){%>
						<td ><input type="hidden" name="txt_cmtans" value="<%=Helper.correctNull((String)listCol.get(10))%>"  style="background: #FFFFCC; font-weight: bold;text-align: right;" >
					      <input type="hidden" name="txt_cmtans1">
						<%
						String[] strArr1=Helper.correctNull((String)listCol.get(10)).split("@");
						for(int a=0;a<strArr1.length;a++)
						{
							%>
						<input type="text" style="background: #FFFFCC; font-weight: bold;text-align: right;" name="txt_gst" readOnly="readonly" value="<%=strArr1[a] %>"  ><br/>
									 
						<%} %>
					
					
					<%}else if(Helper.correctNull((String)listCol.get(11)).equalsIgnoreCase("N")||Helper.correctNull((String)listCol.get(11)).equalsIgnoreCase("NA")){%>
						<td ><input type="text" name="txt_cmtans" value="<%=strexempt %>" style="background: #FFFFCC; font-weight: bold;text-align: right;" >
					      <input type="hidden" name="txt_cmtans1">
									 
					<% }%></td>
						<%}
					else if(Helper.correctNull((String)listCol.get(5)).equalsIgnoreCase("NS")){ 
			           strsector=Helper.correctNull((String)listCol.get(7)); 
			           %>
			           <% if(strsector.equalsIgnoreCase("247")){%>
					<td><select name="txt_cmtans">
					    <option value='' selected="selected">----Select----</option>
				     <lapstab:GeclIdentificationTag apptype="247"  gecltype="<%=strgecltype%>"/>
                        </select> 
					  <%}else{ %>
					  <td><select name="txt_cmtans">
					<option value=""><--select--></option>
					 <lapschoice:StaticDataTag apptype="<%=strsector%>"/></select>
					<%}%>
					<input type="hidden" name="txt_cmtans1"></td>
					
					
					<%}else if(Helper.correctNull((String)listCol.get(5)).equalsIgnoreCase("OCC") && (!(strgecltype.equalsIgnoreCase("GECL -1 extension")|| strgecltype.equalsIgnoreCase("GECL -2 extension")||strgecltype.equalsIgnoreCase("GECL -3 extension")))){ %>
					<td><input type="text" name="txt_cmtans" onKeyPress="allowNumber(this)" value="<%=Helper.correctNull((String)listCol.get(1)) %>" style="text-align: right;" 
					onblur="roundtxt(this);chkamtvalgecl(this,'<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("dbl_proptotval"))))%>','<%=Helper.correctNull((String)listCol.get(4)) %>');chkmaxValgeclamtchk(this,'<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("strgeclassesamt"))))%>')">
					<input type="hidden" name="txt_cmtans1"></td>
					<%}
					else if(Helper.correctNull((String)listCol.get(5)).equalsIgnoreCase("OCC") && (strgecltype.equalsIgnoreCase("GECL -1 extension") || strgecltype.equalsIgnoreCase("GECL -2 extension")||strgecltype.equalsIgnoreCase("GECL -3 extension"))){ %>
					<td><input type="text" name="txt_cmtans" onKeyPress="allowNumber(this)" value="<%=Helper.correctNull((String)listCol.get(1)) %>" style="text-align: right;" 
					onblur="roundtxt(this);chkamtvalgecl1(this,'<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("dbl_proptotval"))))%>','<%=Helper.correctNull((String)listCol.get(4)) %>');">
					<input type="hidden" name="txt_cmtans1"></td>
					<%}
					
					else if(Helper.correctNull((String)listCol.get(5)).equalsIgnoreCase("AO")){ %>
					<td><input type="text" name="txt_cmtans" onKeyPress="allowNumber(this)" value="<%=Helper.correctNull((String)listCol.get(1)) %>" style="text-align: right;" onblur="roundtxt(this);">
					<input type="hidden" name="txt_cmtans1"></td>
					<%}else{ %>
					<td><textarea name="txt_cmtans" rows="4" cols="75"><%=Helper.correctNull((String)listCol.get(1)) %></textarea>
					<input type="hidden" name="txt_cmtans1"></td>
					<%} %>
					<td><select name="sel_eligible">
					<option value=""><--select--></option>
					<%if(Helper.correctNull((String)listCol.get(2)).equalsIgnoreCase("Y")){ %>
					<option value="Y" selected="selected">Yes</option>
					<%}else{ %>
					<option value="Y">Yes</option>
					<%}if(Helper.correctNull((String)listCol.get(2)).equalsIgnoreCase("N")){ %>
					<option value="N" selected="selected">No</option>
					<%}else{ %>
					<option value="N">No</option>
					<%} %>
					</select><input type="hidden" name="hidassid" value="<%=Helper.correctNull((String)listCol.get(3)) %>"></td>
				</tr>
				
				<%}}%>
				
				
				</table>
		  	
		  	</td>					  
		</tr>
	 	</table>
	 	<table width="90%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center" id="idfidpn">
	 	<tr>
	 	<td>Facility :&nbsp;<select name="sel_facilitysno" tabindex="1" onchange="getFacilityDetails();">
				<option value="0" selected="selected">--Select--</option>
                <lapschoice:ComMisDetailsTag apptype='<%=Helper.correctNull((String)request.getParameter("appno")) %>' page='dpn'/>
				</select></td>
	 	</tr>
	 	<%if(!Helper.correctNull((String)hshValues.get("strDPNAccno")).equalsIgnoreCase("")){ %>
	 	<tr>
	 	<td>Account no: <%=Helper.correctNull((String)hshValues.get("strDPNAccno")) %></td>
	 	</tr>
	 	<%} %>
	  	<tr>
			<td valign="top" >
			
			<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
			<tr class="dataheader">
			<td colspan="3" align="right">(Amount in Rs.)</td>
			</tr>
	  			<tr class="dataheader">
					<td width="5%">S.No</td>
					<td width="40%">Description </td>
					<td width="40%">Amount</td>
				</tr>
				<%if(listDPN!=null && listDPN.size()>0){
					for(int i=0;i<listDPN.size();i++){
					listCol=(ArrayList)listDPN.get(i);
					if(i==1){
					%>
					<tr class="datagrid">
					<td colspan="3" align="center">Interest Deferment</td>
					</tr>
					<%} %>
					<tr class="datagrid">
					<td><%=i+1 %>.</td>
					<td><input type="hidden" name="hid_dpncmts" value="<%=Helper.correctNull((String)listCol.get(0)) %>"><%=Helper.correctNull((String)listCol.get(0)) %></td>
					<td><input type="text" name="txtAmount" value="<%=Helper.correctNull((String)listCol.get(1)) %>" style="text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);calculate1();"></td>
				</tr>
				
				<%}}else{
					for(int i=0;i<strArr.length;i++){
						if(i==0){
						%>
						<tr class="datagrid">
						<td>1.</td>
						<td><input type="hidden" name="hid_dpncmts" value="Existing OD Limit">Existing OD Limit</td>
						<td><input type="text" name="txtAmount" value="<%=Helper.correctNull((String)hshValues.get("strExistingLim")) %>" style="text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)"></td>
						</tr>
						<tr class="datagrid">
						<td colspan="3" align="center">Interest Deferment</td>
						</tr>
						<%} %>
						<tr class="datagrid">
						<td><%=i+2 %>.</td>
						<td><input type="hidden" name="hid_dpncmts" value="<%=strArr[i]%>"><%=strArr[i]%></td>
						<td><input type="text" name="txtAmount" value="" style="text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);calculate1();"></td>
					</tr>
					
					<%}
				%>
					<tr class="datagrid">
						<td><%=strArr.length+1%>.</td>
						<td><input type="hidden" name="hid_dpncmts" value="Total">Total</td>
						<td><input type="text" name="txtAmount" value="" style="text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)"></td>
					</tr>
					<tr class="datagrid">
						<td><%=strArr.length+2 %>.</td>
						<td><input type="hidden" name="hid_dpncmts" value="Recommended">Recommended</td>
						<td><input type="text" name="txtAmount" value="" style="text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);calculate1();"></td>
					</tr>
				
				<%} %>
				
				
				</table>
		  	
		  	</td>					  
		</tr>
	 	</table>
	 	<table width="90%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center" id="idMMithra">
	  	<tr>
			<td valign="top" >
			
			<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
			<tr class="datagrid">
			<td colspan="2" align="right">(Amount in Rs.)</td>
			</tr>
					<tr class="datagrid">
					<td>Details as on Date</td>
					<td><input type="text" name="txt_mithraason"
													size="16"
													onBlur="checkDate(this);checkmaxdate(this,currentDate);"
													value="<%=Helper.correctNull((String)hshValues.get("strAmount1")) %>">
												<a alt="Select date from calender" id="duedate"
													href="#" onClick="callCalender('txt_mithraason')"
													onMouseOver="window.status='Date Picker';return true;"
													onMouseOut="window.status='';return true;"><img
													src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
													border="0" alt="Select date from calender"></a></td>
					</tr>
					<tr class="datagrid">
					<td><input type="hidden" name="hid_desc" value="Value of Stock (A)">Value of Stock(A)</td>
					<td><input type="text" name="txtAmount1" value="<%=Helper.correctNull((String)hshValues.get("strAmount2")) %>" style="text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);calculate();"></td>
					</tr>
					<tr class="datagrid">
					<td><input type="hidden" name="hid_desc" value="Value of Book Debt (B)">Value of Book Debt(B)</td>
					<td><input type="text" name="txtAmount1" value="<%=Helper.correctNull((String)hshValues.get("strAmount3")) %>" style="text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);calculate();"></td>
					</tr>
					<tr class="datagrid">
					<td><input type="hidden" name="hid_desc" value="Value of Creditors (C)">Value of Creditors(C)</td>
					<td><input type="text" name="txtAmount1" value="<%=Helper.correctNull((String)hshValues.get("strAmount4")) %>" style="text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);calculate();"></td>
					</tr>
					<tr class="datagrid">
					<td><input type="hidden" name="hid_desc" value="Total of A+B-C (D)">Total of A+B-C (D)</td>
					<td><input type="text" name="txtAmount1" value="<%=Helper.correctNull((String)hshValues.get("strAmount5")) %>" style="text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);calculate();"></td>
					</tr>
					<tr class="datagrid">
					<td><input type="hidden" name="hid_desc" value="MPBF <%=dblMargin %>% of D (E)">MPBF <%=dblMargin %>% of D (E)</td>
					<td><input type="text" name="txtAmount1" value="<%=Helper.correctNull((String)hshValues.get("strAmount6")) %>" style="text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);calculate();"></td>
					</tr>
					<tr class="datagrid">
					<td><input type="hidden" name="hid_desc" value="Loan amount applied (F)">Loan amount applied (F)</td>
					<td><input type="text" name="txtAmount1" value="<%=Helper.correctNull((String)hshValues.get("strAmount7")) %>" style="text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);calculate();"></td>
					</tr>
					<tr class="datagrid">
					<td><input type="hidden" name="hid_desc" value="Least of E or F">Least of E or F</td>
					<td><input type="text" name="txtAmount1" value="<%=Helper.correctNull((String)hshValues.get("strAmount8")) %>" style="text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);calculate();"></td>
					</tr>
				
				
				
				</table>
		  	
		  	</td>					  
		</tr>
	 	</table>
	 	<%{ %>
	 		<table width="90%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center" id="idGECL">
	  	<tr>
			<td valign="top" >
			
			<table width="98%" align="center" border="0" cellspacing="0" cellpadding="0" class="outertable">
<div id="top">
	<%if(strgecltype.equalsIgnoreCase("GECL1")){ %>
<table width="70%" align="center" cellpadding="3" cellspacing="0" border="0">
	<tr class="datagrid">
			<td colspan="3" align="right">(Amount in Rs.)</td>
			</tr>
<tr class="datagrid">
<td align="left" width="5%">A</td>
<td><input type="hidden" name="hid_desc1" value="Total outstanding balance under term loans of applicant with other banks/FIs as on 29.02.2020 [A]">Total outstanding balance under term loans of applicant with other banks/FIs as on 29.02.2020</td>
<td><input type="text" name="txtAmount3" value="<%=Helper.correctNull((String)hshValues.get("strAmount1")) %>" style="text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);additionValues();getPercentageofNumber();"></td>

</tr>
<tr class="datagrid">
<td align="left">B</td>
<td><input type="hidden" name="hid_desc1" value="Total outstanding balance under term loans of applicant with our bank as on 29.02.2020 [B]"> Total outstanding balance under term loans of applicant with our bank as on 29.02.2020</td>
<td><input type="text" name="txtAmount3" value="<%=Helper.correctNull((String)hshValues.get("strAmount2")) %>" style="text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);additionValues();getPercentageofNumber();"></td>

</tr>
<tr class="datagrid">
<td align="left">C</td>
<td><input type="hidden" name="hid_desc1" value="Total outstanding balance in term loans as on 29.02.2020(A+B) [C]">Total outstanding balance in term loans as on 29.02.2020(A+B) </td>
<td><input type="text" name="txtAmount3" value="<%=Helper.correctNull((String)hshValues.get("strAmount3")) %>" style="text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);"></td>
</tr>
<tr class="datagrid">
<td align="left">D</td>
<td><input type="hidden" name="hid_desc1" value="Total outstanding balance under working capital loans of applicant with other banks/FIs as on 29.02.2020 [D]">Total outstanding balance under working capital loans of applicant with other banks/FIs as on 29.02.2020</td>
<td><input type="text" name="txtAmount3" value="<%=Helper.correctNull((String)hshValues.get("strAmount4")) %>" style="text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);additionValues();getPercentageofNumber();"></td>
</tr>
<tr class="datagrid">
<td align="left">E</td>
<td><input type="hidden" name="hid_desc1" value="Total outstanding balance under working capital loans of applicant with our bank as on 29.02.2020 [E]">Total outstanding balance under working capital loans of applicant with our bank as on 29.02.2020</td>
<td><input type="text" name="txtAmount3" value="<%=Helper.correctNull((String)hshValues.get("strAmount5")) %>" style="text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);additionValues();getPercentageofNumber();"></td>
</tr>
<tr class="datagrid">
<td align="left">F</td>
<td><input type="hidden" name="hid_desc1" value="Total outstanding balance in working capital loans as on 29.02.2020(D+E) [F]">Total outstanding balance in working capital loans as on 29.02.2020(D+E)</td>
<td><input type="text" name="txtAmount3" value="<%=Helper.correctNull((String)hshValues.get("strAmount6")) %>" style="text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);"></td>
</tr>
<tr class="datagrid">
<td align="left">G</td>
<td><input type="hidden" name="hid_desc1" value="Total outstanding balance of applicant with all MLIs as on 29.02.2020(C+F) [G]">Total outstanding balance of applicant with all MLIs as on 29.02.2020(C+F)</td>
<td><input type="text" name="txtAmount3" value="<%=Helper.correctNull((String)hshValues.get("strAmount7")) %>" style="text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);"></td>
</tr>
<tr class="datagrid">
<td align="left">H</td>
<td><input type="hidden" name="hid_desc1" value="Total outstanding balance as per latest Bureau report [H]">Total outstanding balance as per latest Bureau report</td>
<td><input type="text" name="txtAmount3" value="<%=Helper.correctNull((String)hshValues.get("strAmount8")) %>" style="text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);"></td>
</tr>
<tr class="datagrid">
<td align="left">I</td>
<td><input type="hidden" name="hid_desc1" value="Maximum eligible limit to the borrower <%=dblMarginAss1%> % of G) [I]">Maximum eligible limit to the borrower(<%=dblMarginAss1%>% of G)</td>
<td><input type="text" name="txtAmount3" value="<%=Helper.correctNull((String)hshValues.get("strAmount9")) %>" style="text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);"></td>
</tr>
<tr class="datagrid">
<td align="left">J</td> 
<td><input type="hidden" name="hid_desc1" value="Maximum eligible limit without NOC from others -(<%=dblMarginAss2%>% of B+E) [J]">Maximum eligible limit without NOC from others -(<%=dblMarginAss2%>% of B+E)</td>
<td><input type="text" name="txtAmount3" value="<%=Helper.correctNull((String)hshValues.get("strAmount10")) %>" style="text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);"></td>
</tr>
<tr class="datagrid">
<td align="left">K</td>
<td><input type="hidden" name="hid_desc1" value="Limit Requested by the borrower [K]">Limit Requested by the borrower</td>
<td><input type="text" name="txtAmount3" value="<%=Helper.correctNull((String)hshValues.get("strAmount11")) %>" style="text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);chkloanAmt(this);getPercentageofNumber();"></td>
</tr>
<tr class="datagrid">
<td align="left">L</td>
<td><input type="hidden" name="hid_desc1" value="Limit recommended lower of (I,J,K) [L]">Limit recommended lower of (I,J,K)</td>
<td><input type="text" name="txtAmount3" value="<%=Helper.correctNull((String)hshValues.get("strAmount12")) %>" style="text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);"></td>
</tr>
<%} %>
<%if(strgecltype.equalsIgnoreCase("GECL2")){%>
<tr class="datagrid">
<td align="left" width="5%">A</td>
<td><input type="hidden" name="hid_desc1" value="Total outstanding balance under term loans of applicant with other banks/FIs ">Total outstanding balance under term loans of applicant with other banks/FIs as on 29.02.2020</td>
<td><input type="text" name="txtAmount5" value="<%=Helper.correctNull((String)hshValues.get("strAmount1")) %>" style="text-align: right;" onKeyPress="allowNumber(this)" onBlur="additionValuesgecl2();getPercentageofNumbergecl2();"></td>

</tr>
<tr class="datagrid">
<td align="left">B</td>
<td><input type="hidden" name="hid_desc1" value="Total outstanding balance under term loans of applicant with our bank"> Total outstanding balance under term loans of applicant with our bank as on 29.02.2020 </td>
<td><input type="text" name="txtAmount5" value="<%=Helper.correctNull((String)hshValues.get("strAmount2")) %>" style="text-align: right;" onKeyPress="allowNumber(this)" onBlur="additionValuesgecl2();getPercentageofNumbergecl2();"></td>

</tr>
<tr class="datagrid">
<td align="left">C</td>
<td><input type="hidden" name="hid_desc1" value="Total  outstanding balance in term loans">Total outstanding balance in term loans as on 29.02.2020(A+B)</td>
<td><input type="text" name="txtAmount5" value="<%=Helper.correctNull((String)hshValues.get("strAmount3")) %>" style="background: #FFFFCC; font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" onBlur=""></td>
</tr>
<tr class="datagrid">
<td align="left">D</td>
<td><input type="hidden" name="hid_desc1" value="Total outstanding balance under fund based working capital loans of applicant with other banks/FIs">Total outstanding balance under fund based working capital loans of applicant with other banks/FIs as on 29.02.2020  </td>
<td><input type="text" name="txtAmount5" value="<%=Helper.correctNull((String)hshValues.get("strAmount4")) %>" style="text-align: right;" onKeyPress="allowNumber(this)" onBlur="additionValuesgecl2();getPercentageofNumbergecl2();"></td>
</tr>
<tr class="datagrid">
<td align="left">E</td>
<td><input type="hidden" name="hid_desc1" value="Total outstanding balance under fund based working capital loans of applicant with our bank">Total outstanding balance under fund based working capital loans of applicant with our bank as on 29.02.2020 </td>
<td><input type="text" name="txtAmount5" value="<%=Helper.correctNull((String)hshValues.get("strAmount5")) %>" style="text-align: right;" onKeyPress="allowNumber(this)" onBlur="additionValuesgecl2();getPercentageofNumbergecl2();"></td>
</tr>
<tr class="datagrid">
<td align="left">F</td>
<td><input type="hidden" name="hid_desc1" value="Total outstanding balance in fund based working capital loans">Total outstanding balance in fund based working capital loans as on 29.02.2020(D+E)</td>
<td><input type="text" name="txtAmount5" value="<%=Helper.correctNull((String)hshValues.get("strAmount6")) %>" style="background: #FFFFCC; font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" onBlur=""></td>
</tr>
<tr class="datagrid">
<td align="left">G</td>
<td><input type="hidden" name="hid_desc1" value="Total Outstanding balance as on with other MLIs (A+D)">Total Outstanding balance as on 29.02.2020 with other MLIs (A+D)</td>
<td><input type="text" name="txtAmount5" value="<%=Helper.correctNull((String)hshValues.get("strAmount7")) %>" style="background: #FFFFCC; font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" onBlur="getPercentageofNumbergecl2();"></td>
</tr>
<tr class="datagrid">
<td align="left">H</td>
<td><input type="hidden" name="hid_desc1" value="Total Outstanding balance as on  with our Bank (B+E)">Total Outstanding balance as on 29.02.2020 with our Bank (B+E)</td>
<td><input type="text" name="txtAmount5" value="<%=Helper.correctNull((String)hshValues.get("strAmount8")) %>" style="background: #FFFFCC; font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" onBlur="getPercentageofNumbergecl2();"></td>
</tr>
<tr class="datagrid">
<td align="left">I</td>
<td><input type="hidden" name="hid_desc1" value="Amount of overdue in savings/current account/credit card account as per bureau report">Amount of overdue in savings/current account/credit card account as per bureau report</td>
<td><input type="text" name="txtAmount5" value="<%=Helper.correctNull((String)hshValues.get("strAmount9")) %>" style="text-align: right;" onKeyPress="allowNumber(this)" onBlur=""></td>
</tr>
<tr class="datagrid">
<td align="left">J</td>
<td><input type="hidden" name="hid_desc1" value="Total outstanding balance in fund based limit  as on  as per latest Bureau report">Total outstanding balance in fund based limit  as on 29-02-2020 as per latest Bureau report</td>
<td><input type="text" name="txtAmount5" value="<%=Helper.correctNull((String)hshValues.get("strAmount10")) %>" style="text-align: right;" onKeyPress="allowNumber(this)" onBlur=""></td>
</tr>
<tr class="datagrid">
<td align="left">K</td>
<td><input type="hidden" name="hid_desc1" value="Total eligible limit from entire MLI's (<%=dblMargingecl2limt%>% of G+H)">Total eligible limit from entire MLI's (<%=dblMargingecl2limt%>%  of G+H)</td>
<td><input type="text" name="txtAmount5" value="<%=Helper.correctNull((String)hshValues.get("strAmount11")) %>" style="background: #FFFFCC; font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);"></td>
</tr>
<tr class="datagrid">
<td align="left">L</td>
<td><input type="hidden" name="hid_desc1" value="Total eligible limit with our Bank (<%=dblMargingecl2banklimt%>% of H)">Total eligible limit with our Bank (<%=dblMargingecl2banklimt%>%  of H)</td>
<td><input type="text" name="txtAmount5" value="<%=Helper.correctNull((String)hshValues.get("strAmount12")) %>" style="background: #FFFFCC; font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);"></td>
</tr>
<tr class="datagrid">
<td align="left">M1</td>
<td><input type="hidden" name="hid_desc1" value="Total Limit Applied Fund Based">Total Limit Applied  Fund Based</td>
<td><input type="text" name="txtAmount5" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("dbl_propfundostot"))))%> " style="background: #FFFFCC; font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);getPercentageofNumbergecl2();"></td>
</tr>
<tr class="datagrid">
<td align="left">M2</td>
<td><input type="hidden" name="hid_desc1" value="Total Limit Applied  Non Fund Based"> Total Limit Applied  Non Fund Based</td>
<td><input type="text" name="txtAmount5" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("dbl_propnonfundostot"))))%>" style="background: #FFFFCC; font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);getPercentageofNumbergecl2();"></td>
</tr>
<tr class="datagrid">
<td align="left">N1</td>
<td><input type="hidden" name="hid_desc1" value="Total Limit Recommended/Proposed (considering only our Bank's Exposure)  Fund Based">Total Limit Recommended/Proposed (considering only our Bank's Exposure)  Fund Based</td>
<td><input type="text" name="txtAmount5" value="<%=Helper.correctNull((String)hshValues.get("strAmount15")) %>" style="text-align: right;" onKeyPress="allowNumber(this)" onBlur="selperchkval12();"></td>
</tr>

<tr class="datagrid">
<td align="left">N2</td>
<td><input type="hidden" name="hid_desc1" value="Total Limit Recommended/Proposed (considering only our Bank's Exposure) Non Fund Based">Total Limit Recommended/Proposed (considering only our Bank's Exposure) Non Fund Based</td>
<td><input type="text" name="txtAmount5" value="<%=Helper.correctNull((String)hshValues.get("strAmount16")) %>" style="text-align: right;" onKeyPress="allowNumber(this)" onBlur="selperchkval12();"></td>
</tr>
<tr class="datagrid">
<td align="left">O</td>
<td><input type="hidden" name="hid_desc1" value="Whether NOC from other MLI's is submitted to avail the eligible limit with our bank? ">Whether NOC from other MLI's is submitted to avail the eligible limit with our bank?</td>
<td><select name="txtAmount5" onchange="selchangeval();">
							<option value="" selected="selected">--select--</option>
							<option value="Yes">Yes</option>
							<option value="No" >No</option>
							</select>
							</td>
</tr>
<tr class="datagrid" id="id_geclval3"> 
<td align="left">P</td>
<td><input type="hidden" name="hid_desc1" value="Comments">Comments</td>   
 <td> <textarea name="txtAmount5"  cols="50" wrap="VIRTUAL" rows="3" onKeyPress="textlimit(this,3999)" wrap="VIRTUAL" onKeyUp="textlimit(this,3999)""><%=Helper.correctNull((String)hshValues.get("strAmount18"))%></textarea></td>
 </tr>
<tr class="datagrid" id="id_geclval1">
<td align="left">Q1</td>
<td><input type="hidden" name="hid_desc1" value="If NOC submitted, limit recommended/proposed (considering the entire exposure with all MLI's) Fund Based">If NOC submitted, limit recommended/proposed (considering the entire exposure with all MLI's) Fund Based</td>
<td><input type="text" name="txtAmount5" value="<%=Helper.correctNull((String)hshValues.get("strAmount19")) %>" style="text-align: right;" onKeyPress="allowNumber(this)" onBlur="selperchkval();"></td>
</tr>
<tr class="datagrid" id="id_geclval2">
<td align="left">Q2</td>
<td><input type="hidden" name="hid_desc1" value="If NOC submitted, limit recommended/proposed (considering the entire exposure with all MLI's) Non Fund Based">If NOC submitted, limit recommended/proposed (considering the entire exposure with all MLI's)  Non Fund Based</td>
<td><input type="text" name="txtAmount5" value="<%=Helper.correctNull((String)hshValues.get("strAmount20")) %>" style="text-align: right;" onKeyPress="allowNumber(this)" onBlur="selperchkval();"></td>
</tr>
<%} %>


<%if(strgecltype.equalsIgnoreCase("GECL3")){%>
<tr class="datagrid">
<td align="left" width="5%">A</td>
<td><input type="hidden" name="hid_desc1" value="A) Total outstanding balance under term loans of applicant with other banks/FIs as on 29.02.2020">Total outstanding balance under term loans of applicant with other banks/FIs as on 29.02.2020</td>
<td><input type="text" name="txtAmount6" value="<%=Helper.correctNull((String)hshValues.get("strAmount1")) %>" style="text-align: right;" onKeyPress="allowNumber(this)" onBlur="additionValuesgecl3();getPercentageofNumbergecl3();"></td>

</tr>
<tr class="datagrid">
<td align="left">B</td>
<td><input type="hidden" name="hid_desc1" value="B) Total outstanding balance under term loans of applicant with our bank as on 29.02.2020"> Total outstanding balance under term loans of applicant with our bank as on 29.02.2020</td>
<td><input type="text" name="txtAmount6" value="<%=Helper.correctNull((String)hshValues.get("strAmount2")) %>" style="text-align: right;" onKeyPress="allowNumber(this)" onBlur="additionValuesgecl3();getPercentageofNumbergecl3();"></td>

</tr>
<tr class="datagrid">
<td align="left">C</td>
<td><input type="hidden" name="hid_desc1" value="C) Total outstanding balance in term loans as on 29.02.2020(A+B)">Total outstanding balance in term loans as on 29.02.2020(A+B)</td>
<td><input type="text" name="txtAmount6" value="<%=Helper.correctNull((String)hshValues.get("strAmount3")) %>" style="background: #FFFFCC; font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" onBlur=""></td>
</tr>
<tr class="datagrid">
<td align="left">D</td>
<td><input type="hidden" name="hid_desc1" value="D) Total outstanding balance under working capital loans of applicant with other banks/FIs as on 29.2.2020">Total outstanding balance under working capital loans of applicant with other banks/FIs as on 29.2.2020</td>
<td><input type="text" name="txtAmount6" value="<%=Helper.correctNull((String)hshValues.get("strAmount4")) %>" style="text-align: right;" onKeyPress="allowNumber(this)" onBlur="additionValuesgecl3();getPercentageofNumbergecl3();"></td>
</tr>
<tr class="datagrid">
<td align="left">E</td>
<td><input type="hidden" name="hid_desc1" value="E) Total outstanding balance in working capital loans of applicant with  our Bank as on 29.2.2020">Total outstanding balance in working capital loans of applicant with  our Bank as on 29.2.2020</td>
<td><input type="text" name="txtAmount6" value="<%=Helper.correctNull((String)hshValues.get("strAmount5")) %>" style="text-align: right;" onKeyPress="allowNumber(this)" onBlur="additionValuesgecl3();getPercentageofNumbergecl3();"></td>
</tr>
<tr class="datagrid">
<td align="left">F</td>
<td><input type="hidden" name="hid_desc1" value="F) Total outstanding balance in working capital loans as on 29.2.2020 (D+E)">Total outstanding balance in working capital loans as on 29.2.2020 (D+E)</td>
<td><input type="text" name="txtAmount6" value="<%=Helper.correctNull((String)hshValues.get("strAmount6")) %>" style="background: #FFFFCC; font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" onBlur=""></td>
</tr>
<tr class="datagrid">
<td align="left">G</td>
<td><input type="hidden" name="hid_desc1" value="G) Total outstanding balance of applicant with other MLIs as on 29.2.2020(A+D)">Total outstanding balance of applicant with other MLIs as on 29.2.2020(A+D)</td>
<td><input type="text" name="txtAmount6" value="<%=Helper.correctNull((String)hshValues.get("strAmount7")) %>" style="background: #FFFFCC; font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" onBlur="getPercentageofNumbergecl3();"></td>
</tr>
<tr class="datagrid">
<td align="left">H</td>
<td><input type="hidden" name="hid_desc1" value="H) Total Outstanding balance as on  with our Bank (B+E)">Total outstanding balance of applicant with our Bank as on 29.02.2020 (B+E)</td>
<td><input type="text" name="txtAmount6" value="<%=Helper.correctNull((String)hshValues.get("strAmount8")) %>" style="background: #FFFFCC; font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" onBlur="getPercentageofNumbergecl3();"></td>
</tr>
<tr class="datagrid">
<td align="left">I</td>
<td><input type="hidden" name="hid_desc1" value="I) Amount of overdue in savings/current account/credit card account as per bureau report">Amount of overdue in savings/current account/credit card account as per bureau report</td>
<td><input type="text" name="txtAmount6" value="<%=Helper.correctNull((String)hshValues.get("strAmount9")) %>" style="text-align: right;" onKeyPress="allowNumber(this)" onBlur=""></td>
</tr>
<tr class="datagrid">
<td align="left">J</td>
<td><input type="hidden" name="hid_desc1" value="J) Total outstanding balance in fund based limit  as on 29-02-2020 as per latest Bureau report">Total outstanding balance in fund based limit  as on 29-02-2020 as per latest Bureau report</td>
<td><input type="text" name="txtAmount6" value="<%=Helper.correctNull((String)hshValues.get("strAmount10")) %>" style="text-align: right;" onKeyPress="allowNumber(this)" onBlur=""></td>
</tr>
<tr class="datagrid">
<td align="left">K</td>
<td><input type="hidden" name="hid_desc1" value="K) Maximum eligible limit to the borrower from entire MLIs (<%=dblMargingecl3limt%>% of G+H)">Maximum eligible limit to the borrower from entire MLIs(<%=dblMargingecl3limt%>%  of G+H)</td>
<td><input type="text" name="txtAmount6" value="<%=Helper.correctNull((String)hshValues.get("strAmount11")) %>" style="background: #FFFFCC; font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);"></td>
</tr>
<tr class="datagrid">
<td align="left">L</td>
<td><input type="hidden" name="hid_desc1" value="L) Maximum eligible limit to the borrower with our Bank(<%=dblMargingecl3banklimt%>% of H)">Maximum eligible limit to the borrower with our Bank(<%=dblMargingecl3banklimt%>%  of H)</td>
<td><input type="text" name="txtAmount6" value="<%=Helper.correctNull((String)hshValues.get("strAmount12")) %>" style="background: #FFFFCC; font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);additionValuesgecl3();"></td>
</tr>
<tr class="datagrid">
<td align="left">M</td>
<td><input type="hidden" name="hid_desc1" value="M) Existing Sanction limit under GECL 1.00">Existing Sanction limit under GECL 1.00</td>
<td><input type="text" name="txtAmount6" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("dblgecl1TotAmount"))))%> " style="background: #FFFFCC; font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);additionValuesgecl3();"></td>
</tr>

<tr class="datagrid">
<td align="left">N</td>
<td><input type="hidden" name="hid_desc1" value="N) Existing Sanction limit under GECL 2.00">Existing Sanction limit under GECL 2.00</td>
<td><input type="text" name="txtAmount6" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("dblgecl2TotAmount")))) %>" style="background: #FFFFCC; font-weight: bold;text-align: right;"  onKeyPress="allowNumber(this)" onBlur="additionValuesgecl3();"></td>
</tr>
<tr class="datagrid">
<td align="left">0</td>
<td><input type="hidden" name="hid_desc1" value="O) Eligible amount under GECL 3.0 considering our Bank Exposure only)( L-M-N)">Eligible amount under GECL 3.0 considering our Bank Exposure only)( L-M-N)</td>
<td><input type="text" name="txtAmount6" value="<%=Helper.correctNull((String)hshValues.get("strAmount15")) %>" style="background: #FFFFCC; font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" onBlur="additionValuesgecl3();"></td>
</tr>
<tr class="datagrid">
<td align="left">P</td>
<td><input type="hidden" name="hid_desc1" value="P) Limit Requested by Borrower">Limit Requested by Borrower</td>
<td><input type="text" name="txtAmount6" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("dbl_proptotval")))) %>" style="background: #FFFFCC; font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" onBlur=""></td>
</tr>
<tr class="datagrid">
<td align="left">Q</td>
<td><input type="hidden" name="hid_desc1" value="Q) Limit recommended  considering our Banks Exposure Only">Limit recommended  considering our Banks Exposure Only</td>
<td><input type="text" name="txtAmount6" value="<%=Helper.correctNull((String)hshValues.get("strAmount17")) %>" style="text-align: right;" onKeyPress="allowNumber(this)" onBlur="selperchkvalgecl3();"></td>
</tr>
<tr class="datagrid">
<td align="left">R</td>
<td><input type="hidden" name="hid_desc1" value="R) Whether NOC from other MLI's is submitted to avail the eligible limit with our bank?">Whether NOC from other MLI's is submitted to avail the eligible limit with our bank?</td>
<td><select name="txtAmount6" onchange="selchangegecl3val();">
							<option value="" selected="selected">--select--</option>
							<option value="Yes">Yes</option>
							<option value="No" >No</option>
							</select>
							</td>
</tr>
<tr class="datagrid" id="id_gecl3val"> 
<td align="left">S</td>
<td><input type="hidden" name="hid_desc1" value="S) Comments">Comments</td>   
 <td> <textarea name="txtAmount6"  cols="50" wrap="VIRTUAL" rows="3" onKeyPress="textlimit(this,3999)" wrap="VIRTUAL" onKeyUp="textlimit(this,3999)""><%=Helper.correctNull((String)hshValues.get("strAmount19"))%></textarea></td>
 </tr>
<tr class="datagrid" id="id_gecl3val1">
<td align="left">T</td>
<td><input type="hidden" name="hid_desc1" value="T) If NOC submitted, limit recommended/proposed (considering the entire exposure with all MLI's)">If NOC submitted, limit recommended/proposed (considering the entire exposure with all MLI's)</td>
<td><input type="text" name="txtAmount6" value="<%=Helper.correctNull((String)hshValues.get("strAmount20")) %>" style="text-align: right;" onKeyPress="allowNumber(this)" onBlur="selperchkvalgecl3();"></td>
</tr>
<%}%>
<%if(strgecltype.equalsIgnoreCase("GECL4")){%>
<tr>
			<td>
			
			<table width="60%" align="center" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr class="datagrid">
<td align="left">A</td>
<td><input type="hidden" name="hid_desc1" value="A) Borrower exposure with our bank as on 31-03-2021">Borrower exposure with our bank as on 31/03/2021</td>
<td><input type="text" name="txtAmount7" value="<%=Helper.correctNull((String)hshValues.get("strAmount1")) %>" style="text-align: right;" onKeyPress="allowInteger()" onBlur=""></td>

</tr>
<tr class="datagrid">
<td align="left">B</td>
<td><input type="hidden" name="hid_desc1" value="B) Whether borrower accounts are taken over from other Banks after 01/04/2021"> Whether borrower accounts are taken over from other Banks after 01/04/2021</td>
<td><select name="txtAmount7" onchange="selchangevalgecl4();">
							<option value="" selected="selected">--select--</option>
							<option value="Yes">Yes</option>
							<option value="No" >No</option>
							</select>
							</td>
</tr>
<tr class="datagrid" id="id_gecl4">
<td align="left">C</td>
<td><input type="hidden" name="hid_desc1" value="C)Borrower exposure with other bank as on 31/03/2021"> Borrower exposure with other bank as on 31/03/2021</td>
<td><input type="text" name="txtAmount7" value="<%=Helper.correctNull((String)hshValues.get("strAmount3")) %>" style="text-align: right;" onKeyPress="allowNumber(this)" onBlur=""></td>

</tr>
<tr class="datagrid">
<td align="left">D</td>
<td><input type="hidden" name="hid_desc1" value="D) Project cost as per Quotation/estimation">Project cost as per Quotation/estimation</td>
<td><input type="text" name="txtAmount7" value="<%=Helper.correctNull((String)hshValues.get("strAmount4")) %>" style="text-align: right;" onKeyPress="allowNumber(this)" onBlur=""></td>

</tr>
<tr class="datagrid">
<td align="left">E</td>
<td><input type="hidden" name="hid_desc1" value="E) Margin Amount"> Margin Amount</td>
<td><input type="text" name="txtAmount7" value="<%=Helper.correctNull((String)hshValues.get("strAmount5")) %>" style="text-align: right;" onKeyPress="allowNumber(this)" onBlur="vargecl4margin();"></td>

</tr>
<tr class="datagrid">
<td align="left">F</td>
<td><input type="hidden" name="hid_desc1" value="F)Limit Requested by Borrower">Limit Requested by Borrower</td>
<td><input type="text" name="txtAmount7" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("dbl_proptotval")))) %>" style="background: #FFFFCC; font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" onBlur=""></td>
</tr>
<tr class="datagrid">
<td align="left">G</td>
<td><input type="hidden" name="hid_desc1" value="g)Limit proposed and recommended">Limit proposed and recommended</td>
<td><input type="text" name="txtAmount7" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("dblgeclproposedamt")))) %>" style="background: #FFFFCC; font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" onBlur=""></td>
</tr>
	 	</table>
<%} %>
<%if(strgecltype.equalsIgnoreCase("GECL1-Restructure")){%>
<tr>
			<td>
			
			<table width="60%" align="center" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr class="datagrid">
<td align="left">A</td>
<td><input type="hidden" name="hid_desc1" value="A) Total outstanding balance of the applicant with our banks as on 29-02-2020">Total outstanding balance of the applicant with our banks as on 29-02-2020</td>
<td><input type="text" name="txtAmount8" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("dblgecl1borrowerourbankamt")))) %>" style="text-align: right;" onKeyPress="allowInteger()" onBlur=""></td>

</tr>
<tr class="datagrid">
<td align="left">B</td>
<td><input type="hidden" name="hid_desc1" value="B) <%=dblbaloutstanding%> % of the balance outstanding as on 29-02-2020"><%=dblbaloutstanding%> % of the balance outstanding as on 29-02-2020</td>
<td><input type="text" name="txtAmount8" value="<%=Helper.correctNull((String)hshValues.get("strAmount2")) %>" style="text-align: right;" onKeyPress="allowInteger()" onBlur=""></td>

</tr>
<tr class="datagrid">
<td align="left">C</td>
<td><input type="hidden" name="hid_desc1" value="C) Borrower availed facility under GECL 3.0"> Borrower availed facility under GECL 3.0</td>
<td><select name="txtAmount8" onchange="">
							<option value="" selected="selected">--select--</option>
							<option value="Yes">Yes</option>
							<option value="No" >No</option>
							</select>
							</td>
</tr>
	 	</table>
<%} %>

	<%if(strgecltype.equalsIgnoreCase("GECL -1 extension")){ %>
<table width="70%" align="center" cellpadding="3" cellspacing="0" border="0">
	<tr class="datagrid">
			<td colspan="3" align="right">(Amount in Rs.)</td>
			</tr>
<tr class="datagrid">
<td align="left" width="5%">A</td>
<td><input type="hidden" name="hid_desc1" value="Total balance o/s  under TL of the applicant  with other banks/FIs as on 29.02.2020 [A]
">Total balance o/s  under TL of the applicant  with other banks/FIs as on 29.02.2020 [A]
</td>
<td><input type="text" name="txtAmount9" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("gecl1sno1")))) %>" style="background: #FFFFCC; font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);additionValues9();"></td>

</tr>
<tr class="datagrid">
<td align="left">B</td>
<td><input type="hidden" name="hid_desc1" value="Total balance o/s  under TL of the applicant with our Bank as on 29.02.2020 [B]
"> Total balance o/s  under TL of the applicant with our Bank as on 29.02.2020 [B]</td>
<td><input type="text" name="txtAmount9" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("gecl1sno2")))) %>" style="background: #FFFFCC; font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);additionValues9();"></td>

</tr>
<tr class="datagrid">
<td align="left">C</td>
<td><input type="hidden" name="hid_desc1" value="Total  balance o/s under TL as on 29.02.2020(A+B) [C]
">Total  balance o/s under TL as on 29.02.2020(A+B) [C] </td>
<td><input type="text" name="txtAmount9" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("gecl1sno3")))) %>" style="background: #FFFFCC; font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);additionValues9();"></td>
</tr>
<tr class="datagrid">
<td align="left">D</td>
<td><input type="hidden" name="hid_desc1" value="Total balance o/s  under WC of the applicant  with other banks/FIs as on 29.02.2020 [D]
">Total balance o/s  under WC of the applicant  with other banks/FIs as on 29.02.2020 [D]
</td>
<td><input type="text" name="txtAmount9" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("gecl1sno4")))) %>" style="background: #FFFFCC; font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);additionValues9();"></td>
</tr>
<tr class="datagrid">
<td align="left">E</td>
<td><input type="hidden" name="hid_desc1" value="Total balance o/s  under WC of the applicant with our Bank as on 29.02.2020 [E]
">Total balance o/s  under WC of the applicant with our Bank as on 29.02.2020 [E]
</td>
<td><input type="text" name="txtAmount9" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("gecl1sno5")))) %>" style="background: #FFFFCC; font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);additionValues9();"></td>
</tr>
<tr class="datagrid">
<td align="left">F</td>
<td><input type="hidden" name="hid_desc1" value="Total  balance o/s under WC as on 29.02.2020(D+E) [F]
">Total  balance o/s under WC as on 29.02.2020(D+E) [F]
</td>
<td><input type="text" name="txtAmount9" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("gecl1sno6")))) %>" style="background: #FFFFCC; font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);additionValues9();"></td>
</tr>
<tr class="datagrid">
<td align="left">G</td>
<td><input type="hidden" name="hid_desc1" value="Total balance o/s under TL+WC of the applicant  with other banks/FIs  as on 29.02.2020 (A+D) [G]
">Total balance o/s under TL+WC of the applicant  with other banks/FIs  as on 29.02.2020 (A+D) [G]
</td>
<td><input type="text" name="txtAmount9" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("gecl1sno7")))) %>" style="background: #FFFFCC; font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);additionValues9();"></td>
</tr>
<tr class="datagrid">
<td align="left">H</td>
<td><input type="hidden" name="hid_desc1" value="Total balance o/s under TL+WC of the applicant with our Bank  as on 29.02.2020 (B+E) [H]
">Total balance o/s under TL+WC of the applicant with our Bank  as on 29.02.2020 (B+E) [H]
</td>
<td><input type="text" name="txtAmount9" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("gecl1sno8")))) %>" style="background: #FFFFCC; font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);additionValues9();getPercentageofNumber9();"></td>
</tr>
<tr class="datagrid">
<td align="left">I</td>
<td><input type="hidden" name="hid_desc1" value="Total balance o/s of the applicant across all MLI's as on 29.02.2020 (G+H) [I]
">Total balance o/s of the applicant across all MLI's as on 29.02.2020 (G+H) [I]
</td>
<td><input type="text" name="txtAmount9" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("gecl1sno9")))) %>" style="background: #FFFFCC; font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);additionValues9();"></td>
</tr>
<tr class="datagrid">
<td align="left">J</td>
<td><input type="hidden" name="hid_desc1" value="Maximum eligible Finance(<%=dbgecl1sno10%>% of H) [J]
">Maximum eligible Finance(<%=dbgecl1sno10%>% of H) [J]
</td>
<td><input type="text" name="txtAmount9" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("gecl1sno10"))) )%>" style="background: #FFFFCC; font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);"></td>
</tr>
<tr class="datagrid">
<td align="left">K</td>
<td><input type="hidden" name="hid_desc1" value="Loan already availed under GECL 1.0 [K]
">Loan already availed under GECL 1.0 [K]
</td>
<td><input type="text" name="txtAmount9" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("gecl1sno11")))) %>" style="background: #FFFFCC; font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" 
onBlur="roundtxt(this);additionValues9();"></td>
</tr>
<tr class="datagrid">
<td align="left">L</td>
<td><input type="hidden" name="hid_desc1" value="Sanctioned limit under GECL1  - 10% additional assistance [L]
">Sanctioned limit under GECL1  - 10% additional assistance [L]
</td>
<td><input type="text" name="txtAmount9" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("gecl1sno12")))) %>" style="background: #FFFFCC; font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);additionValues9();"></td>
</tr>
<tr class="datagrid">
<td align="left">M</td>
<td><input type="hidden" name="hid_desc1" value="Total support under GECL 1 already availed (K+L) [M]
">Total support under GECL 1 already availed (K+L) [M]
</td>
<td><input type="text" name="txtAmount9" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("gecl1sno13")))) %>" style="background: #FFFFCC; font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);"></td>
</tr>
<tr class="datagrid">
<td align="left">N</td>
<td><input type="hidden" name="hid_desc1" value="Total balance o/s  under TL of the applicant  with other banks/FIs as on 31.03.2021 [N]

">Total balance o/s  under TL of the applicant  with other banks/FIs as on 31.03.2021 [N]

</td>
<td><input type="text" name="txtAmount9" value="<%=Helper.correctNull((String)hshValues.get("strAmount14")) %>" style="text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);additionValues9();getPercentageofNumber9();"></td>
</tr>
<tr class="datagrid">
<td align="left">O</td>
<td><input type="hidden" name="hid_desc1" value="Total balance o/s  under TL of the applicant with our Bank as on 31.03.2021 [O]

">Total balance o/s  under TL of the applicant with our Bank as on 31.03.2021 [O]

</td>
<td><input type="text" name="txtAmount9" value="<%=Helper.correctNull((String)hshValues.get("strAmount15")) %>" style="text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);additionValues9();getPercentageofNumber9();"></td>
</tr>
<tr class="datagrid">
<td align="left">P</td>
<td><input type="hidden" name="hid_desc1" value="Total  balance o/s under TL as on 31.03.2021(N+O) [P]
">Total  balance o/s under TL as on 31.03.2021(N+O) [P]
</td>
<td><input type="text" name="txtAmount9" value="<%=Helper.correctNull((String)hshValues.get("strAmount16")) %>" style="background: #FFFFCC; font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);additionValues9();"></td>
</tr>
<tr class="datagrid">
<td align="left">Q</td>
<td><input type="hidden" name="hid_desc1" value="Total balance o/s  under WC of the applicant  with other banks/FIs as on 31.03.2021 [Q]
">Total balance o/s  under WC of the applicant  with other banks/FIs as on 31.03.2021 [Q]
</td>
<td><input type="text" name="txtAmount9" value="<%=Helper.correctNull((String)hshValues.get("strAmount17")) %>" style="text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);additionValues9();"></td>
</tr>
<tr class="datagrid">
<td align="left">R</td>
<td><input type="hidden" name="hid_desc1" value="Total balance o/s  under WC of the applicant with our Bank as on 31.03.2021 [R]

">Total balance o/s  under WC of the applicant with our Bank as on 31.03.2021 [R]

</td>
<td><input type="text" name="txtAmount9" value="<%=Helper.correctNull((String)hshValues.get("strAmount18")) %>" style="text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);additionValues9();getPercentageofNumber9();"></td>
</tr>
<tr class="datagrid">
<td align="left">S</td>
<td><input type="hidden" name="hid_desc1" value="Total  balance o/s under WC as on 31.03.2021(Q+R) [S]

">Total  balance o/s under WC as on 31.03.2021(Q+R) [S]

</td>
<td><input type="text" name="txtAmount9" value="<%=Helper.correctNull((String)hshValues.get("strAmount19")) %>" style="background: #FFFFCC; font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);additionValues9();"></td>
</tr>
<tr class="datagrid">
<td align="left">T</td>
<td><input type="hidden" name="hid_desc1" value="Total balance o/s under TL+WC of the applicant  with other banks/FIs as on 31.03.2021 (N+Q) [T]

">Total balance o/s under TL+WC of the applicant  with other banks/FIs as on 31.03.2021 (N+Q) [T]

</td>
<td><input type="text" name="txtAmount9" value="<%=Helper.correctNull((String)hshValues.get("strAmount20")) %>" style="background: #FFFFCC; font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);additionValues9();"></td>
</tr>
<tr class="datagrid">
<td align="left">U</td>
<td><input type="hidden" name="hid_desc1" value="Total balance o/s under TL+WC of the applicant with our Bank  as on 31.03.2021(O+R) [U]

">Total balance o/s under TL+WC of the applicant with our Bank  as on 31.03.2021(O+R) [U]

</td>
<td><input type="text" name="txtAmount9" value="<%=Helper.correctNull((String)hshValues.get("strAmount21")) %>" style="background: #FFFFCC; font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);additionValues9();"></td>
</tr>
<tr class="datagrid">
<td align="left">V</td>
<td><input type="hidden" name="hid_desc1" value="Total balance o/s of the applicant across all MLIs  as on 31.03.2021(T+U) [V]

">Total balance o/s of the applicant across all MLIs  as on 31.03.2021(T+U) [V]

</td>
<td><input type="text" name="txtAmount9" value="<%=Helper.correctNull((String)hshValues.get("strAmount22")) %>" style="background: #FFFFCC; font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);additionValues9();"></td>
</tr>
<%if(Helper.correctNull((String) request.getParameter("appstatus")).equalsIgnoreCase("Open/Pending")){%>
<tr class="datagrid">
<td align="left">W</td>
<td><input type="hidden" name="hid_desc1" value="Eligible finance under GECL 1 extension {(H or  U-M  whichever is higher)} *<%=dbgecl1sno23%>% - M [W]">Eligible finance under GECL 1 extension {(H or  U-M  whichever is higher)} *<%=dbgecl1sno23%>% - M [W]
</td>
<td><input type="text" name="txtAmount9" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("gecl1sno231")))) %>" style="background: #FFFFCC; font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);"></td>
</tr>
<% }
else
{%>
<tr class="datagrid">
<td align="left">W</td>
<td><input type="hidden" name="hid_desc1" value="Eligible finance under GECL 1 extension (<%=dbgecl1sno23%>% of (H or U whichever is higher) - M) [W]
">Eligible finance under GECL 1 extension (<%=dbgecl1sno23%>% of (H or U whichever is higher) - M) [W]


</td>
<td><input type="text" name="txtAmount9" value="<%=Helper.correctNull((String)hshValues.get("strAmount23")) %>" style="background: #FFFFCC; font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);"></td>
</tr>

<% }%>
<tr class="datagrid">
<td align="left">X</td>
<td><input type="hidden" name="hid_desc1" value="Limit Requested by Borrower [X]

">Limit Requested by Borrower [X]

</td>
<td><input type="text" name="txtAmount9" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("gecl1sno24")))) %>" style="background: #FFFFCC; font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);"></td>
</tr>

<tr class="datagrid">
<td align="left"></td>
<td><input type="hidden" name="hid_desc1" value="Limit recommended (Least of W or X)
">Limit recommended (Least of W or X)
</td>
<td><input type="text" name="txtAmount9" value="<%=Helper.correctNull((String)hshValues.get("strAmount215")) %>"  style="background: #FFFFCC; font-weight: bold;text-align: right;"   onKeyPress="allowNumber(this)" onBlur="roundtxt(this);"></td>
</tr>

<%} %>

<%if(strgecltype.equalsIgnoreCase("GECL -3 extension")){ %>
<table width="70%" align="center" cellpadding="3" cellspacing="0" border="0">
	<tr class="datagrid">
			<td colspan="3" align="right">(Amount in Rs.)</td>
			</tr>
<tr class="datagrid">
<td align="left" width="5%">A</td>
<td><input type="hidden" name="hid_desc1" value="Total balance o/s  under TL of the applicant with other banks/FIs as on 29.02.2020 [A]">Total balance o/s  under TL of the applicant  with other banks/FIs as on 29.02.2020 [A]
</td>
<td><input type="text" name="txtAmount10" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("gecl3sno1")))) %>" style="background: #FFFFCC; font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);additionValues10();"></td>

</tr>
<tr class="datagrid">
<td align="left">B</td>
<td><input type="hidden" name="hid_desc1" value="Total balance o/s  under TL of the applicant with our Bank as on 29.02.2020 [B]"> Total balance o/s  under TL of the applicant with our Bank as on 29.02.2020 [B]</td>
<td><input type="text" name="txtAmount10" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("gecl3sno2")))) %>" style="background: #FFFFCC; font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);additionValues10();"></td>

</tr>
<tr class="datagrid">
<td align="left">C</td>
<td><input type="hidden" name="hid_desc1" value="Total  balance o/s under TL as on 29.02.2020(A+B) [C]">Total  balance o/s under TL as on 29.02.2020(A+B) [C] </td>
<td><input type="text" name="txtAmount10" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("gecl1sno3")))) %>" style="background: #FFFFCC; font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);"></td>
</tr>
<tr class="datagrid">
<td align="left">D</td>
<td><input type="hidden" name="hid_desc1" value="Total balance o/s  under WC of the applicant with other banks/FIs as on 29.02.2020 [D]">Total balance o/s  under WC of the applicant with other banks/FIs as on 29.02.2020 [D]
</td>
<td><input type="text" name="txtAmount10" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("gecl3sno4")))) %>" style="background: #FFFFCC; font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);additionValues10();"></td>
</tr>
<tr class="datagrid">
<td align="left">E</td>
<td><input type="hidden" name="hid_desc1" value="Total balance o/s  under WC of the applicant with our Bank as on 29.02.2020 [E]">Total balance o/s  under WC of the applicant with our Bank as on 29.02.2020 [E]
</td>
<td><input type="text" name="txtAmount10" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("gecl3sno5")))) %>" style="background: #FFFFCC; font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);additionValues10();"></td>
</tr>
<tr class="datagrid">
<td align="left">F</td>
<td><input type="hidden" name="hid_desc1" value="Total  balance o/s under WC as on 29.02.2020(D+E) [F]
">Total  balance o/s under WC as on 29.02.2020(D+E) [F]
</td>
<td><input type="text" name="txtAmount10" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("gecl3sno6")))) %>" style="background: #FFFFCC; font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);"></td>
</tr>
<tr class="datagrid">
<td align="left">G</td>
<td><input type="hidden" name="hid_desc1" value="Total balance o/s under TL+WC of the applicant with other banks/FIs as on 29.02.2020 (A+D) [G]
">Total balance o/s under TL+WC of the applicant with other banks/FIs as on 29.02.2020 (A+D) [G]
</td>
<td><input type="text" name="txtAmount10" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("gecl3sno7")))) %>" style="background: #FFFFCC; font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);"></td>
</tr>
<tr class="datagrid">
<td align="left">H</td>
<td><input type="hidden" name="hid_desc1" value="Total balance o/s under TL+WC of the applicant with our Bank  as on 29.02.2020 (B+E) [H]
">Total balance o/s under TL+WC of the applicant with our Bank  as on 29.02.2020 (B+E) [H]
</td>
<td><input type="text" name="txtAmount10" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("gecl3sno8")))) %>" style="background: #FFFFCC; font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);"></td>
</tr>
<tr class="datagrid">
<td align="left">I</td>
<td><input type="hidden" name="hid_desc1" value="Total balance o/s of the applicant across MLIs as on 29.02.2020 (C+F) [I]">Total balance o/s of the applicant across MLIs as on 29.02.2020 (C+F) [I]
</td>
<td><input type="text" name="txtAmount10" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("gecl3sno9")))) %>" style="background: #FFFFCC; font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);"></td>
</tr>
<tr class="datagrid">
<td align="left">J</td>
<td><input type="hidden" name="hid_desc1" value="Maximum eligible Finance(<%=COM_GECL3EXT_MAXELGFINANCE%>% of H) [J]"> Maximum eligible Finance(<%=COM_GECL3EXT_MAXELGFINANCE%>% of H) [J]
</td>
<td><input type="text" name="txtAmount10" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("gecl3sno101"))) )%>" style="background: #FFFFCC; font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);"></td>
</tr>
<tr class="datagrid">
<td align="left">K</td>
<td><input type="hidden" name="hid_desc1" value="Existing Sanction limit under GECL 1.00 [K]">Existing Sanction limit under GECL 1.00 [K]
</td>
<td><input type="text" name="txtAmount10" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("gecl3sno10")))) %>" style="background: #FFFFCC; font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" 
onBlur="roundtxt(this);"></td>
</tr>
<tr class="datagrid">
<td align="left">L</td>
<td><input type="hidden" name="hid_desc1" value="Existing Sanction limit under GECL 2.00 [L]
">Existing Sanction limit under GECL 2.00 [L]
</td>
<td><input type="text" name="txtAmount10" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("gecl3sno12")))) %>" 
style="background: #FFFFCC; font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);"></td>
</tr>
<tr class="datagrid">
<td align="left">M</td>
<td><input type="hidden" name="hid_desc1" value="Loan already availed under GECL 3.0 [M]
">Loan already availed under GECL 3.0 [M]
</td>
<td><input type="text" name="txtAmount10" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("gecl3sno13")))) %>" 
style="background: #FFFFCC; font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);"></td>
</tr>
<tr class="datagrid">
<td align="left">N</td>
<td><input type="hidden" name="hid_desc1" value="Total support under GECL already availed (K+L+M) [N]">Total support under GECL already availed (K+L+M) [N]
</td>
<td><input type="text" name="txtAmount10" value="<%=Helper.correctNull((String)hshValues.get("strAmount14")) %>" style="background: #FFFFCC; font-weight: bold;text-align: right;" 
onKeyPress="allowNumber(this)" onBlur="roundtxt(this);"></td>
</tr>
<tr class="datagrid">
<td align="left">O</td>
<td><input type="hidden" name="hid_desc1" value="Total balance o/s  under TL of the applicant with other banks/FIs as on 31.03.2021 [O]">Total balance o/s  under TL of the applicant with other banks/FIs as on 31.03.2021 [O]
</td>
<td><input type="text" name="txtAmount10" value="<%=Helper.correctNull((String)hshValues.get("strAmount15")) %>" style="text-align: right;" 
onKeyPress="allowNumber(this)" onBlur="roundtxt(this);additionValues10();"></td>
</tr>
<tr class="datagrid">
<td align="left">P</td>
<td><input type="hidden" name="hid_desc1" value="Total balance o/s  under TL of the applicant with our Bank as on 31.03.2021 [P]
">Total balance o/s  under TL of the applicant with our Bank as on 31.03.2021 [P]
</td>
<td><input type="text" name="txtAmount10" value="<%=Helper.correctNull((String)hshValues.get("strAmount16")) %>" 
style="text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);additionValues10();getPercentageofNumber10();"></td>
</tr>
<tr class="datagrid">
<td align="left">Q</td>
<td><input type="hidden" name="hid_desc1" value="Total  balance o/s under TL as on 31.03.2021(O+P) [Q]

">Total  balance o/s under TL as on 31.03.2021(O+P) [Q]

</td>
<td><input type="text" name="txtAmount10" value="<%=Helper.correctNull((String)hshValues.get("strAmount17")) %>" 
style="background: #FFFFCC; font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);"></td>
</tr>
<tr class="datagrid">
<td align="left">R</td>
<td><input type="hidden" name="hid_desc1" value="Total balance o/s  under WC of the applicant with other banks/FIs as on 31.03.2021 [R]
">Total balance o/s  under WC of the applicant with other banks/FIs as on 31.03.2021 [R]
</td>
<td><input type="text" name="txtAmount10" value="<%=Helper.correctNull((String)hshValues.get("strAmount18")) %>" 
style="text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);additionValues10();"></td>
</tr>
<tr class="datagrid">
<td align="left">S</td>
<td><input type="hidden" name="hid_desc1" value="Total balance o/s  under WC of the applicant with our Bank as on 31.03.2021 [S]
">Total balance o/s  under WC of the applicant with our Bank as on 31.03.2021 [S]
</td>
<td><input type="text" name="txtAmount10" value="<%=Helper.correctNull((String)hshValues.get("strAmount19")) %>" 
style="text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);additionValues10();getPercentageofNumber10();"></td>
</tr>
<tr class="datagrid">
<td align="left">T</td>
<td><input type="hidden" name="hid_desc1" value="Total  balance o/s under WC as on 31.03.2021(R+S) [T]
">Total  balance o/s under WC as on 31.03.2021(R+S) [T]
</td>
<td><input type="text" name="txtAmount10" value="<%=Helper.correctNull((String)hshValues.get("strAmount20")) %>"
 style="background: #FFFFCC; font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);"></td>
</tr>
<tr class="datagrid">
<td align="left">U</td>
<td><input type="hidden" name="hid_desc1" value="Total balance o/s under TL+WC of the applicant with other banks/FIs as on 31.03.2021 (O+R) [U]
">Total balance o/s under TL+WC of the applicant with other banks/FIs as on 31.03.2021 (O+R) [U]
</td>
<td><input type="text" name="txtAmount10" value="<%=Helper.correctNull((String)hshValues.get("strAmount21")) %>" style="background: #FFFFCC; font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);"></td>
</tr>
<tr class="datagrid">
<td align="left">V</td>
<td><input type="hidden" name="hid_desc1" value="Total balance o/s under TL+WC of the applicant with our Bank  as on 31.03.2021(P+S) [V]
">Total balance o/s under TL+WC of the applicant with our Bank  as on 31.03.2021(P+S) [V]
</td>
<td><input type="text" name="txtAmount10" value="<%=Helper.correctNull((String)hshValues.get("strAmount22")) %>" style="background: #FFFFCC; font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);"></td>
</tr>
<tr class="datagrid">
<td align="left">W</td>
<td><input type="hidden" name="hid_desc1" value="Total balance o/s under TL+WC of the applicant across all MLIs as on 31.03.2021 (Q+T) [W]
">Total balance o/s under TL+WC of the applicant across all MLIs as on 31.03.2021 (Q+T) [W]
</td>
<td><input type="text" name="txtAmount10" value="<%=Helper.correctNull((String)hshValues.get("strAmount23")) %>" style="background: #FFFFCC; font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);"></td>
</tr>
<tr class="datagrid">
<td align="left">X</td>
<td><input type="hidden" name="hid_desc1" value="Eligible finance under GECL 3 extension {(H or V-N whichever is higher)}*<%=COM_GECL3EXT_ELGFINANCE%>% - N) [X]
">Eligible finance under GECL 3 extension {(H or V-N whichever is higher)}*<%=COM_GECL3EXT_ELGFINANCE%>% - N) [X]
</td>
<td><input type="text" name="txtAmount10" value="<%=Helper.correctNull((String)hshValues.get("strAmount24")) %>" style="background: #FFFFCC; font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);"></td>
</tr>

<tr class="datagrid">
<td align="left">Y</td>
<td><input type="hidden" name="hid_desc1" value="Limit Requested by Borrower [Y]

">Limit Requested by Borrower [Y]

</td>
<td><input type="text" name="txtAmount10" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("gecl3sno25")))) %>" 
style="background: #FFFFCC; font-weight: bold;text-align: right;"   onKeyPress="allowNumber(this)" onBlur="roundtxt(this);"></td>
</tr>

<tr class="datagrid">
<td align="left">Z</td>
<td><input type="hidden" name="hid_desc1" value="Limit recommended (Least of X or Y) [Z]

">Limit recommended (Least of X or Y) [Z]

</td>
<td><input type="text" name="txtAmount10" value="<%=Helper.correctNull((String)hshValues.get("strAmount26")) %>"  style="background: #FFFFCC; font-weight: bold;text-align: right;"   onKeyPress="allowNumber(this)" onBlur="roundtxt(this);"></td>
</tr>


<%} %>
<%if(strgecltype.equalsIgnoreCase("GECL -2 extension")){ %>
<table width="70%" align="center" cellpadding="3" cellspacing="0" border="0">
	<tr class="datagrid">
			<td colspan="3" align="right">(Amount in Rs.)</td>
			</tr>
<tr class="datagrid">
<td align="left" width="5%">A</td>
<td><input type="hidden" name="hid_desc1" value="Total balance o/s  under TL of the applicant with other banks/FIs as on 29.02.2020 [A]
">Total balance o/s  under TL of the applicant with other banks/FIs as on 29.02.2020 [A]
</td>
<td><input type="text" name="txtAmount11" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("gecl2sno1")))) %>" style="background: #FFFFCC; font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);additionValues11();"></td>

</tr>
<tr class="datagrid">
<td align="left">B</td>
<td><input type="hidden" name="hid_desc1" value="Total balance o/s  under TL of the applicant with our Bank as on 29.02.2020 [B]
"> Total balance o/s  under TL of the applicant with our Bank as on 29.02.2020 [B]
</td>
<td><input type="text" name="txtAmount11" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("gecl2sno2")))) %>" style="background: #FFFFCC; font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);additionValues11();"></td>

</tr>
<tr class="datagrid">
<td align="left">C</td>
<td><input type="hidden" name="hid_desc1" value="Total  balance o/s under TL as on 29.02.2020(A+B) [C]
">Total  balance o/s under TL as on 29.02.2020(A+B) [C]
</td>
<td><input type="text" name="txtAmount11" value="<%=Helper.correctNull((String)hshValues.get("gecl2sno3")) %>" style="background: #FFFFCC; font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);"></td>
</tr>
<tr class="datagrid">
<td align="left">D</td>
<td><input type="hidden" name="hid_desc1" value="Total balance o/s  under fund based WC of the applicant with other banks/FIs as on 29.02.2020 [D]
">Total balance o/s  under fund based WC of the applicant with other banks/FIs as on 29.02.2020 [D]
</td>
<td><input type="text" name="txtAmount11" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("gecl2sno4")))) %>" style="background: #FFFFCC; font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);additionValues11();"></td>
</tr>
<tr class="datagrid">
<td align="left">E</td>
<td><input type="hidden" name="hid_desc1" value="Total balance o/s  under fund based WC of the applicant with our Bank as on 29.02.2020 [E]
">Total balance o/s  under fund based WC of the applicant with our Bank as on 29.02.2020 [E]
</td>
<td><input type="text" name="txtAmount11" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("gecl2sno5")))) %>" style="background: #FFFFCC; font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);additionValues11();"></td>
</tr>
<tr class="datagrid">
<td align="left">F</td>
<td><input type="hidden" name="hid_desc1" value="Total  balance o/s under WC as on 29.02.2020(D+E) [F]
">Total  balance o/s under WC as on 29.02.2020(D+E) [F]
</td>
<td><input type="text" name="txtAmount11" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("gecl2sno6")))) %>" style="background: #FFFFCC; font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);"></td>
</tr>
<tr class="datagrid">
<td align="left">G</td>
<td><input type="hidden" name="hid_desc1" value="Total balance o/s under TL+WC of the applicant with other banks/FIs as on 29.02.2020 (A+D) [G]
">Total balance o/s under TL+WC of the applicant with other banks/FIs as on 29.02.2020 (A+D) [G]
</td>
<td><input type="text" name="txtAmount11" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("gecl2sno7")))) %>" style="background: #FFFFCC; font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);"></td>
</tr>
<tr class="datagrid">
<td align="left">H</td>
<td><input type="hidden" name="hid_desc1" value="Total balance o/s under TL+WC of the applicant with our Bank  as on 29.02.2020 (B+E) [H]
">Total balance o/s under TL+WC of the applicant with our Bank  as on 29.02.2020 (B+E) [H]
</td>
<td><input type="text" name="txtAmount11" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("gecl2sno8")))) %>" style="background: #FFFFCC; font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);"></td>
</tr>
<tr class="datagrid">
<td align="left">I</td>
<td><input type="hidden" name="hid_desc1" value="Total balance o/s of the applicant across all MLIs  as on 29.02.2020 (C+F) [I]
">Total balance o/s of the applicant across all MLIs  as on 29.02.2020 (C+F) [I]
</td>
<td><input type="text" name="txtAmount11" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("gecl2sno9")))) %>" style="background: #FFFFCC; font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);"></td>
</tr>
<tr class="datagrid">
<td align="left">J</td>
<td><input type="hidden" name="hid_desc1" value="Maximum eligible Finance(<%=COM_GECL2EXT_MAXELGFINANCE%>% of H) [J]
">Maximum eligible Finance(<%=COM_GECL2EXT_MAXELGFINANCE%>% of H) [J] 
</td>
<td><input type="text" name="txtAmount11" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("gecl2sno10"))) )%>" style="background: #FFFFCC; font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);"></td>
</tr>
<tr class="datagrid">
<td align="left">K</td>
<td><input type="hidden" name="hid_desc1" value="Loan already availed under GECL 2.0 [K]
">Loan already availed under GECL 2.0 [K]
</td>
<td><input type="text" name="txtAmount11" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("gecl2sno11")))) %>" style="background: #FFFFCC; font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" 
onBlur="roundtxt(this);additionValues9();"></td>
</tr>
<tr class="datagrid">
<td align="left">L</td>
<td><input type="hidden" name="hid_desc1" value="Total balance o/s  under TL of the applicant with other banks/FIs as on 31.03.2021 [L]
">Total balance o/s  under TL of the applicant with other banks/FIs as on 31.03.2021 [L]
</td>
<td><input type="text" name="txtAmount11" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("strAmount12")))) %>"
style="font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);additionValues11();"></td>
</tr>
<tr class="datagrid">
<td align="left">M</td>
<td><input type="hidden" name="hid_desc1" value="Total balance o/s  under TL of the applicant with our Bank as on 31.03.2021 [M]
">Total balance o/s  under TL of the applicant with our Bank as on 31.03.2021 [M]
</td>
<td><input type="text" name="txtAmount11" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("strAmount13")))) %>" style=" font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);additionValues11();getPercentageofNumber11();"></td>
</tr>
<tr class="datagrid">
<td align="left">N</td>
<td><input type="hidden" name="hid_desc1" value="Total  balance o/s under TL as on 31.03.2021(L+M) [N]
">Total  balance o/s under TL as on 31.03.2021(L+M) [N]
</td>
<td><input type="text" name="txtAmount11" value="<%=Helper.correctNull((String)hshValues.get("strAmount14")) %>" style="background: #FFFFCC;font-weight: bold; text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);"></td>
</tr>
<tr class="datagrid">
<td align="left">O</td>
<td><input type="hidden" name="hid_desc1" value="Total balance o/s  under fund based WC of the applicant with other banks/FIs as on 31.03.2021 [O]
">Total balance o/s  under fund based WC of the applicant with other banks/FIs as on 31.03.2021 [O]
</td>
<td><input type="text" name="txtAmount11" value="<%=Helper.correctNull((String)hshValues.get("strAmount15")) %>" style="font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);additionValues11();getPercentageofNumber11();"></td>
</tr>
<tr class="datagrid">
<td align="left">P</td>
<td><input type="hidden" name="hid_desc1" value="Total balance o/s  under fund based WC of the applicant with our Bank as on 31.03.2021 [P]
">Total balance o/s  under fund based WC of the applicant with our Bank as on 31.03.2021 [P]
</td>
<td><input type="text" name="txtAmount11" value="<%=Helper.correctNull((String)hshValues.get("strAmount16")) %>" style=" font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);additionValues11();getPercentageofNumber11();"></td>
</tr>
<tr class="datagrid">
<td align="left">Q</td>
<td><input type="hidden" name="hid_desc1" value="Total  balance o/s under WC as on 31.03.2021(O+P) [Q]
">Total  balance o/s under WC as on 31.03.2021(O+P) [Q]
</td>
<td><input type="text" name="txtAmount11" value="<%=Helper.correctNull((String)hshValues.get("strAmount17")) %>" style="background: #FFFFCC;font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);additionValues11();"></td>
</tr>
<tr class="datagrid">
<td align="left">R</td>
<td><input type="hidden" name="hid_desc1" value="Total balance o/s under TL+WC of the applicant with other banks/FIs as on 31.03.2021 (L+O) [R]
">Total balance o/s under TL+WC of the applicant with other banks/FIs as on 31.03.2021 (L+O) [R]
</td>
<td><input type="text" name="txtAmount11" value="<%=Helper.correctNull((String)hshValues.get("strAmount18")) %>" style="background: #FFFFCC;font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);"></td>
</tr>
<tr class="datagrid">
<td align="left">S</td>
<td><input type="hidden" name="hid_desc1" value="Total balance o/s under TL+WC of the applicant with our Bank  as on 31.03.2021(M+P) [S]
">Total balance o/s under TL+WC of the applicant with our Bank  as on 31.03.2021(M+P) [S]
</td>
<td><input type="text" name="txtAmount11" value="<%=Helper.correctNull((String)hshValues.get("strAmount19")) %>" style="background: #FFFFCC; font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);"></td>
</tr>
<tr class="datagrid">
<td align="left">T</td>
<td><input type="hidden" name="hid_desc1" value="Total balance o/s of the applicant across all MLIs as on 31.03.2021 (N+Q) [T]
">Total balance o/s of the applicant across all MLIs as on 31.03.2021 (N+Q) [T]
</td>
<td><input type="text" name="txtAmount11" value="<%=Helper.correctNull((String)hshValues.get("strAmount20")) %>" style="background: #FFFFCC; font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);"></td>
</tr>
<tr class="datagrid">
<td align="left">U</td>
<td><input type="hidden" name="hid_desc1" value="Eligible finance under GECL 2 extension {(H or S-K whichever is higher)}*<%=COM_GECL2EXT_ELGFINANCE%>% - K) [U]
">Eligible finance under GECL 2 extension {(H or S-K whichever is higher)}*<%=COM_GECL2EXT_ELGFINANCE%>% - K) [U]
</td>
<td><input type="text" name="txtAmount11" value="<%=Helper.correctNull((String)hshValues.get("strAmount21")) %>" style="background: #FFFFCC; font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);"></td>
</tr>
<tr class="datagrid">
<td align="left">V</td>
<td><input type="hidden" name="hid_desc1" value="Limit Requested by Borrower [V]
">Limit Requested by Borrower [V]
</td>
<td><input type="text" name="txtAmount11" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("gecl2sno24")))) %>" style="background: #FFFFCC; font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);"></td>
</tr>
<tr class="datagrid">
<td align="left">W</td>
<td><input type="hidden" name="hid_desc1" value="Limit recommended (Least of U or V)


">Limit recommended (Least of U or V)
[W]

</td>
<td><input type="text" name="txtAmount11" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("percentof181")))) %>" style="background: #FFFFCC; font-weight: bold;text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);"></td>
</tr>
<%} %>


</table>
</div>
</table>
<%} %>
		  	
		  	</td>					  
		</tr>
	 	</table>
	  <br>
	 </td>
 </tr>
</table>
<br> 
	<%if(strPageName.equalsIgnoreCase("GECL")){ %>
<lapschoice:combuttonnew btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' btnnames='Edit_Save_Cancel_Delete'/>
<%}else{ %>
<lapschoice:combuttonnew btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' btnnames='Edit_Save_Cancel_Delete_Audit Trail'/>
<%} %>
<input type="hidden" name="hidPage" value="35">
<input type="hidden" name="hidBeanId" value="">
 <input type="hidden" name="hidBeanMethod" value=""> 
 <input type="hidden" name="hidBeanGetMethod" value=""> 
<input type="hidden" name="hidAction" value="">
<input type="hidden" name="hidSourceUrl" value=""> 
<input type="hidden" name="hidCommentPage" value="">
<input type="hidden" name="flowtype1" value="<%=strPageName %>">
<INPUT TYPE="hidden" name="strAssessment" value = "<%=request.getParameter("strAssessment")%>">
<input type="hidden" name="hidtxt_cmtans" value="<%=Helper.correctNull((String) hshValues.get("strnameofsector"))%>"> 
<input type="hidden" name="strAppType" value="<%=Helper.correctNull((String) session.getAttribute("strAppType"))%>"> 
<input type="hidden" name="hiduserclass" value="<%=Helper.correctNull((String) hshValues.get("usr_class"))%>"> 
<br>
</form>
</body>
</html>