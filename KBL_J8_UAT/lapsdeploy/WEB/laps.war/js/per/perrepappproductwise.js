function showPeriod()
{
	var purl = path+"jsp/share/repdateselect.jsp";
	var title = "ListofPeriod";
	var prop = "scrollbars=no,width=350,height=320";	
	var xpos = (screen.width - 350) / 2;
	var ypos = (screen.height - 320) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,title,prop);
}
 function doRunReport()
{
	var param = setParam();
	var outf =document.forms[0].hidOpFields.value;
	var dbf =document.forms[0].hidSelFields.value;	 
	var code =document.forms[0].hidOrgCode.value;
	var prodtype=document.forms[0].selprodtype.value;
	var prdcode =document.forms[0].hidProducts.value;
	var dt =document.forms[0].txtDate.value;
	var sdt =document.forms[0].txtSaveDate.value;
	var orglevel =document.forms[0].sellevel.value;
	var orgname = document.forms[0].hidOrgName.value;
	
	if (document.forms[0].txtDate.value == "")
	{
		ShowAlert('121',"Period");
		document.forms[0].txtDate.focus();
		return false;
		}
		
	if (param !="")
	{
		window.open(path+"action/perrunappproductwise.jsp?hidBeanId=repappproductwise&hidBeanGetMethod=getData&hidMethod=getRepDetails&hidLoanType="+prodtype+"&hidProducts="+prdcode+"&txtDate="+dt+"&hidOrgCode="+code+"&txtSaveDate="+sdt+"&hidOpFields="+outf+"&hidSelFields="+dbf+"&orglevel="+orglevel+"&hidOrgName="+orgname,"stat","scrollbars=Yes,toolbars=No,menubar=no,width=750,height=550,top=10,left=10");
	}
		
	
}

function save()
{
	var purl="";
	var title = "SaveReport";
	var prop = "scrollbars=no,width=350,height=320";	
	var xpos = (screen.width - 350) / 2;
	var ypos = (screen.height - 320) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	
	var usrid =userid;
	var beanid ="repData";
	var action="Insert";
	var source="/action/perrepappproductwise.jsp";
	var repname=document.forms[0].repname.value;
	
	var param = setParam();
	if (param !="")
	{
		purl =path+"action/savereport.jsp?BeanId="+beanid+"&Action="+action;
		purl +="&Source="+source+"&repname="+repname+"&param="+param;
		window.open(purl,title,prop);
	}
}

function setParam()
{
	var opfields="";
	var dbfields="";
	var orgcode="";
	var orgname="";
	var count=0;
	var org="";
	var prdcode="";
	var prdval="";
	param="";
	var org_name="";
	
	if(document.forms[0].sellevel.selectedIndex != 0 
			&&	document.forms[0].rpselect1.selectedIndex != -1
		    &&	document.forms[0].selappno.selectedIndex != -1 ) 
	{
	
   var dt =document.forms[0].txtDate.value;
//	if (document.forms[0].txtDate.value == "")
//	{
	//	dt="All";
	//}
  	    		document.forms[0].txtDate.value =dt;
  orgcode =document.forms[0].sellevel.options[document.forms[0].sellevel.selectedIndex].text;
   
   for (i=0;i<document.forms[0].rpselect2.length;i++)
       	{
			if (document.forms[0].rpselect2.options[i].selected == true)
			{
				count++;
			}
        }
		if(count == 0)
		{
			for(i=0;i<4;i++)
			{
				document.forms[0].rpselect2.options[i].selected = true;
			}
		}
   
   count =0;
	for(x=0;x<document.forms[0].rpselect1.length;x++)
	{
		if (document.forms[0].rpselect1[x].selected)
		{
			count++;
			var c = document.forms[0].rpselect1.options[x].value;
			c = c.substring(2,c.length);
			org =org + c+",";
			c = document.forms[0].rpselect1.options[x].text;
		    org_name =org_name + " , " + c ;			
		}
	}
	if (count > 0)
	{
		org= org.substring(0,org.length-1);
		org_name= org_name.substring(2,org_name.length);
	}

	count =0;
	for(x=0;x<document.forms[0].selappno.length;x++)
	{
		if (document.forms[0].selappno[x].selected)
		{
			count++;
			var c = document.forms[0].selappno.options[x].value;
			var c1= document.forms[0].selappno.options[x].text;
			prdcode =prdcode + c+"','";
			prdval =prdval +c1+"','";
					
		}
	}
	if (count > 0)
	{
		prdcode= prdcode.substring(0,prdcode.length-3);
		prdval= prdval.substring(0,prdval.length-3);
	}
				
		
   
    param =orgcode+";"+org+";"+prdcode+";"+dt+";";
	var dt =document.forms[0].txtDate.value;
	count =0;
		for(x=0;x<document.forms[0].rpselect2.length;x++)
		{
			count++;
			document.forms[0].rpselect2[x].selected=true;
			/*if(dt!='All' && x=='1')
			{
				opfields =opfields +"cat_name"+",";
			}
			else
			{*/
				opfields =opfields +document.forms[0].rpselect2.options[x].value+",";
			
				dbfields =dbfields +document.forms[0].rpselect2.options[x].text+",";
							
			
		}
		if (count > 0)
		{
			dbfields= dbfields.substring(0,dbfields.length-1);
			opfields= opfields.substring(0,opfields.length-1);
		}
	
	param +=opfields+";";
	param +=dbfields+";P;"+prdval;

	document.forms[0].hidParam.value=param;
	document.forms[0].hidOrgCode.value =org;	
	document.forms[0].hidProducts.value =prdcode;
	document.forms[0].hidOpFields.value =opfields;	
	document.forms[0].hidSelFields.value =dbfields;	
	document.forms[0].hidOrgName.value =org_name;
	}
	else if(document.forms[0].sellevel.selectedIndex == 0)
	{
		ShowAlert('111',"Organisation Level");
		document.forms[0].sellevel.focus();
		return false;
	}
	else if(document.forms[0].rpselect1.selectedIndex == -1)
	{
		ShowAlert('111',"Organisation");
		document.forms[0].rpselect1.focus();
		return false;
	}
	else if(document.forms[0].selappno.selectedIndex == -1)
	{
		ShowAlert('111','Product');
		document.forms[0].selappno.focus();
		return false;
	}
	
	
	return param;
}

function browse()
{
	var user=userid;
	var purl="";
	var title = "BrowseReport";
	var prop = "scrollbars=no,width=400,height=300";	
	var xpos = (screen.width - 400) / 2;
	var ypos = (screen.height - 320) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	var repname= document.forms[0].repname.value;
	purl =path+"action/browsereport.jsp?BeanId= repData&userid="+user+"&method=getProfileNames&repname="+repname+"";
	window.open(purl,title,prop);
}

function doReset()
{
	document.forms[0].sellevel.options[0].selected =true;
	document.forms[0].selappno.length =0;
	document.forms[0].rpselect1.length =0;
	document.forms[0].txtDate.value="";
	document.forms[0].selprodtype.value="S";

}
function doClose()
{
	if (ConfirmMsg("100"))
	{
	document.forms[0].hidBeanId.disabled=true;
	document.forms[0].action=path+"action/apprepnav.jsp";
	document.forms[0].submit();
	}
}


function selectValues()
{
	document.forms[0].rpselect1.selectedIndex =-1;
	document.forms[0].selappno.length=0;
	var bnkname = document.forms[0].sellevel.options[document.forms[0].sellevel.selectedIndex].value;

 document.all.ifrm.src=path+"action/iframeapprep.jsp?hidBeanMethod=getData&hidMethod=getOrgnames&hidBeanId=repappper&bnklevel="+bnkname;
}
function selectProduct()
{
	var prodtype=document.forms[0].selprodtype.value;
	if(prodtype=="S")
	{
		ShowAlert('111','Product Type');
		return;
	}
	var count =0;
	var org="";
	var strBankLevel="";
	var  strBankVal="";
	var strBankCode="";
	document.forms[0].selappno.length=0;
	/*for(x=0;x<document.forms[0].rpselect1.length;x++)
	{
		if (document.forms[0].rpselect1[x].selected)
		{
			var c = document.forms[0].rpselect1.options[x].value;
			var c =document.forms[0].rpselect1.options[x].value;
			strBankLevel =c.substring(0,1);
			strBankCode = c.substring(2,c.length);
			break;
					
		}
	}
	
	if (strBankLevel=="C")
	{
		strBankVal = "'"+strBankCode.substring(0,3)+"000000000000'";
	}
	else if (strBankLevel=="R")
	{
		strBankVal = "'"+strBankCode.substring(0,6)+"000000000";
		strBankVal = strBankVal +"','"+ strBankCode.substring(0,3)+"000000000000'";
	}
	else if (strBankLevel=="D")
	{
		strBankVal = "'"+strBankCode.substring(0,9)+"000000";
		strBankVal = strBankVal+"','"+ strBankCode.substring(0,6)+"000000000";
		strBankVal = strBankVal +"','"+ strBankCode.substring(0,3)+"000000000000'";
	}
	else if (strBankLevel=="A")
	{
		strBankVal = "'"+strBankCode.substring(0,12)+"000";
		strBankVal = strBankVal+"','"+strBankCode.substring(0,9)+"000000";
		strBankVal = strBankVal+"','"+ strBankCode.substring(0,6)+"000000000";
		strBankVal = strBankVal +"','"+ strBankCode.substring(0,3)+"000000000000'";

	}
	else if (strBankLevel=="B")
	{
		strBankVal = "'"+strBankCode.substring(0,15);
		strBankVal = strBankVal+"','"+strBankCode.substring(0,12)+"000";
		strBankVal = strBankVal+"','"+strBankCode.substring(0,9)+"000000";
		strBankVal = strBankVal+"','"+ strBankCode.substring(0,6)+"000000000";
		strBankVal = strBankVal +"','"+ strBankCode.substring(0,3)+"000000000000'";

	}*/
	
//	alert(path+"action/iframeprimrep.jsp?hidBeanMethod=getData&hidMethod=getOrgProducts&hidPrdType=P&hidBeanId=repappproductwise&hidOrgCode="+strBankVal);

//	document.all.ifrm.src=path+"action/iframeprimrep.jsp?hidBeanMethod=getData&hidMethod=getOrgProducts&hidPrdType=P&hidBeanId=repappproductwise&hidOrgCode="+strBankVal+"&prodtype="+prodtype;
	document.all.ifrm.src=path+"action/iframeprimrep.jsp?hidBeanMethod=getData&hidMethod=getOrgProducts&hidPrdType=P&hidBeanId=repappproductwise&prodtype="+prodtype;
	
}

