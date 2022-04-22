from app import make_engine
import argparse
import pandas


p = make_engine()


# def get_file_data(file_path: str) -> list:
#     pass


def main(args):

    dataFrame = pandas.read_excel(args.input, sheet_name=args.sheet)
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
        p.asserta(fato)
        excel_rows.append(d)

    # p.assertz('compramos(Item) :- gasto(_,Item,_,_,_,_,_)')
    #p.assertz('qtdComprada(Item,Qtd) :- gasto(_,Item,_,_,_,_,_)')
    # print(list(p.query('gasto(X,Y,Z,A,B,C,D)')))
    # print(bool(list(p.query("compramos('Cimento Campeão CPII')"))))

    for a in p.query("compramos('Cimento Campeão CPII')"):
        print(a)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Trabalho paradigmas")
    parser.add_argument("input", metavar="i", type=str, help="Arquivo de entrada")
    parser.add_argument("sheet", metavar="s", type=str, help="Página do arquivo de entrada")

    main(parser.parse_args())
