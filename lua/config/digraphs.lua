-- Custom digraphs for math, programming-language, and CS notation.
-- In insert mode, trigger with Ctrl-K followed by the two-character sequence.

vim.cmd [==[
" information flow
digraph /l  8467  " ℓ
digraph [=  8849  " ⊑
digraph ]=  8850  " ⊒
digraph [_  8847  " ⊏
digraph ]_  8848  " ⊐
digraph [^  8851  " ⊔
digraph [U  8852  " ⊓
digraph (>  8829  " ≽
digraph (<  8828  " ≼
digraph /<  8928  " ⋠
digraph />  8929  " ⋡
digraph ~=  8776  " ≈
digraph /~  8777  " ≉
digraph ~>  8669  " ⇝
digraph >>  8608  " ↠
digraph /[  8930  " ⋢
digraph /]  8931  " ⋣

" PL
digraph [[  10214 " ⟦
digraph ]]  10215 " ⟧
digraph \|- 8866  " ⊢
digraph \|= 8872  " ⊨
digraph _\| 8869  " ⊥
digraph \|_ 8869  " ⊥
digraph TT  8868  " ⊤

" Other math
digraph ox  8855  " ⊗
digraph o+  8853  " ⊕
digraph \|> 8614  " ↦
digraph /=  8800  " ≠
digraph /\  8743  " ∧
digraph \/  8744  " ∨
digraph ~~  0172  " ¬

" Sets
digraph /(  8713   " ∉
digraph UU  8746   " ∪
digraph U^  8745   " ∩
digraph xx  215    " ×
digraph (_  8838   " ⊆
digraph )_  8839   " ⊇
digraph \\  8726   " ∖
digraph \|\| 10072 " ❘
digraph ^^  770    "  ̂

" mathbb
digraph NN  8469  " ℕ
digraph ZZ  8484  " ℤ
digraph RR  8477  " ℝ

" Misc
digraph sq  8730  " √
digraph <>  8822  " ≶
]==]
