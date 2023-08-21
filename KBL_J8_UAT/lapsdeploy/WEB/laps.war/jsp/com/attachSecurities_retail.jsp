<%@include file="../share/directives.jsp"%>
<%
	ArrayList vecData = new ArrayList();
	ArrayList vecRow = new ArrayList();
	ArrayList vecFacID = new ArrayList();
	ArrayList arrColFacID = new ArrayList();
	ArrayList arrFacID = new ArrayList();
	
	String hidposition= Helper.correctNull((String)hshValues.get("hidposition"));
	String hidFacID= Helper.correctNull((String)hshValues.get("hidFacID"));
	String strPrd_cgstatus= Helper.correctNull((String)hshValues.get("strPrd_cgstatus"));
	String strmargin="";
	int Securitycount=Integer.parseInt(Helper.correctInt((String)request.getParameter("hidsize")));
	if (hshValues != null) 
	{
		vecData = (ArrayList) hshValues.get("vecData");
		arrColFacID = (ArrayList) hshValues.get("arrColFacID");
	}
	String str_Existing= Helper.correctNull((String)hshValues.get("Existing"));
	String str_Proposed= Helper.correctNull((String)hshValues.get("Proposed"));
	int intVecSize=vecData.size();
	int intarrsize=arrColFacID.size();
	String STRSECCERSAIREFNO= Helper.correctNull((String)hshValues.get("SEC_CERSAIREFNO"));
	String STRSECSEARCHPERFORMDATE= Helper.correctNull((String)hshValues.get("SEC_SEARCHPERFORM_DATE"));
	String strcussectype=Helper.correctNull((String)hshValues.get("cus_sec_type"));
	String strcersaidate=Helper.correctNull((String)hshValues.get("cersaidate"));
	String strProposalType = Helper.correctNull((String)hshValues.get("strAppType"));
	String strsecalreadymortg = Helper.correctNull((String)hshValues.get("SEC_ALREADY_MORTG"));
	String strCropType = Helper.correctNull((String)hshValues.get("sec_croptype"));
%>
<html>
<head>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varCategoryType="<%=Helper.correctNull((String)request.getParameter("hidCategoryType"))%>";
var vecSize = "<%=vecData.size()%>";
var hidFacID = "<%=hidFacID%>";
var varstrPrd_cgstatus= "<%=strPrd_cgstatus%>";
var VARSECCERSAIREFNO= "<%=STRSECCERSAIREFNO%>";
var VARSECSEARCHPERFORMDATE= "<%=STRSECSEARCHPERFORMDATE%>";
var varcussectype="<%=strcussectype%>";
var Varcersaidate ="<%=strcersaidate%>";
var VarProposalType ="<%=strProposalType%>";
var Varsecalreadymortg ="<%=strsecalreadymortg%>";
var VarcropType ="<%=strCropType%>";

function onload()
{
	var facID=hidFacID.split("~");
	var secValue="<%=Helper.correctNull((String)request.getParameter("secValue"))%>";
	var resiValue="<%=Helper.correctNull((String)request.getParameter("resiValue"))%>";

	<% if(arrColFacID != null && arrColFacID.size()>0) 
	{
		for(int i=0;i<vecData.size();i++)
		{
			vecFacID =(ArrayList) vecData.get(i);
			String facID=Helper.correctNull((String)vecFacID.get(4));
			String strParentfacno=Helper.correctNull((String)vecFacID.get(10));
			for(int j=0;j<arrColFacID.size();j++)
			{
				arrFacID = (ArrayList)arrColFacID.get(j);
				
				
				String strarrFacID=Helper.correctNull((String)arrFacID.get(0));
				strmargin=Helper.checkDecimal(Helper.correctNull((String)arrFacID.get(1)));
				String 	strsectype=(Helper.correctNull((String)arrFacID.get(2)));
				String 	strexiprop=(Helper.correctNull((String)arrFacID.get(3)));
				String strSecuritytype=(Helper.correctNull((String)arrFacID.get(6)));
				String strMappedParentfacno=(Helper.correctNull((String)arrFacID.get(4)));
			if( strarrFacID.equalsIgnoreCase(facID) )
			{
				if(strMappedParentfacno.equalsIgnoreCase(strParentfacno))
				{
				if(vecData.size()==1)
				{
		%>			
					document.forms[0].chk_facility.checked=true;
					document.forms[0].txt_margin.value="<%=strmargin%>";
					document.forms[0].sel_sectype.value="<%=strsectype%>";
					<%if(strSecuritytype.equalsIgnoreCase("")){
						strSecuritytype="S";
					}%>
					document.forms[0].sel_securitytype.value="<%=strSecuritytype%>";
					<%
					if(Helper.correctNull((String)vecFacID.get(8)).equalsIgnoreCase("E"))
					{
					%>
					document.forms[0].hidparentappno.value="<%=Helper.correctNull((String)vecFacID.get(10))%>";
					document.forms[0].hidparentsno.value="<%=Helper.correctNull((String)vecFacID.get(11))%>";
		
				<%}
				if(Helper.correctNull((String)vecFacID.get(9)).equalsIgnoreCase("Y"))
				{
				%>
				document.forms[0].chk_facility.disabled=true;
				document.forms[0].txt_margin.disabled=true;
				document.forms[0].sel_sectype.disabled=true;
				document.forms[0].sel_securitytype.disabled=true;
				<%	
				}
				} else {%>
					document.forms[0].chk_facility[<%=i%>].checked=true;
					document.forms[0].txt_margin[<%=i%>].value="<%=strmargin%>";
					document.forms[0].sel_sectype["<%=i%>"].value="<%=strsectype%>";
					<%if(strSecuritytype.equalsIgnoreCase("")){
						strSecuritytype="S";
					}%>
					document.forms[0].sel_securitytype["<%=i%>"].value="<%=strSecuritytype%>";
					<%
					if(Helper.correctNull((String)vecFacID.get(8)).equalsIgnoreCase("E"))
					{
					%>
					document.forms[0].hidparentappno["<%=i%>"].value="<%=Helper.correctNull((String)vecFacID.get(10))%>";
					document.forms[0].hidparentsno["<%=i%>"].value="<%=Helper.correctNull((String)vecFacID.get(11))%>";
		
				<%}if(Helper.correctNull((String)vecFacID.get(9)).equalsIgnoreCase("Y"))
		{
			%>
			document.forms[0].chk_facility[<%=i%>].disabled=true;
			document.forms[0].txt_margin[<%=i%>].disabled=true;
			document.forms[0].sel_sectype[<%=i%>].disabled=true;
			document.forms[0].sel_securitytype[<%=i%>].disabled=true;
			<%}	}
			}}}}}
	
	if(vecData != null && vecData.size()>0) 
			{
				for(int i=0;i<vecData.size();i++)
				{
					vecFacID =(ArrayList) vecData.get(i);
					if(vecData.size()==1)
					{
						if(Helper.correctNull((String)vecFacID.get(14)).equalsIgnoreCase("Y") || Helper.correctNull((String)vecFacID.get(9)).equalsIgnoreCase("Y") || Helper.correctNull((String)vecFacID.get(8)).equalsIgnoreCase("E"))
						{
						%>
						document.forms[0].chk_facility.disabled=true;
						document.forms[0].txt_margin.disabled=true;
						document.forms[0].sel_sectype.disabled=true;
						document.forms[0].sel_securitytype.disabled=true;
						<%	
						}
						if(Helper.correctNull((String)vecFacID.get(8)).equalsIgnoreCase("E"))
						{
						%>
						document.forms[0].hidparentappno.value="<%=Helper.correctNull((String)vecFacID.get(10))%>";
						document.forms[0].hidparentsno.value="<%=Helper.correctNull((String)vecFacID.get(11))%>";
			
					<%}}else {
							 
							 if(Helper.correctNull((String)vecFacID.get(14)).equalsIgnoreCase("Y") || Helper.correctNull((String)vecFacID.get(9)).equalsIgnoreCase("Y") || Helper.correctNull((String)vecFacID.get(8)).equalsIgnoreCase("E"))
				{
					%>
					document.forms[0].chk_facility[<%=i%>].disabled=true;
					document.forms[0].txt_margin[<%=i%>].disabled=true;
					document.forms[0].sel_sectype[<%=i%>].disabled=true;
					document.forms[0].sel_securitytype[<%=i%>].disabled=true;
					<%	
					}
					if(Helper.correctNull((String)vecFacID.get(8)).equalsIgnoreCase("E"))
					{
					%>
					document.forms[0].hidparentappno["<%=i%>"].value="<%=Helper.correctNull((String)vecFacID.get(10))%>";
					document.forms[0].hidparentsno["<%=i%>"].value="<%=Helper.correctNull((String)vecFacID.get(11))%>";
		
				<%}}}}%>



				<% if(vecData != null && vecData.size()>0) 
				{
					for(int i=0;i<vecData.size();i++)
					{
						vecFacID =(ArrayList) vecData.get(i);
						if(vecData.size()==1)
						{%>
							
							 if(document.forms[0].sel_sectype.value=="2")
							   {
								 document.forms[0].txt_margin.disabled=true;
							   }
							   else
							   {
							     document.forms[0].txt_margin.disabled=false;	
							   }

						 <%if(Helper.correctNull((String)vecFacID.get(8)).equalsIgnoreCase("P")&& Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P"))
							{%>
								document.forms[0].txt_margin.readOnly=true;
								document.forms[0].sel_sectype.disabled=true;
								document.forms[0].sel_securitytype.disabled=true;
								document.forms[0].chk_facility.disabled=true;
							<%if(Helper.correctNull((String)vecFacID.get(13)).contains("@SEC@"))
							{%>
								document.forms[0].sel_securitytype.disabled=false;
								document.forms[0].sel_sectype.disabled=false;
								document.forms[0].txt_margin.readOnly=false;
								document.forms[0].chk_facility.disabled=false;
							<%}%>
							<%if(Helper.correctNull((String)vecFacID.get(13)).contains("@MODSEC@"))
							{%>
								document.forms[0].sel_sectype.disabled=false;
								document.forms[0].sel_securitytype.disabled=false;
							<%} 
							if(Helper.correctNull((String)vecFacID.get(13)).equalsIgnoreCase(""))
							{%>
								document.forms[0].txt_margin.readOnly=false;
								document.forms[0].sel_sectype.disabled=false;
								document.forms[0].sel_securitytype.disabled=false;
								document.forms[0].chk_facility.disabled=false;
							<%}
							}%>

							if(!(document.forms[0].chk_facility.checked))
							   {
									document.forms[0].txt_margin.readOnly=true;
									document.forms[0].sel_sectype.disabled=true;
									document.forms[0].sel_securitytype.disabled=true;
							   }
					   <%}else {%>
						 if(document.forms[0].sel_sectype[<%=i%>].value=="2")
					    {
						 document.forms[0].txt_margin[<%=i%>].disabled=true;
			            }
				        else
						{
						document.forms[0].txt_margin[<%=i%>].disabled=false;
						}

						 <%if(Helper.correctNull((String)vecFacID.get(8)).equalsIgnoreCase("P")&& Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P"))
							{%>
								document.forms[0].txt_margin[<%=i%>].readOnly=true;
								document.forms[0].sel_sectype[<%=i%>].disabled=true;
								document.forms[0].sel_securitytype[<%=i%>].disabled=true;
								document.forms[0].chk_facility[<%=i%>].disabled=true;
							<%if(Helper.correctNull((String)vecFacID.get(13)).contains("@SEC@"))
							{%>
								document.forms[0].sel_securitytype[<%=i%>].disabled=false;
								document.forms[0].sel_sectype[<%=i%>].disabled=false;
								document.forms[0].txt_margin[<%=i%>].readOnly=false;
								document.forms[0].chk_facility[<%=i%>].disabled=false;
							<%}%>
							<%if(Helper.correctNull((String)vecFacID.get(13)).contains("@MODSEC@"))
							{%>
								document.forms[0].sel_sectype[<%=i%>].disabled=false;
								document.forms[0].sel_securitytype[<%=i%>].disabled=false;
							<%} 
							if(Helper.correctNull((String)vecFacID.get(13)).equalsIgnoreCase(""))
							{%>
								document.forms[0].txt_margin[<%=i%>].readOnly=false;
								document.forms[0].sel_sectype[<%=i%>].disabled=false;
								document.forms[0].sel_securitytype[<%=i%>].disabled=false;
								document.forms[0].chk_facility[<%=i%>].disabled=false;
							<%}
							}%>
							if(!(document.forms[0].chk_facility[<%=i%>].checked))
							   {
									document.forms[0].txt_margin[<%=i%>].readOnly=true;
									document.forms[0].sel_sectype[<%=i%>].disabled=true;
									document.forms[0].sel_securitytype[<%=i%>].disabled=true;
							   }
				<%}}}%>
							
				
	

}
function doClose()
{	
	var con=ConfirmMsg('100');
	if(con)
	{
			window.close();
	}
}
function checkSecurity()
{
	var secID="";
	var factype="";
	var facsno="";
	var margin="";
	var nature="";
	var limit="";
	var outstand="";
	var type="";
	var sectype="";
	var hidparentappno="";
	var hidparentsno="";
	var bowid="";
	var Sectype="";
	<%
	if(vecData!=null&&vecData.size()>0)
	{
		if(vecData.size()>1)
		{
			for(int l=0; l<vecData.size(); l++)
			{%>
				if(document.forms[0].chk_facility["<%=l%>"].checked==true)
				{
					<%vecRow=(ArrayList) vecData.get(l);
					if(vecRow!=null)
					{%>
						if(document.forms[0].txt_margin["<%=l%>"].value=="")document.forms[0].txt_margin["<%=l%>"].value="";
						secID=secID+"<%=Helper.correctNull((String)vecRow.get(4))%>"+"~";
						factype=factype+"<%=Helper.correctNull((String)vecRow.get(5))%>"+" ~";
						facsno=facsno+"<%=Helper.correctNull((String)vecRow.get(3))%>"+"~";
						margin=margin+document.forms[0].txt_margin["<%=l%>"].value+"~";
						nature=nature+"<%=Helper.correctNull((String)vecRow.get(6))%>"+" ~";
						limit=limit+"<%=Helper.correctNull((String)vecRow.get(1))%>"+"~";
						outstand=outstand+"<%=Helper.correctNull((String)vecRow.get(7))%>"+"~";
						type=type+document.forms[0].txt_type["<%=l%>"].value+"~";
						sectype=sectype+document.forms[0].sel_sectype["<%=l%>"].value+"~";
						hidparentappno=hidparentappno+document.forms[0].hidparentappno["<%=l%>"].value+" ~";
						hidparentsno=hidparentsno+document.forms[0].hidparentsno["<%=l%>"].value+" ~";
						bowid=bowid+"<%=Helper.correctNull((String)vecRow.get(12))%>"+"~";
						Sectype=Sectype+document.forms[0].sel_securitytype["<%=l%>"].value+"~";
					<%}%>
				}
			<%}
		}
		else if(vecData.size()==1)
		{%>
			if(document.forms[0].chk_facility.checked==true)
			{
				<%vecRow=(ArrayList) vecData.get(0);
				if(vecRow!=null)
				{%>
				if(document.forms[0].txt_margin.value=="")document.forms[0].txt_margin.value="";
					secID=secID+"<%=Helper.correctNull((String)vecRow.get(4))%>"+"~";
					factype=factype+"<%=Helper.correctNull((String)vecRow.get(5))%>"+" ~";
					facsno=facsno+"<%=Helper.correctNull((String)vecRow.get(3))%>"+"~";
					margin=margin+document.forms[0].txt_margin.value+"~";
					nature=nature+"<%=Helper.correctNull((String)vecRow.get(6))%>"+" ~";
					limit=limit+"<%=Helper.correctDouble((String)vecRow.get(1))%>"+"~";
					outstand=outstand+"<%=Helper.correctDouble((String)vecRow.get(7))%>"+"~";
					type=type+document.forms[0].txt_type.value+"~";
					sectype=sectype+document.forms[0].sel_sectype.value+"~";
					hidparentappno=hidparentappno+document.forms[0].hidparentappno.value+"~ ";
					hidparentsno=hidparentsno+document.forms[0].hidparentsno.value+"~ ";
					bowid=bowid+"<%=Helper.correctNull((String)vecRow.get(12))%>"+"~";
					Sectype=Sectype+document.forms[0].sel_securitytype.value+"~";
				<%}%>
			}
		<%}
	}
	%>
	document.forms[0].hidSecID.value=secID;
	document.forms[0].hidFacSno.value=facsno;
	document.forms[0].hidFacType.value=factype;
	document.forms[0].hidmargin.value=margin;
	document.forms[0].hidnature.value=nature;
	document.forms[0].hidlimit.value=limit;
	document.forms[0].hidoutstand.value=outstand;
	document.forms[0].hidtype.value=type;
	document.forms[0].hidsectype.value=sectype;
	document.forms[0].hidtype.value=type;
	document.forms[0].hid_ParentAppno.value=hidparentappno;
	document.forms[0].hid_ParentSno.value=hidparentsno;
	document.forms[0].hidBowID.value=bowid;
	document.forms[0].hidsecuritytype.value=Sectype;
}
function doSave()
{
	checkSecurity();

	if(document.forms[0].chk_facility.length >1)
	{
		for(var i=0;i<document.forms[0].chk_facility.length;i++)
		{
				if(document.forms[0].chk_facility[i].checked && document.forms[0].sel_sectype[i].value=="0")
				{
					alert("Select Type");
					document.forms[0].sel_sectype[i].focus();
					return;
				}
				if(document.forms[0].chk_facility[i].checked && document.forms[0].sel_sectype[i].value=="1" && document.forms[0].txt_margin[i].value=="")
				{
					alert("Enter Margin Value");
					document.forms[0].txt_margin[i].focus();
					return;
				}
				if(document.forms[0].chk_facility[i].checked && document.forms[0].sel_securitytype[i].value=="S")
				{
					alert("Select Security Type");
					document.forms[0].sel_securitytype[i].focus();
					return;
				}
		}
	}
	else
	{
			if(document.forms[0].chk_facility.checked && document.forms[0].sel_sectype.value=="0")
			{
				alert("Select Type");
				document.forms[0].sel_sectype.focus();
				return;
			}
			if(document.forms[0].chk_facility.checked && document.forms[0].sel_sectype.value=="1" &&document.forms[0].txt_margin.value=="")
			{
				alert("Enter Margin Value");
				document.forms[0].txt_margin.focus();
				return;
			}
			if(document.forms[0].chk_facility.checked && document.forms[0].sel_securitytype.value=="S")
			{
				alert("Select Security Type");
				document.forms[0].sel_securitytype.focus();
				return;
			}

	}
	document.forms[0].cmdsave.disabled=true;
	var secId=document.forms[0].hidSecID.value;
	var facsno=document.forms[0].hidFacSno.value;
	var factype=document.forms[0].hidFacType.value;
	var facmargin=document.forms[0].hidmargin.value;
	var facnature=document.forms[0].hidnature.value;
	var faclimit=document.forms[0].hidlimit.value;
	var facoutstand=document.forms[0].hidoutstand.value;
	var type=document.forms[0].hidtype.value;
	var sectype=document.forms[0].hidsectype.value;
	var hidparentAppno=document.forms[0].hid_ParentAppno.value;
	var hidparentSno=document.forms[0].hid_ParentSno.value;
	var bowid=document.forms[0].hidBowID.value;
	var securitytype=document.forms[0].hidsecuritytype.value;
	<%if(Securitycount<=1){%>
		window.opener.document.forms[0].hidFacID.value=secId;
		window.opener.document.forms[0].hidFacSno.value=facsno;
		window.opener.document.forms[0].hidFacType.value=factype;
		window.opener.document.forms[0].hidSecMargin.value=facmargin;
		window.opener.document.forms[0].hidFacNature.value=facnature;
		window.opener.document.forms[0].hidFacLimit.value=faclimit;
		window.opener.document.forms[0].hidFacOutstand.value=facoutstand;
		window.opener.document.forms[0].hidType.value=type;
		if(!document.forms[0].hidFacSno.value=="")
		{
			window.opener.document.forms[0].hidSelect.value="Y";
		}
		else
		{
			window.opener.document.forms[0].hidSelect.value="N";
		}
		window.opener.document.forms[0].sel_sectype.value=sectype;
		window.opener.document.forms[0].hid_parentappno.value=hidparentAppno;
		window.opener.document.forms[0].hid_parentsno.value=hidparentSno;
		window.opener.document.forms[0].hidBowID.value=bowid;
		window.opener.document.forms[0].hidsecuritytype.value=securitytype;
		
	<%}else{%>
		window.opener.document.forms[0].hidFacID[<%=hidposition%>].value=secId;
		window.opener.document.forms[0].hidFacSno[<%=hidposition%>].value=facsno;
		window.opener.document.forms[0].hidFacType[<%=hidposition%>].value=factype;
		window.opener.document.forms[0].hidSecMargin[<%=hidposition%>].value=facmargin;
		window.opener.document.forms[0].hidFacNature[<%=hidposition%>].value=facnature;
		window.opener.document.forms[0].hidFacLimit[<%=hidposition%>].value=faclimit;
		window.opener.document.forms[0].hidFacOutstand[<%=hidposition%>].value=facoutstand;
		window.opener.document.forms[0].hidType[<%=hidposition%>].value=type;
		if(!document.forms[0].hidFacSno.value=="")
		{
			window.opener.document.forms[0].hidSelect[<%=hidposition%>].value="Y";
		}
		else
		{
			window.opener.document.forms[0].hidSelect[<%=hidposition%>].value="N";
		}
		window.opener.document.forms[0].sel_sectype[<%=hidposition%>].value=sectype;
		window.opener.document.forms[0].hid_parentappno[<%=hidposition%>].value=hidparentAppno;
		window.opener.document.forms[0].hid_parentsno[<%=hidposition%>].value=hidparentSno;
		window.opener.document.forms[0].hidBowID[<%=hidposition%>].value=bowid;
		window.opener.document.forms[0].hidsecuritytype[<%=hidposition%>].value=securitytype;
		
	<%}%>
	//window.opener.doAttchbtn();
	
	if(VarProposalType!= "P")
	{
	if(varcussectype == "10" || varcussectype == "11"  || varcussectype == "12"  || varcussectype == "13"
		|| varcussectype == "15"  || varcussectype == "16"  || varcussectype == "17")
	{
			
		if(VARSECCERSAIREFNO == "" || VARSECSEARCHPERFORMDATE == "")
		{
			alert("Kindly Enter CERSAI Search Ref. No and search Date field in Home -> Securities -> Property Details ");
			return;
		}
	
		/*if(VARSECSEARCHPERFORMDATE == "")
		{
			alert("Kindly Enter CERSAI search Date  field in Home -> Securities -> Property Details ");
			return;
		}*/

		if(Varcersaidate == 'Y')
		{
			alert("CERSAI search Date for Attached Securities Expired.! please modify in Home -> Securities -> Property Details ");
			return;
		}

		if(Varsecalreadymortg == "")
		{
			alert("Kindly Select Whether property offered is already mortgaged to our Bank field in Home -> Securities -> Property Details ");
			return;
		}
	}
	if(varcussectype == "14")
	{
		if(VarcropType == "")
		{
			alert("Kindly Select Crop type in Home -> Securities -> Property Details ");
			return;
		}
	}
	}
	window.close();
}
function hideMargin(sno)
{
	if(varstrPrd_cgstatus == "Y")
	{
		<%if(intVecSize<=1){ %>
		if(document.forms[0].sel_sectype.value=="2")
		{
		alert("Collateral security cannot be added if the facility is covered under CGTMSE");
		document.forms[0].sel_sectype.value="0";
		document.forms[0].sel_sectype.focus();
		}
		<%}else {%>
		if(document.forms[0].sel_sectype[sno].value=="2")
		{
		alert("Collateral security cannot be added if the facility is covered under CGTMSE");
		document.forms[0].sel_sectype[sno].value="0";
		document.forms[0].sel_sectype[sno].focus();
		}
		<%}%>
	}
	
	<%if(intVecSize<=1){ %>
		if(document.forms[0].sel_sectype.value=="2")
		{
			document.forms[0].txt_margin.value="0.00";
			document.forms[0].txt_margin.disabled=true;
		}
		else
		{	
		document.forms[0].txt_margin.disabled=false;		
		document.forms[0].txt_margin.readOnly=false;		
		}
		<%}else{ %>
		if(document.forms[0].sel_sectype[sno].value=="2")
		{
			document.forms[0].txt_margin[sno].value="0.00";
			document.forms[0].txt_margin[sno].disabled=true;
		}
		else
		{	
		document.forms[0].txt_margin[sno].disabled=false;		
		document.forms[0].txt_margin[sno].readOnly=false;		
		}
		<%}%>

		<%if(intVecSize<=1)
	    { %>
			if(document.forms[0].sel_sectype.value=="2" || document.forms[0].sel_sectype.value=="1")
			{
				document.forms[0].chk_facility.checked=true;
				checkSecurity();
			}
			else
			{	
				document.forms[0].chk_facility.checked=false;	
				checkSecurity();	
			}
		<%}
	    else
	    { %>
			if(document.forms[0].sel_sectype[sno].value=="2" || document.forms[0].sel_sectype[sno].value=="1")
			{
				document.forms[0].chk_facility[sno].checked=true;
				checkSecurity();
			}
			else
			{	
				document.forms[0].chk_facility[sno].checked=false;
				checkSecurity();		
			}
		<%} %>
		<%if(intVecSize<=1)
	    { %>
			if(document.forms[0].sel_sectype.value=="1")
			{
				document.forms[0].txt_margin.value="";
			}
		<%}
	    else
	    { %>
			if(document.forms[0].sel_sectype[sno].value=="1")
			{
			document.forms[0].txt_margin[sno].value="";
			}
		<%} %>
}	
function chkenablefield(sno)
{
	<%if(intVecSize<=1)
    { %>
		document.forms[0].txt_margin.readOnly=false;
		document.forms[0].sel_sectype.disabled=false;
		document.forms[0].sel_securitytype.disabled=false;
	<%}
    else
    { %>
		document.forms[0].txt_margin[sno].readOnly=false;
		document.forms[0].sel_sectype[sno].disabled=false;
		document.forms[0].sel_securitytype[sno].disabled=false;
	<%} %>	
}
function chkapprovedsec(val,sno)
{
	if(val=="N")
	{
		<%if(intVecSize<=1)
	    { %>
	    	if(document.forms[0].chk_facility.checked)
	    	{
		    	alert("You cannot attach unapproved company share as a Security");
		    	document.forms[0].chk_facility.checked=false;
		    	return;
	    	}
		<%}
	    else
	    { %>
	    if(document.forms[0].chk_facility[sno].checked)
    	{
	    	alert("You cannot attach unapproved company share as a Security");
	    	document.forms[0].chk_facility[sno].checked=false;
	    	return;
    	}
		<%} %>
	}
}
</SCRIPT>
</head>
<body onload="onload();">
<form method="post" class="normal">

						<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
							<tr>
								<td valign="top">
								<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
									<tr>
										<td>
										<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
											
											<tr>
												<td>
												<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable"  align="center">
													<tr class="">
														<td colspan="3"  align="left"><b>Securities Attach</b>
														</td>
													</tr>
													<tr class="dataheader">
														<td align="center"><b>Security Value</b>
														</td>
														<td align="right"><b><%=Helper.correctNull((String)request.getParameter("secValue"))%>&nbsp;</b>
														</td>
														
													</tr>
												</table>	
												<br>
												<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable"  align="center">	
												
												<%
										
											if(str_Proposed.equalsIgnoreCase("Y"))
											{
												%>
													<tr class="dataheader">
														<td width="5%"  align="center">&nbsp;
														</td>
														<td width="55%"  align="center">Facility 
														</td>
														<td width="55%"  align="center">Type 
														</td>
														<td width="20%"  align="center">Amount
														</td>
														<td width="20%"  align="center">Margin (%)
														</td>
														<td width="20%"  align="center">Security Type</td>
													</tr>
												
												<tr class="dataheader">
															<td width="100%" align="left" colspan="6"><b>Proposed Facilities</b></td>
													</tr>
												<%
											int vecsize = 0;
											if (vecData != null) 
											{
												vecsize = vecData.size();
											
											for (int i = 0; i < vecsize; i++) 
											{
												vecRow = (ArrayList) vecData.get(i);
												if (vecRow != null) 
												{
													if(Helper.correctNull((String) vecRow.get(8)).equalsIgnoreCase("P")){
											%>		
												<tr class="datagrid">
													<td width="5%"><input type="checkbox" name="chk_facility" value="" style="border-style: none" onClick="chkapprovedsec('<%=Helper.correctNull((String) vecRow.get(15)) %>','<%=i%>');checkSecurity();chkenablefield('<%=i%>');"></td>
													<td width="55%"><%=Helper.correctNull((String) vecRow.get(0))%> <input type="hidden" name="txt_facility" value="<%=Helper.correctNull((String) vecRow.get(0))%>"> </td>
													<td width="20%" align="center">
													<input type="hidden" name="hidparentappno" value="">
													<input type="hidden" name="hidparentsno" value="">
													<select name="sel_sectype" onChange="hideMargin('<%=i%>')">
																<option value="0" >--Select--</option>
																<option value="1">Primary</option>
																<option value="2">Collateral</option>
															</select><input type="hidden" name="txt_type" value="<%=Helper.correctNull((String) vecRow.get(8))%>"></td>
													<td width="20%" align="right"><%=Helper.correctNull((String) vecRow.get(1))%><input type="hidden" name="txt_amount" value="<%=Helper.checkDecimal(Helper.correctNull((String) vecRow.get(1)))%>"></td>
													<td width="20%" align="right"><input type="text" id="hidMarginId" name="txt_margin" style="text-align: right;" onblur="checkSecurity();checkPercentage(this);roundtxt(this)"></td>
													<td><select name="sel_securitytype">
																<option value="S" >--Select--</option>
																<option value="F">Fresh</option>
																<option value="E">Existing</option>
															</select></td>
												</tr>
											<%}	} }
											} else {
											%>
											<tr class="datagrid">
													<td width="100%" align="center" colspan="5">&nbsp;NO FACILITIES &nbsp;</td>
											</tr>
											<%}} 
											if(str_Existing.equalsIgnoreCase("Y"))
											{
												%><tr><td colspan="5">&nbsp;</td></tr>
													<tr class="dataheader">
														<td width="5%"  align="center">&nbsp;
														</td>
														<td width="55%"  align="center">Facility 
														</td>
														<td width="55%"  align="center">Type 
														</td>
														<td width="20%"  align="center">Amount
														</td>
														<td width="20%"  align="center">Margin (%)
														</td>
														<td width="20%"  align="center">Security Type</td>
													</tr>
												
										
									
													<tr class="dataheader">
													<td width="100%" align="left" colspan="6"><b>Existing Facilities</b></td>
											</tr>
												<%
											int vecsize = 0;
											if (vecData != null) 
											{
												vecsize = vecData.size();
											
											for (int i = 0; i < vecsize; i++) 
											{
												vecRow = (ArrayList) vecData.get(i);
												if (vecRow != null) 
												{
													if(Helper.correctNull((String) vecRow.get(8)).equalsIgnoreCase("E")){
											%>		
												<tr class="datagrid">
													<td width="5%"><input type="checkbox" name="chk_facility" value="<%=Helper.correctNull((String) vecRow.get(4))%>" style="border-style: none" onClick="checkSecurity()"></td>
													<td width="55%"><%=Helper.correctNull((String) vecRow.get(0))%> <input type="hidden" name="txt_facility" value="<%=Helper.correctNull((String) vecRow.get(0))%>"> </td>
													<td width="20%" align="center">
													<input type="hidden" name="hidparentappno" value="<%=Helper.correctNull((String) vecRow.get(10))%>">
													<input type="hidden" name="hidparentsno" value="<%=Helper.correctNull((String) vecRow.get(11))%>">
													<select name="sel_sectype">
																<option value="0" >--Select--</option>
																<option value="1" >Primary</option>
																<option value="2" >Collateral</option>
															</select><input type="hidden" name="txt_type" value="<%=Helper.correctNull((String) vecRow.get(8))%>"></td>
													<td width="20%" align="right"><%=Helper.correctNull((String) vecRow.get(1))%><input type="hidden" name="txt_amount" value="<%=Helper.checkDecimal(Helper.correctNull((String) vecRow.get(1)))%>"></td>
													<td width="20%" align="right"><input type="text" name="txt_margin" style="text-align: right;" onblur="checkSecurity();checkPercentage(this);roundtxt(this)"></td>
													<td><select name="sel_securitytype">
																<option value="S" >--Select--</option>
																<option value="F">Fresh</option>
																<option value="E">Existing</option>
															</select></td>
												</tr>
											<%}	} }
											} else {
											%>
											<tr class="dataheader">
													<td width="100%" align="center" colspan="5">&nbsp;NO FACILITIES &nbsp;</td>
											</tr>
											<%}} %>
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
				<table width="15%" border='1' cellspacing='0' cellpadding='0' class='outertable' align="center">
				<tr>
				<td>
					<table border='0' cellspacing='0' cellpadding='3' >
					<tr>
						<td width="7%"><input type="button" name="cmdsave" value="Save" class="buttonOthers"
						onClick="doSave()">
						</td>
						<td width="8%"><input id="attachbtn" type="button" name="cmdclose" value="Close" class="buttonClose"
						onClick="doClose()"></td>
					</tr>
					</table>
				</td>
				</tr>
				</table>
<lapschoice:hiddentag pageid='<%=PageId%>'/>

<INPUT TYPE="hidden" name="hidAppType" value="P"> 
<input type="hidden" name="hidDemoId"> 
<input type="hidden" name="hid_rowcount" value=""> 
<input type="hidden" name="readFlag" value="<%=Helper.correctNull((String)session.getAttribute("strGroupRights")).charAt(18)%>">
<input type="hidden" name="hidCategoryType" value="<%=Helper.correctNull((String)request.getParameter("hidCategoryType"))%>">
<input type="hidden" name="hidSecID" value="">  
<input type="hidden" name="hidFacSno" value="">  
<input type="hidden" name="hidFacType" value="">  
<input type="hidden" name="hidmargin" value="">  
<input type="hidden" name="hidnature" value="">  
<input type="hidden" name="hidlimit" value="">  
<input type="hidden" name="hidoutstand" value="">
<input type="hidden" name="hidtype" value="">
<input type="hidden" name="hidsectype" value="">
<input type="hidden" name="hidsecuritytype" value="">
 <input type="hidden" name="hid_ParentAppno" value="">
<input type="hidden" name="hid_ParentSno" value="">
<input type="hidden" name="hidBowID" value="">
</form>
</body>
</html>
