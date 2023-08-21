<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>Milk Flow Chart</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var txt_lactrationdays= "<%=Helper.correctNull((String)hshValues.get("txt_lactrationdays"))%>"
var txt_drydays = "<%=Helper.correctNull((String)hshValues.get("txt_drydays"))%>" 
var txt_months = "<%=Helper.correctNull((String)hshValues.get("txt_months"))%>" 
var batch_purchased = "<%=Helper.correctNull((String)hshValues.get("agr_batch_purchased"))%>" 


function clearfields()
{
	var lactationdays = document.forms[0].txt_lactrationdays.value;
	var drydays = document.forms[0].txt_drydays.value;
	
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].value="";
		}		
	}		
	document.forms[0].txt_months.disabled=false;
	document.forms[0].txt_months.value=0;
	document.forms[0].txt_lactrationdays.value=lactationdays;
	document.forms[0].txt_drydays.value=drydays;
	/*if(document.forms[0].hideditflag.value == "edit")
	{
		document.forms[0].txt_lactrationdays.value="";
		document.forms[0].txt_drydays.value="";
		document.forms[0].txt_months.value=0;
	}*/
}

function enableButtons(bool1, bool2, bool3, bool4, bool5, bool6)
{
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool5;
	document.forms[0].cmdclose.disabled = bool6;
}

function doSave()
{  

    enableButtons(true, true, true, false, true, true);
    callLDCows();
    callLDCows1();
    calltotal();
    if(batch_purchased=='2' && document.forms[0].txt_months.value=='0')
    {
   	 alert("Select the Interval Between Batches in Months");
   	 return;
    }
    var milkingdays1=document.forms[0].txt_lactrationdays.value;
	var drydays1=document.forms[0].txt_drydays.value;
	if(milkingdays1=="")
	{
		milkingdays1=0;
	}
	if(drydays1=="")
	{
		drydays1=0;
	}
	if((eval(milkingdays1)+eval(drydays1))==360)
	{
		document.forms[0].hidBeanId.value="agriculture";		
		document.forms[0].hidSourceUrl.value="/action/agr_LDCows.jsp";
		document.forms[0].hidBeanMethod.value="updateLDdata";
		document.forms[0].hidBeanGetMethod.value="getLDdata";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
	}
	else
	{
		alert("Total of Lactation and Dry days are not equal to 360");
	}
}

function doEdit()
{
 	document.forms[0].txt_lactrationdays.readOnly=false;
  	document.forms[0].txt_drydays.readOnly=false;
	document.forms[0].hideditflag.value ="edit";
	document.forms[0].hidAction.value ="insert";
	//clearfields();
	disablefields(false);
	enableButtons(true, true, false, false, false, true);		
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidAction.value ="";
		document.forms[0].hidBeanId.value="agriculture";
		document.forms[0].hidBeanGetMethod.value="getLDdata";
		document.forms[0].action=appURL+"action/agr_LDCows.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
	}	
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].hidBeanId.value="agriculture";		
		document.forms[0].hidSourceUrl.value="/action/agr_LDCows.jsp";
		document.forms[0].hidBeanMethod.value="updateLDdata";
		document.forms[0].hidBeanGetMethod.value="getLDdata";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
	}	
}

function doClose()
{
	if( ConfirmMsg(100))
	{
		document.forms[0].target="_parent";
		document.forms[0].action=appURL+"action/"+"persearch.jsp";
		document.forms[0].submit();
	}
}

function check()
{
	var milkingdays1=document.forms[0].txt_lactrationdays.value;
	var drydays1=document.forms[0].txt_drydays.value;
	var months=document.forms[0].txt_months.value;
 	if(milkingdays1=="")
	{
		document.forms[0].txt_lactrationdays.value=280;
	    document.forms[0].txt_drydays.value=80;
    }
	if(eval(milkingdays1)<280)
	{
		alert("Milking Days should not be less than 280 days");
		document.forms[0].txt_lactrationdays.value=280;
		document.forms[0].txt_drydays.value=0;
		document.forms[0].txt_lactrationdays.focus();
		return;
	}
	if(eval(milkingdays1)>360)
	{
		alert("Milking Days should not exceed 360 days");
		document.forms[0].txt_lactrationdays.value=280;
		document.forms[0].txt_drydays.value=0;
		document.forms[0].txt_lactrationdays.focus();
		return;
	}
	if(eval(drydays1)>80)
	{
		alert("Dry Days should not exceed 80 days");
		document.forms[0].txt_lactrationdays.value=280;
		document.forms[0].txt_drydays.value=0;
		document.forms[0].txt_drydays.focus();	
		return;
	}
	if(eval(drydays1)<0)
	{
		alert("Dry Days should not be less than 0 days");
		document.forms[0].txt_lactrationdays.value=280;
		document.forms[0].txt_drydays.value=0;
		document.forms[0].txt_drydays.focus();
		return;
	}
	if(eval(months)>6)
	{
		alert("Months should not exceed more than 6 months");
		document.forms[0].txt_months.value=1;
		document.forms[0].txt_months.focus();		
		return;
	}
}

 function totlacDry()
 {
 
   var lacdry="";
   lacdry = eval(document.forms[0].txt_lactrationdays.value)+eval(document.forms[0].txt_drydays.value);
   if(eval(lacdry)>360)
    {
     alert("Total of Dry Days and Lactation days should not exceed 360 days");
     document.forms[0].txt_lactrationdays.value=280;
	 document.forms[0].txt_drydays.value=0;
	 return;
	 }
  
  }



function callLDCows1()
{
    if(document.forms[0].txt_months.value!="0")
	{
	var milkingdays1="";
	var lactationday1="";
	var drydays1="";var lactationday=360;
	var months=document.forms[0].txt_months.value;
	var milkingdays1=document.forms[0].txt_lactrationdays.value;
	var drydays1=document.forms[0].txt_drydays.value;
	if(milkingdays1=="")
	{
		document.forms[0].txt_lactrationdays.value=280;
	    document.forms[0].txt_drydays.value=80;
		return;
	}	
	if(drydays1=="")
	{
		document.forms[0].txt_lactrationdays.value=280;
	    document.forms[0].txt_drydays.value=80;
		return;
	}	
  	if(months=="")
	{
		months=6;
	}	
   	var days1=eval(months)*30;
   	lactationday1=360-eval(days1);	
    var IL= eval(milkingdays1) - 30;
	document.forms[0].txtIL.value = eval(IL);
	
	if(eval(IL)>eval(lactationday1))
	{
		document.forms[0].txtIL.value=eval(lactationday1);
		document.forms[0].txtIIL.value=eval(IL)-eval(lactationday1);
		document.forms[0].txtIID.value=eval(drydays1);
		document.forms[0].txtID.value="0";
		jjh=eval(lactationday)-(eval(document.forms[0].txtIIL.value)+eval(document.forms[0].txtIID.value));
		if(eval(jjh)>eval(milkingdays1))
		{
			document.forms[0].txt_IIbatchIIL.value=eval(milkingdays1);
			document.forms[0].txt_IIbatchIID.value=eval(jjh)-eval(document.forms[0].txt_IIbatchIIL.value);
		}
		IL1 = eval(lactationday1) - eval(document.forms[0].txtIL.value);
	}
	else
	{
		IL1 = eval(lactationday1) - eval(document.forms[0].txtIL.value);
	}
	if(eval(months)==1)
	{
		if(eval(milkingdays1)==360)
		{
			document.forms[0].txtIL.value = eval(lactationday1);
			document.forms[0].txtID.value ="0";
			document.forms[0].txtIIL.value="0";		    
			document.forms[0].txtIID.value=eval(drydays1);
		}
		if(eval(document.forms[0].txtIID.value)==eval(drydays1))
		{
			document.forms[0].txt_IIbatchIID.value="0";
			document.forms[0].txt_IIbatchIIL.value=eval(lactationday)-(eval(document.forms[0].txtIIL.value)+eval(document.forms[0].txtIID.value));
			IL1 = eval(lactationday1) - eval(document.forms[0].txtIL.value);
		}
	}
	if(eval(months)>=2)
	{
		if(eval(milkingdays1)>=340)
		{
			document.forms[0].txtIL.value = eval(lactationday1);
			document.forms[0].txtID.value ="0";
			document.forms[0].txtIIL.value=eval(IL)-eval(lactationday1);
		   	document.forms[0].txtIID.value=eval(drydays1);
			if(eval(document.forms[0].txtIID.value)==eval(drydays1))
			{
				document.forms[0].txt_IIbatchIID.value="0";
				document.forms[0].txt_IIbatchIIL.value=eval(lactationday)-(eval(document.forms[0].txtIIL.value)+eval(document.forms[0].txtIID.value));
				IL1 = eval(lactationday1) - eval(document.forms[0].txtIL.value);
			}
	 	}
	}    
	if(eval(document.forms[0].txtID)!="0")
	{	
		if(eval(IL1)!="0")
		{
			if(eval(IL1)<eval(drydays1))
			{
				document.forms[0].txtID.value=eval(IL1);
				document.forms[0].txtIID.value=eval(drydays1)-eval(document.forms[0].txtID.value);				
				document.forms[0].txt_IIbatchIL.value=eval(lactationday1)-(eval(document.forms[0].txtIL.value)+eval(document.forms[0].txtID.value));
				var IIL1=eval(lactationday)-eval(document.forms[0].txtIID.value);
			}
    	}
     	if(eval(IL1)>eval(drydays1))
		{
			document.forms[0].txtID.value=eval(drydays1);
			document.forms[0].txt_IIbatchIL.value=eval(lactationday1)-(eval(document.forms[0].txtIL.value)+eval(document.forms[0].txtID.value));
			document.forms[0].txtIIL.value=eval(milkingdays1)-eval(document.forms[0].txt_IIbatchIL.value);
			document.forms[0].txtIID.value=eval(drydays1);
			document.forms[0].txt_IIbatchIIL.value=eval(lactationday)-(eval(document.forms[0].txtIIL.value)+eval(document.forms[0].txtIID.value));
		}
	    if(eval(IL1)==eval(drydays1))
		{
			document.forms[0].txtID.value=eval(IL1);
			document.forms[0].txtIIL.value=eval(milkingdays1);
			document.forms[0].txtIID.value=eval(drydays1);
			document.forms[0].txt_IIbatchIIL.value=eval(lactationday)-(eval(document.forms[0].txtIIL.value)+eval(document.forms[0].txtIID.value));
		}
    }    
    if(eval(IIL1)<eval(milkingdays1))
    {
	    document.forms[0].txtIIL.value=eval(IIL1);
	    document.forms[0].txtIIIL.value=eval(milkingdays1)-eval(document.forms[0].txtIIL.value);
	    document.forms[0].txtIIID.value=eval(drydays1);
	    document.forms[0].txt_IIbatchIIIL.value=eval(lactationday)-(eval( document.forms[0].txtIIIL.value)+eval(document.forms[0].txtIIID.value));
    }
    if(eval(IIL1)==eval(milkingdays1))
    {   
    	document.forms[0].txtIIL.value=eval(milkingdays1);
     	document.forms[0].txtIIID.value=eval(drydays1);
    	IIK4=eval(lactationday)-eval(document.forms[0].txtIIID.value);
     	if(eval(IIK4)<eval(milkingdays1))
     	{
      		document.forms[0].txtIIIL.value=eval(IIK4);
      		document.forms[0].txtIVL.value=eval(milkingdays1)-eval(IIK4);
      		document.forms[0].txtIVD.value=eval(drydays1);
     		document.forms[0].txt_IIbatchIVL.value=eval(lactationday)-(eval( document.forms[0].txtIVL.value)+eval(document.forms[0].txtIVD.value));
     	}
    }
    if(eval(IIL1)>eval(milkingdays1))
    {
	    document.forms[0].txtIIL.value=eval(milkingdays1);
	    IIK1=eval(lactationday)-(eval( document.forms[0].txtIIL.value)+eval( document.forms[0].txtIID.value));
	    if(eval(IIK1)<eval(drydays1))
	    {
		    document.forms[0].txt_IIbatchIID.value=eval(IIK1);
		    document.forms[0].txt_IIbatchIIL.value=eval(lactationday)-(eval( document.forms[0].txtIIL.value)+eval(document.forms[0].txtIID.value)+eval(document.forms[0].txt_IIbatchIID.value))
	    }
	    if(eval(IIK1)==eval(drydays1))
	    {
		    document.forms[0].txt_IIbatchIID.value=eval(IIK1);
		    document.forms[0].txt_IIbatchIIL.value=eval(lactationday)-(eval( document.forms[0].txtIIL.value)+eval(document.forms[0].txtIID.value)+eval(document.forms[0].txt_IIbatchIID.value))
	    }
	    if(eval(document.forms[0].txt_IIbatchIID.value)==eval(drydays1))
	    {
		    document.forms[0].txtIIIL.value=eval(milkingdays1);
		    document.forms[0].txtIIID.value=eval(drydays1);
		    document.forms[0].txt_IIbatchIIIL.value=eval(lactationday)-(eval(document.forms[0].txtIIIL.value)+eval(document.forms[0].txtIIID.value));
    	}
	    if(eval(document.forms[0].txt_IIbatchIID.value)!=eval(drydays1))
	    {
		    if(eval(document.forms[0].txt_IIbatchIID.value)>0)
		    {
   	 			document.forms[0].txtIIID.value=eval(drydays1)-eval(document.forms[0].txt_IIbatchIID.value);
   				var  kk1=eval(lactationday)-eval(document.forms[0].txtIIID.value);
    			if(eval(kk1)>eval(milkingdays1))
    			{
     				document.forms[0].txtIIIL.value=eval(milkingdays1);
     				document.forms[0].txt_IIbatchIIID.value=eval(lactationday)-(eval( document.forms[0].txtIIIL.value)+eval(document.forms[0].txtIIID.value));
     			}
     			if(eval(kk1)==eval(milkingdays1))
    			{
     				document.forms[0].txtIIIL.value=eval(milkingdays1);
		      		document.forms[0].txtIVD.value=eval(drydays1);
		      		document.forms[0].txt_IIbatchIIIL.value=eval(lactationday)-(eval( document.forms[0].txtIIIL.value)+eval(document.forms[0].txtIIID.value));
		     		DDF1=eval(lactationday)-eval( document.forms[0].txtIVD.value);
		     		if(eval(DDF1)<eval(milkingdays1))
     				{
				     	document.forms[0].txtIVL.value=eval(DDF1);
				     	document.forms[0].txt_IIbatchIVL.value=eval(lactationday)-(eval( document.forms[0].txtIVL.value)+eval(document.forms[0].txtIVD.value));
				     	document.forms[0].txtVL.value=eval(milkingdays1)-eval(document.forms[0].txtIVL.value);
				     	document.forms[0].txtVD.value=eval(drydays1);
				     	document.forms[0].txt_IIbatchVL.value=eval(lactationday)-(eval( document.forms[0].txtVL.value)+eval(document.forms[0].txtVD.value));
    				}
     				if((eval(document.forms[0].txt_IIbatchVL.value)>0))
     				{
					    document.forms[0].txtVIL.value=eval(milkingdays1)-eval(document.forms[0].txt_IIbatchVL.value);
  						VIL1=eval(lactationday)-eval(document.forms[0].txtVIL.value);
   						if(eval(VIL1)>eval(drydays1))
  						{
					   		document.forms[0].txtVID.value=eval(drydays1);
					   		document.forms[0].txt_IIbatchVIL.value=eval(lactationday)-(eval(document.forms[0].txtVIL.value)+eval(document.forms[0].txtVID.value));
   						}
   						if(eval(VIL1)<eval(drydays1))
   						{
					   		document.forms[0].txtVID.value=eval(VIL1);
					   		document.forms[0].txtVIID.value=eval(drydays1)-eval(VIL1);
					   		document.forms[0].txt_IIbatchVIL.value=eval(lactationday)-(eval(document.forms[0].txtVIL.value)+eval(document.forms[0].txtVID.value));
					   		VIIDm1=eval(lactationday)-eval(document.forms[0].txtVIID.value);
   
   							if(eval(VIIDm1)<eval(milkingdays1))
   							{
   								document.forms[0].txtVIIL.value=eval(VIIDm1);
    							document.forms[0].txt_IIbatchVIID.value=eval(lactationday)-(eval(document.forms[0].txtVIIL.value)+eval(document.forms[0].txtVIID.value));
   							}
   							if(eval(VIIDm1)>eval(milkingdays1))
   							{
   								document.forms[0].txtVIIL.value=eval(milkingdays1);
   								document.forms[0].txt_IIbatchVIID.value=eval(lactationday)-(eval(document.forms[0].txtVIIL.value)+eval(document.forms[0].txtVIID.value));
   							}
   							if(eval(VIIDm1)==eval(milkingdays1))
   							{
   								document.forms[0].txtVIIL.value=eval(VIIDm1);
   							}
   						}
   					}  
  				}
    		}
      		if(eval(kk1)<eval(milkingdays1))
    		{
     			document.forms[0].txtIIIL.value=eval(kk1);
     			document.forms[0].txtIVL.value=eval(milkingdays1)-eval(document.forms[0].txtIIIL.value);
      			document.forms[0].txtIVD.value=eval(drydays1);
      			document.forms[0].txt_IIbatchIIID.value=eval(lactationday)-(eval( document.forms[0].txtIIIL.value)+eval(document.forms[0].txtIIID.value));
      			document.forms[0].txt_IIbatchIIIL.value=eval(lactationday)-(eval( document.forms[0].txtIIIL.value)+eval(document.forms[0].txtIIID.value));
      			document.forms[0].txt_IIbatchIVL.value=eval(lactationday)-(eval( document.forms[0].txtIVL.value)+eval(document.forms[0].txtIVD.value));
    		}
     		if(eval(document.forms[0].txt_IIbatchIIID.value)==eval(drydays1))
    		{
   
    			document.forms[0].txtIVL.value=eval(milkingdays1);
    			kk2=eval(lactationday)-eval(document.forms[0].txtIVL.value);
    			if(eval(kk2)>eval(drydays1))
    			{
     				document.forms[0].txtIVD.value=eval(drydays1);
      				document.forms[0].txt_IIbatchIVL.value=eval(lactationday)-(eval( document.forms[0].txtIVL.value)+eval(document.forms[0].txtIVD.value));
    			}
    		}
    		if(eval(document.forms[0].txt_IIbatchIIID.value)>0)
    		{
    			if(eval(document.forms[0].txt_IIbatchIIID.value)<eval(drydays1))
    			{
   					document.forms[0].txtIVD.value=eval(drydays1)-eval(document.forms[0].txt_IIbatchIIID.value);
    				kD2=eval(lactationday)-eval(document.forms[0].txtIVD.value);
    				if(eval(kD2)>eval(milkingdays1))
    				{
     					document.forms[0].txtIVL.value=eval(milkingdays1);
      					document.forms[0].txt_IIbatchIVD.value=eval(lactationday)-(eval( document.forms[0].txtIVL.value)+eval(document.forms[0].txtIVD.value));
    				}
     				if(eval(kD2)==eval(milkingdays1))
    				{
     					document.forms[0].txtIVL.value=eval(milkingdays1);
      					document.forms[0].txt_IIbatchIVD.value=eval(lactationday)-(eval( document.forms[0].txtIVL.value)+eval(document.forms[0].txtIVD.value));
     					document.forms[0].txtVD.value=eval(drydays1);
     					gg1=eval(lactationday)-eval(document.forms[0].txtVD.value);
     					if(eval(gg1)<eval(milkingdays1))
   						{
      						document.forms[0].txtVL.value=eval(gg1);
       						document.forms[0].txt_IIbatchVL.value=eval(lactationday)-(eval( document.forms[0].txtVL.value)+eval(document.forms[0].txtVD.value));
      						document.forms[0].txtVIL.value=eval(milkingdays1)-eval( document.forms[0].txtVL.value);
     						document.forms[0].txtVID.value=eval(drydays1);
       						document.forms[0].txt_IIbatchVIL.value=eval(lactationday)-(eval( document.forms[0].txtVIL.value)+eval(document.forms[0].txtVID.value));
     					}
    				}
     				if(eval(kD2)<eval(milkingdays1))
    				{
     					document.forms[0].txtIVL.value=eval(kD2);
     					document.forms[0].txtVL.value=eval(milkingdays1)-eval(document.forms[0].txtIVL.value);
     					document.forms[0].txtVD.value=eval(drydays1);
      					document.forms[0].txt_IIbatchIVD.value=eval(lactationday)-(eval( document.forms[0].txtIVL.value)+eval(document.forms[0].txtIVD.value));
    					document.forms[0].txt_IIbatchIVD.value=eval(lactationday)-(eval( document.forms[0].txtIVL.value)+eval(document.forms[0].txtIVD.value));
   						document.forms[0].txt_IIbatchVL.value=eval(lactationday)-(eval( document.forms[0].txtVL.value)+eval(document.forms[0].txtVD.value));
    				}
        		}
       		}
     		if(eval(document.forms[0].txt_IIbatchIVD.value)>0)
    		{
     			if(eval(document.forms[0].txt_IIbatchIVD.value)<eval(drydays1))
     			{
     				document.forms[0].txtVD.value=eval(drydays1)-eval(document.forms[0].txt_IIbatchIVD.value);
    				VL1=eval(lactationday)-eval(document.forms[0].txtVD.value);
     				if(eval(VL1)<eval(milkingdays1))
       				{
				     	document.forms[0].txtVL.value=eval(VL1);
				     	document.forms[0].txt_IIbatchVL.value=eval(lactationday)-(eval(document.forms[0].txtVL.value)+eval(document.forms[0].txtVD.value));
				     	document.forms[0].txtVIL.value=(eval(milkingdays1)-eval(document.forms[0].txtVL.value));
				     	document.forms[0].txtVID.value=eval(drydays1);
				     	document.forms[0].txt_IIbatchVIL.value=eval(lactationday)-(eval(document.forms[0].txtVIL.value)+eval(document.forms[0].txtVID.value));
      				}
      				if(eval(VL1)>eval(milkingdays1))
      				{
    					document.forms[0].txtVL.value=eval(milkingdays1);
   						document.forms[0].txt_IIbatchVD.value=eval(lactationday)-(eval(document.forms[0].txtVL.value)+eval(document.forms[0].txtVD.value));
      				}
      				if(eval(VL1)==eval(milkingdays1))
     				{
   						document.forms[0].txtVL.value=eval(milkingdays1);
  						document.forms[0].txt_IIbatchVL.value=eval(lactationday)-(eval(document.forms[0].txtVL.value)+eval(document.forms[0].txtVD.value));
   						document.forms[0].txtVID.value=eval(drydays1);
   						document.forms[0].txtVIL.value=eval(lactationday)-eval(document.forms[0].txtVID.value);
   						document.forms[0].txt_IIbatchVIL.value=eval(lactationday)-(eval(document.forms[0].txtVIL.value)+eval(document.forms[0].txtVID.value));
   						document.forms[0].txtVIIL.value=eval(milkingdays1)-eval( document.forms[0].txtVIL.value);
   						document.forms[0].txtVIID.value=eval(drydays1);
   						document.forms[0].txt_IIbatchVIIL.value=eval(lactationday)-(eval(document.forms[0].txtVIIL.value)+eval(document.forms[0].txtVIID.value));
     				} 
      			}
   			}
     		if(eval(document.forms[0].txt_IIbatchVD.value)>0)
    		{
     			if(eval(document.forms[0].txt_IIbatchVD.value)<eval(drydays1))
     			{
       				document.forms[0].txtVID.value=eval(drydays1)-eval(document.forms[0].txt_IIbatchVD.value);
        			LL1=eval(lactationday)-eval(document.forms[0].txtVID.value);
        			if(eval(LL1)>eval(milkingdays1))
        			{
         				document.forms[0].txtVIL.value=eval(milkingdays1);
        				document.forms[0].txt_IIbatchVID.value=eval(lactationday)-(eval( document.forms[0].txtVIL.value)+eval(document.forms[0].txtVID.value));
        			}
        			if(eval(LL1)==eval(milkingdays1))
        			{
         				document.forms[0].txtVIL.value=eval(milkingdays1);
        				document.forms[0].txt_IIbatchVID.value=eval(lactationday)-(eval( document.forms[0].txtVIL.value)+eval(document.forms[0].txtVID.value));
        			}
       			}
       		}
       		if(eval(document.forms[0].txt_IIbatchVID.value)==eval(drydays1))
       		{
       			document.forms[0].txtVIIL.value=eval(milkingdays1);
       			ffr=eval(lactationday)-eval(document.forms[0].txtVIIL.value);
       			if(eval(ffr)>eval(drydays1))
       			{
       				document.forms[0].txtVIID.value=eval(drydays1);
      				document.forms[0].txt_IIbatchVIIL.value=eval(ffr)-eval(document.forms[0].txtVIID.value);
       			}
       		}
       		if(eval(document.forms[0].txt_IIbatchVID.value)!=eval(drydays1))
       		{
        		if(eval(document.forms[0].txt_IIbatchVID.value)>0)
       			{
        			if(eval(document.forms[0].txt_IIbatchVID.value)<eval(drydays1))
        			{      
       					document.forms[0].txtVIID.value=eval(drydays1)-eval(document.forms[0].txt_IIbatchVID.value);
        				LL2=eval(lactationday)-eval(document.forms[0].txtVIID.value);
         				if(eval(LL2)>eval(milkingdays1))
         				{
         					document.forms[0].txtVIIL.value=eval(milkingdays1);
        					document.forms[0].txt_IIbatchVIID.value=eval(lactationday)-(eval( document.forms[0].txtVIIL.value)+eval(document.forms[0].txtVIID.value));
     					}
         				if(eval(LL2)<eval(milkingdays1))
         				{
         					document.forms[0].txtVIIL.value=eval(LL2);
         					document.forms[0].txt_IIbatchVIIL.value=eval(lactationday)-(eval( document.forms[0].txtVIIL.value)+eval(document.forms[0].txtVIID.value));
        				}
       				}
       			}
       		}
       		if(eval(document.forms[0].txt_IIbatchVID.value)==0)
       		{
       			document.forms[0].txtVIID.value=eval(drydays1);
        		LL3=eval(lactationday)-eval(document.forms[0].txtVIID.value);
        		if(eval(LL3)>eval(milkingdays1))
        		{
         			document.forms[0].txtVIIL.value=eval(milkingdays1);
        			document.forms[0].txt_IIbatchVIID.value=eval(lactationday)-(eval( document.forms[0].txtVIIL.value)+eval(document.forms[0].txtVIID.value));
        		}
         		if(eval(LL3)<eval(milkingdays1))
         		{
         			document.forms[0].txtVIIL.value=eval(LL3);
        			document.forms[0].txt_IIbatchVIIL.value=eval(lactationday)-(eval( document.forms[0].txtVIIL.value)+eval(document.forms[0].txtVIID.value));
        		}
       		}
    	}
    }
    IIK1=eval(lactationday)-(eval( document.forms[0].txtIIL.value)+eval( document.forms[0].txtIID.value));
    ggt=eval(lactationday)-eval(document.forms[0].txtVIID.value);
    if(eval(ggt)==eval(milkingdays1))
    {
      	document.forms[0].txtVIIL.value=eval(milkingdays1);
    }
    if(eval(document.forms[0].txtIID.value)==eval(drydays1))
    {
      	if(eval(IIK1)<eval(drydays1))
     	{
    		document.forms[0].txt_IIbatchIIL.value=eval(IIK1);
     	}
    	if(eval(document.forms[0].txtIIL.value)==eval(milkingdays1))
    	{
    		if(eval(document.forms[0].txtIID.value)==eval(drydays1))
    		{
    			document.forms[0].txtIIIL.value=eval(milkingdays1);
    			document.forms[0].txtIIID.value=eval(drydays1);
    			document.forms[0].txtIVL.value=eval(milkingdays1);
			    document.forms[0].txtIVD.value=eval(drydays1);
			    document.forms[0].txtVL.value=eval(milkingdays1);
			    document.forms[0].txtVD.value=eval(drydays1);
			    document.forms[0].txtVIL.value=eval(milkingdays1);
			    document.forms[0].txtVID.value=eval(drydays1);
			    document.forms[0].txtVIIL.value=eval(milkingdays1);
			    document.forms[0].txtVIID.value=eval(drydays1);
    		}
    	}
    }
    if(eval(document.forms[0].txtIID.value)!=eval(drydays1))
    {
     	if(eval(IIK1)>eval(drydays1))
   		{
   			document.forms[0].txt_IIbatchIID.value=eval(drydays1);
    		document.forms[0].txt_IIbatchIIL.value=eval(lactationday)-(eval( document.forms[0].txtIIL.value)+eval(document.forms[0].txtIID.value)+eval(document.forms[0].txt_IIbatchIID.value))
    	}
    }   
    if(eval(document.forms[0].txtIID.value)==eval(drydays1))
    {
	    if(eval(IIK1)>eval(milkingdays1))
	    {
		    document.forms[0].txt_IIbatchIIL.value=eval(milkingdays1);
		    document.forms[0].txt_IIbatchIID.value=eval(lactationday)-(eval( document.forms[0].txtIIL.value)+eval(document.forms[0].txtIID.value)+eval(document.forms[0].txt_IIbatchIIL.value))
	    }
   		else
   		{
     		if(eval(IIK1)>eval(drydays1))
    		{
			    document.forms[0].txt_IIbatchIID.value="0";
			    document.forms[0].txt_IIbatchIIL.value=eval(lactationday)-(eval( document.forms[0].txtIIL.value)+eval(document.forms[0].txtIID.value)+eval(document.forms[0].txt_IIbatchIID.value))
    		}
		}
    }
   	if((eval(document.forms[0].txt_IIbatchIIL.value)==eval(milkingdays1)))
    {
    	if((eval(document.forms[0].txt_IIbatchIID.value)<eval(drydays1)))
     	{
      		document.forms[0].txtIIID.value=eval(drydays1)-eval(document.forms[0].txt_IIbatchIID.value);
       		VV1=eval(lactationday)-eval(document.forms[0].txtIIID.value);
       		if(eval(VV1)>eval(milkingdays1))
       		{
     			document.forms[0].txtIIIL.value=eval(milkingdays1);
      			document.forms[0].txt_IIbatchIIID.value=eval(lactationday)-(eval(document.forms[0].txtIIIL.value)+eval(document.forms[0].txtIIID.value));
      			document.forms[0].txtIVD.value=eval(drydays1)-eval( document.forms[0].txt_IIbatchIIID.value);
     			MMR=eval(lactationday)-eval(document.forms[0].txtIVD.value);
     			if(eval(MMR)>eval(milkingdays1))
     			{
     				document.forms[0].txtIVL.value=eval(milkingdays1);
       				document.forms[0].txt_IIbatchIVD.value=eval(lactationday)-(eval(document.forms[0].txtIVL.value)+eval(document.forms[0].txtIVD.value));
      				document.forms[0].txtVD.value=eval(drydays1)-eval(document.forms[0].txt_IIbatchIVD.value);
      				UU1=eval(lactationday)-eval( document.forms[0].txtVD.value);
      				if(eval(UU1)>eval(milkingdays1))
      				{
      					document.forms[0].txtVL.value=eval(milkingdays1);
      					gg1=eval(lactationday)-(eval(document.forms[0].txtVL.value)+eval(document.forms[0].txtVD.value));
      					if(eval(gg1)>eval(drydays1))
      					{
      						document.forms[0].txt_IIbatchVD.value=eval(drydays1);
       						document.forms[0].txt_IIbatchVL.value=eval(lactationday)-(eval(document.forms[0].txtVL.value)+eval(document.forms[0].txtVD.value)+eval(document.forms[0].txt_IIbatchVD.value));
      					}
        				if(eval(gg1)<eval(drydays1))
      					{
      						document.forms[0].txt_IIbatchVD.value=eval(gg1);
      						document.forms[0].txtVID.value=eval(drydays1)-eval(document.forms[0].txt_IIbatchVD.value);
      						tt1=eval(lactationday)-eval(document.forms[0].txtVID.value);
       						document.forms[0].txt_IIbatchVL.value=eval(lactationday)-(eval(document.forms[0].txtVL.value)+eval(document.forms[0].txtVD.value)+eval(document.forms[0].txt_IIbatchVD.value));
      						if(eval(tt1)>eval(milkingdays1))
     						{
      							document.forms[0].txtVIL.value=eval(milkingdays1);
      							document.forms[0].txt_IIbatchVID.value=eval(lactationday)-(eval(document.forms[0].txtVIL.value)+eval(document.forms[0].txtVID.value));
      							document.forms[0].txtVIID.value=eval(drydays1)-eval(document.forms[0].txt_IIbatchVID.value);
       							ER1=eval(lactationday)-eval(document.forms[0].txtVIID.value);
       							if(eval(ER1)>eval(milkingdays1))
       							{
       								document.forms[0].txtVIIL.value=eval(milkingdays1);
        							document.forms[0].txt_IIbatchVIID.value=eval(lactationday)-(eval(document.forms[0].txtVIIL.value)+eval(document.forms[0].txtVIID.value));
       							}
      						}
      					}
      				}
     			}
     		}
        }
    }
	if(eval(document.forms[0].txt_IIbatchIIL.value)>0)
   	{
   		if(eval(document.forms[0].txt_IIbatchIID.value)==eval(drydays1))
   		{
   			document.forms[0].txtIIIL.value=eval(milkingdays1)-eval(document.forms[0].txt_IIbatchIIL.value);
  			IIIL1=eval(lactationday)-eval(document.forms[0].txtIIIL.value);
   			if(eval(IIIL1)<eval(drydays1))
   			{
   				document.forms[0].txtIIID.value=eval(IIIL1);
  				document.forms[0].txtIVD.value=eval(drydays1)-eval(IIIL1);
    			document.forms[0].txt_IIbatchIIIL.value=eval(lactationday)-(eval(document.forms[0].txtIIIL.value)+eval(document.forms[0].txtIIID.value));
    			IVD=document.forms[0].txtIVD.value;
   			}
   			if(eval(IIIL1)==eval(drydays1))
   			{
			   	document.forms[0].txtIIID.value=eval(drydays1);
			   	document.forms[0].txtIVL.value=eval(milkingdays1)-eval(document.forms[0].txtIIIL.value);
			   	document.forms[0].txtIVD.value=eval(drydays1);
			   	document.forms[0].txt_IIbatchIVL.value=eval(lactationday)-(eval(document.forms[0].txtIVL.value)+eval(document.forms[0].txtIVD.value));
  			}
    		if(eval(IIIL1)>eval(drydays1))
   			{
  				document.forms[0].txtIIID.value=eval(drydays1);
   				document.forms[0].txt_IIbatchIIIL.value=eval(lactationday)-(eval(document.forms[0].txtIIIL.value)+eval(document.forms[0].txtIIID.value));
   			}
   		}
    }
    if((eval(document.forms[0].txt_IIbatchIIL.value)>0))
   	{
     	if((eval(document.forms[0].txt_IIbatchIIL.value)!=eval(milkingdays1)))
   		{ 
   			document.forms[0].txtIIIL.value=eval(milkingdays1)-eval(document.forms[0].txt_IIbatchIIL.value);
   			IIIL1=eval(lactationday)-eval(document.forms[0].txtIIIL.value);
   			if(eval(IIIL1)<eval(drydays1))
   			{
   				document.forms[0].txtIIID.value=eval(IIIL1);
   				document.forms[0].txtIVD.value=eval(drydays1)-eval(IIIL1);
    			document.forms[0].txt_IIbatchIIIL.value=eval(lactationday)-(eval(document.forms[0].txtIIIL.value)+eval(document.forms[0].txtIIID.value));
    			IVD=document.forms[0].txtIVD.value;
   				bb2=eval(lactationday)-eval(document.forms[0].txtIVD.value);
  				if(eval(bb2)>eval(milkingdays1))
   				{
   					document.forms[0].txtIVL.value=eval(milkingdays1);
   					document.forms[0].txt_IIbatchIVD.value=eval(lactationday)-(eval(document.forms[0].txtIVL.value)+eval(document.forms[0].txtIVD.value));
   					document.forms[0].txtVD.value=eval(drydays1)-eval( document.forms[0].txt_IIbatchIVD.value);
   					document.forms[0].txtVL.value=eval(lactationday)-eval(document.forms[0].txtVD.value);
   					document.forms[0].txtVIL.value=eval(milkingdays1)-eval( document.forms[0].txtVL.value);
 					document.forms[0].txtVID.value=eval(drydays1);
    				document.forms[0].txt_IIbatchVIL.value=eval(lactationday)-(eval(document.forms[0].txtVIL.value)+eval(document.forms[0].txtVID.value));
   				}
    			if(eval(bb2)==eval(milkingdays1))
   				{
   					document.forms[0].txtIVL.value=eval(milkingdays1);
   					document.forms[0].txt_IIbatchIVL.value=eval(lactationday)-(eval(document.forms[0].txtIVL.value)+eval(document.forms[0].txtIVD.value));
   					document.forms[0].txtVD.value=eval(drydays1);
   					document.forms[0].txtVL.value=eval(lactationday)-eval(document.forms[0].txtVD.value);
   					document.forms[0].txtVIL.value=eval(milkingdays1)-eval( document.forms[0].txtVL.value);
   					document.forms[0].txtVID.value=eval(drydays1);
    				document.forms[0].txt_IIbatchVIL.value=eval(lactationday)-(eval(document.forms[0].txtVIL.value)+eval(document.forms[0].txtVID.value));
   				}
   				if(eval(bb2)<eval(milkingdays1))
   				{
    				document.forms[0].txtIVL.value=eval(bb2);
   					document.forms[0].txtVL.value=eval(milkingdays1)-eval(document.forms[0].txtIVL.value);
    				document.forms[0].txtVD.value=eval(drydays1);
   					document.forms[0].txt_IIbatchVL.value=eval(lactationday)-(eval(document.forms[0].txtVL.value)+eval(document.forms[0].txtVD.value));
   				}
   			}
   			if(eval(IIIL1)==eval(drydays1))
   			{
  				document.forms[0].txtIIID.value=eval(drydays1);
    			document.forms[0].txtIVL.value=eval(milkingdays1)-eval(document.forms[0].txtIIIL.value);
    			document.forms[0].txtIVD.value=eval(drydays1);

   				document.forms[0].txt_IIbatchIVL.value=eval(lactationday)-(eval(document.forms[0].txtIVL.value)+eval(document.forms[0].txtIVD.value));
   			}
   			if(eval(document.forms[0].txt_months.value)==1)
   			{ 
  				if(eval(document.forms[0].txtIIIL.value)==eval(drydays1))
   				{
   					if(eval(document.forms[0].txtIIID.value)==eval(drydays1))
  					{
    					document.forms[0].txtIVL.value=eval(lactationday);
   						document.forms[0].txtIVD.value="0";
   						document.forms[0].txtVL.value=eval(drydays1);
   						document.forms[0].txtVD.value=eval(drydays1);
   						document.forms[0].txtVIL.value=eval(drydays1);
   						document.forms[0].txtVID.value=eval(drydays1);
    					document.forms[0].txtVIIL.value=eval(lactationday);
    					document.forms[0].txtVIID.value="0";
   					}
   				}
   			}
   			if(eval(IIIL1)>eval(drydays1))
   			{
   				document.forms[0].txtIIID.value=eval(drydays1);
   				document.forms[0].txt_IIbatchIIIL.value=eval(lactationday)-(eval(document.forms[0].txtIIIL.value)+eval(document.forms[0].txtIIID.value));
  			}
    	}
	}
    if((eval(document.forms[0].txt_IIbatchIIIL.value)>0))
    {
   		document.forms[0].txtIVL.value=eval(milkingdays1)-eval(document.forms[0].txt_IIbatchIIIL.value);
   		IVL1=eval(lactationday)-eval(document.forms[0].txtIVL.value);
   		if(eval(IVL1)<eval(drydays1))
   		{
    		document.forms[0].txtIVD.value=eval(IVL1);
     		document.forms[0].txt_IIbatchIVL.value=eval(lactationday)-(eval(document.forms[0].txtIVL.value)+eval(document.forms[0].txtIVD.value));
     		document.forms[0].txtVD.value=eval(drydays1)-eval(IVL1);
      		VLM1=eval(lactationday)-eval(document.forms[0].txtVD.value);
      		if(eval(VLM1)<eval(milkingdays1))
     		{
      			document.forms[0].txtVL.value=eval(VLM1);
       			document.forms[0].txtVIL.value=eval(milkingdays1)-eval(document.forms[0].txtVL.value);
       			document.forms[0].txtVID.value=eval(drydays1);
        		document.forms[0].txt_IIbatchVIL.value=eval(lactationday)-(eval(document.forms[0].txtVIL.value)+eval(document.forms[0].txtVID.value));
      		}
       		if(eval(VLM1)==eval(milkingdays1))
      		{
      			document.forms[0].txtVL.value=eval(milkingdays1);
       			document.forms[0].txtVID.value=eval(drydays1)-eval( document.forms[0].txtVD.value);
        		LLK1=eval(lactationday)-eval( document.forms[0].txtVID.value);
        		if(eval(LLK1)<eval(milkingdays1))
        		{
        			document.forms[0].txtVIL.value=eval(LLK1);
        			document.forms[0].txtVIIL.value=eval(milkingdays1)-eval(document.forms[0].txtVIL.value);
      				bbgg=eval(lactationday)-eval(document.forms[0].txtVIIL.value);
      				if(eval(bbgg)>eval(drydays1))
      				{
         				document.forms[0].txtVIID.value=eval(drydays1);
      				}
        		}
        		document.forms[0].txt_IIbatchVL.value=eval(lactationday)-(eval(document.forms[0].txtVL.value)+eval(document.forms[0].txtVD.value));
       			document.forms[0].txt_IIbatchVIL.value=eval(lactationday)-(eval(document.forms[0].txtVIL.value)+eval(document.forms[0].txtVID.value));
       			document.forms[0].txt_IIbatchVIIL.value=eval(lactationday)-(eval(document.forms[0].txtVIIL.value)+eval(document.forms[0].txtVIID.value));
      		}
      		if(eval(VLM1)>eval(milkingdays1))
      		{
      			document.forms[0].txtVL.value=eval(milkingdays1);
       			document.forms[0].txt_IIbatchVD.value=eval(lactationday)-(eval(document.forms[0].txt_VL.value)+eval(document.forms[0].txtVD.value));
        		if(eval(document.forms[0].txt_IIbatchVD.value)>0)
        		{
       				document.forms[0].txtVID.value=eval(drydays1)-eval(document.forms[0].txt_IIbatchVD.value);
       				WW1=eval(lactationday)-eval(document.forms[0].txtVID.value);
       				if(eval(WW1)>eval(milkingdays1))
       				{
        				document.forms[0].txtVIL.value=eval(milkingdays1);
        				document.forms[0].txt_IIbatchVIL.value=eval(lactationday)-(eval( document.forms[0].txtVIL.value)+eval(document.forms[0].txtVID.value));
       				}
      				else
       				{
        				document.forms[0].txtVIL.value=eval(lactationday)-eval(document.forms[0].txtVID.value);
       				}
        			document.forms[0].txtVIIL.value=eval(milkingdays1)-eval(document.forms[0].txtVIL.value);
      				VIILM2=eval(lactationday)-eval(document.forms[0].txtVIIL.value);      
      				if(eval(VIILM2)>eval(drydays1))
      				{
        				document.forms[0].txtVIID.value=eval(drydays1);
    					document.forms[0].txt_IIbatchVIIL.value=eval(lactationday)-(eval( document.forms[0].txtVIIL.value)+eval(document.forms[0].txtVIID.value));
      				}
       			}
     		}
   		}
    	if(eval(IVL1)>eval(drydays1))
   		{
   			document.forms[0].txtIVD.value=eval(drydays1);
   			rr3=eval(lactationday)-(eval(document.forms[0].txtIVL.value)+eval(document.forms[0].txtIVD.value));
   			if(eval(rr3)>eval(milkingdays1))
   			{
    			document.forms[0].txt_IIbatchIVL.value=eval(milkingdays1);
     			document.forms[0].txt_IIbatchIVD.value=eval(lactationday)-(eval(document.forms[0].txtIVL.value)+eval(document.forms[0].txtIVD.value)+eval(document.forms[0].txt_IIbatchIVL.value));
   				document.forms[0].txtVD.value=eval(drydays1)-eval( document.forms[0].txt_IIbatchIVD.value);
    			document.forms[0].txtVL.value=eval(milkingdays1);
    			document.forms[0].txt_IIbatchVD.value=eval(lactationday)-(eval(document.forms[0].txtVL.value)+eval(document.forms[0].txtVD.value));
    			document.forms[0].txtVID.value=eval(drydays1)-eval(document.forms[0].txt_IIbatchVD.value);   
   				document.forms[0].txtVIL.value=eval(milkingdays1);   
    			document.forms[0].txt_IIbatchVID.value=eval(lactationday)-(eval(document.forms[0].txtVIL.value)+eval(document.forms[0].txtVID.value));
     			document.forms[0].txtVIID.value=eval(drydays1)-eval(document.forms[0].txt_IIbatchVID.value);   
    			document.forms[0].txtVIIL.value=eval(milkingdays1);   
     			document.forms[0].txt_IIbatchVIID.value=eval(lactationday)-(eval(document.forms[0].txtVIIL.value)+eval(document.forms[0].txtVIID.value));
   			}
    		else
    		{
   				document.forms[0].txt_IIbatchIVL.value=eval(lactationday)-(eval(document.forms[0].txtIVL.value)+eval(document.forms[0].txtIVD.value));
   			    if(document.forms[0].txt_IIbatchIVL.value==eval(milkingdays1))
				{
                document.forms[0].txtVL.value="0";
                document.forms[0].txtVD.value=eval(drydays1);
                document.forms[0].txt_IIbatchVL.value=eval(milkingdays1);
				document.forms[0].txt_IIbatchVD.value=(eval(lactationday)-(eval(document.forms[0].txtVL.value)+eval( document.forms[0].txtVD.value)+eval( document.forms[0].txt_IIbatchVL.value)));
                document.forms[0].txtVID.value=eval(drydays1)-eval(document.forms[0].txt_IIbatchVD.value);
                document.forms[0].txtVIL.value=eval(milkingdays1);
                document.forms[0].txt_IIbatchVID.value=eval(lactationday)-(eval(document.forms[0].txtVIL.value)+eval(document.forms[0].txtVID.value));
                document.forms[0].txtVIID.value=eval(drydays1)-eval(document.forms[0].txt_IIbatchVID.value);
                 document.forms[0].txtVIIL.value=eval(milkingdays1);
                 document.forms[0].txt_IIbatchVIID.value=eval(lactationday)-(eval(document.forms[0].txtVIIL.value)+eval(document.forms[0].txtVIID.value));
				}
   				
   			}
   		}
    	if(eval(IVL1)==eval(drydays1))
   		{
   			document.forms[0].txtIVD.value=eval(drydays1);
   			document.forms[0].txt_IIbatchIVL.value=eval(lactationday)-(eval(document.forms[0].txtIVL.value)+eval(document.forms[0].txtIVD.value));
   			document.forms[0].txtVL.value=eval(milkingdays1);
   			VBBB=eval(lactationday)-eval(document.forms[0].txtVL.value);
   			if(eval( VBBB)<eval(drydays1))
   			{
   				document.forms[0].txtVD.value=eval(VBBB);
   				document.forms[0].txtVID.value=eval(drydays1)-eval(VBBB);
    			document.forms[0].txtVIL.value=eval(lactationday)-eval( document.forms[0].txtVID.value);
     			document.forms[0].txtVIIL.value=eval(milkingdays1)-eval( document.forms[0].txtVIL.value);
     			document.forms[0].txtVIID.value=eval(drydays1);
   			}
     		document.forms[0].txt_IIbatchVL.value=eval(lactationday)-(eval(document.forms[0].txtVL.value)+eval(document.forms[0].txtVD.value));
     		document.forms[0].txt_IIbatchVIL.value=eval(lactationday)-(eval(document.forms[0].txtVIL.value)+eval(document.forms[0].txtVID.value));
     		document.forms[0].txt_IIbatchVIIL.value=eval(lactationday)-(eval(document.forms[0].txtVIIL.value)+eval(document.forms[0].txtVIID.value));
   		}
    } 
    if((eval(document.forms[0].txt_IIbatchIVL.value)>0)&&(eval(document.forms[0].txt_IIbatchIVL.value)!=eval(milkingdays1)))
   	{
   		document.forms[0].txtVL.value=eval(milkingdays1)-eval(document.forms[0].txt_IIbatchIVL.value);
   		VL1=eval(lactationday)-eval(document.forms[0].txtVL.value);
  		if(eval(VL1)<eval(drydays1))
  		{
   			document.forms[0].txtVD.value=eval(lactationday)-eval(document.forms[0].txtVL.value);
   			document.forms[0].txt_IIbatchVL.value=eval(lactationday)-(eval(document.forms[0].txtVL.value)+eval(document.forms[0].txtVD.value));
   			document.forms[0].txtVID.value=eval(drydays1)-eval(document.forms[0].txtVD.value);
   			VILM1=eval(lactationday)-eval( document.forms[0].txtVID.value);
   			if(eval(VILM1)<eval(milkingdays1))
   			{
   				document.forms[0].txtVIL.value=eval(VILM1);
     			document.forms[0].txtVIIL.value=eval(milkingdays1)-eval(VILM1);
      			document.forms[0].txtVIID.value=eval(drydays1);
    			document.forms[0].txt_IIbatchVIIL.value=eval(lactationday)-(eval( document.forms[0].txtVIIL.value)+eval( document.forms[0].txtVIID.value));
   			}
    		if(eval(VILM1)==eval(milkingdays1))
   			{
    			document.forms[0].txtVIL.value=eval(milkingdays1);
      			document.forms[0].txtVIID.value=eval(drydays1);
      			document.forms[0].txtVIIL.value=eval(lactationday)-eval(document.forms[0].txtVIID.value);
    			document.forms[0].txt_IIbatchVIIL.value=eval(lactationday)-(eval( document.forms[0].txtVIIL.value)+eval( document.forms[0].txtVIID.value));
   			}
   			if(eval(VILM1)>eval(milkingdays1))
   			{
    			document.forms[0].txtVIL.value=eval(milkingdays1);
    			document.forms[0].txt_IIbatchVID.value=eval(lactationday)-(eval( document.forms[0].txtVIL.value)+eval( document.forms[0].txtVID.value));
    			if(eval(document.forms[0].txt_IIbatchVID.value)>0)
    			{
     				document.forms[0].txtVIID.value=eval(drydays1)-eval( document.forms[0].txt_IIbatchVID.value);
     				document.forms[0].txtVIIL.value=eval(lactationday)-eval( document.forms[0].txtVIID.value);
    			}
   			}
   		}
   		if(eval(VL1)>eval(drydays1))
   		{	
   			document.forms[0].txtVD.value=eval(drydays1);
   			document.forms[0].txt_IIbatchVL.value=eval(lactationday)-(eval(document.forms[0].txtVL.value)+eval(document.forms[0].txtVD.value));
   		}
    } 
   	if((eval(document.forms[0].txt_IIbatchVL.value)>0))
   	{
   		if((eval(document.forms[0].txt_IIbatchVL.value)>eval(milkingdays1)))
   		{
   			document.forms[0].txt_IIbatchVL.value=eval(milkingdays1);
   			document.forms[0].txt_IIbatchVD.value=eval(lactationday)-(eval( document.forms[0].txtVL.value)+eval( document.forms[0].txtVD.value)+eval(document.forms[0].txt_IIbatchVL.value));
   			document.forms[0].txtVID.value=eval(drydays1)-eval(document.forms[0].txt_IIbatchVD.value);
    		document.forms[0].txtVIL.value=eval(milkingdays1);
    		document.forms[0].txt_IIbatchVID.value=eval(lactationday)-(eval( document.forms[0].txtVID.value)+eval( document.forms[0].txtVIL.value));
     		document.forms[0].txtVIID.value=eval(drydays1)-eval(document.forms[0].txt_IIbatchVID.value);
      		document.forms[0].txtVIIL.value=eval(milkingdays1);
      		document.forms[0].txt_IIbatchVIIL.value=eval(lactationday)-(eval( document.forms[0].txtVIIL.value)+eval( document.forms[0].txtVIID.value));
   		}
   		if(!(eval(document.forms[0].txt_IIbatchVL.value)>=eval(milkingdays1)))
   		{
   			document.forms[0].txtVIL.value=eval(milkingdays1)-eval(document.forms[0].txt_IIbatchVL.value);
   			VIL1=eval(lactationday)-eval(document.forms[0].txtVIL.value);
  
   			if(eval(VIL1)>eval(drydays1))
   			{
   				document.forms[0].txtVID.value=eval(drydays1);
   				document.forms[0].txt_IIbatchVIL.value=eval(lactationday)-(eval(document.forms[0].txtVIL.value)+eval(document.forms[0].txtVID.value));
   			}
   			if(eval(VIL1)<eval(drydays1))
   			{
   				document.forms[0].txtVID.value=eval(VIL1);
   				document.forms[0].txtVIID.value=eval(drydays1)-eval(VIL1);
   				document.forms[0].txt_IIbatchVIL.value=eval(lactationday)-(eval(document.forms[0].txtVIL.value)+eval(document.forms[0].txtVID.value));
   				VIIDm1=eval(lactationday)-eval(document.forms[0].txtVIID.value);
   				if(eval(VIIDm1)<eval(milkingdays1))
   				{
   					document.forms[0].txtVIIL.value=eval(VIIDm1);
    				document.forms[0].txt_IIbatchVIID.value=eval(lactationday)-(eval(document.forms[0].txtVIIL.value)+eval(document.forms[0].txtVIID.value));
   				}
   				if(eval(VIIDm1)>eval(milkingdays1))
   				{
   					document.forms[0].txtVIIL.value=eval(milkingdays1);
   					document.forms[0].txt_IIbatchVIID.value=eval(lactationday)-(eval(document.forms[0].txtVIIL.value)+eval(document.forms[0].txtVIID.value));
   				}
   				if(eval(VIIDm1)==eval(milkingdays1))
   				{
   					document.forms[0].txtVIIL.value=eval(VIIDm1);
   				}
  			}
    	}  
    }
  	if((eval(document.forms[0].txt_IIbatchVIL.value)>0))
  	{
   		document.forms[0].txtVIIL.value=eval(milkingdays1)-eval(document.forms[0].txt_IIbatchVIL.value);
   		VIIL1=eval(lactationday)-eval(document.forms[0].txtVIIL.value);
   		if(eval(VIIL1)==eval(drydays1))
   		{
   			document.forms[0].txtVIID.value=eval(drydays1);
   			document.forms[0].txt_IIbatchVIIL.value=eval(lactationday)-(eval(document.forms[0].txtVIIL.value)+eval(document.forms[0].txtVIID.value));
   		}
   		if(eval(VIIL1)>eval(drydays1))
   		{
   			document.forms[0].txtVIID.value=eval(drydays1);
   			document.forms[0].txt_IIbatchVIIL.value=eval(lactationday)-(eval(document.forms[0].txtVIIL.value)+eval(document.forms[0].txtVIID.value));
   		}
   		if(eval(VIIL1)<eval(drydays1))
   		{
   			document.forms[0].txtVIID.value=eval(lactationday)-eval(document.forms[0].txtVIIL.value);
   			document.forms[0].txt_IIbatchVIIL.value=eval(lactationday)-(eval(document.forms[0].txtVIIL.value)+eval(document.forms[0].txtVIID.value));
  		}
    } 
    }   
}

function callLDCows()
{
    var VL1="";
    var milkingdays_11=""; var milkingdays_12="";var  milkingdays_13="";
	var lactationday =360;
	var milkingdays=document.forms[0].txt_lactrationdays.value;
	if(milkingdays=="")
	{
		milkingdays=280;
	}	
	var drydays=document.forms[0].txt_drydays.value;
	if(drydays=="")
	{
		drydays=80;
	}	
	var months=document.forms[0].txt_months.value;
    if(months=="")
	{
		months=1;
	}
    var IL	= eval(milkingdays) - 30;
	document.forms[0].txt_IL.value = eval(IL);
	IL1 = eval(lactationday) - eval(document.forms[0].txt_IL.value);
	if(eval(IL1)>eval(drydays))
	{
		document.forms[0].txt_ID.value=eval(drydays);
		document.forms[0].txt_IbatchIL.value=eval(lactationday)-(eval(document.forms[0].txt_IL.value)+eval(document.forms[0].txt_ID.value));
	}
	else if(eval(IL1)==eval(drydays))
	{
		document.forms[0].txt_ID.value=eval(drydays);
		document.forms[0].txt_IbatchIL.value=eval(lactationday)-(eval(document.forms[0].txt_IL.value)+eval(document.forms[0].txt_ID.value));
		document.forms[0].txt_IIL.value=eval(milkingdays);
		IID1=eval(lactationday)-eval(document.forms[0].txt_IIL.value);
		document.forms[0].txt_IID.value=eval(IID1);
		document.forms[0].txt_IIID.value=eval(drydays)-eval(document.forms[0].txt_IID.value);
		IIID1=eval(lactationday)-eval(document.forms[0].txt_IIID.value);
		
		if(eval(IIID1)>eval(milkingdays))
		{
			document.forms[0].txt_IIIL.value=eval(milkingdays);
			document.forms[0].txt_IbatchIIID.value=eval(lactationday)-(eval(document.forms[0].txt_IIIL.value)+eval(document.forms[0].txt_IIID.value));
		}
		if(eval(IIID1)==eval(milkingdays))
		{

			document.forms[0].txt_IIIL.value=eval(milkingdays);
			document.forms[0].txt_IbatchIIID.value=eval(lactationday)-(eval(document.forms[0].txt_IIIL.value)+eval(document.forms[0].txt_IIID.value));
			document.forms[0].txt_IVD.value=eval(drydays);
			document.forms[0].txt_IVL.value=eval(lactationday)-eval(document.forms[0].txt_IVD.value);
			document.forms[0].txt_IbatchIVL.value=eval(lactationday)-(eval(document.forms[0].txt_IVL.value)+eval(document.forms[0].txt_IVD.value));
			document.forms[0].txt_VL.value=eval(milkingdays)-eval(document.forms[0].txt_IVL.value);
			document.forms[0].txt_VD.value=eval(drydays);
			document.forms[0].txt_IbatchVL.value=eval(lactationday)-(eval(document.forms[0].txt_VL.value)+eval(document.forms[0].txt_VD.value));
		}
	 	if(eval(document.forms[0].txt_IbatchIIID.value)>0)
     	{
     		document.forms[0].txt_IVD.value=eval(drydays)-eval(document.forms[0].txt_IbatchIIID.value);
		    IVL1=eval(lactationday)-eval(document.forms[0].txt_IVD.value);
		    if(eval(IVL1)<eval(milkingdays))
		    {
				document.forms[0].txt_IVL.value=eval(IVL1);
			    document.forms[0].txt_IbatchIVL.value=eval(lactationday)-(eval(document.forms[0].txt_IVL.value)+eval(document.forms[0].txt_IVD.value));
			    document.forms[0].txt_VL.value=(eval(milkingdays)-eval(document.forms[0].txt_IVL.value));
			    document.forms[0].txt_VD.value=eval(drydays);
			    document.forms[0].txt_IbatchVL.value=eval(lactationday)-(eval(document.forms[0].txt_VL.value)+eval(document.forms[0].txt_VD.value));
      		}
      		if(eval(IVL1)==eval(milkingdays))
     		{
			    document.forms[0].txt_IVL.value=eval(IVL1);
			    document.forms[0].txt_IbatchIVL.value=eval(lactationday)-(eval(document.forms[0].txt_IVL.value)+eval(document.forms[0].txt_IVD.value));
			    document.forms[0].txt_VD.value=eval(drydays);
			    VL1=(eval(lactationday)-eval(document.forms[0].txt_VD.value));
     		}
      		if(eval(IVL1)>eval(milkingdays))
     		{
			    document.forms[0].txt_IVL.value=eval(milkingdays);
			    document.forms[0].txt_IbatchIVD.value=eval(lactationday)-(eval(document.forms[0].txt_IVL.value)+eval(document.forms[0].txt_IVD.value));
     		}
     		if(eval(document.forms[0].txt_IbatchIVD.value)>0)
     		{
      			document.forms[0].txt_VD.value=eval(drydays)-eval(document.forms[0].txt_IbatchIVD.value);
       			VL1=eval(lactationday)-eval(document.forms[0].txt_VD.value);
     			if(eval(VL1)<eval(milkingdays))
       			{
			     	document.forms[0].txt_VL.value=eval(VL1);
			     	document.forms[0].txt_IbatchVL.value=eval(lactationday)-(eval(document.forms[0].txt_VL.value)+eval(document.forms[0].txt_VD.value));
			     	document.forms[0].txt_VIL.value=(eval(milkingdays)-eval(document.forms[0].txt_VL.value));
			     	document.forms[0].txt_VID.value=eval(drydays);
			     	document.forms[0].txt_IbatchVIL.value=eval(lactationday)-(eval(document.forms[0].txt_VIL.value)+eval(document.forms[0].txt_VID.value));
      			}
       			if(eval(VL1)>eval(milkingdays))
      			{
    				document.forms[0].txt_VL.value=eval(milkingdays);
    				document.forms[0].txt_IbatchVD.value=eval(lactationday)-(eval(document.forms[0].txt_VL.value)+eval(document.forms[0].txt_VD.value));
      			}
      			if(eval(VL1)==eval(milkingdays))
     			{
   					document.forms[0].txt_VL.value=eval(milkingdays);
   					document.forms[0].txt_IbatchVL.value=eval(lactationday)-(eval(document.forms[0].txt_VL.value)+eval(document.forms[0].txt_VD.value));
   					document.forms[0].txt_VID.value=eval(drydays);
				   	document.forms[0].txt_VIL.value=eval(lactationday)-eval(document.forms[0].txt_VID.value);
				   	document.forms[0].txt_IbatchVIL.value=eval(lactationday)-(eval(document.forms[0].txt_VIL.value)+eval(document.forms[0].txt_VID.value));
				   	document.forms[0].txt_VIIL.value=eval(milkingdays)-eval( document.forms[0].txt_VIL.value);
				   	document.forms[0].txt_VIID.value=eval(drydays);
				   	document.forms[0].txt_IbatchVIIL.value=eval(lactationday)-(eval(document.forms[0].txt_VIIL.value)+eval(document.forms[0].txt_VIID.value));
     			} 
      		}
        }  
	}
	if(eval(IL1)<eval(drydays))
	{
		document.forms[0].txt_ID.value=eval(IL1);
		document.forms[0].txt_IID.value=eval(drydays)-eval(document.forms[0].txt_ID.value);
		document.forms[0].txt_IbatchIL.value=eval(lactationday)-(eval(document.forms[0].txt_IL.value)+eval(document.forms[0].txt_ID.value));
		IIL1=eval(lactationday)-eval(document.forms[0].txt_IID.value);
		if(eval(IIL1)>eval(milkingdays))
		{
			document.forms[0].txt_IIL.value=eval(milkingdays);
			document.forms[0].txt_IbatchIID.value=eval(lactationday)-(eval(document.forms[0].txt_IIL.value)+eval(document.forms[0].txt_IID.value));
		}
		if(eval(IIL1)==eval(milkingdays))
		{
			document.forms[0].txt_IIL.value=eval(milkingdays);
			document.forms[0].txt_IIID.value=eval(drydays);
			IIILM1=eval(lactationday)-eval(document.forms[0].txt_IIID.value);
			if(eval(IIILM1)<eval(milkingdays))
			{
			document.forms[0].txt_IIIL.value=eval(IIILM1);
			document.forms[0].txt_IVL.value=eval(milkingdays)-eval(IIILM1);
			document.forms[0].txt_IVD.value=eval(drydays);
			document.forms[0].txt_IbatchIVL.value=eval(lactationday)-(eval(document.forms[0].txt_IVL.value)+eval(document.forms[0].txt_IVD.value));
			}
		}	
		if(eval(IIL1)<eval(milkingdays))
		{
			document.forms[0].txt_IIL.value=eval(IIL1);
			document.forms[0].txt_IbatchIIL.value=eval(lactationday)-(eval(document.forms[0].txt_IIL.value)+eval(document.forms[0].txt_IID.value));
			document.forms[0].txt_IIIL.value=eval(milkingdays)-eval(document.forms[0].txt_IIL.value);
			IIILN1=eval(lactationday)-eval(document.forms[0].txt_IIIL.value);
			if(eval(IIILN1)<eval(drydays))
			{
				document.forms[0].txt_IIID.value=eval(IIILN1);
				document.forms[0].txt_IVD.value=eval(drydays)-eval(document.forms[0].txt_IIID.value);
				IVLM1=eval(lactationday)-eval(document.forms[0].txt_IVD.value);
				document.forms[0].txt_IVL.value=eval(IVLM1);
				document.forms[0].txt_VL.value=eval(milkingdays)-eval(document.forms[0].txt_IVL.value);
				document.forms[0].txt_VD.value=eval(drydays);
				document.forms[0].txt_IbatchVL.value=eval(lactationday)-(eval(document.forms[0].txt_VL.value)+eval(document.forms[0].txt_VD.value));
			}
			else
			{
				document.forms[0].txt_IIID.value=eval(drydays);
			}
			document.forms[0].txt_IbatchIIIL.value=eval(lactationday)-(eval(document.forms[0].txt_IIIL.value)+eval(document.forms[0].txt_IIID.value));
		}	
     	if(eval(document.forms[0].txt_IbatchIID.value)>0)
     	{
     		document.forms[0].txt_IIID.value=eval(drydays)-eval(document.forms[0].txt_IbatchIID.value);
   			IIIL1=eval(lactationday)-eval(document.forms[0].txt_IIID.value);
   			if(eval(IIIL1)<eval(milkingdays))
   			{
    			document.forms[0].txt_IIIL.value=eval(IIIL1);
    			document.forms[0].txt_IbatchIIIL.value=eval(lactationday)-(eval(document.forms[0].txt_IIIL.value)+eval(document.forms[0].txt_IIID.value));
			    document.forms[0].txt_IVL.value=(eval(milkingdays)-eval(document.forms[0].txt_IIIL.value));
			    document.forms[0].txt_IVD.value=eval(drydays);
			    document.forms[0].txt_IbatchIVL.value=eval(lactationday)-(eval(document.forms[0].txt_IVL.value)+eval(document.forms[0].txt_IVD.value));
      		}
     		if(eval(IIIL1)>eval(milkingdays))
   			{
			    document.forms[0].txt_IIIL.value=eval(milkingdays);
			    document.forms[0].txt_IbatchIIID.value=eval(lactationday)-(eval(document.forms[0].txt_IIIL.value)+eval(document.forms[0].txt_IIID.value));
	      	}
	      	if(eval(IIIL1)==eval(milkingdays))
   			{
     			document.forms[0].txt_IIIL.value=eval(milkingdays);
      			document.forms[0].txt_IVD.value=eval(drydays);
      			JJJ=eval(lactationday)-eval( document.forms[0].txt_IVD.value);
     			if(eval(JJJ)<eval(milkingdays))
     			{
     				document.forms[0].txt_IVL.value=eval(JJJ);
      				document.forms[0].txt_IbatchIVL.value=eval(lactationday)-(eval(document.forms[0].txt_IVL.value)+eval(document.forms[0].txt_IVD.value));
     				document.forms[0].txt_VL.value=eval(milkingdays)-eval(document.forms[0].txt_IVL.value);
      				document.forms[0].txt_VD.value=eval(drydays);
   					document.forms[0].txt_IbatchVL.value=eval(lactationday)-(eval(document.forms[0].txt_VL.value)+eval(document.forms[0].txt_VD.value));
     			}
      		} 
     	}
	}
   if((eval(document.forms[0].txt_IbatchIL.value)>0))
   {
	   document.forms[0].txt_IIL.value=eval(milkingdays)-eval(document.forms[0].txt_IbatchIL.value);
	   IIL1=eval(lactationday)-eval(document.forms[0].txt_IIL.value);
	   if(eval(IIL1)>eval(drydays))
	   {
		   document.forms[0].txt_IID.value=eval(drydays);
		   document.forms[0].txt_IbatchIIL.value=eval(lactationday)-(eval(document.forms[0].txt_IIL.value)+eval(document.forms[0].txt_IID.value));
	   }
	   if(eval(IIL1)<eval(drydays))
	   {	   
	    	document.forms[0].txt_IID.value=eval(IIL1);
	    	document.forms[0].txt_IIID.value=eval(drydays)-eval(document.forms[0].txt_IID.value);
	     	IIIL1=eval(lactationday)-eval(document.forms[0].txt_IIID.value);
	     	if(eval(IIIL1)>eval(milkingdays))
	     	{
		     	document.forms[0].txt_IIIL.value=eval(milkingdays);
		     	document.forms[0].txt_IbatchIIID.value=eval(lactationday)-(eval(document.forms[0].txt_IIIL.value)+eval(document.forms[0].txt_IIID.value));
      		}
      		if(eval(document.forms[0].txt_IbatchIIID.value)>0)
    		{
     			document.forms[0].txt_IVD.value=eval(drydays)-eval(document.forms[0].txt_IbatchIIID.value);
   				IVL1=eval(lactationday)-eval(document.forms[0].txt_IVD.value);
   				if(eval(IVL1)<eval(milkingdays))
   				{
				    document.forms[0].txt_IVL.value=eval(IVL1);
				    document.forms[0].txt_IbatchIVL.value=eval(lactationday)-(eval(document.forms[0].txt_IVL.value)+eval(document.forms[0].txt_IVD.value));
				    document.forms[0].txt_VL.value=(eval(milkingdays)-eval(document.forms[0].txt_IVL.value));
				    document.forms[0].txt_VD.value=eval(drydays);
				    document.forms[0].txt_IbatchVL.value=eval(lactationday)-(eval(document.forms[0].txt_VL.value)+eval(document.forms[0].txt_VD.value));
      			}
      			if(eval(IVL1)==eval(milkingdays))
     			{
				    document.forms[0].txt_IVL.value=eval(IVL1);
				    document.forms[0].txt_IbatchIVL.value=eval(lactationday)-(eval(document.forms[0].txt_IVL.value)+eval(document.forms[0].txt_IVD.value));
				    document.forms[0].txt_VD.value=eval(drydays);
				    VL1=(eval(lactationday)-eval(document.forms[0].txt_VD.value));
     			}
      			if(eval(IVL1)>eval(milkingdays))
     			{
				    document.forms[0].txt_IVL.value=eval(milkingdays);
				    document.forms[0].txt_IbatchIVD.value=eval(lactationday)-(eval(document.forms[0].txt_IVL.value)+eval(document.forms[0].txt_IVD.value));
         		}
			    if(eval(document.forms[0].txt_IbatchIVD.value)>0)
			    {
			       	document.forms[0].txt_VD.value=eval(drydays)-eval(document.forms[0].txt_IbatchIVD.value);
			       	VL1=eval(lactationday)-eval(document.forms[0].txt_VD.value);
     			}
      			if(eval(VL1)<eval(milkingdays))
   				{
				    document.forms[0].txt_VL.value=eval(VL1);
				    document.forms[0].txt_IbatchVL.value=eval(lactationday)-(eval(document.forms[0].txt_VL.value)+eval(document.forms[0].txt_VD.value));
				    document.forms[0].txt_VIL.value=(eval(milkingdays)-eval(document.forms[0].txt_VL.value));
				    document.forms[0].txt_VID.value=eval(drydays);
				    document.forms[0].txt_IbatchVIL.value=eval(lactationday)-(eval(document.forms[0].txt_VIL.value)+eval(document.forms[0].txt_VID.value));
      			}
      			if(eval(VL1)==eval(milkingdays))
   				{
				    document.forms[0].txt_VL.value=eval(milkingdays);
				    document.forms[0].txt_IbatchVL.value=eval(lactationday)-(eval(document.forms[0].txt_VL.value)+eval(document.forms[0].txt_VD.value));
				    document.forms[0].txt_VID.value=eval(drydays);
				    document.forms[0].txt_VIL.value=eval(lactationday)-eval(drydays);
				    document.forms[0].txt_VIIL.value=eval(milkingdays)-eval(document.forms[0].txt_VIL.value);
				    document.forms[0].txt_VIID.value=eval(drydays);
				    document.forms[0].txt_IbatchVIL.value=eval(lactationday)-(eval(document.forms[0].txt_VIL.value)+eval(document.forms[0].txt_VID.value));
				    document.forms[0].txt_IbatchVIIL.value=eval(lactationday)-(eval(document.forms[0].txt_VIIL.value)+eval(document.forms[0].txt_VIID.value));
      			} 
     		}  
      	}
   	}
    if(eval(document.forms[0].txt_IbatchIIL.value)>0)
   	{
   		document.forms[0].txt_IIIL.value=eval(milkingdays)-eval(document.forms[0].txt_IbatchIIL.value);
   		IIIL1=eval(lactationday)-eval(document.forms[0].txt_IIIL.value);
    	if(eval(IIIL1)<eval(drydays))
   		{
   			document.forms[0].txt_IIID.value=eval(IIIL1);
  			document.forms[0].txt_IVD.value=eval(drydays)-eval(IIIL1);
    		document.forms[0].txt_IbatchIIIL.value=eval(lactationday)-(eval(document.forms[0].txt_IIIL.value)+eval(document.forms[0].txt_IIID.value));
    		IVD=document.forms[0].txt_IVD.value;
   		}
   		if(eval(IIIL1)==eval(drydays))
   		{
   			document.forms[0].txt_IIID.value=eval(drydays);
     		document.forms[0].txt_IVL.value=eval(milkingdays)-eval(document.forms[0].txt_IIIL.value);
      		document.forms[0].txt_IVD.value=eval(drydays);
  			document.forms[0].txt_IbatchIVL.value=eval(lactationday)-(eval(document.forms[0].txt_IVL.value)+eval(document.forms[0].txt_IVD.value));
   		}
    	if(eval(IIIL1)>eval(drydays))
   		{
   			document.forms[0].txt_IIID.value=eval(drydays);
   			document.forms[0].txt_IbatchIIIL.value=eval(lactationday)-(eval(document.forms[0].txt_IIIL.value)+eval(document.forms[0].txt_IIID.value));
   		}
    }
    if((eval(document.forms[0].txt_IbatchIIIL.value)>0))
   	{
   		document.forms[0].txt_IVL.value=eval(milkingdays)-eval(document.forms[0].txt_IbatchIIIL.value);
   		IVL1=eval(lactationday)-eval(document.forms[0].txt_IVL.value);
   		if(eval(IVL1)<eval(drydays))
   		{
    		document.forms[0].txt_IVD.value=eval(IVL1);
     		document.forms[0].txt_IbatchIVL.value=eval(lactationday)-(eval(document.forms[0].txt_IVL.value)+eval(document.forms[0].txt_IVD.value));
     		document.forms[0].txt_VD.value=eval(drydays)-eval(IVL1);
      		VLM1=eval(lactationday)-eval(document.forms[0].txt_VD.value);
      		if(eval(VLM1)<eval(milkingdays))
      		{
	      		document.forms[0].txt_VL.value=eval(VLM1);
	       		document.forms[0].txt_VIL.value=eval(milkingdays)-eval(document.forms[0].txt_VL.value);
	       		document.forms[0].txt_VID.value=eval(drydays);
	        	document.forms[0].txt_IbatchVIL.value=eval(lactationday)-(eval(document.forms[0].txt_VIL.value)+eval(document.forms[0].txt_VID.value));
      		}
       		if(eval(VLM1)==eval(milkingdays))
      		{
      			document.forms[0].txt_VL.value=eval(milkingdays);
       			document.forms[0].txt_VID.value=eval(drydays)-eval( document.forms[0].txt_VD.value);
        		LLK1=eval(lactationday)-eval( document.forms[0].txt_VID.value);
        		if(eval(LLK1)<eval(milkingdays))
        		{
			        document.forms[0].txt_VIL.value=eval(LLK1);
			        document.forms[0].txt_VIIL.value=eval(milkingdays)-eval(document.forms[0].txt_VIL.value);
			      	bbgg=eval(lactationday)-eval(document.forms[0].txt_VIIL.value);
			      	if(eval(bbgg)>eval(drydays))
			      	{
			         	document.forms[0].txt_VIID.value=eval(drydays);
			      	}
        		}
        		document.forms[0].txt_IbatchVL.value=eval(lactationday)-(eval(document.forms[0].txt_VL.value)+eval(document.forms[0].txt_VD.value));
       			document.forms[0].txt_IbatchVIL.value=eval(lactationday)-(eval(document.forms[0].txt_VIL.value)+eval(document.forms[0].txt_VID.value));
       			document.forms[0].txt_IbatchVIIL.value=eval(lactationday)-(eval(document.forms[0].txt_VIIL.value)+eval(document.forms[0].txt_VIID.value));
      		}
      		if(eval(VLM1)>eval(milkingdays))
      		{
      			document.forms[0].txt_VL.value=eval(milkingdays);
       			document.forms[0].txt_IbatchVD.value=eval(lactationday)-(eval(document.forms[0].txt_VL.value)+eval(document.forms[0].txt_VD.value));
        		if(eval(document.forms[0].txt_IbatchVD.value)>0)
        		{
			       	document.forms[0].txt_VID.value=eval(drydays)-eval(document.forms[0].txt_IbatchVD.value);
			        document.forms[0].txt_VIL.value=eval(lactationday)-eval(document.forms[0].txt_VID.value);
			        document.forms[0].txt_VIIL.value=eval(milkingdays)-eval(document.forms[0].txt_VIL.value);
			      	VIILM2=eval(lactationday)-eval(document.forms[0].txt_VIIL.value);
			      	if(eval(VIILM2)>eval(drydays))
			      	{
			        	document.forms[0].txt_VIID.value=eval(drydays);
    					document.forms[0].txt_IbatchVIIL.value=eval(lactationday)-(eval( document.forms[0].txt_VIIL.value)+eval(document.forms[0].txt_VIID.value));
      				}
       			}
      		}
   		}
    	if(eval(IVL1)>eval(drydays))
   		{
   			document.forms[0].txt_IVD.value=eval(drydays);
   			document.forms[0].txt_IbatchIVL.value=eval(lactationday)-(eval(document.forms[0].txt_IVL.value)+eval(document.forms[0].txt_IVD.value));
   		}
    	if(eval(IVL1)==eval(drydays))
   		{
		   	document.forms[0].txt_IVD.value=eval(drydays);
		   	document.forms[0].txt_IbatchIVL.value=eval(lactationday)-(eval(document.forms[0].txt_IVL.value)+eval(document.forms[0].txt_IVD.value));
		   	document.forms[0].txt_VL.value=eval(milkingdays);
		   	VBBB=eval(lactationday)-eval(document.forms[0].txt_VL.value);
		   	if(eval( VBBB)<eval(drydays))
		   	{
		   		document.forms[0].txt_VD.value=eval(VBBB);
		   		document.forms[0].txt_VID.value=eval(drydays)-eval(VBBB);
		    	document.forms[0].txt_VIL.value=eval(lactationday)-eval( document.forms[0].txt_VID.value);
		     	document.forms[0].txt_VIIL.value=eval(milkingdays)-eval( document.forms[0].txt_VIL.value);
     			document.forms[0].txt_VIID.value=eval(drydays);
   			}
	     	document.forms[0].txt_IbatchVL.value=eval(lactationday)-(eval(document.forms[0].txt_VL.value)+eval(document.forms[0].txt_VD.value));
	     	document.forms[0].txt_IbatchVIL.value=eval(lactationday)-(eval(document.forms[0].txt_VIL.value)+eval(document.forms[0].txt_VID.value));
	     	document.forms[0].txt_IbatchVIIL.value=eval(lactationday)-(eval(document.forms[0].txt_VIIL.value)+eval(document.forms[0].txt_VIID.value));
   		}
    } 
    if((eval(document.forms[0].txt_IbatchIVL.value)>0))
   	{
   		document.forms[0].txt_VL.value=eval(milkingdays)-eval(document.forms[0].txt_IbatchIVL.value);
   		VL1=eval(lactationday)-eval(document.forms[0].txt_VL.value);
   		if(eval(VL1)<eval(drydays))
   		{
	   		document.forms[0].txt_VD.value=eval(lactationday)-eval(document.forms[0].txt_VL.value);
	   		document.forms[0].txt_IbatchVL.value=eval(lactationday)-(eval(document.forms[0].txt_VL.value)+eval(document.forms[0].txt_VD.value));
	   		document.forms[0].txt_VID.value=eval(drydays)-eval(document.forms[0].txt_VD.value);
	   		VILM1=eval(lactationday)-eval( document.forms[0].txt_VID.value);
	   		if(eval(VILM1)<eval(milkingdays))
   			{
   				document.forms[0].txt_VIL.value=eval(VILM1);
     			document.forms[0].txt_VIIL.value=eval(milkingdays)-eval(VILM1);
      			document.forms[0].txt_VIID.value=eval(drydays);
    			document.forms[0].txt_IbatchVIIL.value=eval(lactationday)-(eval( document.forms[0].txt_VIIL.value)+eval( document.forms[0].txt_VIID.value));
   			}
    		if(eval(VILM1)==eval(milkingdays))
   			{
    			document.forms[0].txt_VIL.value=eval(milkingdays);
      			document.forms[0].txt_VIID.value=eval(drydays);
      			document.forms[0].txt_VIIL.value=eval(lactationday)-eval(document.forms[0].txt_VIID.value);
    			document.forms[0].txt_IbatchVIIL.value=eval(lactationday)-(eval( document.forms[0].txt_VIIL.value)+eval( document.forms[0].txt_VIID.value));
   			}
   			if(eval(VILM1)>eval(milkingdays))
   			{
    			document.forms[0].txt_VIL.value=eval(milkingdays);
    			document.forms[0].txt_IbatchVID.value=eval(lactationday)-(eval( document.forms[0].txt_VIL.value)+eval( document.forms[0].txt_VID.value));
    			if(eval(document.forms[0].txt_IbatchVID.value)>0)
    			{
     				document.forms[0].txt_VIID.value=eval(drydays)-eval( document.forms[0].txt_IbatchVID.value);
     				document.forms[0].txt_VIIL.value=eval(lactationday)-eval( document.forms[0].txt_VIID.value);
    			}
   			}
   		}
   		if(eval(VL1)>eval(drydays))
   		{
   			document.forms[0].txt_VD.value=eval(drydays);
   			document.forms[0].txt_IbatchVL.value=eval(lactationday)-(eval(document.forms[0].txt_VL.value)+eval(document.forms[0].txt_VD.value));
   		}
    } 
  	if((eval(document.forms[0].txt_IbatchVIL.value)>0))
   	{
   		document.forms[0].txt_VIIL.value=eval(milkingdays)-eval(document.forms[0].txt_IbatchVIL.value);
   		VIIL1=eval(lactationday)-eval(document.forms[0].txt_VIIL.value);
   		if(eval(VIIL1)>eval(drydays))
   		{
   			document.forms[0].txt_VIID.value=eval(drydays);
   			document.forms[0].txt_IbatchVIIL.value=eval(lactationday)-(eval(document.forms[0].txt_VIIL.value)+eval(document.forms[0].txt_VIID.value));
   		}
   		if(eval(VIIL1)<eval(drydays))
   		{
   			document.forms[0].txt_VIID.value=eval(lactationday)-eval(document.forms[0].txt_VIIL.value);
   			document.forms[0].txt_IbatchVIIL.value=eval(lactationday)-(eval(document.forms[0].txt_VIIL.value)+eval(document.forms[0].txt_VIID.value));
   		}
    }   
	if(eval(document.forms[0].txt_IbatchIIID.value)>0)
    {
     	document.forms[0].txt_IVD.value=eval(drydays)-eval(document.forms[0].txt_IbatchIIID.value);
   		IVL1=eval(lactationday)-eval(document.forms[0].txt_IVD.value);
   		if(eval(IVL1)<eval(milkingdays))
   		{
    		document.forms[0].txt_IVL.value=eval(IVL1);
    		document.forms[0].txt_IbatchIVL.value=eval(lactationday)-(eval(document.forms[0].txt_IVL.value)+eval(document.forms[0].txt_IVD.value));
    		document.forms[0].txt_VL.value=(eval(milkingdays)-eval(document.forms[0].txt_IVL.value));
    		document.forms[0].txt_VD.value=eval(drydays);
     		document.forms[0].txt_IbatchVL.value=eval(lactationday)-(eval(document.forms[0].txt_VL.value)+eval(document.forms[0].txt_VD.value));
      	}
      	if(eval(IVL1)==eval(milkingdays))
     	{
    		document.forms[0].txt_IVL.value=eval(IVL1);
    		document.forms[0].txt_IbatchIVL.value=eval(lactationday)-(eval(document.forms[0].txt_IVL.value)+eval(document.forms[0].txt_IVD.value));
     		document.forms[0].txt_VD.value=eval(drydays);
     		VL1=(eval(lactationday)-eval(document.forms[0].txt_VD.value));
     	}
      	if(eval(IVL1)>eval(milkingdays))
     	{
    		document.forms[0].txt_IVL.value=eval(milkingdays);
    		document.forms[0].txt_IbatchIVD.value=eval(lactationday)-(eval(document.forms[0].txt_IVL.value)+eval(document.forms[0].txt_IVD.value));
        }
     	if(eval(document.forms[0].txt_IbatchIVD.value)>0)
     	{
       		document.forms[0].txt_VD.value=eval(drydays)-eval(document.forms[0].txt_IbatchIVD.value);
       		VL1=eval(lactationday)-eval(document.forms[0].txt_VD.value);
     	}
      	if(eval(VL1)<eval(milkingdays))
   		{
		    document.forms[0].txt_VL.value=eval(VL1);
		    document.forms[0].txt_IbatchVL.value=eval(lactationday)-(eval(document.forms[0].txt_VL.value)+eval(document.forms[0].txt_VD.value));
		    document.forms[0].txt_VIL.value=(eval(milkingdays)-eval(document.forms[0].txt_VL.value));
		    document.forms[0].txt_VID.value=eval(drydays);
		    document.forms[0].txt_IbatchVIL.value=eval(lactationday)-(eval(document.forms[0].txt_VIL.value)+eval(document.forms[0].txt_VID.value));
      	}
    }  
    if(eval(document.forms[0].txt_IbatchIVD.value)>0)
    {
       	document.forms[0].txt_VD.value=eval(drydays)-eval(document.forms[0].txt_IbatchIVD.value);
       	VL1=eval(lactationday)-eval(document.forms[0].txt_VD.value);
      
      	if(eval(VL1)<eval(milkingdays))
   		{
		    document.forms[0].txt_VL.value=eval(VL1);
		    document.forms[0].txt_IbatchVL.value=eval(lactationday)-(eval(document.forms[0].txt_VL.value)+eval(document.forms[0].txt_VD.value));
		    document.forms[0].txt_VIL.value=(eval(milkingdays)-eval(document.forms[0].txt_VL.value));
		    document.forms[0].txt_VID.value=eval(drydays);
		    document.forms[0].txt_IbatchVIL.value=eval(lactationday)-(eval(document.forms[0].txt_VIL.value)+eval(document.forms[0].txt_VID.value));
      	}
       	if(eval(VL1)>eval(milkingdays))
   		{
    		document.forms[0].txt_VL.value=eval(milkingdays);
    		document.forms[0].txt_IbatchVD.value=eval(lactationday)-(eval(document.forms[0].txt_VL.value)+eval(document.forms[0].txt_VD.value));
      	}
    }
    if(eval(document.forms[0].txt_IbatchVD.value)>0)
    {
	    document.forms[0].txt_VID.value=eval(drydays)-eval(document.forms[0].txt_IbatchVD.value);
	    bbm1=eval(lactationday)-eval(document.forms[0].txt_VID.value);
	    if(eval(bbm1)<eval(milkingdays))
	    {
	     	document.forms[0].txt_VIL.value=eval( bbm1);
	      	document.forms[0].txt_VIIL.value=eval(milkingdays)-eval( bbm1);
	     	document.forms[0].txt_VIID.value=eval(drydays);
	      	document.forms[0].txt_IbatchVIIL.value=eval(lactationday)-(eval(document.forms[0].txt_VIIL.value)+eval(document.forms[0].txt_VIID.value));
	    }
    	if(eval(bbm1)==eval(milkingdays))
    	{
	     	document.forms[0].txt_VIL.value=eval(milkingdays);
	     	document.forms[0].txt_VIID.value=eval(drydays);
	     	document.forms[0].txt_VIIL.value=eval(lactationday)-eval( document.forms[0].txt_VIID.value);
	      	document.forms[0].txt_IbatchVIIL.value=eval(lactationday)-(eval(document.forms[0].txt_VIIL.value)+eval(document.forms[0].txt_VIID.value));
    	}
    	if(eval(bbm1)>eval(milkingdays))
    	{
     		document.forms[0].txt_VIL.value=eval(milkingdays);
      		document.forms[0].txt_IbatchVID.value=eval(lactationday)-(eval(document.forms[0].txt_VIL.value)+eval(document.forms[0].txt_VID.value));
    	}
    }
    if(eval(document.forms[0].txt_IbatchVID.value)>0)
    {
	    document.forms[0].txt_VIID.value=eval(drydays)-eval(document.forms[0].txt_IbatchVID.value);
	    bbm81=eval(lactationday)-eval(document.forms[0].txt_VIID.value);
	    
	    if(eval(bbm81)>eval(milkingdays))
	    {
	     	document.forms[0].txt_VIIL.value=eval(milkingdays);
	      	document.forms[0].txt_IbatchVIID.value=eval(lactationday)-(eval(document.forms[0].txt_VIIL.value)+eval(document.forms[0].txt_VIID.value));
	    }
    	if(eval(bbm81)<eval(milkingdays))
    	{
     		document.forms[0].txt_VIIL.value=eval(bbm81);
      		document.forms[0].txt_IbatchVIIL.value=eval(lactationday)-(eval(document.forms[0].txt_VIIL.value)+eval(document.forms[0].txt_VIID.value));
    	}
    	if(eval(bbm81)==eval(milkingdays))
    	{
     		document.forms[0].txt_VIIL.value=eval(milkingdays);
      		document.forms[0].txt_IbatchVIID.value=eval(lactationday)-(eval(document.forms[0].txt_VIIL.value)+eval(document.forms[0].txt_VIID.value));
    	}
    }
  	if((eval(document.forms[0].txt_IbatchVL.value)>0))
   	{
   		document.forms[0].txt_VIL.value=eval(milkingdays)-eval(document.forms[0].txt_IbatchVL.value);
   		VIL1=eval(lactationday)-eval(document.forms[0].txt_VIL.value);
   		if(eval(VIL1)>eval(drydays))
   		{
   			document.forms[0].txt_VID.value=eval(drydays);
   			document.forms[0].txt_IbatchVIL.value=eval(lactationday)-(eval(document.forms[0].txt_VIL.value)+eval(document.forms[0].txt_VID.value));
   		}
   		if(eval(VIL1)<eval(drydays))
   		{
		   	document.forms[0].txt_VID.value=eval(VIL1);
		   	document.forms[0].txt_VIID.value=eval(drydays)-eval(VIL1);
		   	document.forms[0].txt_IbatchVIL.value=eval(lactationday)-(eval(document.forms[0].txt_VIL.value)+eval(document.forms[0].txt_VID.value));
		   	VIIDm1=eval(lactationday)-eval( document.forms[0].txt_VIID.value);
		   	if(eval(VIIDm1)<eval(milkingdays))
		   	{
			   	document.forms[0].txt_VIIL.value=eval(VIIDm1);
			    document.forms[0].txt_IbatchVIID.value=eval(lactationday)-(eval(document.forms[0].txt_VIIL.value)+eval(document.forms[0].txt_VIID.value));
		   }
		   if(eval(VIIDm1)>eval(milkingdays))
		   {
			   document.forms[0].txt_VIIL.value=eval(milkingdays);
			   document.forms[0].txt_IbatchVIID.value=eval(lactationday)-(eval(document.forms[0].txt_VIIL.value)+eval(document.forms[0].txt_VIID.value));
		   }
		   if(eval(VIIDm1)==eval(milkingdays))
		   {
		   		document.forms[0].txt_VIIL.value=eval(VIIDm1);
		   }
   		}
    }  
    if((eval(document.forms[0].txt_IbatchVIL.value)>0))
   	{
   		document.forms[0].txt_VIIL.value=eval(milkingdays)-eval(document.forms[0].txt_IbatchVIL.value);
	   	VIIL1=eval(lactationday)-eval(document.forms[0].txt_VIIL.value);
	   	if(eval(VIIL1)==eval(drydays))
	   	{
	   		document.forms[0].txt_VIID.value=eval(drydays);
	   		document.forms[0].txt_IbatchVIIL.value=eval(lactationday)-(eval(document.forms[0].txt_VIIL.value)+eval(document.forms[0].txt_VIID.value));
	   	}
	   	if(eval(VIIL1)>eval(drydays))
	   	{
	   		document.forms[0].txt_VIID.value=eval(drydays);
	   		document.forms[0].txt_IbatchVIIL.value=eval(lactationday)-(eval(document.forms[0].txt_VIIL.value)+eval(document.forms[0].txt_VIID.value));
	   	}
	   	if(eval(VIIL1)<eval(drydays))
	   	{
	   		document.forms[0].txt_VIID.value=eval(lactationday)-eval(document.forms[0].txt_VIIL.value);
	   		document.forms[0].txt_IbatchVIIL.value=eval(lactationday)-(eval(document.forms[0].txt_VIIL.value)+eval(document.forms[0].txt_VIID.value));
	   	}
	}  
}

function onloading()
{	
	document.forms[0].txt_lactrationdays.value=txt_lactrationdays;
	document.forms[0].txt_drydays.value=txt_drydays;
	if(txt_months!="")
	{
		document.forms[0].txt_months.value=txt_months;
	}
   	var milkingdays1=document.forms[0].txt_lactrationdays.value;
	var drydays1=document.forms[0].txt_drydays.value;
	var months=document.forms[0].txt_months.value;
 	if(milkingdays1=="")
	{
		document.forms[0].txt_lactrationdays.value=280;
		 document.forms[0].txt_drydays.value=60;
    }
    disablefields(true);
}

function disablefields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=true;
		}		
	}	
	document.forms[0].txt_lactrationdays.readOnly=val;
	document.forms[0].txt_drydays.readOnly=val;
	
	if(batch_purchased=='1')
	{
	document.forms[0].txt_months.disabled=true;
	}
	else
	{
	document.forms[0].txt_months.disabled=val;
	}
}

function calltotal()	
{
    var totalval = 0;
    var firstval  = document.forms[0].txt_IL.value;
    var secondval = document.forms[0].txt_IbatchIL.value;
    var thirdval  = document.forms[0].txtIL.value;
    var fourthval = document.forms[0].txt_IIbatchIL.value;
    if(secondval == "")
    {
     	secondval = 0;
    }
    if(thirdval == "")
    {
    	thirdval = 0;
    }
    if(fourthval == "")
    {
    	 fourthval = 0;
    }
    totalval = eval(firstval) + eval(secondval) + eval(thirdval) + eval(fourthval);
    document.forms[0].txt_firstltotal.value = totalval;
    var firstval  = document.forms[0].txt_ID.value;
    var secondval = document.forms[0].txt_IbatchID.value;
    var thirdval  = document.forms[0].txtID.value;
    var fourthval = document.forms[0].txt_IIbatchID.value;
    if(secondval == "")
    {
     	secondval = 0;
    }
    if(thirdval == "")
    {
    	thirdval = 0;
    }
    if(fourthval == "")
    {
    	 fourthval = 0;
    }
    totalval = eval(firstval) + eval(secondval) + eval(thirdval) + eval(fourthval);
    document.forms[0].txt_firstdtotal.value = totalval;
    var firstval  = document.forms[0].txt_IIL.value;
    var secondval = document.forms[0].txt_IbatchIIL.value;
    var thirdval  = document.forms[0].txtIIL.value;
    var fourthval = document.forms[0].txt_IIbatchIIL.value;
    if(secondval == "")
    {
     	secondval = 0;
    }
    if(thirdval == "")
    {
    	thirdval = 0;
    }
    if(fourthval == "")
    {
    	 fourthval = 0;
    }
    totalval = eval(firstval) + eval(secondval) + eval(thirdval) + eval(fourthval);
    document.forms[0].txt_secondltotal.value = totalval;
    var firstval  = document.forms[0].txt_IID.value;
    var secondval = document.forms[0].txt_IbatchIID.value;
    var thirdval  = document.forms[0].txtIID.value;
    var fourthval = document.forms[0].txt_IIbatchIID.value;
    if(secondval == "")
    {
     	secondval = 0;
    }
    if(thirdval == "")
    {
    	thirdval = 0;
    }
    if(fourthval == "")
    {
    	 fourthval = 0;
    }
    totalval = eval(firstval) + eval(secondval) + eval(thirdval) + eval(fourthval);
    document.forms[0].txt_seconddtotal.value = totalval;
    var firstval  = document.forms[0].txt_IIIL.value;
    var secondval = document.forms[0].txt_IbatchIIIL.value;
    var thirdval  = document.forms[0].txtIIIL.value;
    var fourthval = document.forms[0].txt_IIbatchIIIL.value;
    if(secondval == "")
    {
     	secondval = 0;
    }
    if(thirdval == "")
    {
    	thirdval = 0;
    }
    if(fourthval == "")
    {
    	 fourthval = 0;
    }
    totalval = eval(firstval) + eval(secondval) + eval(thirdval) + eval(fourthval);
    document.forms[0].txt_thirdltotal.value = totalval;
    var firstval  = document.forms[0].txt_IIID.value;
    var secondval = document.forms[0].txt_IbatchIIID.value;
    var thirdval  = document.forms[0].txtIIID.value;
    var fourthval = document.forms[0].txt_IIbatchIIID.value;
    if(secondval == "")
    {
     	secondval = 0;
    }
    if(thirdval == "")
    {
    	thirdval = 0;
    }
    if(fourthval == "")
    {
    	 fourthval = 0;
    }
    totalval = eval(firstval) + eval(secondval) + eval(thirdval) + eval(fourthval);
    document.forms[0].txt_thirddtotal.value = totalval;
    var firstval  = document.forms[0].txt_IVL.value;
    var secondval = document.forms[0].txt_IbatchIVL.value;
    var thirdval  = document.forms[0].txtIVL.value;
    var fourthval = document.forms[0].txt_IIbatchIVL.value;
    if(secondval == "")
    {
     	secondval = 0;
    }
    if(thirdval == "")
    {
    	thirdval = 0;
    }
    if(fourthval == "")
    {
    	 fourthval = 0;
    }
    totalval = eval(firstval) + eval(secondval) + eval(thirdval) + eval(fourthval);
    document.forms[0].txt_fourthltotal.value = totalval;
    var firstval  = document.forms[0].txt_IVD.value;
    var secondval = document.forms[0].txt_IbatchIVD.value;
    var thirdval  = document.forms[0].txtIVD.value;
    var fourthval = document.forms[0].txt_IIbatchIVD.value;
    if(secondval == "")
    {
     	secondval = 0;
    }
    if(thirdval == "")
    {
    	thirdval = 0;
    }
    if(fourthval == "")
    {
    	 fourthval = 0;
    }
    totalval = eval(firstval) + eval(secondval) + eval(thirdval) + eval(fourthval);
    document.forms[0].txt_fourthdtotal.value = totalval;
    var firstval  = document.forms[0].txt_VL.value;
    var secondval = document.forms[0].txt_IbatchVL.value;
    var thirdval  = document.forms[0].txtVL.value;
    var fourthval = document.forms[0].txt_IIbatchVL.value;
    if(secondval == "")
    {
     	secondval = 0;
    }
    if(thirdval == "")
    {
    	thirdval = 0;
    }
    if(fourthval == "")
    {
    	 fourthval = 0;
    }
    totalval = eval(firstval) + eval(secondval) + eval(thirdval) + eval(fourthval);
    document.forms[0].txt_fifthltotal.value = totalval;
    var firstval  = document.forms[0].txt_VD.value;
    var secondval = document.forms[0].txt_IbatchVD.value;
    var thirdval  = document.forms[0].txtVD.value;
    var fourthval = document.forms[0].txt_IIbatchVD.value;
    if(secondval == "")
    {
     	secondval = 0;
    }
    if(thirdval == "")
    {
    	thirdval = 0;
    }
    if(fourthval == "")
    {
    	 fourthval = 0;
    }
    totalval = eval(firstval) + eval(secondval) + eval(thirdval) + eval(fourthval);
    document.forms[0].txt_fifthdtotal.value = totalval;
    var firstval  = document.forms[0].txt_VIL.value;
    var secondval = document.forms[0].txt_IbatchVIL.value;
    var thirdval  = document.forms[0].txtVIL.value;
    var fourthval = document.forms[0].txt_IIbatchVIL.value;
    if(secondval == "")
    {
     	secondval = 0;
    }
    if(thirdval == "")
    {
    	thirdval = 0;
    }
    if(fourthval == "")
    {
    	 fourthval = 0;
    }
    totalval = eval(firstval) + eval(secondval) + eval(thirdval) + eval(fourthval);
    document.forms[0].txt_sixthltotal.value = totalval;
    var firstval  = document.forms[0].txt_VID.value;
    var secondval = document.forms[0].txt_IbatchVID.value;
    var thirdval  = document.forms[0].txtVID.value;
    var fourthval = document.forms[0].txt_IIbatchVID.value;
    if(secondval == "")
    {
     	secondval = 0;
    }
    if(thirdval == "")
    {
    	thirdval = 0;
    }
    if(fourthval == "")
    {
    	 fourthval = 0;
    }
    totalval = eval(firstval) + eval(secondval) + eval(thirdval) + eval(fourthval);
    document.forms[0].txt_sixthdtotal.value = totalval;
    var firstval  = document.forms[0].txt_VIIL.value;
    var secondval = document.forms[0].txt_IbatchVIIL.value;
    var thirdval  = document.forms[0].txtVIIL.value;
    var fourthval = document.forms[0].txt_IIbatchVIIL.value;
    if(secondval == "")
    {
     	secondval = 0;
    }
    if(thirdval == "")
    {
    	thirdval = 0;
    }
    if(fourthval == "")
    {
    	 fourthval = 0;
    }
    totalval = eval(firstval) + eval(secondval) + eval(thirdval) + eval(fourthval);
    document.forms[0].txt_seventhltotal.value = totalval;
    var firstval  = document.forms[0].txt_VIID.value;
    var secondval = document.forms[0].txt_IbatchVIID.value;
    var thirdval  = document.forms[0].txtVIID.value;
    var fourthval = document.forms[0].txt_IIbatchVIID.value;
    if(secondval == "")
    {
     	secondval = 0;
    }
    if(thirdval == "")
    {
    	thirdval = 0;
    }
    if(fourthval == "")
    {
    	 fourthval = 0;
    }
    totalval = eval(firstval) + eval(secondval) + eval(thirdval) + eval(fourthval);
    document.forms[0].txt_seventhdtotal.value = totalval;
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onloading();callLDCows();callLDCows1();calltotal();check()">
<form name="frmpri" method="post" class="normal">
<BR>
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
	<tr>
		<td align="right" width="50%">Lactation Days</td>
		<td align="left" width="50%"><input type="text"
			name="txt_lactrationdays"
			value="<%=Helper.correctNull((String)hshValues.get("txt_lactrationdays"))%>"
			onblur="check();totlacDry()" onKeyPress="allowInteger()" maxlength="3"> (280 Days-360 Days)</td>
	</tr>
	<tr>
		<td align="right">Dry Days</td>
		<td align="left"><input type="text" name="txt_drydays"
			value="<%=Helper.correctNull((String)hshValues.get("txt_drydays"))%>" maxlength="3"
			onblur="callLDCows();check();calltotal();totlacDry()"
			onKeyPress="allowInteger()"> (0 Days- 80 Days)</td>
	</tr>
	<tr>
		
    <td align="right">Interval Between Batches in Months</td>
		<td align="left"><select name="txt_months"
			onChange="check();callLDCows1();calltotal();">
			<option value="0" selected>select</option>
			<option value="1">1</option>
			<option value="2">2</option>
			<option value="3">3</option>
			<option value="4">4</option>
			<option value="5">5</option>
			<option value="6">6</option>

		</select></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
	<tr class="dataheader">
		<td width="9%" align="center"><b>&nbsp;</b></td>
		<td width="13%" colspan="2" align="center"><b>I</b></td>
		<td width="13%" colspan="2" align="center"><b>II</b></td>
		<td width="13%" colspan="2" align="center"><b>III</b></td>
		<td width="13%" colspan="2" align="center"><b>IV</b></td>
		<td width="13%" colspan="2" align="center"><b>V</b></td>
		<td width="13%" colspan="2" align="center"><b>VI</b></td>
		<td width="13%" colspan="2" align="center"><b>VII</b></td>
	</tr>
	<tr class="dataheader">
		<td width="7%" align="center">&nbsp;</td>
		<td width="7%" align="center"><b>L</b></td>
		<td width="6%" align="center"><b>D</b></td>
		<td width="7%" align="center"><b>L</b></td>
		<td width="6%" align="center"><b>D</b></td>
		<td width="7%" align="center"><b>L</b></td>
		<td width="6%" align="center"><b>D</b></td>
		<td width="7%" align="center"><b>L</b></td>
		<td width="6%" align="center"><b>D</b></td>
		<td width="7%" align="center"><b>L</b></td>
		<td width="6%" align="center"><b>D</b></td>
		<td width="7%" align="center"><b>L</b></td>
		<td width="6%" align="center"><b>D</b></td>
		<td width="7%" align="center"><b>L</b></td>
		<td width="6%" align="center"><b>D</b></td>
	</tr>
	<tr>
		<td rowspan="2" class="dataheader"><b>I Batch</b></td>
		<td><input type="text" size="9" name="txt_IL" value=""></td>
		<td><input type="text" size="9" name="txt_ID" value=""></td>
		<td><input type="text" size="9" name="txt_IIL" value=""></td>
		<td><input type="text" size="9" name="txt_IID" value=""></td>
		<td><input type="text" size="9" name="txt_IIIL" value=""></td>
		<td><input type="text" size="9" name="txt_IIID" value=""></td>
		<td><input type="text" size="9" name="txt_IVL" value=""></td>
		<td><input type="text" size="9" name="txt_IVD" value=""></td>
		<td><input type="text" size="9" name="txt_VL" value=""></td>
		<td><input type="text" size="9" name="txt_VD" value=""></td>
		<td><input type="text" size="9" name="txt_VIL" value=""></td>
		<td><input type="text" size="9" name="txt_VID" value=""></td>
		<td><input type="text" size="9" name="txt_VIIL" value=""></td>
		<td><input type="text" size="9" name="txt_VIID" value=""></td>
	</tr>
	<tr>
		<td><input type="text" size="9" name="txt_IbatchIL" value=""></td>
		<td><input type="text" size="9" name="txt_IbatchID" value=""></td>
		<td><input type="text" size="9" name="txt_IbatchIIL" value=""></td>
		<td><input type="text" size="9" name="txt_IbatchIID" value=""></td>
		<td><input type="text" size="9" name="txt_IbatchIIIL" value=""></td>
		<td><input type="text" size="9" name="txt_IbatchIIID" value=""></td>
		<td><input type="text" size="9" name="txt_IbatchIVL" value=""></td>
		<td><input type="text" size="9" name="txt_IbatchIVD" value=""></td>
		<td><input type="text" size="9" name="txt_IbatchVL" value=""></td>
		<td><input type="text" size="9" name="txt_IbatchVD" value=""></td>
		<td><input type="text" size="9" name="txt_IbatchVIL" value=""></td>
		<td><input type="text" size="9" name="txt_IbatchVID" value=""></td>
		<td><input type="text" size="9" name="txt_IbatchVIIL" value=""></td>
		<td><input type="text" size="9" name="txt_IbatchVIID" value=""></td>
	</tr>
	<tr>
		<td rowspan="2" class="dataheader"><b>II Batch</b></td>
		<td><input type="text" size="9" name="txtIL" value=""></td>
		<td><input type="text" size="9" name="txtID" value=""></td>
		<td><input type="text" size="9" name="txtIIL" value=""></td>
		<td><input type="text" size="9" name="txtIID" value=""></td>
		<td><input type="text" size="9" name="txtIIIL" value=""></td>
		<td><input type="text" size="9" name="txtIIID" value=""></td>
		<td><input type="text" size="9" name="txtIVL" value=""></td>
		<td><input type="text" size="9" name="txtIVD" value=""></td>
		<td><input type="text" size="9" name="txtVL" value=""></td>
		<td><input type="text" size="9" name="txtVD" value=""></td>
		<td><input type="text" size="9" name="txtVIL" value=""></td>
		<td><input type="text" size="9" name="txtVID" value=""></td>
		<td><input type="text" size="9" name="txtVIIL" value=""></td>
		<td><input type="text" size="9" name="txtVIID" value=""></td>
	</tr>
	<tr>
		<td><input type="text" size="9" name="txt_IIbatchIL" value=""></td>
		<td><input type="text" size="9" name="txt_IIbatchID" value=""></td>
		<td><input type="text" size="9" name="txt_IIbatchIIL" value=""></td>
		<td><input type="text" size="9" name="txt_IIbatchIID" value=""></td>
		<td><input type="text" size="9" name="txt_IIbatchIIIL" value=""></td>
		<td><input type="text" size="9" name="txt_IIbatchIIID" value=""></td>
		<td><input type="text" size="9" name="txt_IIbatchIVL" value=""></td>
		<td><input type="text" size="9" name="txt_IIbatchIVD" value=""></td>
		<td><input type="text" size="9" name="txt_IIbatchVL" value=""></td>
		<td><input type="text" size="9" name="txt_IIbatchVD" value=""></td>
		<td><input type="text" size="9" name="txt_IIbatchVIL" value=""></td>
		<td><input type="text" size="9" name="txt_IIbatchVID" value=""></td>
		<td><input type="text" size="9" name="txt_IIbatchVIIL" value=""></td>
		<td><input type="text" size="9" name="txt_IIbatchVIID" value=""></td>
	</tr>
	<tr>
		<td class="dataheader"><b>Total</b></td>
		<td><input type="text" size="9" name="txt_firstltotal" value=""></td>
		<td><input type="text" size="9" name="txt_firstdtotal" value=""></td>
		<td><input type="text" size="9" name="txt_secondltotal" value=""></td>
		<td><input type="text" size="9" name="txt_seconddtotal" value=""></td>
		<td><input type="text" size="9" name="txt_thirdltotal" value=""></td>
		<td><input type="text" size="9" name="txt_thirddtotal" value=""></td>
		<td><input type="text" size="9" name="txt_fourthltotal" value=""></td>
		<td><input type="text" size="9" name="txt_fourthdtotal" value=""></td>
		<td><input type="text" size="9" name="txt_fifthltotal" value=""></td>
		<td><input type="text" size="9" name="txt_fifthdtotal" value=""></td>
		<td><input type="text" size="9" name="txt_sixthltotal" value=""></td>
		<td><input type="text" size="9" name="txt_sixthdtotal" value=""></td>
		<td><input type="text" size="9" name="txt_seventhltotal" value=""></td>
		<td><input type="text" size="9" name="txt_seventhdtotal" value=""></td>
	</tr>
</table>
<br>
<table border="0" cellspacing="1" cellpadding="3" class="outertable" width="40%" align="left">
<tr>
  <td width="40%" align="center"><b>L - Lactation Days</b></td>
  <td width="10%">&nbsp;</td>
  <td width="40%"><b>D - Dry Days</b></td>
</tr>
</table>
<br/>
<br/>
<table border="0" cellspacing="1" cellpadding="3" class="outertable" width="100%">
 <tr>
	<td><b><u>Assumption</u></b></td>
 </tr>
 <tr>
  <td>1. A year consists of 360 Days</td>
 </tr>
 <tr>
   <td>2. Animals purchased within one month of its calving &amp; hence 30 days of milking in 
		  vendors place.<BR>&nbsp;&nbsp;&nbsp;Therefore milking days are reduced 
		  by 30 days in newly inducted animals.&nbsp;</td>
 </tr>
</table>
<br/>
<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<lapschoice:agrihiddentag pageid="<%=PageId%>"/>
<input type="hidden" name="hidAuditFlag" value="<%=Helper.correctNull((String)hshValues.get("auditFlag"))%>">
</form>
</body>
</html>

