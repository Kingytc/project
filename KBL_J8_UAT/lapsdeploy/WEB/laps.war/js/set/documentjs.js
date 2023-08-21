/*

*	Function called in callCancel method to retrive the old values

*/



function helpCancel()

{

	document.forms[0].hidDocId.value=doc_num;

	document.forms[0].txtdoc_desc.value=doc_desc;           

	document.forms[0].chodoc_type.value=doc_type; 

	if(doc_type!="")

	{

		if(doc_type.toUpperCase()=="A")

		{

			document.forms[0].chodoc_type.options.selectedIndex=1;

		}

		else if(doc_type.toUpperCase()=="I")

		{

			document.forms[0].chodoc_type.options.selectedIndex=2;

		}

	}

	document.forms[0].txtdoc_subalternate[0].value=document.forms[0].hidalternate[0].value;

	document.forms[0].taadoc_subrule[0].value=getNewComment(document.forms[0].hidaltrules[0].value);

	document.forms[0].txtdoc_subalternate[1].value=document.forms[0].hidalternate[1].value;

	document.forms[0].taadoc_subrule[1].value=getNewComment(document.forms[0].hidaltrules[1].value);

	document.forms[0].txtdoc_subalternate[2].value=document.forms[0].hidalternate[2].value;

	document.forms[0].taadoc_subrule[2].value=getNewComment(document.forms[0].hidaltrules[2].value);

	document.forms[0].txtdoc_subalternate[3].value=document.forms[0].hidalternate[3].value;

	document.forms[0].taadoc_subrule[3].value=getNewComment(document.forms[0].hidaltrules[3].value);

	document.forms[0].txtdoc_subalternate[4].value=document.forms[0].hidalternate[4].value;

	document.forms[0].taadoc_subrule[4].value=getNewComment(document.forms[0].hidaltrules[4].value);
	document.forms[0].chodoc_type.disabled=true;
	document.forms[0].sec_code.disabled=true;
	document.forms[0].txtdoc_desc.readOnly=true;
	document.forms[0].taadoc_rulesp.readOnly=true;

}



/*

*	Function called to trap double quote

*/



function trapkeyPress()

{

	var varDoublekey=window.event.keyCode;

	if(varDoublekey==34)

	{

		window.event.returnValue=false;

	}

}



/*

*	Function called on load of the page

*/



function callSelect()

{	

	if(doc_type!="")

	{

		if(doc_type.toUpperCase()=="A")

		{

			document.forms[0].chodoc_type.options.selectedIndex=1;

		}

		else if(doc_type.toUpperCase()=="I")

		{

			document.forms[0].chodoc_type.options.selectedIndex=2;

		}

		document.forms[0].chodoc_type.disabled = true;

	}

	disableFields(true);

	disableControls(false,false,true,true,true,false);

	calldisablechk(true);

	if(doc_type == "")

	{

		document.forms[0].cmdedit.disabled = true;

	}	

	if(reqdcode=="Y")

	{

		document.forms[0].chkdoccode.checked=true;		

		document.forms[0].hid_doccode.value=reqdcode;

	}

	else

	{

		document.forms[0].chkdoccode.checked=false;	

		document.forms[0].hid_doccode.value="N";

	}

	

	if(reqddate=="Y")

	{

		document.forms[0].chkdocdate.checked=true;

		document.forms[0].hid_docdate.value=reqddate;

	}

	else 

	{

		document.forms[0].chkdocdate.checked=false;

		document.forms[0].hid_docdate.value="N";

	}

	if(reqdvalue=="Y")

	{

		document.forms[0].chkdocvalue.checked=true;

		document.forms[0].hid_docvalue.value=reqdvalue;

	}

	else

	{

		document.forms[0].chkdocvalue.checked=false;

		document.forms[0].hid_docvalue.value="N";

	}

	if(reqdmdate=="Y")

	{

		document.forms[0].chkmaturitydate.checked=true;

		document.forms[0].hid_docmaturitydate.value=reqdmdate;

	}

	else

	{

		document.forms[0].chkmaturitydate.checked=false;

		document.forms[0].hid_docmaturitydate.value="N";

	}

	if(docreqfl=="Y")

	{

		document.forms[0].chksocreq.checked=true;

		document.forms[0].hid_docrequired.value=docreqfl;

	}

	else

	{

		document.forms[0].chksocreq.checked=false;

		document.forms[0].hid_docrequired.value="N";

	}	

	if(docmanfl=="Y")

	{

		document.forms[0].chkmandatory.checked=true;

		document.forms[0].hid_docmandatory.value=docmanfl;

	}

	else

	{

		document.forms[0].chkmandatory.checked=false;

		document.forms[0].hid_docmandatory.value="N";

	}
	
    if(doc_scode != ''){
    	document.forms[0].sec_code.value=doc_scode;
    }else{
    	document.forms[0].sec_code.value='';
    }
    
    if(doc_primary != ''){
    	document.forms[0].txtdoc_docsp.value=doc_primary;
    }else{
    	document.forms[0].txtdoc_docsp.value='0';
    }
    
	document.forms[0].txtdoc_doccode.value=doc_codename;

	document.all.doc.style.visibility="hidden";

}



/*

*	Function called to validate null values in components 

*/



function checknull(strval1)

{

	var strval = strval1;

	var bool = false;

	while(bool == false)

    {

 		if(strval.substring(0,1) ==" ")

		{

			strval = strval.substring(1,strval.length);

		}

		else

		{

			bool =true;

		}

	}

	return strval;	  

}



/*

*	Function to get ? Help 

*/



function callDescHelp()

{	

	var varhelp=document.forms[0].hidHelpMode.value;

	if(varhelp=="")

	{

		var varUserFor=document.forms[0].chodoc_type.value;
        
		if(varUserFor.toUpperCase()=="I" || varUserFor.toUpperCase() =="A")

		{

			var varQryString = appurl+"action/tdocHelp.jsp?usedfor="+varUserFor;

			var title = "Documents";

			var prop = "scrollbars=no,width=700,height=450";	

			var xpos = 80;

			var ypos = 100;

			prop = prop + ",left="+xpos+",top="+ypos;

			window.open(varQryString,title,prop);

		}

		else

		{

			alert("Select Document Type");

		}

	}

}



/*

*	Format comment before insert

*/



function callFormatComment(comment)

{

	if(comment!="")

	{

		for(var i=0;i<comment.length;i++)

		{

			if (comment.charAt(i)=="\n")

			{

				comment = comment.substring(0,i-1) + "~" + comment.substring(i+1,comment.length);

			}

		}

	}

	if(comment.length>2000)

	{

		comment=comment.substring(0,2000);

	}

	return comment;

}



/*

* Function to perform Update Operation 

*/



function doSave()
{
	if(varEditFlag == "Y")
	{
		if((document.forms[0].hid_value.value!="")&&(document.forms[0].hid_oldvalue.value!=""))
		{
		var value1=document.forms[0].hid_value.value;
		var value2=document.forms[0].hid_oldvalue.value;
			if(value1!=value2)
			{
				alert("Document type cannot be changed");
				return false;
			}
		}
	}
	var vartxtdesc=document.forms[0].txtdoc_desc.value;

	var varchotype=document.forms[0].chodoc_type.value;

	var varseccode=document.forms[0].sec_code.value;

	var vardoccode=document.forms[0].txtdoc_doccode;

	var vartxtprimary1=checknull(document.forms[0].txtdoc_docsp.value);

	var vartxtalternate1=checknull(document.forms[0].txtdoc_subalternate[0].value);

	var vartxtalternate2=checknull(document.forms[0].txtdoc_subalternate[1].value);

	var vartxtalternate3=checknull(document.forms[0].txtdoc_subalternate[2].value);

	var vartxtalternate4=checknull(document.forms[0].txtdoc_subalternate[3].value);

	var vartxtalternate5=checknull(document.forms[0].txtdoc_subalternate[4].value);

		

	if(varchotype.toUpperCase()=="I" || varchotype.toUpperCase()=="A")

	{

		var varbool=checknull(vartxtdesc);

		if(varbool!="")

		{

			if((vartxtprimary1!=""))

			{

				if((vartxtalternate1!="") && (vartxtprimary1==""))

				{

					alert("Alternate document requires Primay Document");

					document.forms[0].txtdoc_docsp.focus();

				}

				else if((vartxtalternate2!="") && (vartxtprimary1==""))

				{

					alert("Alternate document requires Primay Document");

					document.forms[0].txtdoc_docsp.focus();

				}

				else if((vartxtalternate3!="") && (vartxtprimary1==""))

				{

					alert("Alternate document requires Primay Document");

					document.forms[0].txtdoc_docsp.focus();

				}

				else if((vartxtalternate4!="") && (vartxtprimary1==""))

				{

					alert("Alternate document requires Primay Document");

					document.forms[0].txtdoc_docsp.focus();

				}

				else if((vartxtalternate5!="") && (vartxtprimary1==""))

				{

					alert("Alternate document requires Primay Document");

					document.forms[0].txtdoc_docsp.focus();

				}

				else

				{					

					document.forms[0].taadoc_rulesp.value=callFormatComment(document.forms[0].taadoc_rulesp.value);

					document.forms[0].txtdoc_subalternate[0].value=callFormatComment(document.forms[0].txtdoc_subalternate[0].value);

					document.forms[0].txtdoc_subalternate[1].value=callFormatComment(document.forms[0].txtdoc_subalternate[1].value);

					document.forms[0].txtdoc_subalternate[2].value=callFormatComment(document.forms[0].txtdoc_subalternate[2].value);

					document.forms[0].txtdoc_subalternate[3].value=callFormatComment(document.forms[0].txtdoc_subalternate[3].value);

					document.forms[0].txtdoc_subalternate[4].value=callFormatComment(document.forms[0].txtdoc_subalternate[4].value);
					
				
					
					helpUpdate();

				}				

			}

			else

			{

				alert("Primary document is needed");

			}

		}

		else

		{

			alert("Enter Description");

			document.forms[0].txtdoc_desc.readOnly=false;

			document.forms[0].txtdoc_desc.focus();

		}

	}

	else

	{

		alert("Select either applicant or internal");
		document.forms[0].chodoc_type.focus();
		return;

	}	

	
}

function checkval()
{
		document.forms[0].hid_oldvalue.value=document.forms[0].chodoc_type.value;
}

/*

*	Function called from callUpdate

*/



function helpUpdate()
{
	for(i=0;i<document.forms[0].elements.length;i++)

	{

		document.forms[0].elements[i].disabled = false;

	}

		var varchodoc_type =  document.forms[0].chodoc_type.value;

		document.forms[0].chodoc_type.value = varchodoc_type;

		document.forms[0].hidBeanId.value="tdocdocuments";
		document.forms[0].hidRecordflag.value=varRecordFlag;
		//document.forms[0].hidBeanMethod.value="";
		document.forms[0].hidSourceUrl.value="action/documents.jsp";

		document.forms[0].action=appurl+"action/documents.jsp";	

		document.forms[0].submit();
}
/*

*	This method is fired when the edit button is pressed

*/



function doEdit()

{	
	varEditFlag = "Y";
	disableFields(false);

	calldisablechk(false);

	disableControls(true,true,false,false,false,true);

	document.forms[0].hidHelpMode.value="";

	document.forms[0].chodoc_type.disabled=false;

	document.forms[0].chodoc_type.readOnly=true;

	document.forms[0].txtdoc_desc.readOnly=false;

	document.forms[0].hidDocId.value=doc_num;

	document.forms[0].hidBeanGetMethod.value="updateData";
	document.forms[0].hidAction.value="update";
	document.forms[0].hid_value.value=document.forms[0].chodoc_type.value;

}



/*

*	Function Validate rules

*/



function callValidateRules(Obj1,Obj2)

{	

	var valObj1=checknull(Obj1.value);

	if(valObj1=="")

	{

		Obj1.focus();

		Obj2.value="";


		window.event.returnValue=false;

	}

}



/*

*	Function to perform Delete Operation

*/



function doDelete()

{
  document.forms[0].hid_value.value="";
  document.forms[0].hidAction.value="delete";
	var vartxtdesc=checknull(document.forms[0].txtdoc_desc.value);

	var varchotype=checknull(document.forms[0].chodoc_type.value);

	var vartxtprimary1=checknull(document.forms[0].txtdoc_docsp.value);

	var vartxtprimaryr1=checknull(document.forms[0].taadoc_rulesp.value);

	var vartxtalternate1=checknull(document.forms[0].txtdoc_subalternate[0].value);

	var vartxtalternate2=checknull(document.forms[0].txtdoc_subalternate[1].value);

	var vartxtalternate3=checknull(document.forms[0].txtdoc_subalternate[2].value);

	var vartxtalternate4=checknull(document.forms[0].txtdoc_subalternate[3].value);

	var vartxtalternate5=checknull(document.forms[0].txtdoc_subalternate[4].value);

	document.forms[0].hidHelpMode.value="";

		if(document.forms[0].txtdoc_desc.value=="")

				{

					alert('No value to delete');
					

				}		

	if(varchotype.toUpperCase()=="I" || varchotype.toUpperCase()=="A")

	{

		if(document.forms[0].chkParent.checked==true ||

			document.forms[0].chkChild[0].checked==true ||

			document.forms[0].chkChild[1].checked==true ||

			document.forms[0].chkChild[2].checked==true ||

			document.forms[0].chkChild[3].checked==true ||

			document.forms[0].chkChild[4].checked==true)

													

		{

		

		

			var varconfirm=confirm("You are about to Delete the Selected Document");

			

			if(varconfirm)

			{	

			

				calldisablechk(true);

				disableFields(false);

				

				if(document.forms[0].hiddocrow.value=="A")

				{	

				

					if((vartxtdesc=="") && (varchotype==""))

					{

					

						alert('No value to delete');
						

					}

					else

					{

						document.forms[0].chodoc_type.readOnly=false;

						//var con=confirm("You are about to delete the Primary And all Alternate");

						//if(con)

						{

							helpDelete();

						}

					}

				}

				else if(document.forms[0].hiddocsubrow1.value!="" ||

				document.forms[0].hiddocsubrow2.value!="" ||

				document.forms[0].hiddocsubrow3.value!="" ||

				document.forms[0].hiddocsubrow4.value!=""	||

				document.forms[0].hiddocsubrow5.value!="")

				{

					helpDelete();

				}

				/*if((vartxtalternate1!="") && document.forms[0].hiddocsubrow1.value=="A1")

				{

					document.forms[0].chodoc_type.readOnly=false;

					helpDelete();

				}else if((vartxtalternate2!="") && document.forms[0].hiddocsubrow1.value=="A2")

				{

					document.forms[0].chodoc_type.readOnly=false;

					helpDelete();

				}else if((vartxtalternate3!="") && document.forms[0].hiddocsubrow1.value=="A3")

				{

					document.forms[0].chodoc_type.readOnly=false;

					helpDelete();

				}else if((vartxtalternate4!="") && document.forms[0].hiddocsubrow1.value=="A4")

				{

					document.forms[0].chodoc_type.readOnly=false;

					helpDelete();

				}else if((vartxtalternate5!="") && document.forms[0].hiddocsubrow1.value=="A5")

				{

					document.forms[0].chodoc_type.readOnly=false;

					helpDelete();

				}							

				else

				{

					alert("No value to delete");

					callcheckenable(false);

					disableControls(false,false,true,true,true,false);

				}*/

				else

				{

					callcheckenable(false);

					disableControls(false,false,true,true,true,false);

				}

			}

			/*else

			{

				alert("else");

				callcheckenable(false);

				calldisablechk(true);			

			}*/

		}

		else

		{

			alert("Select Documents to Delete");

		}					

	}

}



/*

*	Function call check disable-enable

*/



function callcheckenable(one)

{

	document.forms[0].chkParent.checked=one;

	for(var i=0;i<5;i++)

	{

		document.forms[0].chkChild[i].checked=one;

	}	

}



/*

*	Function called form callDelete

*/



function helpDelete()

{

	document.forms[0].hidDocId.value=doc_num;

	document.forms[0].hidBeanGetMethod.value="deleteData";

	document.forms[0].hidBeanId.value="tdocdocuments";

	document.forms[0].hidSourceUrl.value="action/documents.jsp";

	document.forms[0].action=appurl+"action/documents.jsp";	
	
	document.forms[0].submit();

}



/*

*	Function called when parent checkbox is clicked

*/



function callParent()

{

	if(document.forms[0].chkParent.checked==true)

	{

		document.forms[0].hiddocrow.value="A";

		callChildCheck(false);		

	}

	else

	{

		document.forms[0].hiddocrow.value="";

		callChildCheck(false);

	}

}



/*

*	Function called when the first child checkbox is clicked

*/



function callChild(para1,para2,para3)

{

	if(document.forms[0].chkChild[para1].checked==true)

	{

		document.forms[0].elements["hiddocsubrow"+para2].value=para3;

	}

	else

	{

		document.forms[0].elements["hiddocsubrow"+para2].value="";

	}	

}



/*

*	Function called when to disable all fields except button

*/



function disableFields(one)

{

	for(var i=0;i<document.forms[0].elements.length;i++)

	{

		if(document.forms[0].elements[i].type!="button" && 

			document.forms[0].elements[i].type!="select-one")

		{

			document.forms[0].elements[i].readOnly=one;

		}

	}	

}



/*

*	Function called when cancel button is clicked

*/



function doCancel()

{

	var varconfirm=confirm("You are about to cancel the changes made to the document");
    document.forms[0].hid_value.value="";
  document.forms[0].hidAction.value="";
	if(varconfirm)

	{

		document.forms[0].chodoc_type.disabled = true;
      if(trimtxt(document.forms[0].txtdoc_desc.value)=="")
      {
      
		disableControls(false,true,true,true,true,false);
       }
       else{
       
       disableControls(false,true,true,true,true,false);
       }
       for(var i=0;i<5;i++)

	{

		document.forms[0].chkChild[i].value="";
		document.forms[0].txtdoc_subalternate[i].value="";
		document.forms[0].taadoc_subrule[i].value="";

	}
       document.forms[0].txtdoc_desc.value="";
         document.forms[0].txtdoc_docsp.value="";
		callcheckenable(false);

		calldisablechk(true);

		//disableFields(true);

		clearFields();

		//helpCancel();

		document.forms[0].hidHelpMode.value="";
		document.forms[0].chodoc_type.disabled=false;
		document.forms[0].sec_code.disabled=true;
		document.forms[0].txtdoc_desc.readOnly=true;
		document.forms[0].taadoc_rulesp.readOnly=true;

	}

}



/*

*	Function called when close button is fixed

*/



function doClose()

{ 	

	if(ConfirmMsg('100'))

	{	

		document.forms[0].action=appurl+"action/setupnav.jsp";

		document.forms[0].submit();

	}

}



/*

*	Function invoked to disable controls

*/



function disableControls(bolcreate,boledit,bolapply,boldel,bolcancel,bolclose)

{

	document.forms[0].cmdcreate.disabled=bolcreate;

	document.forms[0].cmdedit.disabled=boledit;

	document.forms[0].cmdsave.disabled=bolapply;

	document.forms[0].cmddelete.disabled=boldel;

	document.forms[0].cmdcancel.disabled=bolcancel;

	document.forms[0].cmdclose.disabled=bolclose;

	/*if(buttonname.toUpperCase()=="CREATEBTN")

	{

		document.forms[0].createbtn.disabled=true;

		document.forms[0].applybtn.disabled=false;

		document.forms[0].editbtn.disabled=true;

		document.forms[0].deletebtn.disabled=true;

		document.forms[0].cancelbtn.disabled=false;

		document.forms[0].closebtn.disabled=true;

	}else if(buttonname.toUpperCase()=="EDITBTN")

	{

		document.forms[0].createbtn.disabled=true;

		document.forms[0].applybtn.disabled=false;

		document.forms[0].editbtn.disabled=true;

		document.forms[0].deletebtn.disabled=false;

		document.forms[0].cancelbtn.disabled=false;

		document.forms[0].closebtn.disabled=true;

	}else if(buttonname.toUpperCase()=="APPLYBTN")

	{

		document.forms[0].createbtn.disabled=false;

		document.forms[0].applybtn.disabled=true;

		document.forms[0].editbtn.disabled=false;

		document.forms[0].deletebtn.disabled=true;

		document.forms[0].cancelbtn.disabled=false;

		document.forms[0].closebtn.disabled=false;

	}else if(buttonname.toUpperCase()=="CANCELBTN")

	{

		document.forms[0].createbtn.disabled=false;

		document.forms[0].applybtn.disabled=true;

		document.forms[0].editbtn.disabled=false;

		document.forms[0].deletebtn.disabled=true;

		document.forms[0].cancelbtn.disabled=true;

		document.forms[0].closebtn.disabled=false;

	}else if(buttonname.toUpperCase()=="ONLOADPAGE")

	{

		document.forms[0].createbtn.disabled=false;

		document.forms[0].applybtn.disabled=true;

		if(doc_type!="")

		{

			document.forms[0].editbtn.disabled=false;

		}else

		{

			document.forms[0].editbtn.disabled=true;

		}

		document.forms[0].deletebtn.disabled=true;

		document.forms[0].cancelbtn.disabled=true;

		document.forms[0].closebtn.disabled=false;

	}*/

}



/*

*	Function called to insert data into the page.

*/



function doCreate()

{
	disableFields(false);

	disableControls(true,true,false,true,false,true);

	clearFields();

	document.forms[0].txtdoc_desc.value="";

	document.forms[0].txtdoc_docsp.value="0";

	
     for(var i=0;i<5;i++)

	{

		document.forms[0].chkChild[i].value="";
		document.forms[0].txtdoc_subalternate[i].value="";
		document.forms[0].taadoc_subrule[i].value="";

	}    
	document.forms[0].taadoc_subrule.value="";
	document.forms[0].txtdoc_subalternate.value="";
 	document.forms[0].chodoc_type.disabled=false;

	document.forms[0].txtdoc_desc.readOnly=false;

	document.forms[0].hidHelpMode.value="H";

	document.forms[0].hidBeanGetMethod.value="insertData";

	document.forms[0].chodoc_type.focus();
	document.forms[0].hid_value.value="";
    document.forms[0].hidAction.value="";
}



/*

*	function to get help

*/



function callHelp()

{

	alert("No help avaliable");

}



/*

*	Function clearFields

*/



function clearFields()

{

	for(var i=0;i<document.forms[0].elements.length;i++)

	{

		if(document.forms[0].elements[i].type!="text" && document.forms[0].elements[i].type!="button")

		{

			document.forms[0].elements[i].value="";

		}	

		if(document.forms[0].elements[i].type=='select-one')

		{

			document.forms[0].elements[i].disabled="";

		}

		if(document.forms[0].elements[i].type=="textarea")

		{

			document.forms[0].elements[i].readOnly="";		  

		}			

	}

}



/*

*	Function to disable checkbox

*/



function calldisablechk(one)

{

	document.forms[0].chkParent.disabled=one;

	callChildCheck(one);

}



/*

*	Function call to disable all child checkboxes

*/

function callChildCheck(one)

{

	for(var i=0;i<5;i++)

	{

		document.forms[0].chkChild[i].disabled=one;

	}

}


