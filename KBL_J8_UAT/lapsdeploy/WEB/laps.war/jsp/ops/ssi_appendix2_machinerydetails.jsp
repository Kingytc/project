<%@include file="../share/directives.jsp"%>
<% 
ArrayList vecRow = new ArrayList();
ArrayList vecCol = new ArrayList();
String strgenid="";

String strcat="";
if(!strCategoryType.equalsIgnoreCase(""))
{
	if(strCategoryType.equalsIgnoreCase("OPS"))
	{
		strcat="Tertiary";
	}
	else 
	{
		strcat="Corporate";
	}		
}%>
<html>
<head>
<title>Raw Materials / Input</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="javascript"src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var genid = "<%=strgenid%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";

function callCalender(fname)
 {
 if(document.forms[0].cmdsave.disabled==false)
	{
	 showCal("<%=ApplicationParams.getAppUrl()%>",fname);
 }
}
function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=val;
		}
	}	
}

function disableCommandButtons(bcmdNew,bcmdEdit,bcmdApply,bcmdCancel,bcmddel,bcmdClose)
{		
	 document.forms[0].cmdnew.disabled =bcmdNew;
	 document.forms[0].cmdedit.disabled=bcmdEdit;
	 document.forms[0].cmddelete.disabled=bcmdApply;
	 document.forms[0].cmdsave.disabled=bcmdCancel;
	 document.forms[0].cmdcancel.disabled=bcmddel;		 
	 document.forms[0].cmdclose.disabled=bcmdClose;
}
function calltotalcost()
{
var invoiceprice=document.forms[0].txt_invoiceprice.value;
var estimatedexp=document.forms[0].txt_estimatedexp.value;
	
if(invoiceprice=="")
{
invoiceprice=0.00;
}

if(estimatedexp=="")
{
estimatedexp=0.00;
}
var total=eval(invoiceprice) + eval(estimatedexp);
if(total=="" || total=="undefined")
{
total="0";
}
document.forms[0].txt_totalcost.value=eval(total);
}

function onloading()
{	
	disableFields(true);
	document.forms[0].hidTabName.value="AnnexureIIMachineryDetails";
	document.forms[0].hidMethod.value="getAnnexure2MachineryDetails";
}

function doEdit()
{
	disableFields(false);
	document.forms[0].hidAction.value ="update";
	document.forms[0].hideditflag.vlaue="Y";
	disableCommandButtons(true,true,true,false,false,true);
	document.forms[0].txt_totalcost.readOnly=true;
}

function selectValues(val1,val2,val3,val4,val5,val6,val7,val8,val9,val10,val11,val12)
{
	document.forms[0].hid_strsno.value=val1;
	document.forms[0].sel_machinerylist.value=val2;
	document.forms[0].sel_machinerytype.value=val3;
	document.forms[0].txt_machineryname.value=val4;
	document.forms[0].sel_machinerycat.value=val5;
	document.forms[0].txt_manufacturername.value=val6;
	document.forms[0].txt_aquisationdate.value=val7;
	document.forms[0].txt_expecteddate.value=val8;
	document.forms[0].txt_invoiceprice.value=val9;
	document.forms[0].txt_estimatedexp.value=val10;
	document.forms[0].txt_totalcost.value=val11;
	document.forms[0].txt_electricreq.value=val12;
	if(document.forms[0].btnenable.value.toUpperCase()=="Y")
	{
		disableCommandButtons(true,false,false,true,false,false);
	}
}
function doNew()
{
	disableFields(false);
	disableCommandButtons(true,true,true,false,false,true);
	document.forms[0].hideditflag.vlaue="Y";
	document.forms[0].hidAction.value ="insert";
   document.forms[0].txt_totalcost.readOnly=true;
}
function doSave()
{	
	
		if(document.forms[0].sel_machinerylist.value=="0")
		{
			ShowAlert('121',"Machinery List");
			return;
		}
		else
		{
		   calltotalcost();
			document.forms[0].hidSourceUrl.value="/action/ssi_appendix2_machinerydetails.jsp";
			document.forms[0].hidBeanId.value="comssiaboveten";
			document.forms[0].hidBeanMethod.value="updateAnnexure2MachineryData";
			document.forms[0].hidBeanGetMethod.value="getAnnexure2MachineryDetails";
			document.forms[0].action=appUrl+"controllerservlet";
			document.forms[0].submit();
	}
}

function doDelete()
{
	document.forms[0].hidAction.value="delete";
	if(!ConfirmMsg("101"))
    {
		return false;
	}
	
	document.forms[0].sel_machinerylist.disabled=false;
	document.forms[0].sel_machinerytype.disabled=false;
	document.forms[0].sel_machinerycat.disabled=false;
	document.forms[0].hidBeanId.value="comssiaboveten";
	document.forms[0].hidBeanMethod.value="updateAnnexure2MachineryData";
	document.forms[0].hidBeanGetMethod.value="getAnnexure2MachineryDetails";
	document.forms[0].hidSourceUrl.value="/action/ssi_appendix2_machinerydetails.jsp";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
}

function doCancel()
{	
	if(ConfirmMsg('102'))
	{
		document.forms[0].hidSourceUrl.value="/action/ssi_appendix2_machinerydetails.jsp";
		document.forms[0].hidMethod.value="getAnnexure2MachineryDetails";
		document.forms[0].hidBeanGetMethod.value="getAnnexure2MachineryDetails";
		document.forms[0].hidBeanId.value="comssiaboveten";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].submit();
	}
}
function doClose()
{
	if(ConfirmMsg(100))
	{ 
		document.forms[0].action=appUrl+"action/agrpage.jsp";
		document.forms[0].submit();
	}
}
function callOtherDetails()
{
		document.forms[0].hidBeanGetMethod.value="getotherdetailsData1";
		document.forms[0].hidBeanId.value="comssiaboveten";
		document.forms[0].action=appUrl+"action/ssi_appendix2_otherdetails.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
}

function callVehicleDetails()
{
	document.forms[0].hidBeanGetMethod.value="getAllVehicleDetails";
	document.forms[0].hidBeanId.value="comssiaboveten";
	document.forms[0].action=appUrl+"action/ops_vehicledetails.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
}

function callValuationEntry()
{
	document.forms[0].hidBeanGetMethod.value="getValuerEntryData";
	document.forms[0].hidBeanId.value="perpropertydetails";
	document.forms[0].action=appUrl+"action/ops_valuationentry.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onloading()">
<form method="post" name="fltintrate" class="normal">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <td> 
        <jsp:include page="../share/applurllinkscom.jsp" flush="true"> 
        <jsp:param name="pageid" value="12" />
        <jsp:param name="cattype" value="<%=strCategoryType%>" />
        <jsp:param name="ssitype" value="<%=strSSIType%>" />
        </jsp:include>
      </td>
    </tr>
    <tr> 
      <td class="page_flow">Home -&gt; <%=strcat %> -&gt; Application -&gt; Proposed / Offered Asset -&gt; Equipment Details</td>
    </tr>
  </table>  
  <span style="display:none"><lapschoice:borrowertype /></span> <lapschoice:application/> 
 <lapschoice:ssiassestdetails tabid="4"/> 
 <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
    <tr> 
      <td valign="top"> <br>
  <table width="100%" border="1" cellspacing="0" cellpadding="5" class="outertable">
    <tr> 
      <td valign="top"> 
        <table width="94%" border="0" cellspacing="1" cellpadding="3" class="outertable" align="center">
          <tr> 
            <td colspan="2">Equipment List</td>
            <td width="19%"> 
              <select name="sel_machinerylist">
                <option value="0" SELECTED="selected">---- Select ----</option>
                <option value="1">Existing</option>
                <option value="2">Proposed</option>
              </select>
            </td>
            <td colspan="2"> Equipment Type</td>
            <td width="18%"> 
              <select name="sel_machinerytype">
                <option value="0" SELECTED="selected">---- Select ----</option>
                <option value="1">Indigenous</option>
                <option value="2">Imported</option>
              </select>
            </td>
          </tr>
          <tr> 
            <td colspan="2">Name of equipment 
              and specification</td>
            <td width="19%"> 
              <input type="text" name="txt_machineryname" size="20" style="text-align:left"
				maxlength="15"  onKeyPress=""
				value="">
            </td>
            <td colspan="2">Equipment Category</td>
            <td width="18%"> 
              <select name="sel_machinerycat">
                <option value="0" SELECTED="selected">---- Select ----</option>
                <option value="N">New</option>
                <option value="S">Second Hand</option>
              </select>
            </td>
          </tr>
          <tr> 
            <td colspan="2">Name of Manufacturer 
              / Fabricator (Place &amp; country of origin,if imported)</td>
            <td width="19%"> 
              <input type="text" name="txt_manufacturername" size="20" style="text-align:left"
				maxlength="15"   onKeyPress=""
				value="">
            </td>
            <td colspan="2"> Date of aquisation/ 
              Date of placement of order (actual/expected)</td>
            <td width="18%"> 
              <input type="text" name="txt_aquisationdate" size="11" value=""  onBlur="checkDate(this)" maxlength="12" >
              <A ALT="Select date from calender"  HREF="javascript:callCalender('txt_aquisationdate')"><IMG src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" BORDER="0"></A> 
            </td>
          </tr>
          <tr> 
            <td colspan="2" > 
              <p>Expected Date of delivery 
              </p>
            </td>
            <td width="19%" > 
              <input type="text" name="txt_expecteddate" size="11" value=""  onBlur="checkDate(this),checkmindate(this,document.forms[0].txt_aquisationdate.value)" maxlength="12" >
              <A ALT="Select date from calender"  HREF="javascript:callCalender('txt_expecteddate')"><IMG src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" BORDER="0"></A></td>
            <td width="21%" >Invoice price 
              incl. Taxes for indigenous equipment/CIF for imported equipment</td>
            <td width="8%" align="right"><%=ApplicationParams.getCurrency()%></td>
            <td width="18%" ><lapschoice:CurrencyTag name="txt_invoiceprice" 
				maxlength="15" tabindex="5" size="20"/></td>
          </tr>
          <tr> 
            <td width="25%">Estimated expenses 
              o/a of insurance, freight,installation, import duty </td>
            <td width="9%" align="right"><%=ApplicationParams.getCurrency()%></td>
            <td width="19%"><lapschoice:CurrencyTag name="txt_estimatedexp" 
				maxlength="15" /></td>
            <td width="21%">Total Cost 
            </td>
            <td width="8%" align="right"><%=ApplicationParams.getCurrency()%></td>
            <td width="18%"><lapschoice:CurrencyTag name="txt_totalcost" 
				maxlength="15" tabindex="5" 
				 /></td>
          </tr>
          <tr> 
            <td width="25%">Electric power 
              requirement</td>
            <td width="9%" align="right">Watt</td>
            <td width="19%"> 
              <input type="text" name="txt_electricreq" size="20" style="text-align:left"
				maxlength="10"   onKeyPress="allowInteger()" value="">
            </td>
            <td width="21%">&nbsp;</td>
            <td width="8%" align="right">&nbsp;</td>
            <td width="18%">&nbsp;</td>
          </tr>
        </table>
        </td>
        </tr>
        </table>
        </td>
        </tr>
        </table>
        <br>
   <lapschoice:combuttonnew btnnames='New_Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
       <br>        
          <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
            <tr class="dataheader"> 
              <td valign="top">
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable linebor">
                    <tr> 
                      <td width="3%" >&nbsp;</td>
                      <td  align="center" width="12%">Equipment List </td>
                      <td  align="center" width="20%">Name of equipment and specification</td>
                      <td  align="left" width="10%">Equipment Type</td>
                      <td width="10%"  align="center">Date of aquisation/ Date of placement of order (actual/expected)</td>
                      <td width="15%"  align="center">Expected Date of delivery</td>
                      <td width="10%"  align="center">Invoice price incl. Taxes for indigenous equipment/CIF for imported equipment</td>
                      <td width="10%"  align="center">Estimated expenses o/a of insurance, freight,installation, import duty </td>
                      <td width="10%"  align="center">Total Cost</td>
                    </tr>
                    <%
                  vecRow=(ArrayList)hshValues.get("vecRow");
					if(vecRow != null && vecRow.size()>0)
					{
						for(int i=0;i<vecRow.size();i++)
						{
						vecCol = (ArrayList)vecRow.get(i);
					%>
                    <tr class="datagrid"> 
                      <td width="3%" align="center"> 
                        <input type="radio" style="border:none" name="radiobutton" value="radiobutton" 
                      onClick="selectValues('<%=Helper.correctNull((String)vecCol.get(0))%>',
						'<%=Helper.correctNull((String)vecCol.get(1))%>','<%=Helper.correctNull((String)vecCol.get(2))%>',
						'<%=Helper.correctNull((String)vecCol.get(3))%>','<%=Helper.correctNull((String)vecCol.get(4))%>',
						'<%=Helper.correctNull((String)vecCol.get(5))%>','<%=Helper.correctNull((String)vecCol.get(6))%>',
						'<%=Helper.correctNull((String)vecCol.get(7))%>','<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol.get(8))))%>',
						'<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol.get(9))))%>','<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol.get(10))))%>',
						'<%=Helper.correctNull((String)vecCol.get(11))%>')">
                        </td>
                      <%
                      String strmachinelist=Helper.correctNull((String)vecCol.get(1));
                      if(strmachinelist.equalsIgnoreCase("1"))
                      {
                    	  strmachinelist="Existing";
                      }
                      else if(strmachinelist.equalsIgnoreCase("2"))
                      {
                    	  strmachinelist="Proposed";
                      }
                      String strmachinetype=Helper.correctNull((String)vecCol.get(2));
                      if(strmachinetype.equalsIgnoreCase("1"))
                      {
                    	  strmachinetype="Indigenious";
                      }
                      else if(strmachinetype.equalsIgnoreCase("2"))
                      {
                    	  strmachinetype="Imported";
                      }
                      %>
                      <td width="12%" >&nbsp;<%=strmachinelist%></td>
                      <td width="20%" >&nbsp;<%=Helper.correctNull((String)vecCol.get(3))%></td>
                      <td width="10%" align="left">&nbsp;<%=strmachinetype%></td>
                      <td width="10%" align="left">&nbsp;<%=Helper.correctNull((String)vecCol.get(6))%></td>
                      <td width="15%" align="left">&nbsp;&nbsp;<%=Helper.correctNull((String)vecCol.get(7))%></td>
                      <td width="10%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol.get(8))))%></td>
                      <td width="10%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol.get(9))))%></td>
                      <td width="10%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol.get(10))))%></td>
                    </tr>
                    <%}}else{%>
                    <tr class="datagrid"> 
                      <td align="center" colspan="10">No Data Found</td>
                    </tr>
                    <%}%>
                  </table>
              </td>
            </tr>
          </table>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
  <input type="hidden" name="hid_strsno" value=""/>
  <input type="hidden" name="otherGenTable" value="">
</form>
</body>
</html>
