:- dynamic gasto/7.

% AUXILIARES
pegaProdutosSemRepetir(X) :-
    findall(Produto, gasto(_, Produto, _, _, _, _, _), ListaProdutos),
    sort(ListaProdutos,X).

itera([],[]).
itera([H|T],Result) :-
    itera(T,Result1),
    findall(QtdProduto,gasto(_,H,_,QtdProduto,_,_,_),ListaQtd),
    sum_list(ListaQtd,Total),
    Result=[Total|Result1].

max_list([X|Xs],Max,Index):-
    max_list(Xs,X,0,0,Max,Index).

max_list([],OldMax,OldIndex,_, OldMax, OldIndex).
max_list([X|Xs],OldMax,_,CurrentIndex, Max, Index):-
    X > OldMax,
    NewCurrentIndex is CurrentIndex + 1,
    NewIndex is NewCurrentIndex,
    max_list(Xs, X, NewIndex, NewCurrentIndex, Max, Index).
max_list([X|Xs],OldMax,OldIndex,CurrentIndex, Max, Index):-
    X =< OldMax,
    NewCurrentIndex is CurrentIndex + 1,
    max_list(Xs, OldMax, OldIndex, NewCurrentIndex, Max, Index).

find_item([H|_],0,Resultado) :- Resultado=H.
find_item([_|T],Index,Resultado) :- Index>0,IndexR is Index -1 ,find_item(T,IndexR,Result1),Resultado=Result1.


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

mais_comprado(ProdutoMaisComprado) :-
    pegaProdutosSemRepetir(X),
    itera(X,Result),
    max_list(Result,_,Index),
    find_item(X,Index,ProdutoMaisComprado),
    write(ProdutoMaisComprado).
