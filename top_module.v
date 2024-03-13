module top_module(
    input clk,       // System clock
    output tx,        // UART TX output
    input C,
    input D,
    input E,
    input F,
    input G,
      input wire [15:0] sw,
       output reg[15:0] led,
       // display
       output reg [6:0] reg_out,
       output reg [3:0] an
);

reg [7:0] tx_data;
   reg [3:0] key = 0;
   reg quality = 0; // major/minor
   reg [2:0] pitch = 0; // A, B, C, D, E
      reg [2:0] C_debounce = 0;
      reg [2:0] D_debounce = 0;
      reg [2:0] E_debounce = 0;
      reg [2:0] F_debounce = 0;
      reg [2:0] G_debounce = 0;
    reg [3:0] sw_out = 0; // switch output
    reg [2:0] sw0_debounce = 0;
    reg [2:0] sw1_debounce = 0;
    reg [2:0] sw2_debounce = 0;
    reg [2:0] sw3_debounce = 0;
    reg [2:0] sw4_debounce = 0;
    reg [2:0] sw5_debounce = 0;
    reg [2:0] sw6_debounce = 0;
    reg [2:0] sw7_debounce = 0;
    reg [2:0] sw8_debounce = 0;
    reg [2:0] sw9_debounce = 0;
    reg [2:0] sw10_debounce = 0;
    reg [2:0] sw11_debounce = 0;
    reg [2:0] sw12_debounce = 0;
    reg [2:0] sw13_debounce = 0;
    reg [2:0] sw14_debounce = 0;
    reg [2:0] sw15_debounce = 0;
    
    reg sendflag = 0; // set to 1 when you want to send
    
       reg [7:0] led_char = 0;
       reg [1:0] LED_activating_counter = 0;
       reg [19:0] refresh_counter = 0;
       reg [7:0] char1 = "C";
       reg [7:0] char2 = "H";
       reg [7:0] char3 = "H";
       reg [7:0] char4 = "H";

wire is_transmitting;
reg transmit;

// Instantiate the UART module
uart uart_inst (
    .clk(clk),
    .rst(1'b0),
    .rx(1'bx),  // Default value for RX (can also use another placeholder value like 8'h0)
    .tx(tx),
    .transmit(transmit),
    .tx_byte(tx_data),
    .received(1'bx),  // Default value for received
    .rx_byte(8'bx),   // Default value for rx_byte
    .is_receiving(1'bx),  // Default value for is_receiving
    .is_transmitting(is_transmitting),  // Default value for is_transmitting
    .recv_error(1'bx)  // Default value for recv_error
);

//   // Transmit state machine
   always @(posedge clk) begin

       // debounce logic
           C_debounce = {C, C_debounce[2:1]};
           D_debounce = {D, D_debounce[2:1]};
           E_debounce = {E, E_debounce[2:1]};
           F_debounce = {F, F_debounce[2:1]};
           G_debounce = {G, G_debounce[2:1]};
           // switches
            sw0_debounce = {sw[15], sw0_debounce[2:1]};
            sw1_debounce = {sw[14], sw1_debounce[2:1]};
            sw2_debounce = {sw[13], sw2_debounce[2:1]};
            sw3_debounce = {sw[12], sw3_debounce[2:1]};
            sw4_debounce = {sw[11], sw4_debounce[2:1]};
            sw5_debounce = {sw[10], sw5_debounce[2:1]};
            sw6_debounce = {sw[9], sw6_debounce[2:1]};
            sw7_debounce = {sw[8], sw7_debounce[2:1]};
            sw8_debounce = {sw[7], sw8_debounce[2:1]};
            sw9_debounce = {sw[6], sw9_debounce[2:1]};
            sw10_debounce = {sw[5], sw10_debounce[2:1]};
            sw11_debounce = {sw[4], sw11_debounce[2:1]};
            sw12_debounce = {sw[3], sw12_debounce[2:1]};
            sw13_debounce = {sw[2], sw13_debounce[2:1]};
            sw14_debounce = {sw[1], sw14_debounce[2:1]};

           if (C_debounce == 3'b001) begin
               pitch = 0;;
           end

           if (D_debounce == 3'b001) begin
               pitch = 1;
           end

           if (E_debounce == 3'b001) begin
               pitch = 2;
           end

           if (F_debounce == 3'b001) begin
               pitch = 3;
           end

           if (G_debounce == 3'b001) begin
               pitch = 4;
           end

            quality = sw[0];



           if (sw0_debounce == 3'b100) begin
               sw_out = 1;
               sendflag = 1;
             $display("sw0 is pressed: %b", sw0_debounce);
           end
           if (sw1_debounce == 3'b100) begin
               sw_out = 2;
               sendflag = 1;
             $display("sw1 is pressed: %b", sw0_debounce);
           end
           if (sw2_debounce == 3'b100) begin
               sw_out = 3;
               sendflag = 1;
             $display("sw2 is pressed: %b", sw0_debounce);
           end
           if (sw3_debounce == 3'b100) begin
               sw_out = 4;
               sendflag = 1;
             $display("sw3 is pressed: %b", sw0_debounce);
           end
           if (sw4_debounce == 3'b100) begin
               sw_out = 5;
               sendflag = 1;
             $display("sw4 is pressed: %b", sw0_debounce);
           end
           if (sw5_debounce == 3'b100) begin
               sw_out = 6;
               sendflag = 1;
             $display("sw5 is pressed: %b", sw0_debounce);
           end
           if (sw6_debounce == 3'b100) begin
               sw_out = 7;
               sendflag = 1;
             $display("sw6 is pressed: %b", sw0_debounce);
           end
           if (sw7_debounce == 3'b100) begin
               sw_out = 8;
               sendflag = 1;
             $display("sw7 is pressed: %b", sw0_debounce);
           end
           if (sw8_debounce == 3'b100) begin
               sw_out = 9;
               sendflag = 1;
             $display("sw8 is pressed: %b", sw0_debounce);
           end
           if (sw9_debounce == 3'b100) begin
               sw_out = 10;
               sendflag = 1;
             $display("sw9 is pressed: %b", sw0_debounce);
           end
           if (sw10_debounce == 3'b100) begin
               sw_out = 11;
               sendflag = 1;
             $display("sw10 is pressed: %b", sw0_debounce);
           end
           if (sw11_debounce == 3'b100) begin
               sw_out = 12;
               sendflag = 1;
             $display("sw11 is pressed: %b", sw0_debounce);
           end
           if (sw12_debounce == 3'b100) begin
               sw_out = 13;
               sendflag = 1;
             $display("sw12 is pressed: %b", sw0_debounce);
           end
           if (sw13_debounce == 3'b100) begin
               sw_out = 14;
               sendflag = 1;
             $display("sw13 is pressed: %b", sw0_debounce);
           end
           if (sw14_debounce == 3'b100) begin
               sw_out = 15;
               sendflag = 1;
             $display("sw14 is pressed: %b", sw0_debounce);
           end

           key = {quality, pitch};
            
           case(key)
               4'b0000: char1 = "C";
               4'b0001: char1 = "D";
               4'b0010: char1 = "E";
               4'b0011: char1 = "F";
               4'b0100: char1 = "G";
               4'b1000: char1 = "C";
               4'b1001: char1 = "D";
               4'b1010: char1 = "E";
               4'b1011: char1 = "F";
               4'b1100: char1 = "G";
               default: char1 = 0;
           endcase
     tx_data = {sw_out, key};

   if (is_transmitting) begin
        transmit = 0;
     if (sendflag) begin
       $display("is still transmitting");

       sendflag = 0;
     end
        
    end
    // Check your button condition here
    // For example, if the button is pressed, initiate transmission
    if (sendflag && !is_transmitting) begin
        transmit = 1;
      

    end
   end


   // this should run the refresh counter, to which the led thing will activiate
       always @(posedge clk)
          begin 
              refresh_counter <= refresh_counter + 1;
              LED_activating_counter = refresh_counter[19:18];
          end 
    
//    a;ways running , setting the an and led to correct number
       always @(*) begin
          case(LED_activating_counter)
              2'b00: begin
                   an = 4'b0111;
                   led_char = char1;
                    
                   $display("first an %b num %b", an, reg_out);
                   end
              2'b01: begin
                   an = 4'b1011;

                   led_char = char2;
                   $display("second an %b num %b", an, reg_out);
                    end
              2'b10: begin
                   an = 4'b1101;
                   led_char = char3;
                    
                   $display("third an %b num %b", an, reg_out);
                      end
              2'b11: begin
                   an = 4'b1110;
                   led_char = char4;
                    
                   $display("fourth an %b num %b", an, reg_out);
                     end
          	default: begin
              an = 4'b1110;
              led_char = "G";   
              $display("error an %b num %b", an, reg_out);
              end
          endcase
          led = {tx_data};
      end
    
    
    
    
   always @(*) begin // binary or ASCII for letters?
       case (led_char)
       "A": reg_out = 7'b0001000; // "A" (LED ON)
       "B": reg_out = 7'b1100000; // "B" (LED ON)
       "C": reg_out = 7'b1000110; // "C" (LED ON)
       "D": reg_out = 7'b0100001; // "D" (LED ON)
       "E": reg_out = 7'b0000110; // "E" (LED ON)
       "F": reg_out = 7'b0001110; // "F" (LED ON)
       "G": reg_out = 7'b1000010; // "G" (LED ON)
        default: reg_out = 7'b1111111; // "0" (default case, LED OFF)
       endcase
   end
    

endmodule
