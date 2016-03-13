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
    variable a, b, c: complex;
	variable t, u: real;
	variable lt, gt, le, ge, eq, ne: boolean;
    variable BufLine: line;
  begin
    a := to_complex(1.0, 2.0);
    b := to_complex(3.0, -5.0);
    wait for CLK_PERIOD;
    -- Test complex addition
    c := a + b;    
    write(Bufline, string'("("));
    write(Bufline, a(re));
    write(Bufline, string'(", "));
    write(Bufline, a(im));
    write(Bufline, string'(") + ("));            
    write(Bufline, b(re));
    write(Bufline, string'(", "));
    write(Bufline, b(im));
    write(Bufline, string'(") = ("));
    write(Bufline, c(re));
    write(Bufline, string'(", "));
    write(Bufline, c(im));
    write(Bufline, string'(")"));
    writeline(ResultsFile, Bufline);
    wait for CLK_PERIOD;
    -- Test complex subtraction
    c := a - b;    
    write(Bufline, string'("("));
    write(Bufline, a(re));
    write(Bufline, string'(", "));
    write(Bufline, a(im));
    write(Bufline, string'(") - ("));            
    write(Bufline, b(re));
    write(Bufline, string'(", "));
    write(Bufline, b(im));
    write(Bufline, string'(") = ("));
    write(Bufline, c(re));
    write(Bufline, string'(", "));
    write(Bufline, c(im));
    write(Bufline, string'(")"));
    writeline(ResultsFile, Bufline);
    wait for CLK_PERIOD;
    -- Test complex multiplication
    c := a * b;    
    write(Bufline, string'("("));
    write(Bufline, a(re));
    write(Bufline, string'(", "));
    write(Bufline, a(im));
    write(Bufline, string'(") * ("));            
    write(Bufline, b(re));
    write(Bufline, string'(", "));
    write(Bufline, b(im));
    write(Bufline, string'(") = ("));
    write(Bufline, c(re));
    write(Bufline, string'(", "));
    write(Bufline, c(im));
    write(Bufline, string'(")"));
    writeline(ResultsFile, Bufline);
    wait for CLK_PERIOD;
    -- Test complex division
    c := a / b;    
    write(Bufline, string'("("));
    write(Bufline, a(re));
    write(Bufline, string'(", "));
    write(Bufline, a(im));
    write(Bufline, string'(") / ("));            
    write(Bufline, b(re));
    write(Bufline, string'(", "));
    write(Bufline, b(im));
    write(Bufline, string'(") = ("));
    write(Bufline, c(re));
    write(Bufline, string'(", "));
    write(Bufline, c(im));
    write(Bufline, string'(")"));
    writeline(ResultsFile, Bufline);
    wait for CLK_PERIOD;
    -- Test conjugate
    c := conjugate(a);
    write(Bufline, string'("conjugate("));
    write(Bufline, a(re));
    write(Bufline, string'(", "));
    write(Bufline, a(im));
    write(Bufline, string'(") = ("));            
    write(Bufline, c(re));
    write(Bufline, string'(", "));
    write(Bufline, c(im));
    write(Bufline, string'(")"));
    writeline(ResultsFile, Bufline);
    wait for CLK_PERIOD;
    -- Test get_real, get_imaginary
    t := get_real(a);
	u := get_imaginary(a);
    write(Bufline, string'("real("));
    write(Bufline, a(re));
    write(Bufline, string'(", "));
    write(Bufline, a(im));
    write(Bufline, string'(") = "));            
    write(Bufline, t);
    write(Bufline, string'(", imaginary("));
    write(Bufline, a(re));
    write(Bufline, string'(", "));
    write(Bufline, a(im));
    write(Bufline, string'(") = "));            
    write(Bufline, u);
    writeline(ResultsFile, Bufline);
    wait for CLK_PERIOD;
    -- Test magnitude
    t := magnitude(a);
	u := magnitude(b);
    write(Bufline, string'("magnitude("));
    write(Bufline, a(re));
    write(Bufline, string'(", "));
    write(Bufline, a(im));
    write(Bufline, string'(") = ("));            
    write(Bufline, t);
    write(Bufline, string'(")"));
    writeline(ResultsFile, Bufline);
    write(Bufline, string'("magnitude("));
    write(Bufline, b(re));
    write(Bufline, string'(", "));
    write(Bufline, b(im));
    write(Bufline, string'(") = ("));            
    write(Bufline, u);
    write(Bufline, string'(")"));
    writeline(ResultsFile, Bufline);
    wait for CLK_PERIOD;	
	-- Test less than
    lt := a < b;    
	gt := a > b;
	le := a <= b;
	ge := a >= b;
	eq := a = b;
	ne := a /= b;
	-- lt
    write(Bufline, string'("("));
    write(Bufline, a(re));
    write(Bufline, string'(", "));
    write(Bufline, a(im));
    write(Bufline, string'(") < ("));            
    write(Bufline, b(re));
    write(Bufline, string'(", "));
    write(Bufline, b(im));
    write(Bufline, string'(") = "));
    write(Bufline, lt);
    writeline(ResultsFile, Bufline);	
	-- gt
    write(Bufline, string'("("));
    write(Bufline, a(re));
    write(Bufline, string'(", "));
    write(Bufline, a(im));
    write(Bufline, string'(") > ("));            
    write(Bufline, b(re));
    write(Bufline, string'(", "));
    write(Bufline, b(im));
    write(Bufline, string'(") = "));
    write(Bufline, gt);
    writeline(ResultsFile, Bufline);	
	-- le
    write(Bufline, string'("("));
    write(Bufline, a(re));
    write(Bufline, string'(", "));
    write(Bufline, a(im));
    write(Bufline, string'(") <= ("));            
    write(Bufline, b(re));
    write(Bufline, string'(", "));
    write(Bufline, b(im));
    write(Bufline, string'(") = "));
    write(Bufline, le);
    writeline(ResultsFile, Bufline);
	-- ge
    write(Bufline, string'("("));
    write(Bufline, a(re));
    write(Bufline, string'(", "));
    write(Bufline, a(im));
    write(Bufline, string'(") >= ("));            
    write(Bufline, b(re));
    write(Bufline, string'(", "));
    write(Bufline, b(im));
    write(Bufline, string'(") = "));
    write(Bufline, ge);
    writeline(ResultsFile, Bufline);	
	-- eq
    write(Bufline, string'("("));
    write(Bufline, a(re));
    write(Bufline, string'(", "));
    write(Bufline, a(im));
    write(Bufline, string'(") = ("));            
    write(Bufline, b(re));
    write(Bufline, string'(", "));
    write(Bufline, b(im));
    write(Bufline, string'(") = "));
    write(Bufline, eq);
    writeline(ResultsFile, Bufline);	
	-- ne
    write(Bufline, string'("("));
    write(Bufline, a(re));
    write(Bufline, string'(", "));
    write(Bufline, a(im));
    write(Bufline, string'(") /= ("));            
    write(Bufline, b(re));
    write(Bufline, string'(", "));
    write(Bufline, b(im));
    write(Bufline, string'(") = "));
    write(Bufline, ne);
    writeline(ResultsFile, Bufline);	
  end process TEST_OPS;
  
end tb_arch;
