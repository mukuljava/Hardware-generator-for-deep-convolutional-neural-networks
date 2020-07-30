module multi_64_33_9_10_16_30(clk, reset, s_data_in_x, s_valid_x, s_ready_x, m_data_out_y, m_valid_y, m_ready_y);
    parameter                      T = 16;
    input                          clk, reset, s_valid_x, m_ready_y;
    input signed [T-1:0]           s_data_in_x;
    output logic                   s_ready_x, m_valid_y;
    output logic signed [T-1:0]    m_data_out_y;
    logic                          m_ready_y1, m_ready_y2;
    logic                          m_valid_y1, m_valid_y2;
    logic signed [T-1:0]           m_data_out_y1, m_data_out_y2;
    layer1_64_33_16_16 l1(.clk(clk), .reset(reset), .s_data_in_x(s_data_in_x), .s_valid_x(s_valid_x), .s_ready_x(s_ready_x),
                       .m_data_out_y(m_data_out_y1), .m_valid_y(m_valid_y1), .m_ready_y(m_ready_y1));
    layer2_32_9_16_12 l2(.clk(clk), .reset(reset), .s_data_in_x(m_data_out_y1), .s_valid_x(m_valid_y1), .s_ready_x(m_ready_y1),
                       .m_data_out_y(m_data_out_y2), .m_valid_y(m_valid_y2), .m_ready_y(m_ready_y2));
    layer3_24_10_16_1 l3(.clk(clk), .reset(reset), .s_data_in_x(m_data_out_y2), .s_valid_x(m_valid_y2), .s_ready_x(m_ready_y2),
                      .m_data_out_y(m_data_out_y), .m_valid_y(m_valid_y), .m_ready_y(m_ready_y));
endmodule
module layer1_64_33_16_16(clk, reset, s_data_in_x, s_valid_x, s_ready_x, m_data_out_y, m_valid_y, m_ready_y);
    parameter                      T = 16, X_COUNT = 64, F_COUNT = 33, ADDR_X = $clog2(X_COUNT), ADDR_F = $clog2(F_COUNT);
    input                          clk, reset, s_valid_x, m_ready_y;
    input signed [T-1:0]           s_data_in_x;
    output logic                   s_ready_x, m_valid_y;
    output logic signed [T-1:0]    m_data_out_y;
    logic [ADDR_X-1:0]             addr_x1, addr_x2, addr_x3, addr_x4, addr_x5, addr_x6, addr_x7, addr_x8, addr_x9, addr_x10, addr_x11, addr_x12, addr_x13, addr_x14, addr_x15, addr_x16;
    logic [ADDR_F-1:0]             addr_f;
    logic                          wr_en_x, clear_acc, en_acc, op_done;
    datapath1 d(.clk(clk), .reset(reset), .s_data_in_x(s_data_in_x), .wr_en_x(wr_en_x), .clear_acc(clear_acc), .en_acc(en_acc),
               .m_data_out_y(m_data_out_y), .m_valid_y(m_valid_y), .m_ready_y(m_ready_y), .op_done(op_done), .addr_f(addr_f),
               .addr_x1(addr_x1), .addr_x2(addr_x2), .addr_x3(addr_x3), .addr_x4(addr_x4), .addr_x5(addr_x5), .addr_x6(addr_x6), .addr_x7(addr_x7), .addr_x8(addr_x8), .addr_x9(addr_x9), .addr_x10(addr_x10), .addr_x11(addr_x11), .addr_x12(addr_x12), .addr_x13(addr_x13), .addr_x14(addr_x14), .addr_x15(addr_x15), .addr_x16(addr_x16));
    ctrlpath1 c(.clk(clk), .reset(reset), .s_valid_x(s_valid_x), .m_ready_y(m_ready_y), .wr_en_x(wr_en_x), .clear_acc(clear_acc),
               .en_acc(en_acc), .s_ready_x(s_ready_x), .m_valid_y(m_valid_y), .op_done(op_done), .addr_f(addr_f),
               .addr_x1(addr_x1), .addr_x2(addr_x2), .addr_x3(addr_x3), .addr_x4(addr_x4), .addr_x5(addr_x5), .addr_x6(addr_x6), .addr_x7(addr_x7), .addr_x8(addr_x8), .addr_x9(addr_x9), .addr_x10(addr_x10), .addr_x11(addr_x11), .addr_x12(addr_x12), .addr_x13(addr_x13), .addr_x14(addr_x14), .addr_x15(addr_x15), .addr_x16(addr_x16));
endmodule

module datapath1 (clk, reset, s_data_in_x, wr_en_x, clear_acc, en_acc, m_data_out_y, m_valid_y, m_ready_y, op_done, addr_f,
                 addr_x1, addr_x2, addr_x3, addr_x4, addr_x5, addr_x6, addr_x7, addr_x8, addr_x9, addr_x10, addr_x11, addr_x12, addr_x13, addr_x14, addr_x15, addr_x16);
    parameter                      T = 16, P = 16, X_COUNT = 64, F_COUNT = 33, ADDR_X = $clog2(X_COUNT), ADDR_F = $clog2(F_COUNT);
    input                          clk, reset, wr_en_x, clear_acc, en_acc;
    input signed [T-1:0]           s_data_in_x;
    input [ADDR_X-1:0]             addr_x1, addr_x2, addr_x3, addr_x4, addr_x5, addr_x6, addr_x7, addr_x8, addr_x9, addr_x10, addr_x11, addr_x12, addr_x13, addr_x14, addr_x15, addr_x16;
    input [ADDR_F-1:0]             addr_f;
    logic signed [T-1:0]           m_data_out_y1, m_data_out_y2, m_data_out_y3, m_data_out_y4, m_data_out_y5, m_data_out_y6, m_data_out_y7, m_data_out_y8, m_data_out_y9, m_data_out_y10, m_data_out_y11, m_data_out_y12, m_data_out_y13, m_data_out_y14, m_data_out_y15, m_data_out_y16;
    logic signed [T-1:0]           s_data_out_f, s_data_out_x1, s_data_out_x2, s_data_out_x3, s_data_out_x4, s_data_out_x5, s_data_out_x6, s_data_out_x7, s_data_out_x8, s_data_out_x9, s_data_out_x10, s_data_out_x11, s_data_out_x12, s_data_out_x13, s_data_out_x14, s_data_out_x15, s_data_out_x16;
    output logic signed [T-1:0]    m_data_out_y;
    input logic                    m_valid_y, m_ready_y;
    logic [P:0]                    counter2;
    output logic                   op_done;
    layer1_64_33_16_16_f_rom rom(.clk(clk), .addr(addr_f), .z(s_data_out_f));
    memory1 #(T, X_COUNT, ADDR_X) x_mem1(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x1), .addr(addr_x1), .wr_en(wr_en_x));
    memory1 #(T, X_COUNT, ADDR_X) x_mem2(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x2), .addr(addr_x2), .wr_en(wr_en_x));
    memory1 #(T, X_COUNT, ADDR_X) x_mem3(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x3), .addr(addr_x3), .wr_en(wr_en_x));
    memory1 #(T, X_COUNT, ADDR_X) x_mem4(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x4), .addr(addr_x4), .wr_en(wr_en_x));
    memory1 #(T, X_COUNT, ADDR_X) x_mem5(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x5), .addr(addr_x5), .wr_en(wr_en_x));
    memory1 #(T, X_COUNT, ADDR_X) x_mem6(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x6), .addr(addr_x6), .wr_en(wr_en_x));
    memory1 #(T, X_COUNT, ADDR_X) x_mem7(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x7), .addr(addr_x7), .wr_en(wr_en_x));
    memory1 #(T, X_COUNT, ADDR_X) x_mem8(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x8), .addr(addr_x8), .wr_en(wr_en_x));
    memory1 #(T, X_COUNT, ADDR_X) x_mem9(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x9), .addr(addr_x9), .wr_en(wr_en_x));
    memory1 #(T, X_COUNT, ADDR_X) x_mem10(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x10), .addr(addr_x10), .wr_en(wr_en_x));
    memory1 #(T, X_COUNT, ADDR_X) x_mem11(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x11), .addr(addr_x11), .wr_en(wr_en_x));
    memory1 #(T, X_COUNT, ADDR_X) x_mem12(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x12), .addr(addr_x12), .wr_en(wr_en_x));
    memory1 #(T, X_COUNT, ADDR_X) x_mem13(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x13), .addr(addr_x13), .wr_en(wr_en_x));
    memory1 #(T, X_COUNT, ADDR_X) x_mem14(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x14), .addr(addr_x14), .wr_en(wr_en_x));
    memory1 #(T, X_COUNT, ADDR_X) x_mem15(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x15), .addr(addr_x15), .wr_en(wr_en_x));
    memory1 #(T, X_COUNT, ADDR_X) x_mem16(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x16), .addr(addr_x16), .wr_en(wr_en_x));
    mac1 m1 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x1), .inf(s_data_out_f), .out(m_data_out_y1),
        	.m_valid_y(m_valid_y));
    mac1 m2 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x2), .inf(s_data_out_f), .out(m_data_out_y2),
        	.m_valid_y(m_valid_y));
    mac1 m3 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x3), .inf(s_data_out_f), .out(m_data_out_y3),
        	.m_valid_y(m_valid_y));
    mac1 m4 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x4), .inf(s_data_out_f), .out(m_data_out_y4),
        	.m_valid_y(m_valid_y));
    mac1 m5 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x5), .inf(s_data_out_f), .out(m_data_out_y5),
        	.m_valid_y(m_valid_y));
    mac1 m6 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x6), .inf(s_data_out_f), .out(m_data_out_y6),
        	.m_valid_y(m_valid_y));
    mac1 m7 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x7), .inf(s_data_out_f), .out(m_data_out_y7),
        	.m_valid_y(m_valid_y));
    mac1 m8 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x8), .inf(s_data_out_f), .out(m_data_out_y8),
        	.m_valid_y(m_valid_y));
    mac1 m9 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x9), .inf(s_data_out_f), .out(m_data_out_y9),
        	.m_valid_y(m_valid_y));
    mac1 m10 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x10), .inf(s_data_out_f), .out(m_data_out_y10),
        	.m_valid_y(m_valid_y));
    mac1 m11 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x11), .inf(s_data_out_f), .out(m_data_out_y11),
        	.m_valid_y(m_valid_y));
    mac1 m12 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x12), .inf(s_data_out_f), .out(m_data_out_y12),
        	.m_valid_y(m_valid_y));
    mac1 m13 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x13), .inf(s_data_out_f), .out(m_data_out_y13),
        	.m_valid_y(m_valid_y));
    mac1 m14 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x14), .inf(s_data_out_f), .out(m_data_out_y14),
        	.m_valid_y(m_valid_y));
    mac1 m15 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x15), .inf(s_data_out_f), .out(m_data_out_y15),
        	.m_valid_y(m_valid_y));
    mac1 m16 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x16), .inf(s_data_out_f), .out(m_data_out_y16),
        	.m_valid_y(m_valid_y));

    always_comb begin
        if((m_valid_y == 1) & (m_ready_y == 1)) begin
            if(counter2 == 0) begin
                m_data_out_y = m_data_out_y1;
            end
            else if(counter2 ==1) begin
                m_data_out_y = m_data_out_y2;
            end
            else if(counter2 ==2) begin
                m_data_out_y = m_data_out_y3;
            end
            else if(counter2 ==3) begin
                m_data_out_y = m_data_out_y4;
            end
            else if(counter2 ==4) begin
                m_data_out_y = m_data_out_y5;
            end
            else if(counter2 ==5) begin
                m_data_out_y = m_data_out_y6;
            end
            else if(counter2 ==6) begin
                m_data_out_y = m_data_out_y7;
            end
            else if(counter2 ==7) begin
                m_data_out_y = m_data_out_y8;
            end
            else if(counter2 ==8) begin
                m_data_out_y = m_data_out_y9;
            end
            else if(counter2 ==9) begin
                m_data_out_y = m_data_out_y10;
            end
            else if(counter2 ==10) begin
                m_data_out_y = m_data_out_y11;
            end
            else if(counter2 ==11) begin
                m_data_out_y = m_data_out_y12;
            end
            else if(counter2 ==12) begin
                m_data_out_y = m_data_out_y13;
            end
            else if(counter2 ==13) begin
                m_data_out_y = m_data_out_y14;
            end
            else if(counter2 ==14) begin
                m_data_out_y = m_data_out_y15;
            end
            else if(counter2 ==15) begin
                m_data_out_y = m_data_out_y16;
            end
            else begin
                m_data_out_y = 0;
            end
        end
        else begin
            m_data_out_y = 0;
        end
    end
    assign op_done = (m_valid_y == 1) & (m_ready_y == 1) & (counter2 == P-1); 
    always_ff @(posedge clk) begin
        if (reset == 1) begin
            counter2 <= 0;
        end
        if((m_valid_y == 1) & (m_ready_y == 1)) begin
            counter2 <= counter2 + 1;
        end
        else if((m_valid_y == 0) & (m_ready_y == 1)) begin
            counter2 <= 0;
        end
        else if((m_valid_y == 0) & (m_ready_y == 0)) begin
            counter2 <= 0;
        end
    end
endmodule

module ctrlpath1 (clk, reset, s_valid_x, m_ready_y, wr_en_x, clear_acc, en_acc, s_ready_x, m_valid_y, op_done, addr_f,
                 addr_x1, addr_x2, addr_x3, addr_x4, addr_x5, addr_x6, addr_x7, addr_x8, addr_x9, addr_x10, addr_x11, addr_x12, addr_x13, addr_x14, addr_x15, addr_x16);
    parameter                      T = 16, P = 16, X_COUNT = 64, F_COUNT = 33, ADDR_X = $clog2(X_COUNT), ADDR_F = $clog2(F_COUNT),
	                               OP_COUNT = X_COUNT-F_COUNT+1, COUNTER_V = $clog2(OP_COUNT);
    input logic                    clk, reset, s_valid_x, m_ready_y;
    output logic                   s_ready_x, m_valid_y;
    output logic [ADDR_X-1:0]             addr_x1, addr_x2, addr_x3, addr_x4, addr_x5, addr_x6, addr_x7, addr_x8, addr_x9, addr_x10, addr_x11, addr_x12, addr_x13, addr_x14, addr_x15, addr_x16;
    output logic [ADDR_F-1:0]      addr_f;
    output logic                   wr_en_x, clear_acc, en_acc;
    logic                          wr_done_x, loaded_x; 
    logic [COUNTER_V + 1:0]        counter;
    logic [ADDR_F:0]               counter1;
    input logic                    op_done;
    always_ff @(posedge clk) begin
        if (reset == 1) begin
            s_ready_x <= 1;
            addr_x1<= 0;
            addr_x2<= 0;
            addr_x3<= 0;
            addr_x4<= 0;
            addr_x5<= 0;
            addr_x6<= 0;
            addr_x7<= 0;
            addr_x8<= 0;
            addr_x9<= 0;
            addr_x10<= 0;
            addr_x11<= 0;
            addr_x12<= 0;
            addr_x13<= 0;
            addr_x14<= 0;
            addr_x15<= 0;
            addr_x16<= 0;
            addr_f <= 0;
            counter1 <= 0;
            en_acc <= 0;
            counter <= P;
            wr_done_x <= 0;
            m_valid_y <= 0;
        end
        if (wr_en_x == 1) begin
            addr_x1 <= addr_x1 + 1;
            addr_x2 <= addr_x2 + 1;
            addr_x3 <= addr_x3 + 1;
            addr_x4 <= addr_x4 + 1;
            addr_x5 <= addr_x5 + 1;
            addr_x6 <= addr_x6 + 1;
            addr_x7 <= addr_x7 + 1;
            addr_x8 <= addr_x8 + 1;
            addr_x9 <= addr_x9 + 1;
            addr_x10 <= addr_x10 + 1;
            addr_x11 <= addr_x11 + 1;
            addr_x12 <= addr_x12 + 1;
            addr_x13 <= addr_x13 + 1;
            addr_x14 <= addr_x14 + 1;
            addr_x15 <= addr_x15 + 1;
            addr_x16 <= addr_x16 + 1;
        end
        if (loaded_x == 1) begin
            addr_x1 <= 0;
            addr_x2 <= 1;
            addr_x3 <= 2;
            addr_x4 <= 3;
            addr_x5 <= 4;
            addr_x6 <= 5;
            addr_x7 <= 6;
            addr_x8 <= 7;
            addr_x9 <= 8;
            addr_x10 <= 9;
            addr_x11 <= 10;
            addr_x12 <= 11;
            addr_x13 <= 12;
            addr_x14 <= 13;
            addr_x15 <= 14;
            addr_x16 <= 15;
            addr_f <= 0;
            counter1 <= 0;
            s_ready_x <= 0;
        end
        if ((s_ready_x == 0) & (m_valid_y == 0)) begin
            if (counter < OP_COUNT+1) begin
                if (counter1 == 1) begin
                    en_acc <= 1;
                end
                else if (counter1 == F_COUNT+1) begin
                    en_acc <= 0;
                end
                if (counter1 < F_COUNT+1) begin
                    addr_x1 <= addr_x1 + 1;
                    addr_x2 <= addr_x2 + 1;
                    addr_x3 <= addr_x3 + 1;
                    addr_x4 <= addr_x4 + 1;
                    addr_x5 <= addr_x5 + 1;
                    addr_x6 <= addr_x6 + 1;
                    addr_x7 <= addr_x7 + 1;
                    addr_x8 <= addr_x8 + 1;
                    addr_x9 <= addr_x9 + 1;
                    addr_x10 <= addr_x10 + 1;
                    addr_x11 <= addr_x11 + 1;
                    addr_x12 <= addr_x12 + 1;
                    addr_x13 <= addr_x13 + 1;
                    addr_x14 <= addr_x14 + 1;
                    addr_x15 <= addr_x15 + 1;
                    addr_x16 <= addr_x16 + 1;
                    addr_f <=  addr_f + 1;
                    counter1 <= counter1 + 1;
                end
                else begin
                    m_valid_y <= 1;
                    counter <= counter + P;
                    addr_x1 <= counter + 0;
                    addr_x2 <= counter + 1;
                    addr_x3 <= counter + 2;
                    addr_x4 <= counter + 3;
                    addr_x5 <= counter + 4;
                    addr_x6 <= counter + 5;
                    addr_x7 <= counter + 6;
                    addr_x8 <= counter + 7;
                    addr_x9 <= counter + 8;
                    addr_x10 <= counter + 9;
                    addr_x11 <= counter + 10;
                    addr_x12 <= counter + 11;
                    addr_x13 <= counter + 12;
                    addr_x14 <= counter + 13;
                    addr_x15 <= counter + 14;
                    addr_x16 <= counter + 15;
                    addr_f <= 0;
                    counter1 <= 0;
                end
            end
            else begin
                addr_x1<= 0;
                addr_x2<= 0;
                addr_x3<= 0;
                addr_x4<= 0;
                addr_x5<= 0;
                addr_x6<= 0;
                addr_x7<= 0;
                addr_x8<= 0;
                addr_x9<= 0;
                addr_x10<= 0;
                addr_x11<= 0;
                addr_x12<= 0;
                addr_x13<= 0;
                addr_x14<= 0;
                addr_x15<= 0;
                addr_x16<= 0;
                addr_f <= 0;
                counter1 <= 0;
                s_ready_x <= 1;
                counter <= P;
            end
        end
        if (clear_acc == 1) begin
            m_valid_y <= 0;
        end
    end
    assign wr_en_x = (s_ready_x == 1) & (s_valid_x == 1);
    assign loaded_x = (addr_x1 == X_COUNT-1) & (wr_en_x == 1);
    assign clear_acc = (m_valid_y == 1) & (m_ready_y == 1) & (op_done == 1);

endmodule

module mac1(clk, en_acc, reset, clear_acc, inx, inf, out, m_valid_y);
    parameter                    T = 16, MAX_VAL = ((1<<(T-1))-1), MIN_VAL = (-1*(1<<(T-1)));
    input                        clk, clear_acc, reset;
    input signed [T-1:0]         inx, inf;
    output logic signed[T-1:0]   out;
    logic signed[T:0]            out_temp;
    logic signed[T-1:0]          mul;
    logic signed[2*T-1:0]        mul_temp;
    input                        en_acc;
    input logic                  m_valid_y;

    always_ff @(posedge clk)
    begin
        mul_temp <= inx * inf;
    end

    always_ff @(posedge clk) begin
        if (reset == 1) begin
           out_temp <= 0;
        end
        else if (clear_acc == 1) begin
           out_temp <= 0;
        end
         else if(en_acc == 1) begin
           out_temp <= mul + out;
        end
    end

    always_comb begin
        if(mul_temp>MAX_VAL) begin
            mul = MAX_VAL;
        end
        else if(mul_temp<MIN_VAL) begin
            mul = MIN_VAL;
        end
        else begin
            mul = mul_temp;
        end

        if(m_valid_y == 1) begin
            if(out_temp < 0) begin
                out = 0;
            end
            else if(out_temp>MAX_VAL) begin
                out = MAX_VAL;
            end
            else begin
                out = out_temp;
            end
        end
        else if(out_temp>MAX_VAL) begin
            out = MAX_VAL;
        end
        else if(out_temp<MIN_VAL)begin 
            out = MIN_VAL;
        end
        else begin
            out = out_temp;
        end
    end
endmodule

module memory1(clk, data_in, data_out, addr, wr_en);
    parameter                   WIDTH=16, SIZE=64, LOGSIZE=6;
    input [WIDTH-1:0]           data_in;
    output logic [WIDTH-1:0]    data_out;
    input [LOGSIZE-1:0]         addr;
    input                       clk, wr_en;

    logic [SIZE-1:0][WIDTH-1:0] mem;

    always_ff @(posedge clk) begin
        data_out <= mem[addr];
        if (wr_en)
            mem[addr] <= data_in;
    end
endmodule

module layer1_64_33_16_16_f_rom(clk, addr, z);
   input clk;
   input [5:0] addr;
   output logic signed [15:0] z;
   always_ff @(posedge clk) begin
      case(addr)
        0: z <= -16'd208;
        1: z <= 16'd135;
        2: z <= 16'd50;
        3: z <= 16'd32;
        4: z <= -16'd60;
        5: z <= -16'd82;
        6: z <= -16'd26;
        7: z <= 16'd143;
        8: z <= 16'd36;
        9: z <= -16'd38;
        10: z <= -16'd75;
        11: z <= 16'd21;
        12: z <= 16'd52;
        13: z <= -16'd106;
        14: z <= -16'd239;
        15: z <= -16'd149;
        16: z <= -16'd45;
        17: z <= -16'd51;
        18: z <= 16'd39;
        19: z <= -16'd203;
        20: z <= 16'd7;
        21: z <= 16'd161;
        22: z <= -16'd144;
        23: z <= 16'd63;
        24: z <= 16'd226;
        25: z <= -16'd23;
        26: z <= -16'd255;
        27: z <= 16'd169;
        28: z <= 16'd187;
        29: z <= -16'd156;
        30: z <= 16'd141;
        31: z <= 16'd235;
        32: z <= 16'd235;
      endcase
   end
endmodule

module layer2_32_9_16_12(clk, reset, s_data_in_x, s_valid_x, s_ready_x, m_data_out_y, m_valid_y, m_ready_y);
    parameter                      T = 16, X_COUNT = 32, F_COUNT = 9, ADDR_X = $clog2(X_COUNT), ADDR_F = $clog2(F_COUNT);
    input                          clk, reset, s_valid_x, m_ready_y;
    input signed [T-1:0]           s_data_in_x;
    output logic                   s_ready_x, m_valid_y;
    output logic signed [T-1:0]    m_data_out_y;
    logic [ADDR_X-1:0]             addr_x1, addr_x2, addr_x3, addr_x4, addr_x5, addr_x6, addr_x7, addr_x8, addr_x9, addr_x10, addr_x11, addr_x12;
    logic [ADDR_F-1:0]             addr_f;
    logic                          wr_en_x, clear_acc, en_acc, op_done;
    datapath2 d(.clk(clk), .reset(reset), .s_data_in_x(s_data_in_x), .wr_en_x(wr_en_x), .clear_acc(clear_acc), .en_acc(en_acc),
               .m_data_out_y(m_data_out_y), .m_valid_y(m_valid_y), .m_ready_y(m_ready_y), .op_done(op_done), .addr_f(addr_f),
               .addr_x1(addr_x1), .addr_x2(addr_x2), .addr_x3(addr_x3), .addr_x4(addr_x4), .addr_x5(addr_x5), .addr_x6(addr_x6), .addr_x7(addr_x7), .addr_x8(addr_x8), .addr_x9(addr_x9), .addr_x10(addr_x10), .addr_x11(addr_x11), .addr_x12(addr_x12));
    ctrlpath2 c(.clk(clk), .reset(reset), .s_valid_x(s_valid_x), .m_ready_y(m_ready_y), .wr_en_x(wr_en_x), .clear_acc(clear_acc),
               .en_acc(en_acc), .s_ready_x(s_ready_x), .m_valid_y(m_valid_y), .op_done(op_done), .addr_f(addr_f),
               .addr_x1(addr_x1), .addr_x2(addr_x2), .addr_x3(addr_x3), .addr_x4(addr_x4), .addr_x5(addr_x5), .addr_x6(addr_x6), .addr_x7(addr_x7), .addr_x8(addr_x8), .addr_x9(addr_x9), .addr_x10(addr_x10), .addr_x11(addr_x11), .addr_x12(addr_x12));
endmodule

module datapath2 (clk, reset, s_data_in_x, wr_en_x, clear_acc, en_acc, m_data_out_y, m_valid_y, m_ready_y, op_done, addr_f,
                 addr_x1, addr_x2, addr_x3, addr_x4, addr_x5, addr_x6, addr_x7, addr_x8, addr_x9, addr_x10, addr_x11, addr_x12);
    parameter                      T = 16, P = 12, X_COUNT = 32, F_COUNT = 9, ADDR_X = $clog2(X_COUNT), ADDR_F = $clog2(F_COUNT);
    input                          clk, reset, wr_en_x, clear_acc, en_acc;
    input signed [T-1:0]           s_data_in_x;
    input [ADDR_X-1:0]             addr_x1, addr_x2, addr_x3, addr_x4, addr_x5, addr_x6, addr_x7, addr_x8, addr_x9, addr_x10, addr_x11, addr_x12;
    input [ADDR_F-1:0]             addr_f;
    logic signed [T-1:0]           m_data_out_y1, m_data_out_y2, m_data_out_y3, m_data_out_y4, m_data_out_y5, m_data_out_y6, m_data_out_y7, m_data_out_y8, m_data_out_y9, m_data_out_y10, m_data_out_y11, m_data_out_y12;
    logic signed [T-1:0]           s_data_out_f, s_data_out_x1, s_data_out_x2, s_data_out_x3, s_data_out_x4, s_data_out_x5, s_data_out_x6, s_data_out_x7, s_data_out_x8, s_data_out_x9, s_data_out_x10, s_data_out_x11, s_data_out_x12;
    output logic signed [T-1:0]    m_data_out_y;
    input logic                    m_valid_y, m_ready_y;
    logic [P:0]                    counter2;
    output logic                   op_done;
    layer2_32_9_16_12_f_rom rom(.clk(clk), .addr(addr_f), .z(s_data_out_f));
    memory2 #(T, X_COUNT, ADDR_X) x_mem1(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x1), .addr(addr_x1), .wr_en(wr_en_x));
    memory2 #(T, X_COUNT, ADDR_X) x_mem2(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x2), .addr(addr_x2), .wr_en(wr_en_x));
    memory2 #(T, X_COUNT, ADDR_X) x_mem3(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x3), .addr(addr_x3), .wr_en(wr_en_x));
    memory2 #(T, X_COUNT, ADDR_X) x_mem4(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x4), .addr(addr_x4), .wr_en(wr_en_x));
    memory2 #(T, X_COUNT, ADDR_X) x_mem5(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x5), .addr(addr_x5), .wr_en(wr_en_x));
    memory2 #(T, X_COUNT, ADDR_X) x_mem6(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x6), .addr(addr_x6), .wr_en(wr_en_x));
    memory2 #(T, X_COUNT, ADDR_X) x_mem7(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x7), .addr(addr_x7), .wr_en(wr_en_x));
    memory2 #(T, X_COUNT, ADDR_X) x_mem8(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x8), .addr(addr_x8), .wr_en(wr_en_x));
    memory2 #(T, X_COUNT, ADDR_X) x_mem9(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x9), .addr(addr_x9), .wr_en(wr_en_x));
    memory2 #(T, X_COUNT, ADDR_X) x_mem10(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x10), .addr(addr_x10), .wr_en(wr_en_x));
    memory2 #(T, X_COUNT, ADDR_X) x_mem11(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x11), .addr(addr_x11), .wr_en(wr_en_x));
    memory2 #(T, X_COUNT, ADDR_X) x_mem12(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x12), .addr(addr_x12), .wr_en(wr_en_x));
    mac2 m1 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x1), .inf(s_data_out_f), .out(m_data_out_y1),
        	.m_valid_y(m_valid_y));
    mac2 m2 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x2), .inf(s_data_out_f), .out(m_data_out_y2),
        	.m_valid_y(m_valid_y));
    mac2 m3 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x3), .inf(s_data_out_f), .out(m_data_out_y3),
        	.m_valid_y(m_valid_y));
    mac2 m4 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x4), .inf(s_data_out_f), .out(m_data_out_y4),
        	.m_valid_y(m_valid_y));
    mac2 m5 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x5), .inf(s_data_out_f), .out(m_data_out_y5),
        	.m_valid_y(m_valid_y));
    mac2 m6 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x6), .inf(s_data_out_f), .out(m_data_out_y6),
        	.m_valid_y(m_valid_y));
    mac2 m7 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x7), .inf(s_data_out_f), .out(m_data_out_y7),
        	.m_valid_y(m_valid_y));
    mac2 m8 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x8), .inf(s_data_out_f), .out(m_data_out_y8),
        	.m_valid_y(m_valid_y));
    mac2 m9 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x9), .inf(s_data_out_f), .out(m_data_out_y9),
        	.m_valid_y(m_valid_y));
    mac2 m10 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x10), .inf(s_data_out_f), .out(m_data_out_y10),
        	.m_valid_y(m_valid_y));
    mac2 m11 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x11), .inf(s_data_out_f), .out(m_data_out_y11),
        	.m_valid_y(m_valid_y));
    mac2 m12 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x12), .inf(s_data_out_f), .out(m_data_out_y12),
        	.m_valid_y(m_valid_y));

    always_comb begin
        if((m_valid_y == 1) & (m_ready_y == 1)) begin
            if(counter2 == 0) begin
                m_data_out_y = m_data_out_y1;
            end
            else if(counter2 ==1) begin
                m_data_out_y = m_data_out_y2;
            end
            else if(counter2 ==2) begin
                m_data_out_y = m_data_out_y3;
            end
            else if(counter2 ==3) begin
                m_data_out_y = m_data_out_y4;
            end
            else if(counter2 ==4) begin
                m_data_out_y = m_data_out_y5;
            end
            else if(counter2 ==5) begin
                m_data_out_y = m_data_out_y6;
            end
            else if(counter2 ==6) begin
                m_data_out_y = m_data_out_y7;
            end
            else if(counter2 ==7) begin
                m_data_out_y = m_data_out_y8;
            end
            else if(counter2 ==8) begin
                m_data_out_y = m_data_out_y9;
            end
            else if(counter2 ==9) begin
                m_data_out_y = m_data_out_y10;
            end
            else if(counter2 ==10) begin
                m_data_out_y = m_data_out_y11;
            end
            else if(counter2 ==11) begin
                m_data_out_y = m_data_out_y12;
            end
            else begin
                m_data_out_y = 0;
            end
        end
        else begin
            m_data_out_y = 0;
        end
    end
    assign op_done = (m_valid_y == 1) & (m_ready_y == 1) & (counter2 == P-1); 
    always_ff @(posedge clk) begin
        if (reset == 1) begin
            counter2 <= 0;
        end
        if((m_valid_y == 1) & (m_ready_y == 1)) begin
            counter2 <= counter2 + 1;
        end
        else if((m_valid_y == 0) & (m_ready_y == 1)) begin
            counter2 <= 0;
        end
        else if((m_valid_y == 0) & (m_ready_y == 0)) begin
            counter2 <= 0;
        end
    end
endmodule

module ctrlpath2 (clk, reset, s_valid_x, m_ready_y, wr_en_x, clear_acc, en_acc, s_ready_x, m_valid_y, op_done, addr_f,
                 addr_x1, addr_x2, addr_x3, addr_x4, addr_x5, addr_x6, addr_x7, addr_x8, addr_x9, addr_x10, addr_x11, addr_x12);
    parameter                      T = 16, P = 12, X_COUNT = 32, F_COUNT = 9, ADDR_X = $clog2(X_COUNT), ADDR_F = $clog2(F_COUNT),
	                               OP_COUNT = X_COUNT-F_COUNT+1, COUNTER_V = $clog2(OP_COUNT);
    input logic                    clk, reset, s_valid_x, m_ready_y;
    output logic                   s_ready_x, m_valid_y;
    output logic [ADDR_X-1:0]             addr_x1, addr_x2, addr_x3, addr_x4, addr_x5, addr_x6, addr_x7, addr_x8, addr_x9, addr_x10, addr_x11, addr_x12;
    output logic [ADDR_F-1:0]      addr_f;
    output logic                   wr_en_x, clear_acc, en_acc;
    logic                          wr_done_x, loaded_x; 
    logic [COUNTER_V + 1:0]        counter;
    logic [ADDR_F:0]               counter1;
    input logic                    op_done;
    always_ff @(posedge clk) begin
        if (reset == 1) begin
            s_ready_x <= 1;
            addr_x1<= 0;
            addr_x2<= 0;
            addr_x3<= 0;
            addr_x4<= 0;
            addr_x5<= 0;
            addr_x6<= 0;
            addr_x7<= 0;
            addr_x8<= 0;
            addr_x9<= 0;
            addr_x10<= 0;
            addr_x11<= 0;
            addr_x12<= 0;
            addr_f <= 0;
            counter1 <= 0;
            en_acc <= 0;
            counter <= P;
            wr_done_x <= 0;
            m_valid_y <= 0;
        end
        if (wr_en_x == 1) begin
            addr_x1 <= addr_x1 + 1;
            addr_x2 <= addr_x2 + 1;
            addr_x3 <= addr_x3 + 1;
            addr_x4 <= addr_x4 + 1;
            addr_x5 <= addr_x5 + 1;
            addr_x6 <= addr_x6 + 1;
            addr_x7 <= addr_x7 + 1;
            addr_x8 <= addr_x8 + 1;
            addr_x9 <= addr_x9 + 1;
            addr_x10 <= addr_x10 + 1;
            addr_x11 <= addr_x11 + 1;
            addr_x12 <= addr_x12 + 1;
        end
        if (loaded_x == 1) begin
            addr_x1 <= 0;
            addr_x2 <= 1;
            addr_x3 <= 2;
            addr_x4 <= 3;
            addr_x5 <= 4;
            addr_x6 <= 5;
            addr_x7 <= 6;
            addr_x8 <= 7;
            addr_x9 <= 8;
            addr_x10 <= 9;
            addr_x11 <= 10;
            addr_x12 <= 11;
            addr_f <= 0;
            counter1 <= 0;
            s_ready_x <= 0;
        end
        if ((s_ready_x == 0) & (m_valid_y == 0)) begin
            if (counter < OP_COUNT+1) begin
                if (counter1 == 1) begin
                    en_acc <= 1;
                end
                else if (counter1 == F_COUNT+1) begin
                    en_acc <= 0;
                end
                if (counter1 < F_COUNT+1) begin
                    addr_x1 <= addr_x1 + 1;
                    addr_x2 <= addr_x2 + 1;
                    addr_x3 <= addr_x3 + 1;
                    addr_x4 <= addr_x4 + 1;
                    addr_x5 <= addr_x5 + 1;
                    addr_x6 <= addr_x6 + 1;
                    addr_x7 <= addr_x7 + 1;
                    addr_x8 <= addr_x8 + 1;
                    addr_x9 <= addr_x9 + 1;
                    addr_x10 <= addr_x10 + 1;
                    addr_x11 <= addr_x11 + 1;
                    addr_x12 <= addr_x12 + 1;
                    addr_f <=  addr_f + 1;
                    counter1 <= counter1 + 1;
                end
                else begin
                    m_valid_y <= 1;
                    counter <= counter + P;
                    addr_x1 <= counter + 0;
                    addr_x2 <= counter + 1;
                    addr_x3 <= counter + 2;
                    addr_x4 <= counter + 3;
                    addr_x5 <= counter + 4;
                    addr_x6 <= counter + 5;
                    addr_x7 <= counter + 6;
                    addr_x8 <= counter + 7;
                    addr_x9 <= counter + 8;
                    addr_x10 <= counter + 9;
                    addr_x11 <= counter + 10;
                    addr_x12 <= counter + 11;
                    addr_f <= 0;
                    counter1 <= 0;
                end
            end
            else begin
                addr_x1<= 0;
                addr_x2<= 0;
                addr_x3<= 0;
                addr_x4<= 0;
                addr_x5<= 0;
                addr_x6<= 0;
                addr_x7<= 0;
                addr_x8<= 0;
                addr_x9<= 0;
                addr_x10<= 0;
                addr_x11<= 0;
                addr_x12<= 0;
                addr_f <= 0;
                counter1 <= 0;
                s_ready_x <= 1;
                counter <= P;
            end
        end
        if (clear_acc == 1) begin
            m_valid_y <= 0;
        end
    end
    assign wr_en_x = (s_ready_x == 1) & (s_valid_x == 1);
    assign loaded_x = (addr_x1 == X_COUNT-1) & (wr_en_x == 1);
    assign clear_acc = (m_valid_y == 1) & (m_ready_y == 1) & (op_done == 1);

endmodule

module mac2(clk, en_acc, reset, clear_acc, inx, inf, out, m_valid_y);
    parameter                    T = 16, MAX_VAL = ((1<<(T-1))-1), MIN_VAL = (-1*(1<<(T-1)));
    input                        clk, clear_acc, reset;
    input signed [T-1:0]         inx, inf;
    output logic signed[T-1:0]   out;
    logic signed[T:0]            out_temp;
    logic signed[T-1:0]          mul;
    logic signed[2*T-1:0]        mul_temp;
    input                        en_acc;
    input logic                  m_valid_y;

    always_ff @(posedge clk)
    begin
        mul_temp <= inx * inf;
    end

    always_ff @(posedge clk) begin
        if (reset == 1) begin
           out_temp <= 0;
        end
        else if (clear_acc == 1) begin
           out_temp <= 0;
        end
         else if(en_acc == 1) begin
           out_temp <= mul + out;
        end
    end

    always_comb begin
        if(mul_temp>MAX_VAL) begin
            mul = MAX_VAL;
        end
        else if(mul_temp<MIN_VAL) begin
            mul = MIN_VAL;
        end
        else begin
            mul = mul_temp;
        end

        if(m_valid_y == 1) begin
            if(out_temp < 0) begin
                out = 0;
            end
            else if(out_temp>MAX_VAL) begin
                out = MAX_VAL;
            end
            else begin
                out = out_temp;
            end
        end
        else if(out_temp>MAX_VAL) begin
            out = MAX_VAL;
        end
        else if(out_temp<MIN_VAL)begin 
            out = MIN_VAL;
        end
        else begin
            out = out_temp;
        end
    end
endmodule

module memory2(clk, data_in, data_out, addr, wr_en);
    parameter                   WIDTH=16, SIZE=64, LOGSIZE=6;
    input [WIDTH-1:0]           data_in;
    output logic [WIDTH-1:0]    data_out;
    input [LOGSIZE-1:0]         addr;
    input                       clk, wr_en;

    logic [SIZE-1:0][WIDTH-1:0] mem;

    always_ff @(posedge clk) begin
        data_out <= mem[addr];
        if (wr_en)
            mem[addr] <= data_in;
    end
endmodule

module layer2_32_9_16_12_f_rom(clk, addr, z);
   input clk;
   input [3:0] addr;
   output logic signed [15:0] z;
   always_ff @(posedge clk) begin
      case(addr)
        0: z <= -16'd64;
        1: z <= 16'd12;
        2: z <= -16'd80;
        3: z <= 16'd110;
        4: z <= 16'd242;
        5: z <= -16'd193;
        6: z <= -16'd109;
        7: z <= -16'd51;
        8: z <= -16'd12;
      endcase
   end
endmodule

module layer3_24_10_16_1(clk, reset, s_data_in_x, s_valid_x, s_ready_x, m_data_out_y, m_valid_y, m_ready_y);
    parameter                      T = 16, X_COUNT = 24, F_COUNT = 10, ADDR_X = $clog2(X_COUNT), ADDR_F = $clog2(F_COUNT);
    input                          clk, reset, s_valid_x, m_ready_y;
    input signed [T-1:0]           s_data_in_x;
    output logic                   s_ready_x, m_valid_y;
    output logic signed [T-1:0]    m_data_out_y;
    logic [ADDR_X-1:0]             addr_x1;
    logic [ADDR_F-1:0]             addr_f;
    logic                          wr_en_x, clear_acc, en_acc, op_done;
    datapath3 d(.clk(clk), .reset(reset), .s_data_in_x(s_data_in_x), .wr_en_x(wr_en_x), .clear_acc(clear_acc), .en_acc(en_acc),
               .m_data_out_y(m_data_out_y), .m_valid_y(m_valid_y), .m_ready_y(m_ready_y), .op_done(op_done), .addr_f(addr_f),
               .addr_x1(addr_x1));
    ctrlpath3 c(.clk(clk), .reset(reset), .s_valid_x(s_valid_x), .m_ready_y(m_ready_y), .wr_en_x(wr_en_x), .clear_acc(clear_acc),
               .en_acc(en_acc), .s_ready_x(s_ready_x), .m_valid_y(m_valid_y), .op_done(op_done), .addr_f(addr_f),
               .addr_x1(addr_x1));
endmodule

module datapath3 (clk, reset, s_data_in_x, wr_en_x, clear_acc, en_acc, m_data_out_y, m_valid_y, m_ready_y, op_done, addr_f,
                 addr_x1);
    parameter                      T = 16, P = 1, X_COUNT = 24, F_COUNT = 10, ADDR_X = $clog2(X_COUNT), ADDR_F = $clog2(F_COUNT);
    input                          clk, reset, wr_en_x, clear_acc, en_acc;
    input signed [T-1:0]           s_data_in_x;
    input [ADDR_X-1:0]             addr_x1;
    input [ADDR_F-1:0]             addr_f;
    logic signed [T-1:0]           m_data_out_y1;
    logic signed [T-1:0]           s_data_out_f, s_data_out_x1;
    output logic signed [T-1:0]    m_data_out_y;
    input logic                    m_valid_y, m_ready_y;
    logic [P:0]                    counter2;
    output logic                   op_done;
    layer3_24_10_16_1_f_rom rom(.clk(clk), .addr(addr_f), .z(s_data_out_f));
    memory3 #(T, X_COUNT, ADDR_X) x_mem1(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x1), .addr(addr_x1), .wr_en(wr_en_x));
    mac3 m1 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x1), .inf(s_data_out_f), .out(m_data_out_y1),
        	.m_valid_y(m_valid_y));

    always_comb begin
        if((m_valid_y == 1) & (m_ready_y == 1)) begin
            if(counter2 == 0) begin
                m_data_out_y = m_data_out_y1;
            end
            else begin
                m_data_out_y = 0;
            end
        end
        else begin
            m_data_out_y = 0;
        end
    end
    assign op_done = (m_valid_y == 1) & (m_ready_y == 1) & (counter2 == P-1); 
    always_ff @(posedge clk) begin
        if (reset == 1) begin
            counter2 <= 0;
        end
        if((m_valid_y == 1) & (m_ready_y == 1)) begin
            counter2 <= counter2 + 1;
        end
        else if((m_valid_y == 0) & (m_ready_y == 1)) begin
            counter2 <= 0;
        end
        else if((m_valid_y == 0) & (m_ready_y == 0)) begin
            counter2 <= 0;
        end
    end
endmodule

module ctrlpath3 (clk, reset, s_valid_x, m_ready_y, wr_en_x, clear_acc, en_acc, s_ready_x, m_valid_y, op_done, addr_f,
                 addr_x1);
    parameter                      T = 16, P = 1, X_COUNT = 24, F_COUNT = 10, ADDR_X = $clog2(X_COUNT), ADDR_F = $clog2(F_COUNT),
	                               OP_COUNT = X_COUNT-F_COUNT+1, COUNTER_V = $clog2(OP_COUNT);
    input logic                    clk, reset, s_valid_x, m_ready_y;
    output logic                   s_ready_x, m_valid_y;
    output logic [ADDR_X-1:0]             addr_x1;
    output logic [ADDR_F-1:0]      addr_f;
    output logic                   wr_en_x, clear_acc, en_acc;
    logic                          wr_done_x, loaded_x; 
    logic [COUNTER_V + 1:0]        counter;
    logic [ADDR_F:0]               counter1;
    input logic                    op_done;
    always_ff @(posedge clk) begin
        if (reset == 1) begin
            s_ready_x <= 1;
            addr_x1<= 0;
            addr_f <= 0;
            counter1 <= 0;
            en_acc <= 0;
            counter <= P;
            wr_done_x <= 0;
            m_valid_y <= 0;
        end
        if (wr_en_x == 1) begin
            addr_x1 <= addr_x1 + 1;
        end
        if (loaded_x == 1) begin
            addr_x1 <= 0;
            addr_f <= 0;
            counter1 <= 0;
            s_ready_x <= 0;
        end
        if ((s_ready_x == 0) & (m_valid_y == 0)) begin
            if (counter < OP_COUNT+1) begin
                if (counter1 == 1) begin
                    en_acc <= 1;
                end
                else if (counter1 == F_COUNT+1) begin
                    en_acc <= 0;
                end
                if (counter1 < F_COUNT+1) begin
                    addr_x1 <= addr_x1 + 1;
                    addr_f <=  addr_f + 1;
                    counter1 <= counter1 + 1;
                end
                else begin
                    m_valid_y <= 1;
                    counter <= counter + P;
                    addr_x1 <= counter + 0;
                    addr_f <= 0;
                    counter1 <= 0;
                end
            end
            else begin
                addr_x1<= 0;
                addr_f <= 0;
                counter1 <= 0;
                s_ready_x <= 1;
                counter <= P;
            end
        end
        if (clear_acc == 1) begin
            m_valid_y <= 0;
        end
    end
    assign wr_en_x = (s_ready_x == 1) & (s_valid_x == 1);
    assign loaded_x = (addr_x1 == X_COUNT-1) & (wr_en_x == 1);
    assign clear_acc = (m_valid_y == 1) & (m_ready_y == 1) & (op_done == 1);

endmodule

module mac3(clk, en_acc, reset, clear_acc, inx, inf, out, m_valid_y);
    parameter                    T = 16, MAX_VAL = ((1<<(T-1))-1), MIN_VAL = (-1*(1<<(T-1)));
    input                        clk, clear_acc, reset;
    input signed [T-1:0]         inx, inf;
    output logic signed[T-1:0]   out;
    logic signed[T:0]            out_temp;
    logic signed[T-1:0]          mul;
    logic signed[2*T-1:0]        mul_temp;
    input                        en_acc;
    input logic                  m_valid_y;

    always_ff @(posedge clk)
    begin
        mul_temp <= inx * inf;
    end

    always_ff @(posedge clk) begin
        if (reset == 1) begin
           out_temp <= 0;
        end
        else if (clear_acc == 1) begin
           out_temp <= 0;
        end
         else if(en_acc == 1) begin
           out_temp <= mul + out;
        end
    end

    always_comb begin
        if(mul_temp>MAX_VAL) begin
            mul = MAX_VAL;
        end
        else if(mul_temp<MIN_VAL) begin
            mul = MIN_VAL;
        end
        else begin
            mul = mul_temp;
        end

        if(m_valid_y == 1) begin
            if(out_temp < 0) begin
                out = 0;
            end
            else if(out_temp>MAX_VAL) begin
                out = MAX_VAL;
            end
            else begin
                out = out_temp;
            end
        end
        else if(out_temp>MAX_VAL) begin
            out = MAX_VAL;
        end
        else if(out_temp<MIN_VAL)begin 
            out = MIN_VAL;
        end
        else begin
            out = out_temp;
        end
    end
endmodule

module memory3(clk, data_in, data_out, addr, wr_en);
    parameter                   WIDTH=16, SIZE=64, LOGSIZE=6;
    input [WIDTH-1:0]           data_in;
    output logic [WIDTH-1:0]    data_out;
    input [LOGSIZE-1:0]         addr;
    input                       clk, wr_en;

    logic [SIZE-1:0][WIDTH-1:0] mem;

    always_ff @(posedge clk) begin
        data_out <= mem[addr];
        if (wr_en)
            mem[addr] <= data_in;
    end
endmodule

module layer3_24_10_16_1_f_rom(clk, addr, z);
   input clk;
   input [3:0] addr;
   output logic signed [15:0] z;
   always_ff @(posedge clk) begin
      case(addr)
        0: z <= 16'd168;
        1: z <= -16'd255;
        2: z <= 16'd139;
        3: z <= 16'd186;
        4: z <= -16'd148;
        5: z <= -16'd162;
        6: z <= -16'd121;
        7: z <= 16'd148;
        8: z <= -16'd109;
        9: z <= 16'd142;
      endcase
   end
endmodule

