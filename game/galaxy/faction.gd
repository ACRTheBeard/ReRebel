class_name faction

var faction_data

func construct(new_faction_data):
	faction_data = new_faction_data

func setProperty(property, value):
	faction_data[property] = value

func getProperty(property):
	return faction_data[property]
	
func setFactionProperty(property, value):
	setProperty(property, value)
	
func getFactionProperty(property):
	return getProperty(property)
