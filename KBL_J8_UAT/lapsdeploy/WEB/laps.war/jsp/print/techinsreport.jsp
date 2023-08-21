<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>
<laps:handleerror />
<% 

String pur1="",pur2="";;
String purpose1=Helper.correctNull((String)hshValues.get("PURPOSEOFREPORT1"));
String purpose2=Helper.correctNull((String)hshValues.get("PURPOSEOFREPORT2"));
if(purpose1 != "")
{
	if(purpose1.equals("1"))
		{
			pur1="Existing Project";
		}
	if(purpose1.equals("2"))
		{
			pur1="New Project (Appraisal)";
		}
	if(purpose1.equals("3"))
		{
			pur1="Sick Unit";
		}
	
}

if(purpose2 !="")
{
	if(purpose2.equals("1"))
		{
			pur2="Routine Appraisal";
		}
	if(purpose2.equals("2"))
		{
			pur2="Assessment";
		}
	if(purpose2.equals("3"))
		{
			pur2="Expansion Scheme";
		}
	if(purpose2.equals("4"))
		{
			pur2="Apprising";
		}
	if(purpose2.equals("5"))
	{
		pur2="Evaluting nuring programme";
	}
}
%>


<html>
<head>
<title>Technical / Inspection Report</title>
<style type="text/css">

</style>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/report.css"
	type="text/css">
	<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/print.css"	type="text/css" >

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body bgcolor="#FFFFFF" text="#000000">
<div id="top">
<table width="100%" border="0" cellspacing="0" cellpadding="3">
  <tr> 
    <td align="center" colspan="7"><img src="<%=ApplicationParams.getAppUrl()%>img/ubibilinguallogo.jpg" /></td>
  </tr>
  <!-- <tr> 
    <td align="center" colspan="7"><b><strong><font size="2" face="MS Sans Serif">Union 
      Bank of India</font></strong></b> </td>
  </tr> -->
  <tr> 
    <td align="center" colspan="7"><b>Branch - <%=Helper.correctNull((String)hshValues.get("orgname"))%></b></td>
  </tr>
  <tr> 
    <td align="center" colspan="7"><%=Helper.correctNull((String)hshValues.get("orgadd1"))%>,&nbsp; 
      <%=Helper.correctNull((String)hshValues.get("orgadd2"))%>,&nbsp; <%=Helper.correctNull((String)hshValues.get("orgcity"))%>,&nbsp; 
      <%=Helper.correctNull((String)hshValues.get("orgstate"))%>-&nbsp; <%=Helper.correctNull((String)hshValues.get("orgzip"))%>&nbsp; 
    </td>
  </tr>
  <tr>
    <td align="center" colspan="7"> <strong><font size="2" face="MS Sans Serif"> 
      <%String insflag=Helper.correctNull((String)hshValues.get("insflag"));
  if(insflag.equalsIgnoreCase("T")){ 
    out.println("TECHNICAL INSPECTION REPORT");
  }else if(insflag.equalsIgnoreCase("I")){
  out.println("INSPECTION REPORT");
	} %>
      </font></strong> 
  </tr>
  <tr bgcolor="white"> 
    <td bgcolor="white" colspan="7" height="28"><laps:application/></td>
    
  </tr>
  <tr> 
    <td width="31%" height="28"><strong>(1) Purpose of Report</strong>&nbsp;</td>
    <td width="18%" height="28"><%=pur1%>&nbsp;</td>
    <td height="28" colspan="2"><%=pur2%>&nbsp;</td>
    <td height="28" width="17%"><strong>Date of Inspection</strong>&nbsp;</td>
    <td height="28" width="10%" colspan="2"><%=Helper.correctNull((String)hshValues.get("DATEOFINSPECTION"))%>&nbsp;</td>
    </tr>
  <tr> 
    <td colspan="2"><strong>(2) Infrastructure Location Factors</strong>&nbsp;</td>
    <td colspan="5">&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2"> &nbsp;&nbsp;<b>&nbsp;&nbsp;2.1</b> Raw Material Sources<br>
    &nbsp;</td>
    <td colspan="5"><%=Helper.correctNull((String)hshValues.get("RAWMATERIAL"))%>&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;<b>2.2</b> Water Arrangements (State 
      quantum for Industries with High requirement of water storage arrangements)<br>&nbsp;
    </td>
    <td colspan="5"><%=Helper.correctNull((String)hshValues.get("WATERARRANGEMANTS"))%>&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;<b>2.3</b> Power(availability, required 
      and sanctioned load/Power Shortage/cuts,standby generator)<br>
    </td>
    <td colspan="5"><%=Helper.correctNull((String)hshValues.get("POWER"))%>&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;&nbsp;&nbsp;<b>&nbsp;2.4 </b>Fuel<br>&nbsp;
    </td>
    <td colspan="5"><%=Helper.correctNull((String)hshValues.get("FUEL"))%>&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;<b>2.5</b> Transportation and Communications(Distance 
      from railway station/highway/our branch)<br>
    </td>
    <td colspan="5"><%=Helper.correctNull((String)hshValues.get("TRANSPORTATION"))%>&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="7" height="23">&nbsp;&nbsp;&nbsp;<strong>&nbsp;2.6 Manpower <br>
      </strong> &nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>&nbsp;2.6.1 </b>Skilled/Unskilled<br>
    &nbsp;</td>
    <td colspan="5"><%=Helper.correctNull((String)hshValues.get("MANPOWER"))%>&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>2.6.2 </b>Prevalent 
      wage rates<br>
    </td>
    <td colspan="5"><%=Helper.correctNull((String)hshValues.get("PREVALENTWAGERATES"))%>&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>2.6.3 </b>Labour 
      relations, incidence of strike/ go slow/lockouts etc..<br>
    </td>
    <td colspan="5"><%=Helper.correctNull((String)hshValues.get("LABOURRELATION"))%>&nbsp;</td>
  </tr>
  <tr> 
    <td height="29" colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;<b>2.7 </b>Market For 
      Products<br>
    </td>
    <td height="29" colspan="5"><%=Helper.correctNull((String)hshValues.get("MARKETFORPRODUCTS"))%>&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;<b>2.8</b> Workshop Facilities for 
      Repairs<br>
    </td>
    <td colspan="5"><%=Helper.correctNull((String)hshValues.get("WORKSHOPFACILITIES"))%>&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;<b>2.9</b> Any Other Special Features 
      such as special facilities/concession available in the place/area<br>
    </td>
    <td colspan="5"><%=Helper.correctNull((String)hshValues.get("SPECIALFEATURES"))%>&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;<b>2.10</b> Banking Facilities<br>
    </td>
    <td colspan="5"><%=Helper.correctNull((String)hshValues.get("BANKINGFACILITIES"))%>&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;<b>2.11</b> Effluent disposal and 
      drainage;Pollution control and environment safeguard measures; permission 
      of Pollution Control Authorities<br>
    </td>
    <td colspan="5"><%=Helper.correctNull((String)hshValues.get("POLLUTION"))%>&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="7"><b>(3) Land and Building </b><br>
    </td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;<b>3.1</b> Land<br>
    </td>
    <td colspan="5">&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>3.1.1</b> 
      Rented/Own<br>
    </td>
    <td colspan="5"><%=Helper.correctNull((String)hshValues.get("land_rentedown"))%>&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>3.1.2</b> 
      Whether mortgaged to Bank/any other financial institution<br>
    </td>
    <td colspan="5"><%=Helper.correctNull((String)hshValues.get("whethermortgaged"))%>&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>3.1.3</b> 
      Total area, purchase cost/taxes/rent<br>
    </td>
    <td colspan="5"><%=Helper.correctNull((String)hshValues.get("totalarea"))%>&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>3.1.4</b> 
      Development expenses on fencing, levelling, etc.<br>
    </td>
    <td colspan="5"><%=Helper.correctNull((String)hshValues.get("developmentcharges"))%>&nbsp;</td>
  </tr>
  <tr> 
    <td height="27" colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;<strong>3.2 Building</strong><br>
    </td>
    <td height="27" colspan="5"></td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>3.2.1</b>. 
      Built-up area<br>
    </td>
    <td colspan="5">:<%=Helper.correctNull((String)hshValues.get("builtuparea"))%>&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>3.2.2</b> 
      Types of structures<br>
    </td>
    <td colspan="5"><%=Helper.correctNull((String)hshValues.get("typesofstructures"))%>&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>3.2.3</b> 
      Adequacy of space for present use as well as for further expansion<br>
      <br>
    </td>
    <td colspan="5"><%=Helper.correctNull((String)hshValues.get("adequencyofspace"))%>&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>3.2.4</b> 
      Deeds and records, if seen<br>
    </td>
    <td colspan="5"><%=Helper.correctNull((String)hshValues.get("deedsandrecords"))%>&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>3.2.5</b> 
      Godown facilities inside the premises<br>
    </td>
    <td colspan="5"><%=Helper.correctNull((String)hshValues.get("godownfacilities"))%>&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="7" height="34"><strong>(4) Plant &amp; Machinery</strong><br>
      <br>
    </td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;&nbsp;&nbsp;<b>&nbsp;4.1</b> Itemwise particulars, capacities, 
      power requirement and cost of existing and proposed machinery<br>
    </td>
    <td colspan="5"><%=Helper.correctNull((String)hshValues.get("particulars"))%>&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;&nbsp;&nbsp;<b>&nbsp;4.2</b> Condition of Machines<br>
    </td>
    <td colspan="5"><%=Helper.correctNull((String)hshValues.get("conditionsofmachine"))%>&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;<b>4.3</b> Satisfactory arrangements 
      for maintenance and repairs<br>
    </td>
    <td colspan="5"><%=Helper.correctNull((String)hshValues.get("SATISFACTORYARRANGEMENTS"))%>&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;<b>4.4</b> In case of Imported machines, 
      availability of repair, facilities and spare parts<br>
    </td>
    <td colspan="5"><%=Helper.correctNull((String)hshValues.get("IMPORTEDMACHINES"))%>&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;<b>4.5</b> Comments on balancing of 
      capacities and on need, if any, for acquiring balancing equipments<br>
    </td>
    <td colspan="5"><%=Helper.correctNull((String)hshValues.get("COMMENTSONBALANCING"))%>&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;<b>4.6</b> Comments on adequacy of 
      machines for planned production<br>
    </td>
    <td colspan="5"><%=Helper.correctNull((String)hshValues.get("COMMENTSONADEQUACY"))%>&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;<b>4.7</b> Availability of new machinery 
      required; Comments on quotations/suppliers, etc.<br>
    </td>
    <td colspan="5"><%=Helper.correctNull((String)hshValues.get("AVAILABILITY"))%>&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;<b>4.8</b> Comments on layout<br>
    </td>
    <td colspan="5"><%=Helper.correctNull((String)hshValues.get("COMMENTSONLAYOUT"))%>&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;<b>4.9</b> Whether hypothecated to 
      Bank/ any other institution<br>
    </td>
    <td colspan="5"><%=Helper.correctNull((String)hshValues.get("WHETHERHYPOTHECATED"))%>&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2"><strong>(5) Products</strong> (Brief particualrs of products 
      manufactured and their applications/uses)</td>
    <td colspan="5"><%=Helper.correctNull((String)hshValues.get("PRODUCTS_PARTICULARS"))%>&nbsp;</td>
  </tr>
  <tr> 
    <td height="24" colspan="2"><strong>(6) Production</strong></td>
    <td height="24" colspan="5">:&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;<b>6.1</b> Operations/processes involved 
      (Brief description, if and when necessary, for projecting the picture of 
      the Industry to a non-technical person)<br>
    </td>
    <td colspan="5"><%=Helper.correctNull((String)hshValues.get("OPERATIONS_PROCESSES"))%>&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;<b>6.2</b> Rates of the production 
      per hour/day<br>
    </td>
    <td colspan="5"><%=Helper.correctNull((String)hshValues.get("RATESOFTHEPRODUCTION"))%>&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;<b>6.3</b> Number of shifts<br>
    </td>
    <td colspan="5"><%=Helper.correctNull((String)hshValues.get("NUMBEROFSHIFTS"))%>&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;&nbsp;&nbsp;<b>&nbsp;6.4 </b>Quantities produced (yearwise/monthwise)<br>
    </td>
    <td width="8%">Month Wise: </td>
    <td width="12%"><%=Helper.correctNull((String)hshValues.get("QUANTITIESPRODUCED_MONTH"))%>&nbsp;</td>
    <td width="4%">Year Wise: </td>
    <td colspan="2"><%=Helper.correctNull((String)hshValues.get("QUANTITIESPRODUCED_YEAR"))%>&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;&nbsp;&nbsp;<b>&nbsp;6.5</b> Comments on achievement 
      of more production<br>
    </td>
    <td colspan="5"><%=Helper.correctNull((String)hshValues.get("COMMENTSONACHIEVEMENT"))%>&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;<b>6.6</b> Quality; compare with other 
      products<br>
    </td>
    <td colspan="5"><%=Helper.correctNull((String)hshValues.get("QUALITY"))%>&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;<b>6.7</b> Testing and Quality Control 
      Facilities<br>
    </td>
    <td colspan="5"><%=Helper.correctNull((String)hshValues.get("TESTINGANDQUALITYCONTROL"))%>&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="7" height="27"><strong>(7) Raw Materials </strong><br>
    </td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;<b>7.1 </b>Availability -palces/prices/quality; 
      seasonal availability, whether available in quota with full details<br>
    </td>
    <td colspan="5"><%=Helper.correctNull((String)hshValues.get("rawmaterial_availability"))%>&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;<b>7.2</b> Arrangements, if any, for 
      bought out parts/ components<br>
    </td>
    <td colspan="5"><%=Helper.correctNull((String)hshValues.get("rawmaterial_arrangements"))%>&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;<b>7.3</b> Suppliers<br>
    </td>
    <td colspan="5"><%=Helper.correctNull((String)hshValues.get("suppliers"))%>&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;<b>7.4</b> Credit available<br>
    </td>
    <td colspan="5"><%=Helper.correctNull((String)hshValues.get("creditavailable"))%>&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;<b>7.5 </b>Frequency of purchase and 
      time gap between placing of order and delivery<br>
    </td>
    <td colspan="5"><%=Helper.correctNull((String)hshValues.get("frquencyofpurchase"))%>&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;<b>7.6 </b>Imported Raw materials 
      and their percentage<br>
    </td>
    <td colspan="5"><%=Helper.correctNull((String)hshValues.get("imported_rawmaterial"))%>&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;&nbsp;&nbsp;<b>&nbsp;7.7 </b>For Imported materials, 
      whether license obtained/available and applied for<br>
    </td>
    <td colspan="5"><%=Helper.correctNull((String)hshValues.get("rawmaterial_license"))%>&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;<b>7.8</b> Value of import license 
      on hand<br>
    </td>
    <td colspan="5"><%=Helper.correctNull((String)hshValues.get("valueof_importlicense"))%>&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;<b>7.9</b> Storage/godown/warehousing 
      arrangements<br>
    </td>
    <td colspan="5"><%=Helper.correctNull((String)hshValues.get("storage"))%>&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;&nbsp;&nbsp;<b>&nbsp;7.10</b> Inspection of existing 
      inventories and components about adequacy/excess(quantity) and condition(quality)<br>
    </td>
    <td colspan="5"><%=Helper.correctNull((String)hshValues.get("inspection"))%>&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;<b>7.11</b> Insurance Cover<br>
    </td>
    <td colspan="5"><%=Helper.correctNull((String)hshValues.get("insurance_cover"))%>&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;<b>7.12</b> Old stock accumulation 
      and arrangements/plan for utilisation/disposal<br>
    </td>
    <td colspan="5"><%=Helper.correctNull((String)hshValues.get("oldstockaccumulation"))%>&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2"><strong>(8) Marketing </strong><br>
    </td>
    <td colspan="5">&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2"><strong>&nbsp;&nbsp;&nbsp;&nbsp;8.1 Demand</strong><br>
    </td>
    <td colspan="5">&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>8.1.1</b> 
      Local/up-country/export (detail of exports and imports)<br>
    </td>
    <td colspan="5"><%=Helper.correctNull((String)hshValues.get("export_import"))%>&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>8.1.2</b> 
      Competitors - Main Competitors<br>
    </td>
    <td colspan="5"><%=Helper.correctNull((String)hshValues.get("competitors"))%>&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>8.1.3</b> 
      Presence of Substitutes, if any<br>
    </td>
    <td colspan="5"><%=Helper.correctNull((String)hshValues.get("presenceofsubstitutes"))%>&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>8.1.4</b> 
      Present and future demand<br>
    </td>
    <td colspan="5"><%=Helper.correctNull((String)hshValues.get("present_futuredemand"))%>&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>8.1.5</b> 
      Arrangement of publicity, if any<br>
    </td>
    <td colspan="5"><%=Helper.correctNull((String)hshValues.get("arrangementofpublicity"))%>&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>8.1.6</b> 
      Previous performance (year wise / month wise)<br>
    </td>
    <td colspan="5"><%=Helper.correctNull((String)hshValues.get("previousperformance"))%>&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>8.1.7</b> 
      Targets-Comments on achievability.<br>
    </td>
    <td colspan="5"><%=Helper.correctNull((String)hshValues.get("targets"))%>&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2"><strong>&nbsp;&nbsp;&nbsp;&nbsp;8.2 Arrangements</strong><br>
    </td>
    <td colspan="5">&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>&nbsp;8.2.1</b> 
      Agency/ Commission agent/ Salesman<br>
    </td>
    <td colspan="5"><%=Helper.correctNull((String)hshValues.get("agency_salesman"))%>&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>8.2.2</b> 
      Direct to wholesalers /retailers/consumers(order-book/file position)<br>
    </td>
    <td colspan="5"><%=Helper.correctNull((String)hshValues.get("wholesalers_retailer_consumer"))%>&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>8.2.3</b> 
      Area/Places covered; major buyers and orderbook position<br>
    </td>
    <td colspan="5"><%=Helper.correctNull((String)hshValues.get("area_places_covered"))%>&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>8.2.4</b> 
      Government orders (D.G.S. &amp; D. C.S.D. (I),Railways,etc)<br>
    </td>
    <td colspan="5"><%=Helper.correctNull((String)hshValues.get("government_orders"))%>&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2"><strong>(9) Profitability</strong> (Yearly/Monthly profitability 
      estimate showing expenses under main heads In the alternative, costing of 
      unit product)</td>
    <td colspan="5"><%=Helper.correctNull((String)hshValues.get("profitability"))%>&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="7"><strong>(10) Management</strong> (Know-how(Collect bio-data 
      information of all important persons working at the unit))<br>
      Capabilities of following in Production, marketing, Man management, financial 
      management, general management and quality control</td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;<b>10.1</b> Directors<br>
    </td>
    <td colspan="5"><%=Helper.correctNull((String)hshValues.get("directors"))%>&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;<b>10.2 </b>Partners<br>
    </td>
    <td colspan="5"><%=Helper.correctNull((String)hshValues.get("partners"))%>&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;<b>10.3</b> Important Executives<br>
    </td>
    <td colspan="5"><%=Helper.correctNull((String)hshValues.get("important_executives"))%>&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2"><strong>(11) Conclusion </strong><br>
    </td>
    <td colspan="5"><%=Helper.correctNull((String)hshValues.get("conclusion"))%>&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2" height="22">&nbsp;&nbsp;<b>&nbsp;&nbsp;11.1</b> Comments on 
      technical feasibility of the project </td>
    <td colspan="5" height="22"><%=Helper.correctNull((String)hshValues.get("technical_feasibility"))%>&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;<b>11.2</b> Comments on economic viability 
      of the project </td>
    <td colspan="5"><%=Helper.correctNull((String)hshValues.get("economic_viability"))%>&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;<b>11.3</b> General Comments<br>
    </td>
    <td colspan="5"><%=Helper.correctNull((String)hshValues.get("general_comments"))%>&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;<b>12</b> Name<br>
    </td>
    <td colspan="5"><%=Helper.correctNull((String)hshValues.get("general_name"))%>&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;<b>13</b> Designation<br>
    </td>
    <td colspan="5"><%=Helper.correctNull((String)hshValues.get("general_designation"))%>&nbsp;</td>
  </tr>
  <tr height="2%"> 
    <td colspan="2" valign="top">&nbsp;&nbsp;&nbsp;&nbsp;<b>&nbsp;&nbsp;</b> Signature<br>
    </td>
    <td colspan="5">&nbsp;</td>
  </tr>
</table>
</div>
