library verilog;
use verilog.vl_types.all;
entity adder1 is
    port(
        dataa           : in     vl_logic_vector(17 downto 0);
        datab           : in     vl_logic_vector(17 downto 0);
        sum             : out    vl_logic_vector(17 downto 0)
    );
end adder1;
