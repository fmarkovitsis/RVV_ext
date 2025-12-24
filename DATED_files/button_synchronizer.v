/* 
 *
 * button_synchronizer: Synchronizes raw button signal
 * 
 * input : clk, button
 * output: syncronized button (new_button)
 *
 * Implementation: 
 *   Uses 2 flip-flops. 
 *   The first one is to ensure that there will be no setup problem
 *   and the second one is for the metastability. The first flip-flop
 *   is has the button as input and the second one has as input the
 *   output of the first flip-flop. The output of the second flip-flop
 *   is the synchronized button. This way, the synchronized button
 *   will be stable after 2 clock cycles.
 */

module button_synchronizer(clk, button, new_button);
	input clk, button;
	output new_button;
	
	reg new_button, f1_output;

	always @(posedge clk) begin
		f1_output <= button;
		new_button <= f1_output;
	end

endmodule