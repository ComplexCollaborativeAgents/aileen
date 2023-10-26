

class InputWriter(object):
    def __init__(self, world_server, soar_agent):
        self._world_server = world_server
        self._soar_agent = soar_agent
        if soar_agent:  # Enable stand alone testing
            self._input_link = soar_agent.get_input_link()
            self._world_link = self._input_link.CreateIdWME("world")
            self._objects_link = self._world_link.CreateIdWME("objects")
        pass

    def generate_input(self):
        metadata = self._world_server.execute_action("Done")
        objects_list = metadata['objects']
        self.add_objects_to_working_memory(objects_list)

    def add_objects_to_working_memory(self, objects_list):
        self._soar_agent.delete_all_children(self._objects_link)
        for w_object in objects_list:
            print(w_object)
            object_id = self._objects_link.CreateIdWME("object")
            object_id.CreateStringWME('id', w_object['name'])
            if 'position' in w_object:
                position_id = object_id.CreateIdWME('position')
                position_id.CreateFloatWME('x', w_object['position']['x'])
                position_id.CreateFloatWME('y', w_object['position']['y'])
                position_id.CreateFloatWME('z', w_object['position']['z'])
            object_id.CreateStringWME('visible', str(w_object['visible']))
            object_id.CreateStringWME('is_interactable', str(w_object['isInteractable']))
            object_id.CreateStringWME('receptacle', str(w_object['receptacle']))
            object_id.CreateStringWME('toggleable', str(w_object['toggleable']))
            object_id.CreateStringWME('is_toggled', str(w_object['isToggled']))
            object_id.CreateStringWME('breakable', str(w_object['breakable']))
            object_id.CreateStringWME('is_broken', str(w_object['isBroken']))
            object_id.CreateStringWME('can_fill_with_liquid', str(w_object['canFillWithLiquid']))
            object_id.CreateStringWME('is_filled_with_liquid', str(w_object['isFilledWithLiquid']))
            object_id.CreateStringWME('fill_liquid', str(w_object['fillLiquid']))
            object_id.CreateStringWME('dirtyable', str(w_object['dirtyable']))
            object_id.CreateStringWME('is_dirty', str(w_object['isDirty']))
            object_id.CreateStringWME('can_be_used_up', str(w_object['canBeUsedUp']))
            object_id.CreateStringWME('is_used_up', str(w_object['isUsedUp']))
            object_id.CreateStringWME('cookable', str(w_object['cookable']))
            object_id.CreateStringWME('is_cooked', str(w_object['isCooked']))
            object_id.CreateStringWME('is_heat_source', str(w_object['isHeatSource']))
            object_id.CreateStringWME('is_cold_source', str(w_object['isColdSource']))
            object_id.CreateStringWME('sliceable', str(w_object['sliceable']))
            object_id.CreateStringWME('is_sliced', str(w_object['isSliced']))
            object_id.CreateStringWME('openable', str(w_object['openable']))
            object_id.CreateStringWME('isOpen', str(w_object['isOpen']))
            object_id.CreateFloatWME('openness', w_object['openness'])
            object_id.CreateStringWME('pickupable', str(w_object['pickupable']))
            object_id.CreateStringWME('isPickedUp', str(w_object['isPickedUp']))
            object_id.CreateStringWME('moveable', str(w_object['moveable']))
            object_id.CreateFloatWME('mass', w_object['mass'])
            if 'salientMaterials' in w_object and w_object['salientMaterials']:
                materials_id = object_id.CreateIdWME('salient_materials')
                for material in w_object['salientMaterials']:
                    materials_id.CreateStringWME('material', material)
            object_id.CreateStringWME('receptacle_object_ids', str(w_object['receptacleObjectIds']))
            object_id.CreateFloatWME('distance', w_object['distance'])
            object_id.CreateStringWME('object_type', str(w_object['objectType']))


