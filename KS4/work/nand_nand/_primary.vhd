library verilog;
use verilog.vl_types.all;
entity nand_nand is
    port(
        x1              : in     vl_logic;
        x2              : in     vl_logic;
        x3              : in     vl_logic;
        f               : out    vl_logic
    );
end nand_nand;
