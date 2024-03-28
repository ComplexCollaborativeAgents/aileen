from typing import Tuple, Callable
import math

from numba import njit, float64

# @njit(float64(float64, float64))
# def fast_round(some_float, np):
#     # fast_round 2
#     PRECISION = float(10 ** np)
#     if some_float > 0:
#         return int(some_float * PRECISION + 0.5) / PRECISION
#     else:
#         return int(some_float * PRECISION - 0.5) / PRECISION

@njit(float64(float64, float64),fastmath=True)
def fast_round(some_float, np):
    # fast_round 1
    return round(some_float, np)


def make_function(name, parameters, body) -> Tuple[str, Callable]:
    declaration = "def {}({}):\n".format(name, parameters)
    declaration += "\n".join("    {}".format(statement) for statement in body)
    exec(declaration)
    func = locals()[name]
    return declaration, func


def compile_expression(expressions, name='preconditions') -> Tuple[str, Callable]:
    if len(expressions) == 0:
        body = 'return True'
    elif len(expressions) == 1:
        body = 'return ' + translate_expression(expressions[0])
    else:
        expr = " and ".join(translate_expression(e) for e in expressions)
        body = "return {}".format(expr)
    return make_function(name, 'state, constants', [body])


def compile_statements(statements, name='effects') -> Tuple[str, Callable]:
    if len(statements) == 0:
        body = ['pass']
    else:
        body = [translate_statement(stmt) for stmt in statements]
    return make_function(name, 'state, constants', body)


def check_numeric(token):
    try:
        float(token)
        return True
    except ValueError:
        return False


def state_var(tokens):
    return "state.state_vars[\"{}\"]".format(str(tokens))


def translate_expression(tokens):
    first_token = tokens[0] if isinstance(tokens, list) else tokens

    # print(f"{len(tokens)} length tokens: {tokens}")

    if check_numeric(first_token):
        return first_token
    elif first_token == "state.time":
        return "state.time"
    elif first_token == '#t':
        return "constants.DELTA_T"
    elif first_token == 'or':
        expr = " or ".join(translate_expression(t) for t in tokens[1:])
        return "({})".format(expr)
    elif first_token == 'and':
        expr = " and ".join(translate_expression(t) for t in tokens[1:])
        return "({})".format(expr)
    elif first_token == 'not':
        return '(not {})'.format(translate_expression(tokens[1]))
    elif first_token in ['=', '>=', '<=', '>', '<']:
        first_token = '==' if first_token == '=' else first_token
        return "(fast_round({}, constants.NUMBER_PRECISION) {} fast_round({}, constants.NUMBER_PRECISION))". \
            format(translate_expression(tokens[1]), first_token, translate_expression(tokens[2]))
    elif first_token in ['+', '-', '*', '/']:
        return "fast_round({} {} {}, constants.NUMBER_PRECISION)". \
            format(translate_expression(tokens[1]), first_token, translate_expression(tokens[2]))
    elif first_token == '^':
        return "fast_round(pow({},{}), constants.NUMBER_PRECISION)". \
            format(translate_expression(tokens[1]), translate_expression(tokens[2]))
    # elif first_token == 'atan2':
    #     return "fast_round(math.atan2({},{}), constants.NUMBER_PRECISION)". \
    #         format(translate_expression(tokens[1]), translate_expression(tokens[2]))
    # elif first_token == 'sin':
    #     return "fast_round(math.sin({}), constants.NUMBER_PRECISION)". \
    #         format(translate_expression(tokens[1]))
    # elif first_token == 'cos':
    #     return "fast_round(math.cos({}), constants.NUMBER_PRECISION)". \
    #         format(translate_expression(tokens[1]))

    ### Allows use of python-math library directly in the PDDL domain.
    ### Usage: (@<func> param1) or (@<func> param1 param2) - currently only unary and binary functions are allowed.
    elif first_token.startswith("@"):
        if len(tokens) == 2:
            return "fast_round(math.{}({}), constants.NUMBER_PRECISION)". \
            format(first_token[1:], translate_expression(tokens[1]))
        elif len(tokens) == 3:
            return "fast_round(math.{}({},{}), constants.NUMBER_PRECISION)". \
            format(first_token[1:], translate_expression(tokens[1]), translate_expression(tokens[2]))
        else:
            raise Exception("Only unary and binary python math functions allowed.")
    else:
        # defer resolution to state
        return state_var(tokens)


def translate_statement(tokens):
    first_token = tokens[0] if isinstance(tokens, list) else tokens

    state_operators = {'assign': '=',
                       'increase': '+',
                       'decrease': '-',
                       'scale-up': '*',
                       'scale-down': '/'}

    if check_numeric(first_token):
        return first_token
    elif first_token in ['+', '-', '*', '/', '^', '=', '>=', '<=', '>', '<', '#t', 'sin', 'cos', 'atan2']:
        return translate_expression(tokens)
    elif first_token in state_operators.keys():
        if first_token == 'assign':
            return "{} {} fast_round({}, constants.NUMBER_PRECISION)". \
                format(state_var(tokens[1]), state_operators[first_token], translate_expression(tokens[2]))
        return "{} = fast_round({} {} {}, constants.NUMBER_PRECISION)". \
            format(state_var(tokens[1]), state_var(tokens[1]), state_operators[first_token], translate_expression(tokens[2]))
    elif first_token == 'not':
        return "{} = False".format(state_var(tokens[1]))
    else:
        return "{} = True".format(state_var(tokens))
