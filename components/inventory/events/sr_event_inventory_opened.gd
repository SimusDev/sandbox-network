extends SR_EventInventory
class_name SR_EventInventoryOpened

static func as_event() -> SR_EventInventoryOpened:
	return SR_Events.get_by_script(SR_EventInventoryOpened) as SR_EventInventoryOpened
