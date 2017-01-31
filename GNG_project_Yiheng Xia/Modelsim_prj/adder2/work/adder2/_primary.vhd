library verilog;
use verilog.vl_types.all;
entity adder2 is
    port(
        dataa           : in     vl_logic_vector(17 downto 0);
        datab           : in     vl_logic_vector(20 downto 0);
        sum             : out    vl_logic_vector(21 downto 0)
    );
end adder2;
