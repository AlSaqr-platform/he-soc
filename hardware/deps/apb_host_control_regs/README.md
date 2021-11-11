# APB SOC CONTROL

Here there is the apb slave where we keep the control registers. As of now, we just implement the control signals for the cluster.

To add registers, just modify the `hjson` file here and re-generate the RTL.

The tool you need to use it [this](https://github.com/pulp-platform/register_interface).
