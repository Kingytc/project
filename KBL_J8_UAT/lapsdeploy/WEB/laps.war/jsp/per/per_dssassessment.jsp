<%@include file="../share/CKEditor.jsp"%>
<%@include file="../share/directives.jsp"%>
<%
	ArrayList arrRow = new ArrayList();
	ArrayList arrCol = new ArrayList();
	ArrayList arrBankRow=new ArrayList();
	ArrayList arrBankCol=new ArrayList();
	ArrayList arrBankPropRow=new ArrayList();
	ArrayList arrBankPropCol=new ArrayList();
	ArrayList arrBankExisEmiDataRow = new ArrayList();
	ArrayList arrBankExisEmiDataCol = new ArrayList();
	ArrayList arrBankPropEmiDataRow = new ArrayList();
	ArrayList arrBankPropEmiDataCol = new ArrayList();
	ArrayList arrOthBankRow=new ArrayList();
	ArrayList arrOthBankCol=new ArrayList();
	ArrayList arrOthBankDataRow = new ArrayList();
	ArrayList arrOthBankDataCol = new ArrayList();
	
	
	if (hshValues != null) {
		arrRow = (ArrayList) hshValues.get("arrRow");
		arrBankRow = (ArrayList) hshValues.get("arrBankRow");
		arrBankPropRow = (ArrayList) hshValues.get("arrBankPropRow");
		arrOthBankRow = (ArrayList) hshValues.get("arrOthBankRow");
	}
	int arraySize = arrRow.size();
	int arrBankExisSize=0;
	int arrOthBankExisSize=0;
	int arrBankPropSize=0;
	if(arrBankRow!=null && arrBankRow.size()>0)
	{
		arrBankExisSize=arrBankRow.size();
	}
	if(arrBankPropRow!=null && arrBankPropRow.size()>0)
	{
		arrBankPropSize=arrBankPropRow.size();
	}
	if(arrOthBankRow!=null && arrOthBankRow.size()>0)
	{
		arrOthBankExisSize=arrOthBankRow.size();
	}
	
	String StrSchemeType = request.getParameter("strschemeType");
%>
<html>
<head>
<title>DEPT SERVICING SCHEDULE</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script language="Javascript1.2"><!-- // load htmlarea
_editor_url = "<%=ApplicationParams.getAppUrl()%>";                     // URL to htmlarea files
var win_ie_ver = parseFloat(navigator.appVersion.split("MSIE")[1]);
if (navigator.userAgent.indexOf('Mac')        >= 0) { win_ie_ver = 0; }
if (navigator.userAgent.indexOf('Windows CE') >= 0) { win_ie_ver = 0; }
if (navigator.userAgent.indexOf('Opera')      >= 0) { win_ie_ver = 0; }
if (win_ie_ver >= 5.5) {
  document.write('<scr' + 'ipt src="' +_editor_url+ 'editor.js"');
  document.write(' language="Javascript1.2"></scr' + 'ipt>');  
} else { document.write('<scr'+'ipt>function editor_generate() { return false; }</scr'+'ipt>'); }
// --></script>

<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/editor.js"></script>
<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>ckeditor/ckeditor.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appstatus="<%=Helper.correctNull((String) request
							.getParameter("appstatus"))%>";
var appno="<%=request.getParameter("appno")%>";
function onLoad()
{
	disableFields(true);
	calculatecount();
}
function disableCmdButtons(bool1, bool2, bool3, bool4, bool5, bool6)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled = bool5;
	document.forms[0].cmdcomments.disabled = bool6;
}
function disableFields(val)
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			document.forms[0].elements[i].disabled=val;		  
		}
		else if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].disabled=val;		  
		}
		else if(document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].disabled=val;		
		}
	}
}
function doEdit()
{
	disableFields(false);
	var Size="<%=arraySize%>";
	var ExisSize="<%=arrBankPropRow.size()%>";
	<%for(int i=0;i<arraySize;i++)
	{%>
		var objname="document.forms[0].txt_netincome"+<%=i%>;
		eval(objname).readOnly=false;
		var objname="document.forms[0].txt_percentage_netsurplus1"+<%=i%>;
		eval(objname).readOnly=true;
		objname="document.forms[0].txt_percentage_netsurplus"+<%=i%>;
		eval(objname).readOnly=true;
		objname="document.forms[0].txt_netsurplus"+<%=i%>;
		eval(objname).readOnly=true;
		objname="document.forms[0].txt_totcommitment"+<%=i%>;
		eval(objname).readOnly=true;
		<%
		for(int b=0;b<arrBankPropRow.size();b++){
		arrBankPropCol=(ArrayList)arrBankPropRow.get(b);
		arrBankPropEmiDataRow = (ArrayList)hshValues.get("arrBankPropEmiDataRow"+i+b);
		arrBankPropEmiDataCol = (ArrayList)arrBankPropEmiDataRow.get(0);
		if((Helper.correctNull((String)arrBankPropCol.get(1)).equalsIgnoreCase("TL")) && (Helper.correctNull((String)arrBankPropCol.get(2)).equalsIgnoreCase("E"))){%>
			objname="document.forms[0].txt_proposedinstallment"+<%=i%>+"<%=b%>";
			eval(objname).readOnly=true;
		<%}else if( (Helper.correctNull((String)arrBankPropCol.get(1)).equalsIgnoreCase("TL")) && (Helper.correctNull((String)arrBankPropCol.get(2)).equalsIgnoreCase("NE"))){ %>
			objname="document.forms[0].txt_proposedinterest"+<%=i%>+"<%=b%>";
			eval(objname).readOnly=true;
			objname="document.forms[0].txt_proposedinstallment"+<%=i%>+"<%=b%>";
			<%
			String strchkval=Helper.correctNull((String)arrBankPropEmiDataCol.get(6));
			if(strchkval.equalsIgnoreCase("H")){%>
			eval(objname).disabled=true;
			<%}else{%>
			eval(objname).disabled=false;
			<%}%>
	<%}else if(Helper.correctNull((String)arrBankPropCol.get(1)).equalsIgnoreCase("OD")){ %>
			objname="document.forms[0].txt_proposedinterest"+<%=i%>+"<%=b%>";
			eval(objname).readOnly=true;
		<%	} 
		 } %>
		 <%for(int b=0;b<arrBankRow.size();b++){
				arrBankCol=(ArrayList)arrBankRow.get(b);
			%>
			<%if((Helper.correctNull((String)arrBankCol.get(2)).equalsIgnoreCase("TL")) && (Helper.correctNull((String)arrBankCol.get(1)).equalsIgnoreCase("E"))){%>
					objname="document.forms[0].txt_existinginstallment"+<%=i%>+"<%=b%>";
					eval(objname).readOnly=true;
			<%}else if((Helper.correctNull((String)arrBankCol.get(2)).equalsIgnoreCase("TL")) && (Helper.correctNull((String)arrBankCol.get(1)).equalsIgnoreCase("NE"))){%>
				objname="document.forms[0].txt_existinginterest"+<%=i%>+"<%=b%>";
				eval(objname).readOnly=true;
			<%}else if(Helper.correctNull((String)arrBankCol.get(2)).equalsIgnoreCase("OD")){%>
				objname="document.forms[0].txt_existinginterest"+<%=i%>+"<%=b%>";
				eval(objname).readOnly=true;
			<%} 
			} %>

			<%for(int b=0;b<arrOthBankRow.size();b++){
				arrOthBankCol=(ArrayList)arrOthBankRow.get(b);
			%>
			<%if((Helper.correctNull((String)arrOthBankCol.get(2)).equalsIgnoreCase("TL")) && (Helper.correctNull((String)arrOthBankCol.get(1)).equalsIgnoreCase("E"))){%>
					objname="document.forms[0].txt_Othexistinginstallment"+<%=i%>+"<%=b%>";
					eval(objname).readOnly=true;
			<%}else if((Helper.correctNull((String)arrOthBankCol.get(2)).equalsIgnoreCase("TL")) && (Helper.correctNull((String)arrOthBankCol.get(1)).equalsIgnoreCase("NE"))){%>
				objname="document.forms[0].txt_Othexistinginterest"+<%=i%>+"<%=b%>";
				eval(objname).readOnly=true;
			<%} else if((Helper.correctNull((String)arrOthBankCol.get(2)).equalsIgnoreCase("OD"))){%>
			objname="document.forms[0].txt_Othexistinginterest"+<%=i%>+"<%=b%>";
			eval(objname).readOnly=true;
			
			<%}}%>

			 
	<%}%>
	disableCmdButtons(true, false, false, false, true, false);	
}
function doSave()
{   
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidAction.value ="insert";
	document.forms[0].hidBeanId.value="comproposal";
	document.forms[0].hidBeanMethod.value="updateDSS";
	document.forms[0].hidBeanGetMethod.value="getDSS";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/per_dssassessment.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();	
}
function doCancel()
{   
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanGetMethod.value="getDSS";
		document.forms[0].hidBeanId.value="comproposal";
		document.forms[0].action=appUrl+"action/per_dssassessment.jsp";
		document.forms[0].submit(); 		
	}
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appUrl+"action/ControllerServlet";	
		document.forms[0].hidBeanId.value="comproposal";
		document.forms[0].hidSourceUrl.value="action/per_dssassessment.jsp";	
		document.forms[0].hidBeanMethod.value="updateDSS";
		document.forms[0].hidBeanGetMethod.value="getDSS";
		document.forms[0].submit();		
	}
}	
function calculatecount()
{
	var size="<%=arraySize%>";
	var avgnetsurplus=0;
	
	<%for(int i=0;i<arraySize;i++)
	{%>
	    var varextinstall=0.00;
	    var varextint=0.00;
	    var varproposedinstall=0.00;
	     var varproposedint=0.00;
	     var varOthinstall=0.00;
	     var varOthint=0.00;
		 var netincome=document.forms[0].txt_netincome<%=i%>.value;
         
        <%for(int j=0;j<arrBankExisSize;j++){
        	arrBankCol=(ArrayList)arrBankRow.get(j);
			arrBankExisEmiDataRow = (ArrayList)hshValues.get("arrBankExisEmiDataRow"+i+j);
			arrBankExisEmiDataCol = (ArrayList)arrBankExisEmiDataRow.get(0);
        %>
        <%if( (Helper.correctNull((String)arrBankExisEmiDataCol.get(2)).equalsIgnoreCase("TL")) && (Helper.correctNull((String)arrBankExisEmiDataCol.get(3)).equalsIgnoreCase("E"))){ %>
        varextinstall=NanNumber(varextinstall)+NanNumber(parseFloat(document.forms[0].txt_existinginstallment<%=i+""+j%>.value));
        <%}else if( (Helper.correctNull((String)arrBankExisEmiDataCol.get(2)).equalsIgnoreCase("TL"))   && (!(Helper.correctNull((String)arrBankExisEmiDataCol.get(3)).equalsIgnoreCase("E"))) && (!(Helper.correctNull((String)arrBankExisEmiDataCol.get(3)).equalsIgnoreCase("")))){ %>
		varextinstall=NanNumber(varextinstall)+NanNumber(parseFloat(document.forms[0].txt_existinginstallment<%=i+""+j%>.value));
		varextint=NanNumber(varextint)+NanNumber(parseFloat(document.forms[0].txt_existinginterest<%=i+""+j%>.value));
		<%} else if(Helper.correctNull((String)arrBankExisEmiDataCol.get(2)).equalsIgnoreCase("OD")){ %>
			varextint=NanNumber(varextint)+NanNumber(parseFloat(document.forms[0].txt_existinginterest<%=i+""+j%>.value));
		<%}%>
		<%}%>

		<%for(int l=0;l<arrOthBankExisSize;l++){
        	arrOthBankDataRow = (ArrayList)hshValues.get("arrOthBankExisDataRow"+i+l);
			arrOthBankDataCol = (ArrayList)arrOthBankDataRow.get(0);
        %>
        <%if( (Helper.correctNull((String)arrOthBankDataCol.get(2)).equalsIgnoreCase("TL")) && (Helper.correctNull((String)arrOthBankDataCol.get(3)).equalsIgnoreCase("E"))){ %>
        varOthinstall=NanNumber(varOthinstall)+NanNumber(parseFloat(document.forms[0].txt_Othexistinginstallment<%=i+""+l%>.value));
        <%}else if((Helper.correctNull((String)arrOthBankDataCol.get(2)).equalsIgnoreCase("TL"))  && (!(Helper.correctNull((String)arrOthBankDataCol.get(3)).equalsIgnoreCase("E"))) && (!(Helper.correctNull((String)arrOthBankDataCol.get(3)).equalsIgnoreCase("")))){ %>
		varOthinstall=NanNumber(varOthinstall)+NanNumber(parseFloat(document.forms[0].txt_Othexistinginstallment<%=i+""+l%>.value));
		varOthint=NanNumber(varOthint)+NanNumber(parseFloat(document.forms[0].txt_Othexistinginterest<%=i+""+l%>.value));
		<%}else if((Helper.correctNull((String)arrOthBankDataCol.get(2)).equalsIgnoreCase("OD"))){ %>
			varOthint=NanNumber(varOthint)+NanNumber(parseFloat(document.forms[0].txt_Othexistinginterest<%=i+""+l%>.value));
		<%}%>
		<%}%>
		
		<%for(int k=0;k<arrBankPropSize;k++)
		{
			arrBankPropEmiDataRow = (ArrayList)hshValues.get("arrBankPropEmiDataRow"+i+k);
			arrBankPropEmiDataCol = (ArrayList)arrBankPropEmiDataRow.get(0);
		%>
		<%if((Helper.correctNull((String)arrBankPropEmiDataCol.get(2)).equalsIgnoreCase("TL")) && (Helper.correctNull((String)arrBankPropEmiDataCol.get(3)).equalsIgnoreCase("E"))){ %>
			varproposedinstall=NanNumber(varproposedinstall)+NanNumber(parseFloat(document.forms[0].txt_proposedinstallment<%=i+""+k%>.value));
		<%}else if( (Helper.correctNull((String)arrBankPropEmiDataCol.get(2)).equalsIgnoreCase("TL")) && (!(Helper.correctNull((String)arrBankPropEmiDataCol.get(3)).equalsIgnoreCase("E"))) && (!(Helper.correctNull((String)arrBankPropEmiDataCol.get(3)).equalsIgnoreCase("")))){ %>
			varproposedinstall=NanNumber(varproposedinstall)+NanNumber(parseFloat(document.forms[0].txt_proposedinstallment<%=i+""+k%>.value));
			varproposedint=NanNumber(varproposedint)+NanNumber(parseFloat(document.forms[0].txt_proposedinterest<%=i+""+k%>.value));
		<%}else if(Helper.correctNull((String)arrBankPropEmiDataCol.get(2)).equalsIgnoreCase("OD")){ %>
			varproposedint=NanNumber(varproposedint)+NanNumber(parseFloat(document.forms[0].txt_proposedinterest<%=i+""+k%>.value));
		<%}%>
		<%}%>
		//Total Commitment
		document.forms[0].txt_totcommitment<%=i%>.value=roundVal(parseFloat(varextinstall)+parseFloat(varextint)+parseFloat(varproposedinstall)+parseFloat(varproposedint)+parseFloat(varOthinstall)+parseFloat(varOthint));

		var totalcommitment=NanNumber(parseFloat(document.forms[0].txt_totcommitment<%=i%>.value));
		

		//Net Surplus
		var netsurplus=NanNumber(parseFloat(netincome)-parseFloat(totalcommitment));
		document.forms[0].txt_netsurplus<%=i%>.value=roundVal(netsurplus);
		if(netsurplus=="" || eval(netsurplus)<0)
		{
			netsurplus=0;
		}
		if(eval(netincome)>0)
		{
			//% of Net Surplus	
			var percentageofnetsurplus=NanNumber((parseFloat(netsurplus)/parseFloat(netincome))*100);
			document.forms[0].txt_percentage_netsurplus<%=i%>.value=roundVal(parseFloat(percentageofnetsurplus));
		}else
		{
			var percentageofnetsurplus=NanNumber(0);
			document.forms[0].txt_percentage_netsurplus<%=i%>.value=roundVal(parseFloat(percentageofnetsurplus));	
		}
		//Average % Farm Net Surplus		
		//avgnetsurplus=roundVal(parseFloat(avgnetsurplus)+parseFloat(percentageofnetsurplus));

				
		//% of Net Surplus
		var otheramt=NanNumber(parseFloat(document.forms[0].txt_otherincome<%=i%>.value));
		var Newincome=parseFloat(netincome)+parseFloat(otheramt);
		var Newsurplus=parseFloat(netsurplus)+parseFloat(otheramt);
		if(eval(Newincome)>0)
		{
			var percentageofnetsurplus1=NanNumber((parseFloat(Newsurplus)/parseFloat(Newincome))*100);
			document.forms[0].txt_percentage_netsurplus1<%=i%>.value=roundVal(parseFloat(percentageofnetsurplus1));
		}else
		{
			var percentageofnetsurplus1=NanNumber(0);
			document.forms[0].txt_percentage_netsurplus1<%=i%>.value=roundVal(parseFloat(percentageofnetsurplus1));	
		}
		//Average % Farm Net Surplus
		avgnetsurplus=roundVal(parseFloat(avgnetsurplus)+parseFloat(percentageofnetsurplus1));
	<%}%>
}

function calculateExiInterest(BALOS,Interest,Year,Col)
{
	var objname="";
	var Interestval="",temp="";
	var dblTemp="",PreviousVal=0;
	var size="<%=arraySize%>";
	for(var i=0;i<size;i++)
	{
		if(i==0)
		{
			objname="document.forms[0].txt_existinginstallment"+i+Col;
			temp=parseFloat(eval(objname).value)
			objname="document.forms[0].hid_ExisEmiInt"+i+Col;
			Interest=parseFloat(eval(objname).value); 
			objname="document.forms[0].hid_ExisLoanAMT"+i+Col;
			BALOS=parseFloat(eval(objname).value);
			Interestval=((parseFloat(BALOS))*Interest)/100;
			if(temp>0)
			{
				objname="document.forms[0].txt_existinginterest"+i+Col;
				eval(objname).value=roundVal(Interestval);
			}else
			{
				objname="document.forms[0].txt_existinginterest"+i+Col;
				eval(objname).value="0.00";
			}
		}
		else if(i>=Year)
		{	
			objname="document.forms[0].txt_existinginstallment"+i+Col;
			temp=parseFloat(eval(objname).value)
			objname="document.forms[0].hid_ExisEmiInt"+i+Col;
			Interest=parseFloat(eval(objname).value);
			objname="document.forms[0].hid_ExisLoanAMT"+i+Col;
			BALOS=parseFloat(eval(objname).value);
			Interestval=((parseFloat(BALOS)-parseFloat(PreviousVal))*Interest)/100;
			if(temp>0)
			{
				objname="document.forms[0].txt_existinginterest"+i+Col;
				eval(objname).value=roundVal(Interestval);
			}else
			{
				objname="document.forms[0].txt_existinginterest"+i+Col;
				eval(objname).value="0.00";
			}
		}
		objname="document.forms[0].txt_existinginstallment"+i+Col;
		PreviousVal=parseFloat(PreviousVal)+parseFloat(eval(objname).value);
	}
	PreviousVal=0; 
}

function calculateOthInterest(BALOS,Interest,Year,Col)
{
	var objname="";
	var Interestval="",temp="";
	var dblTemp="",PreviousVal=0;
	var size="<%=arraySize%>";
	for(var i=0;i<size;i++)
	{
		if(i==0)
		{
			objname="document.forms[0].txt_Othexistinginstallment"+i+Col;
			temp=parseFloat(eval(objname).value)
			objname="document.forms[0].hid_OthEmiInt"+i+Col;
			Interest=parseFloat(eval(objname).value);
			objname="document.forms[0].hid_OthLoanAMT"+i+Col;
			BALOS=parseFloat(eval(objname).value);
			Interestval=((parseFloat(BALOS))*Interest)/100;
			if(temp>0)
			{
				objname="document.forms[0].txt_Othexistinginterest"+i+Col;
				if(temp<=BALOS)
				{
					eval(objname).value=roundVal(Interestval);
				}else
				{
					alert("Installment cannot be greater than Outstanding amount");
					objname="document.forms[0].txt_Othexistinginstallment"+i+Col;
					eval(objname).value="0.00";
					eval(objname).focus();
					return false;
				}
			}else
			{
				objname="document.forms[0].txt_Othexistinginterest"+i+Col;
				eval(objname).value="0.00";
			}
		}
		else if(i>=Year)
		{	
			objname="document.forms[0].txt_Othexistinginstallment"+i+Col;
			temp=parseFloat(eval(objname).value);
			objname="document.forms[0].hid_OthEmiInt"+i+Col;
			Interest=parseFloat(eval(objname).value);
			objname="document.forms[0].hid_OthLoanAMT"+i+Col;
			BALOS=parseFloat(eval(objname).value);
			Interestval=((parseFloat(BALOS)-parseFloat(PreviousVal))*Interest)/100;
			if(temp>0)
			{
				var limitchk=PreviousVal+temp
				if(limitchk<=BALOS)
				{
					objname="document.forms[0].txt_Othexistinginterest"+i+Col;
					eval(objname).value=roundVal(Interestval);
				}
				else
				{
					alert("Installment cannot be greater than Outstanding amount");
					objname="document.forms[0].txt_Othexistinginstallment"+i+Col;
					eval(objname).value="0.00";
					eval(objname).focus();
					return false;
				}
			}else
			{
				objname="document.forms[0].txt_Othexistinginterest"+i+Col;
				eval(objname).value="0.00";
			}
		}
		objname="document.forms[0].txt_Othexistinginstallment"+i+Col;
		PreviousVal=parseFloat(PreviousVal)+parseFloat(eval(objname).value);
	}
	PreviousVal=0;
}


function calculatePropInterest(BALOS,Interest,Year,Col)
{
	
	var objname="";
	var Interestval="",temp="";
	var dblTemp="",PreviousVal=0;
	var size="<%=arraySize%>";
	for(var i=0;i<size;i++)
	{
		if(i==0)
		{
			objname="document.forms[0].txt_proposedinstallment"+i+Col;
			temp=parseFloat(eval(objname).value);
			objname="document.forms[0].hid_PropEmiInt"+i+Col;
			Interest=parseFloat(eval(objname).value);
			objname="document.forms[0].hid_PropLoanAMT"+i+Col;
			BALOS=parseFloat(eval(objname).value);
			Interestval=((parseFloat(BALOS))*Interest)/100;
			if(temp>0)
			{
				objname="document.forms[0].txt_proposedinterest"+i+Col;
				if(temp<=BALOS)
				{
					eval(objname).value=roundVal(Interestval);
				}else
				{
					alert("Installment cannot be greater than Proposed amount");
					objname="document.forms[0].txt_proposedinstallment"+i+Col;
					eval(objname).value="0.00";
					eval(objname).focus();
					return false;
				}
			}
		}
		else if(i>=Year)
		{	
			objname="document.forms[0].txt_proposedinstallment"+i+Col;
			temp=parseFloat(eval(objname).value);
			objname="document.forms[0].hid_PropEmiInt"+i+Col;
			Interest=parseFloat(eval(objname).value);
			objname="document.forms[0].hid_PropLoanAMT"+i+Col;
			BALOS=parseFloat(eval(objname).value);
			Interestval=((parseFloat(BALOS)-parseFloat(PreviousVal))*Interest)/100;
			if(temp>0)
			{
				var limitchk=PreviousVal+temp
				if(limitchk<=BALOS)
				{
					objname="document.forms[0].txt_proposedinterest"+i+Col;
					eval(objname).value=roundVal(Interestval);
				}else
				{
					alert("Installment cannot be greater than Proposed amount");
					objname="document.forms[0].txt_proposedinstallment"+i+Col;
					eval(objname).value="0.00";
					eval(objname).focus();
					return false;
				}
			}else
			{
				objname="document.forms[0].txt_proposedinterest"+i+Col;
				eval(objname).value="0.00";
			}
		}
		objname="document.forms[0].txt_proposedinstallment"+i+Col;
		PreviousVal=parseFloat(PreviousVal)+parseFloat(eval(objname).value);
	}
	PreviousVal=0; 
}


function doComments()
{
	var strAppno =appno;
	var pagetype = document.forms[0].hidCommentPage.value;
	var prop = "scrollbars=yes,width=750,height=550,top=25,left=180";
	var url=appURL+"action/com_comments.jsp?hidBeanId=comproposal&hidBeanGetMethod=getDataComments&pagetype="+pagetype+"&strAppno="+strAppno;
	window.open(url,"Comments",prop);
}
</script>
</head>

<body onload="onLoad()">
 <div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems" url="">
<script language="JavaScript">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script>
</div></div>
<form name="frmbudget" method=post class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../share/Applurllinkper.jsp" flush="true">
			<jsp:param name="pageid" value="8" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
      <td class="page_flow">Home -> Retail -> Application -> DSS</td>
	</tr>
</table>
<span style="display: none"><lapschoice:borrowertype /></span> <lapschoice:application />
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td><jsp:include page="../agr/Applurllinkagr.jsp" flush="true">
			<jsp:param name="pageid" value="109" />
		</jsp:include></td>
	</tr>
</table>
<table width="98%" border="1" cellspacing="0" cellpadding="3"
	class="outertable" align="center">
	<tr>
		<td><br>
		<table border="0" cellspacing="0" cellpadding="0" class="outertable"
			align="center">
			<tr>
				<td>
				<table border="0" cellspacing="1" cellpadding="2" class="outertable" align="center">
					<tr class="dataheader">
						<td><b>Financial Year</b></td>
					</tr>
<!--					<tr class="datagrid" height="25">-->
<!--						<td><input type="text" maxlength="20" size="25" border="0"-->
<!--							style="text-align: left" value="Income From Crop"></td>-->
<!--					</tr>-->
					
					<tr class="datagrid" height="25">
						<td><input type="text" maxlength="20" size="25" border="0" name="txt_income"
							style="text-align: left" value="Net Income from Farm"></td>
					</tr>
					<tr class="datagrid" height="25">
						<td><input type="text" maxlength="30" size="52" border="0"
							style="text-align: left" value="Other Non Agriculture Income(As per IT Return)"></td>
					</tr>
					
					<%if(arrBankRow!=null && arrBankRow.size()>0){%>
						<tr class="dataheader">
						<td colspan="<%=arraySize%>"><b>Existing Loans - Our Bank</b></td>
					</tr>
						<% for(int b=0;b<arrBankRow.size();b++){
							arrBankCol=(ArrayList)arrBankRow.get(b);
						%>
						<tr class="dataheader"  nowrap="nowrap">
						<td colspan="<%=arraySize%>" nowrap="nowrap"><b><%=Helper.correctNull((String)arrBankCol.get(0))%></b></td></tr>
						<%if((Helper.correctNull((String)arrBankCol.get(2)).equalsIgnoreCase("TL")) && (Helper.correctNull((String)arrBankCol.get(1)).equalsIgnoreCase("E"))){ %>
						<tr class="datagrid" height="25">
						<td><input type="text" maxlength="20" size="25" border="0"
							style="text-align: left" value="Installments"></td>
						</tr>
						<%}else if( (Helper.correctNull((String)arrBankCol.get(2)).equalsIgnoreCase("TL")) && (!(Helper.correctNull((String)arrBankCol.get(1)).equalsIgnoreCase("E"))) && (!(Helper.correctNull((String)arrBankCol.get(1)).equalsIgnoreCase("")))){ %>

					<tr class="datagrid" height="25">
						<td><input type="text" maxlength="20" size="25" border="0"
							style="text-align: left" value="Installments"></td>
					</tr>
					
					<tr class="datagrid" height="25">
						<td><input type="text" maxlength="20" size="25" border="0"
							style="text-align: left" value="Interest"></td>
					</tr>
					<%}else if( (Helper.correctNull((String)arrBankCol.get(2)).equalsIgnoreCase("OD"))){ %>
					<tr class="datagrid" height="25">
						<td><input type="text" maxlength="20" size="25" border="0"
							style="text-align: left" value="Interest"></td>
					</tr>
					<%} %>
					<%}} %>
					
					<%if(arrOthBankRow!=null && arrOthBankRow.size()>0){%>
						<tr class="dataheader" rowspan="<%=arraySize%>">
						<td colspan="<%=arraySize%>"><b>Existing Loans - Other Bank</b></td>
					</tr>
						<% for(int b=0;b<arrOthBankRow.size();b++){
							arrOthBankCol=(ArrayList)arrOthBankRow.get(b);
						%>
						<tr class="dataheader"  nowrap="nowrap">
						<td colspan="<%=arraySize%>" nowrap="nowrap"><b><%=Helper.correctNull((String)arrOthBankCol.get(0))%></b></td></tr>
						<%if((Helper.correctNull((String)arrOthBankCol.get(2)).equalsIgnoreCase("TL")) && (Helper.correctNull((String)arrOthBankCol.get(1)).equalsIgnoreCase("E"))){ %>
						<tr class="datagrid" height="25">
						<td><input type="text" maxlength="20" size="25" border="0"
							style="text-align: left" value="Installments"></td>
						</tr>
						<%}else if( (Helper.correctNull((String)arrOthBankCol.get(2)).equalsIgnoreCase("TL")) && (!(Helper.correctNull((String)arrOthBankCol.get(1)).equalsIgnoreCase("E"))) && (!(Helper.correctNull((String)arrOthBankCol.get(1)).equalsIgnoreCase("")))){ %>

					<tr class="datagrid" height="25">
						<td><input type="text" maxlength="20" size="25" border="0"
							style="text-align: left" value="Installments"></td>
					</tr>
					
					<tr class="datagrid" height="25">
						<td><input type="text" maxlength="20" size="25" border="0"
							style="text-align: left" value="Interest"></td>
					</tr>
					<%} else if((Helper.correctNull((String)arrOthBankCol.get(2)).equalsIgnoreCase("OD"))){%>
						<tr class="datagrid" height="25">
							<td><input type="text" maxlength="20" size="25" border="0" style="text-align: left" value="Interest"></td>
						</tr>
					<%}%>
					<%}} %>
					
					

					<%if(arrBankPropRow!=null && arrBankPropRow.size()>0){%>
					<tr class="dataheader">
						<td colspan="<%=arraySize%>"><b>Proposed Loans</b></td>
					</tr>
						<%for(int b=0;b<arrBankPropRow.size();b++){
							arrBankPropCol=(ArrayList)arrBankPropRow.get(b);
						%>
						<tr class="dataheader" rowspan="<%=arraySize%>">
						<td colspan="<%=arraySize%>" nowrap="nowrap"><b><%=Helper.correctNull((String)arrBankPropCol.get(0))%></b></td></tr>
						<%if((Helper.correctNull((String)arrBankPropCol.get(1)).equalsIgnoreCase("TL")) && (Helper.correctNull((String)arrBankPropCol.get(2)).equalsIgnoreCase("E"))){%>
						<tr class="datagrid" height="25">
						<td><input type="text" maxlength="20" size="25" border="0"
							style="text-align: left" value="Installments"></td>
						</tr>
						<%}else if( (Helper.correctNull((String)arrBankPropCol.get(1)).equalsIgnoreCase("TL")) && (!(Helper.correctNull((String)arrBankPropCol.get(2)).equalsIgnoreCase("E"))) && (!(Helper.correctNull((String)arrBankPropCol.get(2)).equalsIgnoreCase("")))){ %>
					<tr class="datagrid" height="25">
						<td><input type="text" maxlength="18" size="25" border="0"
							style="text-align: left" value="Installments"></td>
					</tr>
					<tr class="datagrid" height="25">
						<td><input type="text" maxlength="20" size="25" border="0"
							style="text-align: left" value="Interest"></td>
					</tr>
					<%}else if(Helper.correctNull((String)arrBankPropCol.get(1)).equalsIgnoreCase("OD")){ %>
					<tr class="datagrid" height="25">
						<td><input type="text" maxlength="20" size="25" border="0"
							style="text-align: left" value="Interest"></td>
					</tr>
					<%} %>
					<%}} %>
				
				<tr class="datagrid" height="25">
						<td><input type="text" maxlength="20" size="25" border="0"
							style="text-align: left" value="Total Commitment"></td>
					</tr>
					
					<tr class="datagrid" height="25">
						<td><input type="text" maxlength="20" size="25" border="0"
							style="text-align: left" value="Net Surplus"></td>
					</tr>
					
					<tr class="datagrid" height="25">
						<td><input type="text" maxlength="20" size="25" border="0"
							style="text-align: left" value="% Farm Net Surplus"></td>
					</tr>
					<tr class="datagrid" height="25">
						<td><input type="text" maxlength="20" size="25" border="0"
							style="text-align: left" value="% of Net Surplus"></td>
					</tr>

				</table>
				</td>

				<%
					for (int i = 0; i < arraySize; i++) {
							arrCol = new ArrayList();
							arrCol = (ArrayList) arrRow.get(i);
				%>
				<td valign="top">
				<table border="0" cellspacing="1" cellpadding="2" class="outertable"
					align="center">
					<tr class="dataheader">
						<td align="center">&nbsp;<b>Year&nbsp; <%=i+1%><input type="hidden" name="hid_finyearsno" value="<%=Helper.correctNull((String)arrCol.get(4)) %>"/></b>&nbsp;</td></tr>
<!--					<tr class="datagrid" height="25">-->
<!--						<td align="right"><input type="text" maxlength="15"-->
<!--							tabindex="1" name="txt_incomecroploan" size="15"-->
<!--							onKeyPress="allowWholeNumber(this)" onblur="calculatecount()"-->
<!--							style="text-align: right"-->
<!--							value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(2))))%>"></td>-->
<!--					</tr>-->
<!--					<tr class="datagrid" height="25">-->
<!--						<td align="right"><input type="text" maxlength="15"-->
<!--							tabindex="1" name="txt_otherincome" size="15" onKeyPress="allowWholeNumber(this)"-->
<!--							onblur="calculatecount()"-->
<!--							style="text-align: right" value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(5))))%>"></td>-->
<!--					</tr>-->
					<tr class="datagrid" height="25">
						<td align="right"><input type="text" maxlength="15"
							tabindex="1" name="txt_netincome<%=i%>" size="15"
							onKeyPress="allowWholeNumber(this)" onblur="calculatecount()"
							style="text-align: right" value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(6))))%>"></td>
					</tr>
						<tr class="datagrid" height="25">
						<td align="right"><input type="text" maxlength="15"
							tabindex="1" name="txt_otherincome<%=i%>" size="15" onKeyPress="allowWholeNumber(this)" onblur="calculatecount()"
							style="text-align: right" value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(5))))%>"></td>
					</tr>
					
					<%
					if(arrBankRow!=null && arrBankRow.size()>0){%>
					
					<tr class="dataheader" height="25">
						<td align="right" colspan="<%=arraySize%>"></td>
					</tr>
						<% for(int b=0;b<arrBankRow.size();b++){
							arrBankCol=(ArrayList)arrBankRow.get(b);
							arrBankExisEmiDataRow = (ArrayList)hshValues.get("arrBankExisEmiDataRow"+i+b);
							arrBankExisEmiDataCol = (ArrayList)arrBankExisEmiDataRow.get(0);
						%>
						<input type="hidden" name="hid_existingLoanType<%=i+""+b%>" value="<%=Helper.correctNull((String)arrBankExisEmiDataCol.get(2))%>">
						<input type="hidden" name="hid_existingEmiType<%=i+""+b%>" value="<%=Helper.correctNull((String)arrBankExisEmiDataCol.get(3))%>">
						<%if((Helper.correctNull((String)arrBankExisEmiDataCol.get(2)).equalsIgnoreCase("TL")) && (Helper.correctNull((String)arrBankExisEmiDataCol.get(3)).equalsIgnoreCase("E"))){ %>
							<tr class="dataheader" height="25" >
						<td align="right" colspan="<%=arraySize%>"></td>
					</tr>
						<tr class="datagrid" height="25">
						<td align="right"><input type="text" maxlength="15"
							tabindex="1" name="txt_existinginstallment<%=i+""+b%>" size="15"
							onKeyPress="allowWholeNumber(this)" 
							style="text-align: right" value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrBankExisEmiDataCol.get(0))))%>"></td>
						</tr>
						<%}else if( (Helper.correctNull((String)arrBankExisEmiDataCol.get(2)).equalsIgnoreCase("TL")) && (!(Helper.correctNull((String)arrBankExisEmiDataCol.get(3)).equalsIgnoreCase("E"))) && (!(Helper.correctNull((String)arrBankExisEmiDataCol.get(3)).equalsIgnoreCase("")))){ %>
						<tr class="dataheader" height="25" >
						<td align="right" colspan="<%=arraySize%>"></td>
					</tr>
					<tr class="datagrid" height="25">
						<td align="right"><input type="text" maxlength="15"
							tabindex="1" name="txt_existinginstallment<%=i+""+b%>" size="15"
							onKeyPress="allowWholeNumber(this)" 
							onblur="calculateExiInterest('<%=arrBankExisEmiDataCol.get(4)%>','<%=arrBankExisEmiDataCol.get(5)%>','<%=i%>','<%=b%>');calculatecount();"
							style="text-align: right" value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrBankExisEmiDataCol.get(0))))%>">
							<input type="hidden" name="hid_ExisLoanAMT<%=i+""+b%>" value="<%=arrBankExisEmiDataCol.get(4)%>">
							<input type="hidden" name="hid_ExisEmiInt<%=i+""+b%>" value="<%=arrBankExisEmiDataCol.get(5)%>">
						</td>
					</tr>
					<tr class="datagrid" height="25">
						<td align="right">
						<input type="text" maxlength="15"
							tabindex="1" name="txt_existinginterest<%=i+""+b%>" size="15"
							onKeyPress="allowWholeNumber(this)" onblur="calculatecount();"
							style="text-align: right" value="<%=arrBankExisEmiDataCol.get(1)%>" readonly="readonly">
							</td>
					</tr>
						<%}else if(Helper.correctNull((String)arrBankExisEmiDataCol.get(2)).equalsIgnoreCase("OD")){ %>
							<tr class="dataheader" height="25" >
						<td align="right" colspan="<%=arraySize%>"></td>
					</tr>
						<tr class="datagrid" height="25">
						<td align="right">
						<input type="text" maxlength="15"
							tabindex="1" name="txt_existinginterest<%=i+""+b%>" size="15"
							onKeyPress="allowWholeNumber(this)" onblur=""
							style="text-align: right" value="<%=Helper.formatDoubleValue(Double.parseDouble((String)arrBankExisEmiDataCol.get(1)))%>" readonly="readonly">
							</td>
					</tr>
						<%} %>
					<%}} %>

					<%
					if(arrOthBankRow!=null && arrOthBankRow.size()>0){%>
					
					<tr class="dataheader" height="25">
						<td align="right" colspan="<%=arraySize%>"></td>
					</tr>
						<% for(int b=0;b<arrOthBankRow.size();b++){
							arrBankCol=(ArrayList)arrOthBankRow.get(b);
							arrOthBankDataRow = (ArrayList)hshValues.get("arrOthBankExisDataRow"+i+b);
							arrOthBankDataCol = (ArrayList)arrOthBankDataRow.get(0);
						%>
						<input type="hidden" name="hid_OthexistingLoanType<%=i+""+b%>" value="<%=Helper.correctNull((String)arrOthBankDataCol.get(2))%>">
						<input type="hidden" name="hid_OthexistingEmiType<%=i+""+b%>" value="<%=Helper.correctNull((String)arrOthBankDataCol.get(3))%>">
						<%if((Helper.correctNull((String)arrOthBankDataCol.get(2)).equalsIgnoreCase("TL")) && (Helper.correctNull((String)arrOthBankDataCol.get(3)).equalsIgnoreCase("E"))){ %>
							<tr class="dataheader" height="25" >
						<td align="right" colspan="<%=arraySize%>"></td>
					</tr>
						<tr class="datagrid" height="25">
						<td align="right"><input type="text" maxlength="15"
							tabindex="1" name="txt_Othexistinginstallment<%=i+""+b%>" size="15"
							onKeyPress="allowWholeNumber(this)" 
							style="text-align: right" value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrOthBankDataCol.get(0))))%>"></td>
						</tr>
						<%}else if( (Helper.correctNull((String)arrOthBankDataCol.get(2)).equalsIgnoreCase("TL")) && (!(Helper.correctNull((String)arrOthBankDataCol.get(3)).equalsIgnoreCase("E"))) && (!(Helper.correctNull((String)arrOthBankDataCol.get(3)).equalsIgnoreCase("")))){ %>
						<tr class="dataheader" height="25" >
						<td align="right" colspan="<%=arraySize%>"></td>
					</tr>
					<tr class="datagrid" height="25">
						<td align="right"><input type="text" maxlength="15"
							tabindex="1" name="txt_Othexistinginstallment<%=i+""+b%>" size="15"
							onKeyPress="allowWholeNumber(this)" 
							onblur="calculateOthInterest('<%=arrOthBankDataCol.get(4)%>','<%=arrOthBankDataCol.get(5)%>','<%=i%>','<%=b%>');calculatecount();"
							style="text-align: right" value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrOthBankDataCol.get(0))))%>">
							<input type="hidden" name="hid_OthLoanAMT<%=i+""+b%>" value="<%=arrOthBankDataCol.get(4)%>">
							<input type="hidden" name="hid_OthEmiInt<%=i+""+b%>" value="<%=arrOthBankDataCol.get(5)%>">
							</td>
					</tr>
					<tr class="datagrid" height="25">
						<td align="right">
						<input type="text" maxlength="15"
							tabindex="1" name="txt_Othexistinginterest<%=i+""+b%>" size="15"
							onKeyPress="allowWholeNumber(this)" onblur="calculatecount();"
							style="text-align: right" value="<%=arrOthBankDataCol.get(1)%>" readonly="readonly">
							</td>
					</tr>
						<%} else if((Helper.correctNull((String)arrOthBankDataCol.get(2)).equalsIgnoreCase("OD"))){ %>
						<tr class="dataheader" height="25" >
						<td align="right"></td>
					</tr>
						<tr class="datagrid" height="25">
						<td align="right">
						<input type="text" maxlength="15"
							tabindex="1" name="txt_Othexistinginterest<%=i+""+b%>" size="15"
							onKeyPress="allowWholeNumber(this)" onblur="calculatecount();"
							style="text-align: right" value="<%=arrOthBankDataCol.get(1)%>" readonly="readonly">
							</td>
					</tr>
						<%} %>
					<%}} %>
					
					
					<%
					if(arrBankPropRow!=null && arrBankPropRow.size()>0){%>
					<tr class="dataheader" height="25" >
						<td align="right" colspan="<%=arraySize%>"></td>
					</tr>
						<% for(int b=0;b<arrBankPropRow.size();b++){
							arrBankPropEmiDataRow = (ArrayList)hshValues.get("arrBankPropEmiDataRow"+i+b);
							arrBankPropEmiDataCol = (ArrayList)arrBankPropEmiDataRow.get(0);
							%>
							<tr class="dataheader" height="25" clospan="<%=arraySize%>">
						<td align="right"></td>
					</tr>
					<input type="hidden" name="hid_PropLoanType<%=i+""+b%>" value="<%=Helper.correctNull((String)arrBankPropEmiDataCol.get(2))%>">
						<input type="hidden" name="hid_PropEmiType<%=i+""+b%>" value="<%=Helper.correctNull((String)arrBankPropEmiDataCol.get(3))%>">
					<%if( (Helper.correctNull((String)arrBankPropEmiDataCol.get(2)).equalsIgnoreCase("TL")) && (Helper.correctNull((String)arrBankPropEmiDataCol.get(3)).equalsIgnoreCase("E"))){ %>
					<tr class="datagrid" height="25">
						<td align="right"><input type="text" maxlength="15"
							tabindex="1" name="txt_proposedinstallment<%=i+""+b%>" size="15"
							onKeyPress="allowWholeNumber(this)" onblur="calculatecount()"
							style="text-align: right" value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrBankPropEmiDataCol.get(0))))%>"></td>
					</tr>
					<%}else if( (Helper.correctNull((String)arrBankPropEmiDataCol.get(2)).equalsIgnoreCase("TL"))  && (!(Helper.correctNull((String)arrBankPropEmiDataCol.get(3)).equalsIgnoreCase("E"))) && (!(Helper.correctNull((String)arrBankPropEmiDataCol.get(3)).equalsIgnoreCase("")))){ %>
					<tr class="datagrid" height="25">
						<td align="right"><input type="text" maxlength="15"
							tabindex="1" name="txt_proposedinstallment<%=i+""+b%>" size="15"
							onKeyPress="allowWholeNumber(this)"
							onblur="calculatePropInterest('<%=arrBankPropEmiDataCol.get(4)%>','<%=arrBankPropEmiDataCol.get(5)%>','<%=i%>','<%=b%>');calculatecount();"
							style="text-align: right" value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrBankPropEmiDataCol.get(0))))%>">
								<input type="hidden" name="hid_PropLoanAMT<%=i+""+b%>" value="<%=arrBankPropEmiDataCol.get(4)%>">
								<input type="hidden" name="hid_PropEmiInt<%=i+""+b%>" value="<%=arrBankPropEmiDataCol.get(5)%>">
								<input type="hidden" name="hid_PropHolidaytype<%=i+""+b%>" value="<%=arrBankPropEmiDataCol.get(6)%>">
							</td>
					</tr>
					<tr class="datagrid" height="25">
						<td align="right"><input type="text" maxlength="15"
							tabindex="1" name="txt_proposedinterest<%=i+""+b%>" size="15"
							onKeyPress="allowWholeNumber(this)" onblur="calculatecount();"
							style="text-align: right" value="<%=arrBankPropEmiDataCol.get(1)%>"></td>
						
					</tr>
					
					<%}else if(Helper.correctNull((String)arrBankPropEmiDataCol.get(2)).equalsIgnoreCase("OD")){ %>
					<tr class="datagrid" height="25">
						<td align="right"><input type="text" maxlength="15"
							tabindex="1" name="txt_proposedinterest<%=i+""+b%>" size="15"
							onKeyPress="allowWholeNumber(this)" onblur=""
							style="text-align: right" value="<%=Helper.correctDouble((String)arrBankPropEmiDataCol.get(1))%>"></td>
					</tr>
					<%} %>
					<%}} %>
	
					<tr class="datagrid" height="25">
						<td align="right"><input type="text" maxlength="15"
							tabindex="1" name="txt_totcommitment<%=i%>" size="15"
							onKeyPress="allowWholeNumber(this)"
							style="text-align: right" readonly="readonly"></td>
					</tr>
					
					<tr class="datagrid" height="25">
						<td align="right"><input type="text" maxlength="15"
							tabindex="1" name="txt_netsurplus<%=i%>" size="15"
							onKeyPress="allowWholeNumber(this)"
							style="text-align: right" readonly="readonly"></td>
					</tr>
					
					
					<tr class="datagrid" height="25">
						<td align="right"><input type="text" maxlength="15"
							tabindex="1" name="txt_percentage_netsurplus<%=i%>" size="15"
							onKeyPress="allowWholeNumber(this)"
							style="text-align: right" readonly="readonly"></td>
					</tr>
					<tr class="datagrid" height="25">
						<td align="right"><input type="text" maxlength="15"
							tabindex="1" name="txt_percentage_netsurplus1<%=i%>" size="15"
							onKeyPress="allowWholeNumber(this)"
							style="text-align: right" readonly="readonly"></td>
					</tr>

				</table>
				</td>
				<%
					}
				%>
			</tr>		

			
		</table>
		<br>
		</td>
	</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Comments_Delete" btnenable="Y" />
<lapschoice:hiddentag pageid="<%=PageId%>"/>
<input type="hidden" name="yearfrom" value="1"><!--    <input
	type="hidden" name="cattype" value="<%=strCategoryType%>"> --><input
	type="hidden" name="pagefrom"> <INPUT TYPE="hidden"
	name="strAssessment" value="<%=request.getParameter("strAssessment")%>">
<INPUT TYPE="hidden" name="strschemeType" value="<%=StrSchemeType%>">
<input type="hidden" name="hidBankExisLoanSize" value="<%=arrBankExisSize%>">
<input type="hidden" name="hidBankProposedLoanSize" value="<%=arrBankPropSize%>">
<input type="hidden" name="hidOthBankLoanSize" value="<%=arrOthBankExisSize%>">
<input type="hidden" name="hidBankLoanSize" value="<%=arraySize%>">
   <input type="hidden" name="hidCommentPage" value="assdss">
</form>
</body>
</html>