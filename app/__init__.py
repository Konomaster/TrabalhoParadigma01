# import pkgutil
# from pathlib import Path
from pyswip import Prolog

# PROLOG_RULES = "prolog/rules.pl"

def make_engine():
    prolog = Prolog()
    # prolog.consult(PROLOG_RULES.decode("UTF-8"))
    prolog.consult("app/prolog/rules.pl")
    return prolog
