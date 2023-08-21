<%@include file="../share/directives.jsp"%>
<%
	ArrayList arrRow= new ArrayList();
	ArrayList arrCol=new ArrayList();
	
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
String strAmberStatus=Helper.correctNull((String)hshValues.get("AMBER_APPROVAL"));
String strAmberStatusdate=Helper.correctNull((String)hshValues.get("DEMO_AMBER_DATE"));
//String stremploy=Helper.correctNull((String)arrCol.get(10));
String applholder =  Helper.correctNull(request.getParameter("appholder"));
String digiAppStatus=Helper.correctNull((String)hshValues.get("digiAppNo"));
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
var varOrgLevel="<%=Helper.correctNull((String)hshValues.get("strOrgLevel"))%>";
var varOtherDevFLag="<%=Helper.correctNull((String)hshValues.get("strOtherDevFlag"))%>";
var varAmberStatus="<%=strAmberStatus%>";
var varapplholder="<%=applholder%>";
var varstrusrid='<%=Helper.correctNull((String) session.getAttribute("strUserId"))%>';
var varamberappid="<%=Helper.correctNull((String)hshValues.get("AMBER_APPROVAL_ID"))%>";
var varAmber="<%=Helper.correctNull((String)hshValues.get("DEMO_AMBER_APPROVAL"))%>";



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
	var purl ="<%=ApplicationParams.getAppUrl()%>action/digi_deviationdetail.jsp?hidBeanId=perlimitofloan&hidBeanGetMethod=getData&Applicationno="+appno+"&btnenable="+btnenable+"&hidapplicantid="+appid;
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
          docPPAdate=document.forms[0].hid_prfaddrsdate[<%=i%>].value;
          docPANdate=document.forms[0].hid_PANdate[<%=i%>].value;
          DocPPAUser=document.forms[0].hid_prfaddrsuser[<%=i%>].value;
          DocPANUser=document.forms[0].hid_PANuser[<%=i%>].value;
          <%-- DocAddDate=document.forms[0].hid_fiaddressdate[<%=i%>].value;
          DocAddUser=document.forms[0].hid_fiaddressuser[<%=i%>].value; --%>
          DocEmpDate=document.forms[0].hid_empdate[<%=i%>].value;
          DocEmpUser=document.forms[0].hid_empuser[<%=i%>].value;
          DocBankDate=document.forms[0].hid_bankdate[<%=i%>].value;
          DocBankUser=document.forms[0].hid_bankuser[<%=i%>].value;
          <%-- DocBEDate=document.forms[0].hid_BEdate[<%=i%>].value;
          DocBEUser=document.forms[0].hid_BEuser[<%=i%>].value; --%>
          DocITRDate=document.forms[0].hid_ITRdate[<%=i%>].value;
          DocITRUser=document.forms[0].hid_ITRuser[<%=i%>].value;
          DocPCADate=document.forms[0].hid_proofcurrentaddrdate[<%=i%>].value;
          DocPCAUser=document.forms[0].hid_proofcurrentadduser[<%=i%>].value;
          DocPRADate=document.forms[0].hid_PRAdate[<%=i%>].value;
          DocPRAUser=document.forms[0].hid_PRAuser[<%=i%>].value;
          DocPOADate=document.forms[0].hid_POAdate[<%=i%>].value;
		  DocPOAUser=document.forms[0].hid_POAuser[<%=i%>].value;
          DocBPDate=document.forms[0].hid_BProfdate[<%=i%>].value;
		  DocBPUser=document.forms[0].hid_BProfuser[<%=i%>].value;
		 
         
          
		  if(document.forms[0].chk_proofaddress[<%=i%>].checked==true) 
          {
           	varproofchk=appid+"@PCA@"+DocPRADate+" @"+DocPRAUser+" @";
          }
          else
          {
        	  varproofchk=appid+"@ @ @ @";
        	  
        	  //varproofchk=varproofchk+" @ @ @";
          }
		  if(document.forms[0].chk_proofaddress_perm[<%=i%>].checked==true)
          {
              /* if(varproofchk=="") */
              
           	   varproofchk=varproofchk+"PPA@"+docPPAdate+" @"+DocPPAUser+" @";
              
          }
          else
          {
       	  // varproofchk=appid+"@ @ @ @";
        	  varproofchk=varproofchk+" @ @ @";
          }
          
          if(document.forms[0].chk_pan[<%=i%>].checked==true) 
          {
           	varproofchk=varproofchk+"PAN@"+docPANdate+" @"+DocPANUser+" @";
          }	
          else
          {
       	   varproofchk=varproofchk+" @ @ @";
          }
          
          
          
          if(document.forms[0].chk_resedentailaddress[<%=i%>].checked==true) 
          {
           	varproofchk=varproofchk+"PRA@"+DocPRADate+" @"+DocPRAUser+" @";
          }
          else
          {
       	   varproofchk=varproofchk+" @ @ @";
          }
          
          
          if(document.forms[0].chk_bankstat[<%=i%>].checked==true) 
          {
           	varproofchk=varproofchk+"BNK@"+DocBankDate+" @"+DocBankUser+" @";
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
          }
          else
          {
       	   
        	  varproofchk=varproofchk+" @ @ @";
          }
          
          if(document.forms[0].chk_employment[<%=i%>].checked==true) 
          {
           	varproofchk=varproofchk+"EMP@"+DocEmpDate+" @"+DocEmpUser+" @";
          }
          else
          {
       	   varproofchk=varproofchk+" @ @ @";
          }
         
        
          if(document.forms[0].chk_officeaddress[<%=i%>].checked==true) 
          {
           	varproofchk=varproofchk+"POA@"+DocPOADate+" @"+DocPOAUser+" @";
          }
          else
          {
       	   varproofchk=varproofchk+" @ @ @";
          }
          
         
          
          if(document.forms[0].chk_busineess_proof[<%=i%>].checked==true) 
          {
           	varproofchk=varproofchk+"BP@"+DocBPDate+" @"+DocBPUser+" @";
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
		   
          
<%}} %>

document.forms[0].txt_recBranch.disabled = false;
document.forms[0].txt_recHeadOffice.disabled = false;

document.forms[0].hidKYCChk.value=varKYCchk;
document.forms[0].hidAction.value="Savehl";
document.forms[0].action=appURL+"controllerservlet";
document.forms[0].hidBeanMethod.value="updateSanctionDetails";
document.forms[0].hidBeanGetMethod.value="getDigiDecisionDetail";
document.forms[0].hidBeanId.value="DigitalAppInterface";			
document.forms[0].hidSourceUrl.value="/action/appl_digitalisation_decision_HL.jsp";
document.forms[0].submit();
document.getElementById("form_blur").style.visibility="visible";
document.getElementById("progress").style.visibility="visible";
		
	}
				
		
		function onload()
		{
			var apistatus="<%=Helper.correctNull((String)hshValues.get("apistatus"))%>";
			var apistatusdesc="<%=Helper.correctNull((String)hshValues.get("apistatusdesc"))%>";
			if(apistatus!="")
			{
				alert(apistatus+". "+apistatusdesc);
			}
			
			var Submitstatus="<%=Helper.correctNull((String)hshValues.get("Submitstatus"))%>";
			var rejectstatus="<%=Helper.correctNull((String)hshValues.get("rejectstatus"))%>";
			var strcbscustflag="";
			var varAmberapproval="";	
			var varamberexist ="<%=Helper.correctNull((String)hshValues.get("amberExist"))%>";
			 
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
					//document.forms[0].cmd_UCIC_Check[i].disabled=true;
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
					//document.forms[0].cmd_submit.disabled=true;
					document.forms[0].cmd_save.disabled=true;
					//document.forms[0].cmd_reject.disabled=true;
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
					
					}*/
					
				 
				
					
			
				
				<%
				String StrPAVal="",StrPANVal="",StrEMPVal="",StrBNKVal="",StrPRAVal="",
				StrPOAVal="",StrPCAVal="",StrPPAVal="",StrBPVal="",StrITRVal="",amberApproval="",strucicdedupeflag="",strperappaadhar="",strperapppannum="";
				
					
				if(arrRow.size()>0 && arrRow!=null) 
			      {
			         for(int i=0;i<arrRow.size();i++)
			         {
			        	 
			         
			         arrCol=(ArrayList)arrRow.get(i);
			         String strDocVal=Helper.correctNull((String)arrCol.get(14));
			         String strcbscustflag=Helper.correctNull((String)arrCol.get(23));
			         
			         String strpanflag=Helper.correctNull((String)arrCol.get(5));
			         String strpermaddressflag=Helper.correctNull((String)arrCol.get(21));
			         String strfiemp=Helper.correctNull((String)arrCol.get(7));
			         String strfibankstat=Helper.correctNull((String)arrCol.get(8));
			         String strfiaddress=Helper.correctNull((String)arrCol.get(6));
			         String strbusproofflag=Helper.correctNull((String)arrCol.get(30));
			         String stritrflag=Helper.correctNull((String)arrCol.get(31));
			         String strofficeaddress=Helper.correctNull((String)arrCol.get(32));
			         String strcurrentaddress=Helper.correctNull((String)arrCol.get(4));
			          amberApproval =Helper.correctNull((String)arrCol.get(43));
				          strucicdedupeflag=Helper.correctNull((String)arrCol.get(44));

			         ArrayList arrtemp=new ArrayList();
             		arrtemp=(ArrayList)arrCol.get(36);
			         
			        
			         if(!strDocVal.equalsIgnoreCase(""))
		 			 {
						String[] strDocSplitVal=strDocVal.split("@");
						StrPANVal=strDocSplitVal[2];//3
						//StrADDVal=strDocSplitVal[8];//9
						StrEMPVal=strDocSplitVal[6];//10
						StrBNKVal=strDocSplitVal[4];//11
						StrPRAVal=strDocSplitVal[3];//6
						StrPOAVal=strDocSplitVal[7];//7
						StrPCAVal=strDocSplitVal[0];//1
						StrPPAVal=strDocSplitVal[1];//2
						//StrBEVal=strDocSplitVal[3];//4
						StrBPVal=strDocSplitVal[8];//8
						StrITRVal=strDocSplitVal[5];//5
		 			 }
			         
			         
			         if(strcurrentaddress.equalsIgnoreCase("N"))
				 		{%>
				        
				 		document.forms[0].chk_proofaddress[<%=i%>].checked=true;
						document.forms[0].chk_proofaddress[<%=i%>].disabled=true;
				 	

				        	 <%}
			         
			         
			         if(strpanflag.equalsIgnoreCase("N"))
				 		{%>
				        
				 		document.forms[0].chk_pan[<%=i%>].checked=true;
						document.forms[0].chk_pan[<%=i%>].disabled=true;
				 	

				        	 <%} 
			      
			         
			         if(strpermaddressflag.equalsIgnoreCase("N"))
				 		{%>
				        
				 		document.forms[0].chk_proofaddress_perm[<%=i%>].checked=true;
						document.forms[0].chk_proofaddress_perm[<%=i%>].disabled=true;
				 	

				        	 <%} 
			         
			         if(strfiemp.equalsIgnoreCase("N"))
				 		{%>
				        
				 		document.forms[0].chk_employment[<%=i%>].checked=true;
						document.forms[0].chk_employment[<%=i%>].disabled=true;
				 	

				        	 <%} 
			         
			         
			         if(strfibankstat.equalsIgnoreCase("N"))
				 		{%>
				        
				 		document.forms[0].chk_bankstat[<%=i%>].checked=true;
						document.forms[0].chk_bankstat[<%=i%>].disabled=true;
				 	

				        	 <%} 
			         
			         
			         
			         if(strfiaddress.equalsIgnoreCase("N"))
				 		{%>
				        
				 		document.forms[0].chk_resedentailaddress[<%=i%>].checked=true;
						document.forms[0].chk_resedentailaddress[<%=i%>].disabled=true;
				 	

				        	 <%} 
			         
			         
			         if(strbusproofflag.equalsIgnoreCase("N"))
				 		{%>
				        
				 		document.forms[0].chk_busineess_proof[<%=i%>].checked=true;
						document.forms[0].chk_busineess_proof[<%=i%>].disabled=true;
				 	

				        	 <%} 
			         
			         if(stritrflag.equalsIgnoreCase("N"))
				 		{%>
				        
				 		document.forms[0].chk_itr[<%=i%>].checked=true;
						document.forms[0].chk_itr[<%=i%>].disabled=true;
				 	

				        	 <%} 
			         
			         if(strofficeaddress.equalsIgnoreCase("N"))
				 		{%>
				        
				 		document.forms[0].chk_officeaddress[<%=i%>].checked=true;
						document.forms[0].chk_officeaddress[<%=i%>].disabled=true;
				 	

				        	 <%}
			         
			         
			         
		 			 if(StrPCAVal.equalsIgnoreCase("PCA")){%>    
	      				document.forms[0].chk_proofaddress[<%=i%>].checked=true;
						document.forms[0].chk_proofaddress[<%=i%>].disabled=true;	
	     	  		 	<%} 
		 			 if(StrPPAVal.equalsIgnoreCase("PPA")){%>
		      			document.forms[0].chk_proofaddress_perm[<%=i%>].checked=true;
						document.forms[0].chk_proofaddress_perm[<%=i%>].disabled=true;
			       <%}
		 			if(StrPANVal.equalsIgnoreCase("PAN")){%>    
			        	document.forms[0].chk_pan[<%=i%>].checked=true;
						document.forms[0].chk_pan[<%=i%>].disabled=true;
					<%}
		 			
		 			
		 			
					if(StrEMPVal.equalsIgnoreCase("EMP")){%>    
			        	document.forms[0].chk_employment[<%=i%>].checked=true;
						document.forms[0].chk_employment[<%=i%>].disabled=true;
					<%}if(StrBNKVal.equalsIgnoreCase("BNK")){%>    
			        	document.forms[0].chk_bankstat[<%=i%>].checked=true;
						document.forms[0].chk_bankstat[<%=i%>].disabled=true;	
			       <%}if(StrPRAVal.equalsIgnoreCase("PRA")){%>    
		       			document.forms[0].chk_resedentailaddress[<%=i%>].checked=true;
						document.forms[0].chk_resedentailaddress[<%=i%>].disabled=true;	
		      	  	 <%}if(StrPOAVal.equalsIgnoreCase("POA")){%>    
	       			document.forms[0].chk_officeaddress[<%=i%>].checked=true;
					document.forms[0].chk_officeaddress[<%=i%>].disabled=true;	
	      	  		 <%}
	      	  		 
	      	  		 
			              	  		 
 	 			  if(StrBPVal.equalsIgnoreCase("BP")){%>    
					document.forms[0].chk_busineess_proof[<%=i%>].checked=true;
					document.forms[0].chk_busineess_proof[<%=i%>].disabled=true;	
  					<%}
 	 			  if(StrITRVal.equalsIgnoreCase("ITR")){%>    
					document.forms[0].chk_itr[<%=i%>].checked=true;
					document.forms[0].chk_itr[<%=i%>].disabled=true;	
		<% } 		
 	 			
				
		        	 %>
				  strcbscustflag="<%=strcbscustflag%>";	
  
			       if(varappstatus!="pa" && varappstatus!="ca")
					{		
			      	 	if(document.forms[0].chk_proofaddress[<%=i%>].checked==true &&  document.forms[0].chk_pan[<%=i%>].checked==true && 
			      	 			 document.forms[0].chk_employment[<%=i%>].checked==true && document.forms[0].chk_bankstat[<%=i%>].checked==true &&  
			      	 			document.forms[0].chk_itr[<%=i%>].checked==true && document.forms[0].chk_officeaddress[<%=i%>].checked==true && document.forms[0].chk_resedentailaddress[<%=i%>].checked==true && 
			      	 			document.forms[0].chk_busineess_proof[<%=i%>].checked==true  && document.forms[0].chk_proofaddress_perm[<%=i%>].checked==true)
			    		{
			      			
			      	 		document.forms[0].cmd_cbs_create[<%=i%>].disabled=false;
			    		
			    			
			    		
			    		} 
					}  
					var varucicdedupeflag = "<%=strucicdedupeflag%>";
			        //alert(varucicdedupeflag);
			      
			       <%}}%>
			        
			       document.forms[0].txt_recHeadOffice.disabled=true;
			       document.forms[0].txt_recBranch.disabled=true;
			        if( varOrgLevel=="A" || varOrgLevel=="D" || varOrgLevel=="R"){
			       document.forms[0].txt_recBranch.disabled=false;  
				    }else if(varOrgLevel=="C"){
				     document.forms[0].txt_recHeadOffice.disabled=false;
				     }
				     

				     if(varAmber=="Y" || varAmber=="N" || varamberexist!="AmberExist")
			        	 {
				    document.forms[0].rejected.disabled=true;
			        document.forms[0].approval.disabled=true;
			        if(varstrusrid==varamberappid && varappstatus=="op" ){
				        document.forms[0].undo.disabled=false;
			        }else{
				        document.forms[0].undo.disabled=true;
			        }
			        
			        	 }else{
			        		 
			        document.forms[0].approval.disabled=false; 
			        document.forms[0].rejected.disabled=false;
			        document.forms[0].undo.disabled=true;
			         }
				     if(varappstatus!="op" || varAmberStatus!="" || varapplholder!=varstrusrid)
				     {
				    	 document.forms[0].txt_recBranch.readOnly=true;
				    	 document.forms[0].txt_recHeadOffice.readOnly=true;
				    	 document.forms[0].rejected.disabled=true;
					     document.forms[0].approval.disabled=true;
					     //document.forms[0].cmd_save.disabled=true;
					     document.forms[0].cmd_cbs_create.disabled=true;
					  //   document.forms[0].cmd_UCIC_Check.disabled=true;

				     }
			
		}
		
function callcheck(row)
{
	if(document.forms[0].chk_proofaddress[row].checked==true &&  document.forms[0].chk_pan[row].checked==true &&
		 document.forms[0].chk_employment[row].checked==true && document.forms[0].chk_bankstat[row].checked==true && 
		document.forms[0].chk_itr[row].checked==true && document.forms[0].chk_officeaddress[row].checked==true && document.forms[0].chk_resedentailaddress[row].checked==true &&
		document.forms[0].chk_busineess_proof[row].checked==true && document.forms[0].chk_proofaddress_perm[row].checked==true)
	{
		 
		//&& document.forms[0].chk_proofaddress[row].checked==true
		//document.forms[0].cmd_cbs_create[row].disabled=false;
		
	
	}
	else
	{
		document.forms[0].cmd_cbs_create[row].disabled=true;
		//document.forms[0].cmd_UCIC_Check[row].disabled=true;
	}
	
}	

function goSubmit()
{
	document.forms[0].hidBeanId.value="DigitalAppInterface";
	document.forms[0].hidBeanGetMethod.value="updateSanctionDetails";
	document.forms[0].action=appURL+"action/appl_digitalisation_decision_HL.jsp";
	document.forms[0].submit();
	
}

function goCBSupdate(appid)
{

	document.forms[0].hidborrowerid.value=appid;
	document.forms[0].hidBeanId.value="DigitalAppInterface";
	document.forms[0].hidBeanGetMethod.value="cbsIdModificationService";
	document.forms[0].action=appURL+"action/appl_digitalisation_decision_HL.jsp";
	document.forms[0].submit();
	document.getElementById("form_blur").style.visibility="visible";
	document.getElementById("progress").style.visibility="visible";
}
function goUCICCheck(appid)
{
	var prop = "scrollbars=yes,width=1100,height=700,top=25,left=180";
	appno=document.forms[0].appno.value;
	var url=appURL+"action/digiuciccall.jsp?hidBeanId=DigitalAppInterface&hidBeanGetMethod=UCICExecuteService&hidborrowerid="+appid+"&appno="+appno+"&strappstatus"+varappstatus+"&hidAction=get";
	window.open(url,"DIGI_UCIC",prop);
	onload();
	
}


function goCBScreate(appid)
{
	document.forms[0].hidborrowerid.value=appid;
	document.forms[0].hidBeanId.value="DigitalAppInterface";
	document.forms[0].hidBeanGetMethod.value="cbsIDCreationService";
	document.forms[0].action=appURL+"action/appl_digitalisation_decision_HL.jsp";
	document.forms[0].submit();
	document.getElementById("form_blur").style.visibility="visible";
	document.getElementById("progress").style.visibility="visible";
}

        
function callcheckdate(val,row)
{
	if(val=="PCA")
	{
		if(document.forms[0].chk_proofaddress[row].checked==true)
		{
			document.forms[0].hid_proofcurrentaddrdate[row].value=sysdate;
			document.forms[0].hid_proofcurrentadduser[row].value=strDocUserId;
		}
		else if(document.forms[0].chk_proofaddress[row].checked==false)
		{
			document.forms[0].hid_proofcurrentaddrdate[row].value="";
			document.forms[0].hid_proofcurrentadduser[row].value="";
		}
	}
	
	if(val=="PPA")
	{
		if(document.forms[0].chk_proofaddress_perm[row].checked==true)
		{
			document.forms[0].hid_prfaddrsdate[row].value=sysdate;
			document.forms[0].hid_prfaddrsuser[row].value=strDocUserId;
		}
		else if(document.forms[0].chk_proofaddress_perm[row].checked==false)
		{
			document.forms[0].hid_prfaddrsdate[row].value="";
			document.forms[0].hid_prfaddrsuser[row].value="";
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
if(val=="PRA")
		
	{
	
	if(document.forms[0].chk_resedentailaddress[row].checked==true)
	{
		document.forms[0].hid_PRAdate[row].value=sysdate;
		document.forms[0].hid_PRAuser[row].value=strDocUserId;
	}
	else if(document.forms[0].chk_resedentailaddress[row].checked==false)
	{
		document.forms[0].hid_PRAdate[row].value="";
		document.forms[0].hid_PRAuser[row].value="";
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
	if(val=="EMP")
	{
		if(document.forms[0].chk_employment[row].checked==true)
		{
			document.forms[0].hid_empdate[row].value=sysdate;
			document.forms[0].hid_empuser[row].value=strDocUserId;
		}
		else if(document.forms[0].chk_employment[row].checked==false)
		{
			document.forms[0].hid_empdate[row].value="";
			document.forms[0].hid_empuser[row].value="";
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
	
	
	
	

if(val=="POA")
	
{

if(document.forms[0].chk_officeaddress[row].checked==true)
{
	document.forms[0].hid_POAdate[row].value=sysdate;
	document.forms[0].hid_POAuser[row].value=strDocUserId;
}
else if(document.forms[0].chk_officeaddress[row].checked==false)
{
	document.forms[0].hid_POAdate[row].value="";
	document.forms[0].hid_POAuser[row].value="";
}

}

if(val=="BP")
	
{

if(document.forms[0].chk_busineess_proof[row].checked==true)
{
	document.forms[0].hid_BProfdate[row].value=sysdate;
	document.forms[0].hid_BProfuser[row].value=strDocUserId;
}
else if(document.forms[0].chk_busineess_proof[row].checked==false)
{
	document.forms[0].hid_BProfdate[row].value="";
	document.forms[0].hid_BProfuser[row].value="";
}
}


}

function amberRule(value)
{	
	if(varOtherDevFLag=="Y")
	{
		alert("Insufficient power to approve Amber");
		return false;
	}
	//document.forms[0].hid_approved_appid.value=appid;
	document.forms[0].hidAction.value=value;
	document.forms[0].hidBeanId.value="DigitalAppInterface";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidBeanMethod.value="amberRule";
	document.forms[0].hidBeanGetMethod.value="getDigiDecisionDetail";
	document.forms[0].hidSourceUrl.value="/action/appl_digitalisation_decision_HL.jsp";
	//document.forms[0].hidBeanGetMethod.value="amberRule";
	//document.forms[0].action=appURL+"action/appl_digitalisation_decision_HL.jsp";
	document.forms[0].submit();
	document.getElementById("form_blur").style.visibility="visible";
	document.getElementById("progress").style.visibility="visible";
}

</script>
</head>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<body onload="onload()">
<div id="progress" style="position:absolute; width:106px; visibility:hidden; height:19px; z-index:9999999; left: 550px; top: 450px" >
<img src="<%=ApplicationParams.getAppUrl()%>img/processing2.gif"></div>
<div class="overlay" id="form_blur" style="position:absolute; visibility:hidden;height:1450px;"></div>
<form name="appform" method="post" action="" class="normal">

        <jsp:include page="../share/applurllinkerdigi.jsp" flush="true" > 
        <jsp:param name="pageid" value="1" />
        </jsp:include>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
		   <td class="page_flow">Home -&gt; Digi Retail -&gt; Application -&gt; Loan Particulars -&gt; Decision</td>
    </tr>
  </table>
  <lapschoice:application />
<jsp:include page="../per/applicantTabDigi.jsp" flush="true"> 
             			<jsp:param name="linkid" value="77" />
                        </jsp:include><br>

  <table width="100%" border="0" cellspacing="1" cellpadding="3"  align="center" class="outertable">
   			<tr>
    			<td>
             	 	<table width="38%" border="0" cellspacing="0" align="center" cellpadding="3" class="datagrid">
                	<tr align="center"> 
                		
                		<%if(appstatus.equalsIgnoreCase("Open/Pending") || appstatus.equalsIgnoreCase("op")){%>
                		<td><span style="font-size: 16px;"> Status of Application- <B><span style="color: #7a4d98"> In-Principle Sanction</span> </B>  </span></td>
                	
                	  	<%} else {%>
                		<td><span style="font-size: 16px;"> Status of Application- <B><span style="color: #7a4d98"> <%=appstatus%> </span> </B>  </span></td>
                	<%}%>
                	</tr>
                	</table>
               </td>
    		</tr>
    		<!--  added for amber status   -->
    		
    			<td>
             	 	<table width="40%" border="0" cellspacing="0" align="center" cellpadding="3" class="datagrid">
                	<tr align="center"> 
                		
                		<%if( strAmberStatus.equalsIgnoreCase("Y")){%>
                		<td><span style="font-size: 15px;"> Amber Status- <B><span style="color: #7a4d98"> Approved </span> </B>  </span> &nbsp &nbsp
                		<span style="font-size: 15px;"> Approved By- <B><span style="color: #7a4d98"><%=Helper.correctNull((String)hshValues.get("AMBER_APPROVAL_ID"))%></span> </B>  </span>
                	  &nbsp&nbsp <span style="font-size: 15px;"> Date- <B><span style="color: #7a4d98"><%=strAmberStatusdate%></span> </B>  </span></td>
                		
                		<%} else if(strAmberStatus.equalsIgnoreCase("N")) {%>
                		<td><span style="font-size: 15px;"> Amber Status- <B><span style="color: #7a4d98"> Rejected </span> </B>  </span> &nbsp&nbsp
            		    <span style="font-size: 15px;"> Rejected By- <B><span style="color: #7a4d98"> <%=Helper.correctNull((String)hshValues.get("AMBER_APPROVAL_ID"))%></span> </B>  </span>
            		   &nbsp&nbsp <span style="font-size: 15px;"> Date- <B><span style="color: #7a4d98"> <%=strAmberStatusdate%></span> </B>  </span></td>
            		    
                	<%} else  {%>
                		<td><span style="font-size: 15px;"> Amber Status- <B><span style="color: #7a4d98">  </span> </B>  </span></td>
                	<%}%>
                	</tr>
                	</table>
               </td>
               <tr>
               <td>
             	 	<table width="20%" border="0" cellspacing="0" align="center" cellpadding="3" class="datagrid">
                	<tr align="center"> 
                		
                		
                	<td ><span style="font-size: 12px;"> Digi Application No:<B><span style="color: #7a4d98"> <%=digiAppStatus%></span></B></td>
                	</tr>
                	</table>
               </td>
    		</tr>
    		<!--  added for amber status   -->
    		
    	<tr> 
    	<tr>
    			<td> 
             	 	<table width="85%" border="0" cellspacing="1" align="center" cellpadding="3" class="outertable" >
                	<tr align="center" class="dataHeader" > 
                		<td width="15%">Borrower Details </td>
                		<td width="7%">CBSID </td>
                		<td width="5%">CIBIL Score </td>
                		<td width="10%">KYC CheckList</td> 
                		<td width="10%">Field Investigation CheckList</td> 
                		<td width="10%"> Action&nbsp; </td>
                		<td width="10%" nowrap="nowrap"> Amber Rules &nbsp; </td>
                		<td width="10%" nowrap="nowrap"> &nbsp; </td>
                		
                	</tr>
                	<% 
                	String StrPADate="",StrPAUser="";
                	String StrPANDate="",StrPANUser="";
                	//String StrADDDate="",StrADDUser="";
                	String StrEMPDate="",StrEMPUser="";
                	String StrBNKDate="",StrBNKUser="";
                	String StrPCADate="",StrPCAUser="";
                	String StrPPADate="",StrPPAUser="";
                	//String StrBEDate="",StrBEUser="";
                	String StrITRDate="",StrITRUser="";
                	String StrPRADate="",StrPRAUser="";
                	String StrOAPDate="",StrOAPUser="";
                	String StrBProfDate="",StrBProfUser="";
                	
                	
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
                			String straddressflag=Helper.correctNull((String)arrCol.get(4));
                			String strpanflag=Helper.correctNull((String)arrCol.get(5));
                			String strfiaddressflag=Helper.correctNull((String)arrCol.get(6));
                			String strfiempflag=Helper.correctNull((String)arrCol.get(7));
                			String strfibankstatflag=Helper.correctNull((String)arrCol.get(8));
                			String strperappid=Helper.correctNull((String)arrCol.get(9));
                			String stremploy=Helper.correctNull((String)arrCol.get(10));
                			 String strcbscustflag=Helper.correctNull((String)arrCol.get(23));
							String strborrowerincome=Helper.correctNull((String)arrCol.get(11));
							String strDocDate=Helper.correctNull((String)arrCol.get(15));
                			String strDocUser=Helper.correctNull((String)arrCol.get(16));
                			String strKycPendFlag=Helper.correctNull((String)arrCol.get(24));
                			String strpermaddressflag=Helper.correctNull((String)arrCol.get(21));
                			//String strpraadrs=Helper.correctNull((String)arrCol.get(16));
							String strFiPendFlag=Helper.correctNull((String)arrCol.get(25));	
               				 strucicdedupeflag=Helper.correctNull((String)arrCol.get(44));
               				strperapppannum=Helper.correctNull((String)arrCol.get(45));
               				strperappaadhar=Helper.correctNull((String)arrCol.get(46));
               				
							if(!strDocDate.equalsIgnoreCase(""))
                			{
								
								String[] strDocSplitDate=strDocDate.split("@");
								//StrPADate=strDocSplitDate[0];
								StrPANDate=strDocSplitDate[2];
								//StrADDDate=strDocSplitDate[1];
								StrEMPDate=strDocSplitDate[6];
								StrBNKDate=strDocSplitDate[4];
								StrPCADate=strDocSplitDate[0];
								StrPPADate=strDocSplitDate[1];
								//StrBEDate=strDocSplitDate[6];
								StrITRDate=strDocSplitDate[5];
								StrPRADate=strDocSplitDate[3];
								StrOAPDate=strDocSplitDate[7];
								StrBProfDate=strDocSplitDate[8];
                			
                			}
								
							if(!strDocUser.equalsIgnoreCase(""))
                			{
                				String[] strDocSplitUser=strDocUser.split("@");
                				//StrPAUser =strDocSplitUser[0];
                				StrPANUser=strDocSplitUser[2];
                				//StrADDUser =strDocSplitUser[1];
                				StrEMPUser=strDocSplitUser[6];
                				StrBNKUser=strDocSplitUser[4];
                				StrPCAUser=strDocSplitUser[0];
                				StrPPAUser=strDocSplitUser[1];
                				//StrBEUser=strDocSplitUser[6];
                				StrITRUser=strDocSplitUser[5];
                				StrPRAUser=strDocSplitUser[3];
                				StrOAPUser=strDocSplitUser[7];
                				StrBProfUser=strDocSplitUser[8];
							
							
                			}
							
							  /*  if(strcbscustflag=="Y")
							   		
						       {
						    		 alert("if");
						       
						    	document.forms[0].cmd_submit.disabled=false;	
						       	document.forms[0].cmd_cbs_create[0].disabled=true;

						       }
						       else
						       {
						    	   
						    	 alert("else");
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
            	        	
            	        	if(stremploy.equals("1"))
            	        	{
            	        		
            	        	}
            	        	else
            	        	{
            	        		
            	        	}
                	
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
                 					<td>Proof of Current Address </td>
                 					<td><input type="checkbox" name="chk_proofaddress" style='border=none' onclick="callcheck(<%=i%>);callcheckdate('PCA',<%=i%>)"></td>
                 					<input type="hidden" name="hid_proofcurrentaddrdate" value="<%=StrPCADate%>">
                 					<input type="hidden" name="hid_proofcurrentadduser" value="<%=StrPCAUser%>">
                 				
                 				</tr>
                 				<tr class="datagrid" > 
                 					<td>Proof of Permanent Address </td>
                 					<td><input type="checkbox" name="chk_proofaddress_perm" style='border=none' onclick="callcheck(<%=i%>);callcheckdate('PPA',<%=i%>)"></td>
                 					<input type="hidden" name="hid_prfaddrsdate" value="<%=StrPPADate%>">
                 					<input type="hidden" name="hid_prfaddrsuser" value="<%=StrPPAUser%>">
                 				
                 				</tr>
                 				<tr class="datagrid"> 
                 					<td>PAN/ID </td><td><input type="checkbox" name="chk_pan" style='border=none' onclick="callcheck(<%=i %>);callcheckdate('PAN',<%=i%>)"></td>
                 					<input type="hidden" name="hid_PANdate"value="<%=StrPANDate%>">
                 					<input type="hidden" name="hid_PANuser" value="<%=StrPANUser%>">
                 				
                 				</tr>
                 				
                 				
                 				
                 				<%-- <tr class="datagrid"> 
                 					<td>Business Existence </td><td><input type="checkbox" name="chk_busexst" style='border=none' onclick="callcheck(<%=i%>);callcheckdate('BE',<%=i%>)"></td>
                 				<input type="hidden" name="hid_BEdate"value="<%=StrBEDate%>">
                 					<input type="hidden" name="hid_BEuser" value="<%=StrBEUser%>">
                 				
                 				</tr> --%>
                 				
                 			</table>                 
                 		</td>
                 	
                 		<td>
                 			<table class="outertable">
                 			
                 			
                 			 
                 			 	<tr class="datagrid"> 
                 					<td>Current Address </td><td><input type="checkbox" name="chk_resedentailaddress" style='border=none' onclick="callcheck(<%=i %>);callcheckdate('PRA',<%=i%>)"></td>
                 					<input type="hidden" name="hid_PRAdate"value="<%=StrPRADate%>">
                 					<input type="hidden" name="hid_PRAuser" value="<%=StrPRAUser%>">
                 					</td>
                 				</tr>
                 				<tr class="datagrid"> 
                 					<td>Bank Statement </td><td><input type="checkbox" name="chk_bankstat" style='border=none' onclick="callcheck(<%=i%>);callcheckdate('BNK',<%=i%>)"></td>
                 				
                 					<input type="hidden" name="hid_bankdate" value="<%=StrBNKDate%>">
                 					<input type="hidden" name="hid_bankuser" value="<%=StrBNKUser%>"></td>
                 				</tr>
                 				
                 				<tr class="datagrid"> 
                 					<td>ITR </td><td><input type="checkbox" name="chk_itr" style='border=none' onclick="callcheck(<%=i%>);callcheckdate('ITR',<%=i%>)"></td>
                 					<input type="hidden" name="hid_ITRdate"value="<%=StrITRDate%>">
                 					<input type="hidden" name="hid_ITRuser" value="<%=StrITRUser%>">
                 				</tr>
                 				
                 				<%if(stremploy.equals("1") || stremploy.equals("11")){%>
                 				<%if(stremploy.equals("1") ){%>
                 				
                 				<tr class="datagrid"> 
                 					<td>Employment </td><td><input type="checkbox"  name="chk_employment" style='border=none' onclick="callcheck(<%=i%>);callcheckdate('EMP',<%=i%>)"></td>
                 				<input type="hidden" name="hid_empdate" value="<%=StrEMPDate%>">
                 				<input type="hidden" name="hid_empuser" value="<%=StrEMPUser%>">
                 					</td>
                 				</tr>
                 				<%} else { %>
                 				<td style="visibility:hidden;position: absolute">Employment </td><td><input type="checkbox" style="visibility:hidden;position: absolute" name="chk_employment" style='border=none' onclick="callcheck(<%=i%>);callcheckdate('EMP',<%=i%>)"></td>
                 				<input type="hidden" name="hid_empdate" value="<%=StrEMPDate%>">
                 				<input type="hidden" name="hid_empuser" value="<%=StrEMPUser%>">
                 				<%} %>
                 				<tr class="datagrid"> 
                 					<td style="visibility:hidden;position: absolute">Office Address </td><td><input type="checkbox" style="visibility:hidden;position: absolute" name="chk_officeaddress" checked="checked" style='border=none' onclick="callcheck(<%=i %>);callcheckdate('POA',<%=i%>)"></td>
                 					<input type="hidden" name="hid_POAdate"value="<%=Helper.getCurrentDateTime()%>">
                 					<input type="hidden" name="hid_POAuser" value="<%=strDocUserId%>">
                 				</tr>
                 				<tr class="datagrid"> 
                 					<td style="visibility:hidden;position: absolute">Business Proof</td><td><input type="checkbox" style="visibility:hidden;position: absolute" name="chk_busineess_proof" checked="checked" style='border=none' onclick="callcheck(<%=i %>);callcheckdate('BP',<%=i%>)"></td>
                 					<input type="hidden" name="hid_BProfdate"value="<%=Helper.getCurrentDateTime()%>">
                 					<input type="hidden" name="hid_BProfuser" value="<%=strDocUserId%>">
                 				
                 				</tr>
                 	
                 			<%} else { %>
                 			
                 				<tr class="datagrid"> 
                 					<td style="visibility:hidden;position: absolute">Employment </td><td><input type="checkbox" style="visibility:hidden;position: absolute" name="chk_employment" checked="checked" style='border=none' onclick="callcheck(<%=i%>);callcheckdate('EMP',<%=i%>)"></td>
                 				<input type="hidden" name="hid_empdate" value="<%=Helper.getCurrentDateTime()%>">
                 				<input type="hidden" name="hid_empuser" value="<%=strDocUserId%>">
                 					</td>
                 				</tr>
                 				
                 				<tr class="datagrid"> 
                 					<td>Office Address </td><td><input type="checkbox" name="chk_officeaddress"  style='border=none' onclick="callcheck(<%=i %>);callcheckdate('POA',<%=i%>)"></td>
                 					<input type="hidden" name="hid_POAdate"value="<%=StrOAPDate%>">
                 					<input type="hidden" name="hid_POAuser" value="<%=StrOAPUser%>">
                 				</tr>
                 				<tr class="datagrid"> 
                 					<td>Business Proof</td><td><input type="checkbox" name="chk_busineess_proof"  style='border=none' onclick="callcheck(<%=i %>);callcheckdate('BP',<%=i%>)"></td>
                 					<input type="hidden" name="hid_BProfdate"value="<%=StrBProfDate%>">
                 					<input type="hidden" name="hid_BProfuser" value="<%=StrBProfUser%>">
                 				
                 				</tr>
                 				<%} %>
                 				
                 			</table>
                 		</td>
                 		
                 		
                 		<%if(strcbsid.equalsIgnoreCase("NEW")) { %>
           					<%
           					if((strucicdedupeflag.equalsIgnoreCase("") || !strucicdedupeflag.equalsIgnoreCase("N"))&&(!strperapppannum.equalsIgnoreCase("") || !strperappaadhar.equalsIgnoreCase(""))){
           					 %>
           					<td><input type="hidden" name="hid_appid" value="<%=strperappid %>">
           					<input type="button" class="buttonPrint" name="cmd_cbs_create" value="UCIC Check" onclick="goUCICCheck(document.forms[0].hid_appid[<%=i%>].value)">
           					</td>
           					<%}else{ %>
           					<td><input type="hidden" name="hid_appid" value="<%=strperappid %>">
           					<input type="button" class="buttonPrint" name="cmd_cbs_create" value="Create CBS Customer ID" onclick="goCBScreate(document.forms[0].hid_appid[<%=i%>].value)">
           					</td><%} %>
           					
           			
           				
           				
           				<%} else 
           				{
           				
           					if((straddressflag.equals("Y")||strpanflag.equals("Y") || strpermaddressflag.equals("Y")) && strcbscustflag.equals("N"))
           					{
           					%>
           					<td><input type="hidden" name="hid_appid" value="<%=strperappid %>"><input type="button" class="buttonPrint" name="cmd_cbs_create" value="Update CBS Customer ID" onclick="goCBSupdate(document.forms[0].hid_appid[<%=i%>].value)"></td>
           					<%} 
           					else if(strKycPendFlag.equals("Y")||strFiPendFlag.equals("Y")|| strcbscustflag.equals("N"))
           					{ %>
                   					<td><input type="hidden" name="hid_appid" value="<%=strperappid%>"><input type="button" class="buttonPrint" name="cmd_cbs_create" value="Update" onclick="goCBSupdate(document.forms[0].hid_appid[<%=i%>].value)"></td>
           					<% }
           					else 
           					{ %>
           					<td><input type="hidden" name="hid_appid" value="<%=strperappid %>"><input type="hidden" name="cmd_cbs_create"> </td>
           					<% } }%>
	               
	               
	               	 <td align="left">	
	                	<table class="outertable">
	                		<%
	                		ArrayList arrtemp=new ArrayList();
	                		arrtemp=(ArrayList)arrCol.get(36);
	                		if(arrtemp.size()>0)
	                		{
	                			for(int j=0;j<arrtemp.size();j++)
	                			{
	                		%>
	                			<tr class="datagrid">
	                				<td valign="top"><%=j+1%>. </td>
	                				<td><%=arrtemp.get(j)%></td>
	                			</tr>
	                		<%
	                		}
	                		}
	                		%>	
	                		</table>
	                	</td>
	                	
	                	<td>
	                		<table class="outertable">
	                			<tr align="left" class="datagrid"> 
									<td>Hunter Score</td>
									<td align="center"> : <%=Helper.correctNull((String)arrCol.get(37)) %> &nbsp; </td>
								</tr>
								<tr align="left" class="datagrid"> 
									<td>Hunter Rule Match</td>
									<td align="center"> : <%=Helper.correctNull((String)arrCol.get(38)) %> &nbsp; </td>
								</tr>
								<tr align="left" class="datagrid"> 
									<td>Jocata Match</td>
									<td align="center"> :  <%=Helper.correctNull((String)arrCol.get(39)) %> &nbsp; </td>
								</tr>
								<tr align="left" class="datagrid"> 
									<td>CFR Match</td>
									<td align="center"> :  <%=Helper.correctNull((String)arrCol.get(40)) %> &nbsp; </td>
								</tr>
								<tr align="left" class="datagrid"> 
									<td>Thick Score</td>
									<td align="center"> :  <%=Helper.correctNull((String)arrCol.get(41)) %> &nbsp; </td>
								</tr>
								<tr align="left" class="datagrid"> 
									<td>Thin Score</td>
									<td align="center"> :  <%=Helper.correctNull((String)arrCol.get(42)) %> &nbsp; </td>
								</tr>
	                		</table>
	                	</td>    	
          	
	                	</tr>
       	
	                	
                	   <%  }   } %>
                	 
                	</table>
               </td>
    		</tr>
    		<tr>
    		
    	
    		
               </td>
    		</tr>
    		<br></br>
    		<tr>
     	<td valign="top" align="center" id="id_applicationdet_loantype"> 
        <table width="70%" border="1" cellspacing="1" cellpadding="3" class="outertable" align="center">
    		
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
                	String strdeviationflag=Helper.correctNull((String)hshValues.get("loan_Digi_deviation"));
                	if(strdeviationflag.equals("Y"))
                	{
                		strdeviationflag="Deviation Exist";
                	}
                	else
                	{
                		strdeviationflag="NA";
                	}
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
                	
                	<% if(!Helper.correctDouble((String)hshValues.get("LOAN_UPFRONTFEE")).equalsIgnoreCase("")
                			&& !Helper.correctDouble((String)hshValues.get("LOAN_UPFRONTFEE")).equalsIgnoreCase("0.00")){ %>
                	<tr align="left">
                		<td  bgcolor="#efefef" colspan="2" ><b>Upfront Fee</b></td>
                		<td align="right">Rs.<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("LOAN_UPFRONTFEE")) ))%></td>
                	</tr>
                	<%} %>
                	
                	<% if(!Helper.correctDouble((String)hshValues.get("LOAN_UPFRONTFEECOL")).equalsIgnoreCase("")
                			&& !Helper.correctDouble((String)hshValues.get("LOAN_UPFRONTFEECOL")).equalsIgnoreCase("0.00"))
                	{ %>
                	<tr align="left"> 
                		<td  bgcolor="#efefef" colspan="2" ><b>Upfront Fee Collected</b></td>
                		<td align="right">Rs.<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("LOAN_UPFRONTFEECOL")) ))%></td>
                	</tr>
                	<%} %>
                	
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
    </tr>
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
    
     <table width="70%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
			<tr id="recBranch">
				<td colspan="2">
				<table width="100%" border="0" cellspacing="0" cellpadding="10"
					class="outertable">
					<tr>
						<td><b>Recommendation by the Branch / CLPH</b></td>
						<td><textarea name="txt_recBranch" cols="150" rows="4" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("strBranchRec")) %></textarea></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr id="recHeadOffice">
				<td colspan="2">
				<table width="100%" border="0" cellspacing="0" cellpadding="10"
					class="outertable">
					<tr>
						<td><b>Recommendation by the Head Office</b></td>
						<td><textarea name="txt_recHeadOffice" cols="150" rows="4" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("strHeadOfficeRec")) %></textarea></td>
					</tr>
				</table>
				</td>
			</tr>
	</table>
    
    		<td> 
             	<table width="20%" border="0" cellspacing="0" align="center" cellpadding="3" class="outertable">
                <tr align="center"> 
<!--                	<td><input type="button" name="cmdClick" value="Deviations" class="buttonStyle"	title="Check Deviations" onClick="callDeviation('normal')"></td>-->
                		<td><input type="button" class="buttonOthers" name="cmd_save" value="Save" onclick="doSave()"></td>
                		<td ><input type="button" class="buttonOthers"  name="approval" value="Amber Approve" onclick="amberRule('APPROVED')"></td>
                		<td><input  type="button" class="buttonOthers"  name="rejected" value="Amber Reject"  onclick="amberRule('REJECTED')"></td> 
                		<td><input  type="button" class="buttonOthers"  name="undo" value="Amber Undo"  onclick="amberRule('UNDO')"></td> 
                		<!-- <td><input type="button" class="buttonOthers" name="cmd_submit" value="Submit" onclick="goSubmit()"> &nbsp;</td>
                		<td><input type="button" class="buttonClose" name="cmd_reject" value="Reject" onclick="doReject()"> &nbsp;</td> -->
                
                
                </tr>
                </table>
               </td>
         
    	</tr>
    </table>

	<br><br><br>



 <input type="hidden" name="chk_proofaddress">
 <input type="hidden" name="chk_pan">	
  <input type="hidden" name="chk_fiaddress">
  <input type="hidden" name="chk_employment">
  <input type="hidden" name="chk_bankstat">
   <input type="hidden" name="cmd_cbs_create">
   <input type="hidden" name="cmd_UCIC_Check">
   <input type="hidden" name="hid_appid">
   <input type="hidden" name="hid_hidborrowerid">
   
   <input type="hidden" name="chk_officeaddress"> 
  <input type="hidden" name="chk_resedentailaddress">
   <input type="hidden" name="chk_proofaddress_perm"> 
  <!-- <input type="hidden" name="chk_busexst"> -->
  <input type="hidden" name="chk_busineess_proof"> 
<!--   <input type="hidden" name="chk_proofaddress_office"> -->
  <input type="hidden" name="chk_itr">
 
   <input type="hidden" name="hid_appid">
 <input type="hidden" name="hid_prfaddrsdate">
 <input type="hidden" name="hid_prfaddrsuser">
 <input type="hidden" name="hid_proofcurrentaddrdate">
 <input type="hidden" name="hid_proofcurrentadduser">
 <input type="hidden" name="hid_PANdate">
 <input type="hidden" name="hid_PANuser">
<!-- <input type="hidden" name="hid_BEdate"> -->
 <input type="hidden" name="hid_BEuser">
 <input type="hidden" name="hid_ITRdate">
 <input type="hidden" name="hid_ITRuser">
 <input type="hidden" name="hid_PRAdate">
 <input type="hidden" name="hid_PRAuser">
 <input type="hidden" name="hid_POAdate">
 <input type="hidden" name="hid_POAuser">
 <input type="hidden" name="hid_BProfdate">
 <input type="hidden" name="hid_BProfuser">
 <input type="hidden" name="hid_fiaddressdate">
 <input type="hidden" name="hid_fiaddressuser">
 <input type="hidden" name="hid_empdate">
 <input type="hidden" name="hid_empuser">
 <input type="hidden" name="hid_bankdate">
 <input type="hidden" name="hid_bankuser">
 <input type="hidden" name="hidKYCChk">
 <input type="hidden" name="strcbscustflag">
 <input type="hidden" name="ucicEnable">
<!--  <input type="hidden" name="stremploy">   -->
     
<input type="hidden" name="hidborrowerid">
 <input type="hidden" name="approve">
   
    <input type="hidden" name="strucicdedupeflag">
   
<input type="hidden" name="cmdsave" disabled="disabled">
<input type="hidden" name="hid_approved_appid">
  <lapschoice:hiddentag pageid='<%=PageId%>'/>
</form>
</body>
</html>