<%@include file="../share/directives.jsp"%>

<%
String appCheck=Helper.correctNull((String) request.getParameter("check"));
%>
<html>
<head>
<title>Defaulter List</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
	<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var check = "<%=appCheck%>";


	function onAdd()
	{
		var bool ="false";
	
		if(document.forms[0].sortfrom.selectedIndex < 0)
		{
		alert("Select the search criteria");
		return false;
		}

		var value1=document.forms[0].sortfrom[document.forms[0].sortfrom.selectedIndex].value;
		
		
		var len=document.forms[0].elements.length;
		for(var i=0;i<len;i++)
		{
		  var name=document.forms[0].elements[i].name;
		
		  if(name==value1)
		  {
		     if(document.forms[0].elements[i].value=="")
		       {
		      alert("Enter "+document.forms[0].sortfrom[document.forms[0].sortfrom.selectedIndex].text+" value");
		      document.forms[0].elements[i].focus();
		        }else
		    {
		      	if(document.forms[0].sortfrom.selectedIndex!=-1)
		        {
			var temp=document.forms[0].sortby;
			var value1=document.forms[0].sortfrom[document.forms[0].sortfrom.selectedIndex].value;
			var text1=document.forms[0].sortfrom[document.forms[0].sortfrom.selectedIndex].text;		
			i=temp.options.length;
			for(i=0;i<temp.options.length;i++)
			   {
				if(document.forms[0].sortby[i].value ==value1)
				   {
					alert("Criteria Already Exists");
					bool = "true";
					break;
				   }
				
			    }
			if(bool=="false")
			  {
				temp.options[i]=new Option(text1,value1);	
			  }			
			document.forms[0].sortfrom.selectedIndex=-1;
		  }
	
		}
		      
     } 
  }
}

function onRemove()
{
	var j = document.forms[0].sortby.selectedIndex;
	var temp=document.forms[0].sortby;
	var value1;
	var text1;
	var tempvalue1="";
	var temptext1="";
 
	if(document.forms[0].sortby.selectedIndex!=-1)
	{
		for(i=0;i<temp.options.length;i++)
		{
			if(eval(i)!=eval(j))
			{
				value1=document.forms[0].sortby[i].value;
				text1=document.forms[0].sortby[i].text;
				tempvalue1 = tempvalue1+value1+"~";
				temptext1 = temptext1+text1+"~";
			}
		}

		var strvalue = tempvalue1.split("~");
		var strtext = temptext1.split("~");
		temp.options.length =0;
		
		for(i=0;i<strvalue.length-1;i++)
		{
			temp.options[i]=new Option(strtext[i],strvalue[i]);	
		}
	}
	else
	{
		alert("Select a record to remove");
	}
	document.forms[0].sortby.selectedIndex=-1;

}

function onAddAll()
{
	var list1 =document.forms[0].sortfrom;
	var list2 =document.forms[0].sortby;

	document.forms[0].sortby.options.length =0;

	for(i=0;i<list1.options.length;i++)
	{
			value1=document.forms[0].sortfrom[i].value;
			text1 =document.forms[0].sortfrom[i].text;		
			list2.options[i]=new Option(text1,value1);	
	}
}
function onClear()
{
	document.forms[0].sortby.options.length =0;
}

function onSearch()
{
    var temp=document.forms[0].sortby;
    
    if(temp.options.length==0){
       alert("Enter any one of the field");
       return false;
    }  
    
    var bankname=document.forms[0].BKNM.value;
  
	var temp=document.forms[0].sortby;
	var tempvalue1="";

	if(eval(document.forms[0].sortby.options.length)==0)
	{
		value1=document.forms[0].sortfrom[0].value;
		tempvalue1 = tempvalue1+value1+"~";			
	}
	else
	{
		for(i=0;i<temp.options.length;i++)
		{
			value1=document.forms[0].sortby[i].value;
			tempvalue1 = tempvalue1+value1+"~";			
		}
	}
		document.forms[0].hidsearch.value = tempvalue1;		
		document.forms[0].hidBeanId.value="comrbidefaulter";
		document.forms[0].hidBeanGetMethod.value="getSearchData";
		document.forms[0].action = appUrl+"action/comrbidefsearchresult.jsp";
		document.forms[0].submit();

}


function UpLoad()
{
	document.forms[0].action=appUrl+"action/"+"rbiupload.jsp";
	document.forms[0].submit();
}


function onClose()
{
   	if(ConfirmMsg(100))
	{
		if(check=="applevel")
		{
			window.close();
		}	
		else
		{
			document.forms[0].action=appUrl+"action/"+"mainnav.jsp";
			document.forms[0].submit();
		}	
	}
}

//Help function added by vino
function dohlp()     
{
  var hlpvar = appUrl+"phlp/defaulterslist.htm";
  var title = "DefaultersList";
  var prop = "scrollbars=yes,width=600,height=450";	
  prop = prop + ",left=50,top=150";
  window.open(hlpvar,title,prop);
}


function callCibil()
{
	var win=window.open("http://www.cibil.com");
}

function callECGC()
{
	var win=window.open("https://www.ecgc.in/portal");
}
</script>


</head>

<body>
<form class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; RBI Defaulters List Search</td>
	</tr>
</table>
<br>
<table width="98%" border="0" cellspacing="0" cellpadding="5"
	align="center" class="shadow" class="outertable">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="3"
					 align="center" class="outertable border1 tableBg">
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="1" cellpadding="3"
							align="center" class="outertable">
							<tr>
								
								<td width="19%">&nbsp;</td>
								<td width="31%">&nbsp;</td>
							</tr>
							<tr>
								<td width="19%">Bank Name</td>
								<td width="31%"><input type="text" name="BKNM" size="25"
									onKeyPress="notAllowSplChar()"></td>
								<td width="19%">Branch Name</td>
								<td width="31%"><input type="text" name="BKBR" size="25"
									onKeyPress="notAllowSplChar()"></td>
							</tr>
							<tr>
								<td width="19%">State</td>
								<td width="31%"><input type="text" name="STATE" size="25"
									onKeyPress="notAllowSplChar()"></td>
								<td width="19%">SRNO</td>
								<td width="31%"><INPUT TYPE="text" NAME="SRNO" SIZE="25"
									ONKEYPRESS="notAllowSplChar()"></td>
							</tr>
							<tr>
								<td width="19%">Party Name</td>
								<td width="31%"><INPUT TYPE="text" NAME="PRTY" SIZE="25"
									ONKEYPRESS="notAllowSplChar()"></td>
								<td width="19%">Registered Address</td>
								<td width="31%"><INPUT TYPE="text" NAME="REGADDR" SIZE="25"
									ONKEYPRESS="notAllowSplChar()"></td>
							</tr>
							<tr>
								<TD WIDTH="19%">Outstanding Amount &nbsp; &nbsp; &nbsp; <%=ApplicationParams.getCurrency()%></TD>
								<TD WIDTH="31%"><INPUT TYPE="text" name="OSAMT"
									maxlength="12"
									value='<%=Helper.correctNull((String)hshValues.get("OSAMT"))%>'
									tabindex="4" size="20" style="text-align:right" onKeyPress="allowNumber(OSAMT)" /></TD>
								<td width="19%">Suit Filed</td>
								<td width="31%"><SELECT NAME="SUIT">
									<OPTION VALUE="" selected="selected">&lt;-- Select --&gt;</OPTION>
									<OPTION VALUE="SUIT">Yes</OPTION>
									<OPTION VALUE="NO">No</OPTION>
								</SELECT></td>
							</tr>
							 <tr>
								<TD WIDTH="19%">Other Bank</TD>
								<TD WIDTH="31%"><INPUT TYPE="text" NAME="OTHER_BK" SIZE="25"
									ONKEYPRESS="notAllowSplChar()"></TD> 
								<TD WIDTH="19%">Director Name</TD>
								<TD WIDTH="31%"><INPUT TYPE="text" NAME="DIR" SIZE="25"
									ONKEYPRESS="notAllowSplChar()"></TD>
							</tr>
							
							<tr>
							<td width="19%">&nbsp;</td>
							<td width="31%">&nbsp;</td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="1"
					 align="center" class="outertable border1 tableBg">
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="1" cellpadding="3"
							align="center" class="outertable">
							<tr class="dataheadcolor">
								<td colspan="3">Sort By</td>
							</tr>
							<tr align="center">
								<td width="40%" ROWSPAN="4"><select name="sortfrom" size="10"
									style="width:300">
									<option value="BKNM">Bank Name</option>
									<option value="BKBR">Branch Name</option>
									<option value="STATE">State</option>
									<option value="PRTY">Party Name</option>
									<option value="REGADDR">Registered Address</option>
									<option value="OSAMT">Outstanding Amount</option>
									<option value="SUIT">Suit Filed</option>
									<option value="DIR">Director's Name</option>
									
									
								</select></td>
								<td width="26%"><INPUT TYPE="button" NAME="cmdsearch2"
									VALUE="Add" ONCLICK="onAdd()" CLASS="buttonStyle" ></td>
								<td width="40%" ROWSPAN="4"><select name="sortby" size="10"
									style="width:300">
								</select></td>
							</tr>
							<tr align="center">
								<td width="26%"><INPUT TYPE="button" NAME="cmdsearch3"
									VALUE="Remove" ONCLICK="onRemove()" CLASS="buttonStyle" 
								></td>
							</tr>
							<tr align="center">
								<td width="26%"><INPUT TYPE="button" NAME="cmdsearch32"
									VALUE="Add All" ONCLICK="onAddAll()" CLASS="buttonStyle"
								></td>
							</tr>
							<tr align="center">
								<td width="26%"><INPUT TYPE="button" NAME="cmdsearch33"
									VALUE="Remove All" ONCLICK="onClear()" CLASS="buttonStyle">
								</td>
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
<table width="50%" border="0" cellspacing="0" cellpadding="0"
	 align="center" class="outertable">
	<tr>
		<td>
		<table width="88%" border="0" cellspacing="0" cellpadding="1" class="outertable">
          <tr>
            <td width="22%" align="center">
			&nbsp;
			<a href="javascript:callCibil()"><strong>CIBIL</strong></a>
			
			</td>
			<td width="22%" align="center">
			&nbsp;
			<a href="javascript:callECGC()"><strong>ECGC</strong></a>
			
			</td>
            <td width="14%"> 
              <input type="button" name="cmdsearch" value="Search List"
					onClick="onSearch()" class="buttonStyle" 
					>
            </td>
           
            <td width="23%"> 
              <input type="button" name="cmdclose" value="Close"
					onClick="onClose()" class="buttonClose" style="background-color:#CC3300;color:white;font-size=10;font-family:mssansserif;font-weight:bold">
            </td>
          </tr>
        </table>
		</td>
	</tr>
</table>
<lapschoice:hiddentag pageid="<%=PageId%>"/>
<input type="hidden" name="hidsearch" value=""> 
<input type="hidden" name="check" value="<%=appCheck%>">
</form>
</body>
</html>
