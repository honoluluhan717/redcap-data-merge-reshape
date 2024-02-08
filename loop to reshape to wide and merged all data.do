local files : dir "J:\Geriatrics\PrimaryData\Active Studies\Chow, SCOM\ALIGN_study_Chow\14 instruments" files "*.dta"
cd "J:\Geriatrics\PrimaryData\Active Studies\Chow, SCOM\ALIGN_study_Chow\14 instruments"

local num=1
foreach file in `files' {
              use `file', clear

local widevars

foreach x of varlist * {
              if !inlist("`x'", "refno", "redcap_repeat_instance") {
			  	rename `x' `x'_
                             local widevars `widevars' `x'_
              }
}

reshape wide `widevars', i(refno) j(redcap_repeat_instance)

tempfile t`num'
save `t`num''

local num=`num'+1
}

local num=`num'-1

use "J:\Geriatrics\PrimaryData\Active Studies\Chow, SCOM\ALIGN_study_Chow\demographics.dta", clear
forvalues i=1/14 {
              merge 1:1 refno using `t`i'', nogen 
}

save "J:\Geriatrics\PrimaryData\Active Studies\Chow, SCOM\ALIGN_study_Chow\final_data.dta", replace 

