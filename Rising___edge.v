
module rising_edge_moore (
    input  wire clk,
    input  wire reset,
    input  wire level,
    output reg  tick
);

 localparam
  ZERO = 2'b00,
  EDGE = 2'b01,
  ONE  = 2'b10;
  reg [1:0] present_state;
  reg [1:0] next_state;

   // State Register
   always @(posedge clk or posedge reset)
  begin
  if (reset)
  present_state <= ZERO;
  else
  present_state <= next_state;
  end

 
  // Next State Logic
  always @(*)
  begin
  case (present_state)

   ZERO:
   begin
   if (level)
   next_state = EDGE;
   else
   next_state = ZERO;   
     end

   EDGE:
   begin
    next_state = ONE;
   end

  ONE:
 begin
 if (level)
 next_state = ONE;
 else
 next_state = ZERO;
  end

 default:
 next_state = ZERO;

 endcase
    end

 // Moore Output Logic
    always @(*)
    begin
   if (present_state == EDGE)
            tick = 1'b1;
    else
     tick = 1'b0;
    end

   endmodule

    module rising_edge_mealy (
    input  wire clk,
    input  wire reset,
    input  wire level,
    output reg tick
);

  localparam ZERO = 1'b0,
              ONE  = 1'b1;

  reg present_state;
  reg next_state;

   
  always @(posedge clk or posedge reset)
    begin
    if (reset)
    present_state <= ZERO;
     else
     present_state <= next_state;
     end

    // Next State Logic
    always @(*)
    begin
    case (present_state)

    ZERO:
    begin
   if (level)
    next_state = ONE;
   else
   next_state = ZERO;
   end

   ONE:
   begin
   if (level)
    next_state = ONE;
    else
    next_state = ZERO;
    end

    default:
    next_state = ZERO;

    endcase
    end

    // Mealy Output Logic    
    always @(*)
    begin
    if ((present_state == ZERO) && (level == 1'b1))
    tick = 1'b1;
    else
   tick = 1'b0;
    end

   endmodule












