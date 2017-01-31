library verilog;
use verilog.vl_types.all;
entity mult1 is
    port(
        dataa           : in     vl_logic_vector(14 downto 0);
        datab           : in     vl_logic_vector(17 downto 0);
        product         : out    vl_logic_vector(17 downto 0)
    );
end mult1;
