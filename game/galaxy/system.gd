class_name system

var system_data

func construct(new_system_data):
	system_data = new_system_data

func setProperty(property, value):
	system_data[property] = value

func getProperty(property):
	return system_data[property]
	
func setFactionProperty(property, value):
	setProperty(property, value)
	
func getFactionProperty(property):
	return getProperty(property)
