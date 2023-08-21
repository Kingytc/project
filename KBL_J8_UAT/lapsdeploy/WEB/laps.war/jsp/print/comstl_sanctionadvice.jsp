<%@ page import="com.sai.laps.helper.*,java.util.*"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<laps:handleerror />
<%
String cattype =Helper.correctNull((String)hshValues.get("cattype"));
String strCategoryType =Helper.correctNull((String)request.getParameter("hidCategoryType"));
ArrayList arrRow=null;
ArrayList arrCol=new ArrayList();
ArrayList arrSubFac = new ArrayList();

ArrayList arrtotRemark = new ArrayList();

ArrayList arrSubFacRecords = new ArrayList();
 String strOwner=Helper.correctNull((String)hshValues.get("comapp_ownership"));
 String strProposalvalue = Helper.correctNull((String) hshValues
			.get("proposalvaluesin"));
	if (strProposalvalue.equalsIgnoreCase("C"))
		strProposalvalue = "Crores";
	else
		strProposalvalue = "Lacs";
%>
<html>
<head>
<title>KARNATAKA BANK LTD. - Sanction Advice</title>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>/css/report.css"
	type="text/css">
</head>
<body onLoad="">
	<form>
		
  <table border="1" width="100%" cellspacing="0" cellpadding="3" bordercolor="#999999">
    <tr> 
      
      <td colspan="3" align="center"> <b>KARNATAKA BANK LTD.</b><br>
        <%=Helper.correctNull((String)hshValues.get("RespectiveBranch"))%>&nbsp;&nbsp;Branch </td>
      
    </tr>
    <tr> 
      <td valign="top" width="25%"> 
        <table border="0" width="99%" cellspacing="0" cellpadding="3">
          <tr> 
            <td> <b>NATURE OF BUSINESS:</b></td>
          </tr>
		  <%
		  String strnature="";
		  if(cattype.equalsIgnoreCase("OPS"))
		  {
			  if(Helper.correctNull((String)hshValues.get("ops_accountbusinessnature"))!="")
			  {
			  	strnature=Helper.correctNull((String)hshValues.get("ops_accountbusinessnature"));
			  }
		  }
		  else
		  {
			  if(Helper.correctNull((String)hshValues.get("comapp_businessnature"))!="")
			  {
			  	strnature=Helper.correctNull((String)hshValues.get("comapp_businessnature"));
			  }
		  }
		  %>
		  
          <tr> 
            <td> <%=strnature%> 
            </td>
          </tr>
        </table>
      </td>
      <td valign="top" width="50%"> 
        <table border="0" width="100%" cellspacing="0" cellpadding="0">
          <tr> 
            <td colspan="2" align="center"> <b><u>SANCTION ADVICE</u></b></td>
          </tr>
          <tr> 
            <td width="25%"><b>CONFIDENTIAL </b></td>
            <td width="75%">&nbsp;</td>
          </tr>
          <tr> 
            <td width="25%">&nbsp;</td>
            <td width="75%"> TO, <br>
            <%
            if(!Helper.correctNull((String)hshValues.get("appCreationBranch")).equalsIgnoreCase("")){
            	out.println(Helper.correctNull((String)hshValues.get("appCreationBranch"))+"<br>");
            }
            %>
               <%
            if(!Helper.correctNull((String)hshValues.get("appCreationAddress")).equalsIgnoreCase("")){
            	out.println(Helper.correctNull((String)hshValues.get("appCreationAddress")));
            }
            %>
            <br>
             <%
            if(!Helper.correctNull((String)hshValues.get("appCreationCity")).equalsIgnoreCase("")){
            	out.println(Helper.correctNull((String)hshValues.get("appCreationCity")));
            }
            %>
               <%
            if(!Helper.correctNull((String)hshValues.get("appCreationState")).equalsIgnoreCase("")){
            	out.println(Helper.correctNull((String)hshValues.get("appCreationState")));
            }
            %>
            <%
            if(!Helper.correctNull((String)hshValues.get("appCreationpin")).equalsIgnoreCase("")){
            	out.println(Helper.correctNull((String)hshValues.get("appCreationpin")));
            }
            %>
          </td>
          </tr>
        </table>
      </td>
      <td align="center" width="25%"> 
        <table border="0" width="100%" cellspacing="0" cellpadding="0" bordercolor="#999999">
          <tr> 
            <td colspan="2" align="center"><b>BSR CODES</b></td>
          </tr>
          <%
							String branch="";
							String branch_val=Helper.correctNull((String)hshValues.get("org_branchIn"));
							if(branch_val.equalsIgnoreCase("1"))
								{
									branch="Metro";
								}
							if(branch_val.equalsIgnoreCase("2"))
							{
								branch="Urban";
							}
							if(branch_val.equalsIgnoreCase("3"))
							{
								branch="Semi-Urban";
							}
							if(branch_val.equalsIgnoreCase("5"))
							{
								branch="Rural";
							}
							
							%>
          <tr> 
            <td valign="top"><b>LOCATION:</b></td>
            <td valign="top"><%=branch%>&nbsp;</td>
          </tr>
          <tr> 
            <td valign="top"><b>ORGANISATION:</b></td>
            <td valign="top"><%
								 strOwner=Helper.correctNull((String)hshValues.get("comapp_ownership"));
								  if(strOwner.trim().equals("OO"))
								  out.println("Others");
								  else if(strOwner.trim().equals("OLP"))
								  out.println("Private Limited Company");
								  else if(strOwner.trim().equals("OLC"))
								  out.println("Joint Borrowers");
								  else if(strOwner.trim().equals("OS"))
								  out.println("Sole Proprietor");
								  else if(strOwner.trim().equals("OCC"))
								  out.println("Public Limited Company");
								  else if(strOwner.trim().equals("OP"))
								  out.println("Partnership");
								  else if(strOwner.trim().equals("IN"))
									  out.println("Individual");
								  else if(strOwner.trim().equals("Jo"))
									  out.println("Joint Venture");
								  else if(strOwner.trim().equals("sub"))
									  out.println("Wholly owned subsidiary");
								  else if(strOwner.trim().equals("nbfc"))
									  out.println("NBFC");
								  else
								  out.println("");
							%>&nbsp;</td>
          </tr>
          <tr> 
            <td valign="top"><b>OCCUPATION:</b></td>
            <td valign="top"><%=Helper.correctNull((String)hshValues.get("comapp_companyid"))%> &nbsp;</td>
          </tr>
          <tr> 
            <td valign="top"><b>STATUS:</b></td>
            <td valign="top"><%=Helper.correctNull((String)hshValues.get("com_propassettype"))%>&nbsp; </td>
          </tr>
        </table>
      </td>
    </tr>
    <tr> 
      <td valign="top"> 
        <table border="0" width="99%" cellspacing="0" cellpadding="0">
          <tr> 
            <td colspan="2"> <b>MEANS/REPORTED NETWORTH </b> </td>
          </tr>
          <tr> 
            <td><b>DATE</b></td>
            <td ><b>AMOUNT</b>(<%=ApplicationParams.getCurrency()%>in <%=strProposalvalue%>)</td>
          </tr>
          <tr> 
            <td align="left"><%=Helper.correctNull((String)hshValues.get("asondate"))%></td>
            <td align="center"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("means"))))%></td>
          </tr>
        </table>
      </td>
      <td valign="top"> 
        <table border="0" width="100%" cellspacing="0" cellpadding="0">
          <tr> 
            <td width="29%" valign="top"><b>BORROWER'S NAME :</b></td>
            <td width="71%" valign="top"> <%=Helper.correctNull((String)hshValues.get("comapp_companyname"))%> 
            </td>
          </tr>
          <tr> 
            <td width="29%" valign="top"><b> ADDRESS: </b></td>
            <td width="71%" valign="top">
         <%  
         if(!Helper.correctNull((String)hshValues.get("comapp_regadd1")).equalsIgnoreCase("")){
         	out.println(Helper.correctNull((String)hshValues.get("comapp_regadd1"))+", ");
         }
          %>
             
             <%
             if(!Helper.correctNull((String)hshValues.get("comapp_regadd2")).equalsIgnoreCase("")){
              	out.println(Helper.correctNull((String)hshValues.get("comapp_regadd2"))+", ");
             }
             %>
               <br>
               <%
             if(!Helper.correctNull((String)hshValues.get("city_name")).equalsIgnoreCase("")){
              	out.println(Helper.correctNull((String)hshValues.get("city_name"))+", ");
             }
               if(!Helper.correctNull((String)hshValues.get("state_name")).equalsIgnoreCase("")){
                 	out.println(Helper.correctNull((String)hshValues.get("state_name"))+", ");
                }
               if(!Helper.correctNull((String)hshValues.get("comapp_regpin")).equalsIgnoreCase("")){
                	out.println(Helper.correctNull((String)hshValues.get("comapp_regpin"))+", ");
               }
             %>
            
            </td>
          </tr>
        </table>
      </td>
      <td> 
        <table border="0" width="99%" cellspacing="0" cellpadding="0">
          <tr> 
            <td colspan="4"> <b>SECTORIAL/CATEGORY</b> </td>
          </tr>
          <tr> 
            <td width="25%">A-1</td>
            <td width="25%">B-1</td>
            <td width="25%">C-1</td>
            <td width="25%">D-1</td>
          </tr>
          <tr> 
            <td width="25%">A-2</td>
            <td width="25%">B-2</td>
            <td width="25%">C-2</td>
            <td width="25%">D-2</td>
          </tr>
          <tr> 
            <td width="25%">A-3</td>
            <td width="25%">B-3</td>
            <td width="25%">C-3</td>
            <td width="25%">D-3</td>
          </tr>
          <tr> 
            <td width="25%">A-4</td>
            <td width="25%">B-4</td>
            <td width="25%">C-4</td>
            <td width="25%">D-4</td>
          </tr>
        </table>
      </td>
    </tr>
    <tr> 
      <td> 
        <table border="0" width="99%" cellspacing="0" cellpadding="0">
          <tr> 
            <td colspan="2"><b>CHARGES REGISTERED</b></td>
          </tr>
           <tr> 
            <td align="center"><b>DATE</b></td>
            <td align="center"><b>AMOUNT</b>(<%=ApplicationParams.getCurrency()%>in <%=strProposalvalue%>)</td>
          </tr>
          <tr> 
            <td align="left"><%=Helper.correctNull((String)hshValues.get("rocchargedate"))%> </td>
            <td align="center"><%=Helper.correctNull((String)hshValues.get("roccharges"))%>
            </td>
          </tr>
        </table>
      </td>
      <td> 
        <table border="0" width="100%" cellspacing="0" cellpadding="0">
		
          <tr> 
          <% if((Helper.correctNull((String)hshValues.get("comapp_ownership")).equalsIgnoreCase("001"))
          || (Helper.correctNull((String)hshValues.get("comapp_ownership")).equalsIgnoreCase("002")))
          {%>
          <td id="t2"><b>Date Of Birth</b></td>
          <%}else
        	  {
        	  %>
            <td id="t1"><b>ESTD </b>:- </td>
          <%} %>  
            <td><b>CONSTITUTION</b>: </td>
            <td><b>MONTH OF REVIEW</b> </td>
          </tr> 
          <tr> 
            <td><%=Helper.correctNull((String)hshValues.get("comapp_yrsinbusiness"))%> 
            </td>
            <td> 
              <%
								 strOwner=Helper.correctNull((String)hshValues.get("comapp_ownership"));
								  if(strOwner.trim().equals("OO"))
								  out.println("Others");
								  else if(strOwner.trim().equals("OLP"))
								  out.println("Private Limited Company");
								  else if(strOwner.trim().equals("OLC"))
								  out.println("Joint Borrowers");
								  else if(strOwner.trim().equals("OS"))
								  out.println("Sole Proprietor");
								  else if(strOwner.trim().equals("OCC"))
								  out.println("Public Limited Company");
								  else if(strOwner.trim().equals("OP"))
								  out.println("Partnership");
								  else if(strOwner.trim().equals("IN"))
									  out.println("Individual");
								  else if(strOwner.trim().equals("Jo"))
									  out.println("Joint Venture");
								  else if(strOwner.trim().equals("sub"))
									  out.println("Wholly owned subsidiary");
								  else if(strOwner.trim().equals("nbfc"))
									  out.println("NBFC");
								  else if(strOwner.trim().equals("001"))
								  {
									  out.println("Individual");
									 // callestd();
								  }
								  else if(strOwner.trim().equals("002"))
									  out.println("Joint");
								  else if(strOwner.trim().equals("003"))
									  out.println("ASSOCIATION");
								  else if(strOwner.trim().equals("004"))
									  out.println("TRUSTS");
								  else if(strOwner.trim().equals("005"))
									  out.println("PVT.LTD COMPANIES");
								  else if(strOwner.trim().equals("006"))
									  out.println("PUB.LTD COMPANIES");
									  
								  else if(strOwner.trim().equals("007"))
									  out.println("PARTNERSHIP");
								  else if(strOwner.trim().equals("008"))
									  out.println("H.U.F");
								  else if(strOwner.trim().equals("009"))
									  out.println("PROPRIETORSHIP");
								  else if(strOwner.trim().equals("010"))
									  out.println("BANKING COMPANY");
								  else if(strOwner.trim().equals("999"))
									  out.println("OTHERS");
									  
								  else
								  out.println("");
							%>
            </td>
            <td><%=Helper.correctNull((String)hshValues.get("nextreviewdate"))%>&nbsp; 
            </td>
          </tr>
        </table>
      </td>
      <td> 
        <table border="0" width="99%" cellspacing="0" cellpadding="0">
          <tr> 
            <td ><b>SANCTIONED BY</b></td>
          </tr>
          
          <tr> 
            <td align="left"><%//=Helper.correctNull((String)hshValues.get("sanctionedauthority"))%>
            <%=Helper.correctNull((String)hshValues.get("sanc_auth_design"))%>&nbsp;</td>
          </tr>
        </table>
      </td>
    </tr>
    <tr> 
      <td><b>YOUR REF NO</b>:<%=Helper.correctNull((String)hshValues.get("strAppno"))%></td>
      <td><b>OUR NO:</b> </td>
      <td><b>DATE</b><b>:</b> <%=Helper.correctNull((String)hshValues.get("app_processdate"))%> 
      </td>
    </tr>
    <tr> 
      <td><b>Dated:</b><%=Helper.correctNull((String)hshValues.get("appcreatedate"))%></td>
      <td colspan="2" align="right"><b>(<%=ApplicationParams.getCurrency()%> In <%=strProposalvalue%>)</b></td>
    </tr>
    <tr> 
      <td colspan="3"> 
        <table width="100%" border="1" cellspacing="0" cellpadding="2" bordercolor="#999999">
          <tr valign="top"> 
            <td width="10%"><b>New/ Renewal/ Modification</b></td>
            <td width="20%"><b>LIMIT(S)</b></td>
            <td width="5%"><b>SECURED</b></td>
            <td width="5%"><b>UNSECURED</b></td>
            <td width="5%"><b>MARGIN (%)</b></td>
            <td width="5%"><b>INT/COM (%)</b></td>
            <td width="20%"><b>DOCUMENTS </b></td>
            <td> <b>SECURITY(GIVE BRIEF DETAILS)</b> 
            </td>
          </tr>
          <%     
          	int arrTL_Funded_NonFunded_Size=0;
            ArrayList OurBank_TL = new ArrayList();
            ArrayList TL_Funded_NonFunded=new ArrayList();
            arrTL_Funded_NonFunded_Size=0;
                    
            OurBank_TL=(ArrayList)hshValues.get("OurBank_TL");
            if(OurBank_TL!=null)
            {                    	
            	arrTL_Funded_NonFunded_Size = OurBank_TL.size();
            }
			for(int i=0;i<arrTL_Funded_NonFunded_Size;i++)
            {
            	TL_Funded_NonFunded=(ArrayList)OurBank_TL.get(i); 
                String strCategory="";
                if(Helper.correctNull((String)TL_Funded_NonFunded.get(17)).equalsIgnoreCase("A"))
                {
                	strCategory="<br>(Adhoc Limit for "+Helper.correctNull((String)TL_Funded_NonFunded.get(18))+" Month )";
                }
                else
                {
                	strCategory="";
                }
                ArrayList arrSecurity=new ArrayList();
                arrSecurity=(ArrayList)TL_Funded_NonFunded.get(15);
                int introwspan=Integer.parseInt(Helper.correctInt((String)TL_Funded_NonFunded.get(19)));
                if(arrSecurity!=null && arrSecurity.size()>0)
				{
					for(int j=0;j<arrSecurity.size();j++)
					{
						arrCol=new ArrayList();
						arrCol=(ArrayList)arrSecurity.get(j);
						arrtotRemark.add(Helper.correctNull((String)arrCol.get(3)));//Add only remarks to display separate
						if(j==0){
          %>
          <tr>
          	<td width="10%" valign="top" rowspan="<%=introwspan%>"><%=Helper.correctNull((String)TL_Funded_NonFunded.get(3))%>&nbsp;</td>
          	<td width="20%" valign="top" rowspan="<%=introwspan%>"><b><%=Helper.correctNull((String)TL_Funded_NonFunded.get(1))%></b>&nbsp;<%=strCategory%>&nbsp;</td>
          	<td width="5%" valign="top" align="right" rowspan="<%=introwspan%>">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)TL_Funded_NonFunded.get(4))))%></td>
          	<td width="5%" valign="top" rowspan="<%=introwspan%>">&nbsp;</td>
          	<td width="5%" valign="top">&nbsp;<%=Helper.correctNull((String)arrCol.get(1))%></td>
          	<td width="5%" valign="top" rowspan="<%=introwspan%>">
			&nbsp;<%=Helper.correctNull((String)TL_Funded_NonFunded.get(6))%>
		  </td>
			<td width="20%" valign="top" rowspan="<%=introwspan%>">&nbsp; 
              <%
				ArrayList arrUserDocuments=new ArrayList();
				arrUserDocuments=(ArrayList)TL_Funded_NonFunded.get(14);
				if(arrUserDocuments!=null && arrUserDocuments.size()>0)
				{
					for(int docno=0;docno<arrUserDocuments.size();docno++)
					{
				%>
              		<%=j+1%>.&nbsp;<%=Helper.correctNull((String)arrUserDocuments.get(docno))%><br> 
              	<%	}
				}else{
				%>
				&nbsp;
				<%} %>
            </td>
            <td width="25%" valign="top"><%=Helper.correctNull((String)arrCol.get(0))%>&nbsp;</td> 
          </tr>
          <%}else{ %>
          <tr>
          <td width="5%" valign="top">&nbsp;<%=Helper.correctNull((String)arrCol.get(1))%></td>
          <td width="25%" valign="top"><%=Helper.correctNull((String)arrCol.get(0))%>&nbsp;</td> 
          </tr>
          <%
          }	}
				}else
				{
          %>
          <tr>
          	<td width="10%" valign="top"><%=Helper.correctNull((String)TL_Funded_NonFunded.get(3))%>&nbsp;</td>
          	<td width="20%" valign="top"><b><%=Helper.correctNull((String)TL_Funded_NonFunded.get(1))%>&nbsp;</b><%=strCategory%>&nbsp;</td>
          	<td width="5%" valign="top">&nbsp;</td>
          	<td width="5%" valign="top" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)TL_Funded_NonFunded.get(4))))%></td>
          	<td width="5%" valign="top">&nbsp;</td>
          	<td width="5%" valign="top">&nbsp;<%=Helper.correctNull((String)TL_Funded_NonFunded.get(6))%>
		    </td>
			<td width="20%" valign="top">&nbsp; 
              <%
				ArrayList arrUserDocuments=new ArrayList();
				arrUserDocuments=(ArrayList)TL_Funded_NonFunded.get(14);
				if(arrUserDocuments!=null && arrUserDocuments.size()>0)
				{
					for(int j=0;j<arrUserDocuments.size();j++)
					{
				%>
              		<%=j+1%>.&nbsp;<%=Helper.correctNull((String)arrUserDocuments.get(j))%><br> 
              	<%	}
				}else{
				%>
				&nbsp;
				<%} %>
            </td>
            <td width="25%" valign="top">&nbsp;</td>
          </tr>
          <%
				}
          %>
          <%
//For the Sub-limits, under each one
				arrSubFac = new ArrayList();
                arrSubFac = (ArrayList)TL_Funded_NonFunded.get(13);
                int subFacSize = arrSubFac.size();
				if(arrSubFac!=null && subFacSize>0)
            	{
            		for(int j=0;j<subFacSize;j++)
            		{
            			arrSubFacRecords = new ArrayList();
            			arrSubFacRecords = (ArrayList)arrSubFac.get(j);
            			int intsubtrowspan=Integer.parseInt(Helper.correctInt((String)arrSubFacRecords.get(16)));
            			ArrayList arrSublimitSecurity=new ArrayList();
            			arrSublimitSecurity=(ArrayList)arrSubFacRecords.get(14);
            	if(j==0){%>
            	<tr>
            	  <td colspan="8">&nbsp;<b>&gt;&gt;Sub-Limit</b></td>
            	</tr>
            	<%}%>
            	<%if(arrSublimitSecurity!=null && arrSublimitSecurity.size()>0){ 
            		for(int k=0;k<arrSublimitSecurity.size();k++){
            		ArrayList arrsubCol=new ArrayList();
            		arrsubCol=(ArrayList)arrSublimitSecurity.get(k);
            		arrtotRemark.add(Helper.correctNull((String)arrsubCol.get(3)));//Add only remarks to display separate
            		if(k==0){
            	%>
            	<tr>
            		<td width="10%" valign="top" rowspan="<%=intsubtrowspan%>">&nbsp;<%=Helper.correctNull((String)arrSubFacRecords.get(3))%></td>
            		<td width="20%" valign="top" rowspan="<%=intsubtrowspan%>">&nbsp;<%=Helper.correctNull((String)arrSubFacRecords.get(1))%></td>
            		<td width="5%" valign="top" align="right" rowspan="<%=intsubtrowspan%>">&nbsp;(<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrSubFacRecords.get(4))))%>)</td>
            		<td width="5%" valign="top" rowspan="<%=intsubtrowspan%>">&nbsp;</td>
            		<td width="5%" valign="top">&nbsp;<%=Helper.correctNull((String)arrsubCol.get(1))%></td>
            		<td width="5%" valign="top" rowspan="<%=intsubtrowspan%>">
					&nbsp;<%=Helper.correctNull((String)arrSubFacRecords.get(6))%>
					</td>
					<td width="20%" valign="top" rowspan="<%=intsubtrowspan%>">&nbsp; 
              			<%
							ArrayList arrSublimitDoc=new ArrayList();
							arrSublimitDoc=(ArrayList)arrSubFacRecords.get(13);
							if(arrSublimitDoc!=null && arrSublimitDoc.size()>0)
							{
								for(int j1=0;j1<arrSublimitDoc.size();j1++)
								{
						%>
						<%=j1+1%>&nbsp;<%=Helper.correctNull((String)arrSublimitDoc.get(j1))%><br> 
              			<%
              					}
							}else{
						%>
							&nbsp;
						<%} %>
		            </td>
		             <td width="25%" valign="top"><%=Helper.correctNull((String)arrsubCol.get(0))%>&nbsp;</td>
		         </tr>
		         <%}else{ %>
		         <tr>
		         	<td width="5%" valign="top">&nbsp;<%=Helper.correctNull((String)arrsubCol.get(1))%></td>
		         	<td width="25%" valign="top"><%=Helper.correctNull((String)arrsubCol.get(0))%>&nbsp;</td>
		         </tr>
            	<%}}}else{ %>
            	<tr>
            		<td width="10%" valign="top">&nbsp;<%=Helper.correctNull((String)arrSubFacRecords.get(3))%></td>
            		<td width="20%" valign="top">&nbsp;<%=Helper.correctNull((String)arrSubFacRecords.get(1))%></td>
            		<td width="5%" valign="top">&nbsp;</td>
            		<td width="5%" valign="top" align="right">&nbsp;(<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrSubFacRecords.get(4))))%>)</td>
            		<td width="5%" valign="top">&nbsp;</td>
           			<td width="5%" valign="top">
			 	&nbsp;<%=Helper.correctNull((String)arrSubFacRecords.get(6))%>
					 	</td>
				 	<td width="20%" valign="top">&nbsp; 
              			<%
							ArrayList arrSublimitDoc=new ArrayList();
							arrSublimitDoc=(ArrayList)arrSubFacRecords.get(13);
							if(arrSublimitDoc!=null && arrSublimitDoc.size()>0)
							{
								for(int j1=0;j1<arrSublimitDoc.size();j1++)
								{
						%>
						<%=j1+1%>&nbsp;<%=Helper.correctNull((String)arrSublimitDoc.get(j1))%><br> 
              			<%
              					}
							}else{
						%>
							&nbsp;
						<%} %>
		            </td>
		            <td width="25%" valign="top">&nbsp;</td>
		          </tr>
            	<%} %>
          <%}}} %>
        </table>
         <%
              //TO Disply Security remarks   
                  ArrayList  arrData=new ArrayList();
                if(arrtotRemark != null && arrtotRemark.size()!=0){
             
                    %>
<table width="90%" border="0" cellspacing="0" cellpadding="3" align="center">
   <tr> 
    <td valign="top"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
      
      <%  for(int i=0;i< arrtotRemark.size();i++)
          {
    	 
    	  if(!Helper.formatTextAreaData((String)arrtotRemark.get(i)).equalsIgnoreCase("")){ %>
		  <tr> 
          <td width="3%">&nbsp;</td>
        </tr>
        <tr> 
		  <td width="3%">&nbsp;</td>		
          <td valign="top" class="just" width="97%"><%=Helper.formatTextAreaData((String)arrtotRemark.get(i))%>&nbsp;</td>
        </tr>
        
        <%}
	  } %>
        </table>
      </td>
   </tr>
</table>
		 <%   }
                    %>	
        
      </td>
    </tr>
    <tr> 
      <td colspan="3"><b>Collateral Security:</b></td>
    </tr>
    <%
    	ArrayList arrCollateral=(ArrayList)hshValues.get("arrColl");
   		 if(arrCollateral!=null && arrCollateral.size()>0)
   		 {
   			 for(int i=0;i<arrCollateral.size();i++)
   			 {%>
   			
   			
    
    
    <tr> 
      <td colspan="3">&nbsp;<%=i+1%>.&nbsp;&nbsp;<%=Helper.correctNull((String)arrCollateral.get(i))%></td>
    </tr>
    <%
   			 }
   		 }%>
    <tr> 
      <td><b>MEANS OF GUARANTOR(S)</b></td>
      <td colspan="2" valign="top"><b>Terms &amp; Conditions:</b></td>
    </tr>
    <tr> 
      <td> 
        <table width="100%" border="1" cellspacing="0" cellpadding="0" bordercolor="#999999">
          <tr> 
            <td><b>Name</b></td>
            <td><b>Means&nbsp;(<%=ApplicationParams.getCurrency()%> In <%=strProposalvalue%>)</b></td>
            <td><b>Means as On</b></td>
          </tr>
                              <%
      	if (Helper.correctNull((String) hshValues.get("sel_applicantguarantee")).equalsIgnoreCase("Y")) {
          %>
           <tr> 
            <td><%=Helper.correctNull((String) hshValues
									.get("comapp_companyname"))%>&nbsp;</td>
            <td><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("means"))))%></td>
            <td nowrap="nowrap"><%=Helper.correctNull((String) hshValues
									.get("meansason"))%>&nbsp;</td>
          </tr>
          <%} %>
          <%
					if(cattype!=null)
					{
						if(cattype.equalsIgnoreCase("CORP") || cattype.equalsIgnoreCase("SME")||cattype.equalsIgnoreCase("ADC")||cattype.equalsIgnoreCase("STL"))
						{
		                double dbMeans=0.00;
		                arrRow=(ArrayList)hshValues.get("arrRow6");
				  		if(arrRow!=null && arrRow.size()>0)
							{
								int size=0;
								size=arrRow.size();
								for(int i=0;i<size;i++)
								{
									arrCol=(ArrayList)arrRow.get(i);
									 dbMeans=Double.parseDouble(Helper.correctDouble(Helper.correctNull((String)arrCol.get(2))));%>
          <tr> 
            <td nowrap="nowrap"><%=Helper.correctNull((String)arrCol.get(0))%>&nbsp;</td>
            <td><%=Helper.formatDoubleValue(dbMeans)%></td>
            <td nowrap="nowrap"><%=Helper.correctNull((String)arrCol.get(3))%>&nbsp;</td>
          </tr>
          <%	}
                	}
						}
					}
                	%>
        </table>
      </td>
      <td colspan="2">NOTE :<br>
        1.LIMITS SANCTIONED ARE SUBJECT TO ALL GENERAL INSTRUCTIONS ADVISED FROM 
        TIME TO TIME.<br>
        2.OTHER TERMS &amp; CONDITION/SPECIAL INSRUCTIONS AS PER ENCLOSED ANNEXURES.<br>
      </td>
    </tr>
  </table>
      <table border="1" width="100%" bordercolor="#999999" cellspacing="0" >
        <tr> 
          <td width="29%" colspan="2" align="center"><b>Authorised Signatory</b></td>
          <td width="48%"></td>
          <td width="25%" colspan="2"> <b>&nbsp; Authorised Signatory</b> 
          </td>
        </tr>
        <tr> 
          <td width="10%"><b>Name </b></td>
          <td width="19%">&nbsp;</td>
          <td width="48%"></td>
          <td width="8%"><b>Name </b></td>
          <td width="17%">&nbsp;</td>
        </tr>
        <tr> 
          <td width="10%"><b>Designation</b></td>
          <td width="19%">&nbsp;</td>
          <td width="48%"></td>
          <td width="8%"><b>Designation</b></td>
          <td width="17%">&nbsp;</td>
        </tr>
        <tr> 
          <td width="10%"><b>PA No</b></td>
          <td width="19%">&nbsp;</td>
          <td width="48%"></td>
          <td width="8%"><b>PA No</b></td>
          <td width="17%">&nbsp;</td>
        </tr>
        <tr> 
          <td width="10%"></td>
          <td width="19%"></td>
          <td width="48%"></td>
          <td width="1%"></td>
          <td width="24%"></td>
        </tr>
      </table>
  <input type="hidden" name="cattype" value="<%=strCategoryType%>">
<input type="hidden" name="hidCategoryType" value="<%=strCategoryType%>">     
      </form>
</body>
</html>
