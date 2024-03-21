
def convert_nl_to_pddl(condition: str) -> str:
    return "(and\n\t\t(in Bread|-00.92|+00.99|+02.27 Fridge|-01.00|+00.00|+00.12)\n\t\t(not (opened Fridge|-01.00|+00.00|+00.12))\n\t)"
