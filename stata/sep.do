/* 注意：     */
/*     本方法只考虑了分10、100、1000（10的次方）这种情况  */
/* 基本思想： */
/*     1523个体观测值如果想分为100组，先拿总数除以100，得到一个带小数点的数字（例如15.23）；  */
/*     如果每组分得整数部分15，那么100乘以小数点部分0.23的样本还没有归宿；    */
/*     那么只需要前23组每组按照顺序多分一个，后面77组每组仍然分得15个即可完全分组   */


 
local sep_group = 100       /* input how many groups that you want to get */
local Group_name g_inca     /* input the name of the group var */


local tnumb =  _N

local Int_numb = floor(`tnumb'/`sep_group')
local Dot_numb = (`tnumb'/`sep_group' - `Int_numb')*`sep_group'
 
cap drop Group_numb  
cap drop `Group_name'  

cap gen Group_numb = _n 
cap gen `Group_name'  = .

local i = 1

while `i' <= `Dot_numb'+1 {
replace `Group_name'  = `i' if  (`Int_numb' + 1)*(`i' - 1)< Group_numb & Group_numb<= (`Int_numb' + 1)*`i'
local i = `i'+ 1 
}


dis `i'
dis `Dot_numb'  

local i =`i'-1 
dis (`tnumb' - (`i')*(`Int_numb'+1)) /`Int_numb'   /*还剩下多少组*/
dis ( (`i')*(`Int_numb'+1)) 

local j 1 
while  `j'<=( (`tnumb' - (`i' )*(`Int_numb'+1)) /`Int_numb'  ) {
   replace `Group_name'  = `i'+`j'  if   ( (`i')*(`Int_numb'+1)) +(`Int_numb')*(`j'-1 ) < Group_numb & Group_numb <= (  (`i')*(`Int_numb'+1)) +(`Int_numb')*(`j'  )
local j = `j'+ 1  
} 

