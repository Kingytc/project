ALTER TABLE APPINWARDREG
ADD (INWARD_PASSPORTNUMBER	VARCHAR2(20 BYTE),
INWARD_VOTERID	VARCHAR2(15 BYTE),
INWARD_ENQUIRYPURPOSE	VARCHAR2(50 BYTE),
INWARD_GENDER	VARCHAR2(5 BYTE),
INWARD_CIBILREPORT	VARCHAR2(5 BYTE));


ALTER TABLE MST_CIBILPRODUCTS MODIFY MC_ACCTYPE VARCHAR2(300);

ALTER TABLE MON_INSURANCECOVERED
ADD MON_INSMMRNO VARCHAR2(21);

ALTER TABLE MON_AUDITCOMMENTS MODIFY MON_YEAR NULL;
ALTER TABLE MON_AUDITCOMMENTS MODIFY MON_MONTH NULL;



<!---asha--->
ALTER TABLE LOANDETAILS
ADD loan_intcalcmode VARCHAR2(2);


<!-- Scripts For Audit Trial Bala-->
update PAGE_MASTER set PAGE_SHORTCODE = 'landhold',PAGE_TYPE = 'D',PAGE_AUDITREQ = 'Y' where PAGE_DESC = 'agrlandholdings.jsp'

update PAGE_MASTER set PAGE_SHORTCODE = 'legalop',PAGE_TYPE = 'D',PAGE_AUDITREQ = 'Y' where PAGE_DESC = 'agr_legal_opinion.jsp'

update PAGE_MASTER set PAGE_SHORTCODE = 'poubrfin',PAGE_TYPE = 'N',PAGE_AUDITREQ = 'Y' where PAGE_DESC = 'agr_poultry_broilerfin.jsp'

update PAGE_MASTER set PAGE_SHORTCODE = 'poubroil',PAGE_TYPE = 'N',PAGE_AUDITREQ = 'Y' where PAGE_DESC = 'agr_poultry_broilertech.jsp'

update PAGE_MASTER set PAGE_SHORTCODE = 'pounonre',PAGE_TYPE = 'N',PAGE_AUDITREQ = 'Y' where PAGE_DESC = 'agr_poultry_broinonrec.jsp'

ALTER TABLE AGR_POULTRY_BROINONREC ADD POULTRY_SNO CHAR(2);

ALTER TABLE AGR_POULTRY_NON_RECURRING ADD POULTRY_SNO CHAR(2);

update PAGE_MASTER set PAGE_SHORTCODE = 'broirec',PAGE_TYPE = 'N',PAGE_AUDITREQ = 'Y' where PAGE_DESC = 'agr_poultry_broirec.jsp'

update PAGE_MASTER set PAGE_SHORTCODE = 'broflock',PAGE_TYPE = 'N',PAGE_AUDITREQ = 'Y' where PAGE_DESC = 'agr_poultry_broiflockrep.jsp'

update page_master set page_shortcode='abuldata' ,page_type='N' ,page_auditreq='Y' where page_desc='agr_bullockdata.jsp'

update page_master set page_shortcode='abulfin' ,page_type='N' ,page_auditreq='Y' where page_desc='agr_bullockfinancialdata.jsp'

<!-- After Ist Patch Sent -->

update PAGE_MASTER set PAGE_SHORTCODE = 'livestok',PAGE_TYPE = 'N',PAGE_AUDITREQ = 'Y' where PAGE_DESC = 'livestockdetails.jsp'

update PAGE_MASTER set PAGE_SHORTCODE = 'econdata',PAGE_TYPE = 'N',PAGE_AUDITREQ = 'Y' where PAGE_DESC = 'agr_economicdata.jsp'

update PAGE_MASTER set PAGE_SHORTCODE = 'diaryfin',PAGE_TYPE = 'N',PAGE_AUDITREQ = 'Y' where PAGE_DESC = 'agr_diaryfindata.jsp'

update PAGE_MASTER set PAGE_SHORTCODE = 'agrldcow',PAGE_TYPE = 'N',PAGE_AUDITREQ = 'Y' where PAGE_DESC = 'agr_LDCows.jsp'

update PAGE_MASTER set PAGE_SHORTCODE = 'agrcasfl',PAGE_TYPE = 'N',PAGE_AUDITREQ = 'Y' where PAGE_DESC = 'agr_cashflow.jsp'

update PAGE_MASTER set PAGE_SHORTCODE = 'agrlndet',PAGE_TYPE = 'N',PAGE_AUDITREQ = 'Y' where PAGE_DESC = 'loandetailsagr.jsp'

update PAGE_MASTER set PAGE_SHORTCODE = 'shptchdt',PAGE_TYPE = 'N',PAGE_AUDITREQ = 'Y' where PAGE_DESC = 'agr_sheep_techdata.jsp'

update PAGE_MASTER set PAGE_SHORTCODE = 'sheepeco',PAGE_TYPE = 'N',PAGE_AUDITREQ = 'Y' where PAGE_DESC = 'agr_sheep_ecodata.jsp'

update PAGE_MASTER set PAGE_SHORTCODE = 'flockrep',PAGE_TYPE = 'N',PAGE_AUDITREQ = 'Y' where PAGE_DESC = 'agr_sheep_flockrep.jsp'

update PAGE_MASTER set PAGE_SHORTCODE = 'sheeplrq',PAGE_TYPE = 'N',PAGE_AUDITREQ = 'Y' where PAGE_DESC = 'agr_sheep_loanreq.jsp'

update PAGE_MASTER set PAGE_SHORTCODE = 'sheepexp',PAGE_TYPE = 'N',PAGE_AUDITREQ = 'Y' where PAGE_DESC = 'agr_sheep_expenses.jsp'

update PAGE_MASTER set PAGE_SHORTCODE = 'goldloan',PAGE_TYPE = 'N',PAGE_AUDITREQ = 'Y' where PAGE_DESC = 'agr_goldloan.jsp'

update PAGE_MASTER set PAGE_SHORTCODE = 'seritech',PAGE_TYPE = 'N',PAGE_AUDITREQ = 'Y' where PAGE_DESC = 'agr_seri_techdata.jsp'

update PAGE_MASTER set PAGE_SHORTCODE = 'consloan',PAGE_TYPE = 'N',PAGE_AUDITREQ = 'Y' where PAGE_DESC = 'ConsumptionLoans.jsp'

update PAGE_MASTER set PAGE_SHORTCODE = 'agriseri',PAGE_TYPE = 'N',PAGE_AUDITREQ = 'Y' where PAGE_DESC = 'agr_seri_loanreq.jsp'

update PAGE_MASTER set PAGE_SHORTCODE = 'seriecon',PAGE_TYPE = 'N',PAGE_AUDITREQ = 'Y' where PAGE_DESC = 'agr_seri_economics.jsp'

update PAGE_MASTER set PAGE_SHORTCODE = 'fishpart',PAGE_TYPE = 'N',PAGE_AUDITREQ = 'Y' where PAGE_DESC = 'agr_common_loanrequirements.jsp'

update PAGE_MASTER set PAGE_SHORTCODE = 'machboat',PAGE_TYPE = 'N',PAGE_AUDITREQ = 'Y' where PAGE_DESC = 'agrMachBoatOPExpenses.jsp'

update PAGE_MASTER set PAGE_SHORTCODE = 'boatsurp',PAGE_TYPE = 'N',PAGE_AUDITREQ = 'Y' where PAGE_DESC = 'agrMachBoatSurplus.jsp'

update PAGE_MASTER set PAGE_SHORTCODE = 'techaspe',PAGE_TYPE = 'N',PAGE_AUDITREQ = 'Y' where PAGE_DESC = 'agr_poultry_techaspect.jsp'

update PAGE_MASTER set PAGE_SHORTCODE = 'poullayr',PAGE_TYPE = 'N',PAGE_AUDITREQ = 'Y' where PAGE_DESC = 'agr_poultry_findata.jsp'

update PAGE_MASTER set PAGE_SHORTCODE = 'playnore',PAGE_TYPE = 'N',PAGE_AUDITREQ = 'Y' where PAGE_DESC = 'agr_poultrynonrecurringexp.jsp'

update PAGE_MASTER set PAGE_SHORTCODE = 'playrecr',PAGE_TYPE = 'N',PAGE_AUDITREQ = 'Y' where PAGE_DESC = 'agr_poultryrecurringexp.jsp'

update PAGE_MASTER set PAGE_SHORTCODE = 'layerflk',PAGE_TYPE = 'N',PAGE_AUDITREQ = 'Y' where PAGE_DESC = 'agr_layerflockrep.jsp'

update PAGE_MASTER set PAGE_SHORTCODE = 'foddstok',PAGE_TYPE = 'N',PAGE_AUDITREQ = 'Y' where PAGE_DESC = 'agr_fodder_livestock.jsp'

<!-- Modified Get Method Name-->

update USR_AGRSCREENS set SCREEN_JSP_PAGE = 'agr_UBC_eligibility.jsp?hidBeanId=agreligibility&hidBeanMethod=&hidBeanGetMethod=getUGCC_Eligibility'
where SCREEN_GRP = 'aW' and SCREEN_ID = '290'

<!-- Scripts For Audit Trial Zahoor-->

update PAGE_MASTER set page_auditreq = 'Y',  page_shortcode = 'croptech', page_type = 'N'
where page_id = '219';

update PAGE_MASTER set page_auditreq = 'Y',  page_shortcode = 'cropprop', page_type = 'D'
where page_id = '220';

update PAGE_MASTER set page_auditreq = 'Y',  page_shortcode = 'cropwc', page_type = 'N'
where page_id = '221';

update PAGE_MASTER set page_auditreq = 'Y',  page_shortcode = 'cropterm', page_type = 'N'
where page_id = '222';

alter table agr_termloans modify SLNO varchar2(10);

insert into PAGE_MASTER values ('404','agriEMICalculation.jsp','3','Retail & Agriculture'
,'Retail & Agriculture  -> Application -> Appraisal ->  Eligibility','cropelig','N','Y');

update PAGE_MASTER set page_auditreq = 'Y',  page_shortcode = 'farmpart', page_type = 'N'
where page_id = '224';

update PAGE_MASTER set page_auditreq = 'Y',  page_shortcode = 'farmmech', page_type = 'N'
where page_id = '225';

update PAGE_MASTER set page_auditreq = 'Y',  page_shortcode = 'plntech1', page_type = 'N'
where page_id = '268';

update PAGE_MASTER set page_auditreq = 'Y',  page_shortcode = 'plntech2', page_type = 'N'
where page_id = '269';

update PAGE_MASTER set page_auditreq = 'Y',  page_shortcode = 'plnexpen', page_type = 'N'
where page_id = '270';

update PAGE_MASTER set page_auditreq = 'Y',  page_shortcode = 'plnincom', page_type = 'N'
where page_id = '271';

update PAGE_MASTER set page_auditreq = 'Y',  page_shortcode = 'plancash', page_type = 'N'
where page_id = '272';

insert into PAGE_MASTER values ('405','agr_comm_tech_asp.jsp','3','Retail & Agriculture'
,'Retail & Agriculture  -> Application -> Appraisal ->  Technical Details','commtech','N','Y');

update PAGE_MASTER set page_auditreq = 'Y',  page_shortcode = 'commexp', page_type = 'D'
where page_id = '264';

update PAGE_MASTER set page_auditreq = 'Y',  page_shortcode = 'comminc', page_type = 'D'
where page_id = '263';


<!-- Scripts For Audit Trial Gayu-->

update PAGE_MASTER set page_shortcode='gobrtec' where page_id ='275'

update PAGE_MASTER set page_shortcode='aminirr'  where page_id='226'

update PAGE_MASTER set page_shortcode='farmpart'  where page_id='227'

update PAGE_MASTER set page_shortcode='agrugcc'  where page_id='276'

<!-- Added By Zahoorunnisa.s as on 12th March 2012 -->

set define off;
update page_master set module_name = 'Corporate & SME'
,page_name = 'Corporate & SME -> Customer Profile -> Company Details'
where page_shortcode='comcuspf';

set define off;
update page_master set module_name = 'Setup',
page_name = 'Setup -> NPA -> Delegated Powers'
where page_shortcode='setnpapw';

update page_master set  page_shortcode='pertdemo' where page_id = '401';

set define off;
update page_master set 
page_name = 'Home -> Retail -> Customer Profile -> KYCNorms'
where page_shortcode='comcskyc';

update page_master set page_type = 'N' , page_auditreq = 'Y' where page_id= '86';

update page_master set page_type = 'N' , page_auditreq = 'Y' where page_id= '41';

update page_master set
page_name = 'Home -> Retail -> Application -> Loan Particulars -> Proposed/Offered Asset -> House'
where page_shortcode='perprope';

update page_master set
page_name = 'Home -> Retail -> Application -> Loan Particulars -> Proposed/Offered Asset -> Vehicle'
where page_shortcode='pervehi';

update page_master set
page_name = 'Home -> Retail -> Applicant - > Proposed Asset - >Other Asset'
where page_shortcode='otherast';

update page_master set
page_name = 'Home -> Retail -> Application -> Loan Particulars -> Proposed/Offered Asset -> Verification Details'
where page_shortcode='perverfi';

update page_master set
page_name = 'Home -> Retail -> Credit Information -> Bank Deposits/ NSC/ KVP'
where page_shortcode='perbnkac';

update page_master set
page_name = 'Home -> Retail -> Credit Information -> Insurance Policies'
where page_shortcode='perinsur';

  alter table npa_ageofnpa modify npa_minofage number(7,2);
  alter table npa_ageofnpa modify npa_maxage number(7,2);
  alter table npa_ageofnpa modify npa_point number(7,2);
  alter table organisations modify org_branchtype varchar2(5);
       
     update page_master set page_shortcode = 'setwrkfl' , page_type ='D' , page_auditreq = 'Y' , page_name ='Home -> Setup -> CorporateProducts -> Flowpoints'
     where page_id='106';
     
     update page_master set page_shortcode = 'setwrkfl' , page_type ='D' , page_auditreq = 'Y' , page_name ='Home -> Setup -> CorporateProducts -> Flowpoints'
     where page_id='126' ;
      
     update page_master set page_shortcode = 'setwrkfl' , page_type ='D' , page_auditreq = 'Y' , page_name ='Home -> Setup -> CorporateProducts -> Flowpoints'
     where page_id='127' ;
     
      update page_master set page_shortcode = 'setwrkfl' , page_type ='D' , page_auditreq = 'Y' , page_name ='Home -> Setup -> Tertiary Products -> Flowpoints'
     where page_id='129' ;
     
      update page_master set page_shortcode = 'setwrkfl' , page_type ='D' , page_auditreq = 'Y' , page_name ='Home -> Setup -> Tertiary Products -> Flowpoints'
     where page_id='130' ;
     
  alter table agr_cropdetails modify crop_gross_income number(25,2);
  alter table agr_cropdetails modify crop_net_income number(25,2);
  alter table agr_sheep_ecodata modify SHEEP_FEEDADULT1 number(15,2);
  alter table agr_sheep_ecodata modify SHEEP_FEEDLAMP1 number(15,2);
  alter table agr_sheep_loanamountdata modify  SHEEP_TOTALAMOUNT varchar2(35);
  alter table agr_sheep_loanamountdata modify  SHEEP_MARGINPER varchar2(35);
  alter table agr_sheep_loanamountdata modify  SHEEP_MARGIN varchar2(35);
  alter table agr_sheep_loanamountdata modify  SHEEP_SUBSIDYPER varchar2(35);
  alter table agr_sheep_loanamountdata modify  SHEEP_SUBSIDY varchar2(35);
  alter table agr_sheep_loanamountdata modify  SHEEP_TOTALLOANAMOUNT number(35,2);
  alter table agr_sheep_loanamountdata modify  SHEEP_VALUE1 varchar2(35);
  alter table agr_sheep_loanamountdata modify  SHEEP_VALUE2 varchar2(35);
  alter table agr_sheep_loanamountdata modify  SHEEP_VALUE3 varchar2(35);
  
  alter table agr_sheep_loanreqdata modify  SHEEP_UNITS varchar2(35);
  alter table agr_sheep_loanreqdata modify  SHEEP_COST varchar2(35);
  alter table agr_sheep_loanreqdata modify  SHEEP_AMOUNT varchar2(35);
  alter table agr_sheep_loanreqdata modify  SHEEP_TOTAMOUNT number(35,2);
  
    alter table agr_poultry_expenses modify POULTRY_IYEAR varchar2(15);
    alter table agr_poultry_expenses modify POULTRY_IIYEAR varchar2(15);
    alter table agr_poultry_expenses modify POULTRY_IIIYEAR varchar2(15);
  
<!--End-->

<!-- Added by Subha for Farm Mech. Cropping pattern screen on 27-03-2012 -->

alter table AGR_CROPPINGPATTERN modify(CROP_GROSSINCOMEE VARCHAR2(22 BYTE));
alter table AGR_CROPPINGPATTERN modify(CROP_GROSSINCOMEP VARCHAR2(22 BYTE));
alter table AGR_CROPPINGPATTERN modify(CROP_NETINCOMEE VARCHAR2(22 BYTE));
alter table AGR_CROPPINGPATTERN modify(CROP_NETINCOMEP VARCHAR2(22 BYTE));

alter table AGR_CROPPINGPATTERNDATA modify(TOTNETINCOMEE VARCHAR2(22 BYTE));
alter table AGR_CROPPINGPATTERNDATA modify(TOTNETINCOMEP VARCHAR2(22 BYTE));
alter table AGR_CROPPINGPATTERNDATA modify(TOTNETINCOMEP VARCHAR2(22 BYTE));

<!-- End -->

<!-- Added By Bala-->
ALTER TABLE AGR_POULTRY_BROINONREC ADD POULTRY_SNO CHAR(2);

ALTER TABLE AGR_POULTRY_NON_RECURRING ADD POULTRY_SNO CHAR(2);

<!-- End -->

<!--- Added By Zahoorunnisa.S -->
     alter table agr_poultry_expenditure modify TOTIYEAREXPENSES varchar2(35);
     alter table agr_poultry_expenditure modify TOTIIYEAREXPENSES varchar2(35);
     alter table agr_poultry_expenditure modify TOTIIIYEAREXPENSES varchar2(35);
     alter table agr_poultry_expenditure modify TOTIVYEAREXPENSES varchar2(35);
     alter table agr_poultry_expenditure modify TOTVYEAREXPENSES varchar2(35);
     alter table agr_poultry_expenditure modify TOTVIYEAREXPENSES varchar2(35);
     alter table agr_poultry_expenditure modify TOTVIIYEAREXPENSES varchar2(35);
     alter table agr_poultry_expenditure modify TOTVIIIYEAREXPENSES varchar2(35);
     alter table agr_poultry_expenditure modify TOTIYEARBANK varchar2(35);
     alter table agr_poultry_expenditure modify TOTIIYEARBANK varchar2(35);
     alter table agr_poultry_expenditure modify TOTIIIYEARBANK varchar2(35);
     alter table agr_poultry_expenditure modify TOTIYEARLASTEXP varchar2(35);
     alter table agr_poultry_expenditure modify TOTIIYEARLASTEXP varchar2(35);
     alter table agr_poultry_expenditure modify TOTIIIYEARLASTEXP varchar2(35);
     
      alter table agr_poultry_nonrecurring modify POULTRY_LOANAMOUNT varchar2(50);
      alter table agr_poultry_recurring modify POULTRY_LOANAMOUNT varchar2(35);
      alter table agr_poultry_recurring modify POULTRY_CHARGE varchar2(35);
      
        alter table agr_poultry_recdetails modify AGR_TOTALLOANAMOUNT varchar2(50);
       alter table agr_poultry_recdetails modify AGR_TOTALAMOUNT2 varchar2(50);
         alter table agr_poultry_recdetails modify AGR_TOTALLOANAMOUNT2 varchar2(50);
      
<!--end-->

<!--Added By Saranya.P-->
update page_master set page_shortcode='crdrep1' ,page_type='D',page_auditreq='Y' where page_id='69'
update page_master set page_shortcode='crdrep2' ,page_type='N',page_auditreq='Y' where page_id='70'
update page_master set page_shortcode='insrep' ,page_type='N',page_auditreq='Y' where page_id='65'

set scan off;
Insert into PAGE_MASTER (PAGE_ID,PAGE_DESC,MODULE_KEY,MODULE_NAME,PAGE_NAME,PAGE_SHORTCODE,
PAGE_TYPE,PAGE_AUDITREQ) values (406,'Duediligence1.jsp','3','Retail & Agriculture',
'Duediligence Report','duerep','N','Y');

update page_master set page_name='Credit Report' where page_id='69'


Insert into PAGE_MASTER (PAGE_ID,PAGE_DESC,MODULE_KEY,MODULE_NAME,PAGE_NAME,PAGE_SHORTCODE,
PAGE_TYPE,PAGE_AUDITREQ) values (407,'creditreport3.jsp','6','Commercial',
'Credit Report','comcrdtr','D','Y');


Insert into PAGE_MASTER (PAGE_ID,PAGE_DESC,MODULE_KEY,MODULE_NAME,PAGE_NAME,PAGE_SHORTCODE,
PAGE_TYPE,PAGE_AUDITREQ) values (408,'com_pre_SanctionInspectionReport.jsp','6','Commercial',
'Inspection Report','compresr','N','Y');

set scan off;
Insert into PAGE_MASTER (PAGE_ID,PAGE_DESC,MODULE_KEY,MODULE_NAME,PAGE_NAME,PAGE_SHORTCODE,
PAGE_TYPE,PAGE_AUDITREQ) values (409,'agr_creditreport1.jsp','3','Retail & Agriculture',
'Credit Report','agrcdrep','D','Y');

set scan off;
Insert into PAGE_MASTER (PAGE_ID,PAGE_DESC,MODULE_KEY,MODULE_NAME,PAGE_NAME,PAGE_SHORTCODE,
PAGE_TYPE,PAGE_AUDITREQ) values (410,'agr_pre_sanction.jsp','3','Retail & Agriculture',
'Inspection Report','agrpresn','N','Y');

ALTER TABLE ADV_BILLPURCHASE 
ADD (BILL_SNO VARCHAR2(20) );
<!--END-->
<!-- Added By Zahoorunnisa.S -->
  alter table AGR_POULTRY_FINDATA modify POULTRY_SALEGUNNY varchar2(20);
<!--End-->


ALTER TABLE APP_DEVIATION ADD (DEVIATION_APPREJ VARCHAR2(2),DEVIATION_APPREJUSERID VARCHAR2(20));



<!--Added by Saranya.TV-->
ALTER TABLE PERAPPLICANT 
ADD (PERAPP_MINOR VARCHAR2(50) );
<!--END-->
ALTER TABLE PER_INSURANCE MODIFY (INSU_PREPAID DATE );
ALTER TABLE APP_DEVIATION ADD (DEVIATION_APPREJ VARCHAR2(2),DEVIATION_APPREJUSERID VARCHAR2(20));

<!-- Added By Zahoorunnisa.S on 3rd April 2012 -->

set scan off;
Insert into PAGE_MASTER (PAGE_ID,PAGE_DESC,MODULE_KEY,MODULE_NAME,PAGE_NAME,PAGE_SHORTCODE,
PAGE_TYPE,PAGE_AUDITREQ) values (412,'set_cibilinterface.jsp','1','Setup',
'Home -> Setup -> Interface -> CIBIL Interface ','setcibil','D','Y');
<!--End -->

<!-- Added by Subha for MMR Print Format on 04/04/2012 -->

alter table mon_branchheadcomments add(MON_LIMITS VARCHAR2(2));
alter table mon_branchheadcomments add(MON_LIMITSREASON VARCHAR2(4000));

<!-- END -->

<!-- Added By Zahoorunnisa.S on 4th April 2012 -->

    alter table agr_poultry_recdetails modify AGR_TOTALAMOUNT varchar2(25);
    alter table agr_poultry_recdetails modify AGR_TOTALMARGIN varchar2(25);
    alter table agr_poultry_recdetails modify AGR_TOTALMARGIN2 varchar2(25);
    
<!-- END -->

alter table MON_MSODESTIMATES add(MON_MSODMMRNO VARCHAR2(22 BYTE));
alter table mon_msodBorrowing add(MON_MSODMMRNO VARCHAR2(22 BYTE));


<!-- Added By Zahoorunnisa.S on 11th April 2012 -->
alter table other_parameters modify LOAN_PARAMVAL number(18,2);
<!-- END -->

<!--Saranya.P-->
Insert into PAGE_MASTER (PAGE_ID,PAGE_DESC,MODULE_KEY,MODULE_NAME,PAGE_NAME,PAGE_SHORTCODE,
PAGE_TYPE,PAGE_AUDITREQ) values (411,'reasons_excess.jsp','14','Monthly Monitoring Report',
'Home -> Monitoring-> Monthly Monitoring Reports-> Reasons for excess','rsnexs','N','Y');

Insert into PAGE_MASTER (PAGE_ID,PAGE_DESC,MODULE_KEY,MODULE_NAME,PAGE_NAME,PAGE_SHORTCODE,
PAGE_TYPE,PAGE_AUDITREQ) values (422,'monannexurefacilities.jsp','14','Monthly Monitoring Report',
'Home -> Monitoring-> Monthly Monitoring Reports-> Facilities Enjoyed-> Annexure','anxfac','D','Y');
<!--END-->
alter table mon_stockstatement add(STOCK_MMRNO VARCHAR2(21 BYTE));
<!--Saranya.P-->
ALTER TABLE AGR_CROPPINGPATTERNDATA  
MODIFY (TOTNETINCOMEE VARCHAR2(25 BYTE) );

ALTER TABLE AGR_CROPPINGPATTERNDATA  
MODIFY (TOTNETINCOMEP VARCHAR2(25 BYTE) );
<!--END-->

alter table mon_qprperformance add(MON_QPRMMRNO VARCHAR2(21));
alter table mon_workingcapitalfunds add(MON_WORKMMRNO VARCHAR2(21)); 
alter table mon_currentassetfinanced add(CURRENT_MMRNO VARCHAR2(21)); 
alter table mon_inventory add(MON_INVENMMRNO VARCHAR2(21));

<!--Zahoorunnisa.S on 19th April 2012 -->
alter table mon_branchheadcomments add mon_noname varchar2(80);
alter table mon_branchheadcomments add mon_nodesgn varchar2(80);
alter table mon_branchheadcomments add mon_ainame varchar2(80);
alter table mon_branchheadcomments add mon_aidesgn varchar2(80);
alter table mon_branchheadcomments add mon_bhname varchar2(80);
alter table mon_branchheadcomments add mon_bhdesgn varchar2(80);
<!--end-->

<!--Zahoorunnisa.S on 30th April 2012 -->
alter table discretepowers modify DISC_PERPTYUNSECURED number(20,2);
<!--end-->


<!--Zahoorunnisa.S on 3rd May 2012 -->
update page_master set page_shortcode = 'staffprm', page_type='N',page_auditreq='Y'
where page_id='128';
alter table prd_sanction_limit modify SANCTION_LIMIT number(20,2);
<!--End-->

<!-- Subha on 3rd May 2012 -->
update PAGE_MASTER set PAGE_NAME='Facilities' where page_id='351';
update PAGE_MASTER set PAGE_NAME='Loan Application Register' where page_id='362';
update PAGE_MASTER set PAGE_NAME='Securities' where page_id='342';
update PAGE_MASTER set PAGE_NAME='Inspection Report' where page_id='65';
delete page_master where page_id='406' and module_name='Retail null';
<!-- END -->

<!-- Zahoorunnisa.S on 17th May 2012 -->
INSERT INTO PAGE_MASTER (PAGE_ID, PAGE_DESC, MODULE_KEY, MODULE_NAME, PAGE_NAME, PAGE_SHORTCODE, PAGE_TYPE, PAGE_AUDITREQ) VALUES ('431', 'com_cma_master.jsp', '1', 'Setup', 'Home -> Setup -> Corporate Products -> CMA Index', 'setcma', 'D', 'Y');
<!-- END -->

<!--Added By Zahoorunnisa.S for user single sign ON-->

Create table LAPS_RAM_USERS (
LAPS_ID VARCHAR2(15),
USER_CODE VARCHAR2(15),
USER_PASSWORD VARCHAR2(50)
);

<!--End-->

<!--Added By Zahoorunnisa.S for copy product-->
alter table products modify prd_desc VARCHAR2(150);
<!--End-->

<!-- Added By Zahoorunnisa.S for Internet Interface -->
 alter table organisations add org_internet_centre varchar2(5);
 alter table organisations add org_centrename varchar2(80);
 alter table groups add grp_accessfor varchar2(5); 
 update groups set grp_accessfor = 'OL'; 
 alter table APPINWARDREG add inward_internetapp varchar2(3);
 
create table laps_online_mapping (
lom_referenceno varchar2(20),
lom_appno varchar2(20),
lom_appid varchar2(20),
lom_online_custid varchar2(20)
);
<!-- End -->
alter table groups add grp_privilege varchar2(1);

update groups set grp_privilege=substr(grp_rights,19,1);

create table tlr_others ( tlr_appno varchar2(25), tlr_comments clob);
 

<!-- Added by Ahilandeswari.M -->
alter table per_cuscbsaccountdata add  facility_sno  number(10); 
alter table mis_appdisplayscreen add  app_facility_sno  number(10); 
alter table mis_appdetails add  app_facility_sno  number(10); 
alter table mis_appclassification add app_facility_sno number(10); 
alter table facility_corp add  com_bankscheme  varchar2(100);
<!-- Ended by Ahilandeswari.M --> 

<!--Added by Amaravathi -->
create table com_banking_det
(
  com_bank_appno varchar(30),
  com_bank_factype varchar(5),
  com_bank_facsno varchar(5),
  com_bank_facility varchar(5),
  com_bank_facility_desc varchar(50),
  com_bank_faccrtype varchar(5),
  com_bank_name varchar(40),
  com_bank_arr varchar(5),
  com_bank_lead varchar(40)
);
<-- End-->
 

ALTER TABLE LOANDETAILS 
ADD (LOAN_AGEOFVEH CHAR(2) ); 
<1--added by bhaskar
alter table facility_corp add(com_agrschemetype varchar2(20));

<!--Scripts added by bhaskar from 10 feb to 20 feb-->

alter table rsk_param_rule add(rsk_rule_ratfor varchar2(5));

alter table rsk_param_rule add(rsk_rule_ratcode varchar2(50));

alter table rsk_param_rule add(rsk_rule_bankschmcode varchar2(1000));

alter table mis_activitycode add(act_busruleid varchar2(50));

alter table RSK_LAPS_PARAMS ADD(RSK_PARAMCODE VARCHAR2(50));

alter table RSK_LAPS_PARAMS ADD(RSK_PARAFOR VARCHAR2(10));

alter table RSK_LAPS_PARAMS add(RSK_PARMDATATYPE VARCHAR2(20));


CREATE  TABLE KBL_FINACLE.UPL_PROPOSAL_DATA(PROPOSAL_ID VARCHAR2(256) NOT NULL,
                                            COUNTERPARTY_UID VARCHAR2(64) NOT NULL,
                                            USER_LOGIN_ID VARCHAR2(64) NOT NULL,
                                            BRANCH_CODE VARCHAR2(64) NOT NULL,
                                            IS_RMD NUMBER(22,0));


CREATE  TABLE KBL_FINACLE.UPL_REQUEST_DATA(PROPOSAL_ID VARCHAR2(256) NOT NULL,
                                           REQUEST_ID VARCHAR2(64) NOT NULL,
                                           MODEL_CODE VARCHAR2(64) NOT NULL,
                                           RATING_TYPE NUMBER(22,0),
                                           TRANSACTION_NO VARCHAR2(128),
                                           USE_OLD_RATING NUMBER(22,0));

CREATE  TABLE KBL_FINACLE.UPL_COUNTERPARTY_DATA (PROPOSAL_ID VARCHAR2(256) NOT NULL,
                                                 COUNTERPARTY_UID VARCHAR2(64) NOT NULL,
                                                 NAME VARCHAR2(128) NOT NULL,
                                                 TYPE_CODE VARCHAR2(64),
                                                 GROUP_CODE VARCHAR2(64),
                                                 INDUSTRY_CODE VARCHAR2(64),
                                                 COUNTRY_CODE VARCHAR2(64),
                                                 BANKING_SINCE_DATE DATE,
                                                 BRANCH_CODE VARCHAR2(64),
                                                 BIRTH_DATE DATE);

CREATE  TABLE KBL_FINACLE.UPL_RATING_REQUEST_PARAMETER(PROPOSAL_ID VARCHAR2(256) NOT NULL,
                                                       REQUEST_ID VARCHAR2(64) NOT NULL,
                                                       PARAMETER_CODE VARCHAR2(64) NOT NULL,
                                                       NUMBER_VALUE NUMBER(36,12),
                                                       TEXT_VALUE VARCHAR2(64));


alter table AGR_DSS_ASSESSMENT add (AGR_DSS_TYPE VARCHAR2(10));

alter table AGR_DSS_ASSESSMENT add (AGR_DSS_FACSNO VARCHAR2(50));

alter table USERS add(usr_rmdflag varchar2(5));

alter table FACILITIES add (facility_securityratio number(30,2));

alter table LOANDETAILS add (loan_securityratio number(30,2));

alter table CUS_SECURITIES add(cus_sec_isliqidsecu varchar2(10));

alter table CUS_SECURITIES add(cus_sec_matuliddate date);

alter table prd_margincost add (margin_perct_othersec number(10,2))

<!--ended-->

<!--addede by bhaskar on 25th feb 2014-->

alter table SECURITY_MASTER add (sec_isliquidflag varchar2(10))

<!--end-->

<!--Added by Ahilandeswari.M on 10-03-2014 For Terms & Condition Sub Master Creation -->
alter table facility_terms add (FAC_PARENT_ID varchar2(10));
update facility_terms set FAC_PARENT_ID='0'; 
<!-- -->

<!--Added by Amaravathi for Liability pulling procedure changes-->
ALTER TABLE COM_BANKING ADD COMBK_FACTYPE CHAR(1);
ALTER TABLE COM_BANKING ADD COMBK_FAC_GRP NUMBER(10);
ALTER TABLE per_demographics ADD DEMO_OLDAPPID NUMBER(10);
<!--End-->

<!--Added by Amaravathi for New page in Banking Arrangement -->
CREATE TABLE COM_BANKING_CONSORTIUM
(
  COM_CON_APPNO VARCHAR(30),
  COM_CON_SNO NUMBER(10),
  COM_CON_BANK_CODE VARCHAR(20),
  COM_CON_FAC_NATURE VARCHAR(20),
  COM_CON_FAC_TYPE VARCHAR(5),
  COM_CON_FAC_LIMITOF VARCHAR(20),
  COM_CON_LIMIT DECIMAL(22,2),
  COM_CON_OUTSTANDING DECIMAL(22,2),
  COM_CON_INT_RATE DECIMAL(10,2),
  COM_CON_REMARKS CLOB,
  COM_CON_LEAD_SNO NUMBER(3)
);

CREATE TABLE COM_BA_CONSORTIUM
(
  COM_CONS_APPNO VARCHAR(30),
  COM_CONS_SNO NUMBER(10),
  COM_CONS_BANK_CODE VARCHAR(20),
  COM_CONS_DESC VARCHAR(60)
);

CREATE TABLE COM_BANKING_CONSORTIUM_TL
(
  COM_CON_APPNO VARCHAR(30),
  COM_CON_SNO NUMBER(10),
  COM_CON_BANK_CODE VARCHAR(20),
  COM_CON_FAC_NATURE VARCHAR(20),
  COM_CON_FAC_TYPE VARCHAR(5),
  COM_CON_FAC_LIMITOF VARCHAR(20),
  COM_CON_LIMIT DECIMAL(22,2),
  COM_CON_OUTSTANDING DECIMAL(22,2),
  COM_CON_INT_RATE DECIMAL(10,2),
  COM_CON_REMARKS CLOB,
  COM_CON_LEAD_SNO NUMBER(3)
);

CREATE TABLE COM_BA_CONSORTIUM_TL
(
  COM_CONS_APPNO VARCHAR(30),
  COM_CONS_SNO NUMBER(10),
  COM_CONS_BANK_CODE VARCHAR(20),
  COM_CONS_DESC VARCHAR(60)
);

<!--End-->

<!-- Facilities added 2 column-->

ALTER TABLE FACILITIES
ADD FACILITY_DUEDATE DATE;

ALTER TABLE FACILITIES
ADD FACILITY_DISPLAYDESC VARCHAR(100);


ALTER TABLE COM_BANKING_CONSORTIUM ADD COM_CON_LEAD_SNO NUMBER(3);
ALTER TABLE COM_BANKING_CONSORTIUM_TL ADD COM_CON_LEAD_SNO NUMBER(3);

<!--End-->
<!-- Added By Kishan -->
ALTER TABLE AGR_CAPL_GOODSDETAILS ADD CAPL_GOODS_MARGIN NUMBER(5,2);

<!-- MD Sanction to EC -->
CREATE TABLE KTB_DAY0.COM_MDSANCTIONTOEC
(
	MD_APPNO VARCHAR2(50),
	MD_ESTIMATEFOR VARCHAR2(100),
	MD_PROVISIONALASON DATE,
	MD_ACTUALSUPTO DATE,
	MD_PROJECTIONFOR VARCHAR2(100),
	MD_ACCEPTEDFOR VARCHAR2(100),
	MD_REMARKS VARCHAR2(4000),
	MD_WHETHERTAKEOVER VARCHAR2(1),
	MD_FURNISHDETAILS VARCHAR2(4000),
	MD_BANKNAME VARCHAR2(100),
	MD_SHIFTINGREASON VARCHAR2(4000),
	MD_WHETHERTAKEOVER_FULFIL VARCHAR2(1),
	MD_DEVIATIONCOMMENTS VARCHAR2(4000),
	MD_JUSTIFICATION VARCHAR2(4000),
	MD_ANYOTHERINFO VARCHAR2(4000))
);

ALTER TABLE KTB_DAY0.COM_MDSANCTIONTOEC ADD MD_DEALING VARCHAR2(2);

<!-- Whether Financial Required field is added -->
ALTER TABLE KTB_DAY0.APPLICATIONS ADD APP_FACILITYREQUIRED VARCHAR2(1);

<!-- ADDED BY ELAI-->
<!-- COM_EXTERNALRATING added 2 column-->
ALTER TABLE COM_EXTERNALRATING
ADD EXTERNAL_DEFINITION VARCHAR(50);

<!-- ADDED BY ELAI-->
<!-- COMPANY_INFO added 2 column-->
ALTER TABLE COMPANY_INFO
ADD COMINFO_IEC VARCHAR(50);

ALTER TABLE COMPANY_INFO
ADD COMINFO_GSTIN VARCHAR(50);

<!--ADDED BY ELAI---->
<!---ASSEMENT_COMMENT--->
create table ASSEMENT_COMMENT(ASSEMENT_APPNO VARCHAR2(50),
ASSEMENT_SNO VARCHAR2(50),ASSEMENT_COMMENT VARCHAR2(500,
ASSEMENT_COMMENT1 VARCHAR2(500),ASSEMENT_PAGETYPE VARCHAR2(50),
ASSEMENT_FNO VARCHAR2(50));
<!!---ADDED BY ELAI-->
ALTER TABLE CUS_SECURITIES MODIFY CUS_SEC_CERSAI_DATE VARCHAR2(100);
ALTER TABLE PERAPPLICANT DROP COLUMN PERAPP_CGPAN_NO;

<!-- ADDED BY ELAI-->
<!-- MCLRMASTER added 1 column-->
ALTER TABLE MCLRMASTER
ADD MCLR_TABLECODEOVERDRAFTS VARCHAR(50);



<!--Added for Repo Rate Change-->

create or replace PROCEDURE PROC_MCLRRATE_UPDATE (
    RefRateType IN VARCHAR2,
    RefRateSpread IN Number,
    RefRateTablecodeTL IN varchar2,
    RefRateTablecodeOD IN varchar2,
    OldRefRateSpread Number,
    OldRefRateTablecodeTL varchar2,
    MCLRType varchar2,
    OldMCLRType varchar2,
    DiffRate IN VARCHAR2)
 
 AS
 BEGIN
 
 UPDATE loandetails SET LOAN_MCLRTABCODE=(case when (select prd_loantype from products,applications where app_no=loan_appno and prd_code=app_prdcode)='OD'
 then RefRateTablecodeOD else 
 RefRateTablecodeTL end),LOAN_MODINTRATE=LOAN_MODINTRATE+DiffRate,
        LOAN_INTRATE = LOAN_INTRATE + DiffRate,
        LOAN_BASERATE=RefRateSpread,
        LOAN_MCLRTYPE=MCLRType where  LOAN_APPNO in (select app_no from applications  where (app_status in ('op','ol') 
        or (app_status='pr' and APP_AUTOREJ='Y')) and  nvl(app_delflag,'N')='N')
        and LOAN_APPNO not in (select app_no from applications,app_deviation  where appno=app_no and (app_status in ('op','ol') 
        or (app_status='pr' and APP_AUTOREJ='Y')) and  nvl(app_delflag,'N')='N' and DEVIATION_TYPE='IR') and LOAN_MCLRTYPE=OldMCLRType;
        
  update FACILITIES set FACILITY_INTEREST=FACILITY_INTEREST + DiffRate,BPLR= BPLR + DiffRate,FACILITY_SANCINTEREST = FACILITY_SANCINTEREST + DiffRate,
      facility_baserate=RefRateSpread
      where FACILITY_APPNO in (select a.FACILITY_APPNO from facilities a,facility_mclrspread b,applications 
      where a.FACILITY_APPNO=b.FACILITY_APPNO and app_no=a.FACILITY_APPNO and  (app_status='op' or app_status='ol' or (app_status='pr' and APP_AUTOREJ='Y'))
      and a.FACILITY_SNO=b.FACILITY_SNO and b.FACILITY_MCLRTYPE=OldMCLRType);
      

      
 update  facility_mclrspread set  FACILITY_MCLRTYPE=MCLRType, MCLR_SPREAD=RefRateSpread, MCLR_TABLECODE=(case when (select COM_FACILITY_LOANTYPE
  from facility_corp,facilities b where b.FACILITY_APPNO=FACILITY_APPNO and  b.FACILITY_CODE=COM_FACID 
  and b.FACILITY_SNO=FACILITY_SNO)='OD'
 then RefRateTablecodeOD else 
 RefRateTablecodeTL end)
  where FACILITY_APPNO in (select app_no from applications  where app_loantype in ('A','C') and
   (app_status in ('op','ol')  or (app_status='pr' and APP_AUTOREJ='Y'))) and FACILITY_MCLRTYPE=OldMCLRType; 

 END PROC_MCLRRATE_UPDATE;
 
 <!--End-->

