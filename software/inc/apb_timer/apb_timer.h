#ifndef __ARCHI_APB_TIMER_H__
#define __ARCHI_APB_TIMER_H__

#define APB_TMR_BASE  0x18000000

#define APB_TMR_VALUE_OFFSET 0
#define APB_TMR_CTRL_OFFSET  4
#define APB_TMR_CMP_OFFSET   8

#define APB_TMR_PRESCALER_OFFSET 3
#define APB_TMR_EN_OFFSET 0


#define APB_TIMER_VALUE(id)        ( APB_TMR_BASE | id <<4 )

#define APB_TIMER_CTRL(id)         ( APB_TIMER_VALUE(id) + APB_TMR_CTRL_OFFSET )
#define APB_TIMER_CMP(id)          ( APB_TIMER_VALUE(id) + APB_TMR_CMP_OFFSET )


static inline void apb_timer_enable(int id, uint8_t prescaler)
 {
   pulp_write32(APB_TIMER_CTRL(id), prescaler << 3 | 1);
 }

 static inline void apb_timer_disable(int id)
 {
   pulp_write32(APB_TIMER_CTRL(id), 0);
 }

static inline void apb_timer_set_value(int id, uint32_t val)
 {
   pulp_write32(APB_TIMER_VALUE(id), val);
 }

 static inline uint32_t apb_timer_get_value (int id)
 {
   return pulp_read32(APB_TIMER_VALUE(id));
 }

static inline void apb_timer_set_compare (int id, uint32_t val)
 {
   pulp_write32(APB_TIMER_CMP(id), val);
 }

static inline uint32_t apb_timer_get_compare (int id)
 {
   return pulp_read32(APB_TIMER_CMP(id));
 }


#endif