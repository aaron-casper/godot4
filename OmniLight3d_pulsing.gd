extends OmniLight3D

# pulsating light script

# tldr; the vars you want to adjust are exported to the inspector

# in essence, this script counts cycles, and when a certain
# number of cycles have passed, it increments the brightness
# of the light it's attached to up or down by the prescribed
# value.  you can get fast, slow, jagged, or smooth light
# pulses by adjusting the values in the inspector 

# the script is commented throughout, I find that helps
# the learning process for new programmers.

# internal vars:
var energy : float = 0.0 # initalize a float for light brightness, or "energy" in godot
var up_down : bool = true # this bool toggles when we're counting up or down... increasing or decreasing brightness
var cycles : float = 0.0 # counter for num of cycles
var last_cycles : float = 0.0 # what was the last cycle float value when we bumped brightness up or down?

# inspector vars:
## how frequently in the cycle count do we bump brightness up or down, smaller numbers are faster
@export var cycle_rate : float = 0.05
## how bright do we want to go?
@export var max_energy : float = 3.0 
## how dim do we want to go?
@export var min_energy : float = 1.0
## how much do you want to change the light each num of cycles?
@export var energy_delta : float = 0.1 

func _process(_delta) -> void:
	# spam the console with some debug output
	#print(str(up_down) + " up_down, " + str(cycles) + " cycles, " + str(last_cycles) + " last_cyc, " + str(energy) + " energy" )
	# set the light object's energy (brightness) value
	light_energy = energy
	# increment cycles var
	cycles += _delta
	# check if enough time has elapsed since last change
	if cycles >= (last_cycles + cycle_rate):
		# if so, set our check value to the current num of cycles
		last_cycles = cycles
		# if we're going up...
		if up_down == true:
			# increment brightness
			energy += energy_delta
		# if we've maxed out brightness
		if energy >= max_energy:
			# turn around
			up_down = false
		# if we're going down...
		if up_down == false:
			# decrease brightness
			energy -= energy_delta
		# if we hit the minimum brightness limit
		if energy <= min_energy:
			# turn around
			up_down = true
