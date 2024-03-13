//`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////////
//// Company: 
//// Engineer: 
//// 
//// Create Date: 03/04/2024 02:18:47 PM
//// Design Name: 
//// Module Name: music
//// Project Name: 
//// Target Devices: 
//// Tool Versions: 
//// Description: 
//// 
//// Dependencies: 
//// 
//// Revision:
//// Revision 0.01 - File Created
//// Additional Comments:
//// 
////////////////////////////////////////////////////////////////////////////////////


//module music(
//    input wire clk,
//    // Button inputs
//    input wire C, // up
//    input wire D, // left
//    input wire E, // middle
//    input wire F, // right
//    input wire G, // right
    
//    // TEST
//    output reg tx, // UART transmitter
////    output reg tx_en, // UART transmitter enable
////    output reg [15:0] tx_data, // Data to be transmitted via UART
//    // TEST
    
//    //switches

//    input wire sw[15:0],
//    output reg[14:0] led,
    
//    // display
//    output reg [6:0] reg_out,
//    output reg [3:0] an
//    );
    
//    reg [7:0] led_char = 0;
//    reg [1:0] LED_activating_counter = 0;
//    reg [19:0] refresh_counter = 0;
//    reg [7:0] char1 = "C";
//    reg [7:0] char2 = "H";
//    reg [7:0] char3 = "H";
//    reg [7:0] char4 = "H";
    
//    reg [2:0] C_debounce = 0;
//    reg [2:0] D_debounce = 0;
//    reg [2:0] E_debounce = 0;
//    reg [2:0] F_debounce = 0;
//    reg [2:0] G_debounce = 0;
//    // reg [2:0] F_debounce = 0;
//    reg [3:0] key = 0;
//    reg quality = 0; // major/minor
//    reg [2:0] pitch = 0; // A, B, C, D, E
//    reg sus = 0;
   
//   // TEST
//   // TEST
//      // reg [7:0] uart_data = 8'b10110111;

//    reg [7:0] uart_data = 8'b10101010;
//    reg [1:0] uart_tx_state = 2'b00;
//    reg [3:0] uart_bit_count = 8;
//    reg uart_transmit_enable = 0; // Added variable to control UART transmission
    
//    // Assuming desired baud rate is 9600
//    parameter BAUD_RATE = 9600;
//    // reg [15:0] clock_divider = (1000000000 / BAUD_RATE) - 1; // Calculate clock divider
//    reg [15:0] clock_divider = 9600; // Calculate clock divider

//    reg [25:0] counter = 0;
//    reg sendflag = 0; // set to 1 when you want to send
//    reg [1:0] tx_countdown = 4;
    
    
    
    
//    // Transmit state machine
//    always @(posedge clk) begin
//        if (counter >= clock_divider) begin
//            counter <= 0;
//            tx_countdown = tx_countdown - 1;
         
//            // when you click button
//                    case(uart_tx_state)
//                        4'b00: begin
//                            if (sendflag == 1) begin
//                                uart_data = 8'b00001010;
//                                tx_countdown = 4;
//                                tx = 0;
//                                uart_bit_count = 8;
//                                uart_tx_state = 4'b01;
//                            end
//                        end
                        
//                        4'b01: begin
//                            if (!tx_countdown) begin
//                                if (uart_bit_count) begin
//                                    uart_bit_count = uart_bit_count - 1;
//                                    tx = uart_data[0];
//                                    uart_data = {1'b0, uart_data[7:1]};
//                                    tx_countdown = 4;
//                                    uart_tx_state = 4'b01;                                
//                                end else begin
//                                    tx = 1;
//                                    tx_countdown = 8;
//                                    uart_tx_state = 4'b10;
//                                    sendflag = 0;
//                                end
//                            end
//                        end
                        
//                        4'b10: begin
//                            uart_tx_state = tx_countdown ? 4'b10 : 4'b00;
//                        end               
//                endcase
                   
//        end else begin
//            counter = counter + 1;
//        end
        
        
        
////        case (tx_state)
////                TX_IDLE: begin
////                        if (transmit) begin
////                                // If the transmit flag is raised in the idle
////                                // state, start transmitting the current content
////                                // of the tx_byte input.
////                                tx_data = tx_byte;
////                                // Send the initial, low pulse of 1 bit period
////                                // to signal the start, followed by the data
////                                tx_clk_divider = CLOCK_DIVIDE;
////                                tx_countdown = 4;
////                                tx_out = 0;
////                                tx_bits_remaining = 8;
////                                tx_state = TX_SENDING;
////                        end
////                end
////                TX_SENDING: begin
////                        if (!tx_countdown) begin
////                                if (tx_bits_remaining) begin
////                                        tx_bits_remaining = tx_bits_remaining - 1;
////                                        tx_out = tx_data[0];
////                                        tx_data = {1'b0, tx_data[7:1]};
////                                        tx_countdown = 4;
////                                        tx_state = TX_SENDING;
////                                end else begin
////                                        // Set delay to send out 2 stop bits.
////                                        tx_out = 1;
////                                        tx_countdown = 8;
////                                        tx_state = TX_DELAY_RESTART;
////                                end
////                        end
////                end
////                TX_DELAY_RESTART: begin
////                        // Wait until tx_countdown reaches the end before
////                        // we send another transmission. This covers the
////                        // "stop bit" delay.
////                        tx_state = tx_countdown ? TX_DELAY_RESTART : TX_IDLE;
////                end
////        endcase
////      end
    
    
////    reg sendflag2 = 0;
    
////    always @(posedge clk) begin
////       if (counter >= clock_divider) begin
////           counter <= 0;
////           if (sendflag == 1) begin
////                   case(uart_tx_state)
////                      4'b00: begin
////                      //sendflag2 = 1;
////                         tx <= 0; // Start bit
////    //                     if (uart_transmit_enable == 1) begin
////                           uart_data <= {sus, key}; // Data to send (sw bits)
////    //                     end
////                         uart_tx_state <= 4'b01;
////                         uart_bit_count <= 4'b0000;
////                      end
////                      4'b01: begin
////                         tx <= uart_data[0];
////                         uart_data <= {uart_data[6:0], 1'b0}; // Shift data to the right
////                         uart_tx_state <= 4'b10;
////                         uart_bit_count <= uart_bit_count + 1;
////                      end
////                      4'b10: begin
////                         if (uart_bit_count == 7) begin
////                            tx <= 1; // Stop bit
////                            //sendflag2 = 0;
////                            uart_tx_state <= 4'b00;
////                         end else begin
////                            tx <= uart_data[0];
////                            uart_data <= {uart_data[6:0], 1'b0}; // Shift data to the right
////                            uart_tx_state <= 4'b01;
////                         end
////                         uart_bit_count <= uart_bit_count + 1;
////                      end
////                   endcase
////            end 
////           end
////       else begin
////            counter = counter + 1;
////       end
////     end
//      // TEST
   
   
   
////       always @(posedge clk)
////        begin
////        if (counter >= clock_divider) begin
////               counter <= 0;
////               if (sendflag == 1) begin
////                       case(uart_tx_state)
////                          4'b00: begin
////                          sendflag = 1;
//////                             tx <= 0; // Start bit
////        //                     if (uart_transmit_enable == 1) begin
//////                               uart_data <= {sus, key}; // Data to send (sw bits)
////        //                     end
////                             uart_data <= 8'b11111111;
////                             uart_tx_state <= 4'b10;
////                             uart_bit_count <= 4'b0000;
////                          end
//////                          4'b01: begin
//////                             tx <= uart_data[0];
//////                             uart_data <= {1'b0, uart_data[7:1]}; // Shift data to the right
//////                             uart_tx_state <= 4'b10;
//////                             uart_bit_count <= uart_bit_count + 1;
//////                          end
////                          4'b10: begin
////                             if (uart_bit_count == 7) begin
////                                tx <= 1; // Stop bit
////                                sendflag <= 0;
////                                uart_tx_state <= 4'b00;
////                             end else begin
////                                tx <= uart_data[0];
////                                tx <= 4;
////                                uart_data <= {uart_data[6:0], 1'b0}; // Shift data to the right
////                                uart_tx_state <= 4'b10;
////                             end
////                             uart_bit_count <= uart_bit_count + 1;
////                          end
////                       endcase
////                end 
////               end
////           else begin
////                counter <= counter + 1;
////           end

        
        
        
//        // debounce logic
//            C_debounce = {C, C_debounce[2:1]};
//            D_debounce = {D, D_debounce[2:1]};
//            E_debounce = {E, E_debounce[2:1]};
//            F_debounce = {F, F_debounce[2:1]};
//            G_debounce = {G, G_debounce[2:1]};

//            if (C_debounce == 3'b001) begin
//                pitch <= 0;
//                sendflag <= 1;
//            end

//            if (D_debounce == 3'b001) begin
//                pitch <= 1;
//                sendflag <= 1;
//            end

//            if (E_debounce == 3'b001) begin
//                pitch <= 2;
//                sendflag <= 1;
//            end

//            if (F_debounce == 3'b001) begin
//                pitch <= 3;
//                sendflag <= 1;
//            end

//            if (G_debounce == 3'b001) begin
//                pitch <= 4;
//                sendflag <= 1;
//            end

//            quality = sw[0];
//            sus = sw[1];
//            key = {quality, pitch};
            
//            case(key)
//                4'b0000: char1 = "C";
//                4'b0001: char1 = "D";
//                4'b0010: char1 = "E";
//                4'b0011: char1 = "F";
//                4'b0100: char1 = "G";
//                4'b1000: char1 = "C";
//                4'b1001: char1 = "D";
//                4'b1010: char1 = "E";
//                4'b1011: char1 = "F";
//                4'b1100: char1 = "G";
//                default: char1 = 0;
//            endcase
//        end
    
//    // this should run the refresh counter, to which the led thing will activiate
//        always @(posedge clk)
//           begin 
//               refresh_counter <= refresh_counter + 1;
//               LED_activating_counter = refresh_counter[19:18];
//           end 
    
//    // a;ways running , setting the an and led to correct number
//        always @(*) begin
//           case(LED_activating_counter)
//               2'b00: begin
//                    an = 4'b0111;
//                    led_char = char1;
                    
//                    $display("first an %b num %b", an, reg_out);
//                    end
//               2'b01: begin
//                    an = 4'b1011;

//                    led_char = char2;
//                    $display("second an %b num %b", an, reg_out);
//                     end
//               2'b10: begin
//                    an = 4'b1101;
//                    led_char = char3;
                    
//                    $display("third an %b num %b", an, reg_out);
//                       end
//               2'b11: begin
//                    an = 4'b1110;
//                    led_char = char4;
                    
//                    $display("fourth an %b num %b", an, reg_out);
//                      end
//           default: begin
//               an = 4'b1110;
//               led_char = "G";   
//               $display("error an %b num %b", an, reg_out);
//               end
//           endcase
//           led = {key};
//           led[4] = sus;
//       end
    
    
    
    
//    always @(*) begin // binary or ASCII for letters?
//        case (led_char)
//        "A": reg_out = 7'b0001000; // "A" (LED ON)
//        "B": reg_out = 7'b1100000; // "B" (LED ON)
//        "C": reg_out = 7'b1000110; // "C" (LED ON)
//        "D": reg_out = 7'b0100001; // "D" (LED ON)
//        "E": reg_out = 7'b0000110; // "E" (LED ON)
//        "F": reg_out = 7'b0001110; // "F" (LED ON)
//        "G": reg_out = 7'b1000010; // "G" (LED ON)
//         default: reg_out = 7'b1111111; // "0" (default case, LED OFF)
//        endcase
//    end
    
    
    
//endmodule









////        8'b00110000: reg_out = 7'b1000000; // "0" (LED ON)
////        8'b00110001: reg_out = 7'b1111001; // "1" (LED ON)
////        8'b00110010: reg_out = 7'b0100100; // "2" (LED ON)
////        8'b00110011: reg_out = 7'b0110000; // "3" (LED ON)
////        8'b00110100: reg_out = 7'b0011001; // "4" (LED ON)
////        8'b00110101: reg_out = 7'b0010010; // "5" (LED ON)
////        8'b00110110: reg_out = 7'b0000010; // "6" (LED ON)
////        8'b00110111: reg_out = 7'b1111000; // "7" (LED ON)
////        8'b00111000: reg_out = 7'b0000000; // "8" (LED ON)
////        8'b00111001: reg_out = 7'b0010000; // "9" (LED ON)
////         8'b01000001: reg_out = 7'b0001000; // "A" (LED ON)
////         8'b01000010: reg_out = 7'b1100000; // "B" (LED ON)
////         8'b01000011: reg_out = 7'b1000110; // "C" (LED ON)
////         8'b01000100: reg_out = 7'b1000010; // "D" (LED ON)
////         8'b01000101: reg_out = 7'b0110000; // "E" (LED ON)
////         8'b01000110: reg_out = 7'b0111000; // "F" (LED ON)
////         8'b01000111: reg_out = 7'b0100001; // "G" (LED ON)
////         8'b01001000: reg_out = 7'b0001001; // "H" (LED ON)
////         8'b01001001: reg_out = 7'b1111001; // "I" (LED ON)
////         8'b01001010: reg_out = 7'b1100001; // "J" (LED ON)
////         8'b01001011: reg_out = 7'b0001001; // "K" (LED ON)
////         8'b01001100: reg_out = 7'b1000111; // "L" (LED ON)
////         8'b01001101: reg_out = 7'b0101000; // "M" (LED ON)???
////         8'b01001110: reg_out = 7'b0001001; // "N" (LED ON)
////         8'b01001111: reg_out = 7'b0000001; // "O" (LED ON)
////         8'b01100000: reg_out = 7'b0001111; // "P" (LED ON)
////         8'b01100001: reg_out = 7'b0010010; // "Q" (LED ON)
////         8'b01100010: reg_out = 7'b1101110; // "R" (LED ON)
////         8'b01100011: reg_out = 7'b0010010; // "S" (LED ON)
////         8'b01100100: reg_out = 7'b0000111; // "T" (LED ON)
////         8'b01100101: reg_out = 7'b1000001; // "U" (LED ON)
////         8'b01100110: reg_out = 7'b1000011; // "V" (LED ON)
////         8'b01100111: reg_out = 7'b0101010; // "W" (LED ON)
////         8'b01101000: reg_out = 7'b0110110; // "X" (LED ON)
////         8'b01101001: reg_out = 7'b0010110; // "Y" (LED ON)
////         8'b01101010: reg_out = 7'b0101101; // "Z" (LED ON)