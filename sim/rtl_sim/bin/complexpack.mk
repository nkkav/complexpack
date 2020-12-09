GHDL=ghdl
GHDLFLAGS=--ieee=standard -fexplicit --workdir=work
GHDLRUNFLAGS=--stop-time=290ns

# Default target : run
all : run

# Run target
run: init
	$(GHDL) --elab-run $(GHDLFLAGS) complexpack_tb $(GHDLRUNFLAGS)

# Target to analyze libraries
init:
	mkdir -p work
	$(GHDL) -a $(GHDLFLAGS) ../../../rtl/vhdl/complexpack.vhd
	$(GHDL) -a $(GHDLFLAGS) ../../../bench/vhdl/complexpack_tb.vhd

clean :
	rm -rf *.o work
