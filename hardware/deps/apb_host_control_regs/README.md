# APB SOC CONTROL

Here there is the apb slave where we keep the control registers. As of now, we just implement the control signals for the cluster.

To add registers, just modify the `hjson` file here and re-generate the RTL.

The tool you need to use it [this](https://github.com/pulp-platform/register_interface). From this folder do:
```
git clone git@github.com:AlSaqr-platform/register_interface.git
python3.6 register_interface/vendor/lowrisc_opentitan/util/regtool.py -r soc_control_regs.hjson -t src
```