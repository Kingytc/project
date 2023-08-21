<%@include file="../share/directives.jsp"%>
<%
//out.println(hshValues);
	ArrayList arrRow= new ArrayList();
	ArrayList arrCol=new ArrayList();	
	String applevel = "";
	String appstatus="";
String strInccount=Helper.correctNull((String)hshValues.get("inccount"));
String strEligInccount=Helper.correctNull((String)hshValues.get("PRD_NOOFAPPLICNTINC"));
String strPrdType=Helper.correctNull((String)hshValues.get("strPrdType"));
String strPageParam = Helper.correctNull(
		(String) session.getAttribute("strModifyterms")).trim();
String strFlag="N";
String strappstatus=Helper.correctNull((String)hshValues.get("strappstatus"));
if(strPageParam.contains("GUAR"))
{
	strFlag="Y";
}
String strGuarantor_check=Helper.correctNull((String)hshValues.get("strGuarantor"));
 arrRow=(ArrayList)hshValues.get("cibilarrrow");
 
 appstatus=Helper.correctNull((String)hshValues.get("appstatus"));
 

java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
nf.setMinimumFractionDigits(2);
nf.setMaximumFractionDigits(2);
nf.setGroupingUsed(false);

String strProductType=Helper.correctNull((String)hshValues.get("strProductType"));
String strDocUserId=Helper.correctNull((String)hshValues.get("strUserId"));
String applnHolder=Helper.correctNull((String)hshValues.get("strAppHolder"));
String strcnt=Helper.correctNull((String)hshValues.get("cnt"));
String strAPPAMBEREXISTS=Helper.correctNull((String)hshValues.get("strAPPAMBEREXISTS"));

%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script type="text/javascript">
var btnenable="<%=Helper.correctNull((String)request.getParameter("btnenable"))%>";
var appstatus="<%=appstatus%>";
var varProductType="<%=strProductType%>";
var sysdate="<%=Helper.getCurrentDateTime()%>";
var strDocUserId="<%=strDocUserId%>";
var strAppStatus="<%=appstatus%>";
var varappstatus="<%=strappstatus%>";
var varApplHolder="<%=applnHolder%>";
var strVERIPERMOBT="<%=Helper.correctNull((String)hshValues.get("strVERIPERMOBT"))%>";
var VARAPPAMBEREXISTS="<%=strAPPAMBEREXISTS%>";
//var stremploy="";
function gototab(beanid,methodname,pagename)
{
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

function callDeviation(action)
{
	
	var appid=document.forms[0].hidapplicantid.value;
	appno=document.forms[0].appno.value;
	var purl ="<%=ApplicationParams.getAppUrl()%>action/digi_deviationdetail.jsp?hidBeanId=DigitalAppInterface&hidBeanGetMethod=getDigiDeviationDetail&Applicationno="+appno+"&btnenable="+btnenable+"&hidapplicantid="+appid;
	var xpos = (screen.width - 900) / 2;
	var ypos = (screen.height - 700) / 2;
	var prop = 'scrollbars=yes,menubar=YES,width=900,height=550,status=yes';
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,'Deviation',prop);
}
function changeValuation()
{
	
	
}


<%-- 

function onload()
{
	 if(document.forms[0].cmd_cbs_create.length==undefined)
	{
		document.forms[0].cmd_cbs_create.disabled=true;
	}
	else
	{
		for(var i=0;i<document.forms[0].cmd_cbs_create.length;i++)
		{
			document.forms[0].cmd_cbs_create[i].disabled=true;
		}
	}
	  

	
	 <%if(arrRow.size()>0 && arrRow!=null) 
           	{
           		for(int i=0;i<arrRow.size();i++)
           		{
           			arrCol=(ArrayList)arrRow.get(i);
           			
           			String strcbsid=Helper.correctNull((String)arrCol.get(1));
           			String straddressflag=Helper.correctNull((String)arrCol.get(4));
        			String strpanflag=Helper.correctNull((String)arrCol.get(5));
        			String strfiaddressflag=Helper.correctNull((String)arrCol.get(6));
        			String strfiempflag=Helper.correctNull((String)arrCol.get(7));
        			String strfibankstatflag=Helper.correctNull((String)arrCol.get(8));

           			if(strcbsid.equals(""))
           			{
         			%>
         				document.forms[0].chk_proofaddress[<%=i%>].checked=false;
						document.forms[0].chk_proofaddress[<%=i%>].disabled=false;
						document.forms[0].chk_pan[<%=i%>].checked=false;
   						document.forms[0].chk_pan[<%=i%>].disabled=false;
           			<%	
           			}
           			else
           			{
           				if(straddressflag.equalsIgnoreCase("Y"))
           				{
           			%>
   						document.forms[0].chk_proofaddress[<%=i%>].checked=false;
   						document.forms[0].chk_proofaddress[<%=i%>].disabled=false;
       				<%
           				}
           				else
           				{
           				%>
       						document.forms[0].chk_proofaddress[<%=i%>].checked=true;
       						document.forms[0].chk_proofaddress[<%=i%>].disabled=true;
           				<%
           				}
           				if(strpanflag.equalsIgnoreCase("Y"))
           				{
           			%>
   						document.forms[0].chk_pan[<%=i%>].checked=false;
   						document.forms[0].chk_pan[<%=i%>].disabled=false;
       				<%
           				}
           				else
           				{
           				%>
       						document.forms[0].chk_pan[<%=i%>].checked=true;
       						document.forms[0].chk_pan[<%=i%>].disabled=true;
           				<%
           				}
           			}
           			if(strfiaddressflag.equalsIgnoreCase("Y"))
           			{
           			%>
           				document.forms[0].chk_fiaddress[<%=i%>].checked=false;
   						document.forms[0].chk_fiaddress[<%=i%>].disabled=false;
           			<%}
           			else
       				{
       				%>
   						document.forms[0].chk_fiaddress[<%=i%>].checked=true;
   						document.forms[0].chk_fiaddress[<%=i%>].disabled=true;
       				<%
       				}
           			if(strfiempflag.equalsIgnoreCase("Y"))
           			{
           			%>
           				document.forms[0].chk_employment[<%=i%>].checked=false;
   						document.forms[0].chk_employment[<%=i%>].disabled=false;
           			<%}
           			else
       				{
       				%>
   						document.forms[0].chk_employment[<%=i%>].checked=true;
   						document.forms[0].chk_employment[<%=i%>].disabled=true;
       				<%
       				}
           			if(strfibankstatflag.equalsIgnoreCase("Y"))
           			{
           			%>
           				document.forms[0].chk_bankstat[<%=i%>].checked=false;
   						document.forms[0].chk_bankstat[<%=i%>].disabled=false;
           			<%}
           			else
       				{
       				%>
   						document.forms[0].chk_bankstat[<%=i%>].checked=true;
   						document.forms[0].chk_bankstat[<%=i%>].disabled=true;
       				<%
       				}
           			
           		}
            }

		%> 

		
}

 --%>
 /* function callcheck(row)
{
	if(document.forms[0].chk_proofaddress[row].checked==true &&  document.forms[0].chk_pan[row].checked==true &&
		document.forms[0].chk_fiaddress[row].checked==true && document.forms[0].chk_employment[row].checked==true && document.forms[0].chk_bankstat[row].checked==true )
	{
		document.forms[0].cmd_cbs_create[row].disabled=false;
	}
	else
	{
		document.forms[0].cmd_cbs_create[row].disabled=true;
	}
} */

 function doSave()
{
	var varkycchklist="",varfieldinvstchklist="",varKYCchk="";
	var proofcrntaddress="",varprofpmpaddrss="",pan="",Varbusinesexistenence="";
	var arrSize="<%=arrRow.size()%>";
	var	appid="";
	var cbsId="";
	<%-- 
	<%if(arrRow.size()>0 && arrRow!=null) 
	{
		for(int j=0;j<arrRow.size();j++)
		{
			arrCol=(ArrayList)arrRow.get(j);
    %>
   		   varproofchk="";
	
 --%>
   		<%if(arrRow.size()>0 && arrRow!=null) 
   		{
   			for(int i=0;i<arrRow.size();i++)
   			{
   				arrCol=(ArrayList)arrRow.get(i);
   	    %>
   	   		   varproofchk="";
   	   	       var appid="";
   				
   	   		  
   	      appid=document.forms[0].hid_appid[<%=i%>].value;
         
          docPANdate=document.forms[0].hid_PANdate[<%=i%>].value;
         
          DocPANUser=document.forms[0].hid_PANuser[<%=i%>].value;
          <%-- DocAddDate=document.forms[0].hid_fiaddressdate[<%=i%>].value;
          DocAddUser=document.forms[0].hid_fiaddressuser[<%=i%>].value; --%>
          <%-- DocEmpDate=document.forms[0].hid_empdate[<%=i%>].value;
          DocEmpUser=document.forms[0].hid_empuser[<%=i%>].value;
           DocPPAUser=document.forms[0].hid_prfaddrsuser[<%=i%>].value;
            docPPAdate=document.forms[0].hid_prfaddrsdate[<%=i%>].value;--%>
          DocBankDate=document.forms[0].hid_bankdate[<%=i%>].value;
          DocBankUser=document.forms[0].hid_bankuser[<%=i%>].value;
          <%-- DocBEDate=document.forms[0].hid_BEdate[<%=i%>].value;
          DocBEUser=document.forms[0].hid_BEuser[<%=i%>].value; --%>
          DocITRDate=document.forms[0].hid_ITRdate[<%=i%>].value;
          DocITRUser=document.forms[0].hid_ITRuser[<%=i%>].value;
          <%--   DocPCADate=document.forms[0].hid_proofcurrentaddrdate[<%=i%>].value;
          DocPCAUser=document.forms[0].hid_proofcurrentadduser[<%=i%>].value;
          DocPRADate=document.forms[0].hid_PRAdate[<%=i%>].value;
          DocPRAUser=document.forms[0].hid_PRAuser[<%=i%>].value;
          DocPOADate=document.forms[0].hid_POAdate[<%=i%>].value;
		  DocPOAUser=document.forms[0].hid_POAuser[<%=i%>].value;
          DocBPDate=document.forms[0].hid_BProfdate[<%=i%>].value;
		  DocBPUser=document.forms[0].hid_BProfuser[<%=i%>].value;
		  --%>
		 DocBusinessDate= document.forms[0].hid_businessplacedate[<%=i%>].value;
		DocBusinessUser= document.forms[0].hid_businessplaceuser[<%=i%>].value;
		
		 	
		 
		DocResidentVisitDate=document.forms[0].hid_residenceuser[<%=i%>].value;
		DocResidentVisitUser=document.forms[0].hid_residencedate[<%=i%>].value;

		 
		DocCollateralDate=document.forms[0].hid_collateraldate[<%=i%>].value;
		DocCollateralUser=document.forms[0].hid_collateraluser[<%=i%>].value;


		 
		DocGstDate=document.forms[0].hid_gstndate[<%=i%>].value;
		DocGstUser=document.forms[0].gid_gstnuser[<%=i%>].value;

		 
		DocUANDate=document.forms[0].hid_UANdate[<%=i%>].value;
		DocUANUser=document.forms[0].hid_UANuser[<%=i%>].value;

		
		DocBalanceDate=document.forms[0].hid_balancedate[<%=i%>].value;
		DocBalanceUser=document.forms[0].hid_balanceuser[<%=i%>].value;


		 
		DocTradDate=document.forms[0].hid_tradingdate[<%=i%>].value;
		DocTradeUser=document.forms[0].hid_tradinguser[<%=i%>].value;

		 
		DocStatDate=document.forms[0].hid_statementdate[<%=i%>].value;
		DocStatUser=document.forms[0].hid_statementuser[<%=i%>].value;

		 
		DocCorpDate=document.forms[0].hid_litigationcorpdate[<%=i%>].value;
		DocCorpuser=document.forms[0].hid_litigationcorpuser[<%=i%>].value;

		 
		DocIndvidualDate=document.forms[0].hid_litigationdate[<%=i%>].value;
		DocIndvidualUser=document.forms[0].hid_litigationuser[<%=i%>].value;

		 
		DocSubDate=document.forms[0].hid_submissiondate[<%=i%>].value;
		DocSubUser=document.forms[0].hid_submissionuser[<%=i%>].value;

		 
		  if(document.forms[0].chk_business[<%=i%>].checked==true) 
          {
           	varproofchk=appid+"@BPV@"+DocBusinessDate+" @"+DocBusinessUser+" @";
          }else if(document.forms[0].chk_businessNA[<%=i%>].checked==true) 
          {
             	varproofchk=appid+"@BPVNA@"+DocBusinessDate+" @"+DocBusinessUser+" @";
            }
          else
          {
        	  varproofchk=appid+"@ @ @ @";
        	  
        	  //varproofchk=varproofchk+" @ @ @";
          }
		  if(document.forms[0].chk_residentvisit[<%=i%>].checked==true)
          {
              /* if(varproofchk=="") */
              
           	   varproofchk=varproofchk+"RV@"+DocResidentVisitDate+" @"+DocResidentVisitUser+" @";
              
          }else  if(document.forms[0].chk_residentvisitNA[<%=i%>].checked==true)
          {
           	   varproofchk=varproofchk+"RVNA@"+DocResidentVisitDate+" @"+DocResidentVisitUser+" @";
          }
          else
          {
       	  // varproofchk=appid+"@ @ @ @";
        	  varproofchk=varproofchk+" @ @ @";
          }
          
          if(document.forms[0].chk_pan[<%=i%>].checked==true) 
          {
           	varproofchk=varproofchk+"PAN@"+docPANdate+" @"+DocPANUser+" @";
          }else if(document.forms[0].chk_panNA[<%=i%>].checked==true) 
          {
             	varproofchk=varproofchk+"PANNA@"+docPANdate+" @"+DocPANUser+" @";
            }	
          else
          {
       	   varproofchk=varproofchk+" @ @ @";
          }
          
          
          if(document.forms[0].chk_collateral[<%=i%>].checked==true) 
          {
           	varproofchk=varproofchk+"CV@"+DocCollateralDate+" @"+DocCollateralUser+" @";
          }
          else if(document.forms[0].chk_collateralNA[<%=i%>].checked==true) 
          {
             	varproofchk=varproofchk+"CVNA@"+DocCollateralDate+" @"+DocCollateralUser+" @";
          }
          else
          {
       	   varproofchk=varproofchk+" @ @ @";
          }
          
          
          if(document.forms[0].chk_bankstat[<%=i%>].checked==true) 
          {
           	varproofchk=varproofchk+"BNK@"+DocBankDate+" @"+DocBankUser+" @";
          }else if(document.forms[0].chk_bankstatNA[<%=i%>].checked==true) 
          {
             	varproofchk=varproofchk+"BNKNA@"+DocBankDate+" @"+DocBankUser+" @";
            }
          else
          {
       	   varproofchk=varproofchk+" @ @ @";
          }
          
         <%--  
          if(document.forms[0].chk_busexst[<%=i%>].checked==true) 
          {
           	varproofchk=varproofchk+"BE@"+DocBEDate+"@"+DocBEUser+"@";
          }
          else
          {
       	   varproofchk=varproofchk+" @ @ @";
          }
           --%>
          if(document.forms[0].chk_itr[<%=i%>].checked==true) 
          {
           	varproofchk=varproofchk+"ITR@"+DocITRDate+" @"+DocITRUser+" @";
          }else if(document.forms[0].chk_itrNA[<%=i%>].checked==true) 
          {
             	varproofchk=varproofchk+"ITRNA@"+DocITRDate+" @"+DocITRUser+" @";
            }
          else
          {
       	   
        	  varproofchk=varproofchk+" @ @ @";
          }
          
          if(document.forms[0].chk_gstin[<%=i%>].checked==true) 
          {
           	varproofchk=varproofchk+"GSTIN@"+DocGstDate+" @"+DocGstUser+" @";
          }else if(document.forms[0].chk_gstinNA[<%=i%>].checked==true) 
          {
             	varproofchk=varproofchk+"GSTINNA@"+DocGstDate+" @"+DocGstUser+" @";
            }
          else
          {
       	   varproofchk=varproofchk+" @ @ @";
          }
          
        
          if(document.forms[0].chk_uan[<%=i%>].checked==true) 
          {
           	varproofchk=varproofchk+"UAN@"+DocUANDate+" @"+DocUANUser+" @";
          }else if(document.forms[0].chk_uanNA[<%=i%>].checked==true) 
          {
             	varproofchk=varproofchk+"UANNA@"+DocUANDate+" @"+DocUANUser+" @";
            }
          else
          {
       	   varproofchk=varproofchk+" @ @ @";
          }
          
          
          
          if(document.forms[0].chk_balancesheet[<%=i%>].checked==true) 
          {
           	varproofchk=varproofchk+"BS@"+DocBalanceDate+" @"+DocBalanceUser+" @";
          }else if(document.forms[0].chk_balancesheetNA[<%=i%>].checked==true) 
          {
             	varproofchk=varproofchk+"BSNA@"+DocBalanceDate+" @"+DocBalanceUser+" @";
            }
          else
          {
       	   varproofchk=varproofchk+" @ @ @";
          }

          if(document.forms[0].chk_tra_pro_loss[<%=i%>].checked==true) 
          {
           	varproofchk=varproofchk+"TPL@"+DocTradDate+" @"+DocTradeUser+" @";
          }else if(document.forms[0].chk_tra_pro_lossNA[<%=i%>].checked==true) 
          {
             	varproofchk=varproofchk+"TPLNA@"+DocTradDate+" @"+DocTradeUser+" @";
            }
          else
          {
       	   varproofchk=varproofchk+" @ @ @";
          }

          if(document.forms[0].chk_financialstat[<%=i%>].checked==true) 
          {
           	varproofchk=varproofchk+"SFFS@"+DocStatDate+" @"+DocStatUser+" @";
          } else if(document.forms[0].chk_financialstatNA[<%=i%>].checked==true) 
          {
             	varproofchk=varproofchk+"SFFSNA@"+DocStatDate+" @"+DocStatUser+" @";
            }
          else
          {
       	   varproofchk=varproofchk+" @ @ @";
          }
          if(document.forms[0].chk_litigationcorp[<%=i%>].checked==true) 
          {
           	varproofchk=varproofchk+"CLC@"+DocCorpDate+" @"+DocCorpuser+" @";
          }else if(document.forms[0].chk_litigationcorpNA[<%=i%>].checked==true) 
          {
             	varproofchk=varproofchk+"CLCNA@"+DocCorpDate+" @"+DocCorpuser+" @";
            }
          else
          {
       	   varproofchk=varproofchk+" @ @ @";
          }
          if(document.forms[0].chk_litigationindiv[<%=i%>].checked==true) 
          {
           	varproofchk=varproofchk+"CLI@"+DocIndvidualDate+" @"+DocIndvidualUser+" @";
          }
          else
          {
       	   varproofchk=varproofchk+" @ @ @";
          }

          if(document.forms[0].chk_submission[<%=i%>].checked==true) 
          {
           	varproofchk=varproofchk+"DOC@"+DocSubDate+" @"+DocSubUser+" @";
          }
          else
          {
       	   varproofchk=varproofchk+" @ @ @";
          }
       <%--    
          if(document.forms[0].chk_fiaddress[<%=i%>].checked==true) 
          {
           	varproofchk=varproofchk+"ADD@"+DocAddDate+"@"+DocAddUser+"@";
          }
          else
          {
       	   varproofchk=varproofchk+" @ @ @";
          } --%>
          
         
	
		
		  
          if(varKYCchk==""){
         
        	  varKYCchk=varproofchk+"~";
          }
          else{
       	   varKYCchk=varKYCchk+varproofchk+"~";
          }
		   
          
<%}} if(strAPPAMBEREXISTS.equals("Y")){  %>
	if(document.forms[0].perm_obtaind.value=="S" || document.forms[0].perm_obtaind.value=="")
	{
		ShowAlert('111', "Permission Obtained"); 	
		document.forms[0].perm_obtaind.focus();
		return;	
	}
	
	if(document.forms[0].dev_remarks.value=="")
	{
		ShowAlert('121', "Remarks"); 	
		document.forms[0].dev_remarks.focus();
		return;	
	}
<% } %>
document.forms[0].hidKYCChk.value=varKYCchk;
document.forms[0].hidAction.value="Savehl";
document.forms[0].action=appURL+"controllerservlet";
document.forms[0].hidBeanMethod.value="msmeUpdateSanctionDetails";
document.forms[0].hidBeanGetMethod.value="msmeGetDigiDecisionDetail";
document.forms[0].hidBeanId.value="MsmeDigitalAppInterface";			
document.forms[0].hidSourceUrl.value="/action/appl_digitalisation_decision_msme.jsp";
document.forms[0].submit();
document.getElementById("form_blur").style.visibility="visible";
document.getElementById("progress").style.visibility="visible";
	}
				
		
		function onload()
		{
			if(varApplHolder!=strDocUserId){
				document.forms[0].cmd_save.disabled=true;
			}
			var apistatus="<%=Helper.correctNull((String)hshValues.get("apistatus"))%>";
			var apistatusdesc="<%=Helper.correctNull((String)hshValues.get("apistatusdesc"))%>";
			if(apistatus!="")
			{
				alert(apistatus+". "+apistatusdesc);
			}
			
			var Submitstatus="<%=Helper.correctNull((String)hshValues.get("Submitstatus"))%>";
			var rejectstatus="<%=Helper.correctNull((String)hshValues.get("rejectstatus"))%>";
			var strcbscustflag="";
			 
			if(Submitstatus=="Sucess")
			{
				alert("Your application has been Approved successfully");
				document.forms[0].cmd_submit.disabled=true;
				
			}
			if(rejectstatus=="Sucess")
			{
				alert("Your application has been Rejected successfully");
				document.forms[0].cmd_reject.disabled=true;
				
			}
			if(document.forms[0].cmd_cbs_create.length==undefined)
			{
				document.forms[0].cmd_cbs_create.disabled=true;
			}
			else
			{
				for(var i=0;i<document.forms[0].cmd_cbs_create.length;i++)
				{
					document.forms[0].cmd_cbs_create[i].disabled=true;
				}
			}
			 
			
			
			

				if(varProductType=="pH")
				{
					document.all.id_applicationdet_loantype.style.visibility="visible";
					document.all.id_applicationdet_loantype.style.position="relative";
				}
				else
				{
					document.all.id_applicationdet_loantype.style.visibility="hidden";
					document.all.id_applicationdet_loantype.style.position="absolute";
				}
				if(varappstatus=="pa")
				{
					document.forms[0].cmd_save.disabled=true;
					
				} else if(varappstatus=="pa" && VARAPPAMBEREXISTS == "Y")
				{
					document.forms[0].cmd_save.disabled=true;
					document.forms[0].perm_obtaind.disabled=true;
					document.forms[0].dev_refnum.disabled=true;
					document.forms[0].dev_remarks.disabled=true;
					
				}
				
				if(varappstatus=="pr")
				{
					//document.forms[0].cmd_reject.disabled=true;
					document.forms[0].cmd_save.disabled=true;
					//document.forms[0].cmd_submit.disabled=true;
				}
				
				
				
				/* alert("stremploy"+stremploy)
				 if(stremploy=="")
					{
					
					 document.all.empl.style.visibility="hidden";
					
					} */
					
				 
				
					
			
				
				<%
				String StrPAVal="",StrPANVal="",StrEMPVal="",StrBNKVal="",StrPRAVal="",
				StrPOAVal="",StrPCAVal="",StrPPAVal="",StrBPVal="",StrITRVal="",
				StrCVVal="",StrRVVal="",StrBPV="",StrGSTVal="",StrUANVal="",StrBSval="",StrTPLVal="",StrCLCVal="",StrCLIVal="",StrDSVal="",StrSFFSVal="";
				
		       
				if(arrRow.size()>0 && arrRow!=null) 
			      {
			       
					for(int i=0;i<arrRow.size();i++)
			         {
			         arrCol=(ArrayList)arrRow.get(i);
			         String strDocVal=Helper.correctNull((String)arrCol.get(14));
			         String strcbscustflag=Helper.correctNull((String)arrCol.get(23));
			         String stritrflag=Helper.correctNull((String)arrCol.get(31));
			         String strpanflag=Helper.correctNull((String)arrCol.get(5));
			         String strfibankstat=Helper.correctNull((String)arrCol.get(8));
			         
			         String strCollateral=Helper.correctNull((String)arrCol.get(33));
			         String strBusinessVisit=Helper.correctNull((String)arrCol.get(35));
			         String strresidencVisit=Helper.correctNull((String)arrCol.get(34));
					String strUAN=Helper.correctNull((String)arrCol.get(37));
					String strGST=Helper.correctNull((String)arrCol.get(36));
					String strBalanceSheet=Helper.correctNull((String)arrCol.get(38));
					String strTrading=Helper.correctNull((String)arrCol.get(39));
					String strFinancial=Helper.correctNull((String)arrCol.get(40));
					String strLitigationCorp=Helper.correctNull((String)arrCol.get(41));
					String strLitigatonInd=Helper.correctNull((String)arrCol.get(42));
					String strDocSub=Helper.correctNull((String)arrCol.get(43));
												
					
					
					
					
					//  String strpermaddressflag=Helper.correctNull((String)arrCol.get(21));
			         
			        // String strfiemp=Helper.correctNull((String)arrCol.get(7));
			         
			        // String strfiaddress=Helper.correctNull((String)arrCol.get(6));
			        // String strbusproofflag=Helper.correctNull((String)arrCol.get(30));
			         
			        // String strofficeaddress=Helper.correctNull((String)arrCol.get(32));
			        // String strcurrentaddress=Helper.correctNull((String)arrCol.get(4));
			         
			         if(!strDocVal.equalsIgnoreCase(""))
		 			 {
						String[] strDocSplitVal=strDocVal.split("@");
						StrPANVal=strDocSplitVal[2];//3
						//StrADDVal=strDocSplitVal[8];//Commented
						//StrEMPVal=strDocSplitVal[6];//10
						StrBNKVal=strDocSplitVal[4];//11
						//StrPRAVal=strDocSplitVal[3];//6
						//StrPOAVal=strDocSplitVal[7];//7
						//StrPCAVal=strDocSplitVal[0];//1
						//StrPPAVal=strDocSplitVal[1];//2
						//StrBEVal=strDocSplitVal[3];//4Commented
						//StrBPVal=strDocSplitVal[8];//8
						StrITRVal=strDocSplitVal[5];//5
						StrCVVal=strDocSplitVal[3];
						StrRVVal=strDocSplitVal[1];
						StrUANVal=strDocSplitVal[7];
						StrBSval=strDocSplitVal[8];
						StrTPLVal=strDocSplitVal[9];
						StrCLCVal=strDocSplitVal[11];
						StrCLIVal=strDocSplitVal[12];
						StrDSVal=strDocSplitVal[13];
						StrSFFSVal=strDocSplitVal[10];
						StrBPV=strDocSplitVal[0];
						StrGSTVal=strDocSplitVal[6];
			//0 BPV  1 RV  2 PAN   3 CV  4 BNK 5 ITR 6 GSTIN   7 UAN   8 BS        9 TPL   	10	SFFS  11 CLC  12 CLI 13 DOC
			
		 			 
		 			 }
			       
			         
			         if(strCollateral.equalsIgnoreCase("N"))
				 		{%>
				        
				 		document.forms[0].chk_collateral[<%=i%>].checked=true;
				 		

				        	 <%}
			         
			         
			         if(strpanflag.equalsIgnoreCase("N"))
				 		{%>
				        
				 		document.forms[0].chk_pan[<%=i%>].checked=true;
				 		document.forms[0].chk_pan[<%=i%>].disabled=true;
				 		document.forms[0].chk_panNA[<%=i%>].disabled=true;

				        	 <%} 
			      
			         
			         if(strBusinessVisit.equalsIgnoreCase("N"))
				 		{%>
				        
				 		document.forms[0].chk_business[<%=i%>].checked=true;
				 		document.forms[0].chk_business[<%=i%>].disabled=true;
				 		document.forms[0].chk_businessNA[<%=i%>].disabled=true;

				        	 <%} 
			         
			         if(strresidencVisit.equalsIgnoreCase("N"))
				 		{%>
				        
				 		document.forms[0].chk_residentvisit[<%=i%>].checked=true;
				 		document.forms[0].chk_residentvisit[<%=i%>].disabled=true;
				 		document.forms[0].chk_residentvisitNA[<%=i%>].disabled=true;
				        	 <%} 
			         
			         
			         if(strfibankstat.equalsIgnoreCase("N"))
				 		{%>
				        
				 		document.forms[0].chk_bankstat[<%=i%>].checked=true;
				 		document.forms[0].chk_bankstat[<%=i%>].disabled=true;
				 		document.forms[0].chk_bankstatNA[<%=i%>].disabled=true;

				        	 <%} 
			         
			         
			         
			         if(strUAN.equalsIgnoreCase("N"))
				 		{%>
				        
				 		document.forms[0].chk_uan[<%=i%>].checked=true;
				 		document.forms[0].chk_uan[<%=i%>].disabled=true;
				 		document.forms[0].chk_uanNA[<%=i%>].disabled=true;
				        	 <%} 
			         
			         
			         if(strGST.equalsIgnoreCase("N"))
				 		{%>
				        
				 		document.forms[0].chk_gstin[<%=i%>].checked=true;
				 		document.forms[0].chk_gstin[<%=i%>].disabled=true;
				 		document.forms[0].chk_gstinNA[<%=i%>].disabled=true;
				        	 <%} 
			         
			         if(stritrflag.equalsIgnoreCase("N"))
				 		{%>
				        
				 		document.forms[0].chk_itr[<%=i%>].checked=true;
				 		document.forms[0].chk_itr[<%=i%>].disabled=true;
				 		document.forms[0].chk_itrNA[<%=i%>].disabled=true;
				        	 <%} 
			         
			         if(strBalanceSheet.equalsIgnoreCase("N"))
				 		{%>
				        
				 		document.forms[0].chk_balancesheet[<%=i%>].checked=true;
				 		document.forms[0].chk_balancesheet[<%=i%>].disabled=true;
				 		document.forms[0].chk_balancesheetNA[<%=i%>].disabled=true;
				        	 <%}
			         
			         
			         
			         if(strTrading.equalsIgnoreCase("N"))
				 		{%>
				        
				 		document.forms[0].chk_tra_pro_loss[<%=i%>].checked=true;
				 		document.forms[0].chk_tra_pro_loss[<%=i%>].disabled=true;
				 		document.forms[0].chk_tra_pro_lossNA[<%=i%>].disabled=true;

				        	 <%}
			         if(strFinancial.equalsIgnoreCase("N"))
				 		{%>
				        
				 		document.forms[0].chk_financialstat[<%=i%>].checked=true;
				 		document.forms[0].chk_financialstat[<%=i%>].disabled=true;
				 		document.forms[0].chk_financialstatNA[<%=i%>].disabled=true;

				        	 <%}
			         if(strLitigationCorp.equalsIgnoreCase("N"))
				 		{%>
				        
				 		document.forms[0].chk_litigationcorp[<%=i%>].checked=true;
				 		document.forms[0].chk_litigationcorp[<%=i%>].disabled=true;
				 		document.forms[0].chk_litigationcorpNA[<%=i%>].disabled=true;

				        	 <%}
			         if(strLitigatonInd.equalsIgnoreCase("N"))
				 		{%>
				        
				 		document.forms[0].chk_litigationindiv[<%=i%>].checked=true;
				 		document.forms[0].chk_litigationindiv[<%=i%>].disabled=true;
				 		document.forms[0].chk_litigationindivNA[<%=i%>].disabled=true;

				        	 <%}
			         if(strDocSub.equalsIgnoreCase("N"))
				 		{%>
				        
				 		document.forms[0].chk_submission[<%=i%>].checked=true;
				 		document.forms[0].chk_submission[<%=i%>].disabled=true;
				 		document.forms[0].chk_submissionNA[<%=i%>].disabled=true;
				 			 <%}
			        
			       
			         
		 			 if(StrCVVal.equalsIgnoreCase("CV")){%>    
	      				document.forms[0].chk_collateral[<%=i%>].checked=true;
	      				
	     	  		 	<%} 
		 			 if(StrRVVal.equalsIgnoreCase("RV")){%>
		      			document.forms[0].chk_residentvisit[<%=i%>].checked=true;
		      			
			       <%}
		 			if(StrPANVal.equalsIgnoreCase("PAN")){%>    
			        	document.forms[0].chk_pan[<%=i%>].checked=true;
			        	
						
					<%}
		 			
		 			
		 			
					if(StrUANVal.equalsIgnoreCase("UAN")){%>    
			        	document.forms[0].chk_uan[<%=i%>].checked=true;
			        	
					<%}if(StrBNKVal.equalsIgnoreCase("BNK")){%>    
			        	document.forms[0].chk_bankstat[<%=i%>].checked=true;
			        	
			       <%}if(StrBSval.equalsIgnoreCase("BS")){%>    
		       			document.forms[0].chk_balancesheet[<%=i%>].checked=true;
		       			
		      	  	 <%}
	      	  		 
			              	  		 
 	 			  if(StrTPLVal.equalsIgnoreCase("TPL")){%>    
					document.forms[0].chk_tra_pro_loss[<%=i%>].checked=true;
					
  					<%}
 	 			  if(StrITRVal.equalsIgnoreCase("ITR")){%>    
					document.forms[0].chk_itr[<%=i%>].checked=true;
						
<% }  	 			  
 	 			
 	 			if(StrCLCVal.equalsIgnoreCase("CLC")){%>    
				document.forms[0].chk_litigationcorp[<%=i%>].checked=true;
					
<% }
 	 			if(StrCLIVal.equalsIgnoreCase("CLI")){%>    
				document.forms[0].chk_litigationindiv[<%=i%>].checked=true;
				
<% }
 	 			if(StrDSVal.equalsIgnoreCase("DOC")){%>    
				document.forms[0].chk_submission[<%=i%>].checked=true;
					
<% }
 	 			if(StrSFFSVal.equalsIgnoreCase("SFFS")){%>    
				document.forms[0].chk_financialstat[<%=i%>].checked=true;
				
<% }

 	 			if(StrBPV.equalsIgnoreCase("BPV")){%>    
				document.forms[0].chk_business[<%=i%>].checked=true;
				
<% }
 	 			if(StrGSTVal.equalsIgnoreCase("GSTIN")){%>    
				document.forms[0].chk_gstin[<%=i%>].checked=true;
				
<% }

%>
<% 
	 	 			if(StrBPV.equalsIgnoreCase("BPVNA")){%>    
	 	 			document.forms[0].chk_businessNA[<%=i%>].checked=true;
	 	 			
<% }
					if(StrRVVal.equalsIgnoreCase("RVNA")){%>
						document.forms[0].chk_residentvisitNA[<%=i%>].checked=true;
						
<%}	  
		 			if(StrPANVal.equalsIgnoreCase("PANNA")){%>    
			        	document.forms[0].chk_panNA[<%=i%>].checked=true;
			        	
						
<%}
	 			
				if(StrUANVal.equalsIgnoreCase("UANNA")){%>    
		        	document.forms[0].chk_uanNA[<%=i%>].checked=true;
		        	
<%}				
				if(StrCVVal.equalsIgnoreCase("CVNA")){%>    
					document.forms[0].chk_collateralNA[<%=i%>].checked=true;
						
	
<%}
				if(StrBNKVal.equalsIgnoreCase("BNKNA")){%>    
		        	document.forms[0].chk_bankstatNA[<%=i%>].checked=true;
		        	
<%}			
				if(StrBSval.equalsIgnoreCase("BSNA")){%>    
	       			document.forms[0].chk_balancesheetNA[<%=i%>].checked=true;
	       				
<%}              	  		 
	 			  if(StrTPLVal.equalsIgnoreCase("TPLNA")){%>    
				document.forms[0].chk_tra_pro_lossNA[<%=i%>].checked=true;
					
<%}
	 			  if(StrITRVal.equalsIgnoreCase("ITRNA")){%>    
				document.forms[0].chk_itrNA[<%=i%>].checked=true;
					
<% }  	 			  
	 			
	 			if(StrCLCVal.equalsIgnoreCase("CLCNA")){%>    
			document.forms[0].chk_litigationcorpNA[<%=i%>].checked=true;
			
<% }
	 			if(StrCLIVal.equalsIgnoreCase("CLINA")){%>    
			document.forms[0].chk_litigationindivNA[<%=i%>].checked=true;
				
<% }
	 			if(StrDSVal.equalsIgnoreCase("DOCNA")){%>    
			document.forms[0].chk_submissionNA[<%=i%>].checked=true;
			
<% }
	 			if(StrSFFSVal.equalsIgnoreCase("SFFSNA")){%>    
			document.forms[0].chk_financialstatNA[<%=i%>].checked=true;
			
<% }
	 			if(StrGSTVal.equalsIgnoreCase("GSTINNA")){%>    
			document.forms[0].chk_gstinNA[<%=i%>].checked=true;
<% }			
%>
		
				  strcbscustflag="<%=strcbscustflag%>";	
				
					
					
		      	   
			       if(varappstatus!="pa" && varappstatus!="ca")
					{		
			      	 	if(document.forms[0].chk_business[<%=i%>].checked==true &&  document.forms[0].chk_pan[<%=i%>].checked==true && 
			      	 			 document.forms[0].chk_residentvisit[<%=i%>].checked==true && document.forms[0].chk_bankstat[<%=i%>].checked==true &&  
			      	 			document.forms[0].chk_itr[<%=i%>].checked==true && document.forms[0].chk_collateral[<%=i%>].checked==true && document.forms[0].chk_gstin[<%=i%>].checked==true && 
			      	 			document.forms[0].chk_uan[<%=i%>].checked==true  && document.forms[0].chk_balancesheet[<%=i%>].checked==true &&
			      	 			document.forms[0].chk_tra_pro_loss[<%=i%>].checked==true && document.forms[0].chk_financialstat[<%=i%>].checked==true &&
			      	 			document.forms[0].chk_litigationcorp[<%=i%>].checked==true && document.forms[0].chk_litigationindiv[<%=i%>].checked==true &&
			      	 			document.forms[0].chk_submission[<%=i%>].checked==true

			      	 			)
			    		{
			      			
			      	 		document.forms[0].cmd_cbs_create[<%=i%>].disabled=false;
			    		
			    		} 
			      	 	
					
					} 

			       if(varappstatus=="pa")
					{
			    	  	document.forms[0].chk_collateral[<%=i%>].disabled=true;
						document.forms[0].chk_pan[<%=i%>].disabled=true;
			 			document.forms[0].chk_business[<%=i%>].disabled=true;
			 			document.forms[0].chk_residentvisit[<%=i%>].disabled=true;
			 			document.forms[0].chk_bankstat[<%=i%>].disabled=true;
			 			document.forms[0].chk_uan[<%=i%>].disabled=true;
			 			document.forms[0].chk_gstin[<%=i%>].disabled=true;
						document.forms[0].chk_itr[<%=i%>].disabled=true;
						document.forms[0].chk_balancesheet[<%=i%>].disabled=true;
						document.forms[0].chk_tra_pro_loss[<%=i%>].disabled=true;
						document.forms[0].chk_financialstat[<%=i%>].disabled=true;
						document.forms[0].chk_litigationcorp[<%=i%>].disabled=true;
			    	   	document.forms[0].chk_litigationindiv[<%=i%>].disabled=true;
		        		document.forms[0].chk_submission[<%=i%>].disabled=true;
		        		document.forms[0].chk_collateral[<%=i%>].disabled=true;	
						document.forms[0].chk_collateralNA[<%=i%>].disabled=true;
		        		document.forms[0].chk_residentvisit[<%=i%>].disabled=true;
						document.forms[0].chk_residentvisitNA[<%=i%>].disabled=true;
		        		document.forms[0].chk_pan[<%=i%>].disabled=true;
						document.forms[0].chk_panNA[<%=i%>].disabled=true;
		        		document.forms[0].chk_uan[<%=i%>].disabled=true;
						document.forms[0].chk_uanNA[<%=i%>].disabled=true;
						document.forms[0].chk_bankstat[<%=i%>].disabled=true;
						document.forms[0].chk_bankstatNA[<%=i%>].disabled=true;	
						document.forms[0].chk_balancesheet[<%=i%>].disabled=true;
						document.forms[0].chk_balancesheetNA[<%=i%>].disabled=true;	
						document.forms[0].chk_tra_pro_loss[<%=i%>].disabled=true;
						document.forms[0].chk_tra_pro_lossNA[<%=i%>].disabled=true;
						document.forms[0].chk_itr[<%=i%>].disabled=true;
						document.forms[0].chk_itrNA[<%=i%>].disabled=true;
						document.forms[0].chk_litigationcorp[<%=i%>].disabled=true;
						document.forms[0].chk_litigationcorpNA[<%=i%>].disabled=true;
						document.forms[0].chk_litigationindiv[<%=i%>].disabled=true;
						document.forms[0].chk_litigationindivNA[<%=i%>].disabled=true;
			    	  	document.forms[0].chk_submission[<%=i%>].disabled=true;	
						document.forms[0].chk_submissionNA[<%=i%>].disabled=true;
						document.forms[0].chk_financialstat[<%=i%>].disabled=true;	
						document.forms[0].chk_financialstatNA[<%=i%>].disabled=true;
						document.forms[0].chk_business[<%=i%>].disabled=true;
						document.forms[0].chk_businessNA[<%=i%>].disabled=true;	
						document.forms[0].chk_gstin[<%=i%>].disabled=true;
						document.forms[0].chk_gstinNA[<%=i%>].disabled=true;
						document.forms[0].chk_businessNA[<%=i%>].disabled=true;	
						document.forms[0].chk_business[<%=i%>].disabled=true;
		   				document.forms[0].chk_residentvisitNA[<%=i%>].disabled=true;
						document.forms[0].chk_residentvisit[<%=i%>].disabled=true;
		   				document.forms[0].chk_panNA[<%=i%>].disabled=true;
						document.forms[0].chk_pan[<%=i%>].disabled=true;
		   				document.forms[0].chk_uanNA[<%=i%>].disabled=true;
						document.forms[0].chk_uan[<%=i%>].disabled=true;
		   				document.forms[0].chk_collateralNA[<%=i%>].disabled=true;
						document.forms[0].chk_collateral[<%=i%>].disabled=true;
		   				document.forms[0].chk_bankstatNA[<%=i%>].disabled=true;	
						document.forms[0].chk_bankstat[<%=i%>].disabled=true;
						document.forms[0].chk_balancesheetNA[<%=i%>].disabled=true;	
						document.forms[0].chk_balancesheet[<%=i%>].disabled=true;
						document.forms[0].chk_tra_pro_lossNA[<%=i%>].disabled=true;
						document.forms[0].chk_tra_pro_loss[<%=i%>].disabled=true;
						document.forms[0].chk_litigationcorpNA[<%=i%>].disabled=true;	
						document.forms[0].chk_litigationcorp[<%=i%>].disabled=true;
						document.forms[0].chk_litigationindivNA[<%=i%>].disabled=true;	
						document.forms[0].chk_litigationindiv[<%=i%>].disabled=true;
						document.forms[0].chk_submissionNA[<%=i%>].disabled=true;
						document.forms[0].chk_submission[<%=i%>].disabled=true;	
						document.forms[0].chk_financialstatNA[<%=i%>].disabled=true;
						document.forms[0].chk_financialstat[<%=i%>].disabled=true;
						document.forms[0].chk_gstinNA[<%=i%>].disabled=true;
						document.forms[0].chk_gstin[<%=i%>].disabled=true;
						document.forms[0].chk_itrNA[<%=i%>].disabled=true;
						document.forms[0].chk_itr[<%=i%>].disabled=true;
					}
			       		    
			       		
			       <%}}%>

			   
			      

			       <% if(strAPPAMBEREXISTS.equals("Y")){  %>

			       document.forms[0].perm_obtaind.value =strVERIPERMOBT;  
			 /*  	if(!document.forms[0].perm_obtaind.value=="S" || !document.forms[0].perm_obtaind.value=="")
			   	{
			   		document.forms[0].perm_obtaind.disabled=true;
			   	}
			   	if(!document.forms[0].dev_refnum.value=="")
			   	{
			   		document.forms[0].dev_refnum.disabled=true;
			   	}
			   	*/
			   <% } %>
			       
				
		}
		
function callcheck(row)
{
	if(document.forms[0].chk_business[row].checked==true &&  document.forms[0].chk_pan[row].checked==true &&
		 document.forms[0].chk_residentvisit[row].checked==true && document.forms[0].chk_bankstat[row].checked==true && 
		document.forms[0].chk_itr[row].checked==true && document.forms[0].chk_collateral[row].checked==true && document.forms[0].chk_gstin[row].checked==true &&
		document.forms[0].chk_uan[row].checked==true && document.forms[0].chk_balancesheet[row].checked==true &&  document.forms[0].chk_balancesheet[row].checked==true
		&&  document.forms[0].chk_tra_pro_loss[row].checked==true &&  document.forms[0].chk_financialstat[row].checked==true && 
		 document.forms[0].chk_litigationcorp[row].checked==true &&  document.forms[0].chk_litigationindiv[row].checked==true && document.forms[0].chk_submission[row].checked==true)
	{
		 
		//&& document.forms[0].chk_proofaddress[row].checked==true
		//document.forms[0].cmd_cbs_create[row].disabled=false;
		
	
	}
	else
	{
		document.forms[0].cmd_cbs_create[row].disabled=true;
	}
	
}	

function goSubmit()
{
	
	document.forms[0].hidBeanId.value="MsmeDigitalAppInterface";
	document.forms[0].hidBeanGetMethod.value="msmeUpdateSanctionDetails";
	document.forms[0].action=appURL+"action/appl_digitalisation_decision_msme.jsp";
	document.forms[0].submit();
	
}

function goCBSupdate(appid)
{

	document.forms[0].hidborrowerid.value=appid;
	document.forms[0].hidBeanId.value="DigitalAppInterface";
	document.forms[0].hidBeanGetMethod.value="cbsIdModificationService";
	document.forms[0].action=appURL+"action/appl_digitalisation_decision_msme.jsp";
	document.forms[0].submit();
	document.getElementById("form_blur").style.visibility="visible";
	document.getElementById("progress").style.visibility="visible";
}


function goCBScreate(appid)
{
	document.forms[0].hidborrowerid.value=appid;
	document.forms[0].hidBeanId.value="MsmeDigitalAppInterface";
	document.forms[0].hidBeanGetMethod.value="cbsIDCreationServiceNonInd";
	document.forms[0].action=appURL+"action/appl_digitalisation_decision_msme.jsp";
	document.forms[0].submit();
	document.getElementById("form_blur").style.visibility="visible";
	document.getElementById("progress").style.visibility="visible";
}


//         
function callcheckdate(val,row)
{
	if(val=="BPV")
	{
		if(document.forms[0].chk_business[row].checked==true)
		{
			document.forms[0].hid_businessplacedate[row].value=sysdate;
			document.forms[0].hid_businessplaceuser[row].value=strDocUserId;
		}
		else if(document.forms[0].chk_business[row].checked==false)
		{
			document.forms[0].hid_businessplacedate[row].value="";
			document.forms[0].hid_businessplaceuser[row].value="";
		}
	}
	
	if(val=="RV")
	{
		if(document.forms[0].chk_residentvisit[row].checked==true)
		{
			document.forms[0].hid_residencedate[row].value=sysdate;
			document.forms[0].hid_residenceuser[row].value=strDocUserId;
		}
		else if(document.forms[0].chk_residentvisit[row].checked==false)
		{
			document.forms[0].hid_residencedate[row].value="";
			document.forms[0].hid_residenceuser[row].value="";
		}
	} 
	if(val=="PAN")
	{
		if(document.forms[0].chk_pan[row].checked==true)
		{
			document.forms[0].hid_PANdate[row].value=sysdate;
			document.forms[0].hid_PANuser[row].value=strDocUserId;
		}
		else if(document.forms[0].chk_pan[row].checked==false)
		{
			document.forms[0].hid_PANdate[row].value="";
			document.forms[0].hid_PANuser[row].value="";
		}
			
	}
if(val=="GSTIN")
		
	{
	
	if(document.forms[0].chk_gstin[row].checked==true)
	{
		document.forms[0].hid_gstndate[row].value=sysdate;
		document.forms[0].gid_gstnuser[row].value=strDocUserId;
	}
	else if(document.forms[0].chk_gstin[row].checked==false)
	{
		document.forms[0].hid_gstndate[row].value="";
		document.forms[0].gid_gstnuser[row].value="";
	}
	
	}
if(val=="BNK")
{
	if(document.forms[0].chk_bankstat[row].checked==true)
	{
		document.forms[0].hid_bankdate[row].value=sysdate;
		document.forms[0].hid_bankuser[row].value=strDocUserId;
	}
	else if(document.forms[0].chk_bankstat[row].checked==false)
	{
		document.forms[0].hid_bankdate[row].value="";
		document.forms[0].hid_bankuser[row].value="";
	}
}
if(val=="ITR")
	
{

if(document.forms[0].chk_itr[row].checked==true)
{
	document.forms[0].hid_ITRdate[row].value=sysdate;
	document.forms[0].hid_ITRuser[row].value=strDocUserId;
}
else if(document.forms[0].chk_itr[row].checked==false)
{
	document.forms[0].hid_ITRdate[row].value="";
	document.forms[0].hid_ITRuser[row].value="";
}

}


	 /* if(val=="ADD")
	{
		if(document.forms[0].chk_fiaddress[row].checked==true)
		{
			document.forms[0].hid_fiaddressdate[row].value=sysdate;
			document.forms[0].hid_fiaddressuser[row].value=strDocUserId;
		}
		else if(document.forms[0].chk_fiaddress[row].checked==false)
		{
			document.forms[0].hid_fiaddressdate[row].value="";
			document.forms[0].hid_fiaddressuser[row].value="";
		}
		 
	} */
	
	if(val=="UAN")
	{
		if(document.forms[0].chk_uan[row].checked==true)
		{
			document.forms[0].hid_UANdate[row].value=sysdate;
			document.forms[0].hid_UANuser[row].value=strDocUserId;
		}
		else if(document.forms[0].chk_uan[row].checked==false)
		{
			document.forms[0].hid_UANdate[row].value="";
			document.forms[0].hid_UANuser[row].value="";
		}
	}
	
	/* 
	if(val=="BE")
		
		{
		
		if(document.forms[0].chk_busexst[row].checked==true)
		{
			document.forms[0].hid_BEdate[row].value=sysdate;
			document.forms[0].hid_BEuser[row].value=strDocUserId;
		}
		else if(document.forms[0].chk_busexst[row].checked==false)
		{
			document.forms[0].hid_BEdate[row].value="";
			document.forms[0].hid_BEuser[row].value="";
		}
		
		} */
	
	
	
	

if(val=="BS")
	
{

if(document.forms[0].chk_balancesheet[row].checked==true)
{
	document.forms[0].hid_balancedate[row].value=sysdate;
	document.forms[0].hid_balanceuser[row].value=strDocUserId;
}
else if(document.forms[0].chk_balancesheet[row].checked==false)
{
	document.forms[0].hid_balancedate[row].value="";
	document.forms[0].hid_balanceuser[row].value="";
}

}

if(val=="TPL")
	
{

if(document.forms[0].chk_tra_pro_loss[row].checked==true)
{
	document.forms[0].hid_tradingdate[row].value=sysdate;
	document.forms[0].hid_tradinguser[row].value=strDocUserId;
}
else if(document.forms[0].chk_tra_pro_loss[row].checked==false)
{
	document.forms[0].hid_tradingdate[row].value="";
	document.forms[0].hid_tradinguser[row].value="";
}

}

if(val=="SFFS")
	
{

if(document.forms[0].chk_financialstat[row].checked==true)
{
	document.forms[0].hid_statementdate[row].value=sysdate;
	document.forms[0].hid_statementuser[row].value=strDocUserId;
}
else if(document.forms[0].chk_financialstat[row].checked==false)
{
	document.forms[0].hid_statementdate[row].value="";
	document.forms[0].hid_statementuser[row].value="";
}

}
if(val=="CLC")
	
{

if(document.forms[0].chk_litigationcorp[row].checked==true)
{
	document.forms[0].hid_litigationcorpdate[row].value=sysdate;
	document.forms[0].hid_litigationcorpuser[row].value=strDocUserId;
}
else if(document.forms[0].chk_litigationcorp[row].checked==false)
{
	document.forms[0].hid_litigationcorpdate[row].value="";
	document.forms[0].hid_litigationcorpuser[row].value="";
}

}

if(val=="CLI")
	
{

if(document.forms[0].chk_litigationindiv[row].checked==true)
{
	document.forms[0].hid_litigationdate[row].value=sysdate;
	document.forms[0].hid_litigationuser[row].value=strDocUserId;
}
else if(document.forms[0].chk_litigationindiv[row].checked==false)
{
	document.forms[0].hid_litigationdate[row].value="";
	document.forms[0].hid_litigationuser[row].value="";
}

}

if(val=="DOC")
	
{

if(document.forms[0].chk_submission[row].checked==true)
{
	document.forms[0].hid_submissiondate[row].value=sysdate;
	document.forms[0].hid_submissionuser[row].value=strDocUserId;
}
else if(document.forms[0].chk_submission[row].checked==false)
{
	document.forms[0].hid_submissiondate[row].value="";
	document.forms[0].hid_submissionuser[row].value="";
}

}

if(val=="CV")
	
{

if(document.forms[0].chk_collateral[row].checked==true)
{
	document.forms[0].hid_collateraldate[row].value=sysdate;
	document.forms[0].hid_collateraluser[row].value=strDocUserId;
}
else if(document.forms[0].chk_collateral[row].checked==false)
{
	document.forms[0].hid_collateraldate[row].value="";
	document.forms[0].hid_collateraluser[row].value="";
}

}


}
//		var varQryString = appURL+"action/CorpCgtmseCoverage.jsp?hidBeanId=supuser&hidBeanGetMethod=getCropCgtmse&appno="+ appno+"&btnenable="+btnenable+"&sel_facilitysno=1";


function showCustIdSearch(count,appcnt)
{	

	var varQryString = appURL + "action/com_customerid.jsp?varCount="+count+"&appCount="+appcnt;
	var title = "ADD";
	var prop = "scrollbars=yes,width=650,height=400,menubar=yes";
	var xpos = (screen.width - 350) / 2;
	var ypos = (screen.height - 120) / 2;
	prop = prop + ",left=50,top=50";
	window.open(varQryString, title, prop);

}

function selcbsid(appId,cbsId)

{	
	document.forms[0].hidKYCChk.value=appId+"@"+cbsId;			
	document.forms[0].hidAction.value="updateCBS";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidBeanMethod.value="msmeUpdateSanctionDetails";
	document.forms[0].hidBeanGetMethod.value="msmeGetDigiDecisionDetail";
	document.forms[0].hidBeanId.value="MsmeDigitalAppInterface";			
	document.forms[0].hidSourceUrl.value="/action/appl_digitalisation_decision_msme.jsp";
	document.forms[0].submit();
	document.getElementById("form_blur").style.visibility="visible";
	document.getElementById("progress").style.visibility="visible";

					
}

function NACheckboxCheck()
{
	//alert("calling NACheckboxCheck");
	var arrSize="<%=arrRow.size()%>";
	
   		<%if(arrRow.size()>0 && arrRow!=null) 
   		{
   			for(int i=0;i<arrRow.size();i++)
   			{
   				arrCol=(ArrayList)arrRow.get(i);
   	    %>
   	    if((document.forms[0].chk_business[<%=i%>].checked==true && document.forms[0].chk_businessNA[<%=i%>].checked==true) ||
   	    	(document.forms[0].chk_residentvisit[<%=i%>].checked==true && document.forms[0].chk_residentvisitNA[<%=i%>].checked==true) ||
   	    		(document.forms[0].chk_pan[<%=i%>].checked==true && document.forms[0].chk_panNA[<%=i%>].checked==true) ||
   	    			(document.forms[0].chk_uan[<%=i%>].checked==true && document.forms[0].chk_uanNA[<%=i%>].checked==true) ||
   	    				(document.forms[0].chk_collateral[<%=i%>].checked==true && document.forms[0].chk_collateralNA[<%=i%>].checked==true) ||
   	    					(document.forms[0].chk_gstin[<%=i%>].checked==true && document.forms[0].chk_gstinNA[<%=i%>].checked==true) ||
   	    						(document.forms[0].chk_bankstat[<%=i%>].checked==true && document.forms[0].chk_bankstatNA[<%=i%>].checked==true) ||
   	    							(document.forms[0].chk_itr[<%=i%>].checked==true && document.forms[0].chk_itrNA[<%=i%>].checked==true) ||
   	    								(document.forms[0].chk_balancesheet[<%=i%>].checked==true && document.forms[0].chk_balancesheetNA[<%=i%>].checked==true) ||
   	    									(document.forms[0].chk_tra_pro_loss[<%=i%>].checked==true && document.forms[0].chk_tra_pro_lossNA[<%=i%>].checked==true) ||
   	    										(document.forms[0].chk_financialstat[<%=i%>].checked==true && document.forms[0].chk_financialstatNA[<%=i%>].checked==true) ||
   	    											(document.forms[0].chk_litigationcorp[<%=i%>].checked==true && document.forms[0].chk_litigationcorpNA[<%=i%>].checked==true) ||
   	    												(document.forms[0].chk_litigationindiv[<%=i%>].checked==true && document.forms[0].chk_litigationindivNA[<%=i%>].checked==true) ||
   	    													(document.forms[0].chk_submission[<%=i%>].checked==true && document.forms[0].chk_submissionNA[<%=i%>].checked==true))
   	    {
   	    	alert("Please select anyone checkbox");	
			if(document.forms[0].chk_business[<%=i%>].checked==true && document.forms[0].chk_businessNA[<%=i%>].checked==true)
			{
				document.forms[0].chk_businessNA[<%=i%>].checked = false ;
				document.forms[0].chk_business[<%=i%>].checked = false ;
			}
			if(document.forms[0].chk_residentvisit[<%=i%>].checked==true && document.forms[0].chk_residentvisitNA[<%=i%>].checked==true)
			{
				document.forms[0].chk_residentvisitNA[<%=i%>].checked = false ;
				document.forms[0].chk_residentvisit[<%=i%>].checked = false ;
			}
			if(document.forms[0].chk_pan[<%=i%>].checked==true && document.forms[0].chk_panNA[<%=i%>].checked==true)
			{
				document.forms[0].chk_panNA[<%=i%>].checked = false ;
				document.forms[0].chk_pan[<%=i%>].checked = false ;
			}
			if(document.forms[0].chk_uan[<%=i%>].checked==true && document.forms[0].chk_uanNA[<%=i%>].checked==true)
			{
				document.forms[0].chk_uanNA[<%=i%>].checked = false ;
				document.forms[0].chk_uan[<%=i%>].checked = false ;
			}
			if(document.forms[0].chk_collateral[<%=i%>].checked==true && document.forms[0].chk_collateralNA[<%=i%>].checked==true)
			{
				document.forms[0].chk_collateralNA[<%=i%>].checked = false ;
				document.forms[0].chk_collateral[<%=i%>].checked = false ;
			}
			if(document.forms[0].chk_gstin[<%=i%>].checked==true && document.forms[0].chk_gstinNA[<%=i%>].checked==true)
			{
				document.forms[0].chk_gstinNA[<%=i%>].checked = false ;
				document.forms[0].chk_gstin[<%=i%>].checked = false ;
			}
			if(document.forms[0].chk_bankstat[<%=i%>].checked==true && document.forms[0].chk_bankstatNA[<%=i%>].checked==true)
			{
				document.forms[0].chk_bankstatNA[<%=i%>].checked = false ;
				document.forms[0].chk_bankstat[<%=i%>].checked = false ;
			}
			if(document.forms[0].chk_itr[<%=i%>].checked==true && document.forms[0].chk_itrNA[<%=i%>].checked==true)
			{
				document.forms[0].chk_itrNA[<%=i%>].checked = false ;
				document.forms[0].chk_itr[<%=i%>].checked = false ;
			}
			if(document.forms[0].chk_balancesheet[<%=i%>].checked==true && document.forms[0].chk_balancesheetNA[<%=i%>].checked==true)
			{
				document.forms[0].chk_balancesheetNA[<%=i%>].checked = false ;
				document.forms[0].chk_balancesheet[<%=i%>].checked = false ;
			}
			if(document.forms[0].chk_tra_pro_loss[<%=i%>].checked==true && document.forms[0].chk_tra_pro_lossNA[<%=i%>].checked==true)
			{
				document.forms[0].chk_tra_pro_lossNA[<%=i%>].checked = false ;
				document.forms[0].chk_tra_pro_loss[<%=i%>].checked = false ;
			}
			if(document.forms[0].chk_financialstat[<%=i%>].checked==true && document.forms[0].chk_financialstatNA[<%=i%>].checked==true)
			{
				document.forms[0].chk_financialstatNA[<%=i%>].checked = false ;
				document.forms[0].chk_financialstat[<%=i%>].checked = false ;
			}
			if(document.forms[0].chk_litigationcorp[<%=i%>].checked==true && document.forms[0].chk_litigationcorpNA[<%=i%>].checked==true)
			{
				document.forms[0].chk_litigationcorpNA[<%=i%>].checked = false ;
				document.forms[0].chk_litigationcorp[<%=i%>].checked = false ;
			}
			if(document.forms[0].chk_litigationindiv[<%=i%>].checked==true && document.forms[0].chk_litigationindivNA[<%=i%>].checked==true)
			{
				document.forms[0].chk_litigationindivNA[<%=i%>].checked = false ;
				document.forms[0].chk_litigationindiv[<%=i%>].checked = false ;
			}
			if(document.forms[0].chk_submission[<%=i%>].checked==true && document.forms[0].chk_submissionNA[<%=i%>].checked==true)
			{
				document.forms[0].chk_submissionNA[<%=i%>].checked = false ;
				document.forms[0].chk_submission[<%=i%>].checked = false ;
			}
   	    }	
	<% }} %>  
}
</script>
</head>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<body onload="onload()">
<div id="progress" style="position:absolute; width:106px; visibility:hidden; height:19px; z-index:9999999; left: 550px; top: 250px" >
<img src="<%=ApplicationParams.getAppUrl()%>img/processing2.gif"></div>
<div class="overlay" id="form_blur" style="position:absolute; visibility:hidden;"></div>
<form name="appform" method="post" action="" class="normal">

      <table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="1" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
			<jsp:param name="applevel" value="<%=applevel%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
  	<tr>
				<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt;
				 Application -&gt; Applicant -&gt; Verification</td>
			</tr>
  </table>
  <lapschoice:application />
  <lapstab:ComfacilityTab tabid="8"/>
 <br>
	
  <table width="100%" border="0" cellspacing="1" cellpadding="3"  align="center" class="outertable">
   			<tr>
    			<td>
             	 	<table width="80%" border="0" cellspacing="0" align="center" cellpadding="3" class="outertable">
                	<tr align="center"> 
                		
                		<%if(appstatus.equalsIgnoreCase("Open/Pending") || appstatus.equalsIgnoreCase("op")){%>
                		<td><span style="font-size: 18px;"> Status of Application- <B><span style="color: #7a4d98"> In-Principle Sanction</span> </B>  </span></td>
                	
                	  	<% } else {%>
                		<td><span style="font-size: 18px;"> Status of Application- <B><span style="color: #7a4d98"> <%=appstatus%> </span> </B>  </span></td>
                	<%}%>
					</tr>
                	</table>
               </td>
    		</tr>
    	<tr> 
    	<tr>
    			<td> 
             	 	<table width="95%" border="0" cellspacing="1" align="center" cellpadding="3" class="outertable">
                	<tr align="center" class="dataHeader"> 
                		<td width="15%">Borrower Details </td>
                		<td width="7%">CBSID </td>
                		<td width="6%">CIBIL Score </td>
                		<td width="13%">KYC CheckList</td> 
                		<td width="10%">Field Investigation CheckList</td> 
                		<td width="20%">Financial</td>
                		<td width="15%">Others</td>
                		<td width="25%"> Action&nbsp; </td>
                	</tr>
                	<% 
                	//String StrPADate="",StrPAUser="";
                	String StrPANDate="",StrPANUser="";
                	String StrGSTDate="",StrGSTUser="";
                	String StrBPVDate="",  StrBPVUser="";
                	String StrRVDate ="", StrRVUser="";
                	String StrCVDate="",  StrCVUser="";
                	
                	String  StrUANDate="",   StrUANUser =""; 
                	String StrBSDate="",     StrBSUser="";
                	String  StrTPLDate="",   StrTPLUser="";
                	String  StrSFFSDate="",  StrSFFSUser="";  
                	String StrCLPDate="",  StrCLPUser="";  				
                	String  StrDOCDate="",   StrDOCUser=""; 				
                	String  StrCLIDate="",      StrCLIUser="";
                	
                	//String StrADDDate="",StrADDUser="";
                	//String StrEMPDate="",StrEMPUser="";
                	String StrBNKDate="",StrBNKUser="";
                	//String StrPCADate="",StrPCAUser="";
                	//String StrPPADate="",StrPPAUser="";
                	//String StrBEDate="",StrBEUser="";
                	String StrITRDate="",StrITRUser="";
                	//String StrPRADate="",StrPRAUser="";
                	//String StrOAPDate="",StrOAPUser="";
                	//String StrBProfDate="",StrBProfUser="";
                	
                	
                	if(arrRow.size()>0 && arrRow!=null) 
                	{
                		for(int i=0;i<arrRow.size();i++)
                		{
                			arrCol=(ArrayList)arrRow.get(i);
                			
                			String strcbsid=Helper.correctNull((String)arrCol.get(1));
                			if(strcbsid.equals(""))
                			{
                				strcbsid="NEW";
                			}
                			String strAppType=Helper.correctNull((String)arrCol.get(3));
                			String strAppName=Helper.correctNull((String)arrCol.get(0));
                			String strCibilscore=Helper.correctNull((String)arrCol.get(2));
                			//String straddressflag=Helper.correctNull((String)arrCol.get(4));
                			String strpanflag=Helper.correctNull((String)arrCol.get(5));
                			//String strfiaddressflag=Helper.correctNull((String)arrCol.get(6));
                			//String strfiempflag=Helper.correctNull((String)arrCol.get(7));
                			String strfibankstatflag=Helper.correctNull((String)arrCol.get(8));
                			String strperappid=Helper.correctNull((String)arrCol.get(9));
                			//String stremploy=Helper.correctNull((String)arrCol.get(10));
                			 String strcbscustflag=Helper.correctNull((String)arrCol.get(23));
							String strborrowerincome=Helper.correctNull((String)arrCol.get(11));
							String strDocDate=Helper.correctNull((String)arrCol.get(15));
                			String strDocUser=Helper.correctNull((String)arrCol.get(16));
                			String strKycPendFlag=Helper.correctNull((String)arrCol.get(24));
                			//String strpermaddressflag=Helper.correctNull((String)arrCol.get(21));
                			//String strpraadrs=Helper.correctNull((String)arrCol.get(16));
							String strFiPendFlag=Helper.correctNull((String)arrCol.get(25));	
							String strfinancilapend=Helper.correctNull((String)arrCol.get(44));
							String strotherpendflag=Helper.correctNull((String)arrCol.get(45));
							String strCollateral=Helper.correctNull((String)arrCol.get(33));
					         String strBusinessVisit=Helper.correctNull((String)arrCol.get(35));
					         String strresidencVisit=Helper.correctNull((String)arrCol.get(34));
							String strUAN=Helper.correctNull((String)arrCol.get(37));
							String strGST=Helper.correctNull((String)arrCol.get(36));
							String strBalanceSheet=Helper.correctNull((String)arrCol.get(38));
							String strTrading=Helper.correctNull((String)arrCol.get(39));
							String strFinancial=Helper.correctNull((String)arrCol.get(40));
							String strLitigationCorp=Helper.correctNull((String)arrCol.get(41));
							String strLitigatonInd=Helper.correctNull((String)arrCol.get(42));
							String strDocSub=Helper.correctNull((String)arrCol.get(43));
							String strFinancialPend=Helper.correctNull((String)arrCol.get(44));
							String strOthersPend=Helper.correctNull((String)arrCol.get(45));
							
							if(!strDocDate.equalsIgnoreCase(""))
                			{
								
								String[] strDocSplitDate=strDocDate.split("@");
								//StrPADate=strDocSplitDate[0];
								StrPANDate=strDocSplitDate[2];
								//StrADDDate=strDocSplitDate[1];
								//StrEMPDate=strDocSplitDate[6];
								StrBNKDate=strDocSplitDate[4];
								//StrPCADate=strDocSplitDate[0];
								//StrPPADate=strDocSplitDate[1];
								//StrBEDate=strDocSplitDate[6];
								StrITRDate=strDocSplitDate[5];
								//StrPRADate=strDocSplitDate[3];
								//StrOAPDate=strDocSplitDate[7];
								//StrBProfDate=strDocSplitDate[8];

								StrBPVDate=strDocSplitDate[0];
								StrRVDate=strDocSplitDate[1];
								StrCVDate=strDocSplitDate[3];
								StrGSTDate=strDocSplitDate[6];
								StrUANDate=strDocSplitDate[7];							
								StrBSDate=strDocSplitDate[8];
								StrTPLDate=strDocSplitDate[9];							
								StrSFFSDate=strDocSplitDate[10];
								StrCLPDate=strDocSplitDate[11];
								StrCLIDate=strDocSplitDate[12];
								StrDOCDate=strDocSplitDate[13];
								
  
             			
                			
                			}
								
							if(!strDocUser.equalsIgnoreCase(""))
                			{
                				String[] strDocSplitUser=strDocUser.split("@");
                				//StrPAUser =strDocSplitUser[0];
                				StrPANUser=strDocSplitUser[2];
                				//StrADDUser =strDocSplitUser[1];
                				//StrEMPUser=strDocSplitUser[6];
                				StrBNKUser=strDocSplitUser[4];
                				//StrPCAUser=strDocSplitUser[0];
                				//StrPPAUser=strDocSplitUser[1];
                				//StrBEUser=strDocSplitUser[6];
                				StrITRUser=strDocSplitUser[5];
                				//StrPRAUser=strDocSplitUser[3];
                			//	StrOAPUser=strDocSplitUser[7];
                				//StrBProfUser=strDocSplitUser[8];
								 StrBPVUser =strDocSplitUser[0];
								 StrRVUser=strDocSplitUser[1];
								 StrCVUser=strDocSplitUser[3];
								 StrGSTUser=strDocSplitUser[6];
								 StrUANUser=strDocSplitUser[7];
								 StrBSUser=strDocSplitUser[8];
								 StrTPLUser=strDocSplitUser[9];
								 StrSFFSUser=strDocSplitUser[10];
								 StrCLPUser=strDocSplitUser[11];
								 StrCLIUser= strDocSplitUser[12];
								 StrDOCUser=strDocSplitUser[13];
								

							
                			}
							
							  /*  if(strcbscustflag=="Y")
							   		
						       {
						    		 alert("if");
						       
						    	document.forms[0].cmd_submit.disabled=false;	
						       	document.forms[0].cmd_cbs_create[0].disabled=true;

						       }
						       else
						       {
						    	   
						    	 alert("else")
						       	document.forms[0].cmd_submit.disabled=true;
						       }  */
						    	
							
							String strfinnonfin="";
							if(strborrowerincome.equals("1"))
							{
								strfinnonfin="Non-Financial";
							}
							else
							{
								strfinnonfin="Financial";
							}
							
                			String strappdesc="";
            	        	if(strAppType.equals("a"))
            	        		strappdesc="Applicant - "+strAppName;
            	        	else 
            	        		strappdesc=strfinnonfin+" CoApplicant - "+strAppName;
            	        	
            	        	
                	
                	%>
                	<tr align="center" class="datagrid"> 
                		<td style="padding-right: 5px;"><%=strappdesc %> </td>
                		
                	 <%if(strcbsid.equalsIgnoreCase("NEW")) {%>
                		<td> <span style="color: green;"> <%=strcbsid %> </span> </td>
                 	<%} else { %>	
                 	    <td> <span > <%=strcbsid %> </span> </td>
                 	<%} %>
                 	
 	
                 		<td><%=strCibilscore %></td>
                 		<td>
							<table class="outertable">
                 				<tr class="datagrid" > 
                 				<td></td>
                 				<td>YES</td>
                 				<td>NA</td>
                 				</tr>
                 				<tr class="datagrid" > 	
                 					<td>Business Place Visit</td>
                 					<td><input type="checkbox" name="chk_business" style='border=none' onclick="callcheck(<%=i%>);callcheckdate('BPV',<%=i%>);NACheckboxCheck(<%=i%>)"></td>
                 					<input type="hidden" name="hid_businessplacedate" value="<%=StrBPVDate%>">
                 					<input type="hidden" name="hid_businessplaceuser" value="<%=StrBPVUser%>">
                 					<td><input type="checkbox" name="chk_businessNA" style='border=none' onclick="NACheckboxCheck(<%=i%>)"></td>
                  					
                 				</tr>
                 				<tr class="datagrid" > 
                 					<td>Residence Visit </td>
                 					<td><input type="checkbox" name="chk_residentvisit" style='border=none' onclick="callcheck(<%=i%>);callcheckdate('RV',<%=i%>);NACheckboxCheck(<%=i%>)"></td>
                 					<input type="hidden" name="hid_residencedate" value="<%=StrRVDate%>">
                 					<input type="hidden" name="hid_residenceuser" value="<%=StrRVUser%>">
                 					<td><input type="checkbox" name="chk_residentvisitNA" style='border=none' onclick="NACheckboxCheck(<%=i%>)"></td>
           
                 				</tr>
                 				<tr class="datagrid"> 
                 					<td>PAN</td>
                 					<td><input type="checkbox" name="chk_pan" style='border=none' onclick="callcheck(<%=i %>);callcheckdate('PAN',<%=i%>);NACheckboxCheck(<%=i%>)""></td>
                 					<input type="hidden" name="hid_PANdate"value="<%=StrPANDate%>">
                 					<input type="hidden" name="hid_PANuser" value="<%=StrPANUser%>">
                 					<td><input type="checkbox" name="chk_panNA" style='border=none' onclick="NACheckboxCheck(<%=i%>)"></td>
                 				</tr>
                 				
                 				<tr class="datagrid"> 
                 					<td>KYC Document</td><td><input type="checkbox" name="chk_uan" style='border=none' onclick="callcheck(<%=i %>);callcheckdate('UAN',<%=i%>);NACheckboxCheck(<%=i%>)"></td>
                 					<input type="hidden" name="hid_UANdate"value="<%=StrUANDate%>">
                 					<input type="hidden" name="hid_UANuser" value="<%=StrUANUser%>">
                 					<td><input type="checkbox" name="chk_uanNA" style='border=none' onclick="NACheckboxCheck(<%=i%>)"></td>
                 				</tr>
                 				<% if (i<1){ %>
                 				<tr class="datagrid"> 
                 					<td>Collateral verification</td><td><input type="checkbox" name="chk_collateral" style='border=none' onclick="callcheck(<%=i %>);callcheckdate('CV',<%=i%>);NACheckboxCheck(<%=i%>)"></td>
                 					<input type="hidden" name="hid_collateraldate"value="<%=StrCVDate%>">
                 					<input type="hidden" name="hid_collateraluser" value="<%=StrCVUser%>">
         							<td><input type="checkbox" name="chk_collateralNA" style='border=none' onclick="NACheckboxCheck(<%=i%>)"></td>
                 				</tr>
    				
                 				<tr class="datagrid"> 
                 					<td>GSTIN</td><td><input type="checkbox" name="chk_gstin" style='border=none' onclick="callcheck(<%=i %>);callcheckdate('GSTIN',<%=i%>);NACheckboxCheck(<%=i%>)"></td>
                 					<input type="hidden" name="hid_gstndate"value="<%=StrGSTDate%>">
                 					<input type="hidden" name="gid_gstnuser" value="<%=StrGSTUser%>">
                 					<td><input type="checkbox" name="chk_gstinNA" style='border=none' onclick="NACheckboxCheck(<%=i%>)"></td>
                 				</tr>
                 				<% }else{%>
                 				<tr class="datagrid" style="visibility: hidden;position: relative;" > 
                 					<td>Collateral verification</td><td><input type="checkbox" name="chk_collateral" style='border=none' onclick="callcheck(<%=i %>);callcheckdate('CV',<%=i%>);NACheckboxCheck(<%=i%>)"></td>
                 					<input type="hidden" name="hid_collateraldate"value="<%=StrCVDate%>">
                 					<input type="hidden" name="hid_collateraluser" value="<%=StrCVUser%>">
         							<td><input type="checkbox" name="chk_collateralNA" style='border=none' onclick="NACheckboxCheck(<%=i%>)"></td>
                 				</tr>
    				
                 				<tr class="datagrid" style="visibility: hidden;position: relative;" > 
                 					<td>GSTIN</td><td><input type="checkbox" name="chk_gstin" style='border=none' onclick="callcheck(<%=i %>);callcheckdate('GSTIN',<%=i%>);NACheckboxCheck(<%=i%>)"></td>
                 					<input type="hidden" name="hid_gstndate"value="<%=StrGSTDate%>">
                 					<input type="hidden" name="gid_gstnuser" value="<%=StrGSTUser%>">
                 					<td><input type="checkbox" name="chk_gstinNA" style='border=none' onclick="NACheckboxCheck(<%=i%>)"></td>
                 				</tr>
                 				<% }%>
                 				
                 				
                 			</table>
                 			                 
                 		</td>
                 	
                 		<td>
                 			<table class="outertable">
                 			
                 			<% if (i<1){ %>
                 				<tr class="datagrid" > 
                 				<td></td>
                 				<td>YES</td>
                 				<td>NA</td>
                 				</tr>
                 				<tr class="datagrid"> 
                 					<td>Bank Statement </td><td><input type="checkbox" name="chk_bankstat" style='border=none' onclick="callcheck(<%=i%>);callcheckdate('BNK',<%=i%>);NACheckboxCheck(<%=i%>)"></td>
                 				
                 					<input type="hidden" name="hid_bankdate" value="<%=StrBNKDate%>">
                 					<input type="hidden" name="hid_bankuser" value="<%=StrBNKUser%>"></td>
                 					<td><input type="checkbox" name="chk_bankstatNA" style='border=none' onclick="NACheckboxCheck(<%=i%>)"></td>
                 					
                 				</tr>
                 				
                 				<tr class="datagrid"> 
                 					<td>ITR </td><td><input type="checkbox" name="chk_itr" style='border=none' onclick="callcheck(<%=i%>);callcheckdate('ITR',<%=i%>);NACheckboxCheck(<%=i%>)"></td>
                 					<input type="hidden" name="hid_ITRdate"value="<%=StrITRDate%>">
                 					<input type="hidden" name="hid_ITRuser" value="<%=StrITRUser%>">
                 					<td><input type="checkbox" name="chk_itrNA" style='border=none' onclick="NACheckboxCheck(<%=i%>)"></td>
                 				</tr>
                 			<%}else{ %>
                 				<tr class="datagrid" style="visibility: hidden;position: relative;" > 
                 					<td>Bank Statement </td><td><input type="checkbox" name="chk_bankstat" style='border=none' onclick="callcheck(<%=i%>);callcheckdate('BNK',<%=i%>);NACheckboxCheck(<%=i%>)"></td>
                 				
                 					<input type="hidden" name="hid_bankdate" value="<%=StrBNKDate%>">
                 					<input type="hidden" name="hid_bankuser" value="<%=StrBNKUser%>"></td>
                 					<td><input type="checkbox" name="chk_bankstatNA" style='border=none' onclick="NACheckboxCheck(<%=i%>)"></td>
                 				</tr>
                 				
                 				<tr class="datagrid" style="visibility: hidden;position: relative;"> 
                 					<td>ITR </td><td><input type="checkbox" name="chk_itr" style='border=none' onclick="callcheck(<%=i%>);callcheckdate('ITR',<%=i%>);NACheckboxCheck(<%=i%>)"></td>
                 					<input type="hidden" name="hid_ITRdate"value="<%=StrITRDate%>">
                 					<input type="hidden" name="hid_ITRuser" value="<%=StrITRUser%>">
                 					<td><input type="checkbox" name="chk_itrNA" style='border=none' onclick="NACheckboxCheck(<%=i%>)"></td>
                 				</tr>
                 			<%} %>
                 			 
                 			 	
                 				
                 				
                 			
                 				
                 			</table>
                 		
                 		
                 		
                 		</td>
                 		
                 		<td>
                 		<table class="outertable">
                 			
                 			<% if (i<1){ %>
                 				<tr class="datagrid" > 
                 				<td></td>
                 				<td>YES</td>
                 				<td>NA</td>
                 				</tr>
                 				 <tr class="datagrid"> 
                 					<td>Balance Sheet(Authenticity)</td><td><input type="checkbox" name="chk_balancesheet" style='border=none' onclick="callcheck(<%=i %>);callcheckdate('BS',<%=i%>);NACheckboxCheck(<%=i%>)"></td>
                 					<input type="hidden" name="hid_balancedate"value="<%=StrBSDate%>">
                 					<input type="hidden" name="hid_balanceuser" value="<%=StrBSUser%>">
                 					</td>
                 					<td><input type="checkbox" name="chk_balancesheetNA" style='border=none' onclick="NACheckboxCheck(<%=i%>)"></td>
                 				</tr>
                 			 
                 			 	<tr class="datagrid"> 
                 					<td>Trading, Profit and Loss A/c(Authenticity)</td><td><input type="checkbox" name="chk_tra_pro_loss" style='border=none' onclick="callcheck(<%=i %>);callcheckdate('TPL',<%=i%>);NACheckboxCheck(<%=i%>)"></td>
                 					<input type="hidden" name="hid_tradingdate"value="<%=StrTPLDate%>">
                 					<input type="hidden" name="hid_tradinguser" value="<%=StrTPLUser%>">
                 					</td>
                 					<td><input type="checkbox" name="chk_tra_pro_lossNA" style='border=none' onclick="NACheckboxCheck(<%=i%>)"></td>
                 				</tr>
                 				<tr class="datagrid"> 
                 					<td>Schedules forming Financial Statements(Authenticity)</td><td><input type="checkbox" name="chk_financialstat" style='border=none' onclick="callcheck(<%=i%>);callcheckdate('SFFS',<%=i%>);NACheckboxCheck(<%=i%>)"></td>
                 					
                 					<input type="hidden" name="hid_statementdate" value="<%=StrSFFSDate%>">
                 					<input type="hidden" name="hid_statementuser" value="<%=StrSFFSUser%>"></td>
                 					<td><input type="checkbox" name="chk_financialstatNA" style='border=none' onclick="NACheckboxCheck(<%=i%>)"></td>
                 				</tr>
                 			<%}else{ %>
                 				 <tr class="datagrid" style="visibility: hidden;position: relative;"> 
                 					<td>Balance Sheet(Authenticity)</td><td><input type="checkbox" name="chk_balancesheet" style='border=none' onclick="callcheck(<%=i %>);callcheckdate('BS',<%=i%>);NACheckboxCheck(<%=i%>)"></td>
                 					<input type="hidden" name="hid_balancedate"value="<%=StrBSDate%>">
                 					<input type="hidden" name="hid_balanceuser" value="<%=StrBSUser%>">
                 					</td>
                 					<td><input type="checkbox" name="chk_balancesheetNA" style='border=none' onclick="NACheckboxCheck(<%=i%>)"></td>
                 				</tr>
                 			 
                 			 	<tr class="datagrid" style="visibility: hidden;position: relative;"> 
                 					<td>Trading, Profit and Loss A/c(Authenticity)</td><td><input type="checkbox" name="chk_tra_pro_loss" style='border=none' onclick="callcheck(<%=i %>);callcheckdate('TPL',<%=i%>);NACheckboxCheck(<%=i%>)"></td>
                 					<input type="hidden" name="hid_tradingdate"value="<%=StrTPLDate%>">
                 					<input type="hidden" name="hid_tradinguser" value="<%=StrTPLUser%>">
                 					</td>
                 					<td><input type="checkbox" name="chk_tra_pro_lossNA" style='border=none' onclick="NACheckboxCheck(<%=i%>)"></td>
                 					
                 				</tr>
                 				<tr class="datagrid" style="visibility: hidden;position: relative;"> 
                 					<td>Schedules forming Financial Statements(Authenticity)</td><td><input type="checkbox" name="chk_financialstat" style='border=none' onclick="callcheck(<%=i%>);callcheckdate('SFFS',<%=i%>);NACheckboxCheck(<%=i%>)"></td>
                 					
                 					<input type="hidden" name="hid_statementdate" value="<%=StrSFFSDate%>">
                 					<input type="hidden" name="hid_statementuser" value="<%=StrSFFSUser%>"></td>
                 					<td><input type="checkbox" name="chk_financialstatNA" style='border=none' onclick="NACheckboxCheck(<%=i%>)"></td>
                 				</tr>
                 			<%} %>
                 		
                 			
       
           				</table>               		
                 		</td>
   
                 		<td>
                 		<table class="outertable">
    						
    						<% if (i<1){ %>
    							<tr class="datagrid" > 
                 				<td></td>
                 				<td>YES</td>
                 				<td>NA</td>
                 				</tr>
                 				 <tr class="datagrid"> 
                 					<td>Court Litigation</td><td><input type="checkbox" name="chk_litigationcorp" style='border=none' onclick="callcheck(<%=i %>);callcheckdate('CLC',<%=i%>);NACheckboxCheck(<%=i%>)"></td>
                 					<input type="hidden" name="hid_litigationcorpdate"value="<%=StrCLPDate%>">
                 					<input type="hidden" name="hid_litigationcorpuser" value="<%=StrCLPUser%>">
                 					</td>
                 					<td><input type="checkbox" name="chk_litigationcorpNA" style='border=none' onclick="NACheckboxCheck(<%=i%>)"></td>
                 				</tr>
                 			 
                 			 	<tr class="datagrid" style="visibility: hidden;position: relative;"> 
                 					<td>Court Litigation - Individual</td><td><input type="checkbox" name="chk_litigationindiv" style='border=none' onclick="callcheck(<%=i %>);callcheckdate('CLI',<%=i%>);NACheckboxCheck(<%=i%>)"></td>
                 					<input type="hidden" name="hid_litigationdate"value="<%=StrCLIDate%>">
                 					<input type="hidden" name="hid_litigationuser" value="<%=StrCLIUser%>">
                 					</td>
                 					<td><input type="checkbox" name="chk_litigationindivNA" style='border=none' onclick="NACheckboxCheck(<%=i%>)"></td>
                 				</tr>
                 				<tr class="datagrid" style="visibility: hidden;position: relative;"> 
                 					<td>Any other document submitted by the Applicant</td><td><input type="checkbox" name="chk_submission" style='border=none' onclick="callcheck(<%=i%>);callcheckdate('DOC',<%=i%>);NACheckboxCheck(<%=i%>)"></td>
                 				
                 					<input type="hidden" name="hid_submissiondate" value="<%=StrDOCDate%>">
                 					<input type="hidden" name="hid_submissionuser" value="<%=StrDOCUser%>"></td>
                 					<td><input type="checkbox" name="chk_submissionNA" style='border=none' onclick="NACheckboxCheck(<%=i%>)"></td>
                 				</tr>
                 				
                 			<%}else{ %>
                 				<tr class="datagrid" style="visibility: hidden;position: relative;"> 
                 					<td>Court Litigation - Individual</td><td><input type="checkbox" name="chk_litigationindiv" style='border=none' onclick="callcheck(<%=i %>);callcheckdate('CLI',<%=i%>)"></td>
                 					<input type="hidden" name="hid_litigationdate"value="<%=StrCLIDate%>">
                 					<input type="hidden" name="hid_litigationuser" value="<%=StrCLIUser%>">
                 					</td>
                 					<td><input type="checkbox" name="chk_litigationindivNA" style='border=none' onclick="NACheckboxCheck(<%=i%>)"></td>
                 				</tr>
                 				<tr class="datagrid" style="visibility: hidden;position: relative;"> 
                 					<td>Any other document submitted by the Applicant</td><td><input type="checkbox" name="chk_submission" style='border=none' onclick="callcheck(<%=i%>);callcheckdate('DOC',<%=i%>)"></td>
                 				
                 					<input type="hidden" name="hid_submissiondate" value="<%=StrDOCDate%>">
                 					<input type="hidden" name="hid_submissionuser" value="<%=StrDOCUser%>"></td>
                 					<td><input type="checkbox" name="chk_submissionNA" style='border=none' onclick="NACheckboxCheck(<%=i%>)"></td>
                 				</tr>
                 				 <tr class="datagrid" style="visibility: hidden;position: relative;"> 
                 					<td>Court Litigation - Corporate</td><td><input type="checkbox" name="chk_litigationcorp" style='border=none' onclick="callcheck(<%=i %>);callcheckdate('CLC',<%=i%>)"></td>
                 					<input type="hidden" name="hid_litigationcorpdate"value="<%=StrCLPDate%>">
                 					<input type="hidden" name="hid_litigationcorpuser" value="<%=StrCLPUser%>">
                 					<td><input type="checkbox" name="chk_litigationcorpNA" style='border=none' onclick="NACheckboxCheck(<%=i%>)"></td>
                 					</td>
                 				</tr>
                 			 
                 			 	<tr class="datagrid" style="visibility: hidden;position: relative;"> 
                 					<td>Court Litigation - Individual</td><td><input type="checkbox" name="chk_litigationindiv" style='border=none' onclick="callcheck(<%=i %>);callcheckdate('CLI',<%=i%>)"></td>
                 					<input type="hidden" name="hid_litigationdate"value="<%=StrCLIDate%>">
                 					<input type="hidden" name="hid_litigationuser" value="<%=StrCLIUser%>">
                 					</td>
                 				</tr>
                 				<tr class="datagrid" style="visibility: hidden;position: relative;"> 
                 					<td>Any other document submitted by the Applicant</td><td><input type="checkbox" name="chk_submission" style='border=none' onclick="callcheck(<%=i%>);callcheckdate('DOC',<%=i%>)"></td>
                 				
                 					<input type="hidden" name="hid_submissiondate" value="<%=StrDOCDate%>">
                 					<input type="hidden" name="hid_submissionuser" value="<%=StrDOCUser%>"></td>
                 					<td><input type="checkbox" name="chk_submissionNA" style='border=none' ></td>
                 				</tr>
                 			<%} %>
                 		
                 		
                 			 
                 				               				
                 				</table>
                 		
                 		</td>
                 		
                 		<%if(strcbsid.equalsIgnoreCase("NEW")){%>
	 
           				 <td>
           			<table>
           				<tr class="datagrid"> 
                 	                     	             	
           				<td >CBS ID</td><td><input type="text" name="comapp_cbsid"  maxlength="20" size="15">						
						<span id="idsearch" >
						<a href="#" onClick="showCustIdSearch(<%=i%>,<%=strcnt%>)" style="cursor:hand" tabindex="22">
						<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0" ></a>
						</span>
						</td>
                 			        			
           			</table>
           			<table> 
           			<tr>
                 		
                 		<%if(strcnt.equals("1") || strcnt.equals("01") ){%>
                 		<input type="button" class="buttonPrint" name="sel_cbs_id" value="Update CBS ID" onclick="selcbsid(<%=strperappid%>,document.forms[0].comapp_cbsid.value)"></td>
                 		<%}else{ %>
                 		<input type="button"   class="buttonPrint" name="sel_cbs_id" value="Update CBS ID" onclick="selcbsid(<%=strperappid%>,document.forms[0].comapp_cbsid[<%=i%>].value)"></td>
                 		<%} %>
                 		<td style="visibility:hidden;position:absolute"><input type="hidden" name="hid_appid" value="<%=strperappid %>"><input type="hidden" name="cmd_cbs_create"> </td>
                 		</tr>
           			</table>
           				</td>
						           				
           				
           				<%} else {%>
           			          				     					
           					<td><input type="hidden" name="comapp_cbsid"> </td>
							<td><input type="hidden" name="sel_cbs_id"> </td>
				
					<tr class="datagrid"> 
           			
         					<td style="visibility:hidden;position:absolute"><input type="hidden" name="hid_appid" value="<%=strperappid %>"><input disabled="disabled" type="button" class="buttonPrint" name="cmd_cbs_create" value="Update CBS Customer ID" onclick="goCBSupdate(document.forms[0].hid_appid[<%=i%>].value)"></td>
           					<%  }%>       				
	                	</tr>            	
                	
                	<%  } } %>
                	 
                	</table>
               </td>
    		</tr>
    		<% if(strAPPAMBEREXISTS.equals("Y")){ %>
    		<tr>
    			<td>
    		<table width="95%" border="0" cellspacing="1" align="center" cellpadding="3" class="outertable">
    		<tr align="center" class="dataHeader"> 
    		
                		<td width="15%">Amber Exits  &nbsp; - YES
					</td></tr>
    				<tr align="center" class="datagrid">	
                	 <td>Permission Obtained &nbsp;<span class="mantatory"><b>*</b></span> <select name="perm_obtaind">
					<option value="S">&lt;----Select----&gt;</option>
					<option value="Y">Yes</option>
					<option value="N">No</option>
					</select></td>
					</tr>
					<tr align="center" class="datagrid">
                	 <td>Permission Ref Num &nbsp;<input type="text" name="dev_refnum" size="37" maxlength="50" 
                	 value="<%=Helper.correctNull((String)hshValues.get("strVERIDEVREFNUM"))%>"></td>
                	 
					</tr>
					<tr align="center" class="datagrid">
					<td>Remarks &nbsp;<span class="mantatory"><b>*</b></span>
					<textarea rows="3" cols="50" name="dev_remarks"  onkeydown="textlimitcorp1(this,100);" wrap="VIRTUAL" onkeyup="textlimitcorp1(this,100);" ><%=Helper.correctNull((String) hshValues.get("strVERIDEVREMARK"))%></textarea>
					</td>
					</tr>
    		</table>
    		</td></tr>
    		<%}else{ %>
    				<tr>
    					<td>
                		<table width="95%" border="0" cellspacing="1" align="center" cellpadding="3" class="outertable">
    						<tr align="center" class="dataHeader"> 
                				<td width="15%">Amber Exits  &nbsp; - NO </td>
                			</tr>
                		</table>
                		</td>
                	</tr>
                		<%} %>
    		<tr>
     	<td valign="top" align="center" id="id_applicationdet_loantype"> 
        <table width="70%" border="1" cellspacing="0" cellpadding="3" class="outertable">
    		
    		<tr>
    		    <td class="dataheader"><span style="font-size: 14px;">  Application Details <B>      </B>  </span></td>
			</tr>
    		
    		<tr>
    			<td>
    			<br> 
    			<table width="60%" border="1" cellspacing="0" align="center" cellpadding="3" class="outertable">
                	 
                	<tr align="left"> 
                		<td  bgcolor="#efefef" colspan="2"><b>Application Score</b></td>
                		<td align="center"> <%=Helper.correctNull((String)hshValues.get("ApplicationScore")) %> &nbsp; </td>
               		</tr>
                	
                	<% 
                	String strdeviationflag=Helper.correctNull((String)hshValues.get("digideviationFlag"));
                	if(strdeviationflag.equals("N"))
                	{
                		strdeviationflag="Deviation Approved";
                	}
                	else
                	{
                		strdeviationflag="NA";
                	}
                	strdeviationflag="NA";
                	%>
                	
                	<tr align="left"> 
                		<td  bgcolor="#efefef" colspan="2"> <b>Deviation If any  </b> <a href="#" onclick="callDeviation('normal')">  (Click here for more Details)  </a> </td>
<!--                		<td  bgcolor="#efefef" align="right"> -->
<!-- 		              		<input  type="button" name="cmdClick" value="Click here for more Details" class="buttonStyle"	title="Check Deviations" onClick="callDeviation('normal')">-->
<!--						 </td> -->
                		<td align="center"> <%=strdeviationflag %>   &nbsp; </td> 
                	</tr>
                	<%
                	String strLegalStatus="",strValuationStatus="";
                	String ValuationEntryFlag=Helper.correctNull((String)hshValues.get("ValuationEntryFlag"));
                	if(ValuationEntryFlag.equals("N"))
                	{
                		strLegalStatus=strValuationStatus="In Process";
                	}
                	else
                	{
                		strLegalStatus=strValuationStatus="Completed";
                	}
                	%>
                	<tr align="left" > 
                		<td  bgcolor="#efefef" colspan="2"><b>Legal Status</b></td>
                		<td  align="center">  <%=strLegalStatus %>
<!--	                		<select name="sel_extappl_deviation"> -->
<!--	                			<option value="Y">To be Verified  &nbsp; </option>-->
<!--	                			<option value="N">In Process  &nbsp; </option>-->
<!--	                			<option value="N">Completed  &nbsp; </option>-->
<!--	                			<option value="N">Rejected  &nbsp; </option>-->
<!--	                		</select>-->
                		</td> 
                	</tr>
                	<tr align="left"> 
                		<td  bgcolor="#efefef" colspan="2"><b> Valuation Status </b></td> 
                		<td align="center" > <%=strValuationStatus %>
<!--	                		<select name="sel_extappl_deviation" onchange="changeValuation()"> -->
<!--	                			<option value="N">In process &nbsp;  </option>-->
<!--	                			<option value="N">Completed  &nbsp; </option>-->
<!--	                			<option value="N">Rejected  &nbsp; </option>-->
<!--	                     </select>-->
                		</td> 
                	</tr>
                	<tr align="left"> 
                		<td  bgcolor="#efefef" colspan="2" ><b>Valuation Amount</b></td>
                		<td align="right">Rs.<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("valuationAmount")) ))%> </td>
                	</tr>
                	<tr align="left"> 
                		<td  bgcolor="#efefef"  colspan="2"><b>Total Processing Fee </b></td>
                		<td align="right">Rs.<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("LOAN_DIGI_TOT_PROCESSINGFEE")) ))%></td>
                	</tr>
                	<tr align="left"> 
                		<td  bgcolor="#efefef" colspan="2" ><b> Processing Fee Collected</b></td>
                		<td align="right">Rs.<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("LOAN_DIGI_PROCESSINGFEEPAID")) ))%></td>
                	</tr>
                	
                	<tr align="left"> 
                		<td  bgcolor="#efefef" colspan="2" ><b>Eligible Amount as per Application</b> </td>
                		<td align="right" >Rs.<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("loan_recmdamt")))) %> </td>
                	</tr>
                	
    	            <% 
    	            double finalSancAmount=0.00;
    	            double dblLoanAmount=Double.parseDouble(Helper.correctDouble((String)hshValues.get("loan_recmdamt")));
    	            double dblValuationAmount=Double.parseDouble(Helper.correctDouble((String)hshValues.get("valuationAmount")));
    	            if(dblValuationAmount <= dblLoanAmount)
    	            {
    	            	finalSancAmount=dblValuationAmount;
    	            }
    	            else
    	            {
    	            	finalSancAmount=dblLoanAmount;
    	            }
    	            
    	            
    	            %>
                <!--  	
                	<tr align="left"> 
                		<td  bgcolor="#efefef" colspan="2" ><b>Final Sanction Amount</b> </td>
                		<td align="right" >Rs.<%=nf.format(finalSancAmount) %></td>
                	</tr>
              	 -->
                </table>
                <br> 
            	</td>
    		</tr>
<!--    	 
    		<tr>
				<td class="dataheader"><span style="font-size: 14px;"> Loan Summary</span> 
			</tr>
    		 
    		 
    		 <tr>
    			<td>
    			<br> 
    			<table width="60%" border="1" cellspacing="0" align="center" cellpadding="3" class="outertable">
                	 
                	<tr align="center"> 
                		<td  bgcolor="#efefef"> &nbsp;</td>
                		<td bgcolor="#efefef"> <b>As per Application </b></td>
                		<td bgcolor="#efefef"> <b> Final Sanctioned </b></td>
               		</tr> 
                	<tr align="left"> 
                		<td  bgcolor="#efefef"> <b>Loan Amount</b> </td>
                		<td align="right"> Rs.15,00,000  </td>
                		<td  align="right"> Rs.12,20,000  </td>
               		</tr>
                	<tr align="left"> 
                		<td  bgcolor="#efefef">  <b>Tenure (in Months) </b>  </td> 
                		<td align="center" > 120 &nbsp;          		 </td> 
                		<td align="center"> 120 &nbsp;          		 </td> 
                	</tr>
                	
                	<tr align="left" > 
                		<td  bgcolor="#efefef"> <b>Holiday period (in Months) </b></td>
                		<td align="center"> 3    </td> 
                		<td align="center"> 3  </td> 
                	</tr>
                	<tr align="left"> 
                		<td  bgcolor="#efefef"> <b> Interest Rate </b> </td> 
                		<td align="center"> 12.4%     		</td> 
                		<td align="center" >  12.4%     		</td> 
                	 
                </table>
                <br> 
            	</td>
    		</tr>
     		--><!--
    		 <tr>
    		<td> 
             	<table width="20%" border="0" cellspacing="0" align="center" cellpadding="3" class="outertable">
                <tr align="center"> 
                		<td><input type="button" name="cmdClick" value="Deviations" class="buttonStyle"	title="Check Deviations" onClick="callDeviation('normal')"></td>
                		<td><input type="button" class="buttonOthers" name="cmd_cbs_update" value="Sanction"> &nbsp;</td>
                		<td><input type="button" class="buttonClose" name="cmd_cbs_update" value="Reject"> &nbsp;</td>
                </tr>
                </table>
               </td>
    	</tr>
    		
    	--><!--	 <tr>
    			<td>
    			<br><br>
    			<table width="60%" border="1" cellspacing="0" align="center" cellpadding="3" class="outertable">
                	 <tr bgcolor="#efefef" align="center">
                	 	<td><b>Loan Amount </b> </td>
                	 	<td><b>Tenor </b></td>
                	 	<td><b>Holiday period </b></td>
                	 </tr>
                	  <tr align="center">
                	 	<td>Rs.15,00,000 </td>
                	 	<td>120 </td>
                	 	<td>24 </td>
                	 </tr>
    			 </table>
    			 <br><br>
            	</td>
    		</tr>
    		<tr>
				<td class="dataheader"><span style="font-size: 14px;"> Final Eligible </span> 
			</tr>
    		
    		<tr>
    			<td>
    			<br><br>
    			<table width="60%" border="1" cellspacing="0" align="center" cellpadding="3" class="outertable">
                	 <tr bgcolor="#efefef" align="center">  
                	 	<td><b>Loan Amount </b></td>
                	 	<td><b>Tenor </b></td>
                	 	<td><b>Holiday period </b></td>
                	 	<td><b>Interest Rate </b></td>
                	 </tr>
                	  <tr align="center">
                	 	<td>Rs.12,20,000 </td>
                	 	<td>120 </td>
                	 	<td>24 </td>
                	 	<td>12.5% </td>
                	 </tr>
    			 </table>
    			 <br><br>
            	</td>
    		</tr>
    	
    	--><!-- 	<tr>
    			<td>
    			<table width="30%" border="0" cellspacing="0" align="center" cellpadding="3" class="outertable">
	                <tr>
	    				<td>Processing Fee Collected </td>
						<td>Rs. 2500 </td>    		
		    		</tr>
		    		<tr>
	    				<td>Processing Fee Payment Mode</td>
						<td>Credit Card</td>    		
		    		</tr>
		    		<tr>
		    			<td>Application BRE Score</td>
		    			<td>80 </td>
		    		</tr>
		    		<tr>
		    			<td>Legal and Valuation </td>
		    			<td> Rs.15,00,000</td>
		    		</tr>
		    		<tr>
		    			<td>Eligibility Based on Income</td>
		    			<td> Rs.25,00,000</td>
		    		</tr>
		    		<tr>
		    			<td>Eligibility Amount</td>
		    			<td> Rs.10,00,000</td>
		    		</tr> 
		    		<tr>
							<td>Deviation </td>    					
    						<td> 
	    						<select name="sel_deviation_status" >
	    							<option value="Y">Yes &nbsp;&nbsp;&nbsp;</option>
	    							<option value="N">No</option>
	    						</select>
    						</td>
    				</tr>
               </table>	
    			</td>
    		</tr>
    		 -->
    	<!-- 	
    		<tr>
    			<td>
    			<table width="70%" border="1" cellspacing="0" align="center" cellpadding="3" class="outertable">
                	<tr align="center" class="dataHeader">
                		<td colspan="4"> Deviation</td>
                	</tr>
                	<tr align="center" class="dataHeader"> 
                		<td>Type of Deviation </td>
                		<td>As per Bank defined </td>
                		<td>Borrower requested </td> 
                		<td>Approval Status</td> 
                	</tr>
                	<tr class="datagrid">
                		<td>Loan Amount</td>
                		<td> &nbsp;</td>
                		<td> &nbsp;</td>
                		<td> &nbsp;</td>
                	</tr>
                	<tr class="datagrid">
                		<td>Interest Rate</td>
                		<td> 13.5%</td>
                		<td> 12%</td>
                		<td> Approved </td>
                	</tr>
                	<tr class="datagrid">
                		<td>Margin</td>
                		<td> 25%</td>
                		<td> 20%</td>
                		<td> Rejected </td>
                	</tr>
                </table>
            	</td>
    		</tr>
   		-->
    		
    		
    		
    	</table>
    </td>
    </tr><!--
    <tr>
    		<td> 
             	<table width="20%" border="0" cellspacing="0" align="center" cellpadding="3" class="outertable">
                <tr align="center"> 
                		<td><input type="button" name="cmdClick" value="Deviations" class="buttonStyle"	title="Check Deviations" onClick="callDeviation('normal')"></td>
                		<td><input type="button" class="buttonOthers" name="cmd_cbs_update" value="Sanction"> &nbsp;</td>
                		<td><input type="button" class="buttonClose" name="cmd_cbs_update" value="Reject"> &nbsp;</td>
                </tr>
                </table>
               </td>
    	</tr>
    -->
    	<tr>
    		<td> <br><br> </td>
    	</tr>
    <tr>
    		<td> 
             	<table width="20%" border="0" cellspacing="0" align="center" cellpadding="3" class="outertable">
                <tr align="center"> 
<!--                	<td><input type="button" name="cmdClick" value="Deviations" class="buttonStyle"	title="Check Deviations" onClick="callDeviation('normal')"></td>-->
                		<td><input type="button" class="buttonOthers" name="cmd_save" value="Save" onclick="doSave()"> &nbsp;</td>
                		<!-- <td><input type="button" class="buttonOthers" name="cmd_submit" value="Submit" onclick="goSubmit()"> &nbsp;</td>
                		<td><input type="button" class="buttonClose" name="cmd_reject" value="Reject" onclick="doReject()"> &nbsp;</td> -->
                </tr>
                </table>
               </td>
    	</tr>
    </table>

	<br><br><br>


  <input type="hidden" name="chk_busineess_proof"> 
 <input type="hidden" name="chk_itr">
  <input type="hidden" name="hid_appid">
 <input type="hidden" name="chk_bankstat">
   <input type="hidden" name="cmd_cbs_create">
   <input type="hidden" name="hid_appid">
   <input type="hidden" name="hid_hidborrowerid">
   <input type="hidden" name="chk_pan">	
 <input type="hidden" name="hid_PANdate">
 <input type="hidden" name="hid_PANuser">
  <input type="hidden" name="hidKYCChk">
 <input type="hidden" name="strcbscustflag">
 <input type="hidden" name="hid_ITRdate">
 <input type="hidden" name="hid_ITRuser">
  <input type="hidden" name="hid_bankdate">
 <input type="hidden" name="hid_bankuser">
<input type="hidden" name="hidborrowerid">
<input type="hidden" name="cmdsave" disabled="disabled">

 <input type="hidden" name="hid_empdate">
 <input type="hidden" name="hid_empuser">
 
 <input type="hidden" name="hid_businessplacedate">
 <input type="hidden" name="hid_businessplaceuser">
<input type="hidden" name="chk_business">
	
<input type="hidden" name="chk_residentvisit">
<input type="hidden" name="hid_residenceuser">
<input type="hidden" name="hid_residencedate">

<input type="hidden" name="chk_collateral">
<input type="hidden" name="hid_collateraldate">
<input type="hidden" name="hid_collateraluser">


<input type="hidden" name="chk_gstin">
<input type="hidden" name="hid_gstndate">
<input type="hidden" name="gid_gstnuser">

<input type="hidden" name="chk_uan">
<input type="hidden" name="hid_UANdate">
<input type="hidden" name="hid_UANuser">

<input type="hidden" name="chk_balancesheet">
<input type="hidden" name="hid_balancedate">
<input type="hidden" name="hid_balanceuser">


<input type="hidden" name="chk_tra_pro_loss">
<input type="hidden" name="hid_tradingdate">
<input type="hidden" name="hid_tradinguser">

<input type="hidden" name="chk_financialstat">
<input type="hidden" name="hid_statementdate">
<input type="hidden" name="hid_statementuser">

<input type="hidden" name="chk_litigationcorp">
<input type="hidden" name="hid_litigationcorpdate">
<input type="hidden" name="hid_litigationcorpuser">

<input type="hidden" name="chk_litigationindiv">
<input type="hidden" name="hid_litigationdate">
<input type="hidden" name="hid_litigationuser">

<input type="hidden" name="chk_submission">
<input type="hidden" name="hid_submissiondate">
<input type="hidden" name="hid_submissionuser">
<input type="hidden" name="chk_businessNA">
<input type="hidden" name="chk_residentvisitNA">
<input type="hidden" name="chk_panNA">
<input type="hidden" name="chk_uanNA">
<input type="hidden" name="chk_collateralNA">
<input type="hidden" name="chk_gstinNA">
<input type="hidden" name="chk_bankstatNA">
<input type="hidden" name="chk_itrNA">
<input type="hidden" name="chk_balancesheetNA">
<input type="hidden" name="chk_tra_pro_lossNA">
<input type="hidden" name="chk_financialstatNA">
<input type="hidden" name="chk_litigationcorpNA">
<!-- <input type="hidden" name="hid_BEdate"> 
 <input type="hidden" name="hid_BEuser">
  <input type="hidden" name="hid_PRAdate">
 <input type="hidden" name="hid_PRAuser">
 <input type="hidden" name="hid_POAdate">
 <input type="hidden" name="hid_POAuser">
 <input type="hidden" name="hid_BProfdate">
 <input type="hidden" name="hid_BProfuser">
 <input type="hidden" name="hid_fiaddressdate">
 <input type="hidden" name="hid_fiaddressuser">
    <!--<input type="hidden" name="chk_proofaddress">
 -->
  <!--<input type="hidden" name="chk_fiaddress">
  <input type="hidden" name="chk_employment">
  -->
   <!--
   
   <input type="hidden" name="chk_officeaddress"> 
  <input type="hidden" name="chk_resedentailaddress">
   <input type="hidden" name="chk_proofaddress_perm"> 
  --><!-- <input type="hidden" name="chk_busexst"> -->
 
<!--   <input type="hidden" name="chk_proofaddress_office"> -->
  
 
  
   <!--
 <input type="hidden" name="hid_prfaddrsdate">
 <input type="hidden" name="hid_prfaddrsuser">
 -->



<!--  <input type="hidden" name="stremploy">   -->
     

  <lapschoice:hiddentag pageid='<%=PageId%>'/>
</form>
</body>
</html>