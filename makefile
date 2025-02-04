BOARD=BigTreeTech\ SKR\ Mini\ E3\ v3
UI=MarlinUI

config-default:
	rm -rf ./Marlin/Marlin/Configuration*
	cp -rf ./Configurations/config/examples/Creality/Ender-3\ V2/${BOARD}/${UI}/* ./Marlin/Marlin

config-custom:
	rm -rf ./Marlin/Marlin/Configuration*
	cp -rf ./Custom/* ./Marlin/Marlin