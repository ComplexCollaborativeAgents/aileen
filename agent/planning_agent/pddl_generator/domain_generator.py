from agent.planning_agent.pddl_generator.base_generator import BaseGenerator, PDDLDomain
from agent.environment_model.actions import TeleportAction, PickObjectAction, PutObjectAction, PutInsideObjectAction, OpenObjectAction, CloseObjectAction
#from agent.environment_model.events import NearEvent, RemoveNearEvent
from agent.environment_model.state_definition import EnvironmentState
from agent.environment_model.state_parser import ThorStateParser

class PDDLDomainGenerator(BaseGenerator):
    def __init__(self, _path: str,  name: str):
        super().__init__(_path, name)
        self.predicates = list()
        self.functions = list()
        self.actions = list()
        self.events = list()
        self.environment = EnvironmentState()
        self.prune_objects = True
        self.obj_ids = list()


    def generate(self, world_server, _current_state, _required_objects = list()):
        # there are no processes so not creating that
        self.parser = ThorStateParser(world_server)
        self.objects = self.choose_objects_from_type(_current_state, _required_objects)
        domain = PDDLDomain(self.name)
        domain.set_requirements([":negative-preconditions", ":typing"])
        domain.set_types({"object": ["cell", "interactable"]})
        self.create_predicates()
        #self.create_functions()
        self.create_actions(_current_state)
        #self.create_events(_current_state)

        domain.set_predicates(self.predicates)
        domain.set_functions(self.functions)
        domain.set_actions(self.actions)
        #domain.set_events(self.events)
        domain.write_to_file(self.path)

        return domain

    def choose_objects_from_type(self, _current_state, _required_objects):
        obj_ids = list()
        types_added = set()
        if self.prune_objects and len(_required_objects) > 0:
            objects = self.parser.get_object_ids_by_type(_current_state)

            for _type in objects.keys():
                for r_obj in _required_objects:
                    if _type in r_obj.lower() and _type not in types_added:
                        obj_ids.extend(objects[_type])
                        types_added.add(_type)

        else:
            self.prune_objects = False

        self.obj_ids = obj_ids

    def create_predicates(self):
        self.environment.set_predicates()

        for _, predicate in self.environment.predicates.items():
            self.predicates.append(predicate)

    def create_functions(self):
        self.environment.set_functions()

        for _, fun in self.environment.functions.items():
            self.functions.append(fun)


    def create_actions(self, _current_state):
        teleport = self.create_teleport_action()
        pick = self.create_pick_actions(_current_state)
        put = self.create_put_actions(_current_state)
        put_inside = self.create_put_inside_actions(_current_state)
        _open = self.create_open_actions(_current_state)
        _close = self.create_close_actions(_current_state)
        # cook etc will be added here in future
        [self.actions.extend(a) for a in (teleport, pick, put, put_inside, _open, _close)]

    #def create_events(self, current_state):
    #    near = self.create_near_event(self, current_state)
    #    remove_near = self.create_remove_near_event(self, current_state)

    #    [self.events.extend(a) for a in (near, remove_near)]


    def create_teleport_action(self):
        action = TeleportAction()
        return [action]

    def prune_list_objects(self, all_objects):
        objects = list()
        if self.prune_objects:
            for obj_id in self.obj_ids:
                if obj_id in all_objects:
                    objects.append(obj_id)
        else:
            objects = all_objects

        return objects

    def create_pick_actions(self, _current_state):
        all_objects = self.parser.get_pickable_object_ids(_current_state)
        objects = self.prune_list_objects(all_objects)

        actions = list()

        for obj_id in objects:
            action = PickObjectAction(obj_id)
            actions.append(action)

        return actions


    def create_put_actions(self, _current_state):
        all_objects = self.parser.get_pickable_object_ids(_current_state)
        objects = self.prune_list_objects(all_objects)
        actions = list()

        for obj_id in objects:
            action = PutObjectAction(obj_id)
            actions.append(action)

        return actions

    def create_put_inside_actions(self, _current_state):
        all_objects = self.parser.get_receptacle_object_ids(_current_state)
        objects = self.prune_list_objects(all_objects)
        actions = list()

        for obj_id in objects:
            # object1 will be grounded by the domain
            action = PutInsideObjectAction("", obj_id)
            actions.append(action)

        return actions

    def create_open_actions(self, _current_state):
        all_objects = self.parser.get_openable_object_ids(_current_state)
        objects = self.prune_list_objects(all_objects)
        actions = list()

        for obj_id in objects:
            action = OpenObjectAction(obj_id)
            actions.append(action)

        return actions


    def create_close_actions(self, _current_state):
        all_objects = self.parser.get_openable_object_ids(_current_state)
        objects = self.prune_list_objects(all_objects)
        actions = list()

        for obj_id in objects:
            action = CloseObjectAction(obj_id)
            actions.append(action)

        return actions

    #def create_near_event(self):
    #    event = NearEvent()
    #    return [event]


    #def create_remove_near_event(self):
    #    event = RemoveNearEvent()
    #    return [event]


