library verilog;
use verilog.vl_types.all;
entity multiplex8_1 is
    port(
        D               : in     vl_logic_vector(7 downto 0);
        S               : in     vl_logic_vector(2 downto 0);
        EN              : in     vl_logic;
        Y               : out    vl_logic
    );
end multiplex8_1;
