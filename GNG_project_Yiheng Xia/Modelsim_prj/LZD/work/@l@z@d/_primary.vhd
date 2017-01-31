library verilog;
use verilog.vl_types.all;
entity LZD is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        LZDin           : in     vl_logic_vector(60 downto 0);
        LZDout          : out    vl_logic_vector(6 downto 0);
        position        : out    vl_logic_vector(5 downto 0)
    );
end LZD;
