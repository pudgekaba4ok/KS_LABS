library verilog;
use verilog.vl_types.all;
entity ref_sum is
    port(
        Ain             : in     vl_logic_vector(3 downto 0);
        Bin             : in     vl_logic_vector(3 downto 0);
        Ci              : in     vl_logic;
        Sout            : out    vl_logic_vector(3 downto 0);
        Co              : out    vl_logic
    );
end ref_sum;
