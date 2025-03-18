module ram();
	input wire clk;
	input wire [4:0] wr_addr,rd_addr;
	input wire we,re;   // write & read enable signal
	input wire [31:0] wr_data; // write data
	output reg [31:0] rd_data;		// read data

  reg [31:0] mem_array [31:0];
	
  always@(posedge clk) begin
	    if(we) begin
			    mem_array[wr_addr] <= wr_data;
		  end 
	end
	
  always@(posedge clk) begin	
	  	if(re) begin
		    	rd_data <= mem_array[rd_addr];
		  end	
	end
endmodule 


module sync_fifo();
	input wire clk;
	input wire rst_n;
	input wire we;
	input wire re;
	input wire [31:0] wr_data;
	output [31:0] rd_data;
	output fifo_full, fifo_empty;
	
	reg [5:0] wr_ptr, rd_ptr;
	wire wr_valid, rd_valid;
	
	
	assign wr_valid = (!fifo_full &&  we && rst_n);
	assign rd_valid = (!fifo_empty && re && rst_n);
	
	always@(posedge clk or negedge rst_n) begin
  		if(!rst_n) begin
	    		wr_ptr <= 6'd0;
		  end else if(wr_valid) begin
			    wr_ptr <= wr_ptr + 6'd1; 
		  end
	end
	
	always@(posedge clk or negedge rst_n) begin
		  if(!rst_n) begin
			    rd_ptr <= 6'd0;
		  end else if(rd_valid) begin
			  	rd_ptr <= rd_ptr + 6'd1;
		  end
	end
	
	assign fifo_full = rst_n && (wr_ptr[4:0] == rd_ptr[4:0] && wr_ptr[5] != rd_ptr[5]);
	assign fifo_empty = !rst_n || (wr_ptr == rd_ptr);

	ram inst(.clk(clk),
			 .wr_addr(wr_ptr[4:0]),
			 .rd_addr(rd_ptr[4:0]),
			 .re(rd_valid),
			 .we(wr_valid),
			 .rd_data(rd_data),
			 .wr_data(wr_data)
			);
endmodule
