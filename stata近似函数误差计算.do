clear
set obs 4000
gen n=_n
gen x=n/100
gen p=normal(x)
line p x

gen p1=0.5*(1+(1-exp(-2*x^2/_pi))^0.5)
gen y1=p-p1
line y1 x

local b0=0.2316419
local b1=0.319381530
local b2=-0.356563782
local b3=1.781477937
local b4=-1.821255978
local b5=1.330274429
gen p2=1-(normalden(x))*(`b1'/(1+`b0'*x)+`b2'/(1+`b0'*x)^2+`b3'/(1+`b0'*x)^3+`b4'/(1+`b0'*x)^4+`b5'/(1+`b0'*x)^5)
gen y2=p-p2
line y2 x

clear
set obs 100
gen n=_n
gen yy_bar=n/100
gen GG=(log(yy_bar)-0.5*yy_bar^2)/yy_bar
gen FF=(log(yy_bar)+0.5*yy_bar^2)/yy_bar
line GG yy_bar
line FF yy_bar
gen a=GG-FF
line a yy_bar

