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
	var rpout=document.forms[0].hidCatFields.value;
	var dt=document.forms[0].txtDate.value;
	var sdt=document.forms[0].txtSaveDate.value;
	var orglevel=document.forms[0].sellevel.value;
	var prodttype=document.forms[0].prodttype.value;
	var len = document.forms[0].prodcat.length;	
	 var orgname = document.forms[0].hidOrgName.value;
	for(i=0;i<len;i++)
	{
		 if(document.forms[0].prodcat.options[i].selected==true)
		 {
			 var hidprodcat_text = document.forms[0].prodcat.options[i].text; 
			break;
		 }
	}
	
	if (document.forms[0].txtDate.value == "")
		{
		ShowAlert('121',"Period");
		document.forms[0].txtDate.focus();
		return false;
		}
	
	if (param !="")
	{
		window.open(path+"action/perunappdisposal.jsp?hidBeanId=repappsoar&hidBeanMethod=getData&hidMethod=getRepDetails&hidLoanType=P&hidPrdCode=p&hidCatFields="+rpout+"&txtDate="+dt+"&txtSaveDate="+sdt+"&hidOrgCode="+code+"&hidOpFields="+outf+"&hidSelFields="+dbf+"&orglevel="+orglevel+"&hidprodcat_text="+hidprodcat_text+"&prodttype="+prodttype +"&hidOrgName="+orgname,"cred","scrollbars=Yes,toolbars=No,menubar=no ,width=750 , height=550,top=10,left=10");
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
	var source="/action/perrepappsoar.jsp";
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
	var prd="";
	var org="";
	param="";
	var org_name="";
	
	if(document.forms[0].sellevel.selectedIndex != 0 
		&& document.forms[0].prodttype.selectedIndex != 0  
		&& document.forms[0].prodcat.selectedIndex != 0
		&&	document.forms[0].rpselect1.selectedIndex != -1 
		&&	document.forms[0].rpprod.selectedIndex != -1 ) 
	{
	//if (document.forms[0].txtDate.value == "")
	//{
	//	document.forms[0].txtDate.value="All";
	//}
   var dt =document.forms[0].txtDate.value;
	var cat =document.forms[0].prodcat.options[document.forms[0].prodcat.selectedIndex].value;
	//var subcat =document.forms[0].subcat.options[document.forms[0].subcat.selectedIndex].value;
		
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
				org =org +"'"+c+"',";
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
		var subcat="";
		for(x=0;x<document.forms[0].rpprod.length;x++)
		{
			if (document.forms[0].rpprod[x].selected)
			{
				count++;
				prd =prd +document.forms[0].rpprod.options[x].text+",";
				subcat =subcat +document.forms[0].rpprod.options[x].value+",";
			}										
			
		}
		if (count > 0)
		{
			prd= prd.substring(0,prd.length-1);
			subcat= subcat.substring(0,subcat.length-1);
		}				
		
   
    param =orgcode+";"+org+";"+subcat+";"+dt+";P;P;";

		count =0;
		for(x=0;x<document.forms[0].rpselect2.length;x++)
		{
			
				count++;
				opfields =opfields +document.forms[0].rpselect2.options[x].value+",";
				dbfields =dbfields +document.forms[0].rpselect2.options[x].text+",";
							
			
		}
		if (count > 0)
		{
			dbfields= dbfields.substring(0,dbfields.length-1);
			opfields= opfields.substring(0,opfields.length-1);
		}
	
	param +=opfields+";";
	param +=dbfields;

	document.forms[0].hidParam.value=param;
	document.forms[0].hidOrgCode.value =org;	
	document.forms[0].hidOpFields.value =opfields;	
	document.forms[0].hidSelFields.value =dbfields;	
	document.forms[0].hidCatFields.value =subcat;	
	document.forms[0].hidOrgName.value =org_name;
	}
	else if(document.forms[0].sellevel.selectedIndex == 0)
	{
		ShowAlert('111',"Organisation Level");
		document.forms[0].sellevel.focus();
		return false;
	}
	else if(document.forms[0].prodttype.selectedIndex == 0)
	{
		ShowAlert('111',"Category");
		document.forms[0].prodcat.focus();
		return false;
	}
	else if(document.forms[0].prodcat.selectedIndex == 0)
	{
		ShowAlert('111',"Sub Category");
		document.forms[0].product.focus();
		return false;
	}
	else if(document.forms[0].rpselect1.selectedIndex == -1)
	{
		ShowAlert('111','Organisation');
		document.forms[0].rpselect1.focus();
		return false;
	}
		else if(document.forms[0].rpprod.selectedIndex == -1)
	{
		ShowAlert('111','Product');
		document.forms[0].rpprod.focus();
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
	document.forms[0].rpselect1.length =0;
	document.forms[0].prodcat.selectedIndex =0;
	document.forms[0].rpprod.selectedIndex =0;
	document.forms[0].rpprod.length =0;
	document.forms[0].txtDate.value="";
	document.forms[0].prodttype.value="0";


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
	document.forms[0].rpselect1.length =0;
	document.forms[0].prodttype.selectedIndex =0;
	document.forms[0].prodcat.selectedIndex =0;
	document.forms[0].rpprod.length =0;
	document.forms[0].txtDate.value="";
	var bnkname = document.forms[0].sellevel.options[document.forms[0].sellevel.selectedIndex].value;
 document.all.ifrm.src=path+"action/iframeapprep.jsp?hidBeanMethod=getData&hidMethod=getOrgnames&hidBeanId=repappper&bnklevel="+bnkname;
}


function selectSubCat()
{
	deSelect();
	document.forms[0].product.options[0].selected = true;
	if (document.forms[0].rpselect1.length != 0)
    {
		var pr = document.forms[0].prodcat.options[document.forms[0].prodcat.selectedIndex].value;
		document.all.ifrmp.src=path+"action/iframecreditrep.jsp?hidBeanMethod=getData&hidMethod=getProducts&hidBeanId=repappper&hidProducts=subprod&prodtype="+pr;
		
	}
	else
	{
		document.forms[0].prodcat.selectedIndex =0;
		alert("No Rights to view");
	}

}
function selectProd()
{
	document.forms[0].rpprod.length=0;
	var count=0;
	var org="";
	var strBankVal="";

	for(x=0;x<document.forms[0].rpselect1.length;x++)
		{
			if (document.forms[0].rpselect1[x].selected)
			{
				var c = document.forms[0].rpselect1.options[x].value;
				strBankLevel =c.substring(0,1);
				org = c.substring(2,c.length);
				break;
			}
		}
	if (strBankLevel=="C")
	{
		strBankVal = "'"+org+"'";
	}
	else if (strBankLevel=="R")
	{
		strBankVal = "'"+org.substring(0,6)+"000000000";
		strBankVal = strBankVal +"','"+ org.substring(0,3)+"000000000000'";
	}
	else if (strBankLevel=="D")
	{
		strBankVal = "'"+org.substring(0,9)+"000000";
		strBankVal = strBankVal+"','"+ org.substring(0,6)+"000000000";
		strBankVal = strBankVal +"','"+ org.substring(0,3)+"000000000000'";
	}
	else if (strBankLevel=="A")
	{
		strBankVal = "'"+org.substring(0,12)+"000";
		strBankVal = strBankVal+"','"+org.substring(0,9)+"000000";
		strBankVal = strBankVal+"','"+ org.substring(0,6)+"000000000";
		strBankVal = strBankVal +"','"+ org.substring(0,3)+"000000000000'";

	}
	else if (strBankLevel=="B")
	{
		strBankVal = "'"+org.substring(0,15);
		strBankVal = strBankVal+"','"+org.substring(0,12)+"000";
		strBankVal = strBankVal+"','"+org.substring(0,9)+"000000";
		strBankVal = strBankVal+"','"+ org.substring(0,6)+"000000000";
		strBankVal = strBankVal +"','"+ org.substring(0,3)+"000000000000'";

	}

	if (document.forms[0].rpselect1.length != 0)
	{
	var pt = document.forms[0].prodttype.options[document.forms[0].prodttype.selectedIndex].value;
	var pc = document.forms[0].prodcat.options[document.forms[0].prodcat.selectedIndex].value;
	var pr=pt+pc;
	document.all.ifrm.src=path+"action/iframecreditrep.jsp?hidBeanMethod=getData&hidMethod=getAllProductsDesc&hidBeanId=repappper&hidProducts=getAllProductsDesc&&hidLoanType=P&hidOrgCode="+strBankVal+"&prodtype="+pr;
	}
	else
	{
		alert("No Rights to view");
	}
		

}
function onsel()
{
	deSelect();

}
function deSelect()
{
	document.forms[0].rpprod.length=0;
	for(x=0;x<document.forms[0].rpselect1.length;x++)
		{
			if (document.forms[0].rpselect1[x].selected == true)
			{
				document.forms[0].rpselect1.options.selectedIndex=-1;

			}
		}
}

