--------------------------------------------------------------------------------
-- Filename: complexpack.vhd
-- Purpose : Complex arithmetic package
-- Author  : Nikolaos Kavvadias (C) 2009, 2010, 2011, 2012, 2013, 2014, 2015, 
--                                  2016, 2017
-- Date    : 05-Jun-2017
-- Revision: 0.0.0 (02/10/09)
--           Initial version. Based a code example present in the RASSP series 
--           of VHDL lectures. Compared to the RASSP version, the following have 
--           beed added: conjugate function.
--           0.1.0 (03/03/14)
--           Added get_real, get_imaginary, magnitude, and operators: lt, gt, 
--           le, ge, eq, ne.
--           New library dependency: IEEE.math_real.
--           0.1.1 (04/03/14)
--           Added support for the "abs" and the negation ("-") operators as 
--           those are needed by the complexarrpack package project.
--           0.2.0 (05/06/17)
--           Add polar form, to_polar, to_cartesian, exp, log.
--           Additions based on C implementations from "Basic Algorithms" of 
--           Malcolm McLean.
--
--------------------------------------------------------------------------------

library IEEE;
use IEEE.math_real.all;

package complexpack is
  
  -- A complex number is defined by the pair (real-part, imaginary-part) where 
  -- both items of the pair are numbers. A common algebraic representation for 
  -- complex numbers is:
  --   z = a + i*b, where:
  --   * z is the resulting complex number
  --   * a is the real part of the number also written as a = Re(z)
  --   * b is the imaginary part of the number also written as b = Im(z)
  --   * i is the imaginary unit and has the value of sqrt(-1).
 
  -- re, im specify addresses for an array-based representation of a complex 
  -- number
  constant re : integer := 0;
  constant im : integer := 1;
  
  -- Type definition for a complex number
  type complex is array (natural range re to im) of real;

  -- A complex number in polar form is defined by the pair (radius, angle) 
  -- where both items of the pair are numbers. Polar coordinates express a 
  -- point as a distance (radius or rho) from the origin, followed by a 
  -- rotation (angle equal to theta) around it.
  constant rho   : integer := 0;
  constant theta : integer := 1;
  
  -- Type definition for a complex number in polar form
  type polar is array (natural range rho to theta) of real;
  
  -- Interface for complex arithmetic functionality
  function to_complex (a, b : real) return complex;
  function get_real (a : complex) return real;
  function get_imaginary (a : complex) return real;
  function "+" (a, b : complex) return complex;
  function "-" (a, b : complex) return complex;
  function "-" (a : complex) return complex;
  function "*" (a, b : complex) return complex;
  function "/" (a, b : complex) return complex;
  function conjugate (a : complex) return complex;
  function magnitude (a : complex) return real;
  function "abs" (a : complex) return real;
  function "<"  (a, b : complex) return boolean;  
  function ">"  (a, b : complex) return boolean;  
  function "<=" (a, b : complex) return boolean;  
  function ">=" (a, b : complex) return boolean;  
  function "="  (a, b : complex) return boolean;  
  function "/=" (a, b : complex) return boolean;

  function exp (a : complex) return complex;
  function log (a : complex) return complex;

  function to_polar(a : complex) return polar;
  function to_cartesian(a : polar) return complex;

end complexpack;


package body complexpack is

  function to_complex (a, b : real) return complex is
    variable t : complex;
  begin
    t(re) := a;
    t(im) := b;
    return t;
  end to_complex;

  function get_real (a : complex) return real is
    variable t : real;
  begin
    t := a(re);
	return t;
  end get_real;   

  function get_imaginary (a : complex) return real is
    variable t : real;
  begin
    t := a(im);
	return t;
  end get_imaginary;   
  
  function "+" (a, b : complex) return complex is
    variable t : complex;
  begin
    t(re) := a(re) + b(re);
    t(im) := a(im) + b(im);
    return t;
  end "+";

  function "-" (a, b : complex) return complex is
    variable t : complex;
  begin
    t(re) := a(re) - b(re);
    t(im) := a(im) - b(im);
    return t;
  end "-";

  function "-" (a : complex) return complex is
    variable t : complex;
  begin
    t(re) := - a(re);
    t(im) := - a(im);
    return t;
  end "-";
  
  function "*" (a, b : complex) return complex is
    variable t : complex;
  begin
    t(re) := a(re) * b(re) - a(im) * b(im);
    t(im) := a(re) * b(im) + b(re) * a(im);
    return t;
  end "*";

  function "/" (a, b : complex) return complex is
    variable i : real;
    variable t : complex;
  begin
    t(re) := a(re) * b(re) + a(im) * b(im);
    t(im) := b(re) * a(im) - a(re) * b(im);
    i := b(re)**2 + b(im)**2;
    t(re) := t(re) / i;
    t(im) := t(im) / i;
    return t;
  end "/";

  function conjugate (a : complex) return complex is
    variable t : complex;
  begin
    t(re) := a(re);
    t(im) := -a(im);
    return t;
  end conjugate;
  
  -- Magnitude of a complex number is its distance from the origin.
  -- This function is used by the comparison operators.
  function magnitude (a: complex) return real is
    variable t : real;
  begin
    t := sqrt(a(re)*a(re) + a(im)*a(im));
    return t;
  end magnitude;

  function "abs" (a: complex) return real is
  begin
    return (magnitude(a));
  end "abs";
  
  function "<" (a, b : complex) return boolean is
    variable t : boolean;
  begin
    t := (magnitude(a) < magnitude(b));
    return t;
  end "<";  

  function ">" (a, b : complex) return boolean is
    variable t : boolean;
  begin
    t := (magnitude(a) > magnitude(b));
    return t;
  end ">";  

  function "<=" (a, b : complex) return boolean is
    variable t : boolean;
  begin
    t := (magnitude(a) <= magnitude(b));
    return t;
  end "<=";  

  function ">=" (a, b : complex) return boolean is
    variable t : boolean;
  begin
    t := (magnitude(a) >= magnitude(b));
    return t;
  end ">=";  

  function "=" (a, b : complex) return boolean is
    variable t : boolean;
  begin
    t := (magnitude(a) = magnitude(b));
    return t;
  end "=";  

  function "/=" (a, b : complex) return boolean is
    variable t : boolean;
  begin
    t := (magnitude(a) /= magnitude(b));
    return t;
  end "/=";

  function exp (a : complex) return complex is
    variable t : complex;
    variable exponent : real;
  begin
    exponent := exp(a(re));
    t(re) := exponent * cos(a(im));
    t(im) := exponent * sin(a(im));
    return t;
  end exp;

  function log (a : complex) return complex is
    variable t : complex;
    variable real_part : real;
    variable imag_part : real;
  begin
    real_part := magnitude(a);
    imag_part := arctan(a(im), a(re));
    if (imag_part > MATH_PI) then
      imag_part := imag_part - 2.0 * MATH_PI;
    end if;
    t(re) := log(real_part);
    t(im) := imag_part;
    return t;
  end log;

  function to_polar(a : complex) return polar is
    variable t : polar;
  begin
    t(rho)   := magnitude(a);
    t(theta) := arctan(a(im), a(re));
    return t;
  end to_polar;

  function to_cartesian(a : polar) return complex is
    variable t : complex;
  begin
    t(re) := a(rho) * cos(a(theta));
    t(im) := a(rho) * sin(a(theta));
    return t;
  end to_cartesian;

end complexpack;
