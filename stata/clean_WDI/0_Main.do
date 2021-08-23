

global MainPath  C:\Users\yanli\Desktop\共同富裕课题 

global DTA   "${MainPath}\DTA"
global PLOT  "${MainPath}\OUTPUT\PLOT" 
global TABLE "${MainPath}\OUTPUT\TABLE"
global CODE "${MainPath}\CODE"



//下载并清洗WDI等数据 
 do $CODE\1_data_clean_wdi.do

 qui do $CODE\1_data_clean_gini.do

//合并数据
 clear
 cd $DTA

 use wdi_use.dta,clear 


 merge 1:1 _mergcid using $DTA\gini\allgini_use.dta
 cap drop _merge 

 merge 1:1 _mergcid using $DTA\temp_usa.dta
 cap drop _merge 
 //merge 1:1 _mergcid using $DTA\gini\wiid_use.dta  

gen temp_cid = "."
gen temp_year = "."
replace temp_year = substr(_mergcid , 1, 4)
replace temp_cid = substr(_mergcid , 5, .)
order cid year  temp_*

destring temp_year temp_cid ,replace force

replace year =  temp_year  if year == .
replace cid =  temp_cid if cid == .

drop temp_year  temp_cid

 tsfill  , full 

order  cid countrycode countryname year gini
xtset  cid year


//整理常用变量
 
drop if year < 1960

save wdi_all.dta,replace

//NY_GDP_MKTP_KD_ZG   gdp增速
//NY_GDP_PCAP_KD      2010美元不变价
//NY_GDP_PCAP_CD      现价美元 

//NV_SRV_TOTL_ZS
 
use wdi_all.dta,clear

gen	oecd_state	=	0							
replace	oecd_state	=	1	if	cid==	11     ///     
   |cid== 12     ///     
   |cid== 33     ///     
   |cid== 53     ///     
   |cid== 62     ///     
   |cid== 64     ///     
   |cid== 50     ///     
   |cid== 92     ///     
   |cid== 94     ///     
   |cid== 97     ///     
   |cid== 115     ///     
   |cid== 142     ///     
   |cid== 145     ///     
   |cid== 143     ///     
   |cid== 156     ///     
   |cid== 59     ///     
   |cid== 178     ///     
   |cid== 34     ///     
   |cid== 68     ///     
   |cid== 198		


drop if oecd_state == 0 & cid != 37
drop if year == 2021
order cid countrycode countryname year gini_LIS   NY_GDP_PCAP_KD




**************************************************************
**          画图
**************************************************************
 
 set scheme s1mono

// Fig 1.1 
  
  graph twoway  (line gini_LIS year  if cid == 198, color(black) lpattern(solid) )      ///
                (line gini_LIS year  if cid == 11, color(gs10) lpattern(solid) )      ///
                (line gini_LIS year  if cid == 12, color(gs10) lpattern(solid) )      ///
                (line gini_LIS year  if cid == 33, color(gs10) lpattern(solid) )      ///
                (line gini_LIS year  if cid == 53, color(gs10) lpattern(solid) )      ///
                (line gini_LIS year  if cid == 62, color(gs10) lpattern(solid) )      ///
                (line gini_LIS year  if cid == 64, color(gs10) lpattern(solid) )      ///
                (line gini_LIS year  if cid == 50, color(gs10) lpattern(solid) )      ///
                (line gini_LIS year  if cid == 92, color(gs10) lpattern(solid) )      ///
                (line gini_LIS year  if cid == 94, color(gs10) lpattern(solid) )      ///
                (line gini_LIS year  if cid == 97, color(gs10) lpattern(solid) )      ///
                (line gini_LIS year  if cid == 115, color(gs10) lpattern(solid) )      ///
                (line gini_LIS year  if cid == 142, color(gs10) lpattern(solid) )      ///
                (line gini_LIS year  if cid == 145, color(gs10) lpattern(solid) )      ///
                (line gini_LIS year  if cid == 143, color(gs10) lpattern(solid) )      ///
                (line gini_LIS year  if cid == 156, color(gs10) lpattern(solid) )      ///
                (line gini_LIS year  if cid == 59, color(gs10) lpattern(solid) )      ///
                (line gini_LIS year  if cid == 178, color(gs10) lpattern(solid) )      ///
                (line gini_LIS year  if cid == 34, color(gs10) lpattern(solid) )        ///
                (line gini_LIS year  if cid == 68, color(gs10) lpattern(solid) )      ,   ///
            ylabel( , grid gmax angle(horizontal)   )   /// 
            xtitle(`"{fontface "宋体":年份}"')  ytitle(`"{fontface "宋体":系数}"')   legend(off)
     graph  save   ${PLOT}\fig3_1.gph ,replace 
     graph export  ${PLOT}\fig3_1.png, width(4000) height(3000) replace  
  
 



 






 
