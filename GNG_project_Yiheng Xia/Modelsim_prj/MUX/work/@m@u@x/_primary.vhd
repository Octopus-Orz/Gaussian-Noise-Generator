library verilog;
use verilog.vl_types.all;
entity MUX is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        product         : in     vl_logic_vector(15 downto 0);
        sign            : in     vl_logic;
        result          : out    vl_logic_vector(15 downto 0)
    );
end MUX;
