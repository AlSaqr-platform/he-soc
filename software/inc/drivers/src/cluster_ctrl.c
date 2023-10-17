#include "utils.h"

void init_cluster (unsigned int boot_addr_core) {

    // Reset the cluster
    pulp_write32(ARCHI_APB_SOC_CTRL_ADDR + ARCHI_APB_SOC_CONTROL_CLUSTER_OFFSET,
    (0x1 << ARCHI_APB_SOC_CONTROL_CLUSTER_RESET_N));
    pulp_write32(ARCHI_APB_SOC_CTRL_ADDR + ARCHI_APB_SOC_CONTROL_CLUSTER_OFFSET,
    (0x0 << ARCHI_APB_SOC_CONTROL_CLUSTER_RESET_N));
    pulp_write32(ARCHI_APB_SOC_CTRL_ADDR + ARCHI_APB_SOC_CONTROL_CLUSTER_OFFSET,
    (0x1 << ARCHI_APB_SOC_CONTROL_CLUSTER_RESET_N));

    // Change ris5y boot addresses
    for (int i = 0; i < 8; i++)
        plp_ctrl_core_bootaddr_set_remote(0, i, boot_addr_core);

    // Set enable and fetch enable
    pulp_write32(ARCHI_APB_SOC_CTRL_ADDR + ARCHI_APB_SOC_CONTROL_CLUSTER_OFFSET,
    (0x1 << ARCHI_APB_SOC_CONTROL_CLUSTER_RESET_N) |
    (0x1 << ARCHI_APB_SOC_CONTROL_CLUSTER_EN_SA_BOOT));
    pulp_write32(ARCHI_APB_SOC_CTRL_ADDR + ARCHI_APB_SOC_CONTROL_CLUSTER_OFFSET,
    (0x1 << ARCHI_APB_SOC_CONTROL_CLUSTER_RESET_N) |
    (0x1 << ARCHI_APB_SOC_CONTROL_CLUSTER_EN_SA_BOOT) |
    (0x1 << ARCHI_APB_SOC_CONTROL_CLUSTER_FETCH_EN));

    // Cluster control unit registers, fetch enable
    eoc_fetch_enable_remote(0, 0xff);

    return;
}