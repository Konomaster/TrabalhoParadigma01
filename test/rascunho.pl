gasto('01-09-2021','Cimento Campeão CPII','Loja do Ze',20.0,'saco',28.0,560.0).
gasto('01-09-2021','Lentilha','Loja da Maria',20.0,'saco',28.0,560.0).
gasto('01-10-2021','Cimento Campeão CPII','Loja do Ze',30.0,'saco',28.0,840.0).
gasto('01-09-2021','Cimento Campeão CPII','Lojas Americanas',15.0,'saco',28.0,420.0).
gasto('01-02-2021','Agrofilito','Loja Da Maria',10.0,'saco',28.0,280.0).
gasto('01-03-2021','Lentilha','Lojas Americanas',50.0,'saco',28.0,1400.0).

compramos(Item) :- gasto(_,Item,_,_,_,_,_).

qtdTotal(Item,Total) :- findall(Unidades, (gasto(_,Item,_,Unidades,_,_,_)),ListaTotal),sum_list(ListaTotal,Total).

total_compras_loja(Loja,Total) :- findall(Compra, (gasto(_,_,Loja,_,_,_,Compra)),ListaCompras),sum_list(ListaCompras,Total).

mais_comprado(X) :- findall(TotalUmItem, qtdTotal(_,TotalUmItem),ListaTotal),X=ListaTotal.

not_in_lista([],_).
not_in_lista([H|T],Item) :- H\=Item,not_in_lista(T,Item).

qtdTotalCadaItem(Total,Lista) :- gasto(_,Item,_,_,_,_,_),not_in_lista(Lista,Item),Lista=[Item|[]],findall(Unidades, (gasto(_,Item,_,Unidades,_,_,_)),ListaTotal),Total=ListaTotal.

qtdTCI(A,Lista) :- Lista=[A|[]].

pegaProdutosSemRepetir(X) :- findall(Produto,gasto(_,Produto,_,_,_,_,_),ListaProdutos),sort(ListaProdutos,X).

itera([],[]).
itera([H|T],Result) :- itera(T,Result1), findall(QtdProduto,gasto(_,H,_,QtdProduto,_,_,_),ListaQtd),sum_list(ListaQtd,Total),Result=[Total|Result1].

produtoMaisComprado(ProdutoMaisComprado) :- pegaProdutosSemRepetir(X),itera(X,Result),max_list(Result,_,Index),find_item(X,Index,ProdutoMaisComprado),write(ProdutoMaisComprado).

tamanho([],0).
tamanho([H|T],Result) :- H\=[],tamanho(T,Result1), Result is Result1+1.

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
