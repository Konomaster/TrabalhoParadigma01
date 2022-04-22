import pandas as pd
from pyswip import Prolog


def main():
    p = Prolog()

    # usar com index_col=0 tira a primeira coluna
    dataFrame = pd.read_excel('PlanilhaGastos.xlsx', sheet_name='Pagina1')
    print(dataFrame.head())
    excel_rows = []
    lista_gastos = []
    for i in list(range(0, len(dataFrame.index))):
        d = dataFrame.iloc[i]
        d = d.tolist()
        d[0] = d[0].strftime('%d-%m-%Y')
        fato = 'gasto('
        for j in range(0, len(d)):
            fato += "'"+str(d[j])
            if j == len(d)-1:
                fato += "')"
            else:
                fato += "',"
        print(fato)
        p.assertz(fato)
        excel_rows.append(d)

    p.assertz('compramos(Item) :- gasto(_,Item,_,_,_,_,_)')
    #p.assertz('qtdComprada(Item,Qtd) :- gasto(_,Item,_,_,_,_,_)')
    # print(list(p.query('gasto(X,Y,Z,A,B,C,D)')))
    print(bool(list(p.query("compramos('Cimento Campeão CPII')"))))
    pass


if __name__ == '__main__':
    main()
