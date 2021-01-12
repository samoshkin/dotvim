" Highlight summary line when exceeds 72 columns, not 50 as a default
syn clear gitcommitSummary
syn match gitcommitSummary "^.\{0,72\}" contained containedin=gitcommitFirstLine nextgroup=gitcommitOverflow contains=@Spell
