gasto('01-09-2021','Cimento Campe�o CPII','Loja do Z�','20.0','saco','28.0','560.0').
gasto('01-09-2021','Cimento Campe�o CPII','Loja da zica','30.0','saco','28.0','560.0').
gasto('01-09-2021','Cimento Campe�o CPII','Loja do tonho','50.0','saco','28.0','560.0').

compramos(Item) :- gasto(_,Item,_,_,_,_,_).

totalComprado(Item,QtdTotal) :- \+compramos(Item),QtdTotal is 0.
totalComprado(Item,QtdTotal) :- gasto(_,Item,_,_,_,_,_).
