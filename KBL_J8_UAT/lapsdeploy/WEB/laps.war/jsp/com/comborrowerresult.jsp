<%@include file="../share/directives.jsp"%>
<%

ArrayList g1 = new ArrayList();
ArrayList g2 = new ArrayList();
int noofrows = Integer.parseInt(request.getParameter("noofrows"));
ArrayList v1=new ArrayList();
int noofrows1=0;
	v1 = (ArrayList) hshValues.get("vecval");
	String strType="";
	if(v1!=null)
	{
		int vecsize1 =v1.size();
		if(vecsize1 !=0)
      	{
        	if(noofrows > vecsize1)
        	{
		    	noofrows1 =vecsize1;
		    }
          	for(int l=0;l<noofrows1;l++)
        	{ 
		    	g2 = (ArrayList)v1.get(l);
          		strType=Helper.correctNull((String)g2.get(3));
          		if(strType.equalsIgnoreCase("CORPORATE"))
          		{
          			strType="CORP";
          		}
          	}
		}
	}
%>
<html>
<head>
<script>

function callPage(id,compname,cattype,oldid,democuststatus,cbsstatus,cbsid,comapp_newid,approvedApplDemoid,varKYCCode)
{
	var hidPageType = document.forms[0].hidPageType.value;
	var hidModuleType = document.forms[0].hid_moduletype.value;
	var Type = "<%=strType%>";
	document.forms[0].comapp_compname.value = compname ;
	var Flag=false;
	
	if(hidPageType=="NEW")
	{
		if(varKYCCode=="MIGR")
		{
			alert("Please modify occupation code in Finacle - CRM and then visit LAPS customer profile");
			return;
		}
		if(democuststatus=="N")
		{
			alert("Customer Profile is not filled completely");
			return;
		}
		//if(document.forms[0].hidRatingProposalPendingFlag.value=='Y')
		{
		//alert("You can't create the proposal,Rating Request is still Pending for this Applicant in Only for Rating ;Please contact ["+"<%//=Helper.correctNull((String)hshValues.get("strProposalUserID"))%>"+" : "+"<%//=Helper.correctNull((String)hshValues.get("strProposalUserName"))%>"+"] for further processing.");
		//return;
		}
		//if(document.forms[0].hidRatingProposalFlag.value=='Y')
		{
			//if(confirm("This Applicant has Only for Rating proposal in pending.If you are proceeding, Existing Only for Rating proposal will be closed.Do you want to continue?"))
			{
				Flag=true;
			}
		}//else
		{
		Flag=true;
		}
	}else{
		Flag=true;
	}
	if(Flag)
	{
		if(hidPageType=='SRE' || hidPageType=='STL' || hidPageType=='ADC')
		{
			document.forms[0].hidCategoryType.value= hidPageType;
		}
		else
		{
			document.forms[0].hidCategoryType.value= cattype;
		}
		
		if(hidPageType=="NEW")
		{
			document.forms[0].comapp_id.value=id;
		    document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/comloanhistroy.jsp?comapp_oldid="+oldid+"&hidCategoryType="+hidModuleType+"&CBSid="+cbsid+"&comapp_newid="+comapp_newid+"&approvedApplDemoid="+approvedApplDemoid;
			document.forms[0].target="mainFrame";
		}
		else if(hidPageType=="EXI" || hidPageType=="PROP" || hidPageType=="EXC" || hidPageType=="INS" || hidPageType=="SRE" || hidPageType=="STL" || hidPageType=='ADC')
		{
			document.forms[0].comapp_id.value=oldid;
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/comsearch.jsp?id="+oldid+"&hidModuleType="+hidModuleType+"&idnew="+comapp_newid;
			document.forms[0].target="mainFrame";
		}
		else if(hidPageType=="MST")
		{
			document.forms[0].comapp_id.value=id;
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/commstsearch.jsp?comapp_oldid="+oldid;
			document.forms[0].target="mainFrame";
		}
		document.forms[0].submit();
	}
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
</head>
<body>
<form name="srchform" method ="post" class="normal">
  <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
	<% 
	ArrayList	v = (ArrayList) hshValues.get("vecval");
	
	if(v!=null)
	{
	int vecsize =v.size();

	if(vecsize !=0)
   {
	if(noofrows > vecsize)
	{
		noofrows =vecsize;
	}
	for(int l=0;l<noofrows;l++)
	{ 
		g1 = (ArrayList)v.get(l);

	
	%>
    <tr class="datagrid"> 
       <td width="35%"><a href="#" onclick="javascript:callPage('<%=Helper.correctNull((String)g1.get(4))%>','<%=Helper.replaceForJavaScriptString(Helper.correctNull((String)g1.get(0)))%>','CORP','<%=Helper.correctNull((String)g1.get(4))%>','<%=Helper.correctNull((String)g1.get(8))%>','<%=Helper.correctNull((String)g1.get(7))%>','<%=Helper.correctNull((String)g1.get(5))%>','<%=Helper.correctNull((String)g1.get(9))%>','<%=Helper.correctNull((String)g1.get(10))%>','<%=Helper.correctNull((String)g1.get(11))%>')"><b>&nbsp;&nbsp;<%=Helper.correctNull((String)g1.get(0))%></b></a></td>
       <td width="12%">&nbsp;&nbsp;<%=Helper.correctNull((String)g1.get(5))%></td>
	   <td width="10%">&nbsp;&nbsp;<%=Helper.correctNull((String)g1.get(4))%></td>
	   <td width="33%" align="center"><%=Helper.correctNull((String)g1.get(2))%>&nbsp;
 </td>
    </tr>
    <%


	 }
	}
	 else
		{
			 %>
			  <tr class="datagrid"> 
	              <td width="25%">&nbsp;</td>
           	      <td width="50%" align="center" ></td>
		  	  	  <td width="15%" align="left"></td>
				  <td width="10%" align="center"></td>
             </tr>
		      <tr class="datagrid"> 
	              <td width="25%">&nbsp;</td>
         	      <td width="50%" align="center" ></td>
		 	  	  <td width="15%" align="left"></td>
				  <td width="10%" align="center"></td>
             </tr>
      	    <tr class="datagrid"> 
        	      <td width="25%">&nbsp;</td>
        	      <td width="50%" align="center" >No Data Found</td>
		 	  	  <td width="15%" align="left"></td>
				  <td width="10%" align="center"></td>
    	    </tr>
	   <%
	 }
		
 }
		
		%>
</table>
<input type="hidden" name="comapp_id">
<input type="hidden" name="comapp_compname">
<input type="hidden" name="hidPageType" value="<%=Helper.correctNull((String)request.getParameter("hidPageType"))%>"> 
<input type="hidden" name="hidCategoryType" value="<%=strType%>">
<input type="hidden" name="select_cat" value="<%=Helper.correctNull((String)request.getParameter("cat"))%>">
<input type="hidden" name="srch_txtval" value="<%=Helper.correctNull((String)request.getParameter("bow_name"))%>">
<input type="hidden" name="hid_moduletype" value="<%=Helper.correctNull((String)request.getParameter("varstrSessionModuleType"))%>">
<input type="hidden" name="hidRatingProposalFlag" value="<%=Helper.correctNull((String)hshValues.get("strRatingProposalPending"))%>">
<input type="hidden" name="hidRatingProposalPendingFlag" value="<%=Helper.correctNull((String)hshValues.get("strProposalPendinginKalypto"))%>">
</form>
</body>
</html>
