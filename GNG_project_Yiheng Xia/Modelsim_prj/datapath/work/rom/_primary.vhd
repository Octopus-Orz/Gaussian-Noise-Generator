library verilog;
use verilog.vl_types.all;
entity rom is
    port(
        address         : in     vl_logic_vector(6 downto 0);
        read_en         : in     vl_logic;
        Coef2           : out    vl_logic_vector(17 downto 0);
        Coef1           : out    vl_logic_vector(17 downto 0);
        Coef0           : out    vl_logic_vector(20 downto 0)
    );
end rom;
