function loadValues()
{
	rights = rights.substring(rights.length-1,rights.length);
	if (rights == "c")
	{
		document.forms[0].prodopt.options[document.forms[0].prodopt.options.length]=new Option('Comm/Term Loan',"CT");
		document.forms[0].prodopt.options[document.forms[0].prodopt.options.length]= new Option('Comm/Working Capital',"CW");
	}
	else if (rights =="p")
	{	
		document.forms[0].prodopt.options[document.forms[0].prodopt.options.length]=new Option('Personal',"P");
	}
	else if (rights == "b")
	{
		document.forms[0].prodopt.options[document.forms[0].prodopt.options.length]=new Option('Comm/Term Loan',"CT");
		document.forms[0].prodopt.options[document.forms[0].prodopt.options.length]= new Option('Comm/Working Capital',"CW");
		document.forms[0].prodopt.options[document.forms[0].prodopt.options.length]=new Option('Personal',"P");
		document.forms[0].prodopt.options[document.forms[0].prodopt.options.length]=new Option('Others',"O");
	}
	/*else if (rights == "x")
	{
		ShowAlert("125");
		closeWindow();
	}*/

}


function selectValues()
{
	document.forms[0].prodcat.options[0].selected = true;
	document.forms[0].product.length = 0;
	if (document.forms[0].prodopt.selectedIndex == 0)
    {
		document.forms[0].prodcat.length =1;
		document.forms[0].prodcat.selectedIndex =0;
    }
	else
	{
	prodid = document.forms[0].prodopt.options[document.forms[0].prodopt.selectedIndex].value;
document.all.ifrm.src=path+"action/iframesetprodrep.jsp?hidBeanMethod=getData&hidMethod=getProducts&hidFromWhichPage=main&hidBeanId=prodflow&hidProducts=prod&prodtype="+prodid;
	}
	

}
function selectSub()
{
	document.forms[0].product.selectedIndex =-1;
	document.forms[0].product.length = 0;
	prodid = document.forms[0].prodcat.options[document.forms[0].prodcat.selectedIndex].value;
document.all.ifrm.src=path+"action/iframesetprodrep.jsp?hidBeanMethod=getData&hidMethod=getProducts&hidFromWhichPage=main&hidBeanId=prodflow&hidProducts=subprod&prodtype="+prodid;

}

function runrep()
{
	var param = setParam();
	var outf =document.forms[0].hidOpFields.value;
	var dbf =document.forms[0].hidSelFields.value;	
   	var dt =document.forms[0].txtDate.value;
	if (param !="")
	{
	 var prodtype =	 document.forms[0].prodopt.options[document.forms[0].prodopt.selectedIndex].value;
	 var count=0;
	 var rpout="";
	 		for(x=0;x<document.forms[0].product.length;x++)
			{
				if (document.forms[0].product[x].selected)
				{
					count++;
					rpout =rpout +document.forms[0].product.options[x].value+",";
				}
			}
			if (count > 0)
			{
				rpout= rpout.substring(0,rpout.length-1);
			}
			
window.open(path+"action/runprodflowrep.jsp?hidBeanId=prodflow&hidBeanMethod=getData&hidMethod=getRepDetails&hidPrdCode="+prodtype+"&hidCatFields="+rpout+"&txtDate="+dt+"&hidOpFields="+outf+"&hidSelFields="+dbf,"Prod","scrollbars=Yes,toolbars=No,menubar=no,width=750,height=550,top=10,left=10");
	}
}

function setParam()
{
	var opfields="";
	var dbfields="";
	var orgcode="";
	var rpfields="";
	var prodtype="";
	var cate="";
	var count=0;
	var rpout="";
	param="";

	if(document.forms[0].prodopt.selectedIndex != 0 && document.forms[0].prodcat.selectedIndex !=0 && document.forms[0].product.selectedIndex != -1) 
	{
		prodtype =	 document.forms[0].prodopt.options[document.forms[0].prodopt.selectedIndex].value;
		cate = document.forms[0].prodcat.options[document.forms[0].prodcat.selectedIndex].value;

		for (i=0;i<document.forms[0].rpselect2.length;i++)
        {
			if (document.forms[0].rpselect2.options[i].selected == true)
			{
				count++;
			}
        }
		if(count < 6)
		{
			for(i=0;i<5;i++)
			{
				document.forms[0].rpselect2.options[i].selected = true;
			}
		}

		orgcode =document.forms[0].product.options[document.forms[0].product.selectedIndex].value;
	    
		param =prodtype+";"+cate+";";
		count=0;
		document.forms[0].rpselect2.options[0].selected = true;
			for(x=0;x<document.forms[0].rpselect2.length;x++)
			{
				if (document.forms[0].rpselect2[x].selected)
				{
					count++;
					opfields =opfields +document.forms[0].rpselect2.options[x].value+",";
					dbfields =dbfields +document.forms[0].rpselect2.options[x].text+",";
								
				}
			}
			if (count > 0)
			{
				dbfields= dbfields.substring(0,dbfields.length-1);
				opfields= opfields.substring(0,opfields.length-1);
			}
			count=0;
			for(x=0;x<document.forms[0].product.length;x++)
			{
				if (document.forms[0].product[x].selected)
				{
					count++;
					rpfields =rpfields +document.forms[0].product.options[x].text+",";
					rpout =rpout +document.forms[0].product.options[x].value+",";
				}
			}
			if (count > 0)
			{
				rpfields= rpfields.substring(0,rpfields.length-1);
				rpout= rpout.substring(0,rpout.length-1);
			}
		param +=rpout+";";
		param +=opfields+";";
		param +=dbfields;

		document.forms[0].hidParam.value=param;
		document.forms[0].hidCatFields.value = rpout;
		document.forms[0].hidPrdCode.value = prodtype;	
		document.forms[0].hidOpFields.value =opfields;	
		document.forms[0].hidSelFields.value =dbfields;	
	}
	else if(document.forms[0].prodopt.selectedIndex == 0)
	{
		ShowAlert("111","Product Type");
		document.forms[0].prodopt.focus();
		return false;
	}
	else if(document.forms[0].prodcat.selectedIndex == 0)
	{
		ShowAlert("111","Product Category");
		document.forms[0].prodcat.focus();
		return false;
	}
	else if(document.forms[0].product.selectedIndex == -1)
	{
		ShowAlert("111","Product Subcategory");
		document.forms[0].product.focus();
		return false;
	}
	
	return param;
}
function save()
{
	var purl="";
	var title = "SaveReport";
	var prop = "scrollbars=no,width=350,height=320";	
	var xpos = (screen.width - 350) / 2;
	var ypos = (screen.height - 320) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	document.forms[0].hidAction.value="Insert";
    document.forms[0].hidBeanId.value="repData";
	document.forms[0].hidBeanMethod.value="updateData";
	document.forms[0].hidSourceUrl.value="/action/repprodflowpoint.jsp";
	var beanid =document.forms[0].hidBeanId.value;
	var action=document.forms[0].hidAction.value;
	var source=document.forms[0].hidSourceUrl.value;
	var repname=document.forms[0].repname.value;
	
	var param = setParam();
	if (param !="")
	{
		purl =path+"action/savereport.jsp?BeanId="+beanid+"&Action="+action;
		purl +="&Source="+source+"&repname="+repname+"&param="+param;
		window.open(purl,title,prop);
	}
}

function browse()
{
	var purl="";
	var title = "BrowseReport";
	var prop = "scrollbars=no,width=400,height=300";	
	var xpos = (screen.width - 400) / 2;
	var ypos = (screen.height - 320) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	document.forms[0].hidBeanId.value="prodflow";
	purl =path+"action/browsereport.jsp?BeanId= prodflow&method=getProfileNames&repname=Product Flowpoint Report&pagename=runprodflowrep.jsp&userid="+userid;
	window.open(purl,title,prop);
}
function resetValues()
{
	document.forms[0].prodopt.options[0].selected =true;
	document.forms[0].product.length =0;

}
function closeWindow()
{
	if (ConfirmMsg("100"))
	{
	document.forms[0].action=path+"action/setuprepnav.jsp";
	document.forms[0].submit();
	}
}