//001011
module seq_detector_001011(input bit clk, rst_n, x, output reg z);
  parameter A = 4'h1;
  parameter B = 4'h2;
  parameter C = 4'h3;
  parameter D = 4'h4;
  parameter E = 4'h5; 
  parameter F = 4'h6;
  parameter G = 4'h7;
  
  bit [3:0] state, next_state;
  always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin 
      state <= A;
    end
    else state <= next_state;
  end
  
  always @(state or x) begin
    case(state)
      A: begin
        if(x == 0) next_state = B;
           else       next_state = A;
         end
      B: begin
           if(x == 0) next_state = C;
           else       next_state = A;
         end
      C: begin
        if(x == 0) next_state = C;
           else       next_state = D;
         end
      D: begin
        if(x == 0) next_state = E;
           else       next_state = A;
         end
      E: begin
        if(x == 0) next_state = B;
           else       next_state = F; 
        end
      F: begin
        if(x == 0) next_state = B;
           else       next_state = G;
        end
      G: begin
        if(x == 0) next_state = B;
           else       next_state = A;
      end
 
        
      default: next_state = A;
    endcase
  end
  //As output z is only depends on present state
  always@(state) begin
    case(state)
      A : z = 0;
      B : z = 0;
      C : z = 0;
      D : z = 0;
      E : z = 0;
      F : z = 0;
      G : z = 1;
      default : z = 0;
    endcase
  end
endmodule
