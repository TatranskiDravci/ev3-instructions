# ev3-instructions

A set of tools to simplify building EV3 programs

## Tools

### Constructor
* Engine: Godot
* Output: **EPPF** (ev3 program path file) and **DAT** file

### Compiler
* Language: python3
* Input: **EPPF** files
* Output: **PY** (python) files based on data specified by eppfc.json

## Specifications
### EPPF (ev3 program path file)
* defines actions of EV3 unit
* configurable
* functions
  * no multiple equal functions on single line
  * name cannot include any special, numeric or lower designated characters
  * parameters enclosed in function's name: `r123r` or `mv23::2mv`
  * function parameters separated by `::`
  * list parameters enclosed in `[]` and separated by `,`

### .eppfc.json
* dotfile
* sourced from `~` directory
* written in JSON
* `Config` defines program configuration
* `Class` defines robot class
  * `Methods` defines all methods and their parameters
* `_n` defines parameter n passed on by matching **EPPF** function
