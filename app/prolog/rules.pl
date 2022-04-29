:- dynamic gasto/7.


comprado(Item) :-
    gasto(_,Item,_,_,_,_,_).

quantidade_total(Item, Total) :-
    gasto(_, Item, _, _, _, _, _),
    findall(Unidades, gasto(_, Item, _, Unidades, _, _, _), ListaTotal),
    sum_list(ListaTotal, Total).

valor_total(Item, Total) :-
    quantidade_total(Item, Unidades),
    gasto(_, Item, _, _, _, Valor, _),
    Total is Unidades * Valor, !.

total_compras_loja(Loja,Total) :-
    findall(Compra, gasto(_, _, Loja, _, _, _, Compra), ListaCompras),
    sum_list(ListaCompras, Total).
