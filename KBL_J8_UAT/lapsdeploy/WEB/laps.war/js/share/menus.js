
	<!-- Begin hiding from older browsers
	var menVar;
	isMac = (navigator.appVersion.indexOf("Macintosh") != -1);
	
	menuEventList = new Array(1);
	menuEventList[0] = 0;
	
	uniqueEventIdentifier = 1;
	
	function menuEvent (secs, exeStatement) {
	menVar="x";
		cancelMenuEvent ();
		
		this.time = secs;
		this.exeStatement = exeStatement;
		this.identifier = uniqueEventIdentifier++;
		
		menuEventList[0] = this;
		
		window.setTimeout ( "executemenuEvent(" + menuEventList[0].identifier + ");", secs*1000 );  					
		}
	function executemenuEvent (eventIdentifier) {
		if ( typeof ( menuEventList[0] ) == "object" )
			if ( typeof ( menuEventList[0].exeStatement ) == "string" )
				if ( menuEventList[0].identifier == eventIdentifier ) {
					eval ( menuEventList[0].exeStatement );
					menuEventList[0] = void 0;
					}
		}
	function cancelMenuEvent () {
		menuEventList[0] = void 0;
		}
	
	function menuBarMouseOut () {
		if (isMac) {
			tempEvent = new menuEvent (3, 'if (document.menuIsActive) { document.currentMenu.style.display=\'none\'; document.currentMBarOpt.style.border=\'1px solid #DEDACF\'; document.currentMBarOpt.style.backgroundColor=\'#DEDACF\'; document.currentMBarOpt.style.color=\'black\'; document.menuIsActive=false; }')
			}
		}
	function menuBarBlur () {
			if(menVar=="x")
			{
				document.currentMenu.style.display='none';
				document.currentMBarOpt.style.border='1px solid #DEDACF';
				document.menuIsActive = false;
			}
	}
	
	function menuBarOptionMouseOver (menuBarOptionId, menuId) {
	menVar="x";
		if (document.menuIsActive) {
			document.currentMenu.style.display = 'none';
			document.currentMBarOpt.style.border='1px solid #DEDACF';
			document.currentMBarOpt.style.backgroundColor='#DEDACF';
			document.currentMBarOpt.style.color='black';
			}
		if (isMac) {
			menuId.style.top=16;
			if (document.menuIsActive) {
				menuBarOptionId.style.border='1px solid darkblue';
				menuBarOptionId.style.backgroundColor='darkblue';
				menuBarOptionId.style.color='white';
				menuId.style.display = 'block';
				}
			}
		else {
			if (document.menuIsActive) {
				menuBarOptionId.style.border='1px buttonface inset';
				menuId.style.display = 'block';
				}
			else {
				if (typeof (document.currentMBarOpt) == 'object') {
					document.currentMBarOpt.style.border='1px solid #DEDACF';
					}
				menuBarOptionId.style.border='1px buttonface outset';
				}
			}
		menuBarOptionId.style.cursor='default';
		document.currentMenu=menuId;
		document.currentMBarOpt=menuBarOptionId;
		}
	function menuBarOptionMouseOut (menuBarOptionId) {
	menVar="x";
		if (!document.menuIsActive) {
			menuBarOptionId.style.border='1px solid #DEDACF';
			}
		}
	function menuBarOptionMouseDown (menuBarOptionId, menuId) {
	menVar="x";
		menubar.focus ();
		if (isMac) {
			menuBarOptionId.style.border='1px solid darkblue';
			menuBarOptionId.style.backgroundColor='darkblue';
			menuBarOptionId.style.color='white';
			}
		else {
			menuBarOptionId.style.border='1px buttonface inset';
			}
		menuId.style.display = 'block';
		document.menuIsActive=true;
		}
	
	function menuClick () {
	menVar="x";
		if (isMac) {
			document.currentMenu.style.display='none';
			document.currentMBarOpt.style.border='1px solid #DEDACF';
			document.currentMBarOpt.style.backgroundColor='#DEDACF';
			document.currentMBarOpt.style.color='black';
			}
		}
	
	function menuOptionCellMouseOver (cell) {
		cell.style.cursor='default';
		cell.style.color='white';
		cell.style.backgroundColor='darkblue';
		}
	function menuOptionCellMouseOut (cell) {
		cell.style.backgroundColor='#DEDACF';
		cell.style.color='black';
		}
	
	
	
	//End hiding-->
