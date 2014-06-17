#GHDL=c:\Elec\Ghdl\Bin\ghdl.exe
GHDL=ghdl
GHDLFLAGS=--ieee=synopsys -fexplicit --workdir=work
GHDLRUNFLAGS=--wave=complexpack.ghw --stop-time=200ns

# Default target : elaborate
all : run

# Elaborate target.  Almost useless
elab : force
	$(GHDL) -c $(GHDLFLAGS) -e complexpack_tb

# Run target
run: force
	$(GHDL) --elab-run $(GHDLFLAGS) complexpack_tb $(GHDLRUNFLAGS)

# Targets to analyze libraries
init: force
	mkdir work
	$(GHDL) -a $(GHDLFLAGS) ../../../rtl/vhdl/complexpack.vhd
	$(GHDL) -a $(GHDLFLAGS) ../../../bench/vhdl/complexpack_tb.vhd

force:

clean :
	rm -rf *.o work
