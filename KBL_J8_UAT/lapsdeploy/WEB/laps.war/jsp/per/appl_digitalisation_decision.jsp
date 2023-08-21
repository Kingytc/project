<%@include file="../share/directives.jsp"%>
<%
	ArrayList arrRow= new ArrayList();
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
 arrRow=(ArrayList)hshValues.get("cibilarrrow");

java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
nf.setMinimumFractionDigits(2);
nf.setMaximumFractionDigits(2);
nf.setGroupingUsed(false);
String strProductType=Helper.correctNull((String)hshValues.get("strProductType"));
String strappstatus=Helper.correctNull((String)hshValues.get("strappstatus"));
String strDocUserId=Helper.correctNull((String)hshValues.get("strUserId"));
String strorglevel=Helper.correctNull((String)hshValues.get("strOrgLevel"));
session.setAttribute("sessionModuleType","DIGI");
String appstatus=Helper.correctNull((String)hshValues.get("appstatus"));
String branchcode=Helper.correctNull((String)hshValues.get("strOrgShortCode"));
String applholder =  Helper.correctNull(request.getParameter("appholder"));
String digiGoldFlag = Helper.correctNull((String) session.getAttribute("digiGoldFlag"));
boolean check=true;
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
var varProductType="<%=strProductType%>";
var varappstatus="<%=strappstatus%>";
var sysdate="<%=Helper.getCurrentDateTime()%>";
var strDocUserId="<%=strDocUserId%>";
var strorglevel="<%=strorglevel%>";
var appstatus="<%=appstatus%>";
var branchcode="<%=branchcode%>";
var varapplholder="<%=applholder%>";
var varstrusrid='<%=Helper.correctNull((String) session.getAttribute("strUserId"))%>';

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
	 
		if(varappstatus=="pa")
		{
		//	document.forms[0].cmd_submit.disabled=true;
			document.forms[0].cmd_save.disabled=true;
		//	document.forms[0].cmd_reject.disabled=true;	
		
		}
		if(varappstatus=="pr")
		{
		//	document.forms[0].cmd_reject.disabled=true;
			document.forms[0].cmd_save.disabled=true;
			//document.forms[0].cmd_submit.disabled=true;

		}


		if(strcbscustflag=="Y")
		{
			//document.forms[0].cmd_submit.disabled=false;
			document.forms[0].cmd_cbs_create[0].disabled=true;
		}
		else
		{
  			//document.forms[0].cmd_submit.disabled=true;
			//document.forms[0].cmd_cbs_create[0].disabled=false;
		}



	//organisation check
	if(strorglevel=="C")
	{
		//checkbox
			document.forms[0].chk_proofaddress[0].disabled=true;
			document.forms[0].chk_mendateemi[0].disabled=true;
			document.forms[0].chk_fiaddress[0].disabled=true;
			document.forms[0].chk_pan[0].disabled=true;
			
		//dropdown
		if(!document.forms[0].sel_add.disabled)
			document.forms[0].sel_add.disabled=false;
		if(!document.forms[0].sel_employment.disabled)
			document.forms[0].sel_employment.disabled=false;
		if(!document.forms[0].sel_bankstat.disabled)	
			document.forms[0].sel_bankstat.disabled=false;


		if(document.forms[0].sel_bankstat.value=="4" || document.forms[0].sel_bankstat.value=="5"){
			document.forms[0].sel_bankstat.disabled=true;

		}if(document.forms[0].sel_add.value=="4" || document.forms[0].sel_add.value=="5"){ 
			document.forms[0].sel_add.disabled=true;

		}if(document.forms[0].sel_employment.value=="4" || document.forms[0].sel_employment.value=="5"){ 
			document.forms[0].sel_employment.disabled=true;
		}
		//cbs button
		
		 if((varaddressflag=="Y"||varpanflag=="Y" || varpermaddressflag=="Y")&& strcbscustflag=="N")
		 { 	
			document.forms[0].cmd_cbs_create[0].disabled=true;	
		 }
		 else
		 {
		 if((strKycPendFlag=="Y"|| strFiPendFlag=="Y"||strEManPendFlag=="Y"|| strcbscustflag=="N")&& !(strcbscust==""||strcbscust.equalsIgnoreCase("NEW")))
		document.forms[0].cmd_cbs_create[0].disable=false;
		else
		document.forms[0].cmd_cbs_create[0].disabled=true;
		 }
	
		
		
		

	}
	else if (strorglevel=="A")
	{
		//checkbox
		if(!document.forms[0].chk_proofaddress[0].disabled)
			document.forms[0].chk_proofaddress[0].disabled=false;
		if(!document.forms[0].chk_mendateemi[0].disabled)
			document.forms[0].chk_mendateemi[0].disabled=false;
		if(!document.forms[0].chk_fiaddress[0].disabled)	
			document.forms[0].chk_fiaddress[0].disabled=false;
		if(!document.forms[0].chk_pan[0].disabled)
			document.forms[0].chk_pan[0].disabled=false;
		//dropdown
			
			document.forms[0].sel_add.disabled=true;
			document.forms[0].sel_employment.disabled=true;
			document.forms[0].sel_bankstat.disabled=true;	
		
		//cbs button
			//document.forms[0].cmd_cbs_create[0].disabled=false;
	}
	else 
	{
		//checkbox
			document.forms[0].chk_proofaddress[0].disabled=false;
			document.forms[0].chk_mendateemi[0].disabled=false;
			document.forms[0].chk_fiaddress[0].disabled=false;
			document.forms[0].chk_pan[0].disabled=false;
			
		//dropdown
			document.forms[0].sel_add.disabled=true;
			document.forms[0].sel_employment.disabled=true;
			document.forms[0].sel_bankstat.disabled=true;
		
		//cbs button
			//document.forms[0].cmd_cbs_create[0].disabled=false;
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
	
		<%
		String StrPAVal="",StrPANVal="",StrADDVal="",StrEMPVal="",StrBNKVal="",StrMNDTVal="";
		 if(arrRow.size()>0 && arrRow!=null) 
	      {
				String strcbsid="";
	         for(int i=0;i<arrRow.size();i++)
	         {
	         arrCol=(ArrayList)arrRow.get(i);
	         String strDocVal=Helper.correctNull((String)arrCol.get(14));
	         strcbsid=Helper.correctNull((String)arrCol.get(1));
	         
	         if((strcbsid.equalsIgnoreCase("NEW")|| strcbsid.equalsIgnoreCase("")))
		        { %>
		        	document.forms[0].chk_photograph.disabled=false;
		        	document.forms[0].chk_photograph.checked=false;
		        	document.forms[0].chk_specimen.disabled=false;
		        	document.forms[0].chk_specimen.checked=false;
		        	<% }
		        else 
		        {
		        	%>
		        	document.forms[0].chk_photograph.disabled=true;
	        		document.forms[0].chk_photograph.checked=true;
	        		document.forms[0].chk_specimen.disabled=true;
		        	document.forms[0].chk_specimen.checked=true;
		  		 <%   } 
	         
 			 if(!strDocVal.equalsIgnoreCase(""))
 			 {
				String[] strDocSplitVal=strDocVal.split("@");
				StrPAVal=strDocSplitVal[0];
				StrPANVal=strDocSplitVal[2];
				StrADDVal=strDocSplitVal[1];
				
				StrMNDTVal=strDocSplitVal[3];
 			 }
 			 
 			
 			 
 			String straddressflag=Helper.correctNull((String)arrCol.get(4));
	        String strpermaddressflag=Helper.correctNull((String)arrCol.get(21));
	        String strpanflag=Helper.correctNull((String)arrCol.get(5));
	       	String strfiaddress=Helper.correctNull((String)arrCol.get(6));
	        String strfiemp=Helper.correctNull((String)arrCol.get(7));
	        String strfibankstat=Helper.correctNull((String)arrCol.get(8));
	        String stremandate=Helper.correctNull((String)arrCol.get(22));
	        String strcbscustflag=Helper.correctNull((String)arrCol.get(23));
	        String strKycPendFlag=Helper.correctNull((String)arrCol.get(24));
	        String strFiPendFlag=Helper.correctNull((String)arrCol.get(25));
	        String strEManPendFlag=Helper.correctNull((String)arrCol.get(26));
	        
	        
	         if(straddressflag.equalsIgnoreCase("N"))
	 		{%>
	        	
	 		document.forms[0].chk_proofaddress[<%=i%>].checked=true;
	 		document.forms[0].chk_proofaddress[<%=i%>].disabled=true;
	 	
			 <%}
	 		
	         else
	 		{%>
	   		
	 		document.forms[0].chk_proofaddress[<%=i%>].checked=false;	
	 			<%}

	         
	         if(strpermaddressflag.equalsIgnoreCase("N"))
		 		{%>
		        	
		 		document.forms[0].chk_fiaddress[<%=i%>].checked=true;
		 		document.forms[0].chk_fiaddress[<%=i%>].disabled=true;
		 	
		        	 <%}
		 		else
		 		{%>
		   		
		 		document.forms[0].chk_fiaddress[<%=i%>].checked=false;	
		 		<%}

	         
	         if(strpanflag.equalsIgnoreCase("N"))
		 		{%>
		        
		 		document.forms[0].chk_pan[<%=i%>].checked=true;
				document.forms[0].chk_pan[<%=i%>].disabled=true;
		 	

		        	 <%}
		 		else
		 		{%>
		   		
		 		document.forms[0].chk_pan[<%=i%>].checked=false;	
		 		
		 		<%}
	         
	         
	         if(stremandate.equalsIgnoreCase("N"))
		 		{%>
		        	
		 		document.forms[0].chk_mendateemi[<%=i%>].checked=true;
				document.forms[0].chk_mendateemi[<%=i%>].disabled=true;
		 	
		    

		        	 <%}
		 		else
		 		{%>
		   		
		 		document.forms[0].chk_mendateemi[<%=i%>].checked=false;
		 		
		 		<%}
	         
	         
 			 if(StrPAVal.equalsIgnoreCase("PAC")){%>
      			document.forms[0].chk_proofaddress[<%=i%>].checked=true;
				document.forms[0].chk_proofaddress[<%=i%>].disabled=true;
	       <%}if(StrPANVal.equalsIgnoreCase("PAN")){%>    
	        	document.forms[0].chk_pan[<%=i%>].checked=true;
				document.forms[0].chk_pan[<%=i%>].disabled=true;
			<%}if(StrADDVal.equalsIgnoreCase("PAP")){%>    
	        	document.forms[0].chk_fiaddress[<%=i%>].checked=true;
				document.forms[0].chk_fiaddress[<%=i%>].disabled=true;
			<%}
			
			
			
			if(StrMNDTVal.equalsIgnoreCase("EMAN")){%>    
       			document.forms[0].chk_mendateemi[<%=i%>].checked=true;
				document.forms[0].chk_mendateemi[<%=i%>].disabled=true;	
      	   <%} %>
      	   
	       strcbscustflag="<%=strcbscustflag%>";
	       document.forms[0].sel_add.value="<%=Helper.correctNull((String)arrCol.get(17))%>";
	       document.forms[0].sel_employment.value="<%=Helper.correctNull((String)arrCol.get(18))%>";
	       document.forms[0].sel_bankstat.value="<%=Helper.correctNull((String)arrCol.get(19))%>";
	      
	       
	  	   document.forms[0].hid_sel_add.value="<%=Helper.correctNull((String)arrCol.get(17))%>";
	       document.forms[0].hid_sel_employment.value="<%=Helper.correctNull((String)arrCol.get(18))%>";
	       document.forms[0].hid_sel_bankstat.value="<%=Helper.correctNull((String)arrCol.get(19))%>";

	       var varfiaddress="<%=Helper.correctNull((String)arrCol.get(17))%>";
	       var varfiemp="<%=Helper.correctNull((String)arrCol.get(18))%>";
	       var varfibankstat="<%=Helper.correctNull((String)arrCol.get(19))%>";
	       
	       document.forms[0].hid_FIPEND_FLAG.value="<%=Helper.correctNull((String)arrCol.get(25))%>";
	       document.forms[0].hid_KYCPEND_FLAG.value="<%=Helper.correctNull((String)arrCol.get(24))%>";
	       document.forms[0].hid_EMANPEND_FLAG.value="<%=Helper.correctNull((String)arrCol.get(26))%>";
	       document.forms[0].strcbscustflag.value="<%=Helper.correctNull((String)arrCol.get(23))%>";
 		   var strKycPendFlag="<%=Helper.correctNull((String)arrCol.get(24))%>";
 		   var strFiPendFlag="<%=Helper.correctNull((String)arrCol.get(25))%>";
 	 	   var strEManPendFlag="<%=Helper.correctNull((String)arrCol.get(26))%>";
 	 	   var strcbscustflag="<%=Helper.correctNull((String)arrCol.get(23))%>";		   
 	 	   var strcbscust="<%=Helper.correctNull((String)arrCol.get(1))%>";
 	 	   var varaddressflag="<%=Helper.correctNull((String)arrCol.get(4))%>";
	       var  varpermaddressflag="<%=Helper.correctNull((String)arrCol.get(21))%>";
	      	var   varpanflag="<%=Helper.correctNull((String)arrCol.get(5))%>";
	       	
	       <%	
	         
      	 if(strfiaddress.equalsIgnoreCase("N"))
	 		{%>
	 			document.forms[0].sel_add.disabled=true;
	 			document.forms[0].sel_add.value="4";
	        <%}
	 		else
	 		{%>
	 		if(strorglevel=="C" && (varfiaddress==4 || varfiaddress==5))
	 		{
	 			document.forms[0].sel_add.disabled=true;
	 		}
	 		else{
	 			if(strorglevel=="C"){
		 			document.forms[0].sel_add.disabled=false;
			 		}else{
			 			document.forms[0].sel_add.disabled=true;
			 		}
	 		}
	 		<%}
       
       
     	 	 if(strfiemp.equalsIgnoreCase("N"))
			{%>
				document.forms[0].sel_employment.disabled=true;
				document.forms[0].sel_employment.value="4";
      	 <%}
	 		else
	 		{%>
	 		if(strorglevel=="C" && (varfiemp==4 || varfiemp==5))
	 		{
	 			document.forms[0].sel_employment.disabled=true;
	 		}else{
	 			if(strorglevel=="C"){
		 			document.forms[0].sel_employment.disabled=false;
			 		}else{
			 			document.forms[0].sel_employment.disabled=true;
			 		}
	 		}
	 		<%}
       
      	 if(strfibankstat.equalsIgnoreCase("N"))
	 		{%>
	 			document.forms[0].sel_bankstat.disabled=true;
	 			document.forms[0].sel_bankstat.value="4";
      	 <%}
	 		else
	 		{%>
	 		if(strorglevel=="C" && (varfibankstat==4 || varfibankstat==5))
	 		{
	 			document.forms[0].sel_bankstat.disabled=true;
	 		}else{
		 		if(strorglevel=="C"){
	 			document.forms[0].sel_bankstat.disabled=false;
		 		}else{
		 			document.forms[0].sel_bankstat.disabled=true;
		 		}
	 		}
	 		<%}
	
      		 if(strKycPendFlag.equalsIgnoreCase("N") && strFiPendFlag.equalsIgnoreCase("N") 
     	    	&& strEManPendFlag.equalsIgnoreCase("N")&& strcbscustflag.equalsIgnoreCase("N"))
     	        {%>
     	        document.forms[0].cmd_cbs_create[<%=i%>].disabled=false;
     	      	 
     	        <%}
     	        
     	     else
     	     {%>
     	      document.forms[0].cmd_cbs_create[<%=i%>].disabled=true;
     	     <%}%>
      		 <%
      		 if(Helper.correctNull((String)arrCol.get(27)).equals("on"))
      		 {
      			 %>
      			 
      				document.forms[0].chk_photograph.disabled=true;
	        		document.forms[0].chk_photograph.checked=true;
	        
      		<%	 }
      		 
      		if(Helper.correctNull((String)arrCol.get(28)).equals("on")) 
      		{ %>
      				document.forms[0].chk_specimen.disabled=true;
        			document.forms[0].chk_specimen.checked=true;
      		<%	}
      		if(Helper.correctNull((String)arrCol.get(29)).equals("on")) 
      		{ %>
      				document.forms[0].chk_physicalcompleted.disabled=true;
        			document.forms[0].chk_physicalcompleted.checked=true;
      		<%	}
        	 
      	
		
	          } %>
	          
	         <%	
		     	if(!(Helper.correctNull((String)arrCol.get(29)).equals("on")))
				{ %>
				
				document.forms[0].chk_physicalcompleted.disabled=false;
				
				 <%}else { %>
				document.forms[0].chk_physicalcompleted.disabled=true;			
				<%}%>   
				
			<%}%>

	     	
	     	
        	// callcheck();

		//submit button
		
		
		<%-- 
	      
		if( (straddressflag.equals("Y") && !StrPAVal.equalsIgnoreCase("PAC")) ||  (strpermaddressflag.equals("Y") && !StrADDVal.equalsIgnoreCase("PAP")) ||
	        	 (strpanflag.equals("Y") && !StrPANVal.equalsIgnoreCase("PAN")) || (stremandate.equals("Y") && !StrMNDTVal.equalsIgnoreCase("EMAN"))
	      			
	         	)
	         {
	        	  %>
	      			document.forms[0].cmd_cbs_create[<%=i%>].disabled=true;

	       <%  }
	         else
	         {
	        	 %>
	      			document.forms[0].cmd_cbs_create[<%=i%>].disabled=false;

	     	  <%  }
	         	if(strcbscustflag.equals("") || strcbscustflag.equals("Y") )
	         	{ %>
	         			varcbscustflag="Y";
		      			document.forms[0].cmd_cbs_create[<%=i%>].disabled=false;
	     	  	<% }
	         	else
	         	{ %>
     					varcbscustflag="N";
    	      			document.forms[0].cmd_cbs_create[<%=i%>].disabled=true;
	       	    <% }
		
		
		 --%>
		
	
		
}


function onChangeEmpl()
{

	
     
     if(document.forms[0].sel_employment.value<document.forms[0].hid_sel_employment.value)
    	 {
    	 document.forms[0].sel_employment.value=document.forms[0].hid_sel_employment.value;
    	 }
		
    

}

function onChangeAdd()
{
	if(document.forms[0].sel_add.value<document.forms[0].hid_sel_add.value)
	{
	
	document.forms[0].sel_add.value=document.forms[0].hid_sel_add.value;
	
	}
	
	}
	
	
	function onChangeBnkStmnt()
	{
		
		 if( document.forms[0].sel_bankstat.value<document.forms[0].hid_sel_bankstat.value)
				
			{
				document.forms[0].sel_bankstat.value=document.forms[0].hid_sel_bankstat.value;
			}

		
		
	}

/* function callcheck(row)
{
	if(document.forms[0].chk_proofaddress[row].checked==true &&  document.forms[0].chk_pan[row].checked==true &&
		document.forms[0].chk_fiaddress[row].checked==true && document.forms[0].chk_employment[row].checked==true && document.forms[0].chk_bankstat[row].checked==true && document.forms[0].chk_mendateemi[row].checked==true)
	{
		document.forms[0].cmd_cbs_create[row].disabled=false;
	}
	else
	{
		document.forms[0].cmd_cbs_create[row].disabled=true;
	}
	
} */
//boolean check=true;
function callcheck(row)
{
	if(document.forms[0].chk_proofaddress[0].checked==true &&  document.forms[0].chk_pan[0].checked==true &&
		document.forms[0].chk_fiaddress[0].checked==true  && document.forms[0].chk_mendateemi[0].checked==true )
		
	{	//&& document.forms[0].sel_add.value==null && document.forms[0].sel_employment.value==null && document.forms[0].sel_bankstat.value==null
	
		
		//document.forms[0].cmd_cbs_create[0].disabled=false;
		//document.forms[0].cmd_submit[0].disabled=false;
	}
	else
	{
		document.forms[0].cmd_cbs_create[0].disabled=true;
		//document.forms[0].cmd_submit[0].disabled=true;
	} 	
	 
}





function goSubmit()
{
	document.forms[0].hidAction.value="Submit";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidBeanMethod.value="updateSanctionDetails";
	document.forms[0].hidBeanGetMethod.value="getDigiDecisionDetail";
	document.forms[0].hidBeanId.value="DigitalAppInterface";
	document.forms[0].hidSourceUrl.value="/action/appl_digitalisation_decision.jsp";
	document.forms[0].submit();
}
function doReject()
{

	document.forms[0].hidAction.value="reject";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidBeanMethod.value="updateSanctionDetails";
	document.forms[0].hidBeanGetMethod.value="getDigiDecisionDetail";
	document.forms[0].hidBeanId.value="DigitalAppInterface";
	document.forms[0].hidSourceUrl.value="/action/appl_digitalisation_decision.jsp";
	document.forms[0].submit();
}

function goCBSupdate(appid)
{
	document.forms[0].hidborrowerid.value=appid;
	document.forms[0].hidBeanId.value="DigitalAppInterface";
	document.forms[0].hidBeanGetMethod.value="cbsIdModificationService";
	document.forms[0].action=appURL+"action/appl_digitalisation_decision.jsp";
	document.forms[0].submit();
	
	document.getElementById("form_blur").style.visibility="visible";
	document.getElementById("progress").style.visibility="visible";
}
function callcheckdate(val,row)
{
	if(val=="PAC")
	{
		if(document.forms[0].chk_proofaddress[row].checked==true)
		{
			document.forms[0].hid_prfadd[row].value=sysdate;
			document.forms[0].hid_prfadduser[row].value=strDocUserId;
		}
		else if(document.forms[0].chk_proofaddress[row].checked==false)
		{
			document.forms[0].hid_prfadd[row].value="";
			document.forms[0].hid_prfadduser[row].value="";
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
	if(val=="PAP")
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
		
	}
	/* if(val=="EMP")
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
	if(val=="BNK")
	{
		if(document.forms[0].chk_bankstat[row].checked==true)
		{
			document.forms[0].hid_bankdate[row].value=sysdate;
			document.forms[0].hid_bankuser[row].value=strDocUserId;
		}
		else if(document.forms[0].chk_mendateemi[row].checked==false)
		{
			document.forms[0].hid_bankdate[row].value="";
			document.forms[0].hid_bankuser[row].value="";
		}
	}
	 */
	if(val=="EMAN")
		
		{
		
		if(document.forms[0].chk_mendateemi[row].checked==true)
		{
			document.forms[0].hid_mendate[row].value=sysdate;
			document.forms[0].hid_menduser[row].value=strDocUserId;
		}
		else if(document.forms[0].chk_mendateemi[row].checked==false)
		{
			document.forms[0].hid_mendate[row].value="";
			document.forms[0].hid_menduser[row].value="";
		}
		
		}

}
function goCBScreate(appid)
{
	document.forms[0].hidborrowerid.value=appid;
	document.forms[0].hidBeanId.value="DigitalAppInterface";
	document.forms[0].hidBeanGetMethod.value="cbsIDCreationService";
	document.forms[0].action=appURL+"action/appl_digitalisation_decision.jsp";
	document.forms[0].submit();
	
	document.getElementById("form_blur").style.visibility="visible";
	document.getElementById("progress").style.visibility="visible";
}





function doSave()
{
    var varproofchk="",varKYCchk="",docdate="",docPANdate="",DocPAUser="",DocPANUser="";
    var DocAddDate="",DocAddUser="";
    var DocEmpDate="",DocEmpUser="";
    var DocBankDate="",DocBankUser="";
    var DocMenDate="", DocMendUser="";
    var photograph="N";
    var arrSize="<%=arrRow.size()%>";

    
    
    
    <%if(arrRow.size()>0 && arrRow!=null) 
	{
		for(int i=0;i<arrRow.size();i++)
		{
			arrCol=(ArrayList)arrRow.get(i);
    %>
   		   varproofchk="";
   		   var appid="";
   		   
   			   appid=document.forms[0].hid_lapsappid[<%=i%>].value;
	           docdate=document.forms[0].hid_prfadd[<%=i%>].value;
	           docPANdate=document.forms[0].hid_PANdate[<%=i%>].value;
	           DocPAUser=document.forms[0].hid_prfadduser[<%=i%>].value;
	           DocPANUser=document.forms[0].hid_PANuser[<%=i%>].value;
	           DocAddDate=document.forms[0].hid_fiaddressdate[<%=i%>].value;
	           DocAddUser=document.forms[0].hid_fiaddressuser[<%=i%>].value;
	           DocEmpDate=document.forms[0].hid_empdate[<%=i%>].value;
	           DocEmpUser=document.forms[0].hid_empuser[<%=i%>].value;
	           DocBankDate=document.forms[0].hid_bankdate[<%=i%>].value;
	           DocBankUser=document.forms[0].hid_bankuser[<%=i%>].value;
	           DocMenDate=document.forms[0].hid_mendate[<%=i%>].value;
	           DocMenUser=document.forms[0].hid_menduser[<%=i%>].value;
	          	
	           if(document.forms[0].chk_proofaddress[<%=i%>].checked==true)
	           {
	               if(varproofchk=="")
	               {
	            	   varproofchk=appid+"@PAC@"+docdate+" @"+DocPAUser+" @";
	               }
	           }
	           else
	           {
	        	   varproofchk=appid+"@ @ @ @";
	           }
	           
	           if(document.forms[0].chk_fiaddress[<%=i%>].checked==true) 
	           {
	            	varproofchk=varproofchk+"PAP@"+DocAddDate+" @"+DocAddUser+" @";
	           }
	           else
	           {
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
	          
	         <%--   if(document.forms[0].chk_employment[<%=i%>].checked==true) 
	           {
	            	varproofchk=varproofchk+"EMP@"+DocEmpDate+"@"+DocEmpUser+"@";
	           }
	           else
	           {
	        	   varproofchk=varproofchk+" @ @ @";
	           }
	           if(document.forms[0].chk_bankstat[<%=i%>].checked==true) 
	           {
	            	varproofchk=varproofchk+"BNK@"+DocBankDate+"@"+DocBankUser+"@";
	           }
	           else
	           {
	        	   varproofchk=varproofchk+" @ @ @";
	           }
	           --%> 
	          
	           if(document.forms[0].chk_mendateemi[<%=i%>].checked==true) 
	           {
	            	varproofchk=varproofchk+"EMAN@"+DocMenDate+" @"+DocMenUser+" @";
	           }
	           else
	           {
	        	   varproofchk=varproofchk+" @ @ @";
	           }
	           
	           
	           
	           if(varKYCchk==""){
	          	 varKYCchk=varproofchk+"~";
	           }
	           else{
	        	   varKYCchk=varKYCchk+varproofchk+"~";
	           }
   		   
               
    <%}}%>


    <% 
	  String strchkphysicalcompletedMC="";
	  if(arrRow.size()>0 && arrRow!=null) 
  {
   for(int al=0;al<arrRow.size();al++)
   {
   arrCol=(ArrayList)arrRow.get(al);
   strchkphysicalcompletedMC=Helper.correctNull((String)arrCol.get(29));
   if(strchkphysicalcompletedMC.equals("MC")){
   %>
   if(document.forms[0].chk_physicalcompleted.checked==false)
       {
       alert("Please Confirm the Borrower financial Status is Good");
      // return;
       }
   <% }}} %>
	//enabling fields
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=false;
		}
		if(document.forms[0].elements[i].type=='checkbox')
		{
			document.forms[0].elements[i].disabled=false;
		}
	}

	
    document.forms[0].hidKYCChk.value=varKYCchk;
    document.forms[0].hidAction.value="Save";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidBeanMethod.value="updateSanctionDetails";
	document.forms[0].hidBeanGetMethod.value="getDigiDecisionDetail";
	document.forms[0].hidBeanId.value="DigitalAppInterface";
	document.forms[0].hidSourceUrl.value="/action/appl_digitalisation_decision.jsp";
	document.forms[0].submit();
	document.getElementById("form_blur").style.visibility="visible";
	document.getElementById("progress").style.visibility="visible";

}



</script>
</head>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<body onload="onload()">
<div id="progress" style="position:absolute; width:106px; visibility:hidden; height:19px; z-index:9999999; left: 550px; top: 250px">
<img src="<%=ApplicationParams.getAppUrl()%>img/processing2.gif"></div>
<div class="overlay" id="form_blur" style="position:absolute; visibility:hidden;"></div>

<form name="appform" method="post" action="" class="normal">
<%if(digiGoldFlag.equals("PJ")){ %>
        <jsp:include page="../share/Applurllinkper.jsp" flush="true">
			<jsp:param name="pageid" value="1" />
		</jsp:include>
       <%}else{ %>
	<jsp:include page="../per/applicantTabDigi.jsp" flush="true"> 
             			<jsp:param name="linkid" value="77" />
                        </jsp:include><br>
<%} %>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr>
    <%if(digiGoldFlag.equals("PJ")){ %>
        <td class="page_flow">Home -&gt; Digi Retail -&gt; Application -&gt; Loan Particulars -&gt; Decision</td>
       <%}else{ %>
		   <td class="page_flow">Home -&gt; Digi Retail -&gt; Application -&gt; Loan Particulars -&gt; Decision</td>
		   <%} %>
    </tr>
  </table>
  <lapschoice:application />
  <%if(digiGoldFlag.equals("PJ")){ %>
	<jsp:include page="../per/applicanttab.jsp" flush="true">
					<jsp:param name="linkid" value="77" />
				</jsp:include><br>
<%}else{ %>
	<jsp:include page="../per/applicantTabDigi.jsp" flush="true"> 
             			<jsp:param name="linkid" value="77" />
                        </jsp:include><br>
<%} %>
  <table width="100%" border="0" cellspacing="1" cellpadding="3"  align="center" class="outertable">
   			<tr>
    			<td> 
             	 	<table width="80%" border="0" cellspacing="0" align="center" cellpadding="3" class="outertable">
                	<tr align="center"> 
                		<%if(appstatus.equalsIgnoreCase("Open/Pending") || appstatus.equalsIgnoreCase("op")){%>
                		<td><span style="font-size: 18px;"> Status of Application - <B><span style="color: #7a4d98"> In-Principle Sanction </span> </B>  </span></td>
                		<% }else {%>
                		  <td><span style="font-size: 18px;"> Status of Application - <B><span style="color: #7a4d98"> <%=appstatus%> </span> </B>  </span></td>
                		<% }%>
                	</tr>
                	</table>
               </td>
    		</tr>
    	<tr>
                <%
                	String StrPADate="",StrPANDate="";
                	String StrPAUser="",StrPANUser="";
                	String StrADDDate="",StrADDUser="";
                	String StrEMPDate="",StrEMPUser="";
                	String StrBNKDate="",StrBNKUser="";
                	String StrMENDate="",StrMENUser="";	
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
                			String strDocDate=Helper.correctNull((String)arrCol.get(15));
                			String strDocUser=Helper.correctNull((String)arrCol.get(16));
                			String strbank_name=Helper.correctNull((String)arrCol.get(12));
                		    String stracc_no=Helper.correctNull((String)arrCol.get(13));
                			String strpermaddressflag=Helper.correctNull((String)arrCol.get(18));
                			String strKycPendFlag=Helper.correctNull((String)arrCol.get(24));
                			String strcbscustflag=Helper.correctNull((String)arrCol.get(23));
                			String strFiPendFlag=Helper.correctNull((String)arrCol.get(25));
                			String strEManPendFlag=Helper.correctNull((String)arrCol.get(26));
                			//String strCbsCustFlag=Helper.correctNull((String)arrCol.get(33));
                			
                			if(!strDocDate.equalsIgnoreCase(""))
                			{
								String[] strDocSplitDate=strDocDate.split("@");
								StrPADate=strDocSplitDate[0];	
								StrPANDate=strDocSplitDate[2];
								StrADDDate=strDocSplitDate[1];
                				StrMENDate=strDocSplitDate[3];
                			}
                			if(!strDocUser.equalsIgnoreCase(""))
                			{
                				String[] strDocSplitUser=strDocUser.split("@");
                				StrPAUser =strDocSplitUser[0];
                				StrPANUser=strDocSplitUser[2];
                				StrADDUser =strDocSplitUser[1];
                				StrMENUser=strDocSplitUser[3];
                			}
                			String strappdesc="";
            	        	if(strAppType.equals("a"))
            	        		strappdesc="Applicant - "+strAppName;
            	        	else 
            	        		strappdesc="CoApplicant - "+strAppName;
                	
                	%>
                	
                	<table width="60%" border="0" cellspacing="1" align="center" cellpadding="3" class="outertable">
                	<tr align="center" class="dataHeader"> 
                		<td width="40%">Borrower Details </td>
                		<td width="30%">CBSID </td>
                		<td width="30%">CIBIL Score </td>
                		
                	</tr>	
                	<tr align="center" class="datagrid"> 
                		<td style="padding-right: 5px;"><%=strappdesc %> </td>
                		
                	 <%if(strcbsid.equalsIgnoreCase("NEW")){%>
                		<td> <span style="color: green;"><%=strcbsid %> </span> </td>
                 	<%} else { %>	
                 	    <td> <span > <input type="hidden" name="hid_cbsid"> <%=strcbsid %> </span> </td>
                 	<%} %>
                 	
                 		<td><input type="hidden" name="hid_lapsappid" value="<%=strperappid %>"><%=strCibilscore %></td>
                 		
                 	 
                 	 </tr>
    		<tr>
    			<td> <td>
    		</tr>
    		<tr>
    			<td> <td>
    		</tr>
                 		 
                	
                	</table>
             
    		
    		
    		<table width="60%" border="0" cellspacing="1" align="center" cellpadding="3" class="outertable"> 
    		<tr align="center" class="dataHeader">
    			<td width="33%" >KYC CheckList</td>
    			<td width="33%"> Other Documents </td>
    			<td width="33%"> Mandate </td>
    			
    		</tr>
    		<tr class="datagrid"> 
    			<td align="center">
 			    	<table width="80%" border="0" cellspacing="1" align="center" cellpadding="3" class="outertable"> 
    					<tr class="datagrid"> 
    						<td width="50%">Proof of Address (Current) </td>
    						<td><input type="checkbox" name="chk_proofaddress" style='border=none' onclick="callcheck(<%=i%>);callcheckdate('PAC',<%=i%>) ">
			                <input type="hidden" name="hid_prfadd" value="<%=StrPADate%>">
			               <input type="hidden" name="hid_prfadduser" value="<%=StrPAUser%>">
			           		 </td>
    					</tr>
    					<tr class="datagrid">
			    		 	<td width="50%" >Proof of Address (Permanent)</td>
			    		 	<td><input type="checkbox" name="chk_fiaddress" style='border=none' onclick="callcheck(<%=i%>);callcheckdate('PAP',<%=i%>)">
			                <input type="hidden" name="hid_fiaddressdate" value="<%=StrADDDate%>">
			               <input type="hidden" name="hid_fiaddressuser" value="<%=StrADDUser%>">
			                </td>
               			</tr>
    					<tr class="datagrid">
               				<td width="50%">PAN/ID</td>
               				<td><input type="checkbox" name="chk_pan" style='border=none' onclick="callcheck(<%=i%>);callcheckdate('PAN',<%=i%>)">
               					<input type="hidden" name="hid_PANdate"value="<%=StrPANDate%>">
               					<input type="hidden" name="hid_PANuser" value="<%=StrPANUser%>">
              				</td>
               			
               			</tr>
    				</table>
    			</td>
    			<td align="center">
			    	<table width="80%" border="0" cellspacing="1" align="center" cellpadding="3" class="outertable"> 
    					<tr class="datagrid"> 
    			
			    		 	<td width="40%" >Photograph</td>
			    		 	<td><input type="checkbox" name="chk_photograph" style='border=none'">
			                
			                </td>
               			</tr>
    			<tr class="datagrid"> 
    			
			    		 	<td width="40%" >Specimen Sign</td>
			    		 	<td><input type="checkbox" name="chk_specimen" style='border=none' onclick="callcheck(<%=i%>);">
			                
			                </td>
               			</tr>
    		
    			</table>
    			</td>
    			
    			
    			
    			
    			<td align="center">
			    	<table width="80%" border="0" cellspacing="1" align="center" cellpadding="3" class="outertable"> 
    					<tr class="datagrid"> 
    						<td>
								Mandate for EMI<input type="checkbox" name="chk_mendateemi" style='border=none' onclick="callcheck(<%=i%>);callcheckdate('EMAN',<%=i%>)">
	         						<input type="hidden" name="hid_mendate" value="<%=StrMENDate%>">
	         						<input type="hidden" name="hid_menduser" value="<%=StrMENUser%>">
				              </td>
    					</tr>
    					<tr class="datagrid">
    						<td>Bank Name: <%=strbank_name%></td>
    					</tr>
    					<tr class="datagrid">
    						<td >Account No: <%=stracc_no%></td>
    					</tr>
    		    	</table>
    			</td>
    			
    			
    		</tr>
    		</table>
    	
    			
    		 <table width="60%" border="0" cellspacing="1" align="center" cellpadding="3" class="outertable">
    		 <tr align="center" class="dataHeader">
    		 <td width="10%">Field Investigation CheckList</td> 
    		 </tr>
    		 </table>
    		 <table  width="60%" border="0" cellspacing="1" align="center" cellpadding="8" class="outertable">
                 				
    			<tr class="datagrid" align="center" > 
                 					<td valign="middle" >Address 
                 						<select name="sel_add" onchange=onChangeAdd() >
                 						<option value="1"> </option>
                 						<option value="2">FI Initiated</option>
                 						<option value="3">Report Received</option>
                 						<option value="4">Accept</option>
                 						<option value="5">Reject</option>
                 					</select>
                 						<input type="hidden" name="hid_fiaddressdate" value="<%=StrADDDate%>">
                 						<input type="hidden" name="hid_fiaddressuser" value="<%=StrADDUser%>">
                 					</td>
                 				
                 					
                 				
                 				
                 					<td valign="middle">
                 					 Employment 
                 						<select name="sel_employment" onchange="onChangeEmpl()">
                 						<option value="1"> </option>
                 						<option value="2">FI Initiated</option>
                 						<option value="3">Report Received</option>
                 						<option value="4">Accept</option>
                 						<option value="5">Reject</option>
                 					</select>
                 					<input type="hidden" name="hid_empdate" value="<%=StrEMPDate%>">
                 						<input type="hidden" name="hid_empuser" value="<%=StrEMPUser%>">
                 					</td>
                 				
                 				
                 					<td valign="middle">Bank Statement
                 								
                 						<select name="sel_bankstat" onchange="onChangeBnkStmnt()" >			
                 						<option value="1"> </option>
                 						<option value="2">FI Initiated</option>
                 						<option value="3">Report Received</option>
                 						<option value="4">Accept</option>
                 						<option value="5">Reject</option>
                 					</select>
                 								<input type="hidden" name="hid_bankdate" value="<%=StrBNKDate%>">
                 								<input type="hidden" name="hid_bankuser" value="<%=StrBNKUser%>"> </td>
                 				</tr>
    		  
    		 
    		
    		 <table>
    		 <tr>
    		 <td>  </td>
    		 </tr>
    		 <tr>
    		 <td>  </td>
    		 </tr>
    		 <tr>
    		 <td>  </td>
    		 </tr>
    		 <tr>
    		 </table>
    		   </table>
    		  <% 
    		  String strchkphysicalcompleted="";
    		  if(arrRow.size()>0 && arrRow!=null) 
    	      {
  	         for(int k=0;k<arrRow.size();k++)
  	         {
  	         arrCol=(ArrayList)arrRow.get(k);
  	         strchkphysicalcompleted=Helper.correctNull((String)arrCol.get(29));
  	         if(strchkphysicalcompleted.equals("MC") || strchkphysicalcompleted.equals("on")){
  	         %>  
    		  <table width="60%" border="0" cellspacing="1" align="center" cellpadding="3" class="outertable">
    		  <tr class="datagrid" align="center"> 
    			
			    		 	<td><input type="checkbox" name="chk_physicalcompleted" style='border=none' onclick="callcheck(<%=i%>);"> &nbsp;We Confirm the Borrower financial Status is Good
			                
			                </td>
               			</tr>
               	</table>		
               	<% }}} %>		
    		 <table width="20%" border="0" cellspacing="1" align="center" cellpadding="3" class=""outertable">
    		
<!--    		<tr class="dataHeader" align="center">-->
<!--    		-->
<!--    		 <td width="15%"> Action&nbsp; </td>-->
<!--    		</tr>-->
<!--    		-->
    		 
    		<tr align="center">
    		 <%if(strcbsid.equalsIgnoreCase("NEW")) { %>
           					<td><input type="hidden" name="hid_appid" value="<%=strperappid %>"><input type="button" class="buttonPrint" name="cmd_cbs_create" value="Create CBS Customer ID" onclick="goCBScreate(document.forms[0].hid_appid[<%=i%>].value)"></td>
           				<%}
    		 		else {
           			if((straddressflag.equals("Y")||strpanflag.equals("Y") || strpermaddressflag.equals("Y")) && strcbscustflag.equals("N"))
           					{
           					%>
           					<td><input type="hidden" name="hid_appid" value="<%=strperappid%>"><input type="button" class="buttonPrint" name="cmd_cbs_create" value="Update CBS Customer ID" onclick="goCBSupdate(document.forms[0].hid_appid[<%=i%>].value)"></td>
           					<%}
           			else if(strKycPendFlag.equals("Y")|| strFiPendFlag.equals("Y")||strEManPendFlag.equals("Y")|| strcbscustflag.equals("N"))
   					{ %>
           					<td><input type="hidden" name="hid_appid" value="<%=strperappid%>"><input type="button" class="buttonPrint" name="cmd_cbs_create" value="Update" onclick="goCBSupdate(document.forms[0].hid_appid[<%=i%>].value)"></td>
   					<% }
           					else 
           					{ %>
           					<td><input type="hidden" name="hid_appid" value="<%=strperappid%>"><input type="hidden" name="cmd_cbs_create"> </td>
           					<% } } %>
    		 
    		 </tr>
    		 
    		<tr>
    		 <td>  </td>
    		 </tr>
    		 <tr>
    		 <td>  </td>
    		 </tr>
    		
    		 
    		 
    		 </table>
    		
    		<%  }   } %>	 
    		
    		<%-- 
    		<tr>
    			<td> 
             	 	<table width="75%" border="0" cellspacing="1" align="center" cellpadding="3" class="outertable">
                	<tr align="center" class="dataHeader"> 
                		<td width="15%">Borrower Details </td>
                		<td width="7%">CBSID </td>
                		<td width="5%">CIBIL Score </td>
                		<td width="10%">KYC CheckList</td> 
                		<td width="10%">Field Investigation CheckList</td> 
                		<td width="10%"> Mandate </td>
           		        <td width="15%"> Action&nbsp; </td>
                		
                	</tr>
                	
                	
                	
                	
                	
                	<%
                
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
                			String strDocDate=Helper.correctNull((String)arrCol.get(13));
                			String strDocUser=Helper.correctNull((String)arrCol.get(14));
                			if(!strDocDate.equalsIgnoreCase(""))
                			{
								String[] strDocSplitDate=strDocDate.split("@");
								StrPADate=strDocSplitDate[0];
								StrPANDate=strDocSplitDate[1];
								StrADDDate=strDocSplitDate[2];
								StrEMPDate=strDocSplitDate[3];
								StrBNKDate=strDocSplitDate[4];
                				StrMENDate=strDocSplitDate[5];
                			}
                			if(!strDocUser.equalsIgnoreCase(""))
                			{
                				String[] strDocSplitUser=strDocUser.split("@");
                				StrPAUser =strDocSplitUser[0];
                				StrPANUser=strDocSplitUser[1];
                				StrADDUser =strDocSplitUser[2];
                				StrEMPUser=strDocSplitUser[3];
                				StrBNKUser=strDocSplitUser[4];
                				StrMENDate=strDocSplitUser[5];
                			}
                			String strappdesc="";
            	        	if(strAppType.equals("a"))
            	        		strappdesc="Applicant - "+strAppName;
            	        	else 
            	        		strappdesc="CoApplicant - "+strAppName;
                	
                	%>
                	<tr align="center" class="datagrid"> 
                		<td style="padding-right: 5px;"><%=strappdesc %> </td>
                		
                	 <%if(strcbsid.equalsIgnoreCase("NEW")){%>
                		<td> <span style="color: green;"><%=strcbsid %> </span> </td>
                 	<%} else { %>	
                 	    <td> <span > <%=strcbsid %> </span> </td>
                 	<%} %>
                 	
                 		<td><input type="hidden" name="hid_lapsappid" value="<%=strperappid %>"><%=strCibilscore %></td>
                 		
                 		<td>
							<table class="outertable">
                 				<tr class="datagrid" > 
                 					
                 					<td>Proof of Address </td>
                 					<td><input type="checkbox" name="chk_proofaddress" style='border=none' onclick="callcheck(<%=i%>);callcheckdate('PA',<%=i%>)">
                 					<input type="hidden" name="hid_prfadd" value="<%=StrPADate%>">
                 					<input type="hidden" name="hid_prfadduser" value="<%=StrPAUser%>">
                 					</td>
                 				</tr>
                 				<tr class="datagrid"> 
                 					<td>PAN </td><td><input type="checkbox" name="chk_pan" ='border=none' onclick="callcheck(<%=i%>);callcheckdate('PAN',<%=i%>)">
                 					<input type="hidden" name="hid_PANdate"value="<%=StrPANDate%>">
                 					<input type="hidden" name="hid_PANuser" value="<%=StrPANUser%>">
                 					</td>
                 				</tr>
                 			</table>                 
                 		</td>
                 	
                 		<td>
                 			<table class="outertable">
                 				<tr class="datagrid"> 
                 					<td>Address </td><td><input type="checkbox" name="chk_fiaddress" style='border=none' onclick="callcheck(<%=i%>);callcheckdate('ADD',<%=i%>)">
                 						<input type="hidden" name="hid_fiaddressdate" value="<%=StrADDDate%>">
                 						<input type="hidden" name="hid_fiaddressuser" value="<%=StrADDUser%>">
                 					</td>
                 				</tr>
                 				<tr class="datagrid"> 
                 					<td>Employment </td><td><input type="checkbox" name="chk_employment" style='border=none' onclick="callcheck(<%=i%>);callcheckdate('EMP',<%=i%>)">
                 						<input type="hidden" name="hid_empdate" value="<%=StrEMPDate%>">
                 						<input type="hidden" name="hid_empuser" value="<%=StrEMPUser%>">
                 					</td>
                 				</tr>
                 				<tr class="datagrid"> 
                 					<td>Bank Statement </td><td><input type="checkbox" name="chk_bankstat" style='border=none' onclick="callcheck(<%=i%>);callcheckdate('BNK',<%=i%>)">
                 								<input type="hidden" name="hid_bankdate" value="<%=StrBNKDate%>">
                 								<input type="hidden" name="hid_bankuser" value="<%=StrBNKUser%>"></td>
                 				</tr>
                 			</table>
                 		</td>
                 		
                 		<td>
                 			<table class="outertable">
                 				<tr class="datagrid"> 
                 					<td>E-Mandate for EMI </td><td><input type="checkbox" name="chk_mendateemi" style='border=none' onclick="callcheck(<%=i%>);callcheckdate('EMAN',<%=i%>)">
                 						<input type="hidden" name="hid_mendate" value="<%=StrMENDate%>">
                 						<input type="hidden" name="hid_menduser" value="<%=StrMENUser%>">
                 					</td>
                 				</tr>
                 		</table>
                 		</td>
                 		
                 		
                 		<%if(strcbsid.equalsIgnoreCase("NEW")) { %>
           					<td><input type="hidden" name="hid_appid" value="<%=strperappid %>"><input type="button" class="buttonPrint" name="cmd_cbs_create" value="Create CBS Customer ID" onclick="goCBScreate(document.forms[0].hid_appid[<%=i%>].value)"></td>
           				<%} else 
           				{
           					if(straddressflag.equals("Y") || strpanflag.equals("Y") || strfiaddressflag.equals("Y") || strfiempflag.equals("Y") || strfibankstatflag.equals("Y") )
           					{
           					%>
           					<td><input type="hidden" name="hid_appid" value="<%=strperappid%>"><input type="button" class="buttonPrint" name="cmd_cbs_create" value="Update CBS Customer ID" onclick="goCBSupdate(document.forms[0].hid_appid[<%=i%>].value)"></td>
           					<%} else 
           					{ %>
           					<td><input type="hidden" name="cmd_cbs_create"> </td>
           					<% } } %>
	                	</tr>
                	
                	
                	
                	
                	<%  }   } %>
                	 
                	</table>
               </td>
    		</tr> --%>
    		
    		<tr>
     	<td valign="top" align="center" id="id_applicationdet_loantype"> 
         
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
<!--                		<td><input type="button" name="cmdClick" value="Deviations" class="buttonStyle"	title="Check Deviations" onClick="callDeviation('normal')"></td>-->
                		<td><input type="button" class="buttonOthers" name="cmd_save" value="Save" onclick="doSave()"> &nbsp;</td>
                	<!-- 	<td><input type="button" class="buttonOthers" name="cmd_submit" value="Submit" onclick="goSubmit()"> &nbsp;</td>
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
<input type="hidden" name="hid_appid">
<input type="hidden" name="hid_hidborrowerid">
<input type="hidden" name="hidKYCChk">
<input type="hidden" name="hidInvestigationchk">
<input type="hidden" name="hid_prfadd">
<input type="hidden" name="hid_prfadduser">
<input type="hidden" name="hid_PANdate">
<input type="hidden" name="hid_PANuser">
<input type="hidden" name="hid_fiaddressdate">
<input type="hidden" name="hid_fiaddressuser">
<input type="hidden" name="hid_empdate">
<input type="hidden" name="hid_empuser">
<input type="hidden" name="hid_bankdate">
<input type="hidden" name="hid_bankuser">
<input type="hidden" name="hid_lapsappid">
<input type="hidden" name="chk_mendateemi">
<input type="hidden" name="hid_mendate">
<input type="hidden" name="hid_menduser">
<input type="hidden" name="chk_add">
<input type="hidden" name="hid_sel_employment">
<input type="hidden" name="hid_sel_add">
<input type="hidden" name="hid_sel_bankstat">
<input type="hidden" name="account_no">
<input type="hidden" name="bank_name">
<input type="hidden" name="strcbscustflag">

<input type="hidden" name="hid_KYCPEND_FLAG">
<input type="hidden" name="hid_FIPEND_FLAG">
<input type="hidden" name="hid_EMANPEND_FLAG">
<input type="hidden" name="hidborrowerid">


<input type="hidden" name="cmdsave" disabled="disabled">
  <lapschoice:hiddentag pageid='<%=PageId%>'/>
</form>
</body>
</html>