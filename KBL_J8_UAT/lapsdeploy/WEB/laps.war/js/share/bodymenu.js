/*******************	Beginnging Comments    *******************/   
/*
*		Program Name		 :   bodymenu.js
* 
*		Date created		 :   
*		
*		Date completed		 :   
*
*		Programmer Name		 :  Nalini Kanth P.D.V
*/
/*******************	Modification History    *******************/
/*
*		Modification Date	 :	  
*
*		Modified by			 :    
*
*		Modification Made	 :    
*/  
/*function chkmenu(x)
{
alert(x);
if(x==0)
{
return false;
}*/
//if(document.all.menulyr.style.visibility=="visible")
//{
oFoldMenu=new foldoutMenuObj('oFoldMenu')

oFoldMenu.substay=false //Should the sub menus stay folded?  
oFoldMenu.sub2stay=false //Should the sub2 menus stay folded?
oFoldMenu.sub3stay=false //Should the sub3 menus stay folded? 
oFoldMenu.sub4stay=false //Should the sub4 menus stay folded?
oFoldMenu.sub5stay=false //Should the sub5 menus stay folded?  
oFoldMenu.sub6stay=false //Should the sub6 menus stay folded?  

oFoldMenu.menubetween=18//The pixel value between the foldoutmenus


oFoldMenu.left=10 //The left position of the menu 
oFoldMenu.top=35//The top position of the menu 
oFoldMenu.width=160 //The width of the menu
oFoldMenu.maxheight=420 //The maxheight of the menu, be sure to set this one high enough

//Setting styles
oFoldMenu.clFold="" //Regular styles for the topDivs
oFoldMenu.clSub="left:6" //Styles for the subDivs
oFoldMenu.clSub2="left:20" //Styles for the sub2Divs
oFoldMenu.clSub3="left:30" //Styles for the sub3Divs
oFoldMenu.clSub4="left:40" //Styles for the sub4Divs
oFoldMenu.clSub5="left:60" //Styles for the sub5Divs

oFoldMenu.clCont="position:absolute;" //The cont layer, set position to relative if you want to try and have it inside a layer or whatever
oFoldMenu.clFoldLinks="font-family:Verdana,Arial, Helvetica,Sans-serif; font-size:10px;  text-decoration:none;  font-weight:bold;color:#DEDACF" //#FFBA16 The style for the toplinks
oFoldMenu.clSubLinks="font-family:Verdana,Arial, Helvetica,Sans-serif; font-size:10px;  text-decoration:none;  font-weight:bold;color:#E4E2ED" //The style for the sublinks
oFoldMenu.clSub2Links="font-family:Verdana,Arial, Helvetica,Sans-serif; font-size:10px; text-decoration:none; color:#E4E2ED" //The style for the sub2links
oFoldMenu.clSub3Links="font-family:Verdana,Arial, Helvetica,Sans-serif; font-size:10px; text-decoration:none; color:#E4E2ED" //The style for the sub3links
oFoldMenu.clSub4Links="font-family:Verdana,Arial, Helvetica,Sans-serif; font-size:10px; text-decoration:none; color:#E4E2ED" //The style for the sub4links
oFoldMenu.clSub5Links="font-family:Verdana,Arial, Helvetica,Sans-serif; font-size:10px; text-decoration:none; color:#E4E2ED" //The style for the sub5links

//Do not change this line!
oFoldMenu.makeStyle()

//MAIN 1
//if(x==1)
//{
	oFoldMenu.make('top','&nbsp;Setup',0,0,'../img/img_off.gif','../img/img_on.gif')
	oFoldMenu.make('sub','&nbsp;Organization','javascript:orgnlink()',0,'../img/img_offold.gif')
	oFoldMenu.make('sub','&nbsp;Groups','javascript:groupslink()',0,'../img/img_offold.gif')
	oFoldMenu.make('sub','&nbsp;Users','javascript:userslink()',0,'../img/img_offold.gif')
	oFoldMenu.make('sub','&nbsp;Interest Index','javascript:interestlink()',0,'../img/img_offold.gif')
	oFoldMenu.make('sub','&nbsp;Documents','javascript:documentslink()',0,'../img/img_offold.gif')
	oFoldMenu.make('sub','&nbsp;Products','javascript:productslink()',0,'../img/img_offold.gif')
	oFoldMenu.make('sub','&nbsp;Reports','javascript:setupreports()',0,'../img/img_offold.gif')
	//}	
//MAIN 2
oFoldMenu.make('top','&nbsp;Risk Management',0,0,'../img/img_off.gif','../img/img_on.gif')
	oFoldMenu.make('sub','&nbsp;Personal','javascript:personallink()',0,'../img/img_offold.gif')
	oFoldMenu.make('sub','&nbsp;Commercial','javascript:commerciallink()',0,'../img/img_offold.gif')
			
//MAIN 3
oFoldMenu.make('top','&nbsp;Application Forms',0,0,'../img/img_off.gif','../img/img_on.gif')
			oFoldMenu.make('sub','&nbsp;Personal',0,0,'../img/img_offold.gif')
			oFoldMenu.make('sub2','&nbsp;&nbsp;New','javascript:pnewlink()',0,'../img/img_offold.gif')
			oFoldMenu.make('sub2','&nbsp;&nbsp;Existing','javascript:pextlink()',0,'../img/img_offold.gif')
			oFoldMenu.make('sub2','&nbsp;&nbsp;Auditor Report','javascript:padlink()',0,'../img/img_offold.gif')
			oFoldMenu.make('sub2','&nbsp;&nbsp;Renewal','javascript:prenewallink()',0,'../img/img_offold.gif')
			oFoldMenu.make('sub2','&nbsp;&nbsp;Reports','javascript:preportslink()',0,'../img/img_offold.gif')
	oFoldMenu.make('sub','&nbsp;Commercial',0,0,'../img/img_offold.gif')
			oFoldMenu.make('sub2','&nbsp;&nbsp;New','javascript:cnewlink()',0,'../img/img_offold.gif')
			oFoldMenu.make('sub2','&nbsp;&nbsp;Existing','javascript:cextlink()',0,'../img/img_offold.gif')
			oFoldMenu.make('sub2','&nbsp;&nbsp;Auditor Report','javascript:cadlink()',0,'../img/img_offold.gif')
			oFoldMenu.make('sub2','&nbsp;&nbsp;Renewal','javascript:crenewallink()',0,'../img/img_offold.gif')
			oFoldMenu.make('sub2','&nbsp;&nbsp;Control','javascript:controllink()',0,'../img/img_offold.gif')
			oFoldMenu.make('sub2','&nbsp;&nbsp;Reports','javascript:creportslink()',0,'../img/img_offold.gif')


//MAIN 4

oFoldMenu.make('top','&nbsp;Loan Service',0,0,'../img/img_off.gif','../img/img_on.gif')
	oFoldMenu.make('sub','&nbsp;Payment Options','javascript:poptionlink()',0,'../img/img_offold.gif')
	oFoldMenu.make('sub','&nbsp;Repayments','javascript:repmtslink()',0,'../img/img_offold.gif')
	oFoldMenu.make('sub','&nbsp;Pay Quick','javascript:pquicklink()',0,'../img/img_offold.gif')
   	oFoldMenu.make('sub','&nbsp;Cancel Quick','javascript:cquicklink()',0,'../img/img_offold.gif')
    oFoldMenu.make('sub','&nbsp;Reports','javascript:loanreportslink()',0,'../img/img_offold.gif')
	oFoldMenu.make('sub','&nbsp;Letters','javascript:letterslink()',0,'../img/img_offold.gif')

oFoldMenu.make('top','&nbsp;Graphical Reports',0,0,'../img/img_off.gif','../img/img_on.gif')
	oFoldMenu.make('sub','&nbsp;Application Status','javascript:apstatuslink()',0,'../img/img_offold.gif')
	oFoldMenu.make('sub','&nbsp;Product Popularity','javascript:prdpoplink()',0,'../img/img_offold.gif')
	oFoldMenu.make('sub','&nbsp;Delinquency','javascript:delqlink()',0,'../img/img_offold.gif')


oFoldMenu.construct()

//}
