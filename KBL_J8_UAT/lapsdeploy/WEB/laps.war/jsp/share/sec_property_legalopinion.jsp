<%@include file="../share/directives.jsp"%>
<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<%
String sectype = Helper.correctNull((String) request.getParameter("hidsectype"));
String strsecID = Helper.correctNull((String) request.getParameter("hidsecid"));
String strPagefrom = Helper.correctNull((String) request.getParameter("pagefrom"));
String loan_type = Helper.correctNull((String) request.getParameter("apploantype"));
String strSecId = Helper.correctNull((String) session.getAttribute("strSecId"));
if(strSecId.equalsIgnoreCase(""))
{
	strSecId=Helper.correctNull((String)request.getParameter("hidSecurityId"));
}
String grpRights = Helper.correctNull((String) session.getAttribute("strGroupRights"));

%>
<lapschoice:handleerror />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Security - Property Details</title>
<script>

var varElitePanel="<%=Helper.correctNull((String)hshValues.get("sec_pl_elitepanel"))%>";
var varFlow="<%=Helper.correctNull((String)hshValues.get("SEC_PL_TITLE"))%>";
var varEC="<%=Helper.correctNull((String)hshValues.get("SEC_PL_EC"))%>";
var varMorg="<%=Helper.correctNull((String)hshValues.get("SEC_PL_MORTG"))%>";
var curdate = "<%=Helper.getCurrentDateTime()%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
var varPropFlag="<%=Helper.correctNull((String)hshValues.get("strPropFlag"))%>";
var varVerificationFlag="<%=Helper.correctNull((String)hshValues.get("hid_VerificationFlag"))%>";
var strPagefrom="<%=strPagefrom%>";
var varSearchProp="<%=Helper.correctNull((String)hshValues.get("SEC_PL_SEARCHFROM_PROP"))%>";
var varPeriod_EC="<%=Helper.correctNull((String)hshValues.get("SEC_PL_PERIOD_EC"))%>";
var currentDate="<%=Helper.getCurrentDateTime()%>";
function showOrganisationSearch(varAppUrl,varSelLoc,varTxtLoc)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showOrgSearch(varAppUrl,varSelLoc,varTxtLoc);
	}
}

function callsupnam(varFrom)
{
	var action=document.forms[0].hidAction.value;
	if(document.forms[0].cmdsave.disabled==false)
	{
		var prop = "scrollbars=no,width=500,height=400,top=100,left=250";
		var url=appURL+"action/lawyermaster_retail.jsp?hidBeanId=staticdata&hidBeanGetMethod=getLawyerMaster_legal&hidAction=legal&strfrom="+varFrom;
		window.open(url,"",prop);
		//document.forms[0].cmdaudittrail.disabled=false;
	}
}

function dobtnClose()
{
	if (ConfirmMsg(100)) 
	{
		if(strPagefrom=="secmailbox")
		{
			window.close();
		}
		else
		{
			document.forms[0].hidBeanId.value="securitymaster"
			document.forms[0].hidBeanGetMethod.value="getSecurityValuesDetails";
			document.forms[0].action=appURL+"action/securitiesMasterPage.jsp";
			document.forms[0].submit();
		}
	}
}

function showCitySearch(varTextControl,varTextControl1,varHidControl,varHidControl1,varTextControl2,varHidControl2)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		var varQryString = "<%=ApplicationParams.getAppUrl()%>action/searchCity.jsp?hidcitycontrol="+varTextControl+"&hidstatecontrol="+varTextControl1+"&hidcitycodecontrol="+varHidControl+"&hidstatecodecontrol="+varHidControl1+"&hidzipcontrol="+varTextControl2+"&hidzipvaildatorcontrol="+varHidControl2;
		var title = "City";
		var prop = "scrollbars=yes,width=650,height=400,menubar=yes";	
		var xpos = (screen.width - 350) / 2;
		var ypos = (screen.height - 120) / 2;
		prop = prop + ",left=50,top=50";
		window.open(varQryString,title,prop);
	}
}
function callOnLoad()
{ 
	
	govtValuerCheck();
	if(varElitePanel!="" && varElitePanel!="S"){
		document.forms[0].sel_elitepanel_leg.value=varElitePanel;
		document.forms[0].old_sel_elitepanel_legText.value = document.forms[0].sel_elitepanel_leg.options[document.forms[0].sel_elitepanel_leg.selectedIndex].text; 
	}
	else{
		document.forms[0].sel_elitepanel_leg.value="S";
		document.forms[0].old_sel_elitepanel_legText.value = ""; 
	}
	if(varFlow!="" && varFlow!="0")
	{
        document.forms[0].sel_flowtitle.value=varFlow;
		document.forms[0].old_sel_flowtitleText.value = document.forms[0].sel_flowtitle.options[document.forms[0].sel_flowtitle.selectedIndex].text; 
	}
	else
	{
		document.forms[0].sel_flowtitle.value="0";
		document.forms[0].old_sel_flowtitleText.value =""; 
	}
	if(varEC!="" && varEC!="0")
	{
		document.forms[0].sel_ec.value=varEC;
		document.forms[0].old_sel_ecText.value = document.forms[0].sel_ec.options[document.forms[0].sel_ec.selectedIndex].text; 
	}
	else
	{
		document.forms[0].sel_ec.value="0";
		document.forms[0].old_sel_ecText.value = ""; 
	}
	if(varMorg!="" && varMorg!="0")
	{
		document.forms[0].sel_tomrec.value=varMorg;
		document.forms[0].old_sel_tomrecText.value = document.forms[0].sel_tomrec.options[document.forms[0].sel_tomrec.selectedIndex].text; 
	}
	else
	{
		document.forms[0].sel_tomrec.value="0";
		document.forms[0].old_sel_tomrecText.value = ""; 
	}
	
	disableFields(true);
	<%if(loan_type.equalsIgnoreCase("p")){ %>
		<%if(Helper.correctNull((String)request.getParameter("btnenable")).equalsIgnoreCase("Y")){%>
			disableButtons(false,true,true,true,false,false);
		<%}else{%>
			disableButtons(true,true,true,true,false,true);
		<%}%>
	<%}else{%>
	disableButtons(false,true,true,true,false,true);	
	<%}%>

	<%if(grpRights.charAt(18)=='r'){%>
	<%if(!strPagefrom.equalsIgnoreCase("appl")&&!strPagefrom.equalsIgnoreCase("secmailbox")){%>
	document.forms[0].cmdedit.disabled=true;
	<%}%>
<%}%>
	

	clearrows("tabid_valuerlist");
	<%if(!strPagefrom.equalsIgnoreCase("appl")&&!strPagefrom.equalsIgnoreCase("secmailbox")){%>
	document.forms[0].cmdedit.disabled=true;
	<%}%>
	propvalue();
	Period_EC();
	<%if(!strPagefrom.equalsIgnoreCase("appl")&&!strPagefrom.equalsIgnoreCase("secmailbox")){%>
	document.forms[0].cmdedit.disabled=false;
    <%}%>
	if(varVerificationFlag=="V")
	{
		<%if(!strPagefrom.equalsIgnoreCase("appl")&&!strPagefrom.equalsIgnoreCase("secmailbox")){%>
		document.forms[0].cmdedit.disabled=true;
		<%}%>
	}
	if(varPropFlag!="Y")
	{
		alert("Please fill Property Details tab");
		<%if(!strPagefrom.equalsIgnoreCase("appl")&&!strPagefrom.equalsIgnoreCase("secmailbox")){%>
		document.forms[0].cmdedit.disabled=true;
		<%}%>
	}
	
}
function clearrows(tabid)
{
	var table=document.getElementById(tabid);
	var rowCount=table.rows.length;
	if(rowCount > 0)
	{
		for(var i=rowCount-1;i>0;i--)
		{
			table.deleteRow(i);      
		}
	}
}
function doEdit()
{
	disableFields(false);
	disableButtons(true,false,false,false,true,false);
	document.forms[0].txt_nameofadviser.readOnly=true;
	document.forms[0].sel_elitepanel_leg.disabled=true;
	document.forms[0].txt_legalauditor.readOnly=true;
}

function propvalue()
{
	if(varSearchProp!="")
	{
		var temp= varSearchProp.split("@");
		var valuerlen=temp.length;
		for(var i=0;i<valuerlen;i++)
		{
			 if(valuerlen==1)
			 {
				 var valtemp=temp[i].split("~");
				 
				 document.forms[0].txt_searchfrom_prop.value=valtemp[0];
				 document.forms[0].txt_searchto_prop.value = valtemp[1];
		    	 
			 }else
			 {
				 Addvaluer();
				 var valtemp=temp[i].split("~");
				 document.forms[0].txt_searchfrom_prop[i].value=valtemp[0];
		    	 document.forms[0].txt_searchto_prop[i].value = valtemp[1];
		    	
			 }

		 }
		if(valuerlen!=1)
		 {
			deleteRow("tabid_valuerlist");
		 }
	}
	else
	{
		 //Addvaluer();
	}

}

function datefromval(obj,varRowindex,tabname)
{
	if(tabname=="tabid_valuerlist")
	{
		var tab  = document.getElementById("tabid_valuerlist");
		var rowsLength = tab.rows.length;
		var pagedate=obj.value;
		var pgdt=changeDateformat(pagedate);
		var varc = changeDateformat(currentDate);
		var vartodate;
		if(rowsLength==1)
		{
	    	if(obj.value!="")
			{
	    		alert("chking");
	    		var val=document.forms[0].txt_searchto_prop.value;
	    		var maxdt=changeDateformat(val);
				if(Date.parse(pgdt) > Date.parse(maxdt))
				{
					alert("Date cannot be Greater than " +val );
					obj.value="";
					obj.focus();
				}
				if(Date.parse(pgdt) > Date.parse(varc))
				{
					alert("Date Cannot be future date");
					obj.value="";
					obj.focus();
					return false;
				}
			}
		}else if(rowsLength>=1)
		{
			for(var i=0;i<rowsLength;i++)
			{	
				if(obj.value!="")
				{
					var vartodate=eval("document.forms[0].txt_searchto_prop["+varRowindex+"]");
		    		var val=vartodate.value;
		    		var maxdt=changeDateformat(val);
					if(Date.parse(pgdt) > Date.parse(maxdt))
					{
						alert("Date cannot be Greater than " +val );
						obj.value="";
						obj.focus();
					}
					if(Date.parse(pgdt) > Date.parse(varc))
					{
						alert("Date Cannot be future date");
						obj.value="";
						obj.focus();
						return false;
					}
				}
			}
		}
	}
	else if(tabname=="tabid_valuerlist1")
	{
		var tab  = document.getElementById("tabid_valuerlist1");
		var rowsLength = tab.rows.length;
		var pagedate=obj.value;
		var pgdt=changeDateformat(pagedate);
		var vartodate;
		if(rowsLength==1)
		{
	    	if(obj.value!="")
			{
	    		var val=document.forms[0].txt_PeriodTo_Ec.value;
	    		var maxdt=changeDateformat(val);
				if(Date.parse(pgdt) > Date.parse(maxdt))
				{
					alert("Date cannot be Greater than " +val );
					obj.value="";
					obj.focus();
				}
			}
		}else if(rowsLength>=1)
		{
			for(var i=0;i<rowsLength;i++)
			{	
				if(obj.value!="")
				{
					var vartodate=eval("document.forms[0].txt_PeriodTo_Ec["+varRowindex+"]");
		    		var val=vartodate.value;
		    		var maxdt=changeDateformat(val);
					if(Date.parse(pgdt) > Date.parse(maxdt))
					{
						alert("Date cannot be Greater than " +val );
						obj.value="";
						obj.focus();
					}
				}
			}
		}
	}	
}

function datetoval(obj,varRowindex,tabname)
{ 
	if(tabname=="tabid_valuerlist")
	{
		var tab  = document.getElementById("tabid_valuerlist");
		var rowsLength = tab.rows.length;
		var pagedate=obj.value;
		var pgdt=changeDateformat(pagedate);
		var varc = changeDateformat(currentDate);
		var vartodate;
		if(rowsLength==1)
		{
	    	if(obj.value!="")
			{
	    		var val=document.forms[0].txt_searchfrom_prop.value;
	    		var maxdt=changeDateformat(val);
				if(Date.parse(pgdt) < Date.parse(maxdt))
				{
					alert("Date cannot be lesser than " +val );
					obj.value="";
					obj.focus();
				}
				if(Date.parse(pgdt) > Date.parse(varc))
				{
					alert("Date Cannot be future date");
					obj.value="";
					obj.focus();
					return false;
				}
			}
		}else if(rowsLength>=1)
		{
			for(var i=0;i<rowsLength;i++)
			{	
				if(obj.value!="")
				{
					var vartodate=eval("document.forms[0].txt_searchfrom_prop["+varRowindex+"]");
		    		var val=vartodate.value;
		    		var maxdt=changeDateformat(val);
					if(Date.parse(pgdt) < Date.parse(maxdt))
					{
						alert("Date cannot be lesser than " +val );
						obj.value="";
						obj.focus();
					}
					if(Date.parse(pgdt) > Date.parse(varc))
					{
						alert("Date Cannot be future date");
						obj.value="";
						obj.focus();
						return false;
					}
				}
			}
		}
	}
	else if(tabname=="tabid_valuerlist1")
	{
		var tab  = document.getElementById("tabid_valuerlist1");
		var rowsLength = tab.rows.length;
		var pagedate=obj.value;
		var pgdt=changeDateformat(pagedate);
		var vartodate;
		if(rowsLength==1)
		{
	    	if(obj.value!="")
			{
	    		var val=document.forms[0].txt_PeriodFrom_Ec.value;
	    		var maxdt=changeDateformat(val);
				if(Date.parse(pgdt) < Date.parse(maxdt))
				{
					alert("Date cannot be lesser than " +val );
					obj.value="";
					obj.focus();
				}
			}
		}else if(rowsLength>=1)
		{
			for(var i=0;i<rowsLength;i++)
			{	
				if(obj.value!="")
				{
					var vartodate=eval("document.forms[0].txt_PeriodFrom_Ec["+varRowindex+"]");
		    		var val=vartodate.value;
		    		var maxdt=changeDateformat(val);
					if(Date.parse(pgdt) < Date.parse(maxdt))
					{
						alert("Date cannot be lesser than " +val );
						obj.value="";
						obj.focus();
					}
				}
			}
		}
	}
}

function Period_EC()
{
	if(varPeriod_EC!="")
	{
		var temp= varPeriod_EC.split("@");
		var valuerlen=temp.length;
		for(var i=0;i<valuerlen;i++)
		{
			
			 if(valuerlen==1)
			 {
				 var valtemp=temp[i].split("~");
				 if(valtemp[0]==undefined){valtemp[0]="";}
				 if(valtemp[1]==undefined){valtemp[1]="";}
				 document.forms[0].txt_PeriodFrom_Ec.value=valtemp[0];
				 document.forms[0].txt_PeriodTo_Ec.value = valtemp[1];
		    	 
			 }else
			 {
				 Addvaluer1();
				 var valtemp=temp[i].split("~");
				 if(valtemp[0]==undefined){valtemp[0]="";}
				 if(valtemp[1]==undefined){valtemp[1]="";}
				 document.forms[0].txt_PeriodFrom_Ec[i].value=valtemp[0];
		    	 document.forms[0].txt_PeriodTo_Ec[i].value = valtemp[1];
		    	
			 }
		 }

		if(valuerlen!=1)
		 {
			deleteRow("tabid_valuerlist1");
		 }
	}
	else
	{
		 //Addvaluer1();
	}

}
function doSave()
{
	var s="";
	var tab  = document.getElementById("tabid_valuerlist");
	var rowsLength = tab.rows.length;
	
	if(rowsLength==1)
	{
		if(document.forms[0].txt_searchfrom_prop.value=="")
		{
			alert("Select Search /flow of title on property conducted /obtained FROM");
			document.forms[0].txt_searchfrom_prop.focus();
			return;
		}
		else if(document.forms[0].txt_searchto_prop.value=="")
		{
			alert("Select Search /flow of title on property conducted /obtained TO");
			document.forms[0].txt_searchto_prop.focus();
			return;
		}
		if(document.forms[0].txt_searchfrom_prop.value!=undefined)
		{
        	s = document.forms[0].txt_searchfrom_prop.value+"~"+document.forms[0].txt_searchto_prop.value;
		}   
		else
		{
			s = document.forms[0].txt_searchfrom_prop[0].value+"~"+document.forms[0].txt_searchto_prop[0].value;
		} 
    }
	else if(rowsLength>1)
	{
		for(var i=0;i<rowsLength;i++)
		{
			if(document.forms[0].txt_searchfrom_prop[i].value=="")
			{
				alert("Select Search /flow of title on property conducted /obtained FROM");
				document.forms[0].txt_searchfrom_prop[i].focus();
				return;
			}
			else if(document.forms[0].txt_searchto_prop[i].value=="")
			{
				alert("Select Search /flow of title on property conducted /obtained TO");
				document.forms[0].txt_searchto_prop[i].focus();
				return;
			}
			if(s=="")
			{
		        s = document.forms[0].txt_searchfrom_prop[i].value+"~"+document.forms[0].txt_searchto_prop[i].value;    
	        }
	        else
	        {
	        	s =s+"@"+document.forms[0].txt_searchfrom_prop[i].value+"~"+document.forms[0].txt_searchto_prop[i].value;    
	        }

		}
    }
    document.forms[0].hid_flowprop_dt.value = s;
    //====================
    var Ec="";
	var tab  = document.getElementById("tabid_valuerlist1");
	var rowsLength = tab.rows.length;

	
	if(rowsLength==1)
	{
		if(document.forms[0].sel_ec.value!="n"){
			if(document.forms[0].txt_PeriodFrom_Ec.value=="")
			{
				alert("Enter Period of EC From");
				document.forms[0].txt_PeriodFrom_Ec.focus();
				return;
			}
			else if(document.forms[0].txt_PeriodTo_Ec.value=="")
			{
				alert("Enter Period of EC To");
				document.forms[0].txt_PeriodTo_Ec.focus();
				return;
			}
		}
		if(document.forms[0].txt_PeriodFrom_Ec.value!=undefined)
		{
			Ec = document.forms[0].txt_PeriodFrom_Ec.value+"~"+document.forms[0].txt_PeriodTo_Ec.value;
		}    
		else
		{
			Ec = document.forms[0].txt_PeriodFrom_Ec[0].value+"~"+document.forms[0].txt_PeriodTo_Ec[0].value;
		}
    }
	else if(rowsLength>1)
	{
		for(var i=0;i<rowsLength;i++)
		{
			if(document.forms[0].sel_ec.value!="n"){
				if(document.forms[0].txt_PeriodFrom_Ec[i].value=="")
				{
					alert("Enter Period of EC From");
					document.forms[0].txt_PeriodFrom_Ec[i].focus();
					return;
				}
				else if(document.forms[0].txt_PeriodTo_Ec[i].value=="")
				{
					alert("Enter Period of EC To");
					document.forms[0].txt_PeriodTo_Ec[i].focus();
					return;
				}
			}
			if(Ec=="")
			{
				Ec = document.forms[0].txt_PeriodFrom_Ec[i].value+"~"+document.forms[0].txt_PeriodTo_Ec[i].value;    
	        }
	        else
	        {
	        	Ec =Ec+"@"+document.forms[0].txt_PeriodFrom_Ec[i].value+"~"+document.forms[0].txt_PeriodTo_Ec[i].value;    
	        }

		}
    }
    document.forms[0].hid_Period_Ec.value = Ec;
	if(document.forms[0].txt_nameofadviser.value=="")
	{
		ShowAlert('121',"Name of the Legal opinion Adviser");
		document.forms[0].txt_nameofadviser.focus();
		return false;
	}
	var lawyerCode=document.forms[0].hid_sno.value;
	if(lawyerCode=="2062"){
		if(document.forms[0].txt_gvtscheme_name.value=="")
		{
			alert("Specify Govt Lawyer name");
			document.forms[0].txt_gvtscheme_name.focus();
			return false;
		}
	}
	if(document.forms[0].txt_dateofsubmissionbybank.value=="")
	{
		ShowAlert('121',"Date of submission of request for Legal opinion by bank");
		document.forms[0].txt_dateofsubmissionbybank.focus();
		return false;
	}
	if(document.forms[0].txt_dateofreceiptbybank.value=="")
	{
		ShowAlert('121',"Date of receipt of Legal Opinion Report by bank");
		document.forms[0].txt_dateofreceiptbybank.focus();
		return false;
	}
	if(document.forms[0].txt_date_leaglopinion.value=="")
	{
		ShowAlert('121',"Date of Legal Opinion (As per Report)");
		document.forms[0].txt_date_leaglopinion.focus();
		return false;
	}
	/*if(document.forms[0].txt_cersid.value=="")
	{
		ShowAlert('121',"CERSAI ID");
		document.forms[0].txt_cersid.focus();
		return false;
	}*/
	if(document.forms[0].sel_flowtitle.value=="0")
	{
		ShowAlert('111',"Flow of Title for 30 years obtained");
		document.forms[0].sel_flowtitle.focus();
		return false;
	}
	if(document.forms[0].sel_ec.value=="0")
	{
		ShowAlert('111',"EC for last 14 years obtained");
		document.forms[0].sel_ec.focus();
		return false;
	}
	if(document.forms[0].txt_taxpaidtear.value=="")
	{
		ShowAlert('121',"Latest Tax Paid Receipt");
		document.forms[0].txt_taxpaidtear.focus();
		return false;
	}

	if(document.forms[0].hid_sno.value!="" && (document.forms[0].txt_nameofadviser.value==document.forms[0].txt_legalauditor.value || 
			document.forms[0].hid_sno.value==document.forms[0].hid_legalauditorsno.value))
	{
		alert("Legal opinion Adviser and Legal audit adviser should not be same");
		return false;
	}

	modifyCheck();
	
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].sel_elitepanel_leg.disabled=false;
	document.forms[0].hidAction.value="insert";
	document.forms[0].hidBeanId.value="securitymaster";
	document.forms[0].hidBeanMethod.value="updateLegalOpinion";
	document.forms[0].hidBeanGetMethod.value="getLegalOpinion";
	document.forms[0].hidSourceUrl.value="/action/sec_property_legalopinion.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function modifyCheck()
{
	var temp="";
	var tempname="";

	document.forms[0].sel_flowtitleText.value=document.forms[0].sel_flowtitle.options[document.forms[0].sel_flowtitle.selectedIndex].text;
	document.forms[0].sel_ecText.value=document.forms[0].sel_ec.options[document.forms[0].sel_ec.selectedIndex].text;

	if(document.forms[0].sel_tomrec.value=="0")
		document.forms[0].sel_tomrecText.value="";
	else
		document.forms[0].sel_tomrecText.value=document.forms[0].sel_tomrec.options[document.forms[0].sel_tomrec.selectedIndex].text;

	if(document.forms[0].sel_elitepanel_leg.value=="S")
		document.forms[0].sel_elitepanel_legText.value="";
	else
		document.forms[0].sel_elitepanel_legText.value=document.forms[0].sel_elitepanel_leg.options[document.forms[0].sel_elitepanel_leg.selectedIndex].text;

	if(document.forms[0].sel_flowtitleText.value!=document.forms[0].old_sel_flowtitleText.value)
	{
		temp=temp+"old_sel_flowtitleText"+"@"; 
		tempname=tempname+"Flow of Title for 30 years obtained"+"@";
	}
	if(document.forms[0].sel_ecText.value!=document.forms[0].old_sel_ecText.value)
	{
		temp=temp+"old_sel_ecText"+"@"; 
		tempname=tempname+"EC for last 14 years obtained "+"@";
	}
	if(document.forms[0].sel_tomrecText.value!=document.forms[0].old_sel_tomrecText.value)
	{
		temp=temp+"old_sel_tomrecText"+"@"; 
		tempname=tempname+"Type of Mortgage Recommended"+"@";
	}
	if(document.forms[0].sel_elitepanel_legText.value!=document.forms[0].old_sel_elitepanel_legText.value)
	{
		temp=temp+"old_sel_elitepanel_legText"+"@"; 
		tempname=tempname+"Elite Panel Advocate "+"@";
	}

	//text
	if(document.forms[0].txt_nameofadviser.value!=document.forms[0].old_txt_nameofadviser.value)
	{
		temp=temp+"old_txt_nameofadviser"+"@"; 		tempname=tempname+"Name of the Legal opinion Adviser  "+"@";
	}
	if(document.forms[0].txt_date_leaglopinion.value!=document.forms[0].old_txt_date_leaglopinion.value)
	{
		temp=temp+"old_txt_date_leaglopinion"+"@"; 		tempname=tempname+"Date of Legal Opinion  "+"@";
	}
	if(document.forms[0].txt_date_supleaglopinion.value!=document.forms[0].old_txt_date_supleaglopinion.value)
	{
		temp=temp+"old_txt_date_supleaglopinion"+"@"; 		tempname=tempname+"Date of Supplementary Legal Opinion"+"@";
	}
	if(document.forms[0].txt_date_leaglaudrep.value!=document.forms[0].old_txt_date_leaglaudrep.value)
	{
		temp=temp+"old_txt_date_leaglaudrep"+"@"; 		tempname=tempname+"Date of Legal Audit Report"+"@";
	}
	//if(document.forms[0].txt_cersid.value!=document.forms[0].old_txt_cersid.value)
	//{
	//	temp=temp+"old_txt_cersid"+"@"; 		tempname=tempname+"CERSAI ID"+"@";
	//}
	if(document.forms[0].txt_taxpaidtear.value!=document.forms[0].old_txt_taxpaidtear.value)
	{
		temp=temp+"old_txt_taxpaidtear"+"@"; 		tempname=tempname+"Latest Tax Paid Receipt"+"@";
	}	
	if(document.forms[0].txt_dateofsubmissionbybank.value!=document.forms[0].old_txt_dateofsubmissionbybank.value)
	{
		temp=temp+"old_txt_dateofsubmissionbybank"+"@"; 		tempname=tempname+"Legal opinion-Date of submission of request"+"@";
	}	
	if(document.forms[0].txt_dateofreceiptbybank.value!=document.forms[0].old_txt_dateofreceiptbybank.value)
	{
		temp=temp+"old_txt_dateofreceiptbybank"+"@"; 		tempname=tempname+"Legal opinion-Date of receipt of valuation report"+"@";
	}
	//if(document.forms[0].txt_date_chargecreation.value!=document.forms[0].old_txt_date_chargecreation.value)
	//{
		//temp=temp+"old_txt_date_chargecreation"+"@"; 		tempname=tempname+"Date of creation of charge in CERSAI"+"@";
	//}

	//ROC charge create date
	if(document.forms[0].txt_roccharge_createdt.value!=document.forms[0].old_txt_roccharge_createdt.value)
	{
		temp=temp+"old_txt_roccharge_createdt"+"@"; 		tempname=tempname+"ROC charge create date"+"@";
	}
	//Equitable Mortgage/Registered Mortgage created on
	if(document.forms[0].txt_mortgage_createdon.value!=document.forms[0].old_txt_mortgage_createdon.value)
	{
		temp=temp+"old_txt_mortgage_createdon"+"@"; 		tempname=tempname+"Equitable Mortgage/Registered Mortgage created on"+"@";
	}
	if(document.forms[0].hid_flowprop_dt.value!=document.forms[0].old_hid_flowprop_dt.value)
	{
		temp=temp+"old_hid_flowprop_dt"+"@"; 		tempname=tempname+"Search /flow of title on property conducted /obtained"+"@";
	}
	if(document.forms[0].hid_Period_Ec.value!=document.forms[0].old_hid_Period_Ec.value)
	{
		temp=temp+"old_hid_Period_Ec"+"@"; 		tempname=tempname+"Period of EC"+"@";
	}
	if(document.forms[0].txt_legalauditor.value!=document.forms[0].old_txt_legalauditor.value)
	{
		temp=temp+"old_txt_legalauditor"+"@"; 		tempname=tempname+"Name of the Legal Audit Adviser"+"@";
	}

	
		
	  document.forms[0].hidmodifiedvalue.value = temp;
	  document.forms[0].hidmodifiedField.value = tempname;
}
function doCancel()
{
	if(ConfirmMsg('102'))
	{
		document.forms[0].action=appURL+"action/sec_property_legalopinion.jsp";
		document.forms[0].hidBeanId.value="securitymaster";
	  	document.forms[0].hidBeanGetMethod.value="getLegalOpinion";
	  	document.forms[0].submit();
	}
}
function doDelete()
{
	if(ConfirmMsg('101'))
	{
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidBeanId.value="securitymaster";
		document.forms[0].hidBeanGetMethod.value="getLegalOpinion";
		document.forms[0].hidBeanMethod.value="updateLegalOpinion";
		document.forms[0].hidSourceUrl.value="/action/sec_property_legalopinion.jsp";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
	}
}
function doClose()
{
	if(ConfirmMsg('100'))
	{
		document.forms[0].action=appURL+"action/mainnav.jsp";
		document.forms[0].submit();
	}
}
function disableFields(bool)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=bool;
		}	  
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=bool;
		}
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=bool;		  
		}		
	}

}
function disableButtons(cmdEdit,cmdSave,cmdCancel,cmdDelete,cmdClose,cmdComments)
{
	<%if(!strPagefrom.equalsIgnoreCase("appl")&&!strPagefrom.equalsIgnoreCase("secmailbox")){%>
	
	document.forms[0].cmdedit.disabled=cmdEdit;
	document.forms[0].cmdsave.disabled=cmdSave;
	document.forms[0].cmdcancel.disabled=cmdCancel;
	document.forms[0].cmddelete.disabled=cmdDelete;
	document.forms[0].cmdclose.disabled=cmdClose;
	document.forms[0].cmdcomments.disabled=cmdComments;
	<%}%>
}
function callCalender(name) {

	if (document.forms[0].cmdsave.disabled == false) {

		showCal(appURL, name);
	}
}

function checkyear()
{
	var eyear=document.forms[0].txt_taxpaidtear.value;
	var cyear=curdate.substr(6,10);		
	if(parseInt(eyear)>parseInt(cyear))
	{
     alert("Year can't be greater than"+" "+cyear);
     document.forms[0].txt_taxpaidtear.value="";
     document.forms[0].txt_taxpaidtear.focus();
     return false;
	}
}

function doComments()
{
	
	var btnenable="<%=Helper.correctNull((String)request.getParameter("btnenable"))%>";
	var hidAppNo=document.forms[0].hidSecurityId.value;	
	var prop = "scrollbars=yes,width=750,height=550,top=25,left=180";
	var url=appURL+"action/comments.jsp?hidBeanId=perfinancial&hidBeanGetMethod=getComments&hidAppNo="+hidAppNo+"&hidCommentPage=securityLegalOpinion&btnenable="+btnenable+"&appstatus="+appstatus;
	window.open(url,"Comments",prop);
}

function Addvaluer()
{
	if(document.forms[0].cmdedit.disabled==true)
	{	
	var tab  = document.getElementById("tabid_valuerlist");
	var rowsLength = tab.rows.length;
	if(rowsLength<=200)
	{
		var new_Row    = tab.insertRow(rowsLength);
		var rwlength=rowsLength;
		new_Row.id=""+rowsLength;
		var previous_RowCells=tab.rows[rowsLength-1].cells; 
		for(i=0;i<previous_RowCells.length;i++)
		{
			var new_RowCell=new_Row.insertCell(i);
			new_RowCell.innerHTML=previous_RowCells[i].innerHTML;
			new_RowCell.align="center";
			var new_CellElement=new_RowCell.childNodes[0];
			if(i==0)
	        {
	        	new_RowCell.align="center";
	        }
			for(var j=0;j<new_RowCell.childNodes.length;j++)
			{
				if(new_RowCell.childNodes[j].type=="text")
				{
					new_RowCell.childNodes[j].value="";
					new_RowCell.childNodes[j].disabled=false;
				}
			}
			 
		}
	}
	else
	{
		alert("Cannot add more rows");
	}
	//ClearFields();
}
}



function deleteRow(tableid)
{
	if(document.forms[0].cmdedit.disabled==true)
	{
		var table=document.getElementById(tableid);
		var rowCount=table.rows.length; 
		
		if(rowCount==1){
	       alert("Atleast one data is needed");
	       return;
		}
		else{
			 table.deleteRow(rowCount-1);
		}
	}
}

function callCalender_mul(name,rowindex) 
{
	if(rowindex=="0")
	{
		var tab  = document.getElementById("tabid_valuerlist");
		var rowsLength = tab.rows.length;
		if(rowsLength==1)
		{
			if (document.forms[0].cmdsave.disabled == false) 
			{
				showCal(appURL, name);
			}
		}
		else
		{
			name=name+"["+(rowindex)+"]";
			if (document.forms[0].cmdsave.disabled == false) 
			{

				showCal(appURL, name);
			}
		}
	}
	else
	{
		name=name+"["+(rowindex)+"]";
		if (document.forms[0].cmdsave.disabled == false) 
		{
			showCal(appURL, name);
		}
	}
}

function checklegalopinionrep(date)
{
	if(date=="")
	{
		alert("Please enter Date of submission of request for legal opinion by bank");
		document.forms[0].txt_dateofreceiptbybank.value="";
		document.forms[0].txt_dateofsubmissionbybank.focus();
	 	return false;
	}
}


function Addvaluer1(){

	if(document.forms[0].cmdedit.disabled==true)
	{	
	var tab  = document.getElementById("tabid_valuerlist1");
	var rowsLength = tab.rows.length;
	if(rowsLength<=200)
	{
		var new_Row    = tab.insertRow(rowsLength);
		
		var rwlength=rowsLength;
		new_Row.id=""+rowsLength;
		var previous_RowCells=tab.rows[rowsLength-1].cells; 
		for(i=0;i<previous_RowCells.length;i++)
		{
			var new_RowCell=new_Row.insertCell(i);
			new_RowCell.innerHTML=previous_RowCells[i].innerHTML;
			new_RowCell.align="center";
			new_RowCell.className="datagrid";
			var new_CellElement=new_RowCell.childNodes[0];
			if(i==0)
	        {
	        	new_RowCell.align="center";
	        }
			for(var j=0;j<new_RowCell.childNodes.length;j++)
			{
				if(new_RowCell.childNodes[j].type=="text")
				{
					new_RowCell.childNodes[j].value="";
					new_RowCell.childNodes[j].disabled=false;
				}
			}
			 
		}
	}
	else
	{
		alert("Cannot add more rows");
	}
	//ClearFields();
}
}

function deleteRow1(tabid,tdcount)
{
	if(document.forms[0].cmdedit.disabled==true)
	{
		var tab = document.getElementById(tabid);
		var rowsLength = tab.rows.length;
		var varCheckedFlag=false;
		if(rowsLength>=1)
		{
			for(var i=0;i<rowsLength;i++)
			{
				var current_row = tab.rows[i];
				var chkbox = current_row.cells[tdcount].childNodes[0];
				if(chkbox != null && chkbox.checked == true)
				{
					 if(tabid=="tabid_valuerlist1" && rowsLength=="1")
					{
						document.forms[0].txt_PeriodFrom_Ec.value="";  
						document.forms[0].txt_PeriodTo_Ec.value="";  
					    chkbox.checked=false; 
					    return;
					}
					else
					{
						tab.deleteRow(i);
						rowsLength--;
						i--;
					}

					if(!varCheckedFlag)
					{
						varCheckedFlag=true;
					}
				}
			}
			if(!varCheckedFlag)
			{
				alert("Please select the check box for deletion");
			}
		}
	}
}

function callCalender_mul_Ec(name,rowindex) 
{
	if(rowindex=="0")
	{
		var tab  = document.getElementById("tabid_valuerlist1");
		var rowsLength = tab.rows.length;
		if(rowsLength==1)
		{
			if (document.forms[0].cmdsave.disabled == false) 
			{
				showCal(appURL, name);
			}
		}
		else
		{
			name=name+"["+(rowindex)+"]";
			if (document.forms[0].cmdsave.disabled == false) 
			{

				showCal(appURL, name);
			}
		}
	}
	else
	{
		name=name+"["+(rowindex)+"]";
		if (document.forms[0].cmdsave.disabled == false) 
		{
			showCal(appURL, name);
		}
	}
}
function govtValuerCheck(){
	
	var lawyerCode=document.forms[0].hid_sno.value;
	if(lawyerCode=="2062"){
		document.all.govt_name.style.visibility="visible";
		document.all.govt_name.style.position="relative";
	}else{
		document.all.govt_name.style.visibility="hidden";
		document.all.govt_name.style.position="absolute";
	}
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
</head>
<body onload="callOnLoad();">
<form name="frmpropdet" method="post" class="normal">
<%if(loan_type.equalsIgnoreCase("p")){ %>

<table width="100%" border="0" cellpadding="0" cellspacing="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../share/Applurllinkper.jsp" flush="true">
			<jsp:param name="pageid" value="1" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="outertable">
			<tr>
				<td class="page_flow">Home -&gt; Retail(including schematic) -&gt; Application
				-&gt; Loan Particulars -&gt; Proposed/Offered Asset - &gt; Legal Opinion</td>

			</tr>
		</table>
		<table width="100%" border="0" cellpadding="0" cellspacing="0"
			class="outertable">
			<tr>
				<td><lapschoice:application /></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td valign="bottom">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			align="left" class="outertable">
			<tr align="center">
				<td><jsp:include page="../per/applicanttab.jsp" flush="true">
					<jsp:param name="linkid" value="5" />
				</jsp:include></td>
			</tr>
		</table>
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			align="left" class="outertable">
			<tr>
				<td><jsp:include page="../per/ProposedAssetTabs.jsp"
					flush="true">
					<jsp:param name="tabid" value="5" />
				</jsp:include></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<%}else if(strPagefrom.equalsIgnoreCase("appl")){ %>
 <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="33" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Security Master -&gt; Property Details</td>
	</tr>
</table>
<span style="display: none"><lapschoice:borrowertype /></span> <lapschoice:application />
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../set/appurlsectabs.jsp" flush="true">
			<jsp:param name="pageid" value="11" />
		</jsp:include>
		</td>
	</tr>
</table>
<%}else if(strPagefrom.equals("secmailbox")) { %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
<tr>
	<td valign="top">
	<jsp:include page="../set/appurlsectabs.jsp" flush="true">
		<jsp:param name="pageid" value="101" />
	</jsp:include>
	</td>
</tr>
</table>		
<%}else{%>
<table width="98%" border="0" cellspacing="1" cellpadding="3"	class="outertable" align="center">
	<tr class="dataheader">
		<td align="left" width="10%"><b>Customer Name</b></td>
		<td align="left" width="30%"><b><%=Helper.correctNull((String)hshValues.get("perapp_fname"))%>&nbsp;</b></td>
		<td align="left" width="10%"><b>Customer CBSID</b></td>
		<td align="left" width="20%"><b><%=Helper.correctNull((String)hshValues.get("perapp_cbsid"))%>&nbsp;</b></td>
		<td align="left" width="10%"><b>Customer LAPS ID</b></td>
		<td align="left" width="20%"><b><%=Helper.correctNull((String)hshValues.get("perapp_oldid"))%>&nbsp;</b></td>
	</tr>
</table>
<table width="98%" border="0" cellspacing="1" cellpadding="3" class="outertable" align="center">
<tr>
	<td class="page_flow" colspan="2">Home -&gt; Securities -&gt; Legal Opinion</td>
</tr>
</table>
<table width="98%" border="0" cellspacing="1" cellpadding="3" class="outertable" align="center">
<tr>
<td>
<table width="38%" border="0" cellspacing="0" cellpadding="0" class="outertable">
<tr>
<td class="sub_tab_inactive_new" align="center">
	<b><a href="JavaScript:gototab('securitymaster','getSecurities','customer_securities.jsp')">
	Security Details</a></b>
</td>
	<td class="sub_tab_inactive_new"  align="center"><b><a
					href="JavaScript:gototab('securitymaster','getPropertyDetData','sec_propertydet.jsp')">Property Details</a></b></td>
<td  class="sub_tab_active_new" align="center"><b>Legal Opinion</b></td>
</tr>
</table>
</td>
</tr>
</table>
<%}%>
<table width="80%" border="0" cellpadding="3" cellspacing="0" align="center" class="outertable" style="border: 2px solid #dccada;">
<tr>
	<td>
		<table width="80%" border="0" cellspacing="0" cellpadding="5" class="outertable" align="center">
		<tr>
			<td>
				<table width="80%" border="0" cellspacing="0" cellpadding="5" class="outertable" align="center">
				<tr>
					<td> Security ID :  <span style="color:#750b6a"> <%=Helper.correctNull((String)hshValues.get("strSecID"))%> </span>  </td>	
				</tr>
				<tr>
				 <td>Name of the Legal opinion Adviser&nbsp;<b><span class="mantatory">*</span></b></td>
				 <td nowrap="nowrap"><input type="text" name="txt_nameofadviser" maxlength="50" size="55" onkeypress="allowAlphabetsForName()" onblur="govtValuerCheck();" value="<%=Helper.correctNull((String)hshValues.get("SEC_PL_LAWNAME"))%>">
				 <input type="hidden" name="hid_sno" value="<%=Helper.correctNull((String)hshValues.get("sec_lawyer_seqno")) %>">
				 <span onClick="callsupnam('legal')" style="cursor: hand"><img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0"></span>
				 </td>				
				</tr>
					<tr id="govt_name">
						<td>Specify the Name(GOVT LAWYER)</td>
						<td><input type="text" name="txt_gvtscheme_name" size="30"
							maxlength="29" value="<%=Helper.correctNull((String)hshValues.get("SEC_PL_GOVT_LAWYERNAME"))%>" onKeyPress="notAllowSplChar()"></td>
					</tr>
					<tr>
                   <td>Elite Panel Advocate</td>
                   <td> <select name="sel_elitepanel_leg"
							 tabindex="20">
							<option value="S">---Select---</option>
                        <option value="N">No</option>
                        <option value="Y">Yes</option>
                      </select></td>
                  </tr>
				 <tr>
                   <td>Date of submission of request for legal opinion by bank<span class="mantatory">*&nbsp;</span></td>
                   <td><input type="text" name="txt_dateofsubmissionbybank" size="11"
							value="<%=Helper.correctNull((String)hshValues.get("sec_pl_legsubmitteddate"))%>"
							onBlur="checkDate(this);checkmaxdate(this,curdate);checkmaxdate(this,document.forms[0].txt_date_leaglopinion.value)" maxlength="10" tabindex="15">
		    <a alt="Select date from calender" href="#"
							onClick="callCalender('txt_dateofsubmissionbybank')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" tabindex="29"></a> </td>
                   <td>Date of receipt of Legal Opinion report by bank<span class="mantatory">*&nbsp;</span></td>
                   <td nowrap="nowrap"><input type="text" name="txt_dateofreceiptbybank" size="11"
							value="<%=Helper.correctNull((String)hshValues.get("sec_pl_legrecvdate"))%>"
							onBlur="checkDate(this);checkmaxdate(this,curdate);checkmindate(this,document.forms[0].txt_dateofsubmissionbybank.value);checklegalopinionrep(document.forms[0].txt_dateofsubmissionbybank.value)" maxlength="10" tabindex="15">
		    <a alt="Select date from calender" href="#"
							onClick="callCalender('txt_dateofreceiptbybank')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" tabindex="29"></a> </td>
                  </tr>
                  
                  
				<tr>
				 <td>Date of Legal Opinion (As per Report)&nbsp;<b><span class="mantatory">*</span></b></td>
				 <td> 
              <input type="text" name="txt_date_leaglopinion" size="11"
							value="<%=Helper.correctNull((String)hshValues.get("SEC_PL_LEGOPDATE"))%>"
							onBlur="checkDate(this);checkmaxdate(this,curdate);checkmindate(this,document.forms[0].txt_dateofsubmissionbybank.value)" maxlength="12" tabindex="15">
		    <a alt="Select date from calender" href="#"
							onClick="callCalender('txt_date_leaglopinion')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" tabindex="29"></a></td>
							<td nowrap="nowrap">Date of Supplementary Legal Opinion</td>
				 <td nowrap="nowrap"> 
              <input type="text" name="txt_date_supleaglopinion" size="11"
							value="<%=Helper.correctNull((String)hshValues.get("SEC_PL_LEGOPSUPDATE"))%>"
							onBlur="checkDate(this);checkmaxdate(this,curdate)" maxlength="12" tabindex="15">
		    <a alt="Select date from calender" href="#"
							onClick="callCalender('txt_date_supleaglopinion')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" tabindex="29"></a></td>
				</tr>
				
				<tr>
				 <td>Name of the Legal Audit Adviser&nbsp;</td>
				 <td nowrap="nowrap"><input type="text" name="txt_legalauditor" maxlength="50" size="55"  value="<%=Helper.correctNull((String)hshValues.get("sec_legalaudit_lawyername"))%>">
				 <input type="hidden" name="hid_legalauditorsno" value="<%=Helper.correctNull((String)hshValues.get("sec_legalaudit_lawyersno")) %>">
				 <span onClick="callsupnam('legal1')" style="cursor: hand"><img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0"></span>
				 </td>				
				</tr>
				
				<tr>
				 <td>Date of Legal Audit Report</td>
				 <td> 
              <input type="text" name="txt_date_leaglaudrep" size="11"
							value="<%=Helper.correctNull((String)hshValues.get("SEC_PL_LEGALAUDREPDATE"))%>"
							onBlur="checkDate(this);checkmaxdate(this,curdate)" maxlength="12" tabindex="15">
		    <a alt="Select date from calender" href="#"
							onClick="callCalender('txt_date_leaglaudrep')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" tabindex="29"></a></td>	
							<!--<td>CERSAI ID&nbsp;</td>	
							<td><input type="text" name="txt_cersid" maxlength="30" size="25" onkeypress="allowAlphaNumericSpace()" value="<%=Helper.correctNull((String)hshValues.get("SEC_PL_CERSID"))%>"></td>-->
				</tr>
				<%-- <tr>
				 	<td>Date of creation of charge in CERSAI</td>
				 	<td> 
              			<input type="text" name="txt_date_chargecreation" size="11"
							value="<%=Helper.correctNull((String)hshValues.get("SEC_PL_CHARGECREATIONDATE"))%>"
							onBlur="checkDate(this);checkmaxdate(this,curdate)" maxlength="12" tabindex="15">
		   					 <a alt="Select date from calender" href="#"
							onClick="callCalender('txt_date_chargecreation')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" tabindex="29"></a></td>	
				
				</tr>--%>
				<tr>
				
				<td nowrap="nowrap">Flow of Title for 30 years obtained&nbsp;<b><span class="mantatory">*</span></b></td>
				<td><select name="sel_flowtitle">
				<option value="0">--Select--</option>
				<option value="y">Yes</option>
				<option value="n">No</option>			
				</select></td>	
				<td nowrap="nowrap">EC for last 14 years obtained&nbsp;<b><span class="mantatory">*</span></b></td>
				<td><select name="sel_ec">
				<option value="0">--Select--</option>
				<option value="y">Yes</option>
				<option value="n">No</option>			
				</select></td>				
				</tr>
				
					<tr>				
				<td nowrap="nowrap">Latest Tax Paid Receipt (Year)&nbsp;<b><span class="mantatory">*</span></b></td>
				<td><input type="text" name="txt_taxpaidtear" maxlength="4" size="5" onkeypress="allowInteger()" value="<%=Helper.correctNull((String)hshValues.get("SEC_PL_TAX"))%>"  onblur="checkyear()"></td>
				<td nowrap="nowrap">Type of Mortgage Recommended</td>
				<td><select name="sel_tomrec">
				<option value="0">--Select--</option>
				<option value="E">Equitable</option>
				<option value="R">Registered</option>
				<option value="O">Others</option>			
				</select></td>			
				</tr>
				
				<tr>
				<td nowrap="nowrap">ROC charge create date</td>
				<td><input type="text" name="txt_roccharge_createdt" size="11"
							value="<%=Helper.correctNull((String)hshValues.get("SEC_PL_ROC_CHARGE_CREATEDDT"))%>"
							onBlur="checkDate(this);checkmaxdate(this,curdate)" maxlength="12" tabindex="15">
		    				<a alt="Select date from calender" href="#"
							onClick="callCalender('txt_roccharge_createdt')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" tabindex="29"></a>
				</td>
				<td nowrap="nowrap">Equitable Mortgage/Registered Mortgage created on</td>
				<td nowrap="nowrap"> 
              		<input type="text" name="txt_mortgage_createdon" size="11"
							value="<%=Helper.correctNull((String)hshValues.get("SEC_PL_MORTGAGE_CREATED_ON"))%>"
							onBlur="checkDate(this);checkmaxdate(this,curdate)" maxlength="12" tabindex="15">
		    				<a alt="Select date from calender" href="#"
							onClick="callCalender('txt_mortgage_createdon')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" tabindex="29"></a>
				</td>
				</tr>
				
				
				<tr>
				<td nowrap="nowrap" valign="top">Search /flow of title on property conducted /obtained&nbsp;<b><span class="mantatory">*</span></b></td>
				<td > 
				<table width="100%" border="0"  align="center" class="outertable" id="tabid_valuerlist">
				<tr align="center" id="0">	
					<td  width="20%">FROM<input type="text" name="txt_searchfrom_prop" size="11"
							value="" onBlur="checkDate(this);datefromval(this,this.parentNode.parentNode.id,'tabid_valuerlist')" maxlength="10" tabindex="15">
		   					 <a alt="Select date from calender" 
							onClick="callCalender_mul('txt_searchfrom_prop',this.parentNode.parentNode.id)"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" tabindex="29"></a> </td>	
				
					 <td  width="20%">TO<input type="text" name="txt_searchto_prop" size="11"
							value="" onBlur="checkDate(this);datetoval(this,this.parentNode.parentNode.id,'tabid_valuerlist');" maxlength="10" tabindex="15">
		    				<a alt="Select date from calender"
							onClick="callCalender_mul('txt_searchto_prop',this.parentNode.parentNode.id)"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" tabindex="29"></a> </td>
					</tr>
				</table>
				</td> 
				<td valign="top"><span style="width: 20%;"><a onClick="Addvaluer();"><img
							src="<%=ApplicationParams.getAppUrl()%>img/add.png"
							border="0" tabindex="38"></a>&nbsp;&nbsp;&nbsp;
					 		<a onClick="deleteRow('tabid_valuerlist');"><img
							src="<%=ApplicationParams.getAppUrl()%>img/cancel.png"
							border="0" tabindex="38"></a> </span>
					</td>
				
				</tr>
				<tr>
				<td valign="top" >Period of EC&nbsp;<b><span class="mantatory">*</span>
				<span style="width: 20%;float: right;" ><a onClick="Addvaluer1();"><img
							src="<%=ApplicationParams.getAppUrl()%>img/add.png"
							border="0" tabindex="38"></a>&nbsp;&nbsp;&nbsp;
					 		<a onClick="deleteRow('tabid_valuerlist1');"><img
							src="<%=ApplicationParams.getAppUrl()%>img/cancel.png"
							border="0" tabindex="38"></a> </span>
				</td>
				<td> 
				<table width="100%" border="0"  align="center" class="outertable" id="tabid_valuer">
					<tr class="dataheader" align="center">
						<td width="20%"> From </td>
						<td width="20%"> TO </td>
					</tr>
					</table>
				<table width="100%" border="0"  align="center" class="outertable" id="tabid_valuerlist1">
				<tr align="center" id="0" class="datagrid" >	
				
					<td  width="20%" nowrap="nowrap"> <input type="text" name="txt_PeriodFrom_Ec" size="11"
							value="" onBlur="checkDate(this);checkmaxdate(this,curdate);datefromval(this,this.parentNode.parentNode.id,'tabid_valuerlist1')" maxlength="10" tabindex="15">
		   					 <a alt="Select date from calender" 
							onClick="callCalender_mul_Ec('txt_PeriodFrom_Ec',this.parentNode.parentNode.id)"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" tabindex="29"></a> </td>	
				
					 <td  width="20%" nowrap="nowrap"><input type="text" name="txt_PeriodTo_Ec" size="11"
							value="" onBlur="checkDate(this);checkmaxdate(this,curdate);datetoval(this,this.parentNode.parentNode.id,'tabid_valuerlist1');" maxlength="10" tabindex="15">
		    				<a alt="Select date from calender"
							onClick="callCalender_mul_Ec('txt_PeriodTo_Ec',this.parentNode.parentNode.id)"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" tabindex="29"></a> </td>
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
<%if(strPagefrom.equalsIgnoreCase("appl")||strPagefrom.equalsIgnoreCase("secmailbox")){%>
 <table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable" align="center">
  <tr><td align="center"> 
    <input type="button" name="cmdclose" value="Close" onClick="dobtnClose()"  class="buttonClose"> 
  </td></tr>
 </table>
<%}else{ %>
<lapschoice:combuttonnew
	btnnames='Edit_Save_Cancel_Delete_Comments_Audit Trail'
	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<%} %>
<br>
<input type="hidden" name="hidzip" value="<%=Helper.correctNull((String) hshValues.get("state_validatepin"))%>" />
<lapschoice:hiddentag pageid='<%=PageId%>' />
<input type="hidden" name="txtperapp_appid" value="<%=Helper.correctNull((String) hshValues.get("applicantId"))%>">
<input type="hidden" name="hidDemoId" value="<%=Helper.correctNull((String) request.getParameter("hidDemoId"))%>">
<input type="hidden" name="hidSecurityId" value="<%=Helper.correctNull((String)hshValues.get("strSecID"))%>">
<input type="hidden" name="hidsectype" value="<%=sectype%>">
<input type="hidden" name="hidsecid" value="<%=strsecID%>">

<input type="hidden" name="hidmodifiedvalue">  
<input type="hidden" name="hidmodifiedField">  

<input type="hidden" name="old_txt_nameofadviser" value="<%=Helper.correctNull((String) hshValues.get("SEC_PL_LAWNAME"))%>">
<input type="hidden" name="old_txt_date_leaglopinion" value="<%=Helper.correctNull((String) hshValues.get("SEC_PL_LEGOPDATE"))%>">
<input type="hidden" name="old_txt_date_supleaglopinion" value="<%=Helper.correctNull((String) hshValues.get("SEC_PL_LEGOPSUPDATE"))%>">
<input type="hidden" name="old_txt_date_leaglaudrep" value="<%=Helper.correctNull((String) hshValues.get("SEC_PL_LEGALAUDREPDATE"))%>">
<input type="hidden" name="old_txt_cersid" value="<%=Helper.correctNull((String) hshValues.get("SEC_PL_CERSID"))%>">
<input type="hidden" name="old_txt_taxpaidtear" value="<%=Helper.correctNull((String) hshValues.get("SEC_PL_TAX"))%>">
<input type="hidden" name="old_sel_flowtitleText" >
<input type="hidden" name="old_sel_ecText" >
<input type="hidden" name="old_sel_tomrecText" >
<input type="hidden" name="old_sel_elitepanel_legText" >
<input type="hidden" name="old_txt_date_chargecreation" value="<%=Helper.correctNull((String) hshValues.get("SEC_PL_CHARGECREATIONDATE"))%>">

<input type="hidden" name="old_txt_dateofsubmissionbybank" value="<%=Helper.correctNull((String) hshValues.get("sec_pl_legsubmitteddate"))%>">
<input type="hidden" name="old_txt_dateofreceiptbybank" value="<%=Helper.correctNull((String) hshValues.get("sec_pl_legrecvdate"))%>">

<input type="hidden" name="old_txt_roccharge_createdt" value="<%=Helper.correctNull((String) hshValues.get("SEC_PL_ROC_CHARGE_CREATEDDT"))%>">
<input type="hidden" name="old_txt_mortgage_createdon" value="<%=Helper.correctNull((String) hshValues.get("SEC_PL_MORTGAGE_CREATED_ON"))%>">

<input type="hidden" name="sel_flowtitleText" >
<input type="hidden" name="sel_ecText" >
<input type="hidden" name="sel_tomrecText" >
<input type="hidden" name="sel_elitepanel_legText" >
<input type="hidden" name="hid_VerificationFlag" value="<%=Helper.correctNull((String) hshValues.get("hid_VerificationFlag"))%>" />

<input type="hidden" name="hid_flowprop_dt" value="<%=Helper.correctNull((String) hshValues.get("SEC_PL_SEARCHFROM_PROP")) %>">
<input type="hidden" name="old_hid_flowprop_dt"  value="<%=Helper.correctNull((String) hshValues.get("SEC_PL_SEARCHFROM_PROP")) %>">
<input type="hidden" name="hid_Period_Ec" >
<input type="hidden" name="old_hid_Period_Ec" value="<%=Helper.correctNull((String) hshValues.get("SEC_PL_PERIOD_EC")) %>">
<input type="hidden" name="old_txt_legalauditor" value="<%=Helper.correctNull((String) hshValues.get("sec_legalaudit_lawyername")) %>">
</form>
</body>
</html>