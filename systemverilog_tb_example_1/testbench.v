// Top level testbench contains the interface, DUT and test handles which 
// can be used to start test components once the DUT comes out of reset. Or
// the reset can also be a part of the test class in which case all you need
// to do is start the test's run method.
module tb;
  reg clk;
  
  always #10 clk = ~clk;
  reg_if _if (clk);


  reg_ctrl u0 ( .clk (clk),
            .addr (_if.addr),
               .rstn(_if.rstn),
            .sel  (_if.sel),
               .wr (_if.wr),
            .wdata (_if.wdata),
            .rdata (_if.rdata),
            .ready (_if.ready));

  initial begin
    test	  t0;	
    new_test  t1;
    rand_test t2;
    
    clk <= 0;
    _if.rstn <= 0;
    _if.sel <= 0;
    #20 _if.rstn <= 1;

    t0 = new;
    t0.e0.vif = _if;
//    t0.run();
    
    t1 = new;
    t1.e0.vif = _if;
//    t1.run();
    
    t2 = new;
    t2.e0.vif = _if;
    t2.run();
    
    // Once the main stimulus is over, wait for some time
    // until all transactions are finished and then end 
    // simulation. Note that $finish is required because
    // there are components that are running forever in 
    // the background like clk, monitor, driver, etc
    #500 $finish;
  end
  
  // Simulator dependent system tasks that can be used to 
  // dump simulation waves.
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;    
  end
endmodule



/*
Simulation Log:
---------------

ncsim> run
T=20 [Driver] starting ...
T=20 [Monitor] starting ...
T=30 [Driver] waiting for item ...
T=30 [Driver] addr=0xbe wr=1 wdata=0xbc7a rdata=0x0
T=50 [Driver] waiting for item ...
T=50 [Driver] addr=0xa9 wr=1 wdata=0x3d4c rdata=0x0
T=50 [Monitor] addr=0xbe wr=1 wdata=0xbc7a rdata=0x0
T=50 [Scoreboard] addr=0xbe wr=1 wdata=0xbc7a rdata=0x0
T=50 [Scoreboard] Store addr=0xbe wr=0x1 data=0xbc7a
T=70 [Driver] waiting for item ...
T=70 [Driver] addr=0x3e wr=1 wdata=0x27bd rdata=0x0
T=70 [Monitor] addr=0xa9 wr=1 wdata=0x3d4c rdata=0x0
T=70 [Scoreboard] addr=0xa9 wr=1 wdata=0x3d4c rdata=0x0
T=70 [Scoreboard] Store addr=0xa9 wr=0x1 data=0x3d4c
T=90 [Driver] waiting for item ...
T=90 [Driver] addr=0xc5 wr=1 wdata=0x39e0 rdata=0x0
T=90 [Monitor] addr=0x3e wr=1 wdata=0x27bd rdata=0x0
T=90 [Scoreboard] addr=0x3e wr=1 wdata=0x27bd rdata=0x0
T=90 [Scoreboard] Store addr=0x3e wr=0x1 data=0x27bd
T=110 [Driver] waiting for item ...
T=110 [Driver] addr=0x57 wr=0 wdata=0xfc0c rdata=0x0
T=110 [Monitor] addr=0xc5 wr=1 wdata=0x39e0 rdata=0x0
T=110 [Scoreboard] addr=0xc5 wr=1 wdata=0x39e0 rdata=0x0
T=110 [Scoreboard] Store addr=0xc5 wr=0x1 data=0x39e0
T=130 [Driver] waiting for item ...
T=130 [Driver] addr=0xb3 wr=0 wdata=0x7ba rdata=0x0
T=150 [Driver] wait until ready is high
T=150 [Monitor] addr=0x57 wr=0 wdata=0xfc0c rdata=0x1234
T=150 [Scoreboard] addr=0x57 wr=0 wdata=0xfc0c rdata=0x1234
T=150 [Scoreboard] PASS! First time read, addr=0x57 exp=1234 act=0x1234
T=170 [Driver] waiting for item ...
T=170 [Driver] addr=0xb8 wr=0 wdata=0xefb1 rdata=0x0
T=190 [Driver] wait until ready is high
T=190 [Monitor] addr=0xb3 wr=0 wdata=0x7ba rdata=0x1234
T=190 [Scoreboard] addr=0xb3 wr=0 wdata=0x7ba rdata=0x1234
T=190 [Scoreboard] PASS! First time read, addr=0xb3 exp=1234 act=0x1234
T=210 [Driver] waiting for item ...
T=210 [Driver] addr=0xea wr=0 wdata=0xf40d rdata=0x0
T=230 [Driver] wait until ready is high
T=230 [Monitor] addr=0xb8 wr=0 wdata=0xefb1 rdata=0x1234
T=230 [Scoreboard] addr=0xb8 wr=0 wdata=0xefb1 rdata=0x1234
T=230 [Scoreboard] PASS! First time read, addr=0xb8 exp=1234 act=0x1234
T=250 [Driver] waiting for item ...
T=250 [Driver] addr=0x99 wr=1 wdata=0x6ee6 rdata=0x0
T=270 [Driver] wait until ready is high
T=270 [Monitor] addr=0xea wr=0 wdata=0xf40d rdata=0x1234
T=270 [Scoreboard] addr=0xea wr=0 wdata=0xf40d rdata=0x1234
T=270 [Scoreboard] PASS! First time read, addr=0xea exp=1234 act=0x1234
T=290 [Driver] waiting for item ...
T=290 [Driver] addr=0x53 wr=0 wdata=0x73ce rdata=0x0
T=290 [Monitor] addr=0x99 wr=1 wdata=0x6ee6 rdata=0x0
T=290 [Scoreboard] addr=0x99 wr=1 wdata=0x6ee6 rdata=0x0
T=290 [Scoreboard] Store addr=0x99 wr=0x1 data=0x6ee6
T=310 [Driver] waiting for item ...
T=310 [Driver] addr=0x4a wr=0 wdata=0xb99a rdata=0x0
T=330 [Driver] wait until ready is high
T=330 [Monitor] addr=0x53 wr=0 wdata=0x73ce rdata=0x1234
T=330 [Scoreboard] addr=0x53 wr=0 wdata=0x73ce rdata=0x1234
T=330 [Scoreboard] PASS! First time read, addr=0x53 exp=1234 act=0x1234
T=350 [Driver] waiting for item ...
T=350 [Driver] addr=0xbb wr=1 wdata=0x85f6 rdata=0x0
T=370 [Driver] wait until ready is high
T=370 [Monitor] addr=0x4a wr=0 wdata=0xb99a rdata=0x1234
T=370 [Scoreboard] addr=0x4a wr=0 wdata=0xb99a rdata=0x1234
T=370 [Scoreboard] PASS! First time read, addr=0x4a exp=1234 act=0x1234
T=390 [Driver] waiting for item ...
T=390 [Driver] addr=0x41 wr=1 wdata=0xa426 rdata=0x0
T=390 [Monitor] addr=0xbb wr=1 wdata=0x85f6 rdata=0x0
T=390 [Scoreboard] addr=0xbb wr=1 wdata=0x85f6 rdata=0x0
T=390 [Scoreboard] Store addr=0xbb wr=0x1 data=0x85f6
T=410 [Driver] waiting for item ...
T=410 [Driver] addr=0xb6 wr=1 wdata=0xe267 rdata=0x0
T=410 [Monitor] addr=0x41 wr=1 wdata=0xa426 rdata=0x0
T=410 [Scoreboard] addr=0x41 wr=1 wdata=0xa426 rdata=0x0
T=410 [Scoreboard] Store addr=0x41 wr=0x1 data=0xa426
T=430 [Driver] waiting for item ...
T=430 [Driver] addr=0x60 wr=1 wdata=0xb9e8 rdata=0x0
T=430 [Monitor] addr=0xb6 wr=1 wdata=0xe267 rdata=0x0
T=430 [Scoreboard] addr=0xb6 wr=1 wdata=0xe267 rdata=0x0
T=430 [Scoreboard] Store addr=0xb6 wr=0x1 data=0xe267
T=450 [Driver] waiting for item ...
T=450 [Driver] addr=0x20 wr=1 wdata=0x6ef7 rdata=0x0
T=450 [Monitor] addr=0x60 wr=1 wdata=0xb9e8 rdata=0x0
T=450 [Scoreboard] addr=0x60 wr=1 wdata=0xb9e8 rdata=0x0
T=450 [Scoreboard] Store addr=0x60 wr=0x1 data=0xb9e8
T=470 [Driver] waiting for item ...
T=470 [Driver] addr=0xe0 wr=1 wdata=0x134f rdata=0x0
T=470 [Monitor] addr=0x20 wr=1 wdata=0x6ef7 rdata=0x0
T=470 [Scoreboard] addr=0x20 wr=1 wdata=0x6ef7 rdata=0x0
T=470 [Scoreboard] Store addr=0x20 wr=0x1 data=0x6ef7
T=490 [Driver] waiting for item ...
T=490 [Driver] addr=0x37 wr=0 wdata=0xd00d rdata=0x0
T=490 [Monitor] addr=0xe0 wr=1 wdata=0x134f rdata=0x0
T=490 [Scoreboard] addr=0xe0 wr=1 wdata=0x134f rdata=0x0
T=490 [Scoreboard] Store addr=0xe0 wr=0x1 data=0x134f
T=510 [Driver] waiting for item ...
T=510 [Driver] addr=0x29 wr=0 wdata=0x6496 rdata=0x0
Simulation complete via $finish(1) at time 520 NS + 0
./testbench.sv:363     #500 $finish;
ncsim> exit
*/
