
/* clean the data from WDI */

clear 
cd $DTA
set maxvar 120000 

insheet using WDIData.csv ,names

local i = 5
local j = 1960   //WDI start from year 1960
                 // should rename v* as y19XX  
while `i' <= 66 {
   qui rename v`i' y`j'

    local i = `i' + 1
    local j = `j' + 1
}

 // should replace all "." in variable indicatorcode as "_"
qui replace  indicatorcode = subinstr(indicatorcode, ".", "_",.)

// gen var id for merging
qui do $CODE\idwd.do
qui drop if id == .
qui rename id cid
 
qui sort countrycode indicatorcode

preserve
  qui duplicates drop indicatorcode,force
  qui sort indicatorcode
  qui keep indicatorname indicatorcode 
  qui gen varid = _n

  qui sum varid

  dis r(max)  
  dis "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
  dis "!!!2021年版本是1443个变量，对照表详见excel!!!"
  dis "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"

  qui save varid.dta ,replace
restore
   

  qui gen varid = .
  qui do  $CODE\varid.do
  order cid varid
  sort  cid varid
 
  // xpose data (should take quite a long time to finish) 

  egen grp = group(cid)
  sum grp
  local grp_max = r(max)
  local grp = 1
  
  while `grp' <= `grp_max' { 
  preserve 
  keep if grp == `grp' 
  local name = countrycode 
  order varid 
  keep varid y* 
  xpose, clear varname 
  save data_`grp'_`name'.dta,replace 
  restore 
  local  grp = (`grp' + 1)
  }
 

 // merge dta

clear
 local filesdta : dir . files "data_*.dta"
 foreach na of local filesdta {
 use  `na' , clear

 gen nn = _n
 drop if nn == 1  
 drop nn
 replace _varname = substr(_varname , -4 ,.)
 rename _varname  year
 destring year ,replace force 
 qui do  $CODE\renameVar.do 
 qui save  `na' , replace
                                 }
 

 local i=0
 local filesdta : dir . files "data_*.dta"
 foreach dta of local filesdta {
 if   `i'==0                   {
 use `dta',clear
 capture erase `dta'
                                }
 else                          {
 append  using   `dta'
 capture erase   `dta'
                               }
 local i=1 
                               }












