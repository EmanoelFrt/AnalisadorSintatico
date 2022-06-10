# Trabalho de Compiladores - 2022
<br/>
Emanoel Lucas Fortuna
<br/>
GitHub: https://github.com/EmanoelFrt/AnalisadorSintatico
<br/>
<br/>
Gramática:
<br/>
S ::= bBc | cCa
<br/>
A ::= Cb  | aBd
<br/>
B ::= aCc | ε
<br/>
C ::= bAc |
<br/>
<br/>
First:
<br/>
S ::= { b, c }
<br/>
A ::= { a }
<br/>
B ::= { a, ε }
<br/>
C ::= { b }
<br/>
<br/>
Follow:
<br/>
S ::= { $ }
<br/>
A ::= { c }
<br/>
B ::= { c, d }
<br/>
C ::= { c, a }
<br/>
<br/>

Tabela:

| - | A      | B      | C      | D      | $ 
| ------------- | :-------------: | :-------------: |  :-------------: |   :-------------: |   :-------------: |
| S | -      | S➔bBc | S➔cCa | -      | - |
| A | A➔aBd | -      | -      | -      | - |
| B | B➔aCc | -      | B➜ε   | B➜ε    | - |
| C | -      | C➔bAc | -      | -      |
<br/>
- Sentenças Corretas:
<br/>
cbaabadccdca - Aceito em 20 Iterações. 
<br/>
babadccc - Aceito em 14 Iterações. 
<br/>
cbaca - Aceito em 11 Iterações. 
<br/>
babaabaccdccc - Aceito em 23 Iterações. 
<br/>
<br/>
- Sentenças Incorretas:
<br/>
cbaaababd - Erro em 10 Iterações 
<br/>
badc - Erro em 6 Iterações. 
<br/>
<br/>
