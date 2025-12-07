extends SR_EventInventory
class_name SR_EventInventoryClosed

static func as_event() -> SR_EventInventoryClosed:
	return SR_Events.get_by_script(SR_EventInventoryClosed) as SR_EventInventoryClosed
