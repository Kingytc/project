<%@include file="../share/directives.jsp"%>
<%
	String stroptions = " ";
	String strappnonew = request.getParameter("appno");
	request.setAttribute("_cache_refresh", "true");
%>
<html>
<head>
<title>Proposed Asset</title>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/per/perpropertydetails.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script>
var prop_mortgage="<%=Helper.correctNull((String)hshValues.get("prop_mortgage"))%>";
var prop_allotted="<%=Helper.correctNull((String)hshValues.get("prop_allotted"))%>";
var prop_purpose="<%=Helper.correctNull((String)hshValues.get("prop_purpose"))%>";
var prop_type="<%=Helper.correctNull((String)hshValues.get("prop_type"))%>";
var appno  ="<%=strappnonew%>";
var prop_own_status="<%=Helper.correctNull((String)hshValues.get("prop_own_status"))%>";
var prop_dwelling_unit="<%=Helper.correctNull((String)hshValues.get("prop_dwelling_unit"))%>";
var prop_house_rent="<%=Helper.correctNull((String)hshValues.get("prop_house_rent"))%>";
var qualityconst="<%=Helper.correctNull((String)hshValues.get("qualityconst"))%>";
var presenceamenities="<%=Helper.correctNull((String)hshValues.get("presenceamenities"))%>";
var marketability="<%=Helper.correctNull((String)hshValues.get("marketability"))%>";
var propertytype2="<%=Helper.correctNull((String)hshValues.get("propertytype2"))%>";
var prop_cost="<%=Helper.correctNull((String)hshValues.get("prop_cost"))%>";
var prd = "<%=session.getAttribute("strProductType")%>";
<% String prd_type = Helper.correctNull((String)session.getAttribute("strProductType"));%>
var chk_location1 = "<%=Helper.correctNull((String)hshValues.get("prop_location1"))%>";
var chk_location2 = "<%=Helper.correctNull((String)hshValues.get("prop_location2"))%>";
var chk_location3 = "<%=Helper.correctNull((String)hshValues.get("prop_location3"))%>";
var chk_location4 = "<%=Helper.correctNull((String)hshValues.get("prop_location4"))%>";
var chk_amenities1 = "<%=Helper.correctNull((String)hshValues.get("prop_amenities1"))%>";
var chk_amenities2 = "<%=Helper.correctNull((String)hshValues.get("prop_amenities2"))%>";
var chk_amenities3 = "<%=Helper.correctNull((String)hshValues.get("prop_amenities3"))%>";
var chk_amenities4 = "<%=Helper.correctNull((String)hshValues.get("prop_amenities4"))%>";

var prop_liensociety="<%=Helper.correctNull((String)hshValues.get("prop_liensociety"))%>";
var prop_outstandingsociety="<%=Helper.correctNull((String)hshValues.get("prop_outstandingsociety"))%>";
var prop_societypermission="<%=Helper.correctNull((String)hshValues.get("prop_societypermission"))%>";
var varRecordflag="<%=Helper.correctNull((String)hshValues.get("recordflag"))%>";

var nature = "<%=Helper.correctNull((String)hshValues.get("prop_nature"))%>";
var first_mortgage= "<%=Helper.correctNull((String)hshValues.get("prop_first_mortgage"))%>";
var currentdate= "<%=Helper.getCurrentDateTime()%>";
var varAppStatus = "<%=Helper.correctNull((String)request.getParameter("strappstatus"))%>";

function showCitySearch(varTextControl,varTextControl1,varHidControl,varHidControl1,varTextControl2,varHidControl2)
{
	if(document.forms[0].hideditflag.value=="Y")
	{
		var varQryString = appURL+"action/searchCity.jsp?hidcitycontrol="+varTextControl+"&hidstatecontrol="+varTextControl1+"&hidcitycodecontrol="+varHidControl+"&hidstatecodecontrol="+varHidControl1+"&hidzipcontrol="+varTextControl2+"&hidzipvaildatorcontrol="+varHidControl2;
		var title = "City";
		var prop = "scrollbars=yes,width=650,height=400,menubar=yes";	
		var xpos = (screen.width - 350) / 2;
		var ypos = (screen.height - 120) / 2;
		prop = prop + ",left=50,top=50";
		window.open(varQryString,title,prop);
	}
}

function openotherdet()
{
	var varQryString = appURL+"action/propotherinfo.jsp?hidBeanId=perpropertydetails&hidBeanGetMethod=getotherinfodetails&appno="+ appno;
	var title = "Cost and Source";
	var prop = "scrollbars=yes,width=800,height=550";	
	prop = prop + ",left=100,top=50";
	window.open(varQryString,"",prop);
}

function callonload()
{
	showage();
	document.forms[0].prop_allotted.value=prop_allotted;
	document.forms[0].prop_purpose.value=prop_purpose;
	document.forms[0].prop_type.value=prop_type;
	document.forms[0].prop_cost.value=prop_cost;
	
	if(nature!="")
	{
	 	document.forms[0].sel_nature.value=nature;
	}
	if(first_mortgage!="")
	{
		document.forms[0].firstmortgage.value=first_mortgage;
	}
	if(prop_mortgage!="")
	{
	 	document.forms[0].prop_mortgage.value=prop_mortgage;
	}
	if(prop_purpose=="")
	{
	   	document.forms[0].prop_purpose.value=0;
	}
	if(prop_own_status!="")
	{
		document.forms[0].sel_own.value=prop_own_status;
	}
	if(prop_dwelling_unit!="")
	{
		document.forms[0].sel_dwell.value=prop_dwelling_unit;
	}
	if(prop_house_rent!="")
	{
		document.forms[0].sel_house.value=prop_house_rent;
	}	
	if(prop_type!="")
	{
		document.forms[0].prop_type.value=prop_type;
	}
	if(qualityconst!="")
	{
		document.forms[0].qualityconst.value=qualityconst;
	}	
	if(presenceamenities!="")
	{
		document.forms[0].presenceamenities.value=presenceamenities;
	}
	if(marketability!="")
	{
		document.forms[0].marketability.value=marketability;
	}
	if(propertytype2!="")
	{
		document.forms[0].propertytype2.value=propertytype2;
	}
	if(chk_location1=="Y")
	{
		document.forms[0].chk_mainroad.checked=true;
	}
	else
	{
		document.forms[0].chk_mainroad.checked=false;
	}
	if(chk_location2=="Y")
	{
		document.forms[0].chk_public.checked=true;
	}
	else
	{
		document.forms[0].chk_public.checked=false;
	}
	if(chk_location3=="Y")
	{
		document.forms[0].chk_eduinstitution.checked=true;
	}
	else
	{
		document.forms[0].chk_eduinstitution.checked=false;
	}
	if(chk_location4=="Y")
	{		
		document.forms[0].chk_prime.checked=true;
	}
	else
	{
		document.forms[0].chk_prime.checked=false;
	}
	if(chk_amenities1=="Y")
	{
		document.forms[0].chk_accessible.checked=true;
	}
	else
	{
		document.forms[0].chk_accessible.checked=false;
	}
	if(chk_amenities2=="Y")
	{
		document.forms[0].chk_assured.checked=true;
	}
	else
	{
		document.forms[0].chk_assured.checked=false;
	}
	if(chk_amenities3=="Y")
	{
		document.forms[0].chk_drainages.checked=true;
	}
	else
	{
		document.forms[0].chk_drainages.checked=false;
	}
	if(chk_amenities4=="Y")
	{		
		document.forms[0].chk_currentconnection.checked=true;
	}
	else
	{
		document.forms[0].chk_currentconnection.checked=false;
	}
	if(document.forms[0].prop_totalcost.value=="")
	{
		document.forms[0].prop_totalcost.value="0.00";
	}
	if(document.forms[0].prop_totalfund.value=="")
	{
		document.forms[0].prop_totalfund.value="0.00";
	}
	
	if(prop_liensociety!="")
	{
		document.forms[0].prop_liensociety.value=prop_liensociety;
	}
	if(prop_outstandingsociety!="")
	{
		document.forms[0].prop_outstandingsociety.value=prop_outstandingsociety;
	}
	if(prop_societypermission!="")
	{
		document.forms[0].prop_societypermission.value=prop_societypermission;
	}
	
	document.forms[0].prop_totalcost.readOnly =true;
	document.forms[0].prop_totalfund.readOnly=true;
	rentout();
	
	if(document.forms[0].prop_purpose.value=='1')
	{
		document.all.bulidup1.style.visibility="visible";
		document.all.bulidup1.style.position="relative";
		document.all.bulidup2.style.visibility="hidden";
		document.all.bulidup2.style.position="absolute";
		document.all.bulidup3.style.visibility="hidden";
		document.all.bulidup3.style.position="absolute";
			
		document.all.purchase2.style.visibility="visible";
		document.all.purchase2.style.position="relative";
		document.all.purchase1.style.visibility="hidden";
		document.all.purchase1.style.position="absolute";
		document.all.purchase3.style.visibility="visible";
		document.all.purchase3.style.position="relative";
		   
		document.all.floor11.style.visibility="visible";
		document.all.floor11.style.position="relative";
		document.all.floor1.style.visibility="hidden";
		document.all.floor1.style.position="absolute";
		document.all.floor2.style.visibility="hidden";
		document.all.floor2.style.position="absolute";
	}
	else 
	{
		document.all.bulidup2.style.visibility="visible";
		document.all.bulidup2.style.position="relative";
		document.all.bulidup1.style.visibility="hidden";
		document.all.bulidup1.style.position="absolute";
		document.all.bulidup3.style.visibility="hidden";
		document.all.bulidup3.style.position="absolute";
			
		document.all.purchase1.style.visibility="visible";
		document.all.purchase1.style.position="relative";
		document.all.purchase2.style.visibility="hidden";
		document.all.purchase2.style.position="absolute";
			
		document.all.floor1.style.visibility="visible";
		document.all.floor1.style.position="relative";
		document.all.floor11.style.visibility="hidden";
		document.all.floor11.style.position="absolute";
		document.all.floor2.style.visibility="visible";
		document.all.floor2.style.position="relative";
	}
		
	if(document.forms[0].prop_purpose.value=='1')
	{
		document.all.period1.style.visibility="visible";
		document.all.period1.style.position="relative";
		document.all.period12.style.visibility="hidden";
		document.all.period12.style.position="absolute";
		
		document.all.completion1.style.visibility="visible";
		document.all.completion1.style.position="relative";
		document.all.completion12.style.visibility="hidden";
		document.all.completion12.style.position="absolute";
	}
	else 
	{
		document.all.period12.style.visibility="visible";
		document.all.period12.style.position="relative";
		document.all.period1.style.visibility="hidden";
		document.all.period1.style.position="absolute";
		
		document.all.completion12.style.visibility="visible";
		document.all.completion12.style.position="relative";
		document.all.completion1.style.visibility="hidden";
		document.all.completion1.style.position="absolute";
	}
	if(document.forms[0].prop_purpose.value=='2')
	{
		document.all.buldingvalue13.style.visibility="visible";
		document.all.buldingvalue13.style.position="relative";
		document.all.buldingvalue1.style.visibility="hidden";
	}
	else
	{
		document.all.buldingvalue1.style.visibility="visible";
		document.all.buldingvalue1.style.position="relative";
		document.all.buldingvalue13.style.visibility="hidden";
	}
	showmarket();
	disableFields(true);
}

function showage()
{
	if(document.forms[0].prop_purpose.value!="6")
	{
		if(document.forms[0].propertytype2.value=="2")
		{
			document.all.age1.style.visibility="visible";
			document.all.age2.style.visibility="visible";
			document.all.age3.style.visibility="visible";
		}
		else 
		{
			document.all.age1.style.visibility="hidden";
			document.all.age2.style.visibility="hidden";
			document.all.age3.style.visibility="hidden";
		}
	}
}

function disableCommandButtons(valedit,valapply,valcancel,valdel,valclose)
{
  	document.forms[0].cmdedit.disabled=valedit;
  	document.forms[0].cmdsave.disabled=valapply;
  	document.forms[0].cmdcancel.disabled=valcancel;
  	document.forms[0].cmddelete.disabled=valdel;
  	document.forms[0].cmdclose.disabled=valclose;
}

function callHouse()
{
	if(document.forms[0].txt_staticdataid2.value== "2")
	{
		document.forms[0].sel_house.value ='2';
	}
	else if(document.forms[0].txt_staticdataid2.value== "1")
	{	
		document.forms[0].sel_house.selectedIndex ='1';
	}
}

function showall()
{
	document.all.landquality.style.visibility="visible";	
	document.all.amentity1.style.visibility="visible";	
    document.all.amentity2.style.visibility="visible";
    document.all.dwelunit1.style.visibility="visible";
    document.all.dwelunit2.style.visibility="visible";
    document.all.dwelunit3.style.visibility="visible";
    document.all.property1.style.visibility="visible";
   	document.all.property2.style.visibility="visible";
   	document.all.property3.style.visibility="visible";
	document.all.age1.style.visibility="visible";	
    document.all.age2.style.visibility="visible";
	document.all.age3.style.visibility="visible";
    document.all.firstmort1.style.visibility="visible";	
    document.all.firstmort2.style.visibility="visible";	
    document.all.lease.style.visibility="visible";
    document.all.projdetail1.style.visibility="visible";
    document.all.projdetail2.style.visibility="visible";	
    document.all.occupancy.style.visibility="visible";
    document.all.plotarea1.style.visibility="visible";		
    document.all.plotarea2.style.visibility="visible";	
	document.all.plotarea3.style.visibility="visible";	
    document.all.land1.style.visibility="visible";
   	document.all.land2.style.visibility="visible";
   	document.all.price.style.visibility="visible";
    document.all.undivided1.style.visibility="visible";
    document.all.undivided2.style.visibility="visible";
    document.all.landvalue1.style.visibility="visible";
    document.all.landvalue2.style.visibility="visible";
    document.all.landvalue3.style.visibility="visible";
	document.all.period3.style.visibility="visible";
   	document.all.nature1.style.visibility="visible";	
    document.all.nature2.style.visibility="visible";
    document.all.completion1.style.visibility="visible";
    document.all.completion2.style.visibility="visible";
    document.all.completion2.style.position="relative";
	document.all.completion3.style.visibility="visible";
    document.all.society.style.visibility="visible";
	document.all.society1.style.visibility="visible";
    document.all.agreement.style.visibility="visible";
    document.all.sellername1.style.visibility="visible";
    document.all.sellername2.style.visibility="visible";	
    document.all.selleraddr1.style.visibility="visible";
    document.all.selleraddr2.style.visibility="visible";	
    document.all.builder.style.visibility="visible";	
   	document.all.particulars1.style.visibility="visible";
    document.all.particulars2.style.visibility="visible";
    document.all.cost1.style.visibility="visible";    
    
    document.all.bulidup1.style.visibility="hidden";
    document.all.bulidup1.style.position="absolute";
    document.all.bulidup2.style.visibility="visible";
    document.all.bulidup2.style.position="relative";
    document.all.bulidup3.style.visibility="visible";
    document.all.bulidup3.style.position="relative";
    
    document.all.permssion1.style.visibility="visible";	
    document.all.permssion2.style.visibility="visible";	
    document.all.permssion12.style.visibility="visible";	
    document.all.permssion3.style.visibility="visible";	
    
    document.all.permssion1.style.position="relative";
    document.all.permssion2.style.position="relative";
    document.all.permssion12.style.position="relative";
    document.all.permssion3.style.position="relative";
    
    document.all.concost1.style.visibility="visible";
    document.all.concost3.style.visibility="visible";
    document.all.lien1.style.visibility="visible";
    document.all.lien3.style.visibility="visible";
    
    document.all.amtoutstanding1.style.visibility="visible";
    document.all.amtoutstanding2.style.visibility="visible";
    document.all.amtoutstanding.style.visibility="visible";
    
	document.all.amtoutstanding2.style.position="relative";

	document.all.quality1.style.visibility="visible";
	document.all.quality2.style.visibility="visible";
	document.all.quality3.style.visibility="visible";
	
	document.all.period1.style.visibility="visible";
	document.all.period1.style.position="relative";
	document.all.period2.style.visibility="visible";
	document.all.period2.style.position="relative";
	document.all.period12.style.visibility="hidden";
	document.all.period12.style.position="absolute";

	document.all.concost4.style.visibility="visible";
	document.all.ownership2.style.visibility="visible";
	
	document.all.amentity3.style.visibility="visible";
	document.all.purchase1.style.visibility="visible";
	document.all.purchase2.style.visibility="visible";
	document.all.purchase3.style.visibility="visible";
	document.all.purchase3.style.position="relative";
	document.all.purchase4.style.visibility="visible";
	
	document.all.buldingvalue1.style.visibility="visible";
    document.all.buldingvalue11.style.visibility="visible";	
   	document.all.buldingvalue2.style.visibility="visible";
	document.all.buldingvalue13.style.visibility="visible";
	document.all.buldingvalue12.style.visibility="visible";	
	
	document.all.landcost12.style.visibility="visible";
	document.all.landcost1.style.visibility="visible";
	document.all.landcost2.style.visibility="visible";
	document.all.landcost2.style.position="relative";
	document.all.landcost3.style.visibility="visible";
	
	document.all.cost3.style.visibility="visible";
	document.all.concost2.style.visibility="visible";
	
	document.all.particulars12.style.visibility="visible";
	document.all.particulars12.style.position="relative";
	
	document.all.floor1.style.visibility="visible";
	document.all.floor11.style.visibility="visible";
	document.all.floor2.style.visibility="visible";
	
	document.all.purchase13.style.visibility="visible";	
	
	document.all.period31.style.visibility="visible";
	
	document.all.period21.style.visibility="visible";
}

function showres()
{
	if(document.forms[0].prop_purpose.value== "1")
    {
    	showall();
    	showmarket();
    	document.all.landquality.style.visibility="hidden";	
      	document.all.amentity1.style.visibility="hidden";	
     	document.all.amentity2.style.visibility="hidden";
     	document.all.dwelunit1.style.visibility="hidden";
     	document.all.dwelunit2.style.visibility="hidden";
     	document.all.dwelunit3.style.visibility="hidden";
     	document.all.property1.style.visibility="hidden";
     	document.all.property2.style.visibility="hidden";
     	document.all.property3.style.visibility="hidden";
     	document.all.age1.style.visibility="hidden";	
     	document.all.age2.style.visibility="hidden";
		document.all.age3.style.visibility="hidden";
     	document.all.firstmort1.style.visibility="hidden";	
     	document.all.firstmort2.style.visibility="hidden";	
     	document.all.lease.style.visibility="hidden";
     	document.all.projdetail1.style.visibility="hidden";
     	document.all.projdetail2.style.visibility="hidden";	
     	document.all.occupancy.style.visibility="hidden";
     	document.all.period2.style.visibility="hidden";
     	document.all.completion12.style.visibility="hidden";
     	document.all.completion2.style.visibility="hidden";
     	document.all.floor2.style.visibility="hidden";
     	document.all.permssion2.style.visibility="hidden";	
     	document.all.amtoutstanding2.style.visibility="hidden";
     	document.all.bulidup1.style.visibility="visible";
     	document.all.bulidup2.style.visibility="hidden";
     	
	    document.all.bulidup2.style.position="absolute";
	    document.all.bulidup1.style.position="relative";
	    document.all.particulars13.style.visibility="visible";
     	document.all.particulars1.style.visibility="hidden";
     	document.all.particulars11.style.visibility="hidden";
     	
     	document.all.particulars13.style.position="relative";
	    document.all.particulars1.style.position="absolute";
	    document.all.particulars11.style.position="absolute";
	    document.all.bulidup3.style.visibility="hidden";
	    
	    document.all.land1.style.visibility="hidden";
	    document.all.land2.style.visibility="hidden";
	    
	    document.all.quality1.style.visibility="hidden";
	    document.all.quality2.style.visibility="hidden";
	    document.all.quality3.style.visibility="hidden";
	    document.all.amentity3.style.visibility="hidden";
	    
		document.all.purchase1.style.visibility="hidden";
		document.all.purchase1.style.position="absolute";
		document.all.purchase2.style.visibility="visible";
		document.all.purchase2.style.position="relative";
		document.all.purchase3.style.visibility="visible";
		document.all.purchase3.style.position="relative";
	    
	    document.all.floor11.style.visibility="visible";
		document.all.floor11.style.position="relative";
		document.all.floor1.style.visibility="hidden";
		document.all.floor1.style.position="absolute";
		document.all.floor2.style.visibility="hidden";
		document.all.floor2.style.position="absolute";
		document.all.buldingvalue13.style.visibility="hidden";
		document.all.buldingvalue13.style.position="absolute";
		document.all.buldingvalue1.style.visibility="visible";
		document.all.buldingvalue1.style.position="relative";
		document.all.buldingvalue12.style.position="relative";
		document.all.buldingvalue11.style.visibility="visible";
		document.all.buldingvalue11.style.position="relative";
		
		document.all.landcost12.style.visibility="hidden";
	    document.all.permssion12.style.visibility="hidden";
	    document.all.esti1.style.visibility="visible";
	    
	    document.all.purchase13.style.visibility="hidden";
	    document.all.period31.style.visibility="hidden";
	    document.all.period21.style.visibility="hidden";
	  
    }
    else if(document.forms[0].prop_purpose.value== "2")
    {
    	showall();
    	showage();
    	showmarket();
		document.all.plotarea1.style.visibility="hidden";		
    	document.all.plotarea2.style.visibility="hidden";
		document.all.plotarea3.style.visibility="hidden";	
    	document.all.land1.style.visibility="hidden";
    	document.all.land2.style.visibility="hidden";
    	document.all.amentity1.style.visibility="hidden";
    	document.all.amentity2.style.visibility="hidden";
    	document.all.price.style.visibility="hidden";
    	document.all.undivided1.style.visibility="hidden";
    	document.all.undivided2.style.visibility="hidden";
    	document.all.landvalue1.style.visibility="hidden";
    	document.all.landvalue2.style.visibility="hidden";
    	document.all.landvalue3.style.visibility="hidden";
    	document.all.lease.style.visibility="hidden";
    	document.all.firstmort1.style.visibility="hidden";	
     	document.all.firstmort2.style.visibility="hidden";
     	document.all.ownership2.style.visibility="hidden";
     	document.all.quality2.style.visibility="hidden";
     	document.all.period2.style.visibility="hidden";
     	document.all.landcost2.style.visibility="hidden";
     	document.all.concost2.style.visibility="hidden";
     	
     	document.all.bulidup2.style.visibility="visible";	
     	document.all.bulidup3.style.visibility="visible";
     	document.all.bulidup1.style.visibility="hidden";
     	document.all.bulidup2.style.position="relative";
     	document.all.bulidup3.style.position="relative";
     	document.all.bulidup1.style.position="absolute";
     	
     	document.all.particulars11.style.visibility="visible";	
     	document.all.particulars1.style.visibility="hidden";
     	document.all.particulars13.style.visibility="hidden";
     	document.all.particulars11.style.position="relative";
     	document.all.particulars1.style.position="absolute";
     	document.all.particulars13.style.position="absolute";
     	
     	document.all.permssion1.style.visibility="visible";	
     	document.all.permssion12.style.visibility="hidden";
     	document.all.permssion2.style.visibility="visible";
     	document.all.permssion1.style.position="relative";
     	document.all.permssion12.style.position="absolute";
     	document.all.permssion2.style.position="relative";
     	
     	document.all.floor11.style.visibility="hidden";
		document.all.floor11.style.position="absolute";
		document.all.floor1.style.visibility="visible";
		document.all.floor1.style.position="relative";
		document.all.floor2.style.visibility="hidden";
		document.all.floor2.style.position="absolute";	
     	
     	document.all.buldingvalue13.style.visibility="visible";
		document.all.buldingvalue13.style.position="relative";
		document.all.buldingvalue1.style.visibility="hidden";
		document.all.buldingvalue1.style.position="absolute";
		
		document.all.purchase1.style.visibility="hidden";
		document.all.purchase2.style.visibility="hidden";
		document.all.purchase3.style.visibility="hidden";
		document.all.purchase4.style.visibility="hidden";
		
		
		document.all.completion12.style.visibility="hidden";
     	document.all.amentity3.style.visibility="hidden";
     	
     	document.all.landcost1.style.visibility="hidden";
     	document.all.landcost2.style.visibility="hidden";
     	document.all.landcost1.style.position="absolute";
     	document.all.landcost2.style.position="absolute";
     	
     	
     	document.all.concost1.style.visibility="hidden";
     	document.all.concost2.style.visibility="hidden";
     	document.all.concost3.style.visibility="hidden";
     	document.all.concost4.style.visibility="hidden";
     	
     	document.all.esti1.style.visibility="hidden";
     	
     	document.all.purchase13.style.visibility="hidden";
	    document.all.period31.style.visibility="hidden";
	    document.all.period21.style.visibility="hidden";
    }
    else if(document.forms[0].prop_purpose.value== "3")
    {
    	showall();
    	showage();
    	showmarket();
		document.all.land1.style.visibility="hidden";
    	document.all.land2.style.visibility="hidden";
    	document.all.amentity1.style.visibility="hidden";
    	document.all.amentity2.style.visibility="hidden";
    	document.all.period1.style.visibility="hidden";
    	document.all.period2.style.visibility="hidden";
		document.all.period3.style.visibility="hidden";
    	document.all.dwelunit1.style.visibility="hidden";
     	document.all.dwelunit2.style.visibility="hidden";
     	document.all.dwelunit3.style.visibility="hidden";
     	document.all.property1.style.visibility="hidden";
     	document.all.property2.style.visibility="hidden";
     	document.all.property3.style.visibility="hidden";
     	document.all.firstmort1.style.visibility="hidden";	
     	document.all.firstmort2.style.visibility="hidden";	
     	document.all.nature1.style.visibility="hidden";	
     	document.all.nature2.style.visibility="hidden";
     	document.all.lease.style.visibility="hidden";
     	document.all.projdetail1.style.visibility="hidden";
     	document.all.projdetail2.style.visibility="hidden";	
     	document.all.completion1.style.visibility="hidden";
     	document.all.completion2.style.visibility="hidden";
		document.all.completion3.style.visibility="hidden";
     	document.all.society.style.visibility="hidden";
		document.all.society1.style.visibility="hidden";
		document.all.bulidup2.style.visibility="visible";	
     	document.all.bulidup1.style.visibility="hidden";
		document.all.permssion2.style.visibility="hidden";
		document.all.amtoutstanding2.style.visibility="hidden";
		
		document.all.bulidup2.style.visibility="visible";	
     	document.all.bulidup3.style.visibility="visible";
     	document.all.bulidup1.style.visibility="hidden";
     	document.all.bulidup2.style.position="relative";
     	document.all.bulidup3.style.position="relative";
     	document.all.bulidup1.style.position="absolute";
		
		document.all.particulars11.style.visibility="visible";
		document.all.particulars1.style.visibility="hidden";
		document.all.particulars12.style.visibility="hidden";
		document.all.particulars13.style.visibility="hidden";
		document.all.quality2.style.visibility="hidden";
		document.all.particulars11.style.position="relative";
		document.all.particulars1.style.position="absolute";
		document.all.particulars12.style.position="absolute";
		document.all.particulars13.style.position="absolute";
		document.all.completion12.style.visibility="hidden";
		
		document.all.buldingvalue13.style.visibility="hidden";
		document.all.buldingvalue13.style.position="absolute";
		document.all.buldingvalue1.style.visibility="visible";
		document.all.buldingvalue1.style.position="relative";
		document.all.buldingvalue12.style.position="relative";
		document.all.buldingvalue11.style.visibility="visible";
		document.all.buldingvalue11.style.position="relative";
		document.all.purchase2.style.visibility="hidden";
		
		document.all.landcost12.style.visibility="hidden";
	    document.all.permssion12.style.visibility="hidden";
		document.all.amentity3.style.visibility="hidden";
		document.all.ownership2.style.visibility="hidden";
		
		document.all.floor11.style.visibility="hidden";
		document.all.floor11.style.position="absolute";
		document.all.floor1.style.visibility="visible";
		document.all.floor1.style.position="relative";
		document.all.floor2.style.visibility="hidden";
		document.all.floor2.style.position="absolute";	
		document.all.esti1.style.visibility="hidden";
		
		document.all.age1.style.visibility="visible";	
     	document.all.age2.style.visibility="visible";
		document.all.age3.style.visibility="visible";
		
		document.all.purchase13.style.visibility="hidden";
	    document.all.period31.style.visibility="hidden";
	    document.all.period21.style.visibility="hidden";
    }
    else if(document.forms[0].prop_purpose.value=="4")
    {
    	showall();
    	showage();
    	showmarket();
		document.all.land1.style.visibility="hidden";
    	document.all.land2.style.visibility="hidden";
    	document.all.amentity1.style.visibility="hidden";
    	document.all.amentity2.style.visibility="hidden";
    	document.all.amentity3.style.visibility="hidden";
    	document.all.firstmort1.style.visibility="hidden";	
     	document.all.firstmort2.style.visibility="hidden";	
     	document.all.lease.style.visibility="hidden";
     	document.all.projdetail1.style.visibility="hidden";
     	document.all.projdetail2.style.visibility="hidden";	
     	document.all.bulidup2.style.visibility="visible";	
     	document.all.bulidup1.style.visibility="hidden";
     	document.all.ownership2.style.visibility="hidden";
     	document.all.quality2.style.visibility="hidden";
     	document.all.period1.style.visibility="hidden";
     	document.all.period1.style.position="absolute";
     	document.all.period3.style.visibility="hidden";
     	document.all.period3.style.position="absolute";
     	document.all.permssion2.style.visibility="hidden";
     	document.all.amtoutstanding2.style.visibility="hidden";
     	
     	document.all.bulidup2.style.visibility="visible";	
     	document.all.bulidup3.style.visibility="visible";
     	document.all.bulidup1.style.visibility="hidden";
     	document.all.bulidup2.style.position="relative";
     	document.all.bulidup3.style.position="relative";
     	document.all.bulidup1.style.position="absolute";
     	
     	document.all.particulars11.style.visibility="visible";
		document.all.particulars1.style.visibility="hidden";
		document.all.particulars12.style.visibility="hidden";
		document.all.particulars13.style.visibility="hidden";
		
		document.all.completion12.style.visibility="hidden";
		document.all.completion2.style.visibility="hidden";
		
		document.all.particulars11.style.position="relative";
		document.all.particulars1.style.position="absolute";
		document.all.particulars12.style.position="absolute";
		document.all.particulars13.style.position="absolute";
		
		
		document.all.permssion1.style.visibility="visible";	
     	document.all.permssion12.style.visibility="hidden";
     	document.all.permssion1.style.position="relative";
     	document.all.permssion12.style.position="absolute";
     	
     	document.all.purchase1.style.visibility="hidden";
     	document.all.purchase1.style.position="absolute";
     	
     	document.all.purchase2.style.visibility="visible";
     	document.all.purchase2.style.position="relative";
     	
	     document.all.landcost1.style.visibility="hidden";
	     document.all.landcost2.style.visibility="hidden";
	     
	     document.all.buldingvalue13.style.visibility="hidden";
	     
	     document.all.concost1.style.visibility="hidden";
	     document.all.concost2.style.visibility="hidden";
	     document.all.concost3.style.visibility="hidden";
	     document.all.concost4.style.visibility="hidden";
	     
     	document.all.floor11.style.visibility="hidden";
		document.all.floor11.style.position="absolute";
		document.all.floor1.style.visibility="visible";
		document.all.floor1.style.position="relative";
		document.all.floor2.style.visibility="visible";
		document.all.floor2.style.position="relative";	
     	
     	document.all.esti1.style.visibility="hidden";
    }
    else if(document.forms[0].prop_purpose.value== "5")
    {
    	showall();
    	showmarket();
		document.all.land1.style.visibility="hidden";
    	document.all.land2.style.visibility="hidden";
    	document.all.property1.style.visibility="hidden";
     	document.all.property2.style.visibility="hidden";
     	document.all.property3.style.visibility="hidden";
     	document.all.firstmort1.style.visibility="hidden";	
     	document.all.firstmort2.style.visibility="hidden";
     	document.all.lease.style.visibility="hidden";
     	document.all.agreement.style.visibility="hidden";
     	document.all.projdetail1.style.visibility="hidden";
     	document.all.projdetail2.style.visibility="hidden";	
     	document.all.sellername1.style.visibility="hidden";
     	document.all.sellername2.style.visibility="hidden";	
     	document.all.selleraddr1.style.visibility="hidden";
     	document.all.selleraddr2.style.visibility="hidden";	
     	document.all.builder.style.visibility="hidden";	
     	document.all.bulidup2.style.visibility="visible";	
     	document.all.bulidup1.style.visibility="hidden";
     	document.all.permssion2.style.visibility="hidden";	
     	document.all.amtoutstanding2.style.visibility="hidden";
     	document.all.ownership2.style.visibility="hidden";
     	
     	document.all.period12.style.visibility="visible";
		document.all.period12.style.position="relative";
		document.all.period1.style.visibility="hidden";
		document.all.period1.style.position="absolute";
		document.all.period2.style.visibility="hidden";
		document.all.period2.style.position="absolute";
		
		document.all.completion12.style.visibility="visible";
		document.all.completion12.style.position="relative";
		document.all.completion1.style.visibility="hidden";
		document.all.completion1.style.position="absolute";
     	document.all.completion2.style.visibility="hidden";
		document.all.completion2.style.position="absolute";
		
		document.all.bulidup2.style.visibility="visible";	
     	document.all.bulidup3.style.visibility="visible";
     	document.all.bulidup1.style.visibility="hidden";
     	document.all.bulidup2.style.position="relative";
     	document.all.bulidup3.style.position="relative";
     	document.all.bulidup1.style.position="absolute";
     	
     	document.all.particulars1.style.visibility="hidden";
		document.all.particulars13.style.visibility="hidden";
		
		document.all.particulars1.style.position="absolute";
		document.all.particulars13.style.position="absolute";
     	document.all.permssion12.style.position="relative";
     	document.all.permssion1.style.position="absolute";
		document.all.amentity3.style.visibility="visible";
		
		document.all.landcost1.style.visibility="hidden";
		document.all.landcost1.style.position="absolute";
		document.all.purchase2.style.visibility="hidden";
		
		document.all.buldingvalue13.style.visibility="hidden";
	    document.all.permssion1.style.visibility="hidden";
	    
	    document.all.concost1.style.visibility="hidden";
	    document.all.concost2.style.visibility="hidden";
	    document.all.concost3.style.visibility="hidden";
	    document.all.concost4.style.visibility="hidden";
	    
	    document.all.floor11.style.visibility="hidden";
		document.all.floor11.style.position="absolute";
		document.all.floor1.style.visibility="visible";
		document.all.floor1.style.position="relative";
		document.all.floor2.style.visibility="visible";
		document.all.floor2.style.position="relative";
			
		document.all.esti1.style.visibility="hidden";
		
		document.all.purchase13.style.visibility="hidden";
	    document.all.period31.style.visibility="hidden";
	    document.all.period21.style.visibility="hidden";
		
    }
    else if(document.forms[0].prop_purpose.value== "6")
    {
    	showall();
		document.all.landquality.style.visibility="hidden";		
    	document.all.age1.style.visibility="hidden";	
     	document.all.age2.style.visibility="hidden";
		document.all.age3.style.visibility="hidden";
    	document.all.firstmort1.style.visibility="hidden";	
     	document.all.firstmort2.style.visibility="hidden";	
     	document.all.buldingvalue1.style.visibility="hidden";	
     	document.all.buldingvalue11.style.visibility="hidden";			
    	document.all.buldingvalue2.style.visibility="hidden";
    	document.all.lease.style.visibility="hidden";
    	document.all.agreement.style.visibility="hidden";
    	document.all.sellername1.style.visibility="hidden";
     	document.all.sellername2.style.visibility="hidden";	
     	document.all.selleraddr1.style.visibility="hidden";
     	document.all.selleraddr2.style.visibility="hidden";
		
     	document.all.occupancy.style.visibility="hidden";	
     	document.all.society.style.visibility="hidden";
		document.all.society1.style.visibility="hidden";
		document.all.bulidup2.style.visibility="visible";	
     	document.all.bulidup1.style.visibility="hidden";
		
		document.all.bulidup1.style.visibility="visible";
     	document.all.bulidup2.style.visibility="hidden";
     	
	    document.all.bulidup2.style.position="absolute";
	    document.all.bulidup1.style.position="relative";
		document.all.amentity2.style.visibility="hidden";
		document.all.period2.style.visibility="hidden";
		document.all.ownership2.style.visibility="hidden";
		document.all.completion12.style.visibility="hidden";
		document.all.completion2.style.visibility="hidden";
		document.all.completion1.style.visibility="visible";
		
		document.all.particulars11.style.visibility="visible";
		document.all.particulars1.style.visibility="hidden";
		document.all.particulars12.style.visibility="hidden";
		document.all.particulars13.style.visibility="hidden";
		document.all.particulars11.style.position="relative";
		document.all.particulars1.style.position="absolute";
		document.all.particulars12.style.position="absolute";
		document.all.particulars13.style.position="absolute";
		document.all.landcost2.style.position="relative";
		document.all.concost2.style.position="relative";
		
		document.all.permssion2.style.visibility="hidden";
		document.all.permssion12.style.visibility="hidden";
		document.all.permssion2.style.position="absolute";
		document.all.permssion12.style.position="absolute";
		document.all.concost2.style.visibility="hidden";
		document.all.amtoutstanding2.style.visibility="hidden";
		document.all.amtoutstanding2.style.position="absolute";
		document.all.land1.style.visibility="hidden";
		document.all.land2.style.visibility="hidden";
		
		document.all.quality1.style.visibility="hidden";
		document.all.quality2.style.visibility="hidden";
		document.all.quality3.style.visibility="hidden";
		document.all.landcost2.style.visibility="hidden";
		document.all.landcost2.style.position="absolute";
		
		document.all.purchase1.style.visibility="hidden";
		document.all.buldingvalue12.style.visibility="hidden";
		document.all.buldingvalue13.style.visibility="hidden";
		document.all.floor11.style.visibility="hidden";
		document.all.floor11.style.position="absolute";
		document.all.floor1.style.visibility="visible";
		document.all.floor1.style.position="relative";
		document.all.floor2.style.visibility="hidden";
		document.all.floor2.style.position="absolute";		
		
		document.all.purchase13.style.visibility="hidden";
	    document.all.period31.style.visibility="hidden";
	    document.all.period21.style.visibility="hidden";
	    
	    document.all.landcost1.style.visibility="hidden";
	    document.all.landcost12.style.visibility="hidden";
        document.all.landcost2.style.visibility="hidden";
	    document.all.landcost3.style.visibility="hidden";
		document.all.cost3.style.visibility="hidden";
		
		document.all.esti1.style.visibility="visible";	    

    }
    else if(document.forms[0].prop_purpose.value== "7")
    {
    	showall();
    	showmarket();
		document.all.land1.style.visibility="hidden";
    	document.all.land2.style.visibility="hidden";
    	document.all.price.style.visibility="hidden";
    	document.all.period1.style.visibility="hidden";
    	document.all.period2.style.visibility="hidden";
		document.all.period3.style.visibility="hidden";
    	document.all.property1.style.visibility="hidden";
     	document.all.property2.style.visibility="hidden";
     	document.all.property3.style.visibility="hidden";
     	document.all.firstmort1.style.visibility="hidden";	
     	document.all.firstmort2.style.visibility="hidden";
     	document.all.lease.style.visibility="hidden";
    	document.all.agreement.style.visibility="hidden";
    	document.all.projdetail1.style.visibility="hidden";
     	document.all.projdetail2.style.visibility="hidden";	
     	document.all.sellername1.style.visibility="hidden";
     	document.all.sellername2.style.visibility="hidden";	
     	document.all.selleraddr1.style.visibility="hidden";
     	document.all.selleraddr2.style.visibility="hidden";
     	document.all.cost1.style.visibility="hidden";	
	    document.all.builder.style.visibility="hidden";	
     	
     	document.all.society.style.visibility="hidden";
		document.all.bulidup2.style.visibility="visible";	
     	document.all.bulidup1.style.visibility="hidden";
    	document.all.completion12.style.visibility="hidden";		
		document.all.completion12.style.position="absolute";
		document.all.completion2.style.visibility="hidden";		
		document.all.completion2.style.position="absolute";
		
		document.all.particulars1.style.visibility="hidden";		
		document.all.particulars1.style.position="absolute";
		document.all.particulars12.style.visibility="hidden";		
		document.all.particulars12.style.position="absolute";
		document.all.particulars13.style.visibility="hidden";		
		document.all.particulars13.style.position="absolute";
		
		document.all.amtoutstanding2.style.visibility="hidden";
		document.all.permssion2.style.visibility="hidden";
		
		document.all.ownership2.style.visibility="hidden";
		
		
		document.all.permssion12.style.visibility="visible";	
		document.all.permssion12.style.position="relative";
		document.all.permssion1.style.visibility="hidden";		
		document.all.permssion1.style.position="absolute";
		document.all.permssion2.style.visibility="hidden";		
		document.all.permssion2.style.position="absolute";
		
		document.all.floor11.style.visibility="hidden";
		document.all.floor11.style.position="absolute";
		document.all.floor1.style.visibility="visible";
		document.all.floor1.style.position="relative";
		document.all.floor2.style.visibility="hidden";
		document.all.floor2.style.position="absolute";	
		
		document.all.concost1.style.visibility="hidden";
		document.all.concost2.style.visibility="hidden";
		document.all.concost3.style.visibility="hidden";
		document.all.concost4.style.visibility="hidden";
		
		document.all.purchase1.style.visibility="hidden";
		document.all.purchase2.style.visibility="hidden";
		document.all.purchase3.style.visibility="hidden";
		document.all.purchase4.style.visibility="hidden";
		
		document.all.buldingvalue13.style.visibility="hidden";
		document.all.landcost1.style.visibility="hidden";
		
		document.all.landcost12.style.visibility="hidden";
		document.all.landcost2.style.visibility="hidden";
		document.all.landcost3.style.visibility="hidden";
		document.all.cost3.style.visibility="hidden";
		
		document.all.purchase13.style.visibility="hidden";
	    document.all.period31.style.visibility="hidden";
	    document.all.period21.style.visibility="hidden";
	    
	     document.all.esti1.style.visibility="hidden";
    }
    else
    {
    	showall();
    	document.all.purchase2.style.visibility="hidden";
    	document.all.period21.style.visibility="hidden";
    	document.all.period12.style.visibility="hidden";
    	document.all.period31.style.visibility="hidden";
    	document.all.purchase13.style.visibility="hidden";
    	document.all.floor11.style.visibility="hidden";
    	document.all.buldingvalue13.style.visibility="hidden";
    	document.all.completion12.style.visibility="hidden";
    	document.all.landcost12.style.visibility="hidden";
    	document.all.particulars1.style.visibility="hidden";
    	document.all.particulars13.style.visibility="hidden";
    	document.all.permssion12.style.visibility="hidden";
    	document.all.floor2.style.visibility="hidden";
    	
    	
    }
}

function rentout()
{
	if(document.forms[0].sel_house.value== "1")
	{
		document.all.rent1.style.visibility="visible";
		document.all.rent11.style.visibility="visible";
		document.all.rent2.style.visibility="visible";
	}
	else
	{
		document.all.rent1.style.visibility="hidden";
		document.all.rent11.style.visibility="hidden";
		document.all.rent2.style.visibility="hidden";
	}
}

</script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css">
<body onload="callonload();showres();">
<form method="post" class="normal">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
	<tr>
		<td><jsp:include page="../share/Applurllinkper.jsp" flush="true">
			<jsp:param name="pageid" value="1" />
		</jsp:include></td>
	</tr>
	<tr>

		<td class="page_flow">Home -&gt; Retail -&gt; Application -&gt; Loan Particulars -&gt; Proposed/Offered Asset -&gt; House</td>
	</tr>
</table>
<lapschoice:application />
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="bottom">
		<table width="93%" border="0" cellspacing="0" cellpadding="0" align="left" class="outertable">
			<tr align="center">
				<td><jsp:include page="../per/applicanttab.jsp" flush="true">
					<jsp:param name="linkid" value="5" />
				</jsp:include></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" align="left" class="outertable">
			<tr>
				<td><jsp:include page="../per/ProposedAssetTabs.jsp" flush="true">
					<jsp:param name="tabid" value="1" />
				</jsp:include></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>
		<table border="1" cellspacing="0" cellpadding="3" width="100%" class="outertable">
			<tr>
				<td><b>Details of Immovable Property(To be
				purchased/Constructed/Renovated/Improved/Mortgaged)</b>
				<table cellSpacing=0 cellPadding=3 width="100%" border=0 class="outertable">
					<tbody>
						<tr>
							<td>
							<table cellSpacing=0 cellPadding=3 width="100%" border=0 class="outertable">
								<tbody>
									<tr>
										<td colSpan=2>Purpose of Loan <b><span class="mantatory">*&nbsp;</span></b>
										</td>
										<td width="25%"><select tabIndex=13
											onchange="showres();clearfields()" name=prop_purpose>
											<option value=0 selected>&lt;----Select----&gt;</option>
											<option value=1>Purchase of Land &amp; Construction of House</option>
											<option value=2>Purchase of Flat</option>
											<option value=3>Purchase of ready built House</option>
											<option value=4>Foreclosure/takeover from other Bank/Fls</option>
											<option value=5>Improvement/Renovation of House/flat</option>
											<option value=6>Construction of House/Flat</option>
											<option value=7>Personal needs against mortgage of property</option>
										</select></td>
										<td colSpan=2>Type of the Property<b><span class="mantatory">*&nbsp;</span></b></td>
										<td width="30%"><select tabIndex=1 name=propertytype1 onChange="showmarket()">

											<%stroptions = Helper.correctNull((String) hshValues.get("prop_housetype"));			%>
											<option selected value="">&lt;----Select----&gt;</option>
											<%if ((stroptions.trim()).equals("Land")) {%>
											<option value="Land" selected>Land</option>
											<%} else {%>
											<option value="Land">Land</option>
											<%}if ((stroptions.trim()).equals("Flat")) {%>
											<option value="Flat" selected>Flat / Apartment</option>
											<%} else {%>
											<option value="Flat">Flat / Apartment</option>
											<%}%>
											<%if ((stroptions.trim()).equals("House")) {%>
											<option value="House" selected>House / Building</option>
											<%} else {%>
											<option value="House">House / Building</option>
											<%}%>
										</select></td>
									</tr>
									<tr>
										<td n colSpan="2">Location of the Property<b><span class="mantatory">*&nbsp;</span></b></td>
										<td width="25%"><select tabIndex=2 name=prop_type>
											<option value="" selected>&lt;----Select----&gt;</option>
											<option value="1">Metro</option>
											<option value="2">Urban</option>
											<option value="3">Semi Urban</option>
											<option value="4">Rural</option>
										</select></td>
										<td colspan=2>
										<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
											<tr>
												<td id="plotarea1" width="31%">Area of Plot</td>
												<td id="plotarea2" width="69%" align="left"><b><span class="mantatory">*&nbsp;</span></b></td>
											</tr>
										</table>
										</td>
										<td id="plotarea3" width="30%"><input type="text"
											name="prop_areaofplot"
											value="<%=Helper.correctNull((String)hshValues.get("prop_areaofplot"))%>"
											size="12" maxlength="4" tabindex="3"
											onKeyPress="allowInteger()" style="text-align:right"> Sq.ft</td>
									</tr>
									<tr>
										<td colSpan=2>Survey No<b><span class="mantatory">*&nbsp;</span></b></td>
										<td width="25%"><input type="text" name="prop_builtup"
											size="30" maxlength="25" tabindex="4"
											onKeyPress="notAllowSingleQuote()"
											value="<%=Helper.correctNull((String)hshValues.get("prop_builtup"))%>">
										</td>
										<td colSpan=2>
										<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
											<tr>
												<td width="33%" id=bulidup1>Proposed Built Up Area</td>
												<td width="33%" id=bulidup2>Built Up Area</td>
												<td width="67%" align="left" id=bulidup3><b><span class="mantatory">*&nbsp;</span></b></td>
											</tr>
										</table>
										</td>
										<td width="30%"><input type="text" name="prop_proposedbuildup"
											value="<%=Helper.correctNull((String)hshValues.get("prop_proposedbuildup"))%>"
											size="12" maxlength="4" tabindex="5"
											onKeyPress="allowInteger()" style="text-align:right"> Sq.ft</td>
									</tr>
									<tr>
										<td colSpan=2>Khata No</td>
										<td width="25%"><input type="text" name="prop_totalcostloan"
											value="<%=Helper.correctNull((String)hshValues.get("prop_totalcostloan"))%>"
											size="30" maxlength="25" tabindex="6"></td>

										<td colspan=2>
										<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
											<tr>
												<td colSpan=2 id=ownership1>Ownership Status</td>

												<td width="57%" id=ownership2><b><span class="mantatory">*&nbsp;</span></b></td>
											</tr>
										</table>
										</td>
										<td width="30%"><select tabIndex=7 name=sel_own>
											<option value=0 selected>----Select----</option>
											<option value=1>Sole</option>
											<option value=2>Joint</option>
										</select></td>
									</tr>
									<tr id=landquality>
										<td id=land1 colSpan=2>Is the Land<b><span class="mantatory">*&nbsp;</span></b></td>
										<td id=land2 width="25%"><select tabIndex=8 name=prop_mortgage>
											<option value=0 selected>----Select----</option>
											<option value=1>Freehold</option>
											<option value=2>Leasehold</option>
										</select></td>
										<td colspan=2>
										<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
											<tr>
												<td noWrap align=left id=quality1 width="84%">Quality of
												Construction / Condition</td>
												<td id=quality2 width="16%"><b><span class="mantatory">*&nbsp;</span></b></td>
											</tr>
										</table>
										</td>
										<td width="30%" id=quality3><select tabIndex=9
											name=qualityconst>
											<option value=0 Selected>----Select----</option>
											<option value=1>Excellent</option>
											<option value=2>Good</option>
											<option value=3>Fair</option>
											<option value=4>Poor</option>
										</select></td>
									</tr>
									<tr>
										<td colSpan=2>Marketability <b><span class="mantatory">*&nbsp;</span></b>
										</td>
										<td width="25%"><select tabIndex=11 name=marketability>
											<option value=0 selected>----Select----</option>
											<option value=1>Very Good</option>
											<option value=2>Good</option>
											<option value=3>Fair</option>
											<option value=4>Poor</option>
										</select></td>
										<td colspan=2>
										<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
											<tr>
												<td id=amentity1 colSpan=2>Presence of Amenities</td>
												<td width="43%" id=amentity2><b><span class="mantatory">*&nbsp;</span></b></td>
											</tr>
										</table>
										</td>
										<td id=amentity3 width="30%"><select tabIndex=9
											name=presenceamenities>
											<option value=0 selected>----Select----</option>
											<option value=1>Very Good</option>
											<option value=2>Good</option>
											<option value=3>Fair</option>
											<option value=4>Poor</option>
										</select></td>
									</tr>
									<tr id=price>
										<td colspan=2>
										<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
											<tr>
												<td width="36%" id=purchase1>Purchase price of House/Flat<span class="mantatory">*&nbsp;</span></b></td>
												<td width="94%" id=purchase2>Purchase price of plot<span class="mantatory">*&nbsp;</span></b></td>
												<td width="59%" id=purchase3 align="left">&nbsp;</td>
												<td width="5%" align="left" id=purchase4>Rs</td>
											</tr>
										</table>
										</td>
										<td width="25%"><lapschoice:CurrencyTag
											name="prop_purchaseprice" tabindex="12"
											value='<%=Helper.correctNull((String)hshValues.get("prop_purchaseprice"))%>'
											size="15" maxlength="10" /></td>
										<td colspan=2>
										<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
											<tr>
												<td width="46%">Estimated Cost of Construction</td>
												<td width="46%" id=esti1><b><span class="mantatory">*&nbsp;</span></b></td>
												<td width="8%" align="left">Rs.</td>
											</tr>
										</table>
										</td>

										<td width="30%"><lapschoice:CurrencyTag
											name="prop_estimatedprice" tabindex="12"
											value='<%=Helper.correctNull((String)hshValues.get("prop_estimatecost"))%>'
											size="15" maxlength="10" /></td>
									</tr>
									<tr>
										<td colspan=2>
										<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
											<tr>
												<td id=dwelunit1 width="47%">Is the dwelling Unit</td>
												<td id=dwelunit2 width="53%" align="left"><b><span class="mantatory">*&nbsp;</span></b></td>
											</tr>
										</table>
										</td>

										<td width="25%"><select id=dwelunit3 tabIndex=16

											name=prop_allotted>
											<option value=0 Selected>----Select----</option>
											<option value=1>Final Stage/ Ready built House</option>
											<option value=2>Intermediate Stage</option>
											<option value=3>Foundation Stage</option>
											<option value=4>Planning Stage</option>
										</select></td>
										<td noWrap colSpan=2 height=23>Is the legal title to the
										dwelling unit clear?</td>
										<td width="30%" height=23><select tabIndex=17 name=sel_dwell>
											<option value=0 selected>&lt;---Select---&gt;</option>
											<option value=1>Yes</option>
											<option value=2>No</option>
										</select></td>
									</tr>
									<tr>

										<td colspan=2>
										<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
											<tr>
												<td id=property1 width="35%">Property Type</td>
												<td id=property2 width="65%" align="left"><b><span class="mantatory">*&nbsp;</span></b></td>
											</tr>
										</table>
										</td>
										<td id=property3 width="25%"><select tabIndex=15
											name=propertytype2 onChange="showage()">
											<option value=0 selected>----Select----</option>
											<option value=1>New</option>
											<option value=2>Existing</option>
										</select></td>
										<td colspan=2>
										<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
											<tr>
												<td id=period1 width="77%">Period required for Construction
												</td>
												<td id=period12 width="77%">Period required for Renovation<span class="mantatory">*&nbsp;</span></b></td>
												<td width="36%" id=purchase13>Purchase price of House/Flat</td>
												<td id=period2 align="left" width="11%"><b><span class="mantatory">*&nbsp;</span></b></td>
												<td id=period21 align="left" width="12%">Rs.</td>
											</tr>
										</table>
										</td>
										<td width="30%">

										<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
											<tr>
												<td id=period3 width="39%"><input type="text"
													name="prop_repairdetails"
													value="<%=Helper.correctNull((String)hshValues.get("prop_repairdetails"))%>"
													size="10" maxlength="2" tabindex="14"
													onKeyPress="allowInteger()" style="text-align:right">
												Months</td>
												<td id="period31" width="61%"><lapschoice:CurrencyTag
													name="prop_plotprice"
													value='<%=Helper.correctNull((String)hshValues.get("prop_plotprice"))%>'
													size="15" maxlength="10" tabindex="14"
													onKeyPress="allowInteger()" style="text-align:right" /></td>
											</tr>
										</table>
										</td>
									</tr>
									<tr>
										<td colspan=2>
										<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
											<tr>
												<td id=age1 width="48%">Age of the Premises</td>
												<td id=age2 width="52%" align="left"><b><span class="mantatory">*&nbsp;</span></b></td>
											</tr>
										</table>
										</td>

										<td id=age3 width="25%"><input type="text" name="prop_age"
											value="<%=Helper.correctNull((String)hshValues.get("prop_age"))%>"
											size="10" maxlength="2" tabindex="18"
											onKeyPress="allowInteger()" style="text-align:right"> Years</td>
										<td id=firstmort1 colSpan=2>Will UBI be able to obtain first
										mortgage of dwelling Unit/Property</td>
										<td id=firstmort2 width="30%"><select tabIndex=19 onchange=""
											name=firstmortgage>
											<option value=s selected>select</option>
											<option value=Y>Yes</option>
											<option value=N>No</option>
										</select></td>
									</tr>
									<tr>
										<td id=undivided1 colSpan=2>Undivided Shares of Land</td>
										<td id=undivided2 width="25%"><input type="text"
											name="prop_costofcomplete"
											value="<%=Helper.correctNull((String)hshValues.get("prop_costofcomplete"))%>"
											size="20" maxlength="5" tabindex="20"
											onKeyPress="allowInteger()" style="text-align:right"></td>
										<td colSpan=2>House No/Plot No <b><font color=#ff0000>*</font></b>
										</td>
										<td width="30%"><input type="text" name="prop_houseno"
											value="<%=Helper.correctNull((String)hshValues.get("prop_houseno"))%>"
											size="20" maxlength="10" tabindex="22"></td>
									</tr>
									<tr>
										<td colspan=2>
										<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
											<tr>
												<td width="23%" id=floor1>Floor No.</td>
												<td width="23%" id=floor11>No of Floors</td>
												<td width="77%" id=floor2><b><span class="mantatory">*&nbsp;</span></b></td>
											</tr>
										</table>
										</td>
										<td width="25%"><input type="text" name="prop_floorno"
											size="12" maxlength="2" tabindex="23"
											value="<%=Helper.correctNull((String)hshValues.get("prop_floorno"))%>">
										</td>
										<td id=nature1 colSpan=2>Nature of the property</td>
										<td id=nature2 width="30%"><select tabIndex=25 name=sel_nature>
											<option value=S selected>select</option>
											<option value=R>Residential</option>
											<option value=C>commercial</option>
										</select></td>
									</tr>
									<tr>
										<td colSpan=2>Location Address <b><span class="mantatory">*&nbsp;</span></b></td>
										<td width="25%"><input type="text" name="prop_area"
											value="<%=Helper.correctNull((String)hshValues.get("prop_area"))%>"
											size="45" maxlength="500" tabindex="24"></td>
										<td colSpan=2>City <b><span class="mantatory">*&nbsp;</span></b></td>
										<td width="30%"><input type="text" name="prop_city" size="20"
											maxlength="20" tabindex="26" onKeyPress="notAllowSplChar()"
											value="<%=Helper.correctNull((String)hshValues.get("prop_city"))%>"><b><span
											onClick="showCitySearch('prop_city','prop_state','hidcity','hidstate','prop_pin','hidzip')"
											style="cursor:hand"><img
											src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
											border="0" tabindex="26"></span></b></td>
									</tr>
									<tr>
										<td colSpan=2>State <b><span class="mantatory">*&nbsp;</span></b></td>
										<td width="25%"><input type="text" name="prop_state" size="20"
											maxlength="20" tabindex="28"
											value="<%=Helper.correctNull((String)hshValues.get("prop_state"))%>"
											onKeyPress="notAllowSplChar()"></td>
										<td colSpan=2 height=39><%=ApplicationParams.getZipName()%><b><span class="mantatory">*&nbsp;</span></b></td>
										<td width="30%" height=39><input type="text" name="prop_pin"
											size="12" maxlength="6" tabindex="30"
											onKeyPress="allowInteger()"
											value="<%=Helper.correctNull((String)hshValues.get("prop_pin"))%>">
										</td>
									</tr>
									<tr>
										<td colSpan=2>
										<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
											<tr>
												<td id=landvalue1 width="92%">Market Value of the Land</td>
												<td width="8%" id=landvalue2>Rs.</td>
											</tr>
										</table>
										</td>
										<td id="landvalue3" width="25%"><lapschoice:CurrencyTag
											name="prop_mar_land"
											value='<%=Helper.correctNull((String)hshValues.get("prop_mar_land"))%>'
											size="15" maxlength="12" tabindex="27" /></td>
										<td colspan=2>
										<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
											<tr>
												<td width="12%" id=buldingvalue1 colSpan=2>Market Value of
												the Building/House</td>
												<td width="12%" id=buldingvalue13 colSpan=2>Market Value of
												the flat</td>
												<td width="12%" id=buldingvalue12><b><span class="mantatory">*&nbsp;</span></b></td>
												<td id=buldingvalue11 width="8%">Rs</td>
											</tr>
										</table>
										</td>
										<td id=buldingvalue2 width="30%"><lapschoice:CurrencyTag
											name="prop_mar_build"
											value='<%=Helper.correctNull((String)hshValues.get("prop_mar_build"))%>'
											size="15" maxlength="12" tabindex="29" /></td>
									</tr>
									<tr id=lease>
										<td colSpan=2 height=39>Unexpired Lease Period</td>
										<td width="25%" height=39><input type="text"
											name="prop_unexpiredlease" size="12" maxlength="3"
											tabindex="31"
											value="<%=Helper.correctNull((String)hshValues.get("prop_unexpiredlease"))%>">
										Years</td>
										<td colSpan=2>Unexpired Lease Period &nbsp;(Upto )</td>
										<td width="30%"><input type="text" name="prop_lease_expdate"
											value="<%=Helper.correctNull((String)hshValues.get("prop_lease_expdate"))%>"
											onBlur="dateDOBCheck(document.forms[0].prop_lease_expdate)"
											size="10" maxlength="50" tabindex="31"> <a href="#"
											onClick="callCalender('prop_lease_expdate')"
											title="Click to view calender" border=0><img
											src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
											border="0" tabindex="23"></a></td>
									</tr>
									<tr id=agreement>
										<td colSpan=2>Date of Agreement<b><span class="mantatory">*&nbsp;</span></b>
										</td>
										<td width="25%">
										<table cellSpacing=0 cellPadding=0 width=0% border=0 class="outertable">
											<tbody>
												<tr>
													<td><input type="Text" name="prop_agree_date" size="11"
														tabindex="32"
														value="<%=Helper.correctNull((String)hshValues.get("prop_agree_date"))%>"
														onBlur="checkDate(this);checkmaxdate(this,currentdate);dateDOBCheck(document.forms[0].prop_agree_date)">
													&nbsp;</td>
													<td><a href="#" onClick="callCalender('prop_agree_date')"
														title="Click to view calender" border=0><img
														src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
														border="0" tabindex="33"></a></td>
												</tr>
											</tbody>
										</table>
										</td>
										<td colSpan=2>Agreement No<b><span class="mantatory">*&nbsp;</span></b>
										</td>
										<td width="30%"><input type="Text" name="prop_agree_no"
											tabindex="33"
											value="<%=Helper.correctNull((String)hshValues.get("prop_agree_no"))%>"
											size="20" maxlength="50" onKeyPress="notAllowSplChar()"></td>
									</tr>
									<tr>
										<td colSpan=2>Property Used For</td>
										<td width="25%"><select tabIndex=34 name=sel_house
											onChange="rentout()">
											<option value=0 selected>--Select--</option>
											<option value=1>Renting Out</option>
											<option value=2>Self Occupation</option>
											<option value=3>Leasing Out</option>
											<option value=4>Commercial</option>
										</select></td>

										<td colSpan=2>
										<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
											<tr>
												<td id=rent1>Expected Rent Per Month</td>
												<td id=rent11>Rs</td>
											</tr>
										</table>
										</td>
										<td id=rent2 width="30%"><lapschoice:CurrencyTag
											name="prop_exp_rent"
											value='<%=Helper.correctNull((String)hshValues.get("prop_exp_rent"))%>'
											size="15" maxlength="12" tabindex="35" /></td>
									</tr>
									<tr>
										<td id=sellername1 colSpan=2>Seller/ Owner Name</td>
										<td id=sellername2 width="25%"><input type="text"
											name="prop_sellername" size="30" maxlength="50" tabindex="37"
											value="<%=Helper.correctNull((String)hshValues.get("prop_sellername"))%>">
										</td>
										<td colSpan=2>Interim security</td>
										<td width="30%"><input type="text" name="prop_intermsecurity"
											value="<%=Helper.correctNull((String)hshValues.get("prop_intermsecurity"))%>"
											size="50" maxlength="100" tabindex="8"></td>
									</tr>
									<tr>
										<td id=selleraddr1 colSpan=2>Seller/ Owner Address</td>
										<td id=selleraddr2 width="25%"><b> <textarea
											name="txt_selleraddress" tabindex="39" cols="30" rows="3"
											wrap="VIRTUAL"
											onKeyPress="notAllowSingleAndDoubleQuote();textlimit(this,40)" onKeyUp="textlimit(this,40)"><%=Helper.correctNull((String) hshValues
							.get("prop_sell_add"))%></textarea> </b></td>
										<td id=projdetail1 colSpan=2>Project Name &amp; Details</td>
										<td id=projdetail2 width="30%"><b> <textarea
											name="prop_proj_details" tabindex="36" cols="30" rows="3"
											wrap="VIRTUAL"
											onKeyPress="notAllowSingleAndDoubleQuote();textlimit(this,40)" onKeyUp="textlimit(this,40)"><%=Helper.correctNull((String) hshValues
							.get("prop_proj_details"))%></textarea> </b></td>
									</tr>
									<tr>
										<td colspan=2>
										<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
											<tr>
												<td id=completion1 width="51%">Particulars of Completion</td>
												<td id=completion12 width="51%">Particulars of Completion of
												Renovation<b><span class="mantatory">*&nbsp;</span></b></td>
												<td id=completion2 width="49%"><b><span class="mantatory">*&nbsp;</span></b></td>
											</tr>
										</table>
										</td>
										<td id=completion3 width="25%"><b> <textarea
											name="txt_completion" tabindex="38" cols="30" rows="3"
											wrap="VIRTUAL"
											onKeyPress="notAllowSingleAndDoubleQuote();textlimit(this,40)" onKeyUp="textlimit(this,40)"><%=Helper.correctNull((String) hshValues
							.get("prop_completion"))%></textarea> </b></td>
										<td colSpan=2>Charges if Any</td>
										<td width="30%"><b> <textarea name="txt_prop_charges"
											tabindex="36" cols="30" rows="3" wrap="VIRTUAL"
											onKeyPress="notAllowSingleAndDoubleQuote();textlimit(this,40)" onKeyUp="textlimit(this,40)"><%=Helper.correctNull((String) hshValues
							.get("prop_chargesany"))%></textarea> </b></td>
									</tr>
									<tr id=cost1>
										<td colspan=2>
										<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
											<tr>
												<td width="42%" id=landcost1>Cost per sq. ft (Land)</td>
												<td width="42%" id=landcost12>Cost per sq. ft</td>

												<td width="50%" id=landcost2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b><span class="mantatory">*&nbsp;</span></b></td>
												<td width="8%" align="left" id=landcost3>Rs</td>
											</tr>
										</table>
										</td>
										<td id="cost3" width="25%"><lapschoice:CurrencyTag
											name="prop_cost"
											value='<%=Helper.correctNull((String)hshValues.get("prop_cost"))%>'
											size="20" maxlength="15" tabindex="40" /></td>
										<td colspan=2>
										<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
											<tr>

												<td width="75%" id=concost1>Cost per sq.ft (Construction)</td>
												<td width="17%" id=concost2><b><span class="mantatory">*&nbsp;</span></b></td>
												<td width="8%" align="left" id=concost3>Rs</td>
											</tr>
										</table>
										</td>
										<td width="30%" id="concost4"><lapschoice:CurrencyTag
											name="prop_costofconstruction"
											value='<%=Helper.correctNull((String)hshValues.get("prop_costofconstruction"))%>'
											size="20" maxlength="15" tabindex="40" /></td>
									</tr>
									<tr>
										<td width="13%">&nbsp;</td>
										<td width="12%">&nbsp;</td>
										<td width="25%">&nbsp;</td>


										<td colspan=2>
										<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
											<tr>
												<td id=particulars11 colSpan=2>Particulars of permission</td>
												<td id=particulars1 colSpan=2>Sanction for construction</td>
												<td id=particulars13>Particulars of permission from relevant
												Authority</td>
												<td width="36%" id=particulars12><b><span class="mantatory">*&nbsp;</span></b></td>
											</tr>
										</table>
										</td>
										<td id=particulars2 width="30%"><b> <textarea
											name="prop_construction" tabindex="41" cols="30" rows="3"
											wrap="VIRTUAL" onKeyPress="notAllowSingleAndDoubleQuote();textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues
									.get("prop_constr"))%></textarea> </b></td>
									</tr>
									<tr id=occupancy>
										<td colSpan=2>Occupancy Certificate Issued Date</td>
										<td colSpan=4>
										<table width="11%" cellSpacing=0 cellPadding=0 border=0>
												<tr>
													<td width=73><input type="text" name="txt_certificateissu"
														size="11" tabindex="42" maxlength="11"
														value="<%=Helper.correctNull((String)hshValues.get("prop_occucerti_issue"))%>"
														onBlur="checkDate(this);checkmaxdate(this,currentdate);" readOnly> &nbsp;</td>
													<td align=left width=33><a alt="Select date from calender"
														href="#" onClick="callCalender('txt_certificateissu')"
														onMouseOver="window.status='Date Picker';return true;"
														onMouseOut="window.status='';return true;"><img
														src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
														border=0 alt="Select date from calender" tabindex="44"></a></td>
												</tr>
										</table>
										</td>
									</tr>
									<tr>
										<td colSpan=6>
										<table cellSpacing=0 cellPadding=1 width="100%" border=0 class="outertable">
											<tbody>
												<tr>
													<td vAlign=top width="12%"><b>Location [Indicators]</b></td>
													<td width="43%">
													<table cellSpacing=0 cellPadding=3 width="100%" border=0 class="outertable">
														<tbody>
															<tr>
																<td><INPUT
																	style="BORDER-RIGHT: medium none; BORDER-TOP: medium none; BORDER-LEFT: medium none; BORDER-BOTTOM: medium none"
																	tabIndex=43 type=checkbox value=Y name=chk_mainroad>Near
																by Main Road</td>
															</tr>
															<tr>
																<td><INPUT
																	style="BORDER-RIGHT: medium none; BORDER-TOP: medium none; BORDER-LEFT: medium none; BORDER-BOTTOM: medium none"
																	tabIndex=44 type=checkbox value=Y
																	name=chk_eduinstitution> Near by Market/ Educational
																Institution</td>
															</tr>
															<tr>
																<td><INPUT
																	style="BORDER-RIGHT: medium none; BORDER-TOP: medium none; BORDER-LEFT: medium none; BORDER-BOTTOM: medium none"
																	tabIndex=45 type=checkbox value=Y name=chk_public> Near
																by Other Public Utilities viz., Hospital/Post
																Office/Railway Station etc</td>
															</tr>
															<tr>
																<td><INPUT
																	style="BORDER-RIGHT: medium none; BORDER-TOP: medium none; BORDER-LEFT: medium none; BORDER-BOTTOM: medium none"
																	tabIndex=46 type=checkbox value=Y name=chk_prime>
																Neighbourhood - Prime/ Suburb etc.</td>
															</tr>
														</tbody>
													</table>
													</td>
													<td vAlign=top width="12%"><b>Amenities [Indicators] </b></td>
													<td width="33%">
													<table cellSpacing=0 cellPadding=3 width="100%" border=0 class="outertable">
														<tbody>
															<tr>
																<td><INPUT
																	style="BORDER-RIGHT: medium none; BORDER-TOP: medium none; BORDER-LEFT: medium none; BORDER-BOTTOM: medium none"
																	tabIndex=47 type=checkbox value=Y name=chk_accessible>
																Accessible to Road</td>
															</tr>
															<tr>
																<td><INPUT
																	style="BORDER-RIGHT: medium none; BORDER-TOP: medium none; BORDER-LEFT: medium none; BORDER-BOTTOM: medium none"
																	tabIndex=48 type=checkbox value=Y name=chk_assured>Assured
																water supply</td>
															</tr>
															<tr>
																<td><INPUT
																	style="BORDER-RIGHT: medium none; BORDER-TOP: medium none; BORDER-LEFT: medium none; BORDER-BOTTOM: medium none"
																	tabIndex=49 type=checkbox value=Y name=chk_drainages>
																Proper Drainage System/ Not pruned to water logging</td>
															</tr>
															<tr>
																<td><INPUT
																	style="BORDER-RIGHT: medium none; BORDER-TOP: medium none; BORDER-LEFT: medium none; BORDER-BOTTOM: medium none"
																	tabIndex=50 type=checkbox value=Y
																	name=chk_currentconnection>Current Connection available</td>
															</tr>
														</tbody>
													</table>
													</td>
												</tr>
											</tbody>
										</table>
										</td>
									</tr>
								</tbody>
							</table>
							</td>
						</tr>
					</tbody>
				</table>
				</td>
			<tr>
				<td>
				<table cellSpacing=0 cellPadding=4 width="100%" border=0 class="outertable">
					<tbody>
						<tr id=builder>
							<td width="45%" colSpan=3>
							<div align=left>Name of the Builder and his reputation &amp;
							track record in completion of earlier Project</div>
							</td>
							<td width="55%" colSpan=3><input type="HIDDEN"
								name="txt_buildercode" size="11" tabindex="18" maxlength="11"
								value="<%=Helper.correctNull((String)hshValues.get("prop_housingaddress"))%>"
								Readonly> <input type="text" name="prop_housingaddress"
								size="45" maxlength="500" tabindex="51"
								value="<%=Helper.correctNull((String)hshValues.get("builder_name"))%>">
							<b><span onClick="callsupnam()" style="cursor:hand"><img
								src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
								border="0" tabindex="54"></span></b></td>
						</tr>
						<tr id=builder1>
							<td colSpan=2>Municipal Tax Paid Upto</td>
							<td><input type="text" name="txt_municipaldate" size="11"
								tabindex="42" maxlength="11"
								value="<%=Helper.correctNull((String)hshValues.get("prop_municipalupto"))%>"
								onBlur="checkDate(this);checkmaxdate(this,currentdate);"
								readOnly><a alt="Select date from calender"
								href="#" onClick="callCalender('txt_municipaldate')"
								onMouseOver="window.status='Date Picker';return true;"
								onMouseOut="window.status='';return true;"><img
								src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border=0
								alt="Select date from calender" tabindex="44"></a></td>
							<td colSpan=2 align="right">Water Tax Paid Upto</td>
							<td nowrap><input type="text" name="txt_waterdate" size="11"
								tabindex="42" maxlength="11"
								value="<%=Helper.correctNull((String)hshValues.get("prop_waterdate"))%>"
								onBlur="checkDate(this);checkmaxdate(this,currentdate);"
								readOnly> <a alt="Select date from calender"
								href="#" onClick="callCalender('txt_waterdate')"
								onMouseOver="window.status='Date Picker';return true;"
								onMouseOut="window.status='';return true;"><img
								src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border=0
								alt="Select date from calender" tabindex="44"></a></td>
						</tr>
						<tr id=society>
							<td colSpan=3>
							Name of the Society incase the site is allotted
							by Co-op.Housing Society <BR>
							and whether it is approved by competent authority in the State
							Government.
							</td>
							<td colSpan=3><input type="hidden" name="txt_coopcode" size="11"
								tabindex="18" maxlength="11"
								value="<%=Helper.correctNull((String)hshValues.get("prop_institutename"))%>"
								Readonly> <input type="text" name="prop_institutename"
								tabindex="52"
								value="<%=Helper.correctNull((String)hshValues.get("coopsoc_name"))%>"
								size="45" maxlength="500"> <b><span onClick="callsupnam1()"
								style="cursor:hand"><img
								src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
								border="0" tabindex="56"></span></b></td>
						</tr>
						<tr id=society1>

							<td>
							<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
								<tr>
									<td width="91%" id=permssion1>Whether Society's Permission/NOC
									for sale is obtained?</td>
									<td width="91%" id=permssion12>Whether Society's Permission/NOC
									for renovation is obtained?</td>
									<td width="9%" id=permssion2><b><span class="mantatory">*&nbsp;</span></b></td>
								</tr>
							</table>
							</td>
							<td id=permssion3><select name=prop_societypermission>
								<option value=0 selected>---Select---</option>
								<option value=1>Yes</option>
								<option value=2>No</option>
							</select></td>
							<td>
							<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
								<tr>
									<td id=lien1>Any lien has been marked in Society's record for
									the flat.</td>
								</tr>
							</table>
							</td>
							<td id=lien3><select name=prop_liensociety>
								<option value=0 selected>---Select---</option>
								<option value=1>Yes</option>
								<option value=2>No</option>
							</select></td>
							<td>
							<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
								<tr>
									<td width="85%" id=amtoutstanding1>Whether any amount to be
									paid to society is outstanding?</td>
									<td width="15%" id=amtoutstanding2><b><span class="mantatory">*&nbsp;</span></b></td>
								</tr>
							</table>
							</td>
							<td id=amtoutstanding><select name=prop_outstandingsociety>
								<option value=0 selected>---Select---</option>
								<option value=1>Yes</option>
								<option value=2>No</option>
							</select></td>
						</tr>
					</tbody>
				</table>
				</td>
			</tr>
			</table>
			<br>
				<table border="0" align="center" cellspacing="1" cellpadding="3"
					width="90%" class="outertable">
					<tr class="dataheader">
						<td width="5%">Sl.No</td>
						<td width="25%">Esitimate of Cost</td>
						<td width="25%">&nbsp;</td>
						<td width="5%">Sl.No</td>
						<td width="25%">Estimate of Sources</td>
						<td width="15%"><%=ApplicationParams.getCurrency()%></td>
					</tr>
					<tr class="datagrid">
						<td>01</td>




						<td id="5"><%if (prd_type.equalsIgnoreCase("pH")) {

			%> Purchase price of Land/House/Flat <%} else {

			%> Purchase price of Premises <%}

			%></td>



						<td><lapschoice:CurrencyTag name="prop_costofamenties"
							tabindex="54" onBlur="caculatetot()"
							value='<%=Helper.correctNull((String)hshValues.get("prop_costofamenties"))%>'
							size="15" maxlength="9" /></td>
						<td>01</td>
						<td>Loans requested from the Bank
						<td><lapschoice:CurrencyTag name="prop_amountinvested"
							tabindex="66"
							value='<%=Helper.correctNull((String)hshValues.get("prop_amountinvested"))%>'
							size="15" onBlur="caculatetot()" /></td>
					</tr>
					<tr class="datagrid">
						<td>02</td>

						<td><%if (prd_type.equalsIgnoreCase("pH")) {

			%> Cost of Construction/Improvement <%} else {

			%> Furnishing Cost <%}

			%></td>

						<td><lapschoice:CurrencyTag name="prop_costofconstruct"
							value='<%=Helper.correctNull((String)hshValues.get("prop_costofconstruct"))%>'
							tabindex="55" size="15" maxlength="12" onBlur="caculatetot()" /></td>
						<td>02</td>
						<td>Cost already incurred</td>
						<td width="40%"><lapschoice:CurrencyTag name="prop_savingbank"
							tabindex="67"
							value='<%=Helper.correctNull((String)hshValues.get("prop_savingbank"))%>'
							size="15" maxlength="12" onBlur="caculatetot()" /></td>
					</tr>
					<tr class="datagrid">
						<td>03</td>


						<td>Document/Registration Fees</td>
						<td><lapschoice:CurrencyTag name="prop_registration"
							onBlur="caculatetot()"
							value='<%=Helper.correctNull((String)hshValues.get("prop_registration"))%>'
							size="15" maxlength="12" tabindex="57" /></td>
						<td>03</td>
						<td>Own Savings and Disposal of
						Investments(FD's,Shares,NSC,LICP,Provident Fund)</td>
						<td width="40%"><lapschoice:CurrencyTag name="prop_disposal"
							size="15" tabindex="68" onBlur="caculatetot()"
							value='<%=Helper.correctNull((String)hshValues.get("prop_disposal"))%>'
							maxlength="12" /></td>
					</tr>
					<tr class="datagrid">

						<td>
						<p>&nbsp;</p>
						<p>04</p>
						<p>05</p>
						</td>



						<td height="134"><b>Other Costs(Specify)</b><br>
						<input type="text" name="prop_costrepair" tabindex="59"
							value="<%=Helper.correctNull((String)hshValues.get("prop_costrepair"))%>"
							size="15" maxlength="500" onBlur="this.className=''"
							onFocus="this.className='fancyfld' " style="text-align:left"> <br>
						<input type="text" name="prop_spy2" tabindex="61"
							value="<%=Helper.correctNull((String)hshValues.get("prop_spy2"))%>"
							size="15" maxlength="500" onBlur="this.className=''"
							onFocus="this.className='fancyfld' " style="text-align:left"></td>
						<td height="134"><lapschoice:CurrencyTag name="txtcostofland"
							tabindex="60"
							value='<%=Helper.correctNull((String)hshValues.get("prop_costofland"))%>'
							size="15" maxlength="12" onBlur="caculatetot()" /> <br>
						<lapschoice:CurrencyTag name="prop_outstandingloan" tabindex="62"
							onBlur="caculatetot()"
							value='<%=Helper.correctNull((String)hshValues.get("prop_outstandingloan"))%>'
							size="15" maxlength="12" /></td>

						<td height="134">
						<p>&nbsp;</p>
						<p>04</p>
						</td>

						<td height="134">
						<p><b>Others (Specify) </b></p>
						<p><input type="text" name="prop_otherspy2"
							value="<%=Helper.correctNull((String)hshValues.get("prop_otherspy2"))%>"
							size="15" maxlength="50" tabindex="69" onBlur="caculatetot()"
							onFocus="this.className='fancyfld' " style="text-align:left"></p>
						</td>

						<td width="40%" height="134">
						<p>&nbsp;</p>
						<p><lapschoice:CurrencyTag name="prop_otheramt2"
							value='<%=Helper.correctNull((String)hshValues.get("prop_otheramt2"))%>'
							size="15" tabindex="70" maxlength="50" onBlur="caculatetot()" />
						</p>
						</td>
					</tr>
					<tr class="datagrid">
						<td>06</td>

						<td><input type="text" name="prop_otherspy" tabindex="63"
							value="<%=Helper.correctNull((String)hshValues.get("prop_otherspy"))%>"
							size="15" maxlength="500" onBlur="this.className=''"
							onFocus="this.className='fancyfld' " style="text-align:left"></td>
						<td><lapschoice:CurrencyTag name="prop_otheramt"
							onBlur="caculatetot()"
							value='<%=Helper.correctNull((String)hshValues.get("prop_otheramt"))%>'
							size="15" maxlength="50" tabindex="64" /></td>
						<td>05</td>

						<td>
						<div align="left"><input type="text" name="prop_otherspy1"
							value="<%=Helper.correctNull((String)hshValues.get("prop_otherspy1"))%>"
							size="15" maxlength="50" tabindex="71" onBlur="caculatetot()"
							onFocus="this.className='fancyfld' " style="text-align:left"></div>
						</td>
						<td width="40%"><lapschoice:CurrencyTag name="prop_otheramt1"
							value='<%=Helper.correctNull((String)hshValues.get("prop_otheramt1"))%>'
							size="15" maxlength="12" tabindex="72" onBlur="caculatetot()" />
						</td>
					</tr>
					<tr class="dataheader">
						<td>&nbsp;</td>
						<td>Total Cost</td>
						<td><input type="text" name="prop_totalcost"
							value="<%=Helper.correctNull((String)hshValues.get("prop_totalcost"))%>"
							readOnly="readonly" size="15" maxlength="15" tabindex="65"
							style="text-align:right"></td>

						<td>&nbsp;</td>

						<td>Total Fund</td>
						<td width="40%"><input type="text" name="prop_totalfund"
							value="<%=Helper.correctNull((String)hshValues.get("prop_totalfund"))%>"
							size="15" maxlength="15" tabindex="73" style="text-align:right"
							readOnly="readonly"></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
		</table>
		</td>
	</tr>
</table>
<br>
<table border="0" cellspacing="0" cellpadding="3" align="center" class="outertable linebor buttonbgcolor">
	<tr>
		<td align="center"><input type="button" name="cmddisbursement"
			value="Disbursement details" class="buttonStyle" style="width:150"
			onClick="opendisbursement()"></td>
		<td align="center"><input type="button" name="cmddisbursement2"
			value="General Information" class="buttonStyle" style="width:150"
			onClick="openGeneral()"></td>
		<td align="center"><input type="button" name="pretakeover"
			class="buttonStyle" style="width:150" value="TakeOver"
			onClick="calltakeover()"></td>
	</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail'
	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<BR>
<lapschoice:hiddentag pageid='<%=PageId%>'/> 
<INPUT TYPE="hidden" name="radLoan" value="Y"> 
<input type="hidden"  name="txt_staticdataid" value="<%=Helper.correctNull((String)hshValues.get("prop_own_status"))%>">
<input type="hidden" name="txt_staticdataid1" value="<%=Helper.correctNull((String)hshValues.get("prop_dwelling_unit"))%>">
<input type="hidden" name="txt_staticdataid2" value="<%=Helper.correctNull((String)hshValues.get("prop_house_rent"))%>">
<input type="hidden" name="txt_staticdataid3" value="<%=Helper.correctNull((String)hshValues.get("prop_mortgage"))%>">
<input type="hidden" name="hidcity" value="<%=((String)hshValues.get("hidcity"))%>"> 
<input type="hidden" name="hidstate" value="<%=((String)hshValues.get("hidstate"))%>"> 
 <input type="hidden" name="hidzip" value="<%=Helper.correctNull((String) hshValues.get("state_validatepin"))%>">
</form>
</body>
</html>

