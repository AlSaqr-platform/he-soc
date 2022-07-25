// Auto-generated code

extern int __cluster_code_start;
extern int __cluster_code_end;

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
