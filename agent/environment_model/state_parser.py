import logging, coloredlogs

class ThorStateParser:
    def __init__(self, _server):
        self.world_server = _server
        self._logger = logging.getLogger(__name__)
        coloredlogs.install(level='DEBUG', logger = self._logger)

    def get_objects(self, _event=None):
        if _event is None:
            _event = self.world_server.get_recent_event()

        objects = _event["objects"]
        return objects

    def get_object_ids(self, _event=None):
        objects = self.get_objects(_event)

        object_IDs = list()

        for obj in objects:
            object_IDs.append(obj["objectId"])

        return object_IDs

    def get_object(self, objectID, _event=None):
        objects = self.get_objects(_event)

        for obj in objects:
            if objectID == obj["objectId"]:
                return obj

        return None

    def get_object_ids_by_type(self, _event=None):
        objects = self.get_objects(_event)
        obj_ids_type = dict()

        for obj in objects:
            _type = obj["objectType"]
            if _type not in obj_ids_type:
                obj_ids_type[_type] = list()

            obj_ids_type[_type].append(obj["objectId"])

        return obj_ids_type


    def get_pickable_object_ids(self, _event=None):
        objects = self.get_objects(_event)
        pickupable_IDs = list()

        for obj in objects:
            if obj["pickupable"]:
                pickupable_IDs.append(obj["objectId"])

        return pickupable_IDs

    def get_moveable_object_ids(self, _event=None):
        objects = self.get_objects(_event)
        moveable_IDs = list()

        for obj in objects:
            if obj["moveable"]:
                moveable_IDs.append(obj["objectId"])

        return moveable_IDs

    def get_openable_object_ids(self, _event=None):
        objects = self.get_objects(_event)
        openable_IDs = list()

        for obj in objects:
            if obj["openable"]:
                openable_IDs.append(obj["objectId"])

        return openable_IDs


    def get_receptacle_object_ids(self, _event=None):
        objects = self.get_objects(_event)
        receptacle_IDs = list()

        for obj in objects:
            if obj["receptacle"]:
                receptacle_IDs.append(obj["objectId"])

        return receptacle_IDs


    def get_object_location(self, objectID, _event=None):
        obj = self.get_object(objectID, _event)

        return obj["position"]


    def get_all_object_location(self, _event=None):
        objects = self.get_objects(_event)
        locations = dict()
        for obj in objects:
            obj_id = obj["objectId"]
            locations[obj_id] = obj["position"]
            locations[obj_id]["receptacle"] = False
            for receptacle_obj_id in obj["receptacleObjectIds"]:
                locations[receptacle_obj_id] = obj["position"]
                locations[receptacle_obj_id]["receptacle"] = True

        return locations

    def get_agent_information(self, _event=None):
        if _event is None:
            _event = self.world_server.get_recent_event()

        return _event["agent"]

    def get_agent_location(self, _event=None):
        _agent = self.get_agent_information(_event)

        return _agent["position"]

