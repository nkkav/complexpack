--------------------------------------------------------------------------------
-- Filename: complexpack_tb.vhd
-- Purpose : Testbench for the complex arithmetic package
-- Author  : Nikolaos Kavvadias (C) 2009, 2010, 2011, 2012, 2013, 2014, 2015, 
--                                  2016
-- Date    : 03-Mar-2014
-- Revision: 0.0.0 (02/10/09)
--           Initial version.
--           0.1.0 (03/03/14)
--           Added tests for new functionalities: get_real, get_imaginary, 
--           magnitude, and operators: lt, gt, le, ge, eq, ne.
--
--------------------------------------------------------------------------------

library STD, IEEE;
use STD.textio.all;
use IEEE.std_logic_1164.all;
use WORK.complexpack.all;


entity complexpack_tb is
end complexpack_tb;


architecture tb_arch of complexpack_tb is
  -------------------------------------------------------
  -- Function definitions
  -------------------------------------------------------
  procedure print_complex (a : in complex; BufLine : inout line) is
  begin
    write(BufLine, string'("("));
    write(BufLine, a(re));
    write(BufLine, string'(", "));
    write(BufLine, a(im));
    write(BufLine, string'(")"));
  end print_complex;
  -------------------------------------------------------
  -- Declare results file
  -------------------------------------------------------
  file ResultsFile: text open write_mode is "complexpack_results.txt";
  -------------------------------------------------------
  -- Constant declarations
  -------------------------------------------------------
  constant CLK_PERIOD : time := 10 ns;
begin

  -- Test the basic operators. 
  TEST_OPS: process
    variable a, b, c, d: complex;
	variable t, u: real;
	variable lt, gt, le, ge, eq, ne: boolean;
    variable BufLine: line;
  begin
    a := to_complex(1.0, 2.0);
    b := to_complex(3.0, -5.0);
    d := to_complex(-1.0, 4.0);
    wait for CLK_PERIOD;
    -- Test complex addition
    c := a + b;    
    print_complex(a, BufLine);
    write(BufLine, string'(" + "));            
    print_complex(b, BufLine);
    write(BufLine, string'(" = "));
    print_complex(c, BufLine);
    writeline(ResultsFile, BufLine);
    wait for CLK_PERIOD;
    -- Test complex subtraction
    c := a - b;    
    print_complex(a, BufLine);
    write(BufLine, string'(" - "));            
    print_complex(b, BufLine);
    write(BufLine, string'(" = "));
    print_complex(c, BufLine);
    writeline(ResultsFile, BufLine);
    wait for CLK_PERIOD;
    -- Test complex multiplication
    c := a * b;    
    print_complex(a, BufLine);
    write(BufLine, string'(" * "));            
    print_complex(b, BufLine);
    write(BufLine, string'(" = "));
    print_complex(c, BufLine);
    writeline(ResultsFile, BufLine);
    wait for CLK_PERIOD;
    -- Test complex division
    c := a / b;    
    print_complex(a, BufLine);
    write(BufLine, string'(" / "));            
    print_complex(b, BufLine);
    write(BufLine, string'(" = "));
    print_complex(c, BufLine);
    writeline(ResultsFile, BufLine);
    wait for CLK_PERIOD;
    -- Test complex multiply-and-accumulate
    c := mac(a, b, d);    
    write(BufLine, string'("mac("));
    print_complex(a, BufLine);
    write(BufLine, string'(", "));            
    print_complex(b, BufLine);
    write(BufLine, string'(", "));            
    print_complex(d, BufLine);
    write(BufLine, string'(") = "));
    print_complex(c, BufLine);
    writeline(ResultsFile, BufLine);
    wait for CLK_PERIOD;
    -- Test reciprocal
    c := reciprocal(a);    
    write(BufLine, string'("reciprocal"));
    print_complex(a, BufLine);
    write(BufLine, string'(" = "));
    print_complex(c, BufLine);
    writeline(ResultsFile, BufLine);
    wait for CLK_PERIOD;
    -- Test conjugate
    c := conjugate(a);
    write(BufLine, string'("conjugate"));
    print_complex(a, BufLine);
    write(BufLine, string'(" = "));
    print_complex(c, BufLine);            
    writeline(ResultsFile, BufLine);
    wait for CLK_PERIOD;
    -- Test get_real, get_imaginary
    t := get_real(a);
    u := get_imaginary(a);
    write(BufLine, string'("real"));
    print_complex(a, BufLine);
    write(BufLine, string'(" = "));        
    write(BufLine, t);
    wait for CLK_PERIOD;
    write(BufLine, string'("imaginary"));
    print_complex(a, BufLine);
    write(BufLine, string'(" = "));    
    write(BufLine, u);
    writeline(ResultsFile, BufLine);
    wait for CLK_PERIOD;
    -- Test magnitude
    t := magnitude(a);
    u := magnitude(b);
    write(BufLine, string'("magnitude"));
    print_complex(a, BufLine);
    write(BufLine, string'(" = "));            
    write(BufLine, t);
    writeline(ResultsFile, BufLine);
    wait for CLK_PERIOD;
    write(BufLine, string'("magnitude"));
    print_complex(b, BufLine);
    write(BufLine, string'(" = "));
    write(BufLine, u);
    writeline(ResultsFile, BufLine);
    wait for CLK_PERIOD;	
    -- Test arg
    t := arg(a);
    write(BufLine, string'("arg"));
    print_complex(a, BufLine);
    write(BufLine, string'(" = "));
    write(BufLine, t);
    writeline(ResultsFile, BufLine);
    wait for CLK_PERIOD;
    -- Test less than
    lt := a < b;    
    gt := a > b;
    le := a <= b;
    ge := a >= b;
    eq := a = b;
    ne := a /= b;
    -- lt
    print_complex(a, BufLine);
    write(BufLine, string'(" < "));            
    print_complex(b, BufLine);
    write(BufLine, string'(" = "));
    write(BufLine, lt);
    writeline(ResultsFile, BufLine);	
    wait for CLK_PERIOD;
    -- gt
    print_complex(a, BufLine);
    write(BufLine, string'(" + "));            
    print_complex(b, BufLine);
    write(BufLine, string'(" = "));
    write(BufLine, gt);
    writeline(ResultsFile, BufLine);	
    wait for CLK_PERIOD;
    -- le
    print_complex(a, BufLine);
    write(BufLine, string'(" <= "));            
    print_complex(b, BufLine);
    write(BufLine, string'(" = "));
    write(BufLine, le);
    writeline(ResultsFile, BufLine);
    wait for CLK_PERIOD;
    -- ge
    print_complex(a, BufLine);
    write(BufLine, string'(" >= "));            
    print_complex(b, BufLine);
    write(BufLine, string'(" = "));
    write(BufLine, ge);
    writeline(ResultsFile, BufLine);	
    wait for CLK_PERIOD;
    -- eq
    print_complex(a, BufLine);
    write(BufLine, string'(" = "));            
    print_complex(b, BufLine);
    write(BufLine, string'(" = "));
    write(BufLine, eq);
    writeline(ResultsFile, BufLine);	
    wait for CLK_PERIOD;
    -- ne
    print_complex(a, BufLine);
    write(BufLine, string'(" /= "));            
    print_complex(b, BufLine);
    write(BufLine, string'(" = "));
    write(BufLine, ne);
    writeline(ResultsFile, BufLine);	
    wait for CLK_PERIOD;
    -- Test exp
    c := exp(a);    
    write(BufLine, string'("exp"));
    print_complex(a, BufLine);
    write(BufLine, string'(" = "));
    print_complex(c, BufLine);
    writeline(ResultsFile, BufLine);
    wait for CLK_PERIOD;
    -- Test log
    c := log(a);    
    write(BufLine, string'("log"));
    print_complex(a, BufLine);
    write(BufLine, string'(" = "));
    print_complex(c, BufLine);
    writeline(ResultsFile, BufLine);
    wait for CLK_PERIOD;
    -- Test pow
    c := pow(a, b);    
    write(BufLine, string'("pow("));
    print_complex(a, BufLine);
    write(BufLine, string'(" , "));            
    print_complex(b, BufLine);
    write(BufLine, string'(") = "));
    print_complex(c, BufLine);
    writeline(ResultsFile, BufLine);
    wait for CLK_PERIOD;
    -- Test sqrt
    c := sqrt(a);    
    write(BufLine, string'("sqrt"));
    print_complex(a, BufLine);
    write(BufLine, string'(" = "));
    print_complex(c, BufLine);
    writeline(ResultsFile, BufLine);
    wait for CLK_PERIOD;
    -- Test sin
    c := sin(a);    
    write(BufLine, string'("sin"));
    print_complex(a, BufLine);
    write(BufLine, string'(" = "));
    print_complex(c, BufLine);
    writeline(ResultsFile, BufLine);
    wait for CLK_PERIOD;
    -- Test cos
    c := cos(a);    
    write(BufLine, string'("cos"));
    print_complex(a, BufLine);
    write(BufLine, string'(" = "));
    print_complex(c, BufLine);
    writeline(ResultsFile, BufLine);
    wait for CLK_PERIOD;
    -- Test tan
    c := tan(a);    
    write(BufLine, string'("tan"));
    print_complex(a, BufLine);
    write(BufLine, string'(" = "));
    print_complex(c, BufLine);
    writeline(ResultsFile, BufLine);
    wait for CLK_PERIOD;
    -- Test arcsin
    c := arcsin(a);    
    write(BufLine, string'("arcsin"));
    print_complex(a, BufLine);
    write(BufLine, string'(" = "));
    print_complex(c, BufLine);
    writeline(ResultsFile, BufLine);
    wait for CLK_PERIOD;
    -- Test arccos
    c := arccos(a);    
    write(BufLine, string'("arccos"));
    print_complex(a, BufLine);
    write(BufLine, string'(" = "));
    print_complex(c, BufLine);
    writeline(ResultsFile, BufLine);
    wait for CLK_PERIOD;
    -- Test arctan
    c := arctan(a);    
    write(BufLine, string'("arctan"));
    print_complex(a, BufLine);
    write(BufLine, string'(" = "));
    print_complex(c, BufLine);
    writeline(ResultsFile, BufLine);
    wait for CLK_PERIOD;
  end process TEST_OPS;
  
end tb_arch;
