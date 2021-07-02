gen prova="北京"  //must be string
replace prova="北京" if prov==11
replace prova="天津" if prov==12
replace prova="河北" if prov==13
replace prova="山西" if prov==14
replace prova="内蒙古" if prov==15
replace prova="辽宁" if prov==21
replace prova="吉林" if prov==22
replace prova="黑龙江" if prov==23
replace prova="上海" if prov==31
replace prova="江苏" if prov==32
replace prova="浙江" if prov==33
replace prova="安徽" if prov==34
replace prova="福建" if prov==35
replace prova="江西" if prov==36
replace prova="山东" if prov==37
replace prova="河南" if prov==41
replace prova="湖北" if prov==42
replace prova="湖南" if prov==43
replace prova="广东" if prov==44
replace prova="广西" if prov==45
replace prova="海南" if prov==46
replace prova="重庆" if prov==50
replace prova="四川" if prov==51
replace prova="贵州" if prov==52
replace prova="云南" if prov==53
replace prova="西藏" if prov==54
replace prova="陕西" if prov==61
replace prova="甘肃" if prov==62
replace prova="青海" if prov==63
replace prova="宁夏" if prov==64
replace prova="新疆" if prov==65

gen prov0 = prov
label define Chinese_name_prov 11 "北京" 12 "天津" 13 "河北" 14 "山西" 15 "内蒙古" 21 "辽宁" 22 "吉林" 23 "黑龙江" 31 "上海" 32 "江苏" 33 "浙江" 34 "安徽" 35 "福建" 36 "江西" 37 "山东" 41 "河南" 42 "湖北" 43 "湖南" 44 "广东" 45 "广西" 46 "海南" 50 "重庆" 51 "四川" 52 "贵州" 53 "云南" 54 "西藏" 61 "陕西" 62 "甘肃" 63 "青海" 64 "宁夏" 65 "新疆"
label copy Chinese_name_prov Chinese_name_prov2
label values prov0 Chinese_name_prov2

//


 
gen prov = .

replace prov=11  if prova == "北京"
replace prov=12  if prova == "天津"
replace prov=13  if prova == "河北" 
replace prov=14  if prova == "山西" 
replace prov=15  if prova == "内蒙古"      
replace prov=21  if prova == "辽宁"      
replace prov=22  if prova == "吉林"      
replace prov=23  if prova == "黑龙江"      
replace prov=31  if prova == "上海"      
replace prov=32  if prova == "江苏"      
replace prov=33  if prova == "浙江"      
replace prov=34  if prova == "安徽"      
replace prov=35  if prova == "福建"      
replace prov=36  if prova == "江西"      
replace prov=37  if prova == "山东"      
replace prov=41  if prova == "河南"      
replace prov=42  if prova == "湖北"      
replace prov=43  if prova == "湖南"      
replace prov=44  if prova == "广东"      
replace prov=45  if prova == "广西"      
replace prov=46  if prova == "海南"      
replace prov=50  if prova == "重庆"      
replace prov=51  if prova == "四川"      
replace prov=52  if prova == "贵州"      
replace prov=53  if prova == "云南"      
replace prov=54  if prova == "西藏"      
replace prov=61  if prova == "陕西"      
replace prov=62  if prova == "甘肃"      
replace prov=63  if prova == "青海"      
replace prov=64  if prova == "宁夏"      
replace prov=65  if prova == "新疆"      


