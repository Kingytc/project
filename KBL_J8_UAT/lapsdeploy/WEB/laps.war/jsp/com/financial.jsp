<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
			if (objValues instanceof java.util.HashMap) {
				hshValues = (java.util.HashMap) objValues;
			}
java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
nf.setGroupingUsed(false);
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);
			ArrayList vecid1 = (ArrayList) hshValues.get("vecid1");
			ArrayList vecid2 = (ArrayList) hshValues.get("vecid2");
			ArrayList vecid3 = (ArrayList) hshValues.get("vecid3");
			ArrayList vecid4 = (ArrayList) hshValues.get("vecid4");
			ArrayList vecid5 = (ArrayList) hshValues.get("vecid5");

			String bgclr = "";
			String tagFlag = "";
			int p = 0, sizeyear = 0, from = 0, to = 0, vecModSize = 0;
			String temp = "", totcount = "", upto = "", pageval = "", strCurModule = "", identity = "", fromnext = "";
			totcount = Helper.correctNull((String) hshValues.get("totalyear"));
			upto = Helper.correctNull((String) hshValues.get("upto"));
			fromnext = Helper.correctNull((String) hshValues.get("from"));
			pageval = Helper.correctNull((String) hshValues.get("page"));
			identity = Helper.correctNull((String) hshValues.get("identity"));

			String strcat = "";
			if (!strCategoryType.equalsIgnoreCase(null)) {
				if (strCategoryType.equalsIgnoreCase("OPS")) {
					strcat = "Tertiary";
				} else {
					strcat = "Corporate";
				}
			}
			strCurModule = pageval;
			ArrayList g1 = new ArrayList();
			ArrayList g2 = new ArrayList();
			ArrayList g3 = new ArrayList();
			ArrayList g4 = new ArrayList();
			ArrayList year1 = new ArrayList();
			ArrayList year2 = new ArrayList();
			ArrayList year3 = new ArrayList();
			ArrayList year4 = new ArrayList();
			ArrayList year5 = new ArrayList();
			g2 = (ArrayList) hshValues.get("yearvalue");
			g3 = (ArrayList) hshValues.get("value");
			g4 = (ArrayList) hshValues.get("yearvalue_strt");
			year1 = (ArrayList) hshValues.get("year1");
			year2 = (ArrayList) hshValues.get("year2");
			year3 = (ArrayList) hshValues.get("year3");
			year4 = (ArrayList) hshValues.get("year4");
			year5 = (ArrayList) hshValues.get("year5");
			ArrayList vecModule = (ArrayList) hshValues.get("tabdetails");
			if (vecModule != null) {
				vecModSize = vecModule.size();
			}
			String yearval[] = new String[5];
			String yearval_strt[] = new String[5];
			String comboselect[] = new String[5];
			String snos[] = new String[5];
			int y = 0, n = 0,c=1;

			if(g4!=null && g4.size()>0)
			{
				for(int m=0;m<g4.size();m++)
				{
					//if(!Helper.correctNull((String) g4.get(k)).equalsIgnoreCase(""))
					yearval_strt[m] = Helper.correctNull((String) g4.get(m));
				}
			}
			
			if (g2!=null && g2.size() != 0) {
				sizeyear = g2.size();

				for (int k = 0; k <= g2.size() - 1; k++) {
					if(k<=4)
					{
					snos[c-1]=Helper.correctNull((String)hshValues.get("sno"+(c)));
					c++;
				}
					if ((k % 2) == 0) 
					{
						temp = Helper.correctNull((String) g2.get(k));
						yearval[y] = temp;
						y = y + 1;
					} 
					else if ((k % 2) == 1) 
					{
						temp = Helper.correctNull((String) g2.get(k));
						if (temp.trim().equals("fin_audit")) {
							temp = "a";
						} else if (temp.trim().equals("fin_unaudit")) {
							temp = "u";
						} else if (temp.trim().equals("fin_estimated")) {
							temp = "e";
						} else if (temp.trim().equals("fin_projection")) {
							temp = "p";
						}
						comboselect[n] = temp;
						n = n + 1;
					}
				}
				for (int d = 0; d <= 4; d++) 
				{
					if (comboselect[d] == null) {
						comboselect[d] = "S";

					}
					if (yearval[d] == null) {
						yearval[d] = "";
					}
					if (snos[d] == null) {
						snos[d] = "";
					}
				}
			} 
			else {
				for (p = 0; p <= 4; p++) {
					comboselect[p] = "S";
					yearval[p] = "";
					snos[p] = "";
				}
			}
			String strFinType1 = Helper.correctNull((String) comboselect[0]);
			String strFinType2 = Helper.correctNull((String) comboselect[1]);
			String strFinType3 = Helper.correctNull((String) comboselect[2]);
			String strFinType4 = Helper.correctNull((String) comboselect[3]);
			String strFinType5 = Helper.correctNull((String) comboselect[4]);

			String strYear1 = Helper.correctNull((String) yearval[0]);
			String strYear2 = Helper.correctNull((String) yearval[1]);
			String strYear3 = Helper.correctNull((String) yearval[2]);
			String strYear4 = Helper.correctNull((String) yearval[3]);
			String strYear5 = Helper.correctNull((String) yearval[4]);

			String strYearStrt1 = Helper.correctNull((String) yearval_strt[0]);
			String strYearStrt2 = Helper.correctNull((String) yearval_strt[1]);
			String strYearStrt3 = Helper.correctNull((String) yearval_strt[2]);
			String strYearStrt4 = Helper.correctNull((String) yearval_strt[3]);
			String strYearStrt5 = Helper.correctNull((String) yearval_strt[4]);

			if (strFinType1.trim().equalsIgnoreCase("S")) {
				strFinType1 = Helper.correctNull((String) request.getParameter("type1"));
			}
			if (strFinType2.trim().equals("S")) {
				strFinType2 = Helper.correctNull((String) request.getParameter("type2"));
			}
			if (strFinType3.trim().equals("S")) {
				strFinType3 = Helper.correctNull((String) request.getParameter("type3"));
			}
			if (strFinType4.trim().equals("S")) {
				strFinType4 = Helper.correctNull((String) request.getParameter("type4"));
			}
			if (strFinType5.trim().equals("S")) {
				strFinType5 = Helper.correctNull((String) request.getParameter("type5"));
			}
			String strfintype = Helper.correctNull((String)hshValues.get("fintype"));
			String checkcol1= Helper.correctNull((String)hshValues.get("checkcol1"));
			String checkcol2= Helper.correctNull((String)hshValues.get("checkcol2"));
			String checkcol3= Helper.correctNull((String)hshValues.get("checkcol3"));
			String checkcol4= Helper.correctNull((String)hshValues.get("checkcol4"));
			String checkcol5= Helper.correctNull((String)hshValues.get("checkcol5"));
			String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
			String strFreeze=Helper.correctNull((String)request.getParameter("hidFreeze"));
			String strFreez=Helper.correctNull((String)hshValues.get("Freeze"));
			ArrayList arrcma=(ArrayList)hshValues.get("arrcmaval");	
			
			String strauditflag=Helper.correctNull((String)hshValues.get("Auditflag"));
			String strfreeze_audit=Helper.correctNull((String)hshValues.get("freeze_flag"));
			
			String hshRecord_flag=Helper.correctNull((String)hshValues.get("recordFlag"));
		     int rowid_count=Integer.parseInt(Helper.correctInt((String)hshValues.get("rowid_count")));
		     ArrayList labeld_details=new ArrayList();
		     labeld_details=(ArrayList) hshValues.get("arr_labeldetails");
		     
		     String finaced_id=Helper.correctNull((String)hshValues.get("finace_id"));
			String attach_flag=Helper.correctNull((String)hshValues.get("appattach_flag"));	
			String finaceid_flag=Helper.correctNull((String)hshValues.get("finaceid_flag"));
			  
			  String PAflag=Helper.correctNull((String)hshValues.get("PAflag"));
			  String newattachflag=Helper.correctNull((String)hshValues.get("newattach_flag"));
			  String valuesin=Helper.correctNull((String)hshValues.get("strValuesin"));
			  if(valuesin.equalsIgnoreCase("C")){
					valuesin="Crores";
				}else if(valuesin.equalsIgnoreCase("L")){
					valuesin="Lacs";
				}else if(valuesin.equalsIgnoreCase("R")){
					valuesin="Rupees";
				}else{
					valuesin="";
				}
			%>
<html>
<head>
<title>Financial</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/com/finmain.js"></script>
<SCRIPT language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css"><Script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var varAction="<%=Helper.correctNull((String)hshValues.get("strAction"))%>";	
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
var appno="<%=request.getParameter("appno")%>";
var varstrFreeze="<%=strFreez%>";
var varstraudit="<%=strauditflag%>";
var varstrFreezeaudit="<%=strfreeze_audit%>";
var rowid_count="<%=rowid_count%>";
var finaced_id="<%=finaced_id%>";
var labeldets = new Array();
var cma="<%=strfintype%>";
var newattachflag="<%=newattachflag%>";
var varGrpRights="<%=(Helper.correctNull((String)session.getAttribute("strGroupRights"))).charAt(18)%>";
<%
if(labeld_details!=null)
{
	for(int i=0;i<labeld_details.size();i++)
	{
		
%>
labeldets[<%= i %>] = "<%=(String)labeld_details.get(i)%>";
	
<%
	}
}
%>


//Function Added for interface //by s.sathya moorthy
function doComments()
{
	var btnenable=document.forms[0].btnenable.value;
	page="<%=pageval%>";
	var prop = "scrollbars=no,width=750,height=550,top=25,left=180";
	var url=appURL+"action/com_bankingcomments.jsp?hidBeanId=facilities&hidBeanGetMethod=getComments&hidAppNo="+appno+"&hidPage1="+page+"&appstatus="+appstatus+"&btnenable="+btnenable;
	window.open(url,"Comments",prop);
}
function  UploadtoRAM()
{		
	document.forms[0].hidBeanId.value="financial"
	document.forms[0].hidBeanMethod.value="uploadtoRAM";
	document.forms[0].hidBeanGetMethod.value="getData";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/financial.jsp";
	document.forms[0].submit();	
}
function callCalender(fname,lname)
{
	if(lname.disabled == true)
	{
		if(lname.value == "")
		{
			alert("Undo the financial freeze in Financial / Rating tab and try to save the page there.");
		}
		return;
	}
	var val2=funfinancialYrCheck(lname,'N');
	if(val2==true)
	{
		if(document.forms[0].cmdsave.disabled==false)
		{
 			showCal("<%=ApplicationParams.getAppUrl()%>",fname);
		}
	}
}
function callLink12(page,method)
{		
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].hidBeanId.value="financial";
	document.forms[0].pageval.value="RA";
	document.forms[0].action=appURL+"action/"+page;
	document.forms[0].submit();	 
}
function callCashFlow(page)
{	
	document.forms[0].hidBeanGetMethod.value="GetCashFlowData";
	document.forms[0].hidBeanId.value="comformula";
	document.forms[0].action=appURL+"action/"+page+"?flowtype=CA";
	document.forms[0].submit();	 
}
function comboselect()
{
	document.forms[0].combo1.value ="<%=strFinType1%>";
	document.forms[0].combo2.value ="<%=strFinType2%>";
	document.forms[0].combo3.value ="<%=strFinType3%>";
	document.forms[0].combo4.value ="<%=strFinType4%>";
	document.forms[0].combo5.value ="<%=strFinType5%>";
	//document.forms[0].cmdcomments.disabled=false;
	if(varstrFreeze=='Y')
	{
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdchange.disabled=true;
		document.forms[0].cmdcalculate.disabled=true;
	}
	if((appstatus.toUpperCase())!="OPEN/PENDING")
	{
		document.forms[0].cmdchange.disabled=true;
	}
	if(varGrpRights=='r')
	{
		document.forms[0].cmdchange.disabled=true;
		document.forms[0].cmdcalculate.disabled=true;
		document.forms[0].cmdprint.disabled=true;
		document.forms[0].cmddownloadexceltemplate.disabled=true;
	}
}
function shownext(val)
{
	/*if(document.forms[0].cmdedit.disabled == true)
	{
		alert ("Please save the data");
		return;
	}*/
	upto = <%=Integer.parseInt(upto)%>;
	page="<%=pageval%>";
	totcount=<%=totcount%>;
	fromnext=<%=Integer.parseInt(fromnext)%>;	
	if (val == "n")
	{
		if (upto == totcount)
		{
		from =1;
		}
		else
		{
			from = upto + 1;
		}
	}
	else if (val == "p")
	{
	     from = fromnext - 5;		
	}
	else if(val=="a")
	{
		from=upto+1;
	}
	document.forms[0].action=appURL+"action/financial.jsp?page="+page+"&from="+from;
	document.forms[0].hidBeanGetMethod.value="getData";
	document.forms[0].hidBeanId.value="financial";
	document.forms[0].submit();
}
var xmlHttp=null;
function GetXmlHttpObject()
{	
	try
	{
		xmlHttp=new XMLHttpRequest();
	}
	catch(e)	
	{
		try
		{
			xmlHttp= new ActiveXObject("Msxml12.XMLHTTP");
		}
		catch(e)
		{
			xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
		}
	}	
	return xmlHttp;	
}
//Function added for financial performance //by venu
function doCalculate()
{    
	var from=document.forms[0].fromnext.value;
//	var seldivid=document.forms[0].sel_divID.value;
var seldivid="0";
    var pageval=document.forms[0].pageval.value;
    var cattype=document.forms[0].cattype.value;
    var ssitype="<%=strSSIType%>"; 
	var xmlHttp;
	var uri;
	xmlHttp=GetXmlHttpObject();
	if(xmlHttp==null)
	{
		alert("Browser Do Not Support Using Ajax....");
	}
	uri=appURL+"action/iframfinancial.jsp?hidBeanGetMethod=updateFinancialData&hidBeanId=financial&sel_divID="+seldivid+"&appno="+finaced_id+"&pageval="+pageval+"&from="+from+"&cattype="+cattype+"&hidSSIType="+ssitype+"&hidcmasno="+cma;
	uri = uri +"&sid="+Math.random();
	xmlHttp.onreadystatechange=loadCalculatedValues;   
	xmlHttp.open("GET",uri,true);
	xmlHttp.send(null);
	document.getElementById("progress").style.visibility="visible";
	document.forms[0].cmdcalculate.disabled=true;	
}
function loadCalculatedValues()
{
	var varalertflag="";
if(xmlHttp.readyState==4)
	{	

	var fromiframe=xmlHttp.responseText;
	
	var val5=fromiframe.split('@');
	for(var k=0;k<(val5.length);k++)
	{
		varalertflag=val5[1];
	}
	
		var val4=xmlHttp.responseText;			
		var chkVal = val4.split('&');		
		for(var i=0;i<(chkVal.length);i++)
		{
		    temp1=chkVal[i];
		    var temp2=temp1.split(',');
		    if(temp2.length==2)
		    {
		   		for(j=0;j<(temp2.length-1);j++)
		   		{
		    		var k = i+1;
		    		document.forms[0].elements["calc"+k].value= temp2[j];
			    }
		   }
		   else
		   {
		  		for(j=0;j<(temp2.length-1);j++)
		   		{
		    		var k = i+1;
		    	
		    		document.forms[0].elements["calc"+k][j].value= temp2[j];
			   	}
		   }
		    
		}
		document.getElementById("progress").style.visibility="hidden";
	}

 
     if(varalertflag=="N")
     {
    	 alert("Assets and Liabilities does not Tally!"); 
     }
     else if(varalertflag=="Y")
     {
    	 alert("Assets and Liabilities Tally!");
     }
       
     
}

function getFinType()
{
	<%if(!strCategoryType.equalsIgnoreCase("OPS") && (strfintype.equalsIgnoreCase(null) || strfintype.equalsIgnoreCase("")))
	{%>
		alert("Select the Financial Type");
		document.forms[0].hidBeanId.value="facilities"
		document.forms[0].hidBeanGetMethod.value="getFinancialtype";
		document.forms[0].action=appUrl+"action/comfintype.jsp?val=cma";			
		document.forms[0].submit();
	<%}%>
}
function placeValues()
{	      
	disableFields(true);
	document.forms[0].combo1.disabled=true;
	document.forms[0].combo3.disabled=true;
	document.forms[0].combo2.disabled=true;
	document.forms[0].combo4.disabled=true;
	document.forms[0].combo5.disabled=true;			
	var sel_divID="<%=Helper.correctNull((String)hshValues.get("sel_divID"))%>";			
	//document.forms[0].sel_divID.value=sel_divID;			
	var checkcol1="<%=checkcol1%>";
	var checkcol2="<%=checkcol2%>";
	var checkcol3="<%=checkcol3%>";
	var checkcol4="<%=checkcol4%>";
	var checkcol5="<%=checkcol5%>";

	var ratecol1= "<%=Helper.correctNull((String)hshValues.get("ratecol1"))%>";
	var ratecol2= "<%=Helper.correctNull((String)hshValues.get("ratecol2"))%>";
	var ratecol3= "<%=Helper.correctNull((String)hshValues.get("ratecol3"))%>";
	var ratecol4= "<%=Helper.correctNull((String)hshValues.get("ratecol4"))%>";
	var ratecol5= "<%=Helper.correctNull((String)hshValues.get("ratecol5"))%>";
	
	var sno1="<%=Helper.correctNull((String)hshValues.get("sno1"))%>";
	var sno2="<%=Helper.correctNull((String)hshValues.get("sno2"))%>";
	var sno3="<%=Helper.correctNull((String)hshValues.get("sno3"))%>";
	var sno4="<%=Helper.correctNull((String)hshValues.get("sno4"))%>";
	var sno5="<%=Helper.correctNull((String)hshValues.get("sno5"))%>";
	 if((ratecol1!="") && (ratecol1==sno1)){
		 document.forms[0].ratingchk1.checked=true;
		 document.forms[0].old_ratingchk1.checked=true;
	      }else
		   {
			 document.forms[0].ratingchk1.checked=false;
			 document.forms[0].old_ratingchk1.checked=false;
		    }
	 if((ratecol2!="") && (ratecol2==sno2)){
		 document.forms[0].ratingchk2.checked=true;
		 document.forms[0].old_ratingchk2.checked=true;
	      }else
		   {
			 document.forms[0].ratingchk2.checked=false;
			 document.forms[0].old_ratingchk2.checked=false;
		    }
	 if((ratecol3!="") && (ratecol3==sno3)){
		 document.forms[0].ratingchk3.checked=true;
		 document.forms[0].old_ratingchk3.checked=true;
	      }else
		   {
			 document.forms[0].ratingchk3.checked=false;
			 document.forms[0].old_ratingchk3.checked=false;
		    }
	 if((ratecol4!="") && (ratecol4==sno4)){
		 document.forms[0].ratingchk4.checked=true;
		 document.forms[0].old_ratingchk4.checked=true;
	      }else
		   {
			 document.forms[0].ratingchk4.checked=false;
			 document.forms[0].old_ratingchk4.checked=false;
		    }
	 if((ratecol5!="") && (ratecol5==sno5)){
		 document.forms[0].ratingchk5.checked=true;
		 document.forms[0].old_ratingchk5.checked=true;
	      }else
		   {
			 document.forms[0].ratingchk5.checked=false;
			 document.forms[0].old_ratingchk5.checked=false;
		    }
	    
	 if((checkcol1!="") && (checkcol1==sno1)){
		 document.forms[0].printchk1.checked=true;
	      }else
		   {
			 document.forms[0].printchk1.checked=false;
		    }
	 if((checkcol2!="") && (checkcol2==sno2)){
		 document.forms[0].printchk2.checked=true;
	      }else
		   {
			 document.forms[0].printchk2.checked=false;
		    }
	 if((checkcol3!="") && (checkcol3==sno3)){
		 document.forms[0].printchk3.checked=true;
	      }else
		   {
			 document.forms[0].printchk3.checked=false;
		    }
	 if((checkcol4!="") && (checkcol4==sno4)){
		 document.forms[0].printchk4.checked=true;
	      }else
		   {
			 document.forms[0].printchk4.checked=false;
		    }
	 if((checkcol5!="") && (checkcol5==sno5)){
		 document.forms[0].printchk5.checked=true;
	      }else
		   {
			 document.forms[0].printchk5.checked=false;
		    }
	  			   
}
function doEdit()
{
	disableFields(false);
	enableButtons(true,false,false,false);
	document.forms[0].combo1.disabled=false;
	document.forms[0].combo3.disabled=false;
	document.forms[0].combo2.disabled=false;
	document.forms[0].combo4.disabled=false;
	document.forms[0].combo5.disabled=false;
	document.forms[0].cmdcalculate.disabled=true;
	
	if(document.forms[0].combo1.value=="a" && varstrFreezeaudit=="Y")

	{



	for(i=0;i<rowid_count;i++)
	{

    var str_id=labeldets[i];
  

    document.forms[0].elements["row"+str_id+"c1"].readOnly=true;
		
	}
	document.forms[0].combo1.disabled=true;
	document.forms[0].txtyear1.disabled=true;
	document.forms[0].txtyear1_start.disabled=true;
	}
	if(document.forms[0].combo2.value=="a" && varstrFreezeaudit=="Y")

	{



	for(i=0;i<rowid_count;i++)
	{

    var str_id=labeldets[i];

    document.forms[0].elements["row"+str_id+"c2"].readOnly=true;
		
	}
	document.forms[0].combo2.disabled=true;
	document.forms[0].txtyear2.disabled=true;
	document.forms[0].txtyear2_start.disabled=true;
	}		
	if(document.forms[0].combo3.value=="a" && varstrFreezeaudit=="Y")

	{
    for(i=0;i<rowid_count;i++)
	{

    var str_id=labeldets[i];

    document.forms[0].elements["row"+str_id+"c3"].readOnly=true;
		
	}
    document.forms[0].combo3.disabled=true;
	document.forms[0].txtyear3.disabled=true;	
	document.forms[0].txtyear3_start.disabled=true;	
	}
    if(document.forms[0].combo4.value=="a" && varstrFreezeaudit=="Y")

	{



	for(i=0;i<rowid_count;i++)
	{

    var str_id=labeldets[i];

    document.forms[0].elements["row"+str_id+"c4"].readOnly=true;
		
	}
	document.forms[0].combo4.disabled=true;
	document.forms[0].txtyear4.disabled=true;
	document.forms[0].txtyear4_start.disabled=true;
	}
	if(document.forms[0].combo5.value=="a" && varstrFreezeaudit=="Y")

	{



	for(i=0;i<rowid_count;i++)
	{

    var str_id=labeldets[i];

    document.forms[0].elements["row"+str_id+"c5"].readOnly=true;
		
	}
	document.forms[0].combo5.disabled=true;
	document.forms[0].txtyear5.disabled=true;
	document.forms[0].txtyear5_start.disabled=true;
	
}
}
function doDelete()
{
	var frm=document.forms[0];	
	if(frm.chk1.checked==false && frm.chk2.checked==false && frm.chk3.checked==false && frm.chk4.checked==false &&frm.chk5.checked==false)
	{
		alert("Please select the year you want to delete");
		return;
	}

	
	if(frm.chk1.checked==true && 	document.forms[0].combo1.value=="a")
	{
		alert("No Provision to delete Freezed data");
		return;
	}
	if(frm.chk2.checked==true && 	document.forms[0].combo2.value=="a")
	{
		alert("No Provision to delete Freezed data");
		return;
	}
	if(frm.chk3.checked==true && 	document.forms[0].combo3.value=="a")
	{
		alert("No Provision to delete Freezed data");
		return;
	}
	if(frm.chk4.checked==true && 	document.forms[0].combo4.value=="a")
	{
		alert("No Provision to delete Freezed data");
		return;
	}
	if(frm.chk5.checked==true && 	document.forms[0].combo5.value=="a")
	{
		alert("No Provision to delete Freezed data");
		return;
	}
	else
	{
		if(ConfirmMsg(101))
		 {
			document.forms[0].hidcmasno.value=cma;
			document.forms[0].hidfinanceid.value=finaced_id;
			document.forms[0].combo1.disabled=false;
			document.forms[0].combo3.disabled=false;
			document.forms[0].combo2.disabled=false;
			document.forms[0].combo4.disabled=false;
			document.forms[0].combo5.disabled=false;
			document.forms[0].hidAction.value="delete"
			document.forms[0].hidBeanId.value="financial"
			document.forms[0].hidBeanMethod.value="deleteData";
			document.forms[0].hidBeanGetMethod.value="getData";
			document.forms[0].action=appURL+"controllerservlet";
			document.forms[0].hidSourceUrl.value="/action/financial.jsp";
			document.forms[0].submit();
		 }
	}
}
function checkDesc()
{
	var len=document.forms[0].id.length.value;	
	for(var i=0;i<len;i++)
	{
		if (document.forms[0].type[i].value == "I")
		{
			var x="document.forms[0].desc"+i+".value";
			if (x == "")
			{
				var t = "document.forms[0].row"+id[i]+"c1".value
				t ="0.00"
			}
		}
	}
}


function doSave()
{
	 modifyCheck();
	 if(document.forms[0].hidChangeFlag.value=="Y")
	 {
		 if(!ConfirmMsg(196))
			 {
			 return false;
			 }
	 }
    var from=document.forms[0].fromnext.value;
	var frm=document.forms[0];
	var flag;	
	document.forms[0].hidcmasno.value=cma;
	document.forms[0].hidfinanceid.value=finaced_id;
	//for Checking Same Year
	var strcount=0;
	var strcompyear="",strcomptype="",strnextyear="",strnexttype="";
	var vartemp="", vartype="";
	var flag=0;
	for(var i=1;i<=5;i++)
	{

	vartemp='txtyear'+i;
	 strcompyear=eval("document.forms[0]."+vartemp).value;
 vartype='combo'+i;
	 strcomptype=eval("document.forms[0]."+vartype).value;
	

		for(var j=i+1;j<=5;j++)
		{
			var varnexyear='txtyear'+j;
			strnextyear=eval("document.forms[0]."+varnexyear).value;
			 var varnextype='combo'+j;
			 strnexttype=eval("document.forms[0]."+varnextype).value;
	 
	
	if(strcompyear!="" && strnextyear!=""&&strcomptype!="S"&&strnexttype!="S")

			{
	if((strcompyear==strnextyear)&&(strcomptype==strnexttype))
	{
	
	strcount=strcount+1;
	flag=i;
		
	}
	}
		}
	}


	
	if(document.forms[0].p_checkflag.value=="false")
	{
		flag=true;
	}
	  if((frm.txtyear1.value=="" || frm.txtyear1_start.value=="") && frm.combo1.selectedIndex>0) 
	  {
		  alert("Please Enter Date ");
		  frm.txtyear1.focus();
		  return;
	  }
	  else if(frm.txtyear1.value!="" && frm.combo1.value=="S")
	  {
		  alert("Please Select Financial Type");
		  frm.combo1.focus();
		  return;
	  }
	  if((frm.txtyear2.value=="" || frm.txtyear2_start.value=="") && frm.combo2.selectedIndex>0) 
	  {
		  alert("Please Enter Date ");
		  frm.txtyear2.focus();
		  return;
	  }
	  else if(frm.txtyear2.value!="" && frm.combo2.value=="S")
	  {
		  alert("Please Select Financial Type");
		  frm.combo2.focus();
		  return;
	  }
	 
	  if((frm.txtyear3.value=="" || frm.txtyear3_start.value=="") && frm.combo3.selectedIndex>0) 
	  {
		  alert("Please Enter Date ");
		  frm.txtyear3.focus();
		  return;
	  }
	  else if(frm.txtyear3.value!="" && frm.combo3.value=="S")
	  {
		  alert("Please SelectFinancial Type");
		  frm.combo3.focus();
		  return;
	  }
	  if((frm.txtyear4.value=="" || frm.txtyear4_start.value=="") && frm.combo4.selectedIndex>0) 
	  {
		  alert("Please Enter Date ");
		  frm.txtyear4.focus();
		  return;
	  }
	  else if(frm.txtyear4.value!="" && frm.combo4.value=="S")
	  {
		  alert("Please Select Financial Type");
		  frm.combo4.focus();
		  return;
	  }
	  if((frm.txtyear5.value=="" || frm.txtyear5_start.value=="") && frm.combo5.selectedIndex>0) 
	  {
		  alert("Please Enter Date ");
		  frm.txtyear5.focus();
		  return;
	  }
	  else if(frm.txtyear5.value!="" && frm.combo5.value=="S")
	  {
		  alert("Please Select Financial Type");
		  frm.combo5.focus();
		  return;
	  }
	  if (((frm.txtyear1.value=="" || frm.txtyear1_start.value=="")  && frm.combo1.value=="") &&			
				((frm.txtyear2.value=="" || frm.txtyear2_start.value=="") && frm.combo2.value=="")&&
				((frm.txtyear3.value=="" || frm.txtyear3_start.value=="") && frm.combo3.value=="")&&
				((frm.txtyear4.value=="" || frm.txtyear4_start.value=="") && frm.combo4.value=="")&&
				((frm.txtyear5.value=="" || frm.txtyear5_start.value=="") && frm.combo5.value==""))	
		 {
			  alert("Please Select Date and Financial Type atleast for one Financial Year");
			  frm.combo1.focus();
			  return;
		  }
	  if(strcount>0)
	  {
		  alert("Already Same Year & Type Exists! ");
			var varnexyear='combo'+flag;
			eval("document.forms[0]."+varnexyear).focus();
		  return;
	  }
		
	else
	{
		
			flag=true;
		
	}	
	if(flag==true)
	{		
  		disableFields(false);
		document.forms[0].combo1.disabled=false;
		document.forms[0].combo3.disabled=false;
		document.forms[0].combo2.disabled=false;
		document.forms[0].combo4.disabled=false;
		document.forms[0].combo5.disabled=false;			
		document.forms[0].cmdsave.disabled = true;
		document.forms[0].hidAction.value="update"
		document.forms[0].hidBeanId.value="financial"
	    document.forms[0].hidapppage.value="true"
		document.forms[0].hidBeanMethod.value="updateData";
		document.forms[0].hidBeanGetMethod.value="getData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/financial.jsp?from="+from;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].submit();	
	}		
}
function doList()
{
	disableFields(false);
	//document.forms[0].hidsel_divID.value=document.forms[0].sel_divID.value;
	document.forms[0].combo1.disabled=false;
	document.forms[0].combo3.disabled=false;
	document.forms[0].combo2.disabled=false;
	document.forms[0].combo4.disabled=false;
	document.forms[0].combo5.disabled=false;
	document.forms[0].hidBeanId.value="financial"
	document.forms[0].hidBeanMethod.value="getDataList";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/financial.jsp";
	document.forms[0].submit();
}
function doCancel()
{
	if(ConfirmMsg(102))
	 {


		document.forms[0].hidcmasno.value=cma;
		document.forms[0].hidfinanceid.value=finaced_id;
		document.forms[0].hidBeanId.value="facilities";
		document.forms[0].hidBeanGetMethod.value="getFinancialtype";
	
		document.forms[0].hidSourceUrl.value="/action/financial.jsp";
		document.forms[0].submit();
	 }	
}
function doClose()
{
 var cattype=document.forms[0].cattype.value;
 if((cattype=="ASSI")||(cattype=="ASBI") ||(cattype=="OPS"))
 {
        if(ConfirmMsg(100))
	 {
		 document.forms[0].action=appUrl+"action/agrborrowersearch.jsp";
		 document.forms[0].submit();
	 }
		}
		if((cattype=="SSI")||(cattype=="CORP")||(cattype=="SME"))
        {
        if(ConfirmMsg(100))
	 {
		 document.forms[0].action=appUrl+"action/comborrowersearch.jsp";
		 document.forms[0].submit();
	 }
		}  
}
function callLink(page,bean,method)
{	
	if (document.forms[0].cmdsave.disabled)
	{
	 document.forms[0].hidBeanGetMethod.value=method;
	 document.forms[0].hidBeanId.value=bean;
	 document.forms[0].action=appURL+"action/"+page;
	 document.forms[0].submit();
	 }
	else
	{
		ConfirmMsg(103);
	}
}
function callLink1(page,bean)
{	
	if (document.forms[0].cmdsave.disabled)
	{
	 document.forms[0].hidBeanId.value=bean;
	 document.forms[0].action=appURL+"action/"+page;
	 document.forms[0].submit();
	 }
	else
	{
		ConfirmMsg(103);
	}
}
 function callApplicantTab(page)
  {    	
	if (document.forms[0].cmdsave.disabled)
	{
	  if(page=="company")
	  { 
		  document.forms[0].hidBeanGetMethod.value="getData";
		  document.forms[0].action=appURL+"action/comcompany.jsp";
	  }
	  if(page=="proposal")
	  {
		  document.forms[0].hidBeanGetMethod.value="getProposal";
		  document.forms[0].action=appURL+"action/comproposal.jsp";
	  }	 
	  document.forms[0].submit();
	 }
	else
	{
		ConfirmMsg(103);
	}	
  }  
function getSection(modid)
{	
    if(document.forms[0].cmdsave.disabled == false)
	{
		ShowAlert('103');
		return;
	}	
	if((varAction=="update") && (document.forms[0].cmdcalculate.disabled==false))
	{
	   alert("Press the Calculate Button");
	   return;
	}
	document.forms[0].hidcmasno.value=cma;
	document.forms[0].hidfinanceid.value=finaced_id;	
	document.forms[0].type1.value = document.forms[0].combo1.value;
	document.forms[0].type2.value = document.forms[0].combo2.value;
	document.forms[0].type3.value = document.forms[0].combo3.value;
	document.forms[0].type4.value = document.forms[0].combo4.value;
	document.forms[0].type5.value = document.forms[0].combo5.value;

	document.forms[0].pageval.value = modid;
	document.forms[0].hidBeanId.value="financial";
	document.forms[0].hidBeanGetMethod.value="getData";
	document.forms[0].action = appUrl+"action/financial.jsp";
	document.forms[0].submit();

}
function enableButtons(bool1,bool2,bool3,bool4)
{	
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;	  	
	document.forms[0].cmdclose.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool4;
}
function getdivval()
{
    document.forms[0].type1.value = document.forms[0].combo1.value;
	document.forms[0].type2.value = document.forms[0].combo2.value;
	document.forms[0].type3.value = document.forms[0].combo3.value;
	document.forms[0].type4.value = document.forms[0].combo4.value;
	document.forms[0].type5.value = document.forms[0].combo5.value;
	
	document.forms[0].hidBeanId.value="financial";
	document.forms[0].hidBeanGetMethod.value="getData";
	document.forms[0].action = appUrl+"action/financial.jsp";
	document.forms[0].submit();
}
function getInitial()
{
	page="<%=pageval%>";
	document.forms[0].hidBeanId.value="financial";
	document.forms[0].hidBeanGetMethod.value="getData";
	document.forms[0].action = appUrl+"action/financial.jsp";
	document.forms[0].submit();
}
function callAssessment()
{
	document.forms[0].hidBeanId.value="combobassessment";
	document.forms[0].hidBeanGetMethod.value="getData";
	document.forms[0].action = appUrl+"action/bobassessment.jsp";
	document.forms[0].submit();
}

//Help function added by vino
var strvalue="corp_financial.htm";
function doPrint()
{
	appno = document.forms[0].appno.value;
	if (document.forms[0].identity.value == "")
	{
		upto = "<%=Integer.parseInt(upto)%>";
		page="<%=pageval%>";
		totcount="<%=totcount%>";
		var startfrom = totcount/4;
		
		startfrom = Math.floor(startfrom);
		if (upto == totcount && totcount <= 5)
		{
			from = 1;
		}
		else if(eval(upto % 5)==0) 
		{	
			
			from = upto - 4;
		}
		else if(eval(upto % 5)!=0)
		{
			from = (upto - 5);
			if(from < 5)
			{
				from = from + (5 - from)+1;
			}
			else if(from > 5 && upto == totcount)
			{
				from = (totcount - 1)+1;
			}
			else if(from > 5 && upto < totcount)
			{
				from = (upto - 5)+1;
			}
		}
		var purl = appUrl+"action/com_finprint.jsp?pageval="+page+"&from="+from+"&hidBeanGetMethod=getData&hidBeanId=financial&appno="+appno+"&hidfinid="+finaced_id+"&hidCMANo="+cma;
		prop = "scrollbars=yes,width=700,height=450,statusbar=yes,menubar=yes";	
		xpos = (screen.width - 700) / 2;
		ypos = (screen.height - 650) / 2;
		prop = prop + ",left="+xpos+",top="+ypos;
		var title = "Print";
	}
	else
	{
		page="<%=pageval%>";
		txtyear1=document.forms[0].txtyear1.value;
		txtyear2=document.forms[0].txtyear2.value;
		txtyear3=document.forms[0].txtyear3.value;
		combo1=document.forms[0].combo1.value;
		combo2=document.forms[0].combo2.value;
		combo3=document.forms[0].combo3.value;
		var purl = appUrl+"action/com_finprint.jsp?pageval="+page+"&hidBeanGetMethod=getDataList&hidBeanId=financial&appno="+appno+"&txtyear1="+txtyear1+"&txtyear2="+txtyear2+"&txtyear3="+txtyear3+"&combo1="+combo1+"&combo2="+combo2+"&combo3="+combo3+"&hidfinid="+finaced_id+"&hidCMANo="+cma;
		prop = "scrollbars=yes,width=700,height=550,statusbar=yes";	
		xpos = (screen.width - 700) / 2;
		ypos = (screen.height - 550) / 2;
		prop = prop + ",left="+xpos+",top="+ypos;
		var title = "Print";
	}
	window.open(purl,title,prop);
}

<%if(finaceid_flag.equals("false") && attach_flag.equals("true")){%>


function popupload()
{
	if(varGrpRights!='r')
	{
		var title = "Financial";
		var appno=document.forms[0].hidppid.value;
		var pop = appUrl+"action/com_cmafinancial.jsp?hidBeanId=financial&hidBeanGetMethod=getCMAType&appid="+appno;
		var prop = "menubar=yes,scrollbars=yes,width=500,height=300";
		var xpos = (screen.width - 300) / 2;
		var ypos = (screen.height - 300) / 2;
	
		
		window.open(pop,title,prop);
	}


	

}
<%}else{%>

function popupload()
{
	
}	
<%}%>
<%if(attach_flag.equals("false")){%>


function attachmsg()
{
	
	 alert("Please choose Freezed Finacial format for applicant!"); 
	

}

	
<%}
else{%>

function attachmsg()
{
	
}	
<%}%>

function renewenable()
{
	

	<%if((PAflag.equalsIgnoreCase("true"))){%>

	enableButtons(true,true,true,true);
	document.forms[0].cmdchange.disabled=true;
	
	
	<%}
	
	else
	{%>
	
	<%}
	%>
	
}
function doCreatenewFinancial()
{






	var title = "Financial";
	var appno=document.forms[0].hidppid.value;
	var pop = appUrl+"action/com_cmafinancial.jsp?hidBeanId=financial&hidBeanGetMethod=getCMAType&appid="+appno;
	var prop = "menubar=yes,scrollbars=no,width=500,height=300";
	var xpos = (screen.width - 300) / 2;
	var ypos = (screen.height - 300) / 2;


	if(newattachflag=="true")
	{
	
	window.open(pop,title,prop);

}
	
}
function changefinancial()
{

	var title = "Financial";
	
	var appno=document.forms[0].hidapplicantnewid.value;
	var pop = appUrl+"action/com_cmafinancial.jsp?hidBeanId=financial&hidBeanGetMethod=getCMAType&appid="+appno;
	var prop = "menubar=yes,scrollbars=yes,width=500,height=300";
	var xpos = (screen.width - 300) / 2;
	var ypos = (screen.height - 300) / 2;
	window.open(pop,title,prop);
	
}
function auditcheck(obj)
{
	if(varstrFreezeaudit=="Y")

	{
      if(obj.value=="a")
      {
    	   obj.value="S";
            alert("No Provision to add Audited data after Freeze");
            obj.focus();
  
      }
	}
	
	
}
function funfinancialYrCheck(obj,val1)
{
	var varVal=obj.value;
	if(varVal!="")
	{
		alert("You can't Modify the Date, Please delete the entire finanical for this year");
		if(val1=="Y")
		{
		window.event.returnValue = false;
		}else{
			return false;
		}
	}else{
		return true;
	}
}

function doDownloadExcelTemplate()
{
	var cmaindex=cma;
	var category = "FI";
	var varCmaDesc = "<%=Helper.correctNull((String)hshValues.get("fin_model_name"))%>";
	if(category=="S")
	{
		alert("Select the Category");
		return false;
	}
	if(category!="S" && category!="FI")
	{
		alert("Select the Category as Financial");
		return false;
	}
	if(cmaindex=="")
	{
		alert("Select the CMA Format to Export!");
		return false;
	}
	if(cmaindex!="" && category=="FI")
	{
		var FileName=varCmaDesc+"_"+cmaindex+"_COMPANYNAME";
		var qryString=appURL+"action/"+FileName+".xls?&hidBeanId=excelfunction&hidBeanGetMethod=doExcelExportFinancialFormat&strCMANo="+cmaindex+"&strPage="+category+"&cmaformat="+varCmaDesc;
		var prop="scrollbars=yes,menubar=yes,width=20, height=20";
		window.open(qryString,"FinancialFormat",prop);
	}
}

function chkFinType(var1)
{
	if(var1 == 2)
	{
		var year1 = document.forms[0].txtyear1.value;
		var year2 = document.forms[0].txtyear1_start.value;
		var year3 = document.forms[0].txtyear2.value;
		var year4 = document.forms[0].txtyear2_start.value;
		var combo1 = document.forms[0].combo1.value;
		var combo2 = document.forms[0].combo2.value;

		if((year1+year2+combo1) == (year3+year4+combo2))
		{
			alert("Financial with same year and type is already available");
			document.forms[0].combo2.value = "S";
			document.forms[0].combo2.focus();
		}
	}
	else if(var1 == 3)
	{
		var year1 = document.forms[0].txtyear2.value;
		var year2 = document.forms[0].txtyear2_start.value;
		var year3 = document.forms[0].txtyear3.value;
		var year4 = document.forms[0].txtyear3_start.value;
		var combo1 = document.forms[0].combo2.value;
		var combo2 = document.forms[0].combo3.value;

		if((year1+year2+combo1) == (year3+year4+combo2))
		{
			alert("Financial with same year and type is already available");
			document.forms[0].combo3.value = "S";
			document.forms[0].combo3.focus();
		}
	}
	else if(var1 == 4)
	{
		var year1 = document.forms[0].txtyear3.value;
		var year2 = document.forms[0].txtyear3_start.value;
		var year3 = document.forms[0].txtyear4.value;
		var year4 = document.forms[0].txtyear4_start.value;
		var combo1 = document.forms[0].combo3.value;
		var combo2 = document.forms[0].combo4.value;

		if((year1+year2+combo1) == (year3+year4+combo2))
		{
			alert("Financial with same year and type is already available");
			document.forms[0].combo4.value = "S";
			document.forms[0].combo4.focus();
		}
	}
	else if(var1 == 5)
	{
		var year1 = document.forms[0].txtyear4.value;
		var year2 = document.forms[0].txtyear4_start.value;
		var year3 = document.forms[0].txtyear5.value;
		var year4 = document.forms[0].txtyear5_start.value;
		var combo1 = document.forms[0].combo4.value;
		var combo2 = document.forms[0].combo5.value;

		if((year1+year2+combo1) == (year3+year4+combo2))
		{
			alert("Financial with same year and type is already available");
			document.forms[0].combo5.value = "S";
			document.forms[0].combo5.focus();
		}
	}
}
function modifyCheck()
{	
	var temp=0;
	<%
	ArrayList v1 = (ArrayList) hshValues.get("labeldetails");
	String col11 = "", col12 = "", col13 = "", col14 = "", col15 = "";
	String colval11 = "0";
	String colval12 = "0", colval13 = "0", colval14 = "0", colval15 = "0", strtype1 = "", selectdesc1 = "",selectdesc2 = "";
	int vecsize1 = 0, yearsize1 = 0, finsize1 = 0, startsize1 = 0;
	String colid1 = "", rowid1 = "";
	if (v1 != null) {
		vecsize1 = v1.size();
	}
	if (year1 != null) {
		yearsize1 = year1.size();
	}
	if (yearsize1 == vecsize1) {
		finsize1 = vecsize1;
	} else if (yearsize1 < vecsize1) {
		finsize1 = yearsize1;
	}
	if (finsize1 == 0) {
		finsize1 = vecsize1;
	}
	for (int l = 0; l < finsize1; l++) {
		g1 = (ArrayList) v1.get(l);
		colid1 = Helper.correctNull((String) g1.get(0));
		colid1 = colid1.trim();
		if (year1 != null) {
			rowid1 = Helper.correctDouble((String) vecid1.get(l));
			rowid1 = rowid1.trim();
			if (rowid1.equals(colid1)) {
				colval11 = Helper.correctDouble((String) year1
						.get(l));
			}else {
				colval11 = "0.00";
						} 
		}
		if (year2 != null) {
			rowid1 = Helper.correctDouble((String) vecid2.get(l));
			if (rowid1.equals(colid1)) {
				colval12 = Helper.correctDouble((String) year2
						.get(l));
			} else {
				colval12 = "0.00";
						}
		}
		if (year3 != null) {
			rowid1 = Helper.correctDouble((String) vecid3.get(l));
			if (rowid1.equals(colid1)) {
				colval13 = Helper.correctDouble((String) year3
						.get(l));
			}else {
				colval13 = "0.00";
						}
		}
		if (year4 != null) {
			rowid1 = Helper.correctDouble((String) vecid4.get(l));
			if (rowid1.equals(colid1)) {
				colval14 = Helper.correctDouble((String) year4
						.get(l));
			} else {
				colval14 = "0.00";
						}
		}
		if (year5 != null) {
			rowid1 = Helper.correctDouble((String) vecid5.get(l));
			if (rowid1.equals(colid1)) {
				colval15 = Helper.correctDouble((String) year5
						.get(l));
			} else {
				colval15 = "0.00";
						}
		}
		col11 = "row" + Helper.correctNull((String) g1.get(0))
				+ "c1";
		col12 = "row" + Helper.correctNull((String) g1.get(0))
				+ "c2";
		col13 = "row" + Helper.correctNull((String) g1.get(0))
				+ "c3";
		col14 = "row" + Helper.correctNull((String) g1.get(0))
				+ "c4";
		col15 = "row" + Helper.correctNull((String) g1.get(0))
				+ "c5";
		strtype1 = Helper.correctNull((String) g1.get(2));

	%>
	<%if(!strtype1.equalsIgnoreCase("C")){%>
		if(document.forms[0].<%=col11%>.value!=<%=nf.format(Double.parseDouble(colval11))%>){temp++;}
		if(document.forms[0].<%=col12%>.value!=<%=nf.format(Double.parseDouble(colval12))%>){temp++;}
		if(document.forms[0].<%=col13%>.value!=<%=nf.format(Double.parseDouble(colval13))%>){temp++;}
		if(document.forms[0].<%=col14%>.value!=<%=nf.format(Double.parseDouble(colval14))%>){temp++;}
		if(document.forms[0].<%=col15%>.value!=<%=nf.format(Double.parseDouble(colval15))%>){temp++;}
	<%}}
	%>

	if(document.forms[0].combo1.value!=document.forms[0].old_combo1.value){	temp++;}
	if(document.forms[0].combo2.value!=document.forms[0].old_combo2.value){	temp++;}
	if(document.forms[0].combo3.value!=document.forms[0].old_combo3.value){	temp++;}
	if(document.forms[0].combo4.value!=document.forms[0].old_combo4.value){	temp++;}
	if(document.forms[0].combo5.value!=document.forms[0].old_combo5.value){	temp++;}
	
	if(document.forms[0].txtyear1_start.value!=document.forms[0].old_txtyear1_start.value){	temp++;}
	if(document.forms[0].txtyear2_start.value!=document.forms[0].old_txtyear2_start.value){	temp++;}
	if(document.forms[0].txtyear3_start.value!=document.forms[0].old_txtyear3_start.value){	temp++;}
	if(document.forms[0].txtyear4_start.value!=document.forms[0].old_txtyear4_start.value){	temp++;}
	if(document.forms[0].txtyear5_start.value!=document.forms[0].old_txtyear5_start.value){	temp++;}
	
	if(document.forms[0].txtyear1.value!=document.forms[0].old_txtyear1.value){	temp++;}
	if(document.forms[0].txtyear2.value!=document.forms[0].old_txtyear2.value){	temp++;}
	if(document.forms[0].txtyear3.value!=document.forms[0].old_txtyear3.value){	temp++;}
	if(document.forms[0].txtyear4.value!=document.forms[0].old_txtyear4.value){	temp++;}
	if(document.forms[0].txtyear5.value!=document.forms[0].old_txtyear5.value){	temp++;}
	
	if(document.forms[0].ratingchk1.checked!=document.forms[0].old_ratingchk1.checked){temp++;}
	if(document.forms[0].ratingchk2.checked!=document.forms[0].old_ratingchk2.checked){temp++;}
	if(document.forms[0].ratingchk3.checked!=document.forms[0].old_ratingchk3.checked){temp++;}
	if(document.forms[0].ratingchk4.checked!=document.forms[0].old_ratingchk4.checked){temp++;}
	if(document.forms[0].ratingchk5.checked!=document.forms[0].old_ratingchk5.checked){temp++;}

if(temp>0){document.forms[0].hidChangeFlag.value="Y";}
else{document.forms[0].hidChangeFlag.value="N";}

}
</script>
<script language="JavaScript">
<!--
function MM_reloadPage(init) {  //reloads the window if Nav4 resized
  if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
    document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
}
MM_reloadPage(true);
// -->
</script>
</head>
<body onLoad="comboselect();placeValues();checkDesc();getFinType();popupload();attachmsg();">
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
<form method="post" class="normal">
<%
if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
class="outertable">
<tr>
	<td><jsp:include page="../com/postsanctionlinks.jsp" flush="true">
		<jsp:param name="pageid" value="5" />
		<jsp:param name="cattype" value="<%=strCategoryType%>" />
		<jsp:param name="ssitype" value="<%=strSSIType%>" />
	</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
	</td>
</tr>
</table>
<%}else{%>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td><jsp:include
			page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="6" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>	
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0"  class="outertable">
<%if(strSessionModuleType.equalsIgnoreCase("AGR")){%>
<tr>
<td class="page_flow">Home -&gt; Agriculture -&gt; Application -&gt; Financial
</td>
</tr>
<%}else if (strCategoryType.equalsIgnoreCase("OPS")) {%>
	<tr>
		<td class="page_flow">Home -&gt; Tertiary -&gt; Application -&gt;Financial</td>
	</tr>
	<%}else{%>
	<tr>
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Financial
		</td>
	</tr>
	<%} %>
</table>
<div id="progress" style="position:absolute; width:106px; visibility:hidden; height:19px; z-index:1; left: 521px; top: 300px">
<img src="<%=ApplicationParams.getAppUrl()%>img/finloader.gif"></div>
<span style="display:none"><lapschoice:borrowertype /></span>
<lapschoice:application />
<%} %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">

			<tr>
				<td>
				<table width="100%" cellspacing="0" cellpadding="0" class="outertable">				
					<tr>
						<td><%boolean pflag = false;
			boolean base_year = false;
			int strWidth;
			int tabWidth;
			strWidth = vecModSize;%>
						<table border="0" cellspacing="1" cellpadding="3" class="outertable">
							<tr>
								<%for (int i = 0; i < vecModSize; i++) {
				ArrayList vecVal = (ArrayList) vecModule.get(i);
					if(i==0)
					{
						tagFlag = Helper.correctNull((String)vecVal.get(0));
					}
				   String str1=Helper.correctNull((String)vecVal.get(0));					
				   String strClass;				  
     	 		 if(strWidth == 1)
					{
					tabWidth = 5;
					}
				else if(strWidth == 2)
				{
				tabWidth = 20;
				}
				else
				{
				   tabWidth=80/strWidth;
				}
				if(i==0 && strCurModule.trim().equals(""))
				{
					str1="";
				}
				   if(str1.equals(strCurModule))
				   {
				   strClass="sub_tab_active";
				  }
				  else
				  {
				  strClass="sub_tab_inactive";
				   }				   
				   if (!Helper.correctNull((String) vecVal.get(0))
							.equals("Project Financial Input")) {
				  %> <td  align="center" class="<%=strClass%>">
				  <%if (str1.equals(strCurModule)) {%> 
				  <b><%=Helper.correctNull((String) vecVal.get(0))%></b>
								<%} else {%> 
				<a href="#" onclick="getSection('<%=Helper.correctNull((String)vecVal.get(0))%>')">
				<b><%=Helper.correctNull((String) vecVal.get(0))%></b></a>
								<%}
					if (Helper.correctNull((String) hshValues.get("tabname"))
							.equalsIgnoreCase("Project Financial Input")
							|| Helper.correctNull(
									(String) hshValues.get("tabname"))
									.equalsIgnoreCase("INFRA STRUCTURE MODEL")
							|| Helper.correctNull(
									(String) hshValues.get("tabname"))
									.equalsIgnoreCase("OPERATIONS PHASE")) {
						if (Helper.correctNull(
								(String) hshValues.get("sel_divID"))
								.equalsIgnoreCase("0")) {
							pflag = true;
						}
					}
				}%>
				</td>
								<%}%>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		
				<table width="100%" border="0" cellspacing="0" cellpadding="1" class="outertable linebor">
				<tr class="dataheader">
				<td align="left" colspan="6"><b>&nbsp;Financial Model : <%=Helper.correctNull((String)hshValues.get("fin_model_name"))%></b></td>
				<td align="right" colspan="1"><b>All Values are in <%=valuesin %>&nbsp;</b></td>
				</tr>
					<tr class="dataheader">
						<td colspan="2" align="left"><b>&nbsp;Starting period of financial</b></td>
						<td width="14%" align="center"><input type="text" name="txtyear1_start"
							size="13" maxlength="12"  border="1"
							 value="<%=strYearStrt1%>"
							onBlur="checkDate(txtyear1_start);" readOnly="readonly" onkeydown="funfinancialYrCheck(this,'Y');"> <a
							alt="Select date from calender"
							href="javascript:callCalender('txtyear1_start',document.forms[0].txtyear1_start);"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"></a></td>
						<td width="13%" align="center"><input type="text" name="txtyear2_start"
							size="13" maxlength="12"  border="1"
							 value="<%=strYearStrt2%>"
							onBlur="checkDate(txtyear2_start);checkmindate(this,document.forms[0].txtyear1_start.value);" readOnly="readonly" onkeydown="funfinancialYrCheck(this,'Y');;"> <a
							alt="Select date from calender"
							href="javascript:callCalender('txtyear2_start',document.forms[0].txtyear2_start);"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"></a></td>
						<td width="14%" align="center"><input type="text" name="txtyear3_start"
							size="13" maxlength="12"  border="1"
							 value="<%=strYearStrt3%>"
							onBlur="checkDate(txtyear3_start);checkmindate(this,document.forms[0].txtyear2_start.value);" readOnly="readonly" onkeydown="funfinancialYrCheck(this,'Y');;"> <a
							alt="Select date from calender"
							href="javascript:callCalender('txtyear3_start',document.forms[0].txtyear3_start);"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"></a></td>
						<td width="14%" align="center"><input type="text" name="txtyear4_start"
							size="13" maxlength="12"  border="1"
							 value="<%=strYearStrt4%>"
							onBlur="checkDate(txtyear4_start);checkmindate(this,document.forms[0].txtyear3_start.value);" readOnly="readonly" onkeydown="funfinancialYrCheck(this,'Y');;"> <a
							alt="Select date from calender"
							href="javascript:callCalender('txtyear4_start',document.forms[0].txtyear4_start);"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"></a></td>
						<td width="13%" align="center"><input type="text" name="txtyear5_start"
							size="13" maxlength="12" style=" border-style=groove" border="1"
							 value="<%=strYearStrt5%>"
							onBlur="checkDate(txtyear5_start);checkmindate(this,document.forms[0].txtyear4_start.value);" readOnly="readonly" onkeydown="funfinancialYrCheck(this,'Y');"> <a
							alt="Select date from calender"
							href="javascript:callCalender('txtyear5_start',document.forms[0].txtyear5_start);"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"></a></td>						
					</tr>
					<tr class="dataheader">
						<td colspan="2" align="left"><b>&nbsp;End period of financial</b></td>
						<td width="14%" align="center"><input type="text" name="txtyear1"
							size="13" maxlength="12"  border="1"
							 value="<%=strYear1%>"
							onBlur="checkDate(txtyear1);checkmindate(this,document.forms[0].txtyear1_start.value)" readOnly="readonly" onkeydown="funfinancialYrCheck(this,'Y');"> <a
							alt="Select date from calender"
							href="javascript:callCalender('txtyear1',document.forms[0].txtyear1);"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"></a><input type="hidden" name="strsno1" value="<%=snos[0]%>"></td>
						<td width="13%" align="center"><input type="text" name="txtyear2"
							size="13" maxlength="12"  border="1"
							 value="<%=strYear2%>"
							onBlur="checkDate(txtyear2);checkmindate(this,document.forms[0].txtyear1.value)" readOnly="readonly" onkeydown="funfinancialYrCheck(this,'Y');;"> <a
							alt="Select date from calender"
							href="javascript:callCalender('txtyear2',document.forms[0].txtyear2);"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"></a><input type="hidden" name="strsno2" value="<%=snos[1]%>"></td>
						<td width="14%" align="center"><input type="text" name="txtyear3"
							size="13" maxlength="12"  border="1"
							 value="<%=strYear3%>"
							onBlur="checkDate(txtyear3);checkmindate(this,document.forms[0].txtyear2.value)" readOnly="readonly" onkeydown="funfinancialYrCheck(this,'Y');;"> <a
							alt="Select date from calender"
							href="javascript:callCalender('txtyear3',document.forms[0].txtyear3);"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"></a><input type="hidden" name="strsno3" value="<%=snos[2]%>"></td>
						<td width="14%" align="center"><input type="text" name="txtyear4"
							size="13" maxlength="12"  border="1"
							 value="<%=strYear4%>"
							onBlur="checkDate(txtyear4);checkmindate(this,document.forms[0].txtyear3.value)" readOnly="readonly" onkeydown="funfinancialYrCheck(this,'Y');;"> <a
							alt="Select date from calender"
							href="javascript:callCalender('txtyear4',document.forms[0].txtyear4);"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"></a><input type="hidden" name="strsno4" value="<%=snos[3]%>"></td>
						<td width="13%" align="center"><input type="text" name="txtyear5"
							size="13" maxlength="12" style=" border-style=groove" border="1"
							 value="<%=strYear5%>"
							onBlur="checkDate(txtyear5);checkmindate(this,document.forms[0].txtyear4.value)" readOnly="readonly" onkeydown="funfinancialYrCheck(this,'Y');"> <a
							alt="Select date from calender"
							href="javascript:callCalender('txtyear5',document.forms[0].txtyear5);"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"></a><input type="hidden" name="strsno5" value="<%=snos[4]%>"></td>						
					</tr>
					<tr class="dataheader">
						<td colspan="2">&nbsp;</td>
						<td width="14%" align="center"><select name="combo1" onChange="auditcheck(this)">
							<option value="S" selected="selected">--Select--</option>
							<option value="a">Audited</option>
							<option value="e">Estimated</option>
							<option value="u">Unaudited</option>
							<option value="p">Projection</option>
						</select></td>
						<td width="13%" align="center"><select name="combo2" onChange="auditcheck(this);chkFinType(2)">
							<option value="S" selected="selected">--Select--</option>
							<option value="a">Audited</option>
							<option value="e">Estimated</option>
							<option value="u">Unaudited</option>
							<option value="p">Projection</option>
						</select></td>
						<td width="14%" align="center"><select name="combo3" onChange="auditcheck(this);chkFinType(3)">
							<option value="S" selected="selected">--Select--</option>
							<option value="a">Audited</option>
							<option value="e">Estimated</option>
							<option value="u">Unaudited</option>
							<option value="p">Projection</option>
						</select></td>
						<td width="14%" align="center"><select name="combo4" onChange="auditcheck(this);chkFinType(4)">
							<option value="S" selected="selected">--Select--</option>
							<option value="a">Audited</option>
							<option value="e">Estimated</option>
							<option value="u">Unaudited</option>
							<option value="p">Projection</option>
						</select></td>

						<td width="13%" align="center"><select name="combo5" onChange="auditcheck(this);chkFinType(5)">
							<option value="S" selected="selected">--Select--</option>
							<option value="a">Audited</option>
							<option value="e">Estimated</option>
							<option value="u">Unaudited</option>
							<option value="p">Projection</option>
						</select></td>
					</tr>
					<tr class="datagrid">
						<td colspan="2">&nbsp;<span class="mantatory"><b>For Deleting F.Y. click
						in the box and press delete button</b></span></td>
						<td width="14%" align="center"><input type="checkbox" name="chk1"
							value="y1" style="border-style:none"></td>
						<td width="13%" align="center"><input type="checkbox" name="chk2"
							value="y2" style="border-style:none"></td>
						<td width="14%" align="center"><input type="checkbox" name="chk3"
							value="y3" style="border-style:none"></td>
						<td width="14%" align="center"><input type="checkbox" name="chk4"
							value="y4" style="border-style:none"></td>
						<td width="13%" align="center"><input type="checkbox" name="chk5"
							value="y5" style="border-style:none"></td>
					</tr>
					<tr class="datagrid">
                  <td colspan="2" HEIGHT="22"><span class="mantatory"><b>Select the Check box to print 
                    the financial year</b></span></td>
                  <td align="center" HEIGHT="22" width="14%">
                    <input  type="checkbox" name="printchk1"
							value="p1" style="border-style:none">
                  </td>
                  <td width="16%" align="center" HEIGHT="22">
                    <input  type="checkbox" name="printchk2"
							value="p2" style="border-style:none">
                  </td>
                  <td width="16%" align="center" HEIGHT="22">
                    <input type="checkbox" name="printchk3"
							value="p3" style="border-style:none">
                  </td>
                  <td width="16%" align="center" HEIGHT="22">
                    <input type="checkbox" name="printchk4"
							value="p4" style="border-style:none">
                  </td>
                  <td width="15%" align="center" HEIGHT="22">
                    <input type="checkbox" name="printchk5"
							value="p5" style="border-style:none">
                  </td>
                </tr>
				<tr class="datagrid">
                  <td colspan="2" HEIGHT="22"><span class="mantatory"><b>Select the Check box to pass the value to KALYPTO</b></span></td>
                  <td align="center" HEIGHT="22" width="14%">
                    <input  type="checkbox" name="ratingchk1"
							value="r1" style="border-style:none">
                  </td>
                  <td width="16%" align="center" HEIGHT="22">
                    <input  type="checkbox" name="ratingchk2"
							value="r2" style="border-style:none">
                  </td>
                  <td width="16%" align="center" HEIGHT="22">
                    <input type="checkbox" name="ratingchk3"
							value="r3" style="border-style:none">
                  </td>
                  <td width="16%" align="center" HEIGHT="22">
                    <input type="checkbox" name="ratingchk4"
							value="r4" style="border-style:none">
                  </td>
                  <td width="15%" align="center" HEIGHT="22">
                    <input type="checkbox" name="ratingchk5"
							value="r5" style="border-style:none">
                  </td>
                </tr>
					<%ArrayList v = (ArrayList) hshValues.get("labeldetails");
			String col1 = "", col2 = "", col3 = "", col4 = "", col5 = "";
			String  colval1 = "";
			String colval2 = "", colval3 = "", colval4 = "", colval5 = "", strtype = "", selectdesc = "";
			int vecsize = 0,  yearsize = 0, finsize = 0, startsize = 0;
			String colid = "", rowid = "";
			if (v != null) {
				vecsize = v.size();
			}
			if (year1 != null) {
				yearsize = year1.size();
			}
			if (yearsize == vecsize) {
				finsize = vecsize;
			} else if (yearsize < vecsize) {
				finsize = yearsize;
			}
			if (finsize == 0) {
				finsize = vecsize;
			}
			for (int l = 0; l < finsize; l++) {
				g1 = (ArrayList) v.get(l);
				colid = Helper.correctNull((String) g1.get(0));
				colid = colid.trim();
				if (year1 != null) {
					rowid = Helper.correctDouble((String) vecid1.get(l));
					rowid = rowid.trim();
					if (rowid.equals(colid)) {
						colval1 = Helper.correctDouble((String) year1.get(l));
					} else {
						colval1 = "0.00";
					}
				} else {
					colval1 = "0.00";
				}
				if (year2 != null) {
					rowid = Helper.correctDouble((String) vecid2.get(l));
					if (rowid.equals(colid)) {
						colval2 = Helper.correctDouble((String) year2.get(l));
					} else {
						colval2 = "0.00";
					}
				} else {
					colval2 = "0.00";
				}
				if (year3 != null) {
					rowid = Helper.correctDouble((String) vecid3.get(l));
					if (rowid.equals(colid)) {
						colval3 = Helper.correctDouble((String) year3.get(l));
					} else {
						colval3 = "0.00";
					}
				} else {
					colval3 = "0.00";
				}
				if (year4 != null) {
					rowid = Helper.correctDouble((String) vecid4.get(l));
					if (rowid.equals(colid)) {
						colval4 = Helper.correctDouble((String) year4.get(l));
					} else {
						colval4 = "0.00";
					}
				} else {
					colval4 = "0.00";
				}
				if (year5 != null) {
					rowid = Helper.correctDouble((String) vecid5.get(l));
					if (rowid.equals(colid)) {
						colval5 = Helper.correctDouble((String) year5.get(l));
					} else {
						colval5 = "0.00";
					}
				} else {
					colval5 = "0.00";
				}
				col1 = "row" + Helper.correctNull((String) g1.get(0)) + "c1";
				col2 = "row" + Helper.correctNull((String) g1.get(0)) + "c2";
				col3 = "row" + Helper.correctNull((String) g1.get(0)) + "c3";
				col4 = "row" + Helper.correctNull((String) g1.get(0)) + "c4";
				col5 = "row" + Helper.correctNull((String) g1.get(0)) + "c5";
				selectdesc = "desc" + Helper.correctNull((String) g1.get(0));
				strtype = Helper.correctNull((String) g1.get(2));%>
					<tr class="datagrid">
					<%if(!pageval.equalsIgnoreCase("PROFIT AND LOSS ACCOUNT")){ %>
						<td width="3%" align="center">
						<input type="hidden" name="id" value="<%=Helper.correctNull((String)g1.get(0))%>"> 
						<input type="hidden" name="type" value="<%=Helper.correctNull((String)g1.get(2))%>"> 
						<%=Helper.correctNull((String) g1.get(3))%>&nbsp;
						</td>
						<%}else{ %>
						<td width="3%" align="center">
						<input type="hidden" name="id" value="<%=Helper.correctNull((String)g1.get(0))%>"> 
						<input type="hidden" name="type" value="<%=Helper.correctNull((String)g1.get(2))%>"> 	
						<%=Helper.correctNull((String) g1.get(3))%>&nbsp;					
						</td>						
						<%} %>
						<%if(!pageval.equalsIgnoreCase("PROFIT AND LOSS ACCOUNT")){%>
						<td width="23%"><%if (strtype.trim().equals("I")) {%> 
						<input type="text" name="<%=selectdesc%>" size="13"
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String)g1.get(1))%>"> 
							<%} else {%>
						<div><b><font
							<%if (strtype.trim().equals("C") && !strtype.trim().equals("H") ) out.println("size=\"3\" color=\"blue\""); 
							else   out.println("size=\"1\"");%>><%=Helper.correctNull((String) g1.get(1))%></font></b></div><%}%>
							</td>
							<%}else{ %>
							<td width="23%"><%if (strtype.trim().equals("I")) {%> 
						<input type="text" name="<%=selectdesc%>" size="13"
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String)g1.get(1))%>"> 
							<%} else {%>
						<div><b><font
							<%if (strtype.trim().equals("C") && !strtype.trim().equals("H") ) out.println("size=\"3\" color=\"blue\""); 
							else{if(strtype.trim().equals("H")){ out.println("size=\"2\" color=\"green\"");}else{ out.println("size=\"1\"");}}%>><%=Helper.correctNull((String) g1.get(1))%></font></b></div><%}%>
							</td>				
							<%} %>
						<td width="14%" align="center">
						<%if (!strtype.trim().equals("C") && !strtype.trim().equals("H")) {%> 
						<input type="text" name="<%=col1%>" size="13" style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=nf.format(Double.parseDouble(colval1))%>" onKeyPress="allowNegtiveNumber(this)"> 
							<%} else {%> 
							<input type="hidden" name="<%=col1%>" size="13" style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="0.00"> 
							<%if (!strtype.trim().equals("H")) {%>
						<div align="right" style="width:75">
						<b><font> <lapschoice:CurrencyTag name="calc1" size="13"
							style="color:#0000FF;border:none;font-color:#000000;text-align:right"
							value='<%=nf.format(Double.parseDouble(colval1))%>' other="disabled" /> </font></b></div>
						<%}}%></td>
						<td width="13%" align="center">
						<%if (!strtype.trim().equals("C") && !strtype.trim().equals("H")) {%> 
						<input type="text" name="<%=col2%>" size="13"
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value='<%=nf.format(Double.parseDouble(colval2))%>'
							onKeyPress="allowNegtiveNumber(this)"> 
							<%} else {%> <input type="hidden" name="<%=col2%>" size="13"
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="0.00"> 
							<%if (!strtype.trim().equals("H")) {%>
						<div align="right" style="width:75"><b><font> <lapschoice:CurrencyTag name="calc2" size="13"
							style="color:#000000;border:none;font-color:#000000;text-align:right"
							value='<%=nf.format(Double.parseDouble(colval2))%>' other="disabled" /> </font></b></div>
						<%}}%></td>
						<td width="14%" align="center">
						<%if (!strtype.trim().equals("C") && !strtype.trim().equals("H")) {%> 
						<input type="text" name="<%=col3%>" size="13"
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=nf.format(Double.parseDouble(colval3))%>"
							onKeyPress="allowNegtiveNumber(this)"> 
							<%} else {%> 
							<input type="hidden" name="<%=col3%>" size="13"
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="0.00"> <%if (!strtype.trim().equals("H")) {%>
						<div align="right" style="width:75"><b><font 
							> <lapschoice:CurrencyTag name="calc3" size="13"
							style="color:#000000;border:none;font-color:#000000;text-align:right"
							value="<%=nf.format(Double.parseDouble(colval3))%>" other="disabled" /> </font></b></div>
						<%}}%></td>
						<td width="14%" align="center"><%if (!strtype.trim().equals("C") && !strtype.trim().equals("H")) {
					%> <input type="text" name="<%=col4%>" size="13"
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=nf.format(Double.parseDouble(colval4))%>"onKeyPress="allowNegtiveNumber(this)"> 
							<%} else {%> <input type="hidden" name="<%=col4%>" size="13"
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="0.00"> <%if (!strtype.trim().equals("H")) {%>
						<div align="right" style="width:75"><b><font 
							> <lapschoice:CurrencyTag name="calc4" size="13"
							style="color:#000000;border:none;font-color:#000000;text-align:right"
							value="<%=nf.format(Double.parseDouble(colval4))%>" other="disabled" /> </font></b></div>
						<%}}%></td>
						<td width="13%" align="center"><%if (!strtype.trim().equals("C") && !strtype.trim().equals("H")) {%> 
						<input type="text" name="<%=col5%>" size="13"
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=nf.format(Double.parseDouble(colval5))%>"
							onKeyPress="allowNegtiveNumber(this)"> 
							<%} else {%> <input type="hidden" name="<%=col5%>" size="13"
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="0.00"> <%if (!strtype.trim().equals("H")) {%>
						<div align="right" style="width:75"><b><font 
							> <lapschoice:CurrencyTag name="calc5" size="13"
							style="color:#000000;border:none;font-color:#000000;text-align:right"
							value="<%=nf.format(Double.parseDouble(colval5))%>" other="disabled" /> </font></b></div>
						<%}}%></td>
					</tr>
					<%}
			startsize = finsize;
			if (yearsize < vecsize) {
				for (int l = startsize; l < vecsize; l++) {
					g1 = (ArrayList) v.get(l);
					colval1 = "0.00";
					colval2 = "0.00";
					colval3 = "0.00";
					colval4 = "0.00";
					col1 = "row" + Helper.correctNull((String) g1.get(0)) + "c1";
					col2 = "row" + Helper.correctNull((String) g1.get(0)) + "c2";
					col3 = "row" + Helper.correctNull((String) g1.get(0)) + "c3";
					col4 = "row" + Helper.correctNull((String) g1.get(0)) + "c4";
					col5 = "row" + Helper.correctNull((String) g1.get(0)) + "c5";
					selectdesc = "desc" + Helper.correctNull((String) g1.get(0));
					strtype = Helper.correctNull((String) g1.get(2));%>
					<tr class="datagrid">
						<td width="3%" align="center">
						<input type="hidden" name="id" value="<%=Helper.correctNull((String)g1.get(0))%>"> 
						<input type="hidden" name="type" value="<%=Helper.correctNull((String)g1.get(2))%>">
						<%=Helper.correctNull((String) g1.get(3))%>&nbsp;
						</td>
						<td width="23%"><%if (strtype.trim().equals("I")) {%> 
						<input type="text" name="<%=selectdesc%>" size="13"
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String)g1.get(1))%>"> 
							<%} else {%>
						<div><b><%=Helper.correctNull((String) g1.get(1))%></b></div>
						<%}%></td>
						<td width="14%" align="center">
						<%if (!strtype.trim().equals("C") && !strtype.trim().equals("H")) {%> 
						<input type="text" name="<%=col1%>" size="13"
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=nf.format(Double.parseDouble(colval1))%>"
							onKeyPress="allowNegtiveNumber(this)"> 
							<%} else {%> 
							<input type="hidden" name="<%=col1%>" size="13"
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="0.00"> <%if (!strtype.trim().equals("H")) {%>
						<div align="right" style="width:75"><b><font 
							> <lapschoice:CurrencyTag name="calc1" size="13"
							style="color:#000000;border:none;font-color:#000000;text-align:right"
							value='<%=nf.format(Double.parseDouble(colval1))%>' other="disabled" /></font></b></div>
						<%}}%></td>
						<td width="13%" align="center">
						<%if (!strtype.trim().equals("C") && !strtype.trim().equals("H")) {%> 
						<input type="text" name="<%=col2%>" size="13"
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value='<%=nf.format(Double.parseDouble(colval2))%>'
							onKeyPress="allowNegtiveNumber(this)"> 
							<%} else {%> <input type="hidden" name="<%=col2%>" size="13"
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="0.00"> <%if (!strtype.trim().equals("H")) {%>
						<div align="right" style="width:75"><b><font 
							> <lapschoice:CurrencyTag name="calc2" size="13"
							style="color:#000000;border:none;font-color:#000000;text-align:right"
							value='<%=nf.format(Double.parseDouble(colval2))%>' other="disabled" /> </font></b></div>
						<%}}%></td>
						<td width="14%" align="center">
						<%if (!strtype.trim().equals("C") && !strtype.trim().equals("H")) {%> 
						<input type="text" name="<%=col3%>" size="13"
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value='<%=nf.format(Double.parseDouble(colval3))%>'
							onKeyPress="allowNegtiveNumber(this)"> 
							<%} else {%> <input type="hidden" name="<%=col3%>" size="13"
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="0.00"> <%if (!strtype.trim().equals("H")) {%>
						<div align="right" style="width:75"><b><font 
							> <lapschoice:CurrencyTag name="calc3" size="13"
							style="color:#000000;border:none;font-color:#000000;text-align:right"
							value="<%=nf.format(Double.parseDouble(colval3))%>" other="disabled" /></font></b></div>
						<%}}%></td>
						<td width="14%" align="center">
						<%if (!strtype.trim().equals("C") && !strtype.trim().equals("H")) {%> 
						<input type="text" name="<%=col4%>" size="13"
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=nf.format(Double.parseDouble(colval4))%>"
							onKeyPress="allowNegtiveNumber(this)"> 
							<%} else {%> <input type="hidden" name="<%=col4%>" size="13"
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="0.00"> <%if (!strtype.trim().equals("H")) {%>
						<div align="right" style="width:75"><b><font 
							> <lapschoice:CurrencyTag name="calc4" size="13"
							style="color:#000000;border:none;font-color:#000000;text-align:right"
							value="<%=nf.format(Double.parseDouble(colval4))%>" other="disabled" /></font></b></div>
						<%}}%></td>
						<td width="13%" align="center">
						<%if (!strtype.trim().equals("C") && !strtype.trim().equals("H")) {%> 
						<input type="text" name="<%=col5%>" size="13"
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=nf.format(Double.parseDouble(colval5))%>"
							onKeyPress="allowNegtiveNumber(this)"> <%} else {%> 
							<input type="hidden" name="<%=col5%>" size="13"
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="0.00"> <%if (!strtype.trim().equals("H")) {%>
						<div align="right" style="width:75"><b><font 
							> <lapschoice:CurrencyTag name="calc5" size="13"
							style="color:#000000;border:none;font-color:#000000;text-align:right"
							value="<%=nf.format(Double.parseDouble(colval5))%>" other="disabled" /> </font></b></div>
						<%}}%></td>
					</tr>
					<%}}%>
				</table>
				</td>
			</tr>
		</table>

<br>
<table border="1" cellspacing="0" cellpadding="0" align="center" class="outertable">
			<tr>
				
			<!--<td align="center"><input type="button" name="cmdchange" value="Add"
										class="buttonStyle" onClick="shownext('a')"></td>-->
										
										<td align="center"><input type="button" name="cmdchange" value="Change Financial"
										class="buttonStyle" onClick="changefinancial()"></td>
									<!-- 	<td align="center"><input type="button" name="cmdnewFinancial" value="Create New Financial"
										class="buttonStyle" onClick="doCreatenewFinancial()"></td> -->
										</tr>
										</table>
		<table border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
			<tr>
				<td> <%if ((Integer.parseInt(totcount) > 5) && (Integer.parseInt(fromnext) != 1)) {

			%> &lt;&lt; <a href="javascript:shownext('p')"><b>Previous</b></a>
				<%}

			%></td>
			<td align="center"><br>
			<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete_Calculate_Print_Download Excel Template" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
			</td>	
				<td align="right">&nbsp; <%int y1 = Integer.parseInt(totcount);

			if ((y1 > 4) && (Integer.parseInt(upto) != y1)) {

			%> <a href="javascript:shownext('n')"><b>Next</b></a>&gt;&gt; <%}%></td>
			</tr>			
		</table>
<input type="hidden" name="totvalue" value="<%=totcount%>"> 
<input type="hidden" name="uptovalue" value="<%=upto%>"> 
<input type="hidden" name="fromvalue" value="<%=Integer.parseInt(upto) + 1%>"> 
<INPUT TYPE="hidden" value="<%=pageval%>" name="pageval"> 
<INPUT TYPE="hidden" value="10" name="hidTotal"> 
<input type="hidden" name="otherGenTable"> 
<input type="hidden" name="hidPageName" value="financial.jsp"> 
<INPUT TYPE="hidden" name="hidAudit" value="<%=Helper.correctNull((String)hshValues.get("oldVal"))%>"> 
<input type="hidden" name="type1"> 
<input type="hidden" name="type2"> 
<input type="hidden" name="type3"> 
<input type="hidden" name="type4"> 

<INPUT TYPE="hidden" NAME="hidapppage">
<INPUT TYPE="hidden" NAME="hidfinanceid">
<INPUT TYPE="hidden" NAME="hidfinance">
<INPUT TYPE="hidden" NAME="hidcmasno">  
<input type="hidden" name="type5"> 
<INPUT TYPE="hidden" NAME="hidsel_divID"> 
<INPUT TYPE="hidden" NAME="hidfreeze_forexcel" value="<%=strfreeze_audit%>"> 
<input type="hidden" name="p_checkflag" value="<%=pflag%>"> 
<input type="hidden" name="BaseYearFlag" value="<%=base_year%>"> 
<input type="hidden" name="cattype" value="<%=strCategoryType%>"> 
<INPUT TYPE="hidden" name="fromnext" value="<%=Helper.correctNull((String)hshValues.get("from"))%>">
<input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
<INPUT TYPE="hidden" value = "<%=identity%>" name="identity">
<input type="hidden" name="fin_name" value="<%=Helper.correctNull((String)request.getParameter("comapp_compname"))%>">
<INPUT TYPE="hidden" name="hidppid" value="<%=Helper.correctNull((String)hshValues.get("finappid"))%>">
<INPUT TYPE="hidden" name="sel_proposalvaluesin" value="<%=Helper.correctNull((String)hshValues.get("strValuesin"))%>">
<lapschoice:hiddentag pageid="<%=PageId%>"/>
 <input type="hidden" name="old_txtyear1_start" value="<%=strYearStrt1 %>">
<input type="hidden" name="old_txtyear2_start" value="<%=strYearStrt2 %>">
<input type="hidden" name="old_txtyear3_start" value="<%=strYearStrt3 %>">
<input type="hidden" name="old_txtyear4_start" value="<%=strYearStrt4 %>"> 
<input type="hidden" name="old_txtyear5_start" value="<%=strYearStrt5 %>"> 
<input type="hidden" name="old_txtyear1" value="<%=strYear1 %>"> 
<input type="hidden" name="old_txtyear2" value="<%=strYear2 %>"> 
<input type="hidden"name="old_txtyear3" value="<%=strYear3 %>"> 
<input type="hidden" name="old_txtyear4" value="<%=strYear4 %>"> 
<input	type="hidden" name="old_txtyear5" value="<%=strYear5 %>"> 
<input type="hidden" name="old_combo1" value="<%=strFinType1 %>">
 <input type="hidden" name="old_combo2" value="<%=strFinType2 %>"> 
 <input	type="hidden" name="old_combo3" value="<%=strFinType3 %>"> 
<input type="hidden" name="old_combo4" value="<%=strFinType4 %>">
<input type="hidden" name="old_combo5" value="<%=strFinType5 %>"> 
<input	type="checkbox" name="old_ratingchk1" style="display: none;"> 
<input type="checkbox" name="old_ratingchk2" style="display: none;"> 
<input type="checkbox" name="old_ratingchk3" style="display: none;">
 <input type="checkbox" name="old_ratingchk4" style="display: none;"> 
 <input type="checkbox" name="old_ratingchk5" style="display: none;">
<input type="hidden" name="hidChangeFlag" value="N"> 
	  
</form>
</body>

<script>
	var tagFlag="<%=tagFlag%>";
	var strCurModule ="<%=strCurModule%>";

	function disableFields(val)
	{
		for(var i=0;i<document.forms[0].elements.length;i++)
		{
			if(document.forms[0].elements[i].type=="text")
			{
			  document.forms[0].elements[i].readOnly=val;		  
			}
			else if(document.forms[0].elements[i].type=="select-one")
			{
			  document.forms[0].elements[i].readOnly=val;		  
			}
		}

	//added for disabling the textbox and combo box
	if(tagFlag == strCurModule)
	{		
		document.forms[0].txtyear1.readOnly = false;
		document.forms[0].txtyear2.readOnly = false;
		document.forms[0].txtyear3.readOnly = false;
		document.forms[0].txtyear4.readOnly = false;
		document.forms[0].txtyear5.readOnly = false;
		document.forms[0].combo1.disabled=false;
		document.forms[0].combo3.disabled=false;
		document.forms[0].combo2.disabled=false;
		document.forms[0].combo4.disabled=false;
		document.forms[0].combo5.disabled=false;
	}
	else
	{
//		document.forms[0].fromvalue.value ="0";
		document.forms[0].txtyear1.readOnly = true;
		document.forms[0].txtyear2.readOnly = true;
		document.forms[0].txtyear3.readOnly = true;
		document.forms[0].txtyear4.readOnly = true;
		document.forms[0].txtyear5.readOnly = true;
		document.forms[0].combo1.disabled=true;
		document.forms[0].combo3.disabled=true;
		document.forms[0].combo2.disabled=true;
		document.forms[0].combo4.disabled=true;
		document.forms[0].combo5.disabled=true;
	}
	}
	</script>
</html>
