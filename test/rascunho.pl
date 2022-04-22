gasto('01-09-2021', cimento, 'Loja do Zé', 20.0, saco, 28.0, 560.0).
gasto('01-09-2021', cimento, 'Loja do Zé', 20.0, saco, 28.0, 560.0).
gasto('01-09-2021', piso, 'Loja da zica', 30.0, caixa, 10.0, 300.0).
gasto('01-09-2021', ferramenta, 'Loja do tonho', 2, unidade, 20.0, 40.0).


comprado(Item) :- gasto(_,Item,_,_,_,_,_).

quantidade_total(Item, Total) :-
    gasto(_, Item, _, _, _, _, _),
    findall(Unidades, gasto(_, Item, _, Unidades, _, _, _), ListaTotal),
    sum_list(ListaTotal, Total).

valor_total(Item, Total) :-
    quantidade_total(Item, Unidades),
    gasto(_, Item, _, _, _, Valor, _),
    Total is Unidades * Valor, !.

% comprado_em(Data, Items) :-
%     findall(Unidades, gasto(Data, Item, ))

total_compras_loja(Loja,Total) :- findall(Compra, gasto(_,_,Loja,_,_,_,Compra),ListaCompras),sum_list(ListaCompras,Total).

% mais_comprado(Item) :-
    % L = [],
    % quantidade_total(Tmp, Total),

tmp(Item) :-
    Total is 0,
    repeat,
    write("Total = "), write(Total), write(" Item = "), write(Item), nl,
    quantidade_total(I, Qtd),
    write("Testando "), write(I), write(Qtd), nl,
    
    Qtd >= Total,
    
    write(I), write(" maior"), nl,
    Item = I,
    Total is Qtd;

    write(I), write(" menor"), nl,
    fail.
