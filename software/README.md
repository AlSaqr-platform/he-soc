# Run code on the cluster

To run bare-metal code on the cluster you might need some knowledge of the uarchitecture of the SoC.

We need to write two main.c, one for CVA6 and one for the cluster. CVA6 is in charge of loading the cluster's
binary from the main memory (the DDR4 on fpga) into the L2SPM. Then, it has to release the reset and enable the
fetch enable of the cluster. Also, it has to program the IOTLB so that the addresses coming from the cluster are
properly translated. Being bare-metal execution, it is a 1:1 map.

These steps are translated in c in the following commands:

### Loading the binary

```c
int load_cluster_code() {
      uint32_t *p, *end, *p0;
      p = (uint32_t*)&__cluster_code_start;
      p0 = (uint32_t*)&__cluster_code_start;
      end = (uint32_t*)&__cluster_code_end;
      uint32_t * addr;
      while(p<end){
        addr = 0x1C000000 + ((p - p0)*4);
        pulp_write32(addr,pulp_read32(p));
        p++;
      }
      return 0; 
}
```
the cluster's binary (`cluster.bin`) is embedded into the cva6.bin.

```c
  // C2H TLB configuration
  tlb_cfg(C2H_TLB_BASE_ADDR, 0, c2h_first_va, c2h_last_va, c2h_base_pa, 0x07);

  load_cluster_code();

  // Set the plic to recevie interrupts from the cluster-to-host MBOX
  uint32_t mb_plic_id = 8;
  pulp_write32(PLIC_BASE+(mb_plic_id*4),0x1);
  pulp_write32(PLIC_BASE+0x2000,1<<mb_plic_id);

  // Reset the cluster
  pulp_write32(0x1A106000,0x1);
  pulp_write32(0x1A106000,0x0);
  pulp_write32(0x1A106000,0x1);

  // change ris5y boot addresses
  int boot_addr_core=0x10200040;
  for (int i=0; i<8; i++)
    pulp_write32(0x10200040+i*4,0x1C000000);

  // Set enable and fetch enable
  pulp_write32(0x1A106000,0x3);
  pulp_write32(0x1A106000,0x7);

  // Cluster control unit registers, fetch enable
  pulp_write32(0x10200008,0xff);

  // Wait for the interrupt from the cluster
  while ( pulp_read32(PLIC_BASE+0x200004)!=mb_plic_id ) {
   asm volatile ("wfi");
  }  

```

### Communication with the cluster

There is an hardware mbox to exchange messages between host and cluster. CVA6 bare-metal runtime is very minimal
and does not provide the drivers to read and write. But we have them integrated in the Linux driver, in case you
want to look them up: [here](https://github.com/yvantor/hero/blob/dev/support/libpulp/src/libpulp.c#L704) and [here](https://github.com/yvantor/hero/blob/dev/support/include/pulp_mbox.h).
The base address is `0x10400000`.

### Compiling the cluster's code

You find a minimal cluster-runtime [here](https://github.com/AlSaqr-platform/cluster-runtime). You'll need [Ri5cy's toolchain](https://github.com/pulp-platform/pulp-riscv-gnu-toolchain).

```
git clone git@github.com:AlSaqr-platform/cluster-runtime.git

export RISCV=<path-to-the-toolchain>

export PATH=$RISCV/bin:$PATH

source setup.sh

cd cluster-runtime/examples/hello

make clean all
```

```
cd he-soc/software/hello_pulp

cp <path-to-cl-runtime>/examples/hello/cluster.bin stimuli/

make clean CLUSTER_BIN=1 all
```

You can run the `hello_pulp.riscv` on FPGA now. If you want to use the same uart for CVA6 and the cluster, you'll need to change the `#define ARCHI_STDOUT_ADDR     0x1A222000` to
`#define ARCHI_STDOUT_ADDR     0x40000000`. If not, you need to connect the second UART.
