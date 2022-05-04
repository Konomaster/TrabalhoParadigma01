:- dynamic gasto/7.

% AUXILIARES
pegaProdsSemRepetir(X) :- findall(Produto,gasto(_,Produto,_,_,_,_,_),ListaProdutos),sort(ListaProdutos,X).

fazLista([],[]).
fazLista([H|T],Result) :- fazLista(T,Result1), findall(QtdProduto,gasto(_,H,_,QtdProduto,_,_,_),ListaQtd),sum_list(ListaQtd,Total),Result=[dados(H,Total)|Result1].

descobreMax([],-1).
descobreMax([H|T],Max):-descobreMax(T,OldMax),H=..[_,_,Qtd],((OldMax>Qtd,Max is OldMax);Max is Qtd).



maisComprados(_,[],[]).
maisComprados(Max,[H|T],LProdutos):-maisComprados(Max,T,Res1),H=..[_,Produto,Qtd],
                                   ((Qtd=:=Max,LProdutos=[Produto|Res1]);LProdutos=Res1).



% PRINCIPAIS
comprado(Item) :-
    gasto(_,Item,_,_,_,_,_).

quantidade_total(Item, Total) :-
    gasto(_, Item, _, _, _, _, _),
    findall(Unidades, gasto(_, Item, _, Unidades, _, _, _), ListaTotal),
    sum_list(ListaTotal, Total),!.

valor_total(Item, Total) :-
    quantidade_total(Item, Unidades),
    gasto(_, Item, _, _, _, Valor, _),
    Total is Unidades * Valor, !.

comprados_em(Data, Result) :-
    setof(Item, gasto(Data,Item,_,_,_,_,_), Result).

total_compras_loja(Loja,Total) :-
    findall(Compra, gasto(_, _, Loja, _, _, _, Compra), ListaCompras),
    sum_list(ListaCompras, Total).

mais_comprado(L):-
                  pegaProdsSemRepetir(X),
                  fazLista(X,Res),
                  descobreMax(Res,Max),
                  maisComprados(Max,Res,L),!.


