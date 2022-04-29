from app import make_engine
import argparse
import pandas


prolog = make_engine()


def parse_file_data(file_path: str, type: str = "csv", sheet: str = None) -> None:
    if type == "csv":
        file_data = pandas.read_csv(file_path)
    elif type == "excel":
        file_data = pandas.read_excel(file_path, sheet_name=sheet)
    else:
        print("Formato de arquivo não suportado")
        exit(1)

    print(file_data.head())

    excel_rows = []
    for i in list(range(0, len(file_data.index))):
        d = file_data.iloc[i]
        d = d.tolist()

        if type == "excel":
            d[0] = d[0].strftime('%d-%m-%Y')

        fato = 'gasto('
        for j in range(0, len(d)):
            fato += "'"+str(d[j])
            if j == len(d)-1:
                fato += "')"
            else:
                fato += "',"
        print(fato)
        prolog.asserta(fato)
        excel_rows.append(d)


def menu() -> int:
    print("###################################")
    print("1 - Inserir novo gasto")
    print("2 - Consultar item")
    print("###################################")


def run_question(question: str) -> bool:
    result = prolog.query(question)
    if result == {}:
        return True
    
    return False


def run_query(query: str) -> dict:
    return prolog.query(query)


def main(args):
    parse_file_data(args.input, args.type, args.sheet)


    # p.assertz('compramos(Item) :- gasto(_,Item,_,_,_,_,_)')
    #p.assertz('qtdComprada(Item,Qtd) :- gasto(_,Item,_,_,_,_,_)')
    # print(list(p.query('gasto(X,Y,Z,A,B,C,D)')))
    # print(bool(list(p.query("compramos('Cimento Campeão CPII')"))))

    # for a in prolog.query("compramos('Cimento Campeão CPII')"):
    #     print(a)


parser = argparse.ArgumentParser(description="Trabalho paradigmas")
parser.add_argument("input", metavar="i", type=str, help="Arquivo de entrada")
parser.add_argument("type", metavar="t", type=str, help="Tipo do arquivo de entrada (csv, excel)")
parser.add_argument("sheet", metavar="s", type=str, help="Página do arquivo de entrada")
main(parser.parse_args())
