class_name Building

var building_data:= {}

func construct(new_building_data):
	building_data = new_building_data

func setProperty(property, value):
	building_data[property] = value
	
func getProperty(property):
	return building_data[property]
