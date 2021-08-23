// https://stonecenter.gc.cuny.edu/research/all-the-ginis-alg-dataset-version-february-2019/
/* clean the data from allgini */

clear 
cd $DTA\gini
set maxvar 120000 
 

 use allginis_2019_stata12.dta,clear

 order country contcod year
 drop region nvals MENA

 gen countryname = ""
 rename contcod countrycode

 qui do $CODE\2_idwd.do

 drop if id == .

 rename id cid 

 order cid year 
 keep  cid year LIS gini_LIS Dinc_LIS Dhh_LIS Dgross_LIS SEDLAC gini_SEDLAC Dinc_SEDLAC Dhh_SEDLAC Dgross_SEDLAC EEUROPE gini_EE Dinc_EE Dhh_EE Dgross_EE WYD gini_WYD Dinc_WYD Dhh_WYD Dgross_WYD SILC gini_SILC Dinc_SILC Dhh_SILC Dgross_SILC POVCAL gini_POVCAL Dinc_POVCAL Dhh_POVCAL INDIE gini_INDIE Dinc_INDIE Dhh_INDIE Dgross_INDIE WIDER gini_W Dinc_W Dgross_W Dhh_W CEPAL gini_CEPAL Dinc_CEPAL Dgross_CEPAL Dhh_CEPAL
 
 sort cid year
tostring cid year ,replace force
gen _mergcid =   year + cid
drop cid year  

save allgini_use.dta,replace

//https://www.wider.unu.edu/database/world-income-inequality-database-wiid
/* clean the data from wiid */

use WIID_31MAY2021.dta,clear

drop id 
 gen countryname = ""
 rename c3 countrycode

 qui do $CODE\2_idwd.do

 drop if id == .

 rename id cid 

 order cid year 
 keep  cid year gini ge0 ge1 ge2 a025 a050 a075 a1 palma ratio_top20bottom20 bottom40 q1 q2 q3 q4 q5 d1 d2 d3 d4 d5 d6 d7 d8 d9 d10 bottom5 top5 resource resource_detailed scale scale_detailed sharing_unit reference_unit areacovr areacovr_detailed popcovr popcovr_detailed region_un region_un_sub region_wb oecd eu incomegroup mean median currency reference_period exchangerate mean_usd median_usd 

 sort cid year
tostring cid year ,replace force
gen _mergcid =   year + cid
order _mergcid

// 这里是一个很粗略的清洗，有待完善
 drop if sharing_unit == .
 keep if sharing_unit == 1 
 keep if areacovr == 1
 duplicates tag _mergcid , generate(dupnb)
 order dupnb
 drop if dupnb != 0 & resource == 1 
 drop if dupnb != 0 & resource == 5 
 drop dupnb 
 duplicates tag _mergcid , generate(dupnb)
 order dupnb

 gen TT = 0
 foreach var of varlist gini ge0 ge1 ge2 a025 a050 a075 a1 palma ratio_top20bottom20 bottom40 q1 q2 q3 q4 q5 d1 d2 d3 d4 d5 d6 d7 d8 d9 d10 bottom5 top5 mean median mean_usd median_usd {
     gen t_`var' = 0
     replace t_`var' = 1 if `var' != .

     replace TT = TT + t_`var'
     drop t_`var'
 }
     order TT
 drop if dupnb != 0 & resource == 5 
 

drop cid year  

foreach var of varlist gini ge0 ge1 ge2 a025 a050 a075 a1 palma ratio_top20bottom20 bottom40 q1 q2 q3 q4 q5 d1 d2 d3 d4 d5 d6 d7 d8 d9 d10 bottom5 top5 resource resource_detailed scale scale_detailed sharing_unit reference_unit areacovr areacovr_detailed popcovr popcovr_detailed region_un region_un_sub region_wb oecd eu incomegroup mean median currency reference_period exchangerate mean_usd median_usd  {
    rename `var' wiid_`var'
}
 
save wiid_use.dta,replace





