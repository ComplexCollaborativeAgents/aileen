# from PDDL import PDDL_Parser
from toolz import cons

from planner import Planner
import pprint
import csv
import matplotlib.pyplot as plt
from matplotlib import style
import syntax.constants as constants
import sys
import time
import os, shutil
from datetime import datetime
import gc
sys.dont_write_bytecode = True

def process_config_file(config_file):

    cf_arguments = []

    with open(config_file,'r') as cf:
        for i, line in enumerate(cf):

            # print(str(i) + " =====> " + str(line))

            line = line.lower()
            line = line.replace("\t", "")
            line = line.replace("\n", "")
            line = line.replace(" ", "")
            if line.startswith('[') or line.startswith(';') or line.startswith('#') or line == '':
                continue
            if line.endswith(':true'):
                line = line.split(':')[0]
            if line.endswith('=true'):
                line = line.split('=')[0]

            cf_arguments.append(line)

        print(cf_arguments)
        process_arguments(cf_arguments)

def process_arguments(cl_arguments):

    for arg in cl_arguments:

        if 'config:' not in arg:
            arg = arg.lower()

        if arg.startswith('-'):
            arg = arg[1:]

        if arg == 'h' or arg == 'help':
            print(constants.HELP_TEXT)
            exit(1)
        elif arg == 'val' or arg == 'validate':
            constants.VALIDATE = True
            continue
        elif arg == 'p' or arg == 'print_states':
            constants.PRINT_ALL_STATES = True
            continue
        elif arg == 'noplan':
            constants.NO_PLAN = True
            continue
        elif arg == 'allplans':
            constants.ALL_PLANS = True
            continue
        elif arg == 'vv' or arg == 'very_verbose':
            constants.VERY_VERBOSE_OUTPUT = True
            continue
        elif arg == 'v' or arg == 'verbose':
            constants.VERBOSE_OUTPUT = True
            continue
        elif arg == 'dblevent' or arg == 'double_event':
            constants.DOUBLE_EVENT_CHECK = True
            continue
        elif arg == 'at' or arg == 'anytime':
            constants.ANYTIME = True
            continue
        elif arg == 'pt' or arg == 'precondition_tree':
            constants.PRECONDITION_TREE = True
            continue
        elif arg == 'tv' or arg == 'track_variables':
            constants.TRACK_VARIABLES = True
            constants.VERY_VERBOSE_OUTPUT = True
            continue
        elif arg == 'plot':
            constants.PLOT_TRACKED_VARIABLES = True
            constants.VERY_VERBOSE_OUTPUT = True
            continue

        arg_list = arg.split(':')
        if len(arg_list)==1:
            arg_list = arg.split('=')

        if arg_list[0] == 'config':
            constants.CONFIG_FILE = arg_list[1]
            process_config_file(constants.CONFIG_FILE)
            break

        elif arg_list[0] == 'np' or arg_list[0] == 'number_precision':
            constants.NUMBER_PRECISION = int(arg_list[1])
        elif arg_list[0] == 'at' or arg_list[0] == 'anytime':
            constants.ANYTIME = True
            constants.TRACKED_PLANS = int(arg_list[1])
        elif arg_list[0] == 'th' or arg_list[0] == 'temporal_horizon':
            constants.TIME_HORIZON = float(arg_list[1])
        elif arg_list[0] == 'pi' or arg_list[0] == 'print_info':
            constants.PRINT_INFO = float(arg_list[1])
        elif arg_list[0] == 'to' or arg_list[0] == 'timeout':
            constants.TIMEOUT = float(arg_list[1])
        elif arg_list[0] == 't':
            constants.DELTA_T = round(float(arg_list[1]), constants.NUMBER_PRECISION)
            constants.TIME_PASSING_ACTION.duration = round(constants.DELTA_T, constants.NUMBER_PRECISION)
        elif arg_list[0] == 'tv' or arg_list[0] == 'track_variables':
            constants.TRACK_VARIABLES = True
            constants.TRACKED_VARIABLES_LIST = arg_list[1].replace('[','').replace(']','').split(',')
            constants.VERY_VERBOSE_OUTPUT = True
        elif arg_list[0] == 'plot':
            if arg_list[1] == 'num' or arg_list[1] == 'numeric':
                constants.PLOT_NUMERIC = True
                constants.PLOT_BOOLEAN = False
                constants.PLOT_TRACKED_VARIABLES = True
                constants.VERY_VERBOSE_OUTPUT = True
            elif arg_list[1] == 'bool' or arg_list[1] == 'boolean':
                constants.PLOT_BOOLEAN = True
                constants.PLOT_NUMERIC = False
                constants.PLOT_TRACKED_VARIABLES = True
                constants.VERY_VERBOSE_OUTPUT = True
            elif arg_list[1] == 'log':
                constants.PLOT_LOG = True
                constants.PLOT_NUMERIC = True
                constants.PLOT_TRACKED_VARIABLES = True
                constants.VERY_VERBOSE_OUTPUT = True
            else:
                print('\nERROR: Unrecognized Plotting Argument\nCall with -h flag for help')
                exit(1)

        elif arg_list[0] == 'dl'or arg_list[0] == 'depth_limit':
            constants.DEPTH_LIMIT = float(arg_list[1])
        elif arg_list[0] == 'sa' or arg_list[0] == 'semantic_attachment':
            constants.SEMANTIC_ATTACHMENT = True
            constants.SEMANTIC_ATTACHMENT_ID = float(arg_list[1])
        elif arg_list[0] == 'custom_h' or arg_list[0] == 'custom_heuristic':
            constants.CUSTOM_HEURISTIC_ID = float(arg_list[1])
        elif arg_list[0] == 'search':
            constants.SEARCH_BFS = False
            if arg_list[1] == 'bfs':
                constants.SEARCH_BFS = True
                constants.SEARCH_ALGO_TXT = "BFS"
            elif arg_list[1] == 'dfs':
                constants.SEARCH_DFS = True
                constants.SEARCH_ALGO_TXT = "DFS"
            elif arg_list[1] == 'gbfs':
                constants.SEARCH_GBFS = True
                constants.SEARCH_ALGO_TXT = "GBFS"
            elif arg_list[1] == 'a_star':
                constants.SEARCH_ASTAR = True
                constants.TRACK_G = True
                constants.SEARCH_ALGO_TXT = "A*"
            else:
                print('\nERROR: Unrecognized Heuristic Argument\nCall with -h flag for help')
                exit(1)

        else:
            print('\nERROR: Unrecognized Argument: {}\nCall with -h flag for help'.format(arg))
            exit(1)

def print_config(dom, prob):
    config_string = '\n\n===== NYX Planning Configuration ================\n' \
        '\n\t* domain: ' + str(dom) + \
        '\n\t* problem: ' + str(prob) + \
        '\n\t* config file: ' + str(constants.CONFIG_FILE) + \
        '\n\t* search algorithm: ' + str(constants.SEARCH_ALGO_TXT) + \
        '\n\t* time discretisation: ' + str(constants.DELTA_T) + \
        '\n\t* time horizon: ' + str(constants.TIME_HORIZON) + \
        '\n\t* depth limit: ' + str(constants.DEPTH_LIMIT) + \
        '\n\t* timeout: ' + str(constants.TIMEOUT) + 's' \
        '\n'
    print(config_string)

def print_solution_info(goal_st, plnr, sg_time, ttime):

    non_temporal_count = 0
    pln = plnr.get_trajectory(goal_st)

    for pai in pln:
        if not pai[0] == constants.TIME_PASSING_ACTION:
            non_temporal_count += 1

    config_string = '\n===== Solution Info =============================\n' \
        '\n\t* time: ' + str(round(ttime,3)) + \
        '\n\t* explored states: ' + str(plnr.explored_states) + \
        '\n\t* plan length: ' + str(non_temporal_count) + ' (' + str(len(pln)) + ')' + \
        '\n\t* plan duration: ' + str(sg_time) + \
        '\n\t* plan metric: {:6.3f}'.format(goal_st.metric)
    print(config_string)


def runner(dom_file, prob_file, args_list: []):
    start_time = time.time()
    domain = dom_file
    problem = prob_file
    # plan_file = os.path.dirname(prob_file) + "/plan_" + os.path.basename(prob_file)

    process_arguments(args_list)

    print_config(domain, problem)

    my_plnr = Planner()

    if constants.PRECONDITION_TREE:
        goal_state = my_plnr.solve_pt(domain, problem)
    else:
        goal_state = my_plnr.solve(domain, problem)

    total_time = time.time() - start_time

    if not my_plnr.reached_goal_states:
        print('\n=================================================\n')
        print('\tNo Plan Found!')
        print('\t\tTime: ' + str(round(total_time,3)))
        print('\t\tStates Explored: ' + str(my_plnr.explored_states))
        print('\n=================================================\n')
    else:
        count_gs = 1
        print("\n")
        print('\n=================================================\n')

        if (constants.TRACK_VARIABLES or constants.PLOT_TRACKED_VARIABLES) and constants.TRACKED_VARIABLES_LIST == []:
            constants.TRACKED_VARIABLES_LIST = list(my_plnr.reached_goal_states[0].state.state_vars.keys())
            constants.TRACKED_VARIABLES_LIST = [s.replace("[","").replace("]","").replace("'","").replace(",","") for s in constants.TRACKED_VARIABLES_LIST]

        for sg in my_plnr.reached_goal_states:
            plan_path = os.path.dirname(prob_file) + "/plans/"
            if not os.path.exists(plan_path):
                os.makedirs(plan_path)
            one_plan_file = plan_path + "plan" + str(count_gs) + "_" + os.path.basename(prob_file)
            # my_plan = my_plnr.get_trajectory(sg)
            if not constants.NO_PLAN:
                print_solution_info(sg.state, my_plnr, sg.state.time, total_time)
            process_goal(my_plnr.get_trajectory(sg.state), my_plnr, one_plan_file)

            if constants.TRACK_VARIABLES or constants.PLOT_TRACKED_VARIABLES:
                extract_variable_values(one_plan_file, constants.TRACKED_VARIABLES_LIST, os.path.splitext(one_plan_file)[0]+"_tracked_vars")


            if not constants.ALL_PLANS:
                break
            count_gs += 1

        # summary of search
        print('\n=================================================\n')
        print('\n===== Search Summary ============================\n')
        print('\t\tTime: ' + str(round(total_time, 3)))
        print('\t\tStates Explored: ' + str(my_plnr.explored_states))
        print('\t\tGoals Reached: ' + str(len(my_plnr.reached_goal_states)))
        print('\t\tBest Plan Metric: {:6.3f}'.format(my_plnr.reached_goal_states[0].state.metric))
        print('\n=================================================\n')

    del my_plnr
    gc.collect()

def process_goal(plan_obj, planner_obj, plan_save_file):

    if not constants.NO_PLAN:
        print('\n===== Plan ======================================')
        print('\tPlan File: ' + str(plan_save_file) + '\n')

    count = 0

    # if constants.VERY_VERBOSE_OUTPUT and not constants.NO_PLAN:
    #     print('\nInitial State:')
    #     print(planner_obj.initial_state)
    #     print('')


    open(plan_save_file, 'w').close()

    plan_f = open(plan_save_file, 'a')

    if constants.VERY_VERBOSE_OUTPUT:
        plan_f.write(str(planner_obj.initial_state) + "\n")


    for pair in plan_obj:

        if (not (constants.VERBOSE_OUTPUT or constants.VERY_VERBOSE_OUTPUT)) and pair[0] == constants.TIME_PASSING_ACTION:
            continue

        str1 = '' + str("{:10.3f}".format(planner_obj.visited_hashmap[pair[1].predecessor_hashed].state.time)) + ':\t' + str(pair[0].name)
        str2 = str(pair[0].parameters).replace('\'', '').replace(',)',')') if pair[0].parameters else ''
        str3 = '\t[' + str(pair[0].duration) + ']'

        if not constants.NO_PLAN:
            print(str1, end='')
            print(str2, end='')
            print(str3)

        plan_f.write(str1 + str2.replace(',','').replace('(',' ').replace(')','') + str3 + '\n')

        if constants.VERY_VERBOSE_OUTPUT:
            # if not constants.NO_PLAN:
            #     print(str(pair[1]) + '\n')
            plan_f.write(str(pair[1]) + '\n')
        count += 1
    if not constants.NO_PLAN:
        print('\n=================================================\n')

    plan_f.close()


def extract_variable_values(plan_f, var_list, csv_f=None):

    if type(var_list) is str:
        var_list = var_list.replace('[','').replace(']','').split(',')
        var_list = [s.strip() for s in var_list]
    elif type(var_list) is list:
        var_list = [s.strip() for s in var_list]
        pass
    else:
        print('\n\nerror: unable to parse tracked variables list: {}. skipping...\n'.format(var_list))


    vv_plan_file = plan_f
    csv_file = csv_f+".csv"
    png_file = csv_f+".png"
    tracked_vars = var_list

    lines_list = open(vv_plan_file).readlines()

    state_trajectory = {}

    with open(vv_plan_file) as plan_trace_file:

        for i, line in enumerate(plan_trace_file):

            if "state:" in line:

                cur_state_bools = {}
                cur_state_nums = {}

                time_of_state = float(lines_list[i+1].split("time: ")[1])
                next_init_line = lines_list[i+5]
                next_init_line = next_init_line.split(": [")[1]

                next_init_line = next_init_line.replace("]]", "")
                next_init_line = next_init_line.replace("\t", "")
                next_init_line = next_init_line.replace("\n", "")
                next_init_line = next_init_line.replace("[", "")
                next_init_line = next_init_line.replace("'", "")
                next_init_line = next_init_line.replace("]\", ",":")
                next_init_line = next_init_line.replace("\"", "")
                next_init_line = next_init_line.replace(",", "")

                next_init_dict = next_init_line.split("] ")

                for el in next_init_dict:
                    v = el.split(":")
                    if v[1] == "True":
                        cur_state_bools[v[0]] = True
                    elif v[1] == "False":
                        cur_state_bools[v[0]] = False
                    else:
                        cur_state_nums[v[0]] = float(v[1])

                if i==0:
                    state_trajectory['init'] = {**cur_state_nums, **cur_state_bools}
                    continue

                state_trajectory[time_of_state] = {**cur_state_nums, **cur_state_bools}

    return_trajectory = {'time':[]}
    for tv in tracked_vars:
        return_trajectory[tv] = []

    for t,s in state_trajectory.items():
        return_trajectory['time'].append(t)
        for tv in tracked_vars:
            return_trajectory[tv].append(s[tv])

    csv_vars = []

    for n,v in return_trajectory.items():
        csv_vars.append(n)

    csv_rows_untransposed = []
    for name,vals in return_trajectory.items():
        csv_rows_untransposed.append(vals)

    csv_rows = [list(x) for x in zip(*csv_rows_untransposed)] # transpose the tracked values matrix

    # pprint.pprint(csv_vars)
    # pprint.pprint(csv_rows)

    if constants.TRACK_VARIABLES and csv_file is not None:

        with open(csv_file, 'w') as csv_f:
            write = csv.writer(csv_f)
            write.writerow(csv_vars)
            write.writerows(csv_rows)
            print("Tracked variables saved to {}".format(csv_file))

    if constants.PLOT_TRACKED_VARIABLES:

        # style for plotting line
        # print(plt.style.available)
        # plt.style.use("ggplot")
        plt.style.use("seaborn")
        # plt.style.use("seaborn-darkgrid")
        # plt.style.use("seaborn-paper")
        # plt.style.use("Solarize_Light2")
        # plt.style.use("grayscale")

        # subplots() function you can draw
        # multiple plots in one figure
        fig, axes = plt.subplots(nrows=1, ncols=1, figsize=(10, 5))
        plt.tight_layout(pad=2.0)

        axes.set_xlabel('time')
        



        if constants.PLOT_LOG:
            plt.yscale("log")
        
        for i in range(1,len(csv_rows_untransposed)):

            if constants.PLOT_NUMERIC and (type(csv_rows_untransposed[i][0]) is bool):
                continue
            if constants.PLOT_BOOLEAN and not (type(csv_rows_untransposed[i][0]) is bool):
                continue

            if (type(csv_rows_untransposed[i][0]) is bool) and not constants.PLOT_BOOLEAN:
                axes.plot(csv_rows_untransposed[0], csv_rows_untransposed[i], linestyle='--', label=csv_vars[i])
            else:
                axes.plot(csv_rows_untransposed[0], csv_rows_untransposed[i], label=csv_vars[i])

        plt.legend()
        # plt.show()
        plt.savefig(png_file)

#-----------------------------------------------
# Main
#-----------------------------------------------
if __name__ == '__main__':

     

    if len(sys.argv) < 3 or '-h' in sys.argv:
        print(constants.HELP_TEXT)
        exit(1)

    runner(sys.argv[1], sys.argv[2], sys.argv[3:])

