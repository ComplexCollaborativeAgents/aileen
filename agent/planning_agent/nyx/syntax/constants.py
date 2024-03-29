#!/usr/bin/env python

from syntax.action import Action
from numba import njit, float64


# -----------------------------------------------
# NYX Global Variables
# -----------------------------------------------

TIME_PASSING_ACTION = Action('advance-time', [], [], [], happening_type="advance-time")

# -----------------------------------------------
# NYX CommandLine Arguments
# -----------------------------------------------

CONFIG_FILE = None

DELTA_T = 0.1
TEMPORAL_DOMAIN = False
VERBOSE_OUTPUT = False
VERY_VERBOSE_OUTPUT = False
TIME_HORIZON = 1000
TIMEOUT = 1800
NUMBER_PRECISION = 10
DEPTH_LIMIT = 1000
PRINT_INFO = 10000
NO_PLAN = False
ALL_PLANS = False
DOUBLE_EVENT_CHECK = False
PLOT_VARS = True
SEMANTIC_ATTACHMENT = False
SEMANTIC_ATTACHMENT_ID = 0
ANYTIME = False
TRACKED_PLANS = 10
METRIC_MINIMIZE = True
CONTAINS_TIL_TIF = False

SEARCH_BFS = True
SEARCH_DFS = False
SEARCH_GBFS = False
SEARCH_ASTAR = False

PRECONDITION_TREE = False

CUSTOM_HEURISTIC_ID = 0

TRACK_G = False

SEARCH_ALGO_TXT = "BFS"

VALIDATE = False
PRINT_ALL_STATES = False

TRACK_VARIABLES = False
TRACKED_VARIABLES_LIST = []
PLOT_TRACKED_VARIABLES = False
PLOT_NUMERIC = False
PLOT_BOOLEAN = False
PLOT_LOG = False

EXPAND_TIME_PASSING = False
FULL_TRACE = False


@njit(float64(float64, float64),fastmath=True)
def fast_round(some_float, np):
    # fast_round 1
    return round(some_float, np)

def set_delta_t(delta_t: float):
    global DELTA_T
    DELTA_T = delta_t
    TIME_PASSING_ACTION.duration = DELTA_T

# -----------------------------------------------
# NYX CommandLine Arguments
# -----------------------------------------------

HELP_TEXT = "\n" \
            "\n===========================================================================\n\n" \
            "Nyx Release v0.1\n" \
            "PDDL+ Planner for Hybrid Domains\n" \
            "\n" \
            "Contact: Wiktor Piotrowski - wiktorpi@parc.com\n" \
            "" \
            "\n===========================================================================\n" \
            "\n\tNyx usage:\tpython nyx.py <domain_file.pddl> <problem_file.pddl> <option1> <option2> ...\n" \
            "\n\texample:\tpython nyx.py ex/car/car.pddl ex/car/pb01.pddl -t:1 -v -search:bfs -pi:1000" \
            "\n\texample:\tpython nyx.py ex/car/car.pddl ex/car/pb01.pddl -config:ex/car/car.config\n" \
            "\n===========================================================================\n" \
            "\n\tCOMMAND-LINE OPTIONS:\n" \
            "\n\t-h\t\thelp." \
            "\n\t-config:<file>\tspecify config file containing all planner options." \
            "\n\t-t:<x>\t\ttime step duration (default t=0.1)." \
            "\n\t-th:<x>\t\ttime horizon (default th=1000)." \
            "\n\t-to:<x>\t\ttimeout limit in seconds (default to=1800)." \
            "\n\t-dl:<x>\t\tdepth limit in actions (default dl=1000)." \
            "\n\t-np:<x>\t\tnumber precision in digits after decimal point (default np=10)." \
            "\n\t-sa:<x>\t\tspecify semantic attachment ID (default sa=0)." \
            "\n\t-pt\t\tuse precondition tree instead of an array to store preconditions." \
            "\n\t-dblevent\tcheck triggered events again at the end of time-passing action" \
            "\n\t\t\t(in addition to the default check at the beginning)." \
            "\n\t-search:bfs\tsearch algorithm: breadth-first search (default)." \
            "\n\t-search:dfs\tsearch algorithm: depth-first search." \
            "\n\t-search:gbfs\tsearch algorithm: greedy best-first search." \
            "\n\t-search:a_star\tsearch algorithm: A*." \
            "\n\t-custom_h:<x>\tuse a custom heuristic."\
            "\n\t\t\t<x> is the index of heuristic estimate code defined in heuristic_functions.py." \
            "\n\t-at:<x>\t\tuse anytime search algorithm, store <x> best encountered plans (default = 10)" \
            "\n\t\t\t(anytime search will terminate at -to timeout, default=1800 seconds)." \
            "\n\t-noplan\t\tdo not print the plan." \
            "\n\t-allplans\tprint all found plans (when using anytime algorithm)" \
            "\n\t-pi:<x>\t\tprint ongoing search info every <x> visited states (default pi=10000)." \
            "\n\t-p\t\tprint all visited states." \
            "\n\t-v\t\tverbose plan output (in console and saved to file)." \
            "\n\t-vv\t\tvery verbose plan saved to plan file (verbose output in console)." \
            "\n\t-tv\t\ttrack all state variables throughout the plan (save to CSV)." \
            "\n\t\t\tforces very verbose output." \
            "\n\t-tv:<x>\t\ttrack state variables specified in list <x> throughout the plan (save to CSV)." \
            "\n\t\t\tforces very verbose output." \
            "\n\t-plot\t\tplot tracked state variables values over time" \
            "\n\t\t\t(plots all state variables by default unless set with -tv:<x> flag)." \
            "\n\t-plot:num\t\tplot numeric functions only." \
            "\n\t-plot:bool\t\tplot boolean predicates only." \
            "\n\t-plot:log\t\tplot on a logarithmic Y scale." \
            "\n\n===========================================================================\n" \
            "\n\tCURRENTLY IMPLEMENTED SPECIAL DOMAIN OPERATORS: \n" \
            "\n\t(^ (x) (y))\t\tpower operator, i.e., x**y (can be used with fractions for roots)." \
            "\n\t(sin(x))\t\tsine function (input in radians)." \
            "\n\t(cos(x))\t\tcosine function (input in radians)." \
            "\n\t(atan2 (y) (x))\t\treturns the arc tangent of y/x, in radians." \
            "\n\t\t\t\tx and y are the coordinates of a point (x,y)." \
            "\n\t\t\t\texample: (assign (angle_between_points) (atan2 (- (y ?p2) (y ?p1)) (- (x ?p2) (x ?p1))))" \
            "\n\n===========================================================================\n" \
            "\n\n"

            # "\n\t-val\t\tuse VAL a posteriori to validate results." \


SIMULATOR_HELP = "\n" \
                 "\n===========================================================================\n\n" \
                 "Nyx Release v0.1\n" \
                 "PDDL+ Plan Simulator for Hybrid Domains\n" \
                 "\n" \
                 "Contact: Wiktor Piotrowski - wiktorpi@parc.com\n" \
                 "" \
                 "\n===========================================================================\n" \
                 "\n\tCOMMAND-LINE OPTIONS:\n" \
                 "\n\t-h\t\thelp." \
                 "\n\t-t:<x>\t\ttime step duration (default t=0.1)." \
                 "\n\t-e\t\tinsert time-passing actions between two plan steps if start times differ." \
                 "\n\t-f\t\tfull trace (include states generated by processes and events)." \
                 "\n\t-dblevent\tcheck triggered events again at the end of time-passing action (in addition to the default check at the beginning)." \
                 "\n\t-v\t\tverbose trace output." \
                 "\n\t-vv\t\tvery verbose trace output." \
                 "\n\n===========================================================================\n" \
                 "\n\n"
