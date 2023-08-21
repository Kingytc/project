function getValue()
{
   	var len = document.forms[0].selProd.length;
	var temp ="",temp1="";
	for(i=0;i<len;i++)
	{
		 if(document.forms[0].selProd.options[i].selected==true)
		 {
			temp = document.forms[0].selProd.options[i].value; 
			temp1 = document.forms[0].selProd.options[i].text; 
			break;
		 }
	}
	document.forms[0].hidcat_parent.value=temp.substring(0,temp.indexOf('-'));
    document.forms[0].txtcat_name.value="";
    document.forms[0].audit_Category.value=temp1;
	if (mode =="edit")
	{
		document.forms[0].txtcat_name.disabled=true;
	}
	else if (mode =="new")
	{
		document.forms[0].txtcat_name.focus();
	}
}

function doNew()
{
	mode = "new";
	document.forms[0].txtcat_name.disabled = false;
	document.forms[0].rad[0].disabled = false;
	document.forms[0].rad[1].disabled = false;
	document.forms[0].txtcat_name.focus();
	document.forms[0].cmdsave.disabled = false;
	document.forms[0].cmdnew.disabled = true;
	document.forms[0].cmdedit.disabled = true;
	document.forms[0].cmdcancel.disabled = false;
	//document.forms[0].buthelp.disabled = false;
	document.forms[0].cmdclose.disabled = true;
	document.forms[0].selProd.disabled = false;
	document.forms[0].sel_active.disabled = false;
	document.forms[0].sel_active.value = "S";
	getFocus();
}

function showMsg()
{	
	if (strAction == "failed" )
	{
		 alert(strMsg);
	}
}

function loadPage()
{
	for (i=0;i<document.forms[0].elements.length;i++)
	{
		document.forms[0].elements[i].disabled = true;
	}
	document.forms[0].cmdnew.disabled = false;
	document.forms[0].cmdedit.disabled = false;
	//document.forms[0].buthelp.disabled = false;
	document.forms[0].cmdclose.disabled = false;
	//document.forms[0].cmdaudittrail.disabled = false;
	document.forms[0].rad[0].disabled = false;
	document.forms[0].rad[1].disabled = false;
	document.forms[0].rad[0].checked = true;
	document.forms[0].txtcat_name.value="";
	document.forms[0].sel_active.value = "S";
	showFields();
}

function showProduct()
{
   	if (document.forms[0].rad[0].checked == true && mode =="edit")
	{
		show('parent',"0");
		document.forms[0].hidcat_parent.value="0";
	}
	else if (document.forms[0].rad[1].checked == true && mode == "edit")
	{
	    var par = document.forms[0].hidcat_parent.value;
       	if (mode == "edit")
		{
		   	if (document.forms[0].selProd.selectedIndex == 0)
		   	{
				ShowAlert("111","Category");
				document.forms[0].selProd.focus();
		   	}
		   	else
		   	{
				show('subsel',par);
			}
		}
		else
		{
			show('sub',par);
		}
	}	
}

function getFocus()
{
	if (document.forms[0].rad[0].checked == true)
	{
		document.forms[0].txtcat_name.focus();
	}
	else if (document.forms[0].rad[1].checked == true)
	{
       document.forms[0].selProd.focus();
	}
}

function show(val,val2)
{   
	var purl = path+"jsp/share/prodlist.jsp?hidMethod=getProd&page=product&cat="+val+"&select="+val2+"&beanid=productcat&method=getData";
	var title = "ListofCategory";
	var prop = "scrollbars=no,width=600,height=400";	
	var xpos = (screen.width - 600) / 2;
	var ypos = (screen.height - 400) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,title,prop);
	document.forms[0].selProd.disabled = false;
	document.forms[0].cmdnew.disabled = true;
	document.forms[0].cmdedit.disabled = true;
	document.forms[0].cmdsave.disabled = false;
	document.forms[0].cmdcancel.disabled = false;
	document.forms[0].cmddelete.disabled = false;
	//document.forms[0].buthelp.disabled = false;
	document.forms[0].cmdclose.disabled = true;	
}

function showFields()
{
	if (document.forms[0].rad[0].checked == true)
	{
	  	document.all.categ.style.visibility ="visible";   
		document.all.subcateg.style.visibility="hidden";
		catLabel();

	}
	else
	{
		document.all.categ.style.visibility ="visible";   
		document.all.subcateg.style.visibility="visible";
		catLabel();
		document.forms[0].selProd.selectedIndex =0;
	}
	document.forms[0].txtcat_name.value="";
}

function doSave()
{

  if(document.forms[0].rad[0].checked == true)
  {
	  if(document.forms[0].sel_active.value == "S" ||document.forms[0].sel_active.value == "")
		{
			ShowAlert("111"," Active");
			return;
			}
     if (document.forms[0].txtcat_name.value !="")
	 {
		submitData();
	 }
	 else
	 {
		if (mode == "edit")
		{
			ShowAlert("111","Category");
		}
		else if (mode == "new")
		{
			ShowAlert("112","Category");
			document.forms[0].txtcat_name.disabled = false;
			document.forms[0].txtcat_name.focus();
		}
	 }
  }
  else if(document.forms[0].rad[1].checked == true)
  {
	  if(document.forms[0].sel_active.value == "S" ||document.forms[0].sel_active.value == "")
		{
			ShowAlert("111"," Active");
			return;
			}
	 if (document.forms[0].txtcat_name.value !="" && document.forms[0].selProd.selectedIndex != 0)
	 {
		 submitData();
	 }
	 else if (document.forms[0].selProd.selectedIndex == 0)
	 {
		ShowAlert("111","Category");
		document.forms[0].selProd.disabled = false;
		document.forms[0].selProd.focus();
	 }
	 else if (document.forms[0].txtcat_name.value =="")
	 {
		if (mode == "edit")
		{
			ShowAlert("111","Sub Category ");
		}
		else if (mode == "new")
		{
			ShowAlert("112","Sub Category");
			document.forms[0].txtcat_name.disabled = false;
			document.forms[0].txtcat_name.focus();
		}
	 }	
  }
}

function submitData()
{
	for (i=0;i<document.forms[0].elements.length;i++)
	{
		document.forms[0].elements[i].disabled = false;
	}
	document.forms[0].action=path+"controllerservlet";
	if (mode == "new")
	{
		document.forms[0].hidAction.value="INSERT";
		if (document.forms[0].rad[0].checked == true)
		{
			document.forms[0].hidcat_parent.value ="0";
		}
	}
	else if (mode == "edit")
	{
		document.forms[0].hidAction.value="UPDATE";
	}
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidRecordflag.value=varRecordFlag;
	document.forms[0].hidBeanId.value="productcat";
	document.forms[0].hidBeanMethod.value="updateData";
	document.forms[0].hidSourceUrl.value="/action/categorymaster.jsp";
	document.forms[0].submit();
}

function doEdit()
{
	mode ="edit";
	document.forms[0].txtcat_name.disabled = true;
	document.forms[0].cmdnew.disabled = true;
	document.forms[0].cmdsave.disabled = false;
	document.forms[0].cmdcancel.disabled = false;
	document.forms[0].cmddelete.disabled = false;
	document.forms[0].cmdedit.disabled = true;
	document.forms[0].cmdclose.disabled = true;
	document.forms[0].selProd.disabled = false;
	document.forms[0].rad[0].disabled = true;
	document.forms[0].rad[1].disabled = true;
	document.forms[0].sel_active.disabled = false;
}

function doDelete()
{
	if (document.forms[0].txtcat_name.value != "")
	{
		if (ConfirmMsg("101"))
		{
			for (i=0;i<document.forms[0].elements.length;i++)
			{
				document.forms[0].elements[i].disabled =false;
			}
			document.forms[0].hidAction.value="DELETE";
			document.forms[0].hidBeanId.value="productcat";
			document.forms[0].hidBeanMethod.value="updateData";
			document.forms[0].hidSourceUrl.value="/action/categorymaster.jsp";
			document.forms[0].action=path+"controllerservlet";
			document.forms[0].submit();			
		}
	}
	else
	{
		if(document.forms[0].rad[0].checked == true)
		{
			  ShowAlert("111","Category"); 	
  	    }
		else
		{
			  ShowAlert("111","Sub Category"); 	
		}    
	}
}

function doCancel()
{
   	if (ConfirmMsg("102"))
   	{
    	mode ="load";
		loadPage();
   	}
}


function catLabel()
{
	if(document.forms[0].rad[1].checked==true)
	{
		document.all.catlab.innerHTML="Sub Category";
	}
	else if(document.forms[0].rad[0].checked==true)
	{
		document.all.catlab.innerHTML="Category";
	}
}

function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=path+"action/setupnav.jsp";
		document.forms[0].submit();
	}	
}

function menuOptionDivMouseDown (url)
{
	if(!document.forms[0].cmdsave.disabled)
	{
		ShowAlert(103);
		return;
	}
	document.currentMenu.style.display='none';
	document.currentMBarOpt.style.border='1px solid lightgrey';
	document.menuIsActive = false;
	document.forms[0].action=url;
	document.forms[0].submit();			
}

function dohlp()     
{
  	var hlpvar = path+"phlp/setup_retailprod_categorymaster.htm";
  	var title = "CategoryMaster";
  	var prop = "scrollbars=yes,width=600,height=450";	
  	prop = prop + ",left=50,top=150";  	
  	window.open(hlpvar,title,prop);
}