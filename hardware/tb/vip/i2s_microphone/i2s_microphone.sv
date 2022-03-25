module i2s_microphone #(
    parameter DATA = 12
)
(
  input logic [31:0] data,
  input logic lsb_first,
  input logic ws,
  input logic bclk,
  output logic dout,
  output logic wso
  
);

  enum {IDLE,RUN,PULSE} state, next_state; 
  /*
   NB: This microphone start to transmit data and then tri-state the dout and enable wso line
 */
  reg [5:0] count;
  
  logic set;
  logic tristate;
  
  //reg [23:0] data;
  
  always_ff@ (negedge bclk)
  begin
    if(next_state==PULSE || next_state==IDLE ) 
      state<=next_state;
  end

  always_ff@ (posedge bclk)
  begin
   if(next_state==RUN) begin
     state<=next_state;
     if(set==1'b1)
       if (lsb_first==1'b0)
          count<=31;
       else
          count<=0;
     else
       if (lsb_first==1'b0)
          count<=count-1;
       else
          count<=count+1;
   end
   
   if(set==1'b1) begin
       if (lsb_first==1'b0)
          count<=31;
       else
          count<=0;
   end 
        
   if(state==PULSE)
      tristate=1'b1;
   else
      tristate=1'b0;
  end

  always_comb
  begin
    set=1'b0;
 
    case(state)
    IDLE:
        begin
          
          dout='z;
          wso=0;
          if(ws==1) begin
            next_state=RUN;
            set=1'b1;
          end else
            next_state=IDLE;
            set=1'b1;
        end

    RUN:
        begin
          wso=0;
          dout=data[count];
          if (lsb_first==1'b0) begin
             if(count!=0)
                next_state=RUN;
             else 
                next_state=PULSE;
          end else begin 
             if(count!=31)
                next_state=RUN;
             else 
                next_state=PULSE;
          end
        end

    PULSE:
         begin
           wso=1;
           next_state = IDLE;
           if(tristate==1)
             dout='z;
        end

   default:
          begin
            next_state = IDLE;
          end

    endcase
  end
endmodule

