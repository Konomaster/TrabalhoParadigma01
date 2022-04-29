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
            if j==3 or j==5 or j==6:
                fato += str(d[j])
            else:
                fato += "'" + str(d[j]) + "'"

            if j!=6:
                fato+=","
            else:
                fato+=")"
        print(fato)
        prolog.asserta(fato)
        excel_rows.append(d)


def menu():
    print("###### Consultar ##################")
    print("1 - Produto")
    print("2 - Quantidade comprada de produto")
    print("3 - Valor total de produto")
    print("4 - Comprados na data")
    print("5 - Compras na loja")
    print("6 - Produto mais comprado")
    print("exit - Encerrar")
    print("###################################")


def op_consulta_item() -> None:
    item = input("Nome do item> ")

    if bool(list(prolog.query("comprado('%s')" % item))):
        print("O item foi comprado")
    else:
        print("O item não foi comprado")
    
    # for a in prolog.query("compramos('Cimento Campeão CPII')"):
    #     print(a)

def op_quantidade_item() -> None:
    item = input("Nome do item> ")

    query = prolog.query("quantidade_total('%s', Qtd)" % item)
    # print(query["Qtd"])
    for i in query:
        print(i)

def run_question(question: str) -> bool:
    result = prolog.query(question)
    if result == {}:
        return True
    
    return False


def run_query(query: str) -> dict:
    return prolog.query(query)


def main(args):
    parse_file_data(args.input, args.type, args.sheet)

    cmd = None
    while cmd != "exit":
        menu()
        cmd = input("> ")

        if cmd == "1":
            op_consulta_item()
        elif cmd == "2":
            op_quantidade_item()

    # p.assertz('compramos(Item) :- gasto(_,Item,_,_,_,_,_)')
    #p.assertz('qtdComprada(Item,Qtd) :- gasto(_,Item,_,_,_,_,_)')
    # print(list(p.query('gasto(X,Y,Z,A,B,C,D)')))


parser = argparse.ArgumentParser(description="Trabalho paradigmas")
parser.add_argument("input", metavar="i", type=str, help="Arquivo de entrada")
parser.add_argument("type", metavar="t", type=str, help="Tipo do arquivo de entrada (csv, excel)")
parser.add_argument("sheet", metavar="s", type=str, help="Página do arquivo de entrada")
main(parser.parse_args())
