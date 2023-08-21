function getValue()
{
   	var len = document.forms[0].selProd.length;
	var temp ="";
	for(i=0;i<len;i++)
	{
		 if(document.forms[0].selProd.options[i].selected==true)
		 {
				temp = document.forms[0].selProd.options[i].value; 
				break;
		 }
	}
	document.forms[0].hidcat_parent.value=temp.substring(0,temp.indexOf('-'));
    document.forms[0].txtcat_name.value="";
    document.forms[0].txt_code.value="";
    //document.forms[0].txt_schemecode.value="";
	if (mode =="edit")
	{
		document.forms[0].txtcat_name.disabled=true;
		document.forms[0].txt_code.disabled=true;
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
	document.forms[0].txt_code.disabled = false;
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
	document.forms[0].txt_code.disabled = false;
	document.forms[0].txt_seqorder.disabled = false;
	document.forms[0].seltype.disabled = false;
	//document.forms[0].txt_schemecode.disabled=false;
	//document.forms[0].selstatus.disabled=false;
	document.forms[0].facility1.disabled = false;
	document.forms[0].sel_facilityfor.disabled = false;
	document.forms[0].sel_active.disabled = false;
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
	//document.forms[0].cmdaudittrail.disabled = false;
	document.forms[0].cmdclose.disabled = false;
	document.forms[0].rad[0].disabled = false;
	document.forms[0].rad[1].disabled = false;
	document.forms[0].rad[0].checked = true;
	document.forms[0].txtcat_name.value="";
	document.forms[0].txt_code.value="";
	document.forms[0].txt_seqorder.value="";
	document.forms[0].seltype.value="";	
	document.forms[0].facility1.value="0";
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
				ShowAlert("111","Head of the Facility");
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
	var purl = path+"jsp/share/prodlist.jsp?hidMethod=getFacility&setid=setup&page=facility&cat="+val+"&select="+val2+"&beanid=facilitymaster&method=getData";
	var title = "Head_of_the_Facility";
	var prop = "scrollbars=no,width=450,height=350";	
	var xpos = (screen.width - 350) / 2;
	var ypos = (screen.height - 320) / 2;
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

function callFacilityNames()
{
	var par = document.forms[0].hidcat_parent.value;
	var ss=document.forms[0].hidcat_id.value;
	if(par!="" && ss!="")
	{
		var purl = path+"jsp/set/selectFacilityName.jsp?hidMethod=getFacility&page=facility&cat="+ss+"&select="+par+"&beanid=&method=";
		var title = "Head_of_the_Facility";
		var prop = "scrollbars=no,width=450,height=350";	
		var xpos = (screen.width - 350) / 2;
		var ypos = (screen.height - 320) / 2;
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
	else
	{
		alert("Please Select the Head facility and facility");
	}	
}

function showFields()
{
	if (document.forms[0].rad[0].checked == true)
	{
		document.forms[0].rad[0].value = "H";
	  	document.all.categ.style.visibility ="visible";   
		document.all.subcateg1.style.visibility="hidden";
		document.all.subcateg2.style.visibility="hidden";
		document.all.scheme1.style.visibility="hidden";
		document.all.scheme2.style.visibility="hidden";
		document.all.idfaccode1.style.visibility="hidden";
		document.all.idfaccode2.style.visibility="hidden";
		document.all.typelabel.style.visibility="visible";
		document.all.typecombo.style.visibility="visible";
		document.all.idfacstatus1.style.visibility="hidden";
		document.all.idfacstatus1.style.position="absolute";
		document.all.idfacstatus2.style.visibility="hidden";
		document.all.idfacstatus2.style.position="absolute";
		document.all.fac.style.visibility="visible";
		document.all.fac1.style.visibility="visible";
		document.all.facfor.style.visibility="hidden";
		document.all.facfor.style.position="absolute";
		catLabel();
	}
	else
	{
		document.forms[0].rad[1].value = "F";
		document.all.categ.style.visibility ="visible";   
		document.all.subcateg1.style.visibility="visible";
		document.all.subcateg2.style.visibility="visible";
		//document.all.scheme1.style.visibility="visible";
		//document.all.scheme2.style.visibility="visible";
		document.all.idfaccode1.style.visibility="visible";
		document.all.idfaccode2.style.visibility="visible";
		document.all.typelabel.style.visibility="hidden";
		document.all.typecombo.style.visibility="hidden";
		//document.all.idfacstatus1.style.visibility="visible";
		//document.all.idfacstatus2.style.visibility="visible";
		document.forms[0].seltype.selectedIndex=0;
		document.all.fac.style.visibility="hidden";
		document.all.fac1.style.visibility="hidden";
		catLabel();
		document.forms[0].selProd.selectedIndex =0;
		document.all.facfor.style.visibility="visible";
		document.all.facfor.style.position="relative";
		
	}
	document.forms[0].txtcat_name.value="";
	document.forms[0].txt_code.value="";
}

function doSave()
{
	assoc();
	if(document.forms[0].rad[0].checked == true)
  	{			
    	if (document.forms[0].txtcat_name.value =="")
	 	{
			if (mode == "edit")
			{
				ShowAlert("111","Head of the Facility");
			}
			else if (mode == "new")
			{
				ShowAlert("112","Head of the Facility");
				document.forms[0].txtcat_name.disabled = false;
				document.forms[0].txt_code.disabled = false;
				document.forms[0].txtcat_name.focus();
			}
	 	}
	 	else if(document.forms[0].seltype.value=="")
	 	{
	 		ShowAlert("111","Facility Type");
	 		document.forms[0].seltype.focus();
	 		return
	 	}
	 	else if(document.forms[0].rad[1].checked == true && document.forms[0].txt_code.value=="")
	 	{
	 		ShowAlert("121","Facility Code");
	 		document.forms[0].txt_code.focus();
	 		return;
	 	}
	 	else if(document.forms[0].sel_active.value == "S" ||document.forms[0].sel_active.value == "")
    	{
    		ShowAlert("111"," Active");
    		return false;
    		}
	 	else
	 	{
	 		submitData();
	 	}
  	}
  	else if(document.forms[0].rad[1].checked == true)
  	{
		if (document.forms[0].txtcat_name.value =="")
	 	{
			if (mode == "edit")
			{
				ShowAlert("111","Facility");
			}
			else if (mode == "new")
			{
				ShowAlert("112","Facility");
				document.forms[0].txtcat_name.disabled = false;
				document.forms[0].txt_code.disabled = false;
				document.forms[0].txtcat_name.focus();
				return false;
			}
	 	}
		else if (document.forms[0].selProd.selectedIndex == 0)
	 	{
			ShowAlert("111","Head of the Facility");
			document.forms[0].selProd.disabled = false;
			document.forms[0].selProd.focus();
	 	}
	 	/*else if(document.forms[0].txt_schemecode.value=="")
	 	{
	 		ShowAlert("121","Scheme Code");
	 		document.forms[0].txt_schemecode.focus();
	 	}*/
	 	else if(document.forms[0].txt_code.value=="")
	 	{
	 		ShowAlert("111","Code");
	 		document.forms[0].txt_code.focus();
	 	}
	 	else if(document.forms[0].sel_facilityfor.value=="s" || document.forms[0].sel_facilityfor.value=="")
		{
			ShowAlert("111","Facility For");
			document.forms[0].sel_facilityfor.focus();
			return false;			
		}
	 	/*else if(document.forms[0].selstatus.value=="")
	 	{
	 		ShowAlert("111","Facility Status");
	 		document.forms[0].selstatus.focus();
	 	}*/
	 	else if(document.forms[0].sel_active.value == "S" ||document.forms[0].sel_active.value == "")
		{
			ShowAlert("111"," Active");
			return false;
			}
		else if (document.forms[0].txtcat_name.value !="" && document.forms[0].selProd.selectedIndex != 0)
	 	{
			submitData();
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
	document.forms[0].hidBeanId.value="facilitymaster";
	document.forms[0].hidBeanMethod.value="updateData";
	document.forms[0].hidSourceUrl.value="/action/com_facilitymaster.jsp";
	document.forms[0].submit();
}

function doEdit()
{
	mode ="edit";
	document.forms[0].txtcat_name.disabled = true;
	document.forms[0].txt_code.disabled = true;
	document.forms[0].cmdnew.disabled = true;
	document.forms[0].cmdsave.disabled = false;
	document.forms[0].cmdcancel.disabled = false;
	document.forms[0].cmddelete.disabled = false;
	document.forms[0].cmdedit.disabled = true;
	document.forms[0].cmdclose.disabled = true;
	document.forms[0].selProd.disabled = false;
	//document.forms[0].selstatus.disabled=false;
	document.forms[0].txt_code.disabled=false;
	document.forms[0].rad[0].disabled = true;
	document.forms[0].rad[1].disabled = true;
	document.forms[0].seltype.disabled = true;
	document.forms[0].facility1.disabled = false;
	document.forms[0].sel_active.disabled = false;
	//document.forms[0].txt_schemecode.disabled = false; 
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
			document.forms[0].hidBeanId.value="facilitymaster";
			document.forms[0].hidBeanMethod.value="updateData";
			document.forms[0].hidSourceUrl.value="/action/com_facilitymaster.jsp";
			document.forms[0].action=path+"controllerservlet";
			document.forms[0].submit();
			
		}
	}
	else
	{
		if(document.forms[0].rad[0].checked == true)
		{
			  ShowAlert("111","Head of the Facility"); 	
  	    }
		else
		{
			  ShowAlert("111","Facility"); 	
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
		document.all.catlab.innerHTML="Facility";
	}
	else if(document.forms[0].rad[0].checked==true)
	{
		document.all.catlab.innerHTML="Head of the Facility";
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
