library verilog;
use verilog.vl_types.all;
entity Mask is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        Maskin          : in     vl_logic_vector(14 downto 0);
        position        : in     vl_logic_vector(6 downto 0);
        Maskout         : out    vl_logic_vector(14 downto 0)
    );
end Mask;
