<%@include file="../share/directives.jsp"%>
<%@ page import="com.sai.laps.helper.*,java.util.*"%>
<%@ page import="com.sai.fw.management.utils.FwHelper"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<laps:handleerror />
<%
	String appstatus = Helper.correctNull((String) session
			.getAttribute("appstatus"));
	String strappno = Helper.correctNull((String) session
			.getAttribute("strappno"));
	String schemetype = Helper.correctNull((String) request.getParameter("schemetype"));
	String strAnimaltype =Helper.correctNull((String)hshValues.get("animaltype"));

	java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
	nf.setGroupingUsed(false);
	nf.setMaximumFractionDigits(2);
	nf.setMinimumFractionDigits(2);

	int iarrSize = 0,iarrHRDsize=0;
	ArrayList arrCol = new ArrayList();
	ArrayList arrRow = new ArrayList();
	ArrayList arrHerdProductionRow=new ArrayList();
	ArrayList arrHerdProductionCol=new ArrayList();
	
	if(hshValues!=null && hshValues.size()>0)
	{
		arrRow=(ArrayList)hshValues.get("arrRow");
		arrHerdProductionRow=(ArrayList)hshValues.get("arrHerdProductionRow");
	}	
	if(arrRow!=null && arrRow.size()>0)
	{
		iarrSize=arrRow.size();
	}
	if(arrHerdProductionRow!=null && arrHerdProductionRow.size()>0)
		iarrHRDsize=arrHerdProductionRow.size();
	
	String strDesc[] = { "No. of "+strAnimaltype+" in Batch A",
			"No.of Lactation Days in  Batch A",
			"Total Lactation Days in  Batch A",
			"No. of Dry Days in  Batch A",
			"Total Dry Days in  Batch A",
			"No. of "+strAnimaltype+" in Batch B",
			"No.of Lactation Days in  Batch B",
			"Total Lactation Days in  Batch B",
			"No. of Dry Days in  Batch B",
			"Total Dry Days in  Batch B",
			"Total Milk Yield @",
			"Sale Price of Milk @ Rs. ",
			"Sale Price of "+strAnimaltype+" @ Rs.",
			"Sale of Manure @ Rs.",
			"Total Income"};
	
	String strMilkYiedltr=Helper.correctDouble((String)hshValues.get("agr_yieldingltr"));
	String strMilkCost=Helper.correctDouble((String)hshValues.get("agr_findata_milkcost"));
	String strBuffaloesCost=Helper.correctDouble((String)hshValues.get("agr_findata_buffaloecost")) ;
	String strManureCost=Helper.correctDouble((String)hshValues.get("agr_findata_manurecost"));
	String strFacSNo=Helper.getfacilitySno(schemetype);
%>
<html>
<head>
<title>HERD PROJECTION CHART</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<Script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appstatus="<%=Helper.correctNull((String) request
							.getParameter("appstatus"))%>";
var varfirstbatch= "<%=Helper.correctNull((String) hshValues.get("agr_firstbatchanimal"))%>";
var schemetype="<%=schemetype%>";
function onloading()
{	  
	//document.forms[0].txt_year1[0].value=varfirstbatch;
	document.all.sel_scheme.disabled=false;
	document.all.sel_scheme.value=schemetype;
	if(appstatus=="Open/Pending")
	{
		if(document.forms[0].btnenable.value.toUpperCase()=="Y")
		{
	      disableCmdButtons(false, true, true, true, false);
		}
		else
		{
			disableCmdButtons(true, true, true, true, false);
		}
	}
	else
	{
		disableCmdButtons(true, true, true, true, false);
	}
	disabledFields(true);	
}
function doEdit()
{
	disabledFields(false);
	//document.forms[0].txt_year1[0].readOnly=true;
	<%for(int i=1;i<7;i++)
	{%>
		document.forms[0].txt_year<%=i%>[2].readOnly=true;
		document.forms[0].txt_year<%=i%>[4].readOnly=true;
		document.forms[0].txt_year<%=i%>[7].readOnly=true;
		document.forms[0].txt_year<%=i%>[9].readOnly=true;
		document.forms[0].txt_year<%=i%>[10].readOnly=true;
		document.forms[0].txt_year<%=i%>[11].readOnly=true;
		document.forms[0].txt_year<%=i%>[12].readOnly=true;
		document.forms[0].txt_year<%=i%>[13].readOnly=true;
		document.forms[0].txt_year<%=i%>[14].readOnly=true;
		document.forms[0].txt_year<%=i%>[1].readOnly=true;
		document.forms[0].txt_year<%=i%>[3].readOnly=true;
		document.forms[0].txt_year<%=i%>[6].readOnly=true;
		document.forms[0].txt_year<%=i%>[8].readOnly=true;
	<%}%>
	disableCmdButtons(true, false, false, false, true);	
}
function doSave()
{   

	if(document.forms[0].txt_cycledays.value=="")
	{
      alert("Enter Cycle Days");
      document.forms[0].txt_cycledays.focus();
      return false;
	}
	if(document.forms[0].txt_lacdays.value=="")
	{
      alert("Enter Lactation Days");
      document.forms[0].txt_lacdays.focus();
      return false;
	}
	if(document.forms[0].txt_batch2days.value=="")
	{
      alert("Enter Purchase of II Batch");
      document.forms[0].txt_batch2days.focus();
      return false;
	}
	disableCmdButtons(true, true, true, true, false);	
	document.forms[0].hidAction.value ="insert";
	document.forms[0].hidBeanId.value="agrnursery";
	document.forms[0].hidBeanMethod.value="updateDairyIncomeStatement";
	document.forms[0].hidBeanGetMethod.value="getDairyIncomeStatement";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/agr_dairyincomestatement.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();	
}
function doCancel()
{   
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanGetMethod.value="getDairyIncomeStatement";
		document.forms[0].hidBeanId.value="agrnursery";
		document.forms[0].action=appUrl+"action/agr_dairyincomestatement.jsp";
		document.forms[0].submit(); 		
	}
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appUrl+"action/ControllerServlet";	
		document.forms[0].hidBeanId.value="agrnursery";
		document.forms[0].hidSourceUrl.value="action/agr_dairyincomestatement.jsp";	
		document.forms[0].hidBeanMethod.value="updateDairyIncomeStatement";
		document.forms[0].hidBeanGetMethod.value="getDairyIncomeStatement";
		document.forms[0].submit();		
	}
}	
function calculateToatalAdult()
{
	var varmanurecost=<%=strManureCost%>;
	var varBuffaloesCost=<%=strBuffaloesCost%>;
	<%
		if(iarrHRDsize>0)
		{
			for(int i=0;i<1;i++)
			{
				arrHerdProductionCol=(ArrayList)arrHerdProductionRow.get(i);
				if(arrHerdProductionCol!=null && arrHerdProductionCol.size()>0)
				{
					for(int j=0;j<arrHerdProductionCol.size();j++)
					{
						int k=j+1;
					%>
						var varBatchA=NanNumber(parseFloat(document.forms[0].txt_year<%=k%>[0].value));
						var varBatchB=NanNumber(parseFloat(document.forms[0].txt_year<%=k%>[5].value));
						var vartotal=parseFloat(varBatchA)+parseFloat(varBatchB);
						if(<%=Helper.correctInt((String)arrHerdProductionCol.get(j))%><vartotal)
						{
							alert("The total animals of Year"+<%=k%>+" "+ "cannot exceed the Herd Production chart of Year"+<%=k%>);
							return;
						}
						document.forms[0].txt_year<%=k%>[13].value=NanNumber(parseFloat(vartotal)*parseFloat(varmanurecost));
						roundtxt(document.forms[0].txt_year<%=k%>[13]);
					<%}
				}
				arrHerdProductionCol=(ArrayList)arrHerdProductionRow.get(2);
				if(arrHerdProductionCol!=null && arrHerdProductionCol.size()>0)
				{
					for(int j=0;j<arrHerdProductionCol.size();j++)
					{
						int k=j+1;
					%>
						document.forms[0].txt_year<%=k%>[12].value=
							parseFloat(varBuffaloesCost)*<%=Helper.correctInt((String)arrHerdProductionCol.get(j))%>;
							roundtxt(document.forms[0].txt_year<%=k%>[12]);
					<%}
				}
			}
		}
	for(int i=1;i<7;i++)
	{%>
		var varlactdaysBatchA=NanNumber(parseFloat(document.forms[0].txt_year<%=i%>[1].value));
		var vardrydaysBatchA=NanNumber(parseFloat(document.forms[0].txt_year<%=i%>[3].value));
		var varTotaldaysBatchA=parseFloat(varlactdaysBatchA)+parseFloat(vardrydaysBatchA);
		var varlactdaysBatchB=NanNumber(parseFloat(document.forms[0].txt_year<%=i%>[1].value));
		var vardrydaysBatchB=NanNumber(parseFloat(document.forms[0].txt_year<%=i%>[3].value));
		var varTotaldaysBatchB=parseFloat(varlactdaysBatchB)+parseFloat(vardrydaysBatchB);
		if(varTotaldaysBatchA>365)
		{
			alert("Batch A Total of Lactation and Dry Days cannot greater than 365 in Year"+<%=i%>);
			return;
		}
		if(varTotaldaysBatchB>365)
		{
			alert("Batch B Total of Lactation and Dry Days cannot greater than 365 in Year"+<%=i%>);
			return;
		}
	<%}%>
	callcalculateLactdays();
	callcalculateTotalMilk();
}
function callcalculateLactdays()
{
	<%for(int i=1;i<7;i++)
	{%>
		var varBatchA=NanNumber(parseFloat(document.forms[0].txt_year<%=i%>[0].value));
		var varlactdaysBatchA=NanNumber(parseFloat(document.forms[0].txt_year<%=i%>[1].value));
		var vardrydaysBatchA=NanNumber(parseFloat(document.forms[0].txt_year<%=i%>[3].value));
		var varTotalLactdaysBatchA=parseFloat(varBatchA)*parseFloat(varlactdaysBatchA);
		var varTotalDrydaysBatchA=parseFloat(varBatchA)*parseFloat(vardrydaysBatchA);
		document.forms[0].txt_year<%=i%>[2].value=NanNumber(varTotalLactdaysBatchA);
		document.forms[0].txt_year<%=i%>[4].value=NanNumber(varTotalDrydaysBatchA);
		var varBatchB=NanNumber(parseFloat(document.forms[0].txt_year<%=i%>[5].value));
		var varlactdaysBatchB=NanNumber(parseFloat(document.forms[0].txt_year<%=i%>[6].value));
		var vardrydaysBatchB=NanNumber(parseFloat(document.forms[0].txt_year<%=i%>[8].value));
		var varTotalLactdaysBatchB=parseFloat(varBatchB)*parseFloat(varlactdaysBatchB);
		var varTotalDrydaysBatchB=parseFloat(varBatchB)*parseFloat(vardrydaysBatchB);
		document.forms[0].txt_year<%=i%>[7].value=NanNumber(varTotalLactdaysBatchB);
		document.forms[0].txt_year<%=i%>[9].value=NanNumber(varTotalDrydaysBatchB);
	<%}%>
}
function callcalculateTotalMilk()
{
	var varmilkltrperday=<%=strMilkYiedltr%>;
	var varmilkcost=<%=strMilkCost%>;
	<%for(int i=1;i<7;i++)
	{%>
		var varTotalLactdaysBatchA=NanNumber(parseFloat(document.forms[0].txt_year<%=i%>[2].value));
		var varTotalLactdaysBatchB=NanNumber(parseFloat(document.forms[0].txt_year<%=i%>[7].value));
		var varTotalMilkltr=parseFloat(parseFloat(varTotalLactdaysBatchA)+parseFloat(varTotalLactdaysBatchB))*parseFloat(varmilkltrperday);
		document.forms[0].txt_year<%=i%>[10].value=NanNumber(varTotalMilkltr);
		document.forms[0].txt_year<%=i%>[11].value=NanNumber(parseFloat(varTotalMilkltr)*parseFloat(varmilkcost));
		roundtxt(document.forms[0].txt_year<%=i%>[10]);
		roundtxt(document.forms[0].txt_year<%=i%>[11]);
		var varTotalIncome=0;
		varTotalIncome=parseFloat(document.forms[0].txt_year<%=i%>[11].value)+
			parseFloat(document.forms[0].txt_year<%=i%>[12].value)+
			parseFloat(document.forms[0].txt_year<%=i%>[13].value);	
		document.forms[0].txt_year<%=i%>[14].value=NanNumber(varTotalIncome);
		roundtxt(document.forms[0].txt_year<%=i%>[14]);
		<%}%>
}
function disableCmdButtons(bool1, bool2, bool3, bool4, bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
}
function disabledFields(one)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=one;
		}	  
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=one;
		}
	}
	document.forms[0].txt_drydays.readOnly=true;
	
}

function calDryDays()
{
 var varcDays=document.forms[0].txt_cycledays.value;
 var varLDays=document.forms[0].txt_lacdays.value;
 if(varcDays=="")
 {
	 varcDays=0;
 }
 if(varLDays=="")
 {
	 varLDays=0;
 }
 if(parseInt(varLDays)>parseInt(varcDays))
 {
  alert("Lactation Days can't be greater than Cycle Days");
  document.forms[0].txt_lacdays.value="0";
  document.forms[0].txt_lacdays.focus();
  return false;
 }

  document.forms[0].txt_drydays.value=parseInt(varcDays)-parseInt(varLDays); 	 
 
}

function calBatchCal()
{
	var varLDays=document.forms[0].txt_lacdays.value;
	var varDDays=document.forms[0].txt_drydays.value;
	var varB2days=document.forms[0].txt_batch2days.value;
	var v1=0,v2=0,v3=0,varLDaysTemp=0,v4=0,varDdaystemp=0;
	var vb1=0;
	var b=1;
	var y=1;
	var countFlag=""; 
	if(varLDays!="" && varDDays!="" && varDDays!="0" && varLDays!="0")
	{
    while(y<=6)
          {
              if(y==1)
              {
                  if(parseInt(varLDays)>=360)
                  {
                      document.forms[0].txt_year1[1].value="360";
                      document.forms[0].txt_year1[3].value="0";
                      countFlag="1";
                  }
                  else
                  {
                     document.forms[0].txt_year1[1].value=parseInt(varLDays);  
                     v1=360-parseInt(varLDays);
                     if(parseInt(v1)<=parseInt(varDDays))
                     {
                    	 document.forms[0].txt_year1[3].value=parseInt(v1);
                    	 v3=parseInt(varDDays)-parseInt(v1);
                    	 countFlag="D";
                    	 if(parseInt(varDDays)==parseInt(v1))
                    	 {
                           v3=0;
                           countFlag="L";
                    	 }
                     }
                     else
                     {
                    	 document.forms[0].txt_year1[3].value=parseInt(varDDays);
                    	 v2=parseInt(v1)-parseInt(varDDays);                      	
                    	 if(v2!=0)
                    	 {
                           if(parseInt(v2)<=parseInt(varLDays))
                           {
                        	   document.forms[0].txt_year1[1].value=parseInt(document.forms[0].txt_year1[1].value)+parseInt(v2);
                        	   v3=parseInt(varLDays)-parseInt(v2);
                        	   countFlag="L";
                        	   if(parseInt(v2)==parseInt(varLDays))
                        	   {
                        		   v3=0;
                                   countFlag="D"; 
                        	   }                        	   
                        	   
                           }
                           else
                           {
                        	   document.forms[0].txt_year1[1].value=parseInt(document.forms[0].txt_year1[1].value)+parseInt(varLDays);
                        	   v4=parseInt(v2)-parseInt(varLDays);
                        	   if(parseInt(v4)<=parseInt(varDDays))
                        	   {
                        		   document.forms[0].txt_year1[3].value=parseInt(document.forms[0].txt_year1[3].value)+parseInt(v4);
                        		   v3=parseInt(varDDays)-parseInt(v4);
                        		   countFlag="D";
                        		   if(parseInt(v4)==parseInt(varDDays))
                        		   {
                                      v3=0;
                                      countFlag="L";
                        		   }
                        		  
                        	   } 
                        	   else
                        	   {
                        		   document.forms[0].txt_year1[3].value=parseInt(document.forms[0].txt_year1[3].value)+parseInt(varDDays);
                        		   v3=parseInt(v4)-parseInt(varDDays);
                        		   countFlag="L";                  		                         		  
                        		                          		   
                        	   }                   
                           }
                           
                       	 }                  	 
                     }                                                       

                  }
              } 
              else if(y==2)
              {
                  if(v3!=0)
                  {
                      if(countFlag=="D")
                      {
                      document.forms[0].txt_year2[3].value=parseInt(v3);                      
                      var vtemp=360-parseInt(v3);                     
                      if(parseInt(varLDays)>=parseInt(vtemp))
                      {
                          document.forms[0].txt_year2[1].value=parseInt(vtemp);
                          v3=parseInt(varLDays)-parseInt(vtemp); 
                          countFlag="L"; 
                          if(parseInt(varLDays)==parseInt(vtemp))
                          {
                              v3=0;
                              countFlag="D";
                          } 
                                            
                      }
                      else
                      {
                         document.forms[0].txt_year2[1].value=parseInt(varLDays);  
                         v1=parseInt(vtemp)-parseInt(varLDays);
                         if(parseInt(v1)<=parseInt(varDDays))
                         {
                        	 document.forms[0].txt_year2[3].value=parseInt(document.forms[0].txt_year2[3].value)+parseInt(v1);
                        	 v3=parseInt(varDDays)-parseInt(v1);
                        	 countFlag="D";
                        	 if(parseInt(v1)==parseInt(varDDays))
                        	 {
                                v3=0;
                                countFlag="L";
                        	 }
                         }
                         else
                         {
                        	 document.forms[0].txt_year2[3].value=parseInt(document.forms[0].txt_year2[3].value)+parseInt(varDDays);
                        	 v2=parseInt(v1)-parseInt(varDDays);                         	                         	
                        	 if(v2!=0)
                        	 {
                               if(v2<=varLDays)
                               {
                            	   document.forms[0].txt_year2[1].value=parseInt(document.forms[0].txt_year2[1].value)+parseInt(v2);
                            	   v3=parseInt(varLDays)-parseInt(v2);
                            	   countFlag="L";
                            	   if(parseInt(varLDays)==parseInt(v2))
                            	   {
                                    v3=0;
                                    countFlag="D";                                     
                            	   }
                            	   
                               }
                               else
                               {
                            	   document.forms[0].txt_year2[1].value=parseInt(document.forms[0].txt_year2[1].value)+parseInt(varLDays);
                            	   v3=parseInt(v2)-parseInt(varLDays);
                            	   countFlag="D";                            	   

                               }
                           	 }                  	 
                         }                                                       

                      }
                      } 
                      else if(countFlag=="L")
                      {
                      document.forms[0].txt_year2[1].value=parseInt(v3);                     
                      var vtemp=360-parseInt(v3);                    
                      if(parseInt(varDDays)>=parseInt(vtemp))
                      {
                          document.forms[0].txt_year2[3].value=parseInt(vtemp);                        
                          v3=parseInt(varDDays)-parseInt(vtemp); 
                          countFlag="D";   
                          if(parseInt(varDDays)==parseInt(vtemp))
                          {
                              v3=0;
                              countFlag="L"; 
                          }                   
                      }
                      else
                      {
                         document.forms[0].txt_year2[3].value=parseInt(varDDays);  
                         v1=parseInt(vtemp)-parseInt(varDDays);
                         if(parseInt(v1)<=parseInt(varLDays))
                         {
                        	 document.forms[0].txt_year2[1].value=parseInt(document.forms[0].txt_year2[1].value)+parseInt(v1);
                        	 v3=parseInt(varLDays)-parseInt(v1);
                        	 countFlag="L";
                        	 if(parseInt(varLDays)==parseInt(v1))
                        	 {
                        		 countFlag="D";
                        		 v3=0;
                        	 }
                         }
                         else
                         {
                        	 document.forms[0].txt_year2[1].value=parseInt(document.forms[0].txt_year2[1].value)+parseInt(varLDays);
                        	 v2=parseInt(v1)-parseInt(varLDays);                         	
                        	 if(v2!=0)
                        	 {
                               if(parseInt(v2)<=parseInt(varDDays))
                               {
                            	   document.forms[0].txt_year2[3].value=parseInt(document.forms[0].txt_year2[3].value)+parseInt(v2);
                            	   v3=parseInt(varDDays)-parseInt(v2);
                            	   countFlag="D";
                            	   if(parseInt(v2)==parseInt(varDDays))
                            	   {
                            		   countFlag="L"; 
                            		   v3=0;
                            	   }                            	   
                               }
                               else
                               {
                            	   document.forms[0].txt_year2[3].value=parseInt(document.forms[0].txt_year2[3].value)+parseInt(varDDays);
                            	   v3=parseInt(v2)-parseInt(varDDays);
                            	   countFlag="L";    	   
                            	   

                               }
                           	 }                  	 
                         }                                                       

                      }
                      }                                               

                  }
                  else
                  {
                      if(countFlag=="L")
                      {
                      if(parseInt(varLDays)>=360)
                      {
                          document.forms[0].txt_year2[1].value="360";
                          document.forms[0].txt_year2[3].value="0";
                          countFlag="L";
                      }
                      else
                      {
                         document.forms[0].txt_year2[1].value=parseInt(varLDays);  
                         v1=360-parseInt(varLDays);
                         if(parseInt(v1)<=parseInt(varDDays))
                         {
                        	 document.forms[0].txt_year2[3].value=parseInt(v1);
                        	 v3=parseInt(varDDays)-parseInt(v1);
                        	 countFlag="D";
                        	 if(parseInt(varDDays)==parseInt(v1))
                        	 {
                        		 countFlag="L";
                        		 v3=0;
                        	 }
                         }
                         else
                         {
                        	 document.forms[0].txt_year2[3].value=parseInt(varDDays);
                        	 v2=parseInt(v1)-parseInt(varDDays);                         
                        	 if(v2!=0)
                        	 {
                               if(parseInt(v2)<=parseInt(varLDays))
                               {
                            	   document.forms[0].txt_year2[1].value=parseInt(document.forms[0].txt_year2[1].value)+parseInt(v2);
                            	   v3=parseInt(varLDays)-parseInt(v2);
                            	   countFlag="L";
                            	   if(parseInt(varLDays)==parseInt(v2))
                            	   {
                            		   countFlag="D";
                            		   v3=0;
                            	   }                      	   
                               }
                               else
                               {
                            	   document.forms[0].txt_year2[1].value=parseInt(document.forms[0].txt_year2[1].value)+parseInt(varLDays);
                            	   v4=parseInt(v2)-parseInt(varLDays);
                            	   if(parseInt(v4)<=parseInt(varDDays))
                            	   {
                            		   document.forms[0].txt_year2[3].value=parseInt(document.forms[0].txt_year2[3].value)+parseInt(v4);
                            		   v3=parseInt(varDDays)-parseInt(v4);
                            		   countFlag="D";
                            		   if(parseInt(varDDays)==parseInt(v4))
                            		   {
                                         v3=0;
                                         countFlag="L";
                            		   }
                            		   
                            	   } 
                            	   else
                            	   {
                            		   document.forms[0].txt_year2[3].value=parseInt(document.forms[0].txt_year2[3].value)+parseInt(varDDays);
                            		   v3=parseInt(v4)-parseInt(varDDays); 
                            		   countFlag="L";                      		   
                            	   }                   
                               }
                               
                           	 }                  	 
                         }                                                       

                      }
                      }
                      else if(countFlag=="D")
                      {

                    	  if(parseInt(varDDays)>=360)
                          {
                              document.forms[0].txt_year2[3].value="360";
                              document.forms[0].txt_year2[1].value="0";
                              countFlag="D";
                          }
                          else
                          {
                             document.forms[0].txt_year2[3].value=parseInt(varDDays);  
                             v1=360-parseInt(varDDays);
                             if(parseInt(v1)<=parseInt(varLDays))
                             {
                            	 document.forms[0].txt_year2[1].value=parseInt(v1);
                            	 v3=parseInt(varLDays)-parseInt(v1);
                            	 countFlag="L";
                            	 if(parseInt(varLDays)==parseInt(v1))
                            	 {
                            		 countFlag="D";
                            		 v3=0;
                            	 }
                             }
                             else
                             {
                            	 document.forms[0].txt_year2[1].value=parseInt(varLDays);
                            	 v2=parseInt(v1)-parseInt(varLDays);                         
                            	 if(v2!=0)
                            	 {
                                   if(parseInt(v2)<=parseInt(varDDays))
                                   {
                                	   document.forms[0].txt_year2[3].value=parseInt(document.forms[0].txt_year2[3].value)+parseInt(v2);
                                	   v3=parseInt(varDDays)-parseInt(v2);
                                	   countFlag="D";
                                	   if(parseInt(varDDays)==parseInt(v2))
                                	   {
                                		   countFlag="L";
                                		   v3=0;
                                	   }                      	   
                                   }
                                   else
                                   {
                                	   document.forms[0].txt_year2[3].value=parseInt(document.forms[0].txt_year2[3].value)+parseInt(varDDays);
                                	   v4=parseInt(v2)-parseInt(varDDays);
                                	   if(parseInt(v4)<=parseInt(varLDays))
                                	   {
                                		   document.forms[0].txt_year2[1].value=parseInt(document.forms[0].txt_year2[1].value)+parseInt(v4);
                                		   v3=parseInt(varLDays)-parseInt(v4);
                                		   countFlag="L";
                                		   if(parseInt(varLDays)==parseInt(v4))
                                		   {
                                             v3=0;
                                             countFlag="D";
                                		   }
                                		   
                                	   } 
                                	   else
                                	   {
                                		   document.forms[0].txt_year2[1].value=parseInt(document.forms[0].txt_year2[1].value)+parseInt(varLDays);
                                		   v3=parseInt(v4)-parseInt(varLDays); 
                                		   countFlag="D";                      		   
                                	   }                   
                                   }
                                   
                               	 }                  	 
                             }                                                       

                          }

                      }
                }    

              } 
              else if(y==3)
              {
                  if(v3!=0)
                  {
                      if(countFlag=="D")
                      {
                      document.forms[0].txt_year3[3].value=parseInt(v3);                      
                      var vtemp=360-parseInt(v3);                     
                      if(parseInt(varLDays)>=parseInt(vtemp))
                      {
                          document.forms[0].txt_year3[1].value=parseInt(vtemp);                      
                          v3=parseInt(varLDays)-parseInt(vtemp); 
                          countFlag="L";    
                          if(parseInt(varLDays)==parseInt(vtemp))
                          {
                              v3=0;
                              countFlag="D";
                          }                  
                      }
                      else
                      {
                         document.forms[0].txt_year3[1].value=parseInt(varLDays);  
                         v1=parseInt(vtemp)-parseInt(varLDays);
                         if(parseInt(v1)<=parseInt(varDDays))
                         {
                        	 document.forms[0].txt_year3[3].value=parseInt(document.forms[0].txt_year3[3].value)+parseInt(v1);
                        	 v3=parseInt(varDDays)-parseInt(v1);
                        	 countFlag="D";
                        	 if(parseInt(v1)==parseInt(varDDays))
                        	 {
                                v3=0;
                                countFlag="L";
                        	 }
                         }
                         else
                         {
                        	 document.forms[0].txt_year3[3].value=parseInt(document.forms[0].txt_year3[3].value)+parseInt(varDDays);
                        	 v2=parseInt(v1)-parseInt(varDDays);                         	                         	
                        	 if(v2!=0)
                        	 {
                               if(v2<=varLDays)
                               {
                            	   document.forms[0].txt_year3[1].value=parseInt(document.forms[0].txt_year3[1].value)+parseInt(v2);
                            	   v3=parseInt(varLDays)-parseInt(v2);
                            	   countFlag="L";
                            	   if(parseInt(varLDays)==parseInt(v2))
                            	   {
                                    v3=0;
                                    countFlag="D";                                     
                            	   }
                            	   
                               }
                               else
                               {
                            	   document.forms[0].txt_year3[1].value=parseInt(document.forms[0].txt_year3[1].value)+parseInt(varLDays);
                            	   v3=parseInt(v2)-parseInt(varLDays);
                            	   countFlag="D";                            	   

                               }
                           	 }                  	 
                         }                                                       

                      }
                      } 
                      else if(countFlag=="L")
                      {
                      document.forms[0].txt_year3[1].value=parseInt(v3);                     
                      var vtemp=360-parseInt(v3);                    
                      if(parseInt(varDDays)>=parseInt(vtemp))
                      {
                          document.forms[0].txt_year3[3].value=parseInt(vtemp);                        
                          v3=parseInt(varDDays)-parseInt(vtemp); 
                          countFlag="D";  
                          if(parseInt(varDDays)==parseInt(vtemp))
                          {
                              v3=0;
                              countFlag="L"; 
                          }                    
                      }
                      else
                      {
                         document.forms[0].txt_year3[3].value=parseInt(varDDays);  
                         v1=parseInt(vtemp)-parseInt(varDDays);
                         if(parseInt(v1)<=parseInt(varLDays))
                         {
                        	 document.forms[0].txt_year3[1].value=parseInt(document.forms[0].txt_year3[1].value)+parseInt(v1);
                        	 v3=parseInt(varLDays)-parseInt(v1);
                        	 countFlag="L";
                        	 if(parseInt(varLDays)==parseInt(v1))
                        	 {
                        		 countFlag="D";
                        		 v3=0;
                        	 }
                         }
                         else
                         {
                        	 document.forms[0].txt_year3[1].value=parseInt(document.forms[0].txt_year3[1].value)+parseInt(varLDays);
                        	 v2=parseInt(v1)-parseInt(varLDays);                         	
                        	 if(v2!=0)
                        	 {
                               if(parseInt(v2)<=parseInt(varDDays))
                               {
                            	   document.forms[0].txt_year3[3].value=parseInt(document.forms[0].txt_year3[3].value)+parseInt(v2);
                            	   v3=parseInt(varDDays)-parseInt(v2);
                            	   countFlag="D";
                            	   if(parseInt(v2)==parseInt(varDDays))
                            	   {
                            		   countFlag="L"; 
                            		   v3=0;
                            	   }                            	   
                               }
                               else
                               {
                            	   document.forms[0].txt_year3[3].value=parseInt(document.forms[0].txt_year3[3].value)+parseInt(varDDays);
                            	   v3=parseInt(v2)-parseInt(varDDays);
                            	   countFlag="L";    	   
                            	   

                               }
                           	 }                  	 
                         }                                                       

                      }
                      }                                               

                  }
                  else
                  {
                      if(countFlag=="L")
                      {
                      if(parseInt(varLDays)>=360)
                      {
                          document.forms[0].txt_year3[1].value="360";
                          document.forms[0].txt_year3[3].value="0";
                          countFlag="L";
                      }
                      else
                      {
                         document.forms[0].txt_year3[1].value=parseInt(varLDays);  
                         v1=360-parseInt(varLDays);
                         if(parseInt(v1)<=parseInt(varDDays))
                         {
                        	 document.forms[0].txt_year3[3].value=parseInt(v1);
                        	 v3=parseInt(varDDays)-parseInt(v1);
                        	 countFlag="D";
                        	 if(parseInt(varDDays)==parseInt(v1))
                        	 {
                        		 countFlag="L";
                        		 v3=0;
                        	 }
                         }
                         else
                         {
                        	 document.forms[0].txt_year3[3].value=parseInt(varDDays);
                        	 v2=parseInt(v1)-parseInt(varDDays);                         
                        	 if(v2!=0)
                        	 {
                               if(parseInt(v2)<=parseInt(varLDays))
                               {
                            	   document.forms[0].txt_year3[1].value=parseInt(document.forms[0].txt_year3[1].value)+parseInt(v2);
                            	   v3=parseInt(varLDays)-parseInt(v2);
                            	   countFlag="L";
                            	   if(parseInt(varLDays)==parseInt(v2))
                            	   {
                            		   countFlag="D";
                            		   v3=0;
                            	   }                      	   
                               }
                               else
                               {
                            	   document.forms[0].txt_year3[1].value=parseInt(document.forms[0].txt_year3[1].value)+parseInt(varLDays);
                            	   v4=parseInt(v2)-parseInt(varLDays);
                            	   if(parseInt(v4)<=parseInt(varDDays))
                            	   {
                            		   document.forms[0].txt_year3[3].value=parseInt(document.forms[0].txt_year3[3].value)+parseInt(v4);
                            		   v3=parseInt(varDDays)-parseInt(v4);
                            		   countFlag="D";
                            		   if(parseInt(varDDays)==parseInt(v4))
                            		   {
                                         v3=0;
                                         countFlag="L";
                            		   }
                            		   
                            	   } 
                            	   else
                            	   {
                            		   document.forms[0].txt_year3[3].value=parseInt(document.forms[0].txt_year3[3].value)+parseInt(varDDays);
                            		   v3=parseInt(v4)-parseInt(varDDays); 
                            		   countFlag="L";                      		   
                            	   }                   
                               }
                               
                           	 }                  	 
                         }                                                       

                      }
                      }
                      else if(countFlag=="D")
                      {

                    	  if(parseInt(varDDays)>=360)
                          {
                              document.forms[0].txt_year3[3].value="360";
                              document.forms[0].txt_year3[1].value="0";
                              countFlag="D";
                          }
                          else
                          {
                             document.forms[0].txt_year3[3].value=parseInt(varDDays);  
                             v1=360-parseInt(varDDays);
                             if(parseInt(v1)<=parseInt(varLDays))
                             {
                            	 document.forms[0].txt_year3[1].value=parseInt(v1);
                            	 v3=parseInt(varLDays)-parseInt(v1);
                            	 countFlag="L";
                            	 if(parseInt(varLDays)==parseInt(v1))
                            	 {
                            		 countFlag="D";
                            		 v3=0;
                            	 }
                             }
                             else
                             {
                            	 document.forms[0].txt_year3[1].value=parseInt(varLDays);
                            	 v2=parseInt(v1)-parseInt(varLDays);                         
                            	 if(v2!=0)
                            	 {
                                   if(parseInt(v2)<=parseInt(varDDays))
                                   {
                                	   document.forms[0].txt_year3[3].value=parseInt(document.forms[0].txt_year3[3].value)+parseInt(v2);
                                	   v3=parseInt(varDDays)-parseInt(v2);
                                	   countFlag="D";
                                	   if(parseInt(varDDays)==parseInt(v2))
                                	   {
                                		   countFlag="L";
                                		   v3=0;
                                	   }                      	   
                                   }
                                   else
                                   {
                                	   document.forms[0].txt_year3[3].value=parseInt(document.forms[0].txt_year3[3].value)+parseInt(varDDays);
                                	   v4=parseInt(v2)-parseInt(varDDays);
                                	   if(parseInt(v4)<=parseInt(varLDays))
                                	   {
                                		   document.forms[0].txt_year3[1].value=parseInt(document.forms[0].txt_year3[1].value)+parseInt(v4);
                                		   v3=parseInt(varLDays)-parseInt(v4);
                                		   countFlag="L";
                                		   if(parseInt(varLDays)==parseInt(v4))
                                		   {
                                             v3=0;
                                             countFlag="D";
                                		   }
                                		   
                                	   } 
                                	   else
                                	   {
                                		   document.forms[0].txt_year3[1].value=parseInt(document.forms[0].txt_year3[1].value)+parseInt(varLDays);
                                		   v3=parseInt(v4)-parseInt(varLDays); 
                                		   countFlag="D";                      		   
                                	   }                   
                                   }
                                   
                               	 }                  	 
                             }                                                       

                          }

                      }
                }    

              } 

              else if(y==4)
              {
                  if(v3!=0)
                  {
                      if(countFlag=="D")
                      {
                      document.forms[0].txt_year4[3].value=parseInt(v3);                      
                      var vtemp=360-parseInt(v3);                     
                      if(parseInt(varLDays)>=parseInt(vtemp))
                      {
                          document.forms[0].txt_year4[1].value=parseInt(vtemp);                        
                          v3=parseInt(varLDays)-parseInt(vtemp); 
                          countFlag="L";
                          if(parseInt(varLDays)==parseInt(vtemp))
                          {
                              v3=0;
                              countFlag="D";
                          }                     
                      }
                      else
                      {
                         document.forms[0].txt_year4[1].value=parseInt(varLDays);  
                         v1=parseInt(vtemp)-parseInt(varLDays);
                         if(parseInt(v1)<=parseInt(varDDays))
                         {
                        	 document.forms[0].txt_year4[3].value=parseInt(document.forms[0].txt_year4[3].value)+parseInt(v1);
                        	 v3=parseInt(varDDays)-parseInt(v1);
                        	 countFlag="D";
                        	 if(parseInt(v1)==parseInt(varDDays))
                        	 {
                                v3=0;
                                countFlag="L";
                        	 }
                         }
                         else
                         {
                        	 document.forms[0].txt_year4[3].value=parseInt(document.forms[0].txt_year4[3].value)+parseInt(varDDays);
                        	 v2=parseInt(v1)-parseInt(varDDays);                         	                         	
                        	 if(v2!=0)
                        	 {
                               if(v2<=varLDays)
                               {
                            	   document.forms[0].txt_year4[1].value=parseInt(document.forms[0].txt_year4[1].value)+parseInt(v2);
                            	   v3=parseInt(varLDays)-parseInt(v2);
                            	   countFlag="L";
                            	   if(parseInt(varLDays)==parseInt(v2))
                            	   {
                                    v3=0;
                                    countFlag="D";                                     
                            	   }
                            	   
                               }
                               else
                               {
                            	   document.forms[0].txt_year4[1].value=parseInt(document.forms[0].txt_year4[1].value)+parseInt(varLDays);
                            	   v3=parseInt(v2)-parseInt(varLDays);
                            	   countFlag="D";                            	   

                               }
                           	 }                  	 
                         }                                                       

                      }
                      } 
                      else if(countFlag=="L")
                      {
                      document.forms[0].txt_year4[1].value=parseInt(v3);                     
                      var vtemp=360-parseInt(v3);                    
                      if(parseInt(varDDays)>=parseInt(vtemp))
                      {
                          document.forms[0].txt_year4[3].value=parseInt(vtemp);                      
                          v3=parseInt(varDDays)-parseInt(vtemp); 
                          countFlag="D";   
                          if(parseInt(varDDays)==parseInt(vtemp))
                          {
                              v3=0;
                              countFlag="L"; 
                          }                   
                      }
                      else
                      {
                         document.forms[0].txt_year4[3].value=parseInt(varDDays);  
                         v1=parseInt(vtemp)-parseInt(varDDays);
                         if(parseInt(v1)<=parseInt(varLDays))
                         {
                        	 document.forms[0].txt_year4[1].value=parseInt(document.forms[0].txt_year4[1].value)+parseInt(v1);
                        	 v3=parseInt(varLDays)-parseInt(v1);
                        	 countFlag="L";
                        	 if(parseInt(varLDays)==parseInt(v1))
                        	 {
                        		 countFlag="D";
                        		 v3=0;
                        	 }
                         }
                         else
                         {
                        	 document.forms[0].txt_year4[1].value=parseInt(document.forms[0].txt_year4[1].value)+parseInt(varLDays);
                        	 v2=parseInt(v1)-parseInt(varLDays);                         	
                        	 if(v2!=0)
                        	 {
                               if(parseInt(v2)<=parseInt(varDDays))
                               {
                            	   document.forms[0].txt_year4[3].value=parseInt(document.forms[0].txt_year4[3].value)+parseInt(v2);
                            	   v3=parseInt(varDDays)-parseInt(v2);
                            	   countFlag="D";
                            	   if(parseInt(v2)==parseInt(varDDays))
                            	   {
                            		   countFlag="L"; 
                            		   v3=0;
                            	   }                            	   
                               }
                               else
                               {
                            	   document.forms[0].txt_year4[3].value=parseInt(document.forms[0].txt_year4[3].value)+parseInt(varDDays);
                            	   v3=parseInt(v2)-parseInt(varDDays);
                            	   countFlag="L";    	   
                            	   

                               }
                           	 }                  	 
                         }                                                       

                      }
                      }                                               

                  }
                  else
                  {
                      if(countFlag=="L")
                      {
                      if(parseInt(varLDays)>=360)
                      {
                          document.forms[0].txt_year4[1].value="360";
                          document.forms[0].txt_year4[3].value="0";
                          countFlag="L";
                      }
                      else
                      {
                         document.forms[0].txt_year4[1].value=parseInt(varLDays);  
                         v1=360-parseInt(varLDays);
                         if(parseInt(v1)<=parseInt(varDDays))
                         {
                        	 document.forms[0].txt_year4[3].value=parseInt(v1);
                        	 v3=parseInt(varDDays)-parseInt(v1);
                        	 countFlag="D";
                        	 if(parseInt(varDDays)==parseInt(v1))
                        	 {
                        		 countFlag="L";
                        		 v3=0;
                        	 }
                         }
                         else
                         {
                        	 document.forms[0].txt_year4[3].value=parseInt(varDDays);
                        	 v2=parseInt(v1)-parseInt(varDDays);                         
                        	 if(v2!=0)
                        	 {
                               if(parseInt(v2)<=parseInt(varLDays))
                               {
                            	   document.forms[0].txt_year4[1].value=parseInt(document.forms[0].txt_year4[1].value)+parseInt(v2);
                            	   v3=parseInt(varLDays)-parseInt(v2);
                            	   countFlag="L";
                            	   if(parseInt(varLDays)==parseInt(v2))
                            	   {
                            		   countFlag="D";
                            		   v3=0;
                            	   }                      	   
                               }
                               else
                               {
                            	   document.forms[0].txt_year4[1].value=parseInt(document.forms[0].txt_year4[1].value)+parseInt(varLDays);
                            	   v4=parseInt(v2)-parseInt(varLDays);
                            	   if(parseInt(v4)<=parseInt(varDDays))
                            	   {
                            		   document.forms[0].txt_year4[3].value=parseInt(document.forms[0].txt_year4[3].value)+parseInt(v4);
                            		   v3=parseInt(varDDays)-parseInt(v4);
                            		   countFlag="D";
                            		   if(parseInt(varDDays)==parseInt(v4))
                            		   {
                                         v3=0;
                                         countFlag="L";
                            		   }
                            		   
                            	   } 
                            	   else
                            	   {
                            		   document.forms[0].txt_year4[3].value=parseInt(document.forms[0].txt_year4[3].value)+parseInt(varDDays);
                            		   v3=parseInt(v4)-parseInt(varDDays); 
                            		   countFlag="L";                      		   
                            	   }                   
                               }
                               
                           	 }                  	 
                         }                                                       

                      }
                      }
                      else if(countFlag=="D")
                      {

                    	  if(parseInt(varDDays)>=360)
                          {
                              document.forms[0].txt_year4[3].value="360";
                              document.forms[0].txt_year4[1].value="0";
                              countFlag="D";
                          }
                          else
                          {
                             document.forms[0].txt_year4[3].value=parseInt(varDDays);  
                             v1=360-parseInt(varDDays);
                             if(parseInt(v1)<=parseInt(varLDays))
                             {
                            	 document.forms[0].txt_year4[1].value=parseInt(v1);
                            	 v3=parseInt(varLDays)-parseInt(v1);
                            	 countFlag="L";
                            	 if(parseInt(varLDays)==parseInt(v1))
                            	 {
                            		 countFlag="D";
                            		 v3=0;
                            	 }
                             }
                             else
                             {
                            	 document.forms[0].txt_year4[1].value=parseInt(varLDays);
                            	 v2=parseInt(v1)-parseInt(varLDays);                         
                            	 if(v2!=0)
                            	 {
                                   if(parseInt(v2)<=parseInt(varDDays))
                                   {
                                	   document.forms[0].txt_year4[3].value=parseInt(document.forms[0].txt_year4[3].value)+parseInt(v2);
                                	   v3=parseInt(varDDays)-parseInt(v2);
                                	   countFlag="D";
                                	   if(parseInt(varDDays)==parseInt(v2))
                                	   {
                                		   countFlag="L";
                                		   v3=0;
                                	   }                      	   
                                   }
                                   else
                                   {
                                	   document.forms[0].txt_year4[3].value=parseInt(document.forms[0].txt_year4[3].value)+parseInt(varDDays);
                                	   v4=parseInt(v2)-parseInt(varDDays);
                                	   if(parseInt(v4)<=parseInt(varLDays))
                                	   {
                                		   document.forms[0].txt_year4[1].value=parseInt(document.forms[0].txt_year4[1].value)+parseInt(v4);
                                		   v3=parseInt(varLDays)-parseInt(v4);
                                		   countFlag="L";
                                		   if(parseInt(varLDays)==parseInt(v4))
                                		   {
                                             v3=0;
                                             countFlag="D";
                                		   }
                                		   
                                	   } 
                                	   else
                                	   {
                                		   document.forms[0].txt_year4[1].value=parseInt(document.forms[0].txt_year4[1].value)+parseInt(varLDays);
                                		   v3=parseInt(v4)-parseInt(varLDays); 
                                		   countFlag="D";                      		   
                                	   }                   
                                   }
                                   
                               	 }                  	 
                             }                                                       

                          }

                      }
                }    

              } 

              else if(y==5)
              {
                  if(v3!=0)
                  {
                      if(countFlag=="D")
                      {
                      document.forms[0].txt_year5[3].value=parseInt(v3);                      
                      var vtemp=360-parseInt(v3);                     
                      if(parseInt(varLDays)>=parseInt(vtemp))
                      {
                          document.forms[0].txt_year5[1].value=parseInt(vtemp);                         
                          v3=parseInt(varLDays)-parseInt(vtemp); 
                          countFlag="L";     
                          if(parseInt(varLDays)==parseInt(vtemp))
                          {
                              v3=0;
                              countFlag="D";
                          }                 
                      }
                      else
                      {
                         document.forms[0].txt_year5[1].value=parseInt(varLDays);  
                         v1=parseInt(vtemp)-parseInt(varLDays);
                         if(parseInt(v1)<=parseInt(varDDays))
                         {
                        	 document.forms[0].txt_year5[3].value=parseInt(document.forms[0].txt_year5[3].value)+parseInt(v1);
                        	 v3=parseInt(varDDays)-parseInt(v1);
                        	 countFlag="D";
                        	 if(parseInt(v1)==parseInt(varDDays))
                        	 {
                                v3=0;
                                countFlag="L";
                        	 }
                         }
                         else
                         {
                        	 document.forms[0].txt_year5[3].value=parseInt(document.forms[0].txt_year5[3].value)+parseInt(varDDays);
                        	 v2=parseInt(v1)-parseInt(varDDays);                         	                         	
                        	 if(v2!=0)
                        	 {
                               if(v2<=varLDays)
                               {
                            	   document.forms[0].txt_year5[1].value=parseInt(document.forms[0].txt_year5[1].value)+parseInt(v2);
                            	   v3=parseInt(varLDays)-parseInt(v2);
                            	   countFlag="L";
                            	   if(parseInt(varLDays)==parseInt(v2))
                            	   {
                                    v3=0;
                                    countFlag="D";                                     
                            	   }
                            	   
                               }
                               else
                               {
                            	   document.forms[0].txt_year5[1].value=parseInt(document.forms[0].txt_year5[1].value)+parseInt(varLDays);
                            	   v3=parseInt(v2)-parseInt(varLDays);
                            	   countFlag="D";                            	   

                               }
                           	 }                  	 
                         }                                                       

                      }
                      } 
                      else if(countFlag=="L")
                      {
                      document.forms[0].txt_year5[1].value=parseInt(v3);                     
                      var vtemp=360-parseInt(v3);                    
                      if(parseInt(varDDays)>=parseInt(vtemp))
                      {
                          document.forms[0].txt_year5[3].value=parseInt(vtemp);                       
                          v3=parseInt(varDDays)-parseInt(vtemp); 
                          countFlag="D";  
                          if(parseInt(varDDays)==parseInt(vtemp))
                          {
                              v3=0;
                              countFlag="L"; 
                          }                    
                      }
                      else
                      {
                         document.forms[0].txt_year5[3].value=parseInt(varDDays);  
                         v1=parseInt(vtemp)-parseInt(varDDays);
                         if(parseInt(v1)<=parseInt(varLDays))
                         {
                        	 document.forms[0].txt_year5[1].value=parseInt(document.forms[0].txt_year5[1].value)+parseInt(v1);
                        	 v3=parseInt(varLDays)-parseInt(v1);
                        	 countFlag="L";
                        	 if(parseInt(varLDays)==parseInt(v1))
                        	 {
                        		 countFlag="D";
                        		 v3=0;
                        	 }
                         }
                         else
                         {
                        	 document.forms[0].txt_year5[1].value=parseInt(document.forms[0].txt_year5[1].value)+parseInt(varLDays);
                        	 v2=parseInt(v1)-parseInt(varLDays);                         	
                        	 if(v2!=0)
                        	 {
                               if(parseInt(v2)<=parseInt(varDDays))
                               {
                            	   document.forms[0].txt_year5[3].value=parseInt(document.forms[0].txt_year5[3].value)+parseInt(v2);
                            	   v3=parseInt(varDDays)-parseInt(v2);
                            	   countFlag="D";
                            	   if(parseInt(v2)==parseInt(varDDays))
                            	   {
                            		   countFlag="L"; 
                            		   v3=0;
                            	   }                            	   
                               }
                               else
                               {
                            	   document.forms[0].txt_year5[3].value=parseInt(document.forms[0].txt_year5[3].value)+parseInt(varDDays);
                            	   v3=parseInt(v2)-parseInt(varDDays);
                            	   countFlag="L";    	   
                            	   

                               }
                           	 }                  	 
                         }                                                       

                      }
                      }                                               

                  }
                  else
                  {
                      if(countFlag=="L")
                      {
                      if(parseInt(varLDays)>=360)
                      {
                          document.forms[0].txt_year5[1].value="360";
                          document.forms[0].txt_year5[3].value="0";
                          countFlag="L";
                      }
                      else
                      {
                         document.forms[0].txt_year5[1].value=parseInt(varLDays);  
                         v1=360-parseInt(varLDays);
                         if(parseInt(v1)<=parseInt(varDDays))
                         {
                        	 document.forms[0].txt_year5[3].value=parseInt(v1);
                        	 v3=parseInt(varDDays)-parseInt(v1);
                        	 countFlag="D";
                        	 if(parseInt(varDDays)==parseInt(v1))
                        	 {
                        		 countFlag="L";
                        		 v3=0;
                        	 }
                         }
                         else
                         {
                        	 document.forms[0].txt_year5[3].value=parseInt(varDDays);
                        	 v2=parseInt(v1)-parseInt(varDDays);                         
                        	 if(v2!=0)
                        	 {
                               if(parseInt(v2)<=parseInt(varLDays))
                               {
                            	   document.forms[0].txt_year5[1].value=parseInt(document.forms[0].txt_year5[1].value)+parseInt(v2);
                            	   v3=parseInt(varLDays)-parseInt(v2);
                            	   countFlag="L";
                            	   if(parseInt(varLDays)==parseInt(v2))
                            	   {
                            		   countFlag="D";
                            		   v3=0;
                            	   }                      	   
                               }
                               else
                               {
                            	   document.forms[0].txt_year5[1].value=parseInt(document.forms[0].txt_year5[1].value)+parseInt(varLDays);
                            	   v4=parseInt(v2)-parseInt(varLDays);
                            	   if(parseInt(v4)<=parseInt(varDDays))
                            	   {
                            		   document.forms[0].txt_year5[3].value=parseInt(document.forms[0].txt_year5[3].value)+parseInt(v4);
                            		   v3=parseInt(varDDays)-parseInt(v4);
                            		   countFlag="D";
                            		   if(parseInt(varDDays)==parseInt(v4))
                            		   {
                                         v3=0;
                                         countFlag="L";
                            		   }
                            		   
                            	   } 
                            	   else
                            	   {
                            		   document.forms[0].txt_year5[3].value=parseInt(document.forms[0].txt_year5[3].value)+parseInt(varDDays);
                            		   v3=parseInt(v4)-parseInt(varDDays); 
                            		   countFlag="L";                      		   
                            	   }                   
                               }
                               
                           	 }                  	 
                         }                                                       

                      }
                      }
                      else if(countFlag=="D")
                      {

                    	  if(parseInt(varDDays)>=360)
                          {
                              document.forms[0].txt_year5[3].value="360";
                              document.forms[0].txt_year5[1].value="0";
                              countFlag="D";
                          }
                          else
                          {
                             document.forms[0].txt_year5[3].value=parseInt(varDDays);  
                             v1=360-parseInt(varDDays);
                             if(parseInt(v1)<=parseInt(varLDays))
                             {
                            	 document.forms[0].txt_year5[1].value=parseInt(v1);
                            	 v3=parseInt(varLDays)-parseInt(v1);
                            	 countFlag="L";
                            	 if(parseInt(varLDays)==parseInt(v1))
                            	 {
                            		 countFlag="D";
                            		 v3=0;
                            	 }
                             }
                             else
                             {
                            	 document.forms[0].txt_year5[1].value=parseInt(varLDays);
                            	 v2=parseInt(v1)-parseInt(varLDays);                         
                            	 if(v2!=0)
                            	 {
                                   if(parseInt(v2)<=parseInt(varDDays))
                                   {
                                	   document.forms[0].txt_year5[3].value=parseInt(document.forms[0].txt_year5[3].value)+parseInt(v2);
                                	   v3=parseInt(varDDays)-parseInt(v2);
                                	   countFlag="D";
                                	   if(parseInt(varDDays)==parseInt(v2))
                                	   {
                                		   countFlag="L";
                                		   v3=0;
                                	   }                      	   
                                   }
                                   else
                                   {
                                	   document.forms[0].txt_year5[3].value=parseInt(document.forms[0].txt_year5[3].value)+parseInt(varDDays);
                                	   v4=parseInt(v2)-parseInt(varDDays);
                                	   if(parseInt(v4)<=parseInt(varLDays))
                                	   {
                                		   document.forms[0].txt_year5[1].value=parseInt(document.forms[0].txt_year5[1].value)+parseInt(v4);
                                		   v3=parseInt(varLDays)-parseInt(v4);
                                		   countFlag="L";
                                		   if(parseInt(varLDays)==parseInt(v4))
                                		   {
                                             v3=0;
                                             countFlag="D";
                                		   }
                                		   
                                	   } 
                                	   else
                                	   {
                                		   document.forms[0].txt_year5[1].value=parseInt(document.forms[0].txt_year5[1].value)+parseInt(varLDays);
                                		   v3=parseInt(v4)-parseInt(varLDays); 
                                		   countFlag="D";                      		   
                                	   }                   
                                   }
                                   
                               	 }                  	 
                             }                                                       

                          }

                      }
                }    

              } 

              else if(y==6)
              {
                  if(v3!=0)
                  {
                      if(countFlag=="D")
                      {
                      document.forms[0].txt_year6[3].value=parseInt(v3);                      
                      var vtemp=360-parseInt(v3);                     
                      if(parseInt(varLDays)>=parseInt(vtemp))
                      {
                          document.forms[0].txt_year6[1].value=parseInt(vtemp);                        
                          v3=parseInt(varLDays)-parseInt(vtemp); 
                          countFlag="L";   
                          if(parseInt(varLDays)==parseInt(vtemp))
                          {
                              v3=0;
                              countFlag="D";
                          }                   
                      }
                      else
                      {
                         document.forms[0].txt_year6[1].value=parseInt(varLDays);  
                         v1=parseInt(vtemp)-parseInt(varLDays);
                         if(parseInt(v1)<=parseInt(varDDays))
                         {
                        	 document.forms[0].txt_year6[3].value=parseInt(document.forms[0].txt_year6[3].value)+parseInt(v1);
                        	 v3=parseInt(varDDays)-parseInt(v1);
                        	 countFlag="D";
                        	 if(parseInt(v1)==parseInt(varDDays))
                        	 {
                                v3=0;
                                countFlag="L";
                        	 }
                         }
                         else
                         {
                        	 document.forms[0].txt_year6[3].value=parseInt(document.forms[0].txt_year6[3].value)+parseInt(varDDays);
                        	 v2=parseInt(v1)-parseInt(varDDays);                         	                         	
                        	 if(v2!=0)
                        	 {
                               if(v2<=varLDays)
                               {
                            	   document.forms[0].txt_year6[1].value=parseInt(document.forms[0].txt_year6[1].value)+parseInt(v2);
                            	   v3=parseInt(varLDays)-parseInt(v2);
                            	   countFlag="L";
                            	   if(parseInt(varLDays)==parseInt(v2))
                            	   {
                                    v3=0;
                                    countFlag="D";                                     
                            	   }
                            	   
                               }
                               else
                               {
                            	   document.forms[0].txt_year6[1].value=parseInt(document.forms[0].txt_year6[1].value)+parseInt(varLDays);
                            	   v3=parseInt(v2)-parseInt(varLDays);
                            	   countFlag="D";                            	   

                               }
                           	 }                  	 
                         }                                                       

                      }
                      } 
                      else if(countFlag=="L")
                      {
                      document.forms[0].txt_year6[1].value=parseInt(v3);                     
                      var vtemp=360-parseInt(v3);                    
                      if(parseInt(varDDays)>=parseInt(vtemp))
                      {
                          document.forms[0].txt_year6[3].value=parseInt(vtemp);                        
                          v3=parseInt(varDDays)-parseInt(vtemp); 
                          countFlag="D";   
                          if(parseInt(varDDays)==parseInt(vtemp))
                          {
                              v3=0;
                              countFlag="L"; 
                          }                   
                      }
                      else
                      {
                         document.forms[0].txt_year6[3].value=parseInt(varDDays);  
                         v1=parseInt(vtemp)-parseInt(varDDays);
                         if(parseInt(v1)<=parseInt(varLDays))
                         {
                        	 document.forms[0].txt_year6[1].value=parseInt(document.forms[0].txt_year6[1].value)+parseInt(v1);
                        	 v3=parseInt(varLDays)-parseInt(v1);
                        	 countFlag="L";
                        	 if(parseInt(varLDays)==parseInt(v1))
                        	 {
                        		 countFlag="D";
                        		 v3=0;
                        	 }
                         }
                         else
                         {
                        	 document.forms[0].txt_year6[1].value=parseInt(document.forms[0].txt_year6[1].value)+parseInt(varLDays);
                        	 v2=parseInt(v1)-parseInt(varLDays);                         	
                        	 if(v2!=0)
                        	 {
                               if(parseInt(v2)<=parseInt(varDDays))
                               {
                            	   document.forms[0].txt_year6[3].value=parseInt(document.forms[0].txt_year6[3].value)+parseInt(v2);
                            	   v3=parseInt(varDDays)-parseInt(v2);
                            	   countFlag="D";
                            	   if(parseInt(v2)==parseInt(varDDays))
                            	   {
                            		   countFlag="L"; 
                            		   v3=0;
                            	   }                            	   
                               }
                               else
                               {
                            	   document.forms[0].txt_year6[3].value=parseInt(document.forms[0].txt_year6[3].value)+parseInt(varDDays);
                            	   v3=parseInt(v2)-parseInt(varDDays);
                            	   countFlag="L";    	   
                            	   

                               }
                           	 }                  	 
                         }                                                       

                      }
                      }                                               

                  }
                  else
                  {
                      if(countFlag=="L")
                      {
                      if(parseInt(varLDays)>=360)
                      {
                          document.forms[0].txt_year6[1].value="360";
                          document.forms[0].txt_year6[3].value="0";
                          countFlag="L";
                      }
                      else
                      {
                         document.forms[0].txt_year6[1].value=parseInt(varLDays);  
                         v1=360-parseInt(varLDays);
                         if(parseInt(v1)<=parseInt(varDDays))
                         {
                        	 document.forms[0].txt_year6[3].value=parseInt(v1);
                        	 v3=parseInt(varDDays)-parseInt(v1);
                        	 countFlag="D";
                        	 if(parseInt(varDDays)==parseInt(v1))
                        	 {
                        		 countFlag="L";
                        		 v3=0;
                        	 }
                         }
                         else
                         {
                        	 document.forms[0].txt_year6[3].value=parseInt(varDDays);
                        	 v2=parseInt(v1)-parseInt(varDDays);                         
                        	 if(v2!=0)
                        	 {
                               if(parseInt(v2)<=parseInt(varLDays))
                               {
                            	   document.forms[0].txt_year6[1].value=parseInt(document.forms[0].txt_year6[1].value)+parseInt(v2);
                            	   v3=parseInt(varLDays)-parseInt(v2);
                            	   countFlag="L";
                            	   if(parseInt(varLDays)==parseInt(v2))
                            	   {
                            		   countFlag="D";
                            		   v3=0;
                            	   }                      	   
                               }
                               else
                               {
                            	   document.forms[0].txt_year6[1].value=parseInt(document.forms[0].txt_year6[1].value)+parseInt(varLDays);
                            	   v4=parseInt(v2)-parseInt(varLDays);
                            	   if(parseInt(v4)<=parseInt(varDDays))
                            	   {
                            		   document.forms[0].txt_year6[3].value=parseInt(document.forms[0].txt_year6[3].value)+parseInt(v4);
                            		   v3=parseInt(varDDays)-parseInt(v4);
                            		   countFlag="D";
                            		   if(parseInt(varDDays)==parseInt(v4))
                            		   {
                                         v3=0;
                                         countFlag="L";
                            		   }
                            		   
                            	   } 
                            	   else
                            	   {
                            		   document.forms[0].txt_year6[3].value=parseInt(document.forms[0].txt_year6[3].value)+parseInt(varDDays);
                            		   v3=parseInt(v4)-parseInt(varDDays); 
                            		   countFlag="L";                      		   
                            	   }                   
                               }
                               
                           	 }                  	 
                         }                                                       

                      }
                      }
                      else if(countFlag=="D")
                      {

                    	  if(parseInt(varDDays)>=360)
                          {
                              document.forms[0].txt_year6[3].value="360";
                              document.forms[0].txt_year6[1].value="0";
                              countFlag="D";
                          }
                          else
                          {
                             document.forms[0].txt_year6[3].value=parseInt(varDDays);  
                             v1=360-parseInt(varDDays);
                             if(parseInt(v1)<=parseInt(varLDays))
                             {
                            	 document.forms[0].txt_year6[1].value=parseInt(v1);
                            	 v3=parseInt(varLDays)-parseInt(v1);
                            	 countFlag="L";
                            	 if(parseInt(varLDays)==parseInt(v1))
                            	 {
                            		 countFlag="D";
                            		 v3=0;
                            	 }
                             }
                             else
                             {
                            	 document.forms[0].txt_year6[1].value=parseInt(varLDays);
                            	 v2=parseInt(v1)-parseInt(varLDays);                         
                            	 if(v2!=0)
                            	 {
                                   if(parseInt(v2)<=parseInt(varDDays))
                                   {
                                	   document.forms[0].txt_year6[3].value=parseInt(document.forms[0].txt_year6[3].value)+parseInt(v2);
                                	   v3=parseInt(varDDays)-parseInt(v2);
                                	   countFlag="D";
                                	   if(parseInt(varDDays)==parseInt(v2))
                                	   {
                                		   countFlag="L";
                                		   v3=0;
                                	   }                      	   
                                   }
                                   else
                                   {
                                	   document.forms[0].txt_year6[3].value=parseInt(document.forms[0].txt_year6[3].value)+parseInt(varDDays);
                                	   v4=parseInt(v2)-parseInt(varDDays);
                                	   if(parseInt(v4)<=parseInt(varLDays))
                                	   {
                                		   document.forms[0].txt_year6[1].value=parseInt(document.forms[0].txt_year6[1].value)+parseInt(v4);
                                		   v3=parseInt(varLDays)-parseInt(v4);
                                		   countFlag="L";
                                		   if(parseInt(varLDays)==parseInt(v4))
                                		   {
                                             v3=0;
                                             countFlag="D";
                                		   }
                                		   
                                	   } 
                                	   else
                                	   {
                                		   document.forms[0].txt_year6[1].value=parseInt(document.forms[0].txt_year6[1].value)+parseInt(varLDays);
                                		   v3=parseInt(v4)-parseInt(varLDays); 
                                		   countFlag="D";                      		   
                                	   }                   
                                   }
                                   
                               	 }                  	 
                             }                                                       

                          }

                      }
                }    

              } 
              
             y++;          
          }
	}
	else
	{

	     <%
	     
	      for(int i=1;i<=6;i++)
	      {
	    	  %>
	    	  
	    	  document.forms[0].txt_year<%=i%>[1].value="0";
	    	  document.forms[0].txt_year<%=i%>[3].value="0";	    	
	    	  
	    	  
	    	<%  
	      }
	     %>
	  
	}
	
}

function  calBatch2Cal()
{
	var varLDays=document.forms[0].txt_lacdays.value;
	var varDDays=document.forms[0].txt_drydays.value;
	var varB2days=document.forms[0].txt_batch2days.value;
	var v1=0,v2=0,v3=0,varLDaysTemp=0,v4=0,varDdaystemp=0;
	var vb1=0;
	var b=1;
	var y=1;
	var countFlag=""; 
	if(varB2days!="" && varB2days!="0" && varLDays!="" && varLDays!="0" && varDDays!="" && varDDays!="0")
	{
		while(y<=6)
        {
            if(y==1)
            {

                var vTemp=360-parseInt(varB2days);
                if(parseInt(varLDays)>=parseInt(vTemp))
                {
                    document.forms[0].txt_year1[6].value=parseInt(vTemp);
                    document.forms[0].txt_year1[8].value="0";
                    countFlag="L";
                    v3=parseInt(varLDays)-parseInt(vTemp);
                }
                else
                {
                   document.forms[0].txt_year1[6].value=parseInt(varLDays);  
                   v1=parseInt(vTemp)-parseInt(varLDays);
                   if(parseInt(v1)<=parseInt(varDDays))
                   {
                  	 document.forms[0].txt_year1[8].value=parseInt(v1);
                  	 v3=parseInt(varDDays)-parseInt(v1);
                  	 countFlag="D";
                  	 if(parseInt(varDDays)==parseInt(v1))
                  	 {
                         v3=0;
                         countFlag="L";
                  	 }
                   }
                   else
                   {
                  	 document.forms[0].txt_year1[8].value=parseInt(varDDays);
                  	 v2=parseInt(v1)-parseInt(varDDays);                      	
                  	 if(v2!=0)
                  	 {
                         if(parseInt(v2)<=parseInt(varLDays))
                         {
                      	   document.forms[0].txt_year1[6].value=parseInt(document.forms[0].txt_year1[6].value)+parseInt(v2);
                      	   v3=parseInt(varLDays)-parseInt(v2);
                      	   countFlag="L";
                      	   if(parseInt(v2)==parseInt(varLDays))
                      	   {
                      		   v3=0;
                                 countFlag="D"; 
                      	   }                        	   
                      	   
                         }
                         else
                         {
                      	   document.forms[0].txt_year1[6].value=parseInt(document.forms[0].txt_year1[6].value)+parseInt(varLDays);
                      	   v4=parseInt(v2)-parseInt(varLDays);
                      	   if(parseInt(v4)<=parseInt(varDDays))
                      	   {
                      		   document.forms[0].txt_year1[8].value=parseInt(document.forms[0].txt_year1[8].value)+parseInt(v4);
                      		   v3=parseInt(varDDays)-parseInt(v4);
                      		   countFlag="D";
                      		   if(parseInt(v4)==parseInt(varDDays))
                      		   {
                                    v3=0;
                                    countFlag="L";
                      		   }
                      		  
                      	   } 
                      	   else
                      	   {
                      		   document.forms[0].txt_year1[8].value=parseInt(document.forms[0].txt_year1[8].value)+parseInt(varDDays);
                      		   v3=parseInt(v4)-parseInt(varDDays);
                      		   countFlag="L";                  		                         		  
                      		                          		   
                      	   }                   
                         }
                         
                     	 }                  	 
                   }                                                       

                }
            } 
            else if(y==2)
            {
                if(v3!=0)
                {
                    if(countFlag=="D")
                    {
                    document.forms[0].txt_year2[8].value=parseInt(v3);                      
                    var vtemp=360-parseInt(v3);                     
                    if(parseInt(varLDays)>=parseInt(vtemp))
                    {
                        document.forms[0].txt_year2[6].value=parseInt(vtemp);
                        v3=parseInt(varLDays)-parseInt(vtemp); 
                        countFlag="L"; 
                        if(parseInt(varLDays)==parseInt(vtemp))
                        {
                            v3=0;
                            countFlag="D";
                        } 
                                          
                    }
                    else
                    {
                       document.forms[0].txt_year2[6].value=parseInt(varLDays);  
                       v1=parseInt(vtemp)-parseInt(varLDays);
                       if(parseInt(v1)<=parseInt(varDDays))
                       {
                      	 document.forms[0].txt_year2[8].value=parseInt(document.forms[0].txt_year2[8].value)+parseInt(v1);
                      	 v3=parseInt(varDDays)-parseInt(v1);
                      	 countFlag="D";
                      	 if(parseInt(v1)==parseInt(varDDays))
                      	 {
                              v3=0;
                              countFlag="L";
                      	 }
                       }
                       else
                       {
                      	 document.forms[0].txt_year2[8].value=parseInt(document.forms[0].txt_year2[8].value)+parseInt(varDDays);
                      	 v2=parseInt(v1)-parseInt(varDDays);                         	                         	
                      	 if(v2!=0)
                      	 {
                             if(v2<=varLDays)
                             {
                          	   document.forms[0].txt_year2[6].value=parseInt(document.forms[0].txt_year2[6].value)+parseInt(v2);
                          	   v3=parseInt(varLDays)-parseInt(v2);
                          	   countFlag="L";
                          	   if(parseInt(varLDays)==parseInt(v2))
                          	   {
                                  v3=0;
                                  countFlag="D";                                     
                          	   }
                          	   
                             }
                             else
                             {
                          	   document.forms[0].txt_year2[6].value=parseInt(document.forms[0].txt_year2[6].value)+parseInt(varLDays);
                          	   v3=parseInt(v2)-parseInt(varLDays);
                          	   countFlag="D";                            	   

                             }
                         	 }                  	 
                       }                                                       

                    }
                    } 
                    else if(countFlag=="L")
                    {
                    document.forms[0].txt_year2[6].value=parseInt(v3);                     
                    var vtemp=360-parseInt(v3);                    
                    if(parseInt(varDDays)>=parseInt(vtemp))
                    {
                        document.forms[0].txt_year2[8].value=parseInt(vtemp);                        
                        v3=parseInt(varDDays)-parseInt(vtemp); 
                        countFlag="D";   
                        if(parseInt(varDDays)==parseInt(vtemp))
                        {
                            v3=0;
                            countFlag="L"; 
                        }                   
                    }
                    else
                    {
                       document.forms[0].txt_year2[8].value=parseInt(varDDays);  
                       v1=parseInt(vtemp)-parseInt(varDDays);
                       if(parseInt(v1)<=parseInt(varLDays))
                       {
                      	 document.forms[0].txt_year2[6].value=parseInt(document.forms[0].txt_year2[6].value)+parseInt(v1);
                      	 v3=parseInt(varLDays)-parseInt(v1);
                      	 countFlag="L";
                      	 if(parseInt(varLDays)==parseInt(v1))
                      	 {
                      		 countFlag="D";
                      		 v3=0;
                      	 }
                       }
                       else
                       {
                      	 document.forms[0].txt_year2[6].value=parseInt(document.forms[0].txt_year2[6].value)+parseInt(varLDays);
                      	 v2=parseInt(v1)-parseInt(varLDays);                         	
                      	 if(v2!=0)
                      	 {
                             if(parseInt(v2)<=parseInt(varDDays))
                             {
                          	   document.forms[0].txt_year2[8].value=parseInt(document.forms[0].txt_year2[8].value)+parseInt(v2);
                          	   v3=parseInt(varDDays)-parseInt(v2);
                          	   countFlag="D";
                          	   if(parseInt(v2)==parseInt(varDDays))
                          	   {
                          		   countFlag="L"; 
                          		   v3=0;
                          	   }                            	   
                             }
                             else
                             {
                          	   document.forms[0].txt_year2[8].value=parseInt(document.forms[0].txt_year2[8].value)+parseInt(varDDays);
                          	   v3=parseInt(v2)-parseInt(varDDays);
                          	   countFlag="L";    	   
                          	   

                             }
                         	 }                  	 
                       }                                                       

                    }
                    }                                               

                }
                else
                {
                    if(countFlag=="L")
                    {
                    if(parseInt(varLDays)>=360)
                    {
                        document.forms[0].txt_year2[6].value="360";
                        document.forms[0].txt_year2[8].value="0";
                        countFlag="L";
                    }
                    else
                    {
                       document.forms[0].txt_year2[6].value=parseInt(varLDays);  
                       v1=360-parseInt(varLDays);
                       if(parseInt(v1)<=parseInt(varDDays))
                       {
                      	 document.forms[0].txt_year2[8].value=parseInt(v1);
                      	 v3=parseInt(varDDays)-parseInt(v1);
                      	 countFlag="D";
                      	 if(parseInt(varDDays)==parseInt(v1))
                      	 {
                      		 countFlag="L";
                      		 v3=0;
                      	 }
                       }
                       else
                       {
                      	 document.forms[0].txt_year2[8].value=parseInt(varDDays);
                      	 v2=parseInt(v1)-parseInt(varDDays);                         
                      	 if(v2!=0)
                      	 {
                             if(parseInt(v2)<=parseInt(varLDays))
                             {
                          	   document.forms[0].txt_year2[6].value=parseInt(document.forms[0].txt_year2[6].value)+parseInt(v2);
                          	   v3=parseInt(varLDays)-parseInt(v2);
                          	   countFlag="L";
                          	   if(parseInt(varLDays)==parseInt(v2))
                          	   {
                          		   countFlag="D";
                          		   v3=0;
                          	   }                      	   
                             }
                             else
                             {
                          	   document.forms[0].txt_year2[6].value=parseInt(document.forms[0].txt_year2[6].value)+parseInt(varLDays);
                          	   v4=parseInt(v2)-parseInt(varLDays);
                          	   if(parseInt(v4)<=parseInt(varDDays))
                          	   {
                          		   document.forms[0].txt_year2[8].value=parseInt(document.forms[0].txt_year2[8].value)+parseInt(v4);
                          		   v3=parseInt(varDDays)-parseInt(v4);
                          		   countFlag="D";
                          		   if(parseInt(varDDays)==parseInt(v4))
                          		   {
                                       v3=0;
                                       countFlag="L";
                          		   }
                          		   
                          	   } 
                          	   else
                          	   {
                          		   document.forms[0].txt_year2[8].value=parseInt(document.forms[0].txt_year2[8].value)+parseInt(varDDays);
                          		   v3=parseInt(v4)-parseInt(varDDays); 
                          		   countFlag="L";                      		   
                          	   }                   
                             }
                             
                         	 }                  	 
                       }                                                       

                    }
                    }
                    else if(countFlag=="D")
                    {

                  	  if(parseInt(varDDays)>=360)
                        {
                            document.forms[0].txt_year2[8].value="360";
                            document.forms[0].txt_year2[6].value="0";
                            countFlag="D";
                        }
                        else
                        {
                           document.forms[0].txt_year2[8].value=parseInt(varDDays);  
                           v1=360-parseInt(varDDays);
                           if(parseInt(v1)<=parseInt(varLDays))
                           {
                          	 document.forms[0].txt_year2[6].value=parseInt(v1);
                          	 v3=parseInt(varLDays)-parseInt(v1);
                          	 countFlag="L";
                          	 if(parseInt(varLDays)==parseInt(v1))
                          	 {
                          		 countFlag="D";
                          		 v3=0;
                          	 }
                           }
                           else
                           {
                          	 document.forms[0].txt_year2[6].value=parseInt(varLDays);
                          	 v2=parseInt(v1)-parseInt(varLDays);                         
                          	 if(v2!=0)
                          	 {
                                 if(parseInt(v2)<=parseInt(varDDays))
                                 {
                              	   document.forms[0].txt_year2[8].value=parseInt(document.forms[0].txt_year2[8].value)+parseInt(v2);
                              	   v3=parseInt(varDDays)-parseInt(v2);
                              	   countFlag="D";
                              	   if(parseInt(varDDays)==parseInt(v2))
                              	   {
                              		   countFlag="L";
                              		   v3=0;
                              	   }                      	   
                                 }
                                 else
                                 {
                              	   document.forms[0].txt_year2[8].value=parseInt(document.forms[0].txt_year2[8].value)+parseInt(varDDays);
                              	   v4=parseInt(v2)-parseInt(varDDays);
                              	   if(parseInt(v4)<=parseInt(varLDays))
                              	   {
                              		   document.forms[0].txt_year2[6].value=parseInt(document.forms[0].txt_year2[6].value)+parseInt(v4);
                              		   v3=parseInt(varLDays)-parseInt(v4);
                              		   countFlag="L";
                              		   if(parseInt(varLDays)==parseInt(v4))
                              		   {
                                           v3=0;
                                           countFlag="D";
                              		   }
                              		   
                              	   } 
                              	   else
                              	   {
                              		   document.forms[0].txt_year2[6].value=parseInt(document.forms[0].txt_year2[6].value)+parseInt(varLDays);
                              		   v3=parseInt(v4)-parseInt(varLDays); 
                              		   countFlag="D";                      		   
                              	   }                   
                                 }
                                 
                             	 }                  	 
                           }                                                       

                        }

                    }
              }    

            } 
            else if(y==3)
            {
                if(v3!=0)
                {
                    if(countFlag=="D")
                    {
                    document.forms[0].txt_year3[8].value=parseInt(v3);                      
                    var vtemp=360-parseInt(v3);                     
                    if(parseInt(varLDays)>=parseInt(vtemp))
                    {
                        document.forms[0].txt_year3[6].value=parseInt(vtemp);                      
                        v3=parseInt(varLDays)-parseInt(vtemp); 
                        countFlag="L";    
                        if(parseInt(varLDays)==parseInt(vtemp))
                        {
                            v3=0;
                            countFlag="D";
                        }                  
                    }
                    else
                    {
                       document.forms[0].txt_year3[6].value=parseInt(varLDays);  
                       v1=parseInt(vtemp)-parseInt(varLDays);
                       if(parseInt(v1)<=parseInt(varDDays))
                       {
                      	 document.forms[0].txt_year3[8].value=parseInt(document.forms[0].txt_year3[8].value)+parseInt(v1);
                      	 v3=parseInt(varDDays)-parseInt(v1);
                      	 countFlag="D";
                      	 if(parseInt(v1)==parseInt(varDDays))
                      	 {
                              v3=0;
                              countFlag="L";
                      	 }
                       }
                       else
                       {
                      	 document.forms[0].txt_year3[8].value=parseInt(document.forms[0].txt_year3[8].value)+parseInt(varDDays);
                      	 v2=parseInt(v1)-parseInt(varDDays);                         	                         	
                      	 if(v2!=0)
                      	 {
                             if(v2<=varLDays)
                             {
                          	   document.forms[0].txt_year3[6].value=parseInt(document.forms[0].txt_year3[6].value)+parseInt(v2);
                          	   v3=parseInt(varLDays)-parseInt(v2);
                          	   countFlag="L";
                          	   if(parseInt(varLDays)==parseInt(v2))
                          	   {
                                  v3=0;
                                  countFlag="D";                                     
                          	   }
                          	   
                             }
                             else
                             {
                          	   document.forms[0].txt_year3[6].value=parseInt(document.forms[0].txt_year3[6].value)+parseInt(varLDays);
                          	   v3=parseInt(v2)-parseInt(varLDays);
                          	   countFlag="D";                            	   

                             }
                         	 }                  	 
                       }                                                       

                    }
                    } 
                    else if(countFlag=="L")
                    {
                    document.forms[0].txt_year3[6].value=parseInt(v3);                     
                    var vtemp=360-parseInt(v3);                    
                    if(parseInt(varDDays)>=parseInt(vtemp))
                    {
                        document.forms[0].txt_year3[8].value=parseInt(vtemp);                        
                        v3=parseInt(varDDays)-parseInt(vtemp); 
                        countFlag="D";  
                        if(parseInt(varDDays)==parseInt(vtemp))
                        {
                            v3=0;
                            countFlag="L"; 
                        }                    
                    }
                    else
                    {
                       document.forms[0].txt_year3[8].value=parseInt(varDDays);  
                       v1=parseInt(vtemp)-parseInt(varDDays);
                       if(parseInt(v1)<=parseInt(varLDays))
                       {
                      	 document.forms[0].txt_year3[6].value=parseInt(document.forms[0].txt_year3[6].value)+parseInt(v1);
                      	 v3=parseInt(varLDays)-parseInt(v1);
                      	 countFlag="L";
                      	 if(parseInt(varLDays)==parseInt(v1))
                      	 {
                      		 countFlag="D";
                      		 v3=0;
                      	 }
                       }
                       else
                       {
                      	 document.forms[0].txt_year3[6].value=parseInt(document.forms[0].txt_year3[6].value)+parseInt(varLDays);
                      	 v2=parseInt(v1)-parseInt(varLDays);                         	
                      	 if(v2!=0)
                      	 {
                             if(parseInt(v2)<=parseInt(varDDays))
                             {
                          	   document.forms[0].txt_year3[8].value=parseInt(document.forms[0].txt_year3[8].value)+parseInt(v2);
                          	   v3=parseInt(varDDays)-parseInt(v2);
                          	   countFlag="D";
                          	   if(parseInt(v2)==parseInt(varDDays))
                          	   {
                          		   countFlag="L"; 
                          		   v3=0;
                          	   }                            	   
                             }
                             else
                             {
                          	   document.forms[0].txt_year3[8].value=parseInt(document.forms[0].txt_year3[8].value)+parseInt(varDDays);
                          	   v3=parseInt(v2)-parseInt(varDDays);
                          	   countFlag="L";    	   
                          	   

                             }
                         	 }                  	 
                       }                                                       

                    }
                    }                                               

                }
                else
                {
                    if(countFlag=="L")
                    {
                    if(parseInt(varLDays)>=360)
                    {
                        document.forms[0].txt_year3[6].value="360";
                        document.forms[0].txt_year3[8].value="0";
                        countFlag="L";
                    }
                    else
                    {
                       document.forms[0].txt_year3[6].value=parseInt(varLDays);  
                       v1=360-parseInt(varLDays);
                       if(parseInt(v1)<=parseInt(varDDays))
                       {
                      	 document.forms[0].txt_year3[8].value=parseInt(v1);
                      	 v3=parseInt(varDDays)-parseInt(v1);
                      	 countFlag="D";
                      	 if(parseInt(varDDays)==parseInt(v1))
                      	 {
                      		 countFlag="L";
                      		 v3=0;
                      	 }
                       }
                       else
                       {
                      	 document.forms[0].txt_year3[8].value=parseInt(varDDays);
                      	 v2=parseInt(v1)-parseInt(varDDays);                         
                      	 if(v2!=0)
                      	 {
                             if(parseInt(v2)<=parseInt(varLDays))
                             {
                          	   document.forms[0].txt_year3[6].value=parseInt(document.forms[0].txt_year3[6].value)+parseInt(v2);
                          	   v3=parseInt(varLDays)-parseInt(v2);
                          	   countFlag="L";
                          	   if(parseInt(varLDays)==parseInt(v2))
                          	   {
                          		   countFlag="D";
                          		   v3=0;
                          	   }                      	   
                             }
                             else
                             {
                          	   document.forms[0].txt_year3[6].value=parseInt(document.forms[0].txt_year3[6].value)+parseInt(varLDays);
                          	   v4=parseInt(v2)-parseInt(varLDays);
                          	   if(parseInt(v4)<=parseInt(varDDays))
                          	   {
                          		   document.forms[0].txt_year3[8].value=parseInt(document.forms[0].txt_year3[8].value)+parseInt(v4);
                          		   v3=parseInt(varDDays)-parseInt(v4);
                          		   countFlag="D";
                          		   if(parseInt(varDDays)==parseInt(v4))
                          		   {
                                       v3=0;
                                       countFlag="L";
                          		   }
                          		   
                          	   } 
                          	   else
                          	   {
                          		   document.forms[0].txt_year3[8].value=parseInt(document.forms[0].txt_year3[8].value)+parseInt(varDDays);
                          		   v3=parseInt(v4)-parseInt(varDDays); 
                          		   countFlag="L";                      		   
                          	   }                   
                             }
                             
                         	 }                  	 
                       }                                                       

                    }
                    }
                    else if(countFlag=="D")
                    {

                  	  if(parseInt(varDDays)>=360)
                        {
                            document.forms[0].txt_year3[8].value="360";
                            document.forms[0].txt_year3[6].value="0";
                            countFlag="D";
                        }
                        else
                        {
                           document.forms[0].txt_year3[8].value=parseInt(varDDays);  
                           v1=360-parseInt(varDDays);
                           if(parseInt(v1)<=parseInt(varLDays))
                           {
                          	 document.forms[0].txt_year3[6].value=parseInt(v1);
                          	 v3=parseInt(varLDays)-parseInt(v1);
                          	 countFlag="L";
                          	 if(parseInt(varLDays)==parseInt(v1))
                          	 {
                          		 countFlag="D";
                          		 v3=0;
                          	 }
                           }
                           else
                           {
                          	 document.forms[0].txt_year3[6].value=parseInt(varLDays);
                          	 v2=parseInt(v1)-parseInt(varLDays);                         
                          	 if(v2!=0)
                          	 {
                                 if(parseInt(v2)<=parseInt(varDDays))
                                 {
                              	   document.forms[0].txt_year3[8].value=parseInt(document.forms[0].txt_year3[8].value)+parseInt(v2);
                              	   v3=parseInt(varDDays)-parseInt(v2);
                              	   countFlag="D";
                              	   if(parseInt(varDDays)==parseInt(v2))
                              	   {
                              		   countFlag="L";
                              		   v3=0;
                              	   }                      	   
                                 }
                                 else
                                 {
                              	   document.forms[0].txt_year3[8].value=parseInt(document.forms[0].txt_year3[8].value)+parseInt(varDDays);
                              	   v4=parseInt(v2)-parseInt(varDDays);
                              	   if(parseInt(v4)<=parseInt(varLDays))
                              	   {
                              		   document.forms[0].txt_year3[6].value=parseInt(document.forms[0].txt_year3[6].value)+parseInt(v4);
                              		   v3=parseInt(varLDays)-parseInt(v4);
                              		   countFlag="L";
                              		   if(parseInt(varLDays)==parseInt(v4))
                              		   {
                                           v3=0;
                                           countFlag="D";
                              		   }
                              		   
                              	   } 
                              	   else
                              	   {
                              		   document.forms[0].txt_year3[6].value=parseInt(document.forms[0].txt_year3[6].value)+parseInt(varLDays);
                              		   v3=parseInt(v4)-parseInt(varLDays); 
                              		   countFlag="D";                      		   
                              	   }                   
                                 }
                                 
                             	 }                  	 
                           }                                                       

                        }

                    }
              }    

            } 

            else if(y==4)
            {
                if(v3!=0)
                {
                    if(countFlag=="D")
                    {
                    document.forms[0].txt_year4[8].value=parseInt(v3);                      
                    var vtemp=360-parseInt(v3);                     
                    if(parseInt(varLDays)>=parseInt(vtemp))
                    {
                        document.forms[0].txt_year4[6].value=parseInt(vtemp);                        
                        v3=parseInt(varLDays)-parseInt(vtemp); 
                        countFlag="L";
                        if(parseInt(varLDays)==parseInt(vtemp))
                        {
                            v3=0;
                            countFlag="D";
                        }                     
                    }
                    else
                    {
                       document.forms[0].txt_year4[6].value=parseInt(varLDays);  
                       v1=parseInt(vtemp)-parseInt(varLDays);
                       if(parseInt(v1)<=parseInt(varDDays))
                       {
                      	 document.forms[0].txt_year4[8].value=parseInt(document.forms[0].txt_year4[8].value)+parseInt(v1);
                      	 v3=parseInt(varDDays)-parseInt(v1);
                      	 countFlag="D";
                      	 if(parseInt(v1)==parseInt(varDDays))
                      	 {
                              v3=0;
                              countFlag="L";
                      	 }
                       }
                       else
                       {
                      	 document.forms[0].txt_year4[8].value=parseInt(document.forms[0].txt_year4[8].value)+parseInt(varDDays);
                      	 v2=parseInt(v1)-parseInt(varDDays);                         	                         	
                      	 if(v2!=0)
                      	 {
                             if(v2<=varLDays)
                             {
                          	   document.forms[0].txt_year4[6].value=parseInt(document.forms[0].txt_year4[6].value)+parseInt(v2);
                          	   v3=parseInt(varLDays)-parseInt(v2);
                          	   countFlag="L";
                          	   if(parseInt(varLDays)==parseInt(v2))
                          	   {
                                  v3=0;
                                  countFlag="D";                                     
                          	   }
                          	   
                             }
                             else
                             {
                          	   document.forms[0].txt_year4[6].value=parseInt(document.forms[0].txt_year4[6].value)+parseInt(varLDays);
                          	   v3=parseInt(v2)-parseInt(varLDays);
                          	   countFlag="D";                            	   

                             }
                         	 }                  	 
                       }                                                       

                    }
                    } 
                    else if(countFlag=="L")
                    {
                    document.forms[0].txt_year4[6].value=parseInt(v3);                     
                    var vtemp=360-parseInt(v3);                    
                    if(parseInt(varDDays)>=parseInt(vtemp))
                    {
                        document.forms[0].txt_year4[8].value=parseInt(vtemp);                      
                        v3=parseInt(varDDays)-parseInt(vtemp); 
                        countFlag="D";   
                        if(parseInt(varDDays)==parseInt(vtemp))
                        {
                            v3=0;
                            countFlag="L"; 
                        }                   
                    }
                    else
                    {
                       document.forms[0].txt_year4[8].value=parseInt(varDDays);  
                       v1=parseInt(vtemp)-parseInt(varDDays);
                       if(parseInt(v1)<=parseInt(varLDays))
                       {
                      	 document.forms[0].txt_year4[6].value=parseInt(document.forms[0].txt_year4[6].value)+parseInt(v1);
                      	 v3=parseInt(varLDays)-parseInt(v1);
                      	 countFlag="L";
                      	 if(parseInt(varLDays)==parseInt(v1))
                      	 {
                      		 countFlag="D";
                      		 v3=0;
                      	 }
                       }
                       else
                       {
                      	 document.forms[0].txt_year4[6].value=parseInt(document.forms[0].txt_year4[6].value)+parseInt(varLDays);
                      	 v2=parseInt(v1)-parseInt(varLDays);                         	
                      	 if(v2!=0)
                      	 {
                             if(parseInt(v2)<=parseInt(varDDays))
                             {
                          	   document.forms[0].txt_year4[8].value=parseInt(document.forms[0].txt_year4[8].value)+parseInt(v2);
                          	   v3=parseInt(varDDays)-parseInt(v2);
                          	   countFlag="D";
                          	   if(parseInt(v2)==parseInt(varDDays))
                          	   {
                          		   countFlag="L"; 
                          		   v3=0;
                          	   }                            	   
                             }
                             else
                             {
                          	   document.forms[0].txt_year4[8].value=parseInt(document.forms[0].txt_year4[8].value)+parseInt(varDDays);
                          	   v3=parseInt(v2)-parseInt(varDDays);
                          	   countFlag="L";    	   
                          	   

                             }
                         	 }                  	 
                       }                                                       

                    }
                    }                                               

                }
                else
                {
                    if(countFlag=="L")
                    {
                    if(parseInt(varLDays)>=360)
                    {
                        document.forms[0].txt_year4[1].value="360";
                        document.forms[0].txt_year4[3].value="0";
                        countFlag="L";
                    }
                    else
                    {
                       document.forms[0].txt_year4[6].value=parseInt(varLDays);  
                       v1=360-parseInt(varLDays);
                       if(parseInt(v1)<=parseInt(varDDays))
                       {
                      	 document.forms[0].txt_year4[8].value=parseInt(v1);
                      	 v3=parseInt(varDDays)-parseInt(v1);
                      	 countFlag="D";
                      	 if(parseInt(varDDays)==parseInt(v1))
                      	 {
                      		 countFlag="L";
                      		 v3=0;
                      	 }
                       }
                       else
                       {
                      	 document.forms[0].txt_year4[8].value=parseInt(varDDays);
                      	 v2=parseInt(v1)-parseInt(varDDays);                         
                      	 if(v2!=0)
                      	 {
                             if(parseInt(v2)<=parseInt(varLDays))
                             {
                          	   document.forms[0].txt_year4[6].value=parseInt(document.forms[0].txt_year4[6].value)+parseInt(v2);
                          	   v3=parseInt(varLDays)-parseInt(v2);
                          	   countFlag="L";
                          	   if(parseInt(varLDays)==parseInt(v2))
                          	   {
                          		   countFlag="D";
                          		   v3=0;
                          	   }                      	   
                             }
                             else
                             {
                          	   document.forms[0].txt_year4[6].value=parseInt(document.forms[0].txt_year4[6].value)+parseInt(varLDays);
                          	   v4=parseInt(v2)-parseInt(varLDays);
                          	   if(parseInt(v4)<=parseInt(varDDays))
                          	   {
                          		   document.forms[0].txt_year4[8].value=parseInt(document.forms[0].txt_year4[8].value)+parseInt(v4);
                          		   v3=parseInt(varDDays)-parseInt(v4);
                          		   countFlag="D";
                          		   if(parseInt(varDDays)==parseInt(v4))
                          		   {
                                       v3=0;
                                       countFlag="L";
                          		   }
                          		   
                          	   } 
                          	   else
                          	   {
                          		   document.forms[0].txt_year4[8].value=parseInt(document.forms[0].txt_year4[8].value)+parseInt(varDDays);
                          		   v3=parseInt(v4)-parseInt(varDDays); 
                          		   countFlag="L";                      		   
                          	   }                   
                             }
                             
                         	 }                  	 
                       }                                                       

                    }
                    }
                    else if(countFlag=="D")
                    {

                  	  if(parseInt(varDDays)>=360)
                        {
                            document.forms[0].txt_year4[8].value="360";
                            document.forms[0].txt_year4[6].value="0";
                            countFlag="D";
                        }
                        else
                        {
                           document.forms[0].txt_year4[8].value=parseInt(varDDays);  
                           v1=360-parseInt(varDDays);
                           if(parseInt(v1)<=parseInt(varLDays))
                           {
                          	 document.forms[0].txt_year4[6].value=parseInt(v1);
                          	 v3=parseInt(varLDays)-parseInt(v1);
                          	 countFlag="L";
                          	 if(parseInt(varLDays)==parseInt(v1))
                          	 {
                          		 countFlag="D";
                          		 v3=0;
                          	 }
                           }
                           else
                           {
                          	 document.forms[0].txt_year4[6].value=parseInt(varLDays);
                          	 v2=parseInt(v1)-parseInt(varLDays);                         
                          	 if(v2!=0)
                          	 {
                                 if(parseInt(v2)<=parseInt(varDDays))
                                 {
                              	   document.forms[0].txt_year4[8].value=parseInt(document.forms[0].txt_year4[8].value)+parseInt(v2);
                              	   v3=parseInt(varDDays)-parseInt(v2);
                              	   countFlag="D";
                              	   if(parseInt(varDDays)==parseInt(v2))
                              	   {
                              		   countFlag="L";
                              		   v3=0;
                              	   }                      	   
                                 }
                                 else
                                 {
                              	   document.forms[0].txt_year4[8].value=parseInt(document.forms[0].txt_year4[8].value)+parseInt(varDDays);
                              	   v4=parseInt(v2)-parseInt(varDDays);
                              	   if(parseInt(v4)<=parseInt(varLDays))
                              	   {
                              		   document.forms[0].txt_year4[6].value=parseInt(document.forms[0].txt_year4[6].value)+parseInt(v4);
                              		   v3=parseInt(varLDays)-parseInt(v4);
                              		   countFlag="L";
                              		   if(parseInt(varLDays)==parseInt(v4))
                              		   {
                                           v3=0;
                                           countFlag="D";
                              		   }
                              		   
                              	   } 
                              	   else
                              	   {
                              		   document.forms[0].txt_year4[6].value=parseInt(document.forms[0].txt_year4[6].value)+parseInt(varLDays);
                              		   v3=parseInt(v4)-parseInt(varLDays); 
                              		   countFlag="D";                      		   
                              	   }                   
                                 }
                                 
                             	 }                  	 
                           }                                                       

                        }

                    }
              }    

            } 

            else if(y==5)
            {
                if(v3!=0)
                {
                    if(countFlag=="D")
                    {
                    document.forms[0].txt_year5[8].value=parseInt(v3);                      
                    var vtemp=360-parseInt(v3);                     
                    if(parseInt(varLDays)>=parseInt(vtemp))
                    {
                        document.forms[0].txt_year5[6].value=parseInt(vtemp);                         
                        v3=parseInt(varLDays)-parseInt(vtemp); 
                        countFlag="L";     
                        if(parseInt(varLDays)==parseInt(vtemp))
                        {
                            v3=0;
                            countFlag="D";
                        }                 
                    }
                    else
                    {
                       document.forms[0].txt_year5[6].value=parseInt(varLDays);  
                       v1=parseInt(vtemp)-parseInt(varLDays);
                       if(parseInt(v1)<=parseInt(varDDays))
                       {
                      	 document.forms[0].txt_year5[8].value=parseInt(document.forms[0].txt_year5[8].value)+parseInt(v1);
                      	 v3=parseInt(varDDays)-parseInt(v1);
                      	 countFlag="D";
                      	 if(parseInt(v1)==parseInt(varDDays))
                      	 {
                              v3=0;
                              countFlag="L";
                      	 }
                       }
                       else
                       {
                      	 document.forms[0].txt_year5[8].value=parseInt(document.forms[0].txt_year5[8].value)+parseInt(varDDays);
                      	 v2=parseInt(v1)-parseInt(varDDays);                         	                         	
                      	 if(v2!=0)
                      	 {
                             if(v2<=varLDays)
                             {
                          	   document.forms[0].txt_year5[6].value=parseInt(document.forms[0].txt_year5[6].value)+parseInt(v2);
                          	   v3=parseInt(varLDays)-parseInt(v2);
                          	   countFlag="L";
                          	   if(parseInt(varLDays)==parseInt(v2))
                          	   {
                                  v3=0;
                                  countFlag="D";                                     
                          	   }
                          	   
                             }
                             else
                             {
                          	   document.forms[0].txt_year5[6].value=parseInt(document.forms[0].txt_year5[6].value)+parseInt(varLDays);
                          	   v3=parseInt(v2)-parseInt(varLDays);
                          	   countFlag="D";                            	   

                             }
                         	 }                  	 
                       }                                                       

                    }
                    } 
                    else if(countFlag=="L")
                    {
                    document.forms[0].txt_year5[6].value=parseInt(v3);                     
                    var vtemp=360-parseInt(v3);                    
                    if(parseInt(varDDays)>=parseInt(vtemp))
                    {
                        document.forms[0].txt_year5[8].value=parseInt(vtemp);                       
                        v3=parseInt(varDDays)-parseInt(vtemp); 
                        countFlag="D";  
                        if(parseInt(varDDays)==parseInt(vtemp))
                        {
                            v3=0;
                            countFlag="L"; 
                        }                    
                    }
                    else
                    {
                       document.forms[0].txt_year5[8].value=parseInt(varDDays);  
                       v1=parseInt(vtemp)-parseInt(varDDays);
                       if(parseInt(v1)<=parseInt(varLDays))
                       {
                      	 document.forms[0].txt_year5[6].value=parseInt(document.forms[0].txt_year5[6].value)+parseInt(v1);
                      	 v3=parseInt(varLDays)-parseInt(v1);
                      	 countFlag="L";
                      	 if(parseInt(varLDays)==parseInt(v1))
                      	 {
                      		 countFlag="D";
                      		 v3=0;
                      	 }
                       }
                       else
                       {
                      	 document.forms[0].txt_year5[6].value=parseInt(document.forms[0].txt_year5[6].value)+parseInt(varLDays);
                      	 v2=parseInt(v1)-parseInt(varLDays);                         	
                      	 if(v2!=0)
                      	 {
                             if(parseInt(v2)<=parseInt(varDDays))
                             {
                          	   document.forms[0].txt_year5[8].value=parseInt(document.forms[0].txt_year5[8].value)+parseInt(v2);
                          	   v3=parseInt(varDDays)-parseInt(v2);
                          	   countFlag="D";
                          	   if(parseInt(v2)==parseInt(varDDays))
                          	   {
                          		   countFlag="L"; 
                          		   v3=0;
                          	   }                            	   
                             }
                             else
                             {
                          	   document.forms[0].txt_year5[8].value=parseInt(document.forms[0].txt_year5[8].value)+parseInt(varDDays);
                          	   v3=parseInt(v2)-parseInt(varDDays);
                          	   countFlag="L";    	   
                          	   

                             }
                         	 }                  	 
                       }                                                       

                    }
                    }                                               

                }
                else
                {
                    if(countFlag=="L")
                    {
                    if(parseInt(varLDays)>=360)
                    {
                        document.forms[0].txt_year5[6].value="360";
                        document.forms[0].txt_year5[8].value="0";
                        countFlag="L";
                    }
                    else
                    {
                       document.forms[0].txt_year5[6].value=parseInt(varLDays);  
                       v1=360-parseInt(varLDays);
                       if(parseInt(v1)<=parseInt(varDDays))
                       {
                      	 document.forms[0].txt_year5[8].value=parseInt(v1);
                      	 v3=parseInt(varDDays)-parseInt(v1);
                      	 countFlag="D";
                      	 if(parseInt(varDDays)==parseInt(v1))
                      	 {
                      		 countFlag="L";
                      		 v3=0;
                      	 }
                       }
                       else
                       {
                      	 document.forms[0].txt_year5[8].value=parseInt(varDDays);
                      	 v2=parseInt(v1)-parseInt(varDDays);                         
                      	 if(v2!=0)
                      	 {
                             if(parseInt(v2)<=parseInt(varLDays))
                             {
                          	   document.forms[0].txt_year5[6].value=parseInt(document.forms[0].txt_year5[6].value)+parseInt(v2);
                          	   v3=parseInt(varLDays)-parseInt(v2);
                          	   countFlag="L";
                          	   if(parseInt(varLDays)==parseInt(v2))
                          	   {
                          		   countFlag="D";
                          		   v3=0;
                          	   }                      	   
                             }
                             else
                             {
                          	   document.forms[0].txt_year5[6].value=parseInt(document.forms[0].txt_year5[6].value)+parseInt(varLDays);
                          	   v4=parseInt(v2)-parseInt(varLDays);
                          	   if(parseInt(v4)<=parseInt(varDDays))
                          	   {
                          		   document.forms[0].txt_year5[8].value=parseInt(document.forms[0].txt_year5[8].value)+parseInt(v4);
                          		   v3=parseInt(varDDays)-parseInt(v4);
                          		   countFlag="D";
                          		   if(parseInt(varDDays)==parseInt(v4))
                          		   {
                                       v3=0;
                                       countFlag="L";
                          		   }
                          		   
                          	   } 
                          	   else
                          	   {
                          		   document.forms[0].txt_year5[8].value=parseInt(document.forms[0].txt_year5[8].value)+parseInt(varDDays);
                          		   v3=parseInt(v4)-parseInt(varDDays); 
                          		   countFlag="L";                      		   
                          	   }                   
                             }
                             
                         	 }                  	 
                       }                                                       

                    }
                    }
                    else if(countFlag=="D")
                    {

                  	  if(parseInt(varDDays)>=360)
                        {
                            document.forms[0].txt_year5[8].value="360";
                            document.forms[0].txt_year5[6].value="0";
                            countFlag="D";
                        }
                        else
                        {
                           document.forms[0].txt_year5[8].value=parseInt(varDDays);  
                           v1=360-parseInt(varDDays);
                           if(parseInt(v1)<=parseInt(varLDays))
                           {
                          	 document.forms[0].txt_year5[6].value=parseInt(v1);
                          	 v3=parseInt(varLDays)-parseInt(v1);
                          	 countFlag="L";
                          	 if(parseInt(varLDays)==parseInt(v1))
                          	 {
                          		 countFlag="D";
                          		 v3=0;
                          	 }
                           }
                           else
                           {
                          	 document.forms[0].txt_year5[6].value=parseInt(varLDays);
                          	 v2=parseInt(v1)-parseInt(varLDays);                         
                          	 if(v2!=0)
                          	 {
                                 if(parseInt(v2)<=parseInt(varDDays))
                                 {
                              	   document.forms[0].txt_year5[8].value=parseInt(document.forms[0].txt_year5[8].value)+parseInt(v2);
                              	   v3=parseInt(varDDays)-parseInt(v2);
                              	   countFlag="D";
                              	   if(parseInt(varDDays)==parseInt(v2))
                              	   {
                              		   countFlag="L";
                              		   v3=0;
                              	   }                      	   
                                 }
                                 else
                                 {
                              	   document.forms[0].txt_year5[8].value=parseInt(document.forms[0].txt_year5[8].value)+parseInt(varDDays);
                              	   v4=parseInt(v2)-parseInt(varDDays);
                              	   if(parseInt(v4)<=parseInt(varLDays))
                              	   {
                              		   document.forms[0].txt_year5[6].value=parseInt(document.forms[0].txt_year5[6].value)+parseInt(v4);
                              		   v3=parseInt(varLDays)-parseInt(v4);
                              		   countFlag="L";
                              		   if(parseInt(varLDays)==parseInt(v4))
                              		   {
                                           v3=0;
                                           countFlag="D";
                              		   }
                              		   
                              	   } 
                              	   else
                              	   {
                              		   document.forms[0].txt_year5[6].value=parseInt(document.forms[0].txt_year5[6].value)+parseInt(varLDays);
                              		   v3=parseInt(v4)-parseInt(varLDays); 
                              		   countFlag="D";                      		   
                              	   }                   
                                 }
                                 
                             	 }                  	 
                           }                                                       

                        }

                    }
              }    

            } 

            else if(y==6)
            {
                if(v3!=0)
                {
                    if(countFlag=="D")
                    {
                    document.forms[0].txt_year6[8].value=parseInt(v3);                      
                    var vtemp=360-parseInt(v3);                     
                    if(parseInt(varLDays)>=parseInt(vtemp))
                    {
                        document.forms[0].txt_year6[6].value=parseInt(vtemp);                        
                        v3=parseInt(varLDays)-parseInt(vtemp); 
                        countFlag="L";   
                        if(parseInt(varLDays)==parseInt(vtemp))
                        {
                            v3=0;
                            countFlag="D";
                        }                   
                    }
                    else
                    {
                       document.forms[0].txt_year6[6].value=parseInt(varLDays);  
                       v1=parseInt(vtemp)-parseInt(varLDays);
                       if(parseInt(v1)<=parseInt(varDDays))
                       {
                      	 document.forms[0].txt_year6[8].value=parseInt(document.forms[0].txt_year6[8].value)+parseInt(v1);
                      	 v3=parseInt(varDDays)-parseInt(v1);
                      	 countFlag="D";
                      	 if(parseInt(v1)==parseInt(varDDays))
                      	 {
                              v3=0;
                              countFlag="L";
                      	 }
                       }
                       else
                       {
                      	 document.forms[0].txt_year6[8].value=parseInt(document.forms[0].txt_year6[8].value)+parseInt(varDDays);
                      	 v2=parseInt(v1)-parseInt(varDDays);                         	                         	
                      	 if(v2!=0)
                      	 {
                             if(v2<=varLDays)
                             {
                          	   document.forms[0].txt_year6[6].value=parseInt(document.forms[0].txt_year6[6].value)+parseInt(v2);
                          	   v3=parseInt(varLDays)-parseInt(v2);
                          	   countFlag="L";
                          	   if(parseInt(varLDays)==parseInt(v2))
                          	   {
                                  v3=0;
                                  countFlag="D";                                     
                          	   }
                          	   
                             }
                             else
                             {
                          	   document.forms[0].txt_year6[6].value=parseInt(document.forms[0].txt_year6[6].value)+parseInt(varLDays);
                          	   v3=parseInt(v2)-parseInt(varLDays);
                          	   countFlag="D";                            	   

                             }
                         	 }                  	 
                       }                                                       

                    }
                    } 
                    else if(countFlag=="L")
                    {
                    document.forms[0].txt_year6[6].value=parseInt(v3);                     
                    var vtemp=360-parseInt(v3);                    
                    if(parseInt(varDDays)>=parseInt(vtemp))
                    {
                        document.forms[0].txt_year6[8].value=parseInt(vtemp);                        
                        v3=parseInt(varDDays)-parseInt(vtemp); 
                        countFlag="D";   
                        if(parseInt(varDDays)==parseInt(vtemp))
                        {
                            v3=0;
                            countFlag="L"; 
                        }                   
                    }
                    else
                    {
                       document.forms[0].txt_year6[8].value=parseInt(varDDays);  
                       v1=parseInt(vtemp)-parseInt(varDDays);
                       if(parseInt(v1)<=parseInt(varLDays))
                       {
                      	 document.forms[0].txt_year6[6].value=parseInt(document.forms[0].txt_year6[6].value)+parseInt(v1);
                      	 v3=parseInt(varLDays)-parseInt(v1);
                      	 countFlag="L";
                      	 if(parseInt(varLDays)==parseInt(v1))
                      	 {
                      		 countFlag="D";
                      		 v3=0;
                      	 }
                       }
                       else
                       {
                      	 document.forms[0].txt_year6[6].value=parseInt(document.forms[0].txt_year6[6].value)+parseInt(varLDays);
                      	 v2=parseInt(v1)-parseInt(varLDays);                         	
                      	 if(v2!=0)
                      	 {
                             if(parseInt(v2)<=parseInt(varDDays))
                             {
                          	   document.forms[0].txt_year6[8].value=parseInt(document.forms[0].txt_year6[8].value)+parseInt(v2);
                          	   v3=parseInt(varDDays)-parseInt(v2);
                          	   countFlag="D";
                          	   if(parseInt(v2)==parseInt(varDDays))
                          	   {
                          		   countFlag="L"; 
                          		   v3=0;
                          	   }                            	   
                             }
                             else
                             {
                          	   document.forms[0].txt_year6[8].value=parseInt(document.forms[0].txt_year6[8].value)+parseInt(varDDays);
                          	   v3=parseInt(v2)-parseInt(varDDays);
                          	   countFlag="L";    	   
                          	   

                             }
                         	 }                  	 
                       }                                                       

                    }
                    }                                               

                }
                else
                {
                    if(countFlag=="L")
                    {
                    if(parseInt(varLDays)>=360)
                    {
                        document.forms[0].txt_year6[6].value="360";
                        document.forms[0].txt_year6[8].value="0";
                        countFlag="L";
                    }
                    else
                    {
                       document.forms[0].txt_year6[6].value=parseInt(varLDays);  
                       v1=360-parseInt(varLDays);
                       if(parseInt(v1)<=parseInt(varDDays))
                       {
                      	 document.forms[0].txt_year6[8].value=parseInt(v1);
                      	 v3=parseInt(varDDays)-parseInt(v1);
                      	 countFlag="D";
                      	 if(parseInt(varDDays)==parseInt(v1))
                      	 {
                      		 countFlag="L";
                      		 v3=0;
                      	 }
                       }
                       else
                       {
                      	 document.forms[0].txt_year6[8].value=parseInt(varDDays);
                      	 v2=parseInt(v1)-parseInt(varDDays);                         
                      	 if(v2!=0)
                      	 {
                             if(parseInt(v2)<=parseInt(varLDays))
                             {
                          	   document.forms[0].txt_year6[6].value=parseInt(document.forms[0].txt_year6[6].value)+parseInt(v2);
                          	   v3=parseInt(varLDays)-parseInt(v2);
                          	   countFlag="L";
                          	   if(parseInt(varLDays)==parseInt(v2))
                          	   {
                          		   countFlag="D";
                          		   v3=0;
                          	   }                      	   
                             }
                             else
                             {
                          	   document.forms[0].txt_year6[6].value=parseInt(document.forms[0].txt_year6[6].value)+parseInt(varLDays);
                          	   v4=parseInt(v2)-parseInt(varLDays);
                          	   if(parseInt(v4)<=parseInt(varDDays))
                          	   {
                          		   document.forms[0].txt_year6[8].value=parseInt(document.forms[0].txt_year6[8].value)+parseInt(v4);
                          		   v3=parseInt(varDDays)-parseInt(v4);
                          		   countFlag="D";
                          		   if(parseInt(varDDays)==parseInt(v4))
                          		   {
                                       v3=0;
                                       countFlag="L";
                          		   }
                          		   
                          	   } 
                          	   else
                          	   {
                          		   document.forms[0].txt_year6[8].value=parseInt(document.forms[0].txt_year6[8].value)+parseInt(varDDays);
                          		   v3=parseInt(v4)-parseInt(varDDays); 
                          		   countFlag="L";                      		   
                          	   }                   
                             }
                             
                         	 }                  	 
                       }                                                       

                    }
                    }
                    else if(countFlag=="D")
                    {

                  	  if(parseInt(varDDays)>=360)
                        {
                            document.forms[0].txt_year6[8].value="360";
                            document.forms[0].txt_year6[6].value="0";
                            countFlag="D";
                        }
                        else
                        {
                           document.forms[0].txt_year6[8].value=parseInt(varDDays);  
                           v1=360-parseInt(varDDays);
                           if(parseInt(v1)<=parseInt(varLDays))
                           {
                          	 document.forms[0].txt_year6[6].value=parseInt(v1);
                          	 v3=parseInt(varLDays)-parseInt(v1);
                          	 countFlag="L";
                          	 if(parseInt(varLDays)==parseInt(v1))
                          	 {
                          		 countFlag="D";
                          		 v3=0;
                          	 }
                           }
                           else
                           {
                          	 document.forms[0].txt_year6[6].value=parseInt(varLDays);
                          	 v2=parseInt(v1)-parseInt(varLDays);                         
                          	 if(v2!=0)
                          	 {
                                 if(parseInt(v2)<=parseInt(varDDays))
                                 {
                              	   document.forms[0].txt_year6[8].value=parseInt(document.forms[0].txt_year6[8].value)+parseInt(v2);
                              	   v3=parseInt(varDDays)-parseInt(v2);
                              	   countFlag="D";
                              	   if(parseInt(varDDays)==parseInt(v2))
                              	   {
                              		   countFlag="L";
                              		   v3=0;
                              	   }                      	   
                                 }
                                 else
                                 {
                              	   document.forms[0].txt_year6[8].value=parseInt(document.forms[0].txt_year6[8].value)+parseInt(varDDays);
                              	   v4=parseInt(v2)-parseInt(varDDays);
                              	   if(parseInt(v4)<=parseInt(varLDays))
                              	   {
                              		   document.forms[0].txt_year6[6].value=parseInt(document.forms[0].txt_year6[6].value)+parseInt(v4);
                              		   v3=parseInt(varLDays)-parseInt(v4);
                              		   countFlag="L";
                              		   if(parseInt(varLDays)==parseInt(v4))
                              		   {
                                           v3=0;
                                           countFlag="D";
                              		   }
                              		   
                              	   } 
                              	   else
                              	   {
                              		   document.forms[0].txt_year6[6].value=parseInt(document.forms[0].txt_year6[6].value)+parseInt(varLDays);
                              		   v3=parseInt(v4)-parseInt(varLDays); 
                              		   countFlag="D";                      		   
                              	   }                   
                                 }
                                 
                             	 }                  	 
                           }                                                       

                        }

                    }
              }    

            } 
            
           y++;          
        }
	}

	else
	{

	     <%
	     
	      for(int i=1;i<=6;i++)
	      {
	    	  %>
	    	  
	    	  document.forms[0].txt_year<%=i%>[6].value="0";
	    	  document.forms[0].txt_year<%=i%>[8].value="0";	    	
	    	  
	    	  
	    	<%  
	      }
	     %>
	  
	}
     	 
}
</script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onloading()">
<form name="frmDSCR" method="post">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()"> 
    <div class="menuitems">
      <script language="JavaScript1.2">

</script>
    </div>
</div>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="999" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Agriculture -&gt; Application -&gt; Agriculture -&gt; Income Statement</td>
	</tr>
</table>
<lapschoice:borrowertype /> 
<lapschoice:application />
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td><jsp:include page="../agr/Applurllinkagr.jsp" flush="true">
			<jsp:param name="pageid" value="125" />
			<jsp:param name="schemetype" value="<%=schemetype%>" />
		</jsp:include></td>
	</tr>
</table>
<table width="98%" border="0" cellspacing="0" cellpadding="3"
	class="outertable" align="center">
    <tr> 
      <td valign="top"> 
        <table width="100%" border="0" cellspacing="1" cellpadding="3">
          <tr  class="datagrid">
           <td><b>Cycle Days</b>&nbsp;<span class="mantatory">*</span></td>
           <td colspan="6">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="txt_cycledays" onblur="calDryDays()" onkeypress="allowInteger()" maxlength="15" size="18" value="<%=Helper.correctNull((String)hshValues.get("AGR_CYCLEDATA"))%>"></td>
          </tr>
           <tr  class="datagrid">
           <td><b>Lactation Days</b>&nbsp;<span class="mantatory">*</span></td>
           <td colspan="6">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="txt_lacdays"  onblur="calDryDays();calBatchCal();calBatch2Cal()" onkeypress="allowInteger()" maxlength="15" size="18" value="<%=Helper.correctNull((String)hshValues.get("AGR_LACTATIONDAYS"))%>"></td>
          </tr>
           <tr  class="datagrid">
           <td><b>Dry Days</b></td>
           <td colspan="6">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="txt_drydays"  onblur="calBatchCal()" onkeypress="allowInteger();calBatch2Cal()"  maxlength="15" size="18" value="<%=Helper.correctNull((String)hshValues.get("AGR_DRYDAYS"))%>"></td>
          </tr>
           <tr  class="datagrid">
           <td><b>Purchase of II Batch</b>&nbsp;<span class="mantatory">*</span></td>
           <td colspan="6">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="txt_batch2days" onblur="calBatchCal();calBatch2Cal()" onkeypress="allowInteger()" maxlength="15" size="18" value="<%=Helper.correctNull((String)hshValues.get("AGR_BATCH2DAYS"))%>"></td>
          </tr>
          <tr align="center" class="dataheader"> 
            <td WIDTH="21%">Particulars</td>
            <td WIDTH="13%">YEAR I</td>
            <td WIDTH="12%">YEAR II</td>
            <td WIDTH="14%">YEAR III</td>
            <td WIDTH="14%">YEAR IV</td>
            <td WIDTH="13%">YEAR V</td>
            <td WIDTH="13%">YEAR VI</td>
          </tr>
          <%
				for (int i = 0; i < strDesc.length; i++) {
				if(iarrSize>0&&iarrSize>i)
				{
					arrCol=new ArrayList();	
					arrCol=(ArrayList)arrRow.get(i);
					if(arrCol!=null && arrCol.size()>0)
					{
			%>
          <tr class="datagrid" align="center"> 
            <td align="left" WIDTH="21%"><b><%=strDesc[i]%> 
              <%if(i==10) {%>
              <%=strMilkYiedltr%> &nbsp; lt/day ltrs 
              <%}
             else if(i==11) {%>
              <%=nf.format(FwHelper.parseDouble(strMilkCost))%> &nbsp; /lt 
              <%}
             else if(i==12) {%>
              <b><%=nf.format(FwHelper.parseDouble(strBuffaloesCost))%></b> &nbsp; 
              /each 
              <%}
             else if(i==13) {%>
              <%=nf.format(FwHelper.parseDouble(strManureCost))%> &nbsp; /animal 
              <%} %>
              </b> </td>
            <td WIDTH="13%"> 
              <input type="text" maxlength="15" tabindex="1"
					name="txt_year1" 
					size="18"
					onKeyPress="allowInteger()"
						onblur="calculateToatalAdult()"
					style="text-align: right" value="<%=Helper.correctInt((String)arrCol.get(0))%>">
            </td>
            <td WIDTH="12%"> 
              <input type="text" maxlength="15" tabindex="2"
					name="txt_year2"  size="18" onKeyPress="allowInteger()"
						onblur="calculateToatalAdult()"
					style="text-align: right" value="<%=Helper.correctInt((String)arrCol.get(1))%>">
            </td>
            <td WIDTH="14%"> 
              <input type="text" maxlength="15" tabindex="3"
					name="txt_year3" size="18" onKeyPress="allowInteger()"
						onblur="calculateToatalAdult()"
					style="text-align: right" value="<%=Helper.correctInt((String)arrCol.get(2))%>">
            </td>
            <td WIDTH="14%"> 
              <input type="text" maxlength="15" tabindex="4"
					name="txt_year4"  size="18" onKeyPress="allowInteger(this)"
						onblur="calculateToatalAdult()"
					style="text-align: right" value="<%=Helper.correctInt((String)arrCol.get(3))%>">
            </td>
            <td WIDTH="13%"> 
              <input type="text" maxlength="15" tabindex="5"
					name="txt_year5" size="18" onKeyPress="allowInteger()"
						onblur="calculateToatalAdult()"
					style="text-align: right" value="<%=Helper.correctInt((String)arrCol.get(4))%>">
            </td>
            <td WIDTH="13%"> 
              <input type="text" maxlength="15" tabindex="6"
					name="txt_year6"  size="18"  onKeyPress="allowInteger()"
						onblur="calculateToatalAdult()"
					style="text-align: right" value="<%=Helper.correctInt((String)arrCol.get(5))%>">
            </td>
          </tr>
          <% }
            }else{%>
          <tr class="datagrid" align="center"> 
            <td align="left" WIDTH="21%"><b><%=strDesc[i]%> 
              <%if(i==10) {%>
              <%=strMilkYiedltr%> lt/day ltrs 
              <%}
             else if(i==11) {%>
              <%=nf.format(FwHelper.parseDouble(strMilkCost))%> /lt 
              <%}
             else if(i==12) {%>
              <%=nf.format(FwHelper.parseDouble(strBuffaloesCost))%> /each 
              <%}
             else if(i==13) {%>
              <%=nf.format(FwHelper.parseDouble(strManureCost))%> &nbsp; /animal 
              <%} %>
			  </b>
            </td>
            <td WIDTH="13%" align="center"> 
              <input type="text" maxlength="15" tabindex="1"
					name="txt_year1" size="18" onKeyPress="allowInteger()"
				onblur="calculateToatalAdult()"
				style="text-align: right" value="">
            </td>
            <td WIDTH="12%"> 
              <input type="text" maxlength="15" tabindex="2"
					name="txt_year2" size="18" onKeyPress="allowInteger()"
						onblur="calculateToatalAdult()"
					style="text-align: right" value="">
            </td>
            <td WIDTH="14%"> 
              <input type="text" maxlength="15" tabindex="3"
					name="txt_year3" size="18"  onKeyPress="allowInteger()"
						onblur="calculateToatalAdult()"
					style="text-align: right" value="">
            </td>
            <td WIDTH="14%"> 
              <input type="text" maxlength="15" tabindex="4"
					name="txt_year4" size="18" onKeyPress="allowInteger(this)"
						onblur="calculateToatalAdult()"
					style="text-align: right" value="">
            </td>
            <td WIDTH="13%"> 
              <input type="text" maxlength="15" tabindex="5"
					name="txt_year5"  size="18" onKeyPress="allowInteger()"
						onblur="calculateToatalAdult()"
					style="text-align: right" value="">
            </td>
            <td WIDTH="13%"> 
              <input type="text" maxlength="15" tabindex="6"
					name="txt_year6" size="18" onKeyPress="allowInteger()"
						onblur="calculateToatalAdult()"
					style="text-align: right" value="">
            </td>
          </tr>
          <%} 
         }%>
        </table>
      </td>
    </tr>
  </table>
  <br>
<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete" btnenable="Y" />
<lapschoice:hiddentag pageid="<%=PageId%>"/>
  <input type="hidden"
	name="hid_pagename" value="">
  <input type="hidden"
	name="hidAppType"
	value="<%=Helper.correctNull((String) hshValues.get("hidAppType"))%>">
<input type="hidden" name="hidFacSNo" value="<%=strFacSNo%>">
</form>
</body>
</html>