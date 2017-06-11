GHDL=ghdl
GHDLFLAGS=--ieee=standard -fexplicit --workdir=work
GHDLRUNFLAGS=--wave=complexpack.ghw --stop-time=370ns
#GHDLRUNFLAGS=--vcd=complexpack.vcd --stop-time=370ns

# Default target : run
all : run

# Run target
run: init
	$(GHDL) --elab-run $(GHDLFLAGS) complexpack_tb $(GHDLRUNFLAGS)

# Targets to analyze libraries
init:
	mkdir -p work
	$(GHDL) -a $(GHDLFLAGS) ../../../rtl/vhdl/complexpack.vhd
	$(GHDL) -a $(GHDLFLAGS) ../../../bench/vhdl/complexpack_tb.vhd

clean :
	rm -rf *.o work
