from typing import List, Dict, Union


class Predicate():
    def __init__(self, _name: str , _props: List[str]):
        self.print_name = _name
        self.name = _name.lower() # adding because the name in the nyx are lower cased
        self.properties = _props

    
    def get_predicate(self):
        return self.__str__()

    
    def __str__(self):
        properties = ""
        for prop in self.properties:
            properties += "?" + prop + " "

        return f"({self.name} {properties.strip()})"


class DomainPredicate(Predicate):
    def __init__(self, _name: str, _props: List[str],  _lifted_props: Dict[str, Union[str, List[str]]]):
        super().__init__(_name, _props)
        self.print_name = _name
        self.name = _name.lower()
        self.properties = _props
        self.lifted_variables = _lifted_props


    def get_predicate(self):
        return super().__str__()


    def __str__(self):
        prop_string = ""
        for prop in self.properties:
            if isinstance(self.lifted_variables[prop], list):
                temp = ""
                for p in self.lifted_variables[prop]:
                    temp += f" ?{p}"
            else:
                temp = f"?{self.lifted_variables[prop]}"

            prop_string += f"{temp.strip()} - {prop}"

        return f"({self.name} {prop_string})"


class GroundedPredicate(Predicate):
    def __init__(self, _name: str, _props: List[str], _values: Dict[str, Union[float, str, Predicate]], is_numeric = False, is_not = False, symbol: str = "="):
        super().__init__(_name, _props)
        self.values = _values
        self.is_numeric = is_numeric
        self.is_negation = is_not
        self.symbol = symbol

    
    def get_predicate(self):
        return super().__str__()

    
    def __str__(self):
        predicate = ""
        fin_predicate = ""
        prop_string = ""
        if self.is_numeric:
            temp = GroundedPredicate(self.name, self.properties, self.values, False, False)
            fin_predicate = f"({self.symbol} {temp} {self.values[self.name]})"
        else:
            for p in self.properties:
                val = self.values[p]
                if isinstance(val, list):
                    prop_string += " " + " ".join(val)
                else:
                    prop_string += " " + val

            predicate = f"({self.name} {prop_string.strip()}"
            predicate = predicate.strip()
            predicate += ")"

        if self.is_negation:
            fin_predicate = f"(not ({predicate}))"

        return fin_predicate

class State():
    def __init__(self):
        self.predicates = list()
        self.functions = list()
        self.grounded_predicates = set()
        self.grounded_functions = set()


    def ground(self, predicate: Predicate, values: Dict[str, Union[float, str]], is_numberic: bool = False, is_not: bool = False) -> GroundedPredicate:
        p = GroundedPredicate(predicate.name, values, predicate.properties, is_numberic, is_not)
        self.grounded_predicates.push(p)

        return p


    def get_value(self, predicate: GroundedPredicate):
        if predicate.is_numeric:
            if predicate in self.grounded_functions:
                return predicate.values[predicate.name]
            else:
                return None
        else:
            if predicate.grounded_predicates:
                return True
            else:
                return False


class EnvironmentState(State):
    def __init__(self):
        super().__init__()
        self.predicates = dict()
        self.functions = dict()
        self.set_predicates()
        self.set_functions()


    def set_predicates(self):
        cell_properties = [
            "reachable"
        ]

        object_properties = [
            "receptacle",
            "interactable",
            "toggleable",
            "breakable",
            "fillable",
            "cookable",
            "sliceable",
            "openable",
            "pickable",
            "moveable",
            "holdable"
        ]

        for prop in cell_properties:
            name = "is_" + prop
            p = DomainPredicate(name, ["cell"], {"cell": "c"})
            self.predicates[prop] = p

        for prop in object_properties:
            name = "is_" + prop
            p = DomainPredicate(name, ["interactable"], {"interactable": "p"})
            self.predicates[prop] = p

        near = DomainPredicate("is_near", ["cell"], {"cell": "c"})
        self.predicates["near"] = near

        location = DomainPredicate("location", ["cell", "interactable"], {"cell": "c", "interactable": "p"})
        self.predicates["location"] = location

        holding = DomainPredicate("holding", ["interactable"], {"interactable": "p"})
        self.predicates["holding"] = holding

        opened = DomainPredicate("opened", ["interactable"], {"interactable": "p"})
        self.predicates["opened"] = opened

        _in = DomainPredicate("in", ["interactable"], {"interactable": ["p1", "p2"]})
        self.predicates["in"] = _in

        _on = DomainPredicate("on", ["interactable"], {"interactable": ["p1", "p2"]})
        self.predicates["on"] = _on

        closed = DomainPredicate("closed", ["interactable"], {"interactable": "p"})
        self.predicates["closed"] = closed


    def set_functions(self):
        rob_x = DomainPredicate("robot_x", [], {})
        self.functions["robot_x"] = rob_x

        rob_y = DomainPredicate("robot_y", [], {})
        self.functions["robot_y"] = rob_y

        rob_z = DomainPredicate("robot_z", [], {})
        self.functions["robot_z"] = rob_z

        prev_x = DomainPredicate("prev_robot_x" ,[], {})
        self.functions["prev_robot_x"] = prev_x

        prev_y = DomainPredicate("prev_robot_y", [], {})
        self.functions["prev_robot_y"] = prev_y

        prev_z = DomainPredicate("prev_robot_z", [], {})
        self.functions["prev_robot_z"] = prev_z

        cell_x = DomainPredicate("cell_x", ["cell"], {"cell": "c"})
        self.functions["cell_x"] = cell_x

        cell_y = DomainPredicate("cell_y", ["cell"], {"cell": "c"})
        self.functions["cell_y"] = cell_y

        cell_z = DomainPredicate("cell_z", ["cell"], {"cell": "c"})
        self.functions["cell_z"] = cell_z

        location_x = DomainPredicate("location_x", ["interactable"], {"interactable": "p"})
        self.functions["location_x"] = location_x

        location_y = DomainPredicate("location_y", ["interactable"], {"interactable": "p"})
        self.functions["location_y"] = location_y

        location_z = DomainPredicate("location_z", ["interactable"], {"interactable": "p"})
        self.functions["location_z"] = location_z
